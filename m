Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F68CEC875B
	for <git@archiver.kernel.org>; Thu,  7 Sep 2023 20:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234631AbjIGUVO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Sep 2023 16:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237066AbjIGUVL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2023 16:21:11 -0400
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15D51BD3
        for <git@vger.kernel.org>; Thu,  7 Sep 2023 13:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1694118049; x=1694722849; i=l.s.r@web.de;
 bh=0olzgIRRTg+v0zTmgWEnHVzNo9Ou+ahxXRd+9L/EhP8=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=eBZnkikcFPdJL8Igv0WO3hec1TtArR3tNpusVIM2Z6JuCGnBXLfACIxIrF1Z/3nfDybouq+
 QMqJnQQ0Pn7e8tlxsgYbXIBP6XCEeXfv4De7+zaF1FuXV1TGTqWPA7xjRVcwimbz9QJaVuo+o
 0gksoKrU140ijt4zQt1TOlDnbpuqQWJmZj8xZxeQEHT5CyDBM9CgyomB5Tvt2WZVAsTyMRKGc
 9veDDaMLmRCx+EmzHUjtyq1JZPX/bXF0TXSgDtEwLo62mov2M7hQTMtGL9kSoiOJwjdcL1SgL
 mS/93diu0uDaE0Krlx4AyYNWvPogKwnpfZzFI9yEqlckRRJ7OYcw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.151.74]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Ma0Pm-1qAfYb2gr6-00WJZk; Thu, 07
 Sep 2023 22:20:49 +0200
Message-ID: <e4cec1b9-fb9e-3b12-355f-d4375f2da161@web.de>
Date:   Thu, 7 Sep 2023 22:20:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH] name-rev: use OPT_HIDDEN_BOOL for --peel-tag
Content-Language: en-US
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>
References: <5a86c8f8-fcdc-fee9-8af5-aa5ecb036d2e@web.de>
 <20230905071719.GF199565@coredump.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20230905071719.GF199565@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:o3+3oz+E0+sZOsHR5thO01gfUvsPB6Q5TCNYfjbIQAgZmgXqmYD
 DFmmqivOFOIr+mnXQHDetvjfwTWnlTc7zWjXkm4UVyTcHv7ukmaKID2JMJS87Ky7W7NC8fa
 6cOKfjcbq2T4FJoZcFAnJeQwPSSxF1x9+DygMNh4fDghhTzweTLmsuiBGuVDT3x7SDmFPbq
 JTrDMWXEjtNdmkTVbpiVQ==
UI-OutboundReport: notjunk:1;M01:P0:fWZmOjqZjmQ=;wNmIPNBh9/rp1ngWF7CbphrAURu
 Db+jdfuYHe3dH/DIvV3lKw25vr3TTebkxDHVlPDTtoxIXRsMW1PkANHlts2FW40niGEjSJMtl
 S2XBGpj3RE22LNXF+oqoC42Tj9D9hUyFbaBsWZnQRKqjUe3h/qSaKasIqXJ7n/nBFba2VWveW
 c4iVLPQdlLY0XJEcWrAr0X/3A4pHY6rZ8FTb5ahAEDq2pmpJbBXLevWadqcmklCzH1P9O5NrT
 tkr3KUMbczf2qftD/+ur856lxGO+xvQoiPAIaEKTMNvGCmklb2SSu2CSdPUmabftCIEXh3c1c
 e+FiS8cYad8Y1tEGyUJUbkDPrMJhJtTFoa3n+NCBvvZ3CHZ/RQUjxqqLg69o0PN1zMn1G50IW
 69KdrMIfkOMs46mJBQL1knMf1Mk/glUAT1C7I0+PLOoCV3Mrp2a3qwuEU3ZEscN5c0APX9oa8
 2ub7GOzRF9xAGxQ/WddEUwVU1RswICSgd2uRwOR7NzzAFvppRtUvVG7Ou4e+koOTwDdb5iBMB
 95cwqmwH7vUTQkGPVaeQ9KVoPNiLMh1jx2Y42JQiYiLpbM0wY1byZ6+82LAJi3hQffliGTL4/
 Zu/Wv3yO3/WZxueKO8VnoFM5fHlpBEw0+UKyMP88kkMKfAja4dzj4FDTajcARkBlfL/ACiHjB
 Tbq9qkU+KuQ+hPXR2O8z3RrRYGj0hiQbS9ryog1RILq0xCjWNsolOoc3XSSgRYcbjp24U5Cky
 pZ5ILzc5om5oeHF5d7OQ8w3ebSSoS3uiwrojtHB8HHpQRNYC+Bk9TaYg9u0HxFVKIWubQU4JE
 4JtsGdeQYuE47FCA2XWeq4Pkpy82O9hbHky90IcB3j7QJ+XM7UAFRdCtpoAPyxkN3yIVqRv7Q
 yW0c/v1XDPHl6k/hpTOZIB5kxpv5xu2d9kNg+BEkRFTYm8m18S2H6/h39yE8j0bUdohLewwBj
 /urC6Q==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.09.23 um 09:17 schrieb Jeff King:
> On Sat, Sep 02, 2023 at 08:38:34PM +0200, Ren=C3=A9 Scharfe wrote:
>
> OPT_HIDDEN_BOOL() itself is a little funny to me. I guess back then we
> did not have the "_F" variants, but really it is just:
>
>   OPT_BOOL_F(0, "peel-tag", &peel_tag,
> 	     N_("dereference tags in the input (internal use)")),
> 	     PARSE_OPT_HIDDEN);
>
> which would remove one more special case (after all, being hidden is
> orthogonal to the type).

Good point!

> But there are enough of them that maybe having
> a special name for this is worth it. I dunno.

A special case just for a flag feels wasteful.  _F is more general at a
reasonable price of some verbosity:

	OPT_HIDDEN_BOOL(s, l, v, h),
	OPT_BOOL_F(s, l, v, h, PARSE_OPT_HIDDEN),

Hindsight..

> But we could probably simplify the definition, at least. :)

Sure, that would be some kind of consolation price.

Ren=C3=A9

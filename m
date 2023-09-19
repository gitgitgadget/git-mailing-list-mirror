Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C690CD548C
	for <git@archiver.kernel.org>; Tue, 19 Sep 2023 07:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbjISHm1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Sep 2023 03:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbjISHm0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2023 03:42:26 -0400
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933C2FC
        for <git@vger.kernel.org>; Tue, 19 Sep 2023 00:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
 t=1695109322; x=1695714122; i=l.s.r@web.de;
 bh=pKajNw8cdR3VA1DzMSwv5g4xd2okvDzRkHkMtIfvmro=;
 h=X-UI-Sender-Class:Date:From:Subject:To:Cc:References:In-Reply-To;
 b=YE3QcXschAOhDNbmIP1wqQ4GJQ+np0uj6MoBg55HujSLQJA1SuUta4E9urRJb/1ssiKhbpv8Avm
 L3PWBlO+QqvQwiala6b7o5bPg/Q6SyXaPBSSzuEzh+BRt0QlvISUZOy2Vdu/tN2/Fo6tCVaKJpckI
 PtQDmHPkIEJc5SR+NJ6qEW64yJ2woY4DT7hWbZL0yOnHY1ALWjDWn6Bbkb90Mvs0oO02d7Jz9megM
 h1zNJcjduB0yeaIj94WY42YiZSIxSHegaxYtVyiF7uCE7P50xIrTUvrKIEu+nmkO0+arJblfoSJAW
 Hg80Xbtm41StemCbYvuAZ81wlLj2KFsJwyCQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.147.159]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N3ouq-1riCfx3zfM-00zf2N; Tue, 19
 Sep 2023 09:42:01 +0200
Message-ID: <3c3960cf-155c-4129-913e-31db45671eef@web.de>
Date:   Tue, 19 Sep 2023 09:42:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH v2 06/10] parse-options: mark unused "opt" parameter in
 callbacks
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <20230831211637.GA949188@coredump.intra.peff.net>
 <20230831212128.GF949469@coredump.intra.peff.net>
 <98d1cd21-fb2a-269a-8d0b-f3e050682739@web.de>
 <20230905070512.GC199565@coredump.intra.peff.net>
Content-Language: en-US
In-Reply-To: <20230905070512.GC199565@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jvWjUuvwbrwZZLjIgBSYN6wimnFFNfzBBZptieODwjllayQaBD2
 pcO3vctNsdMZhZuvgXRo6mbG7Au0NuzKxne1wSHKFv6we4Mqzvk1fXlgZTwAy/JWfUY8vL+
 /BkOlhqubH44bU0o1ZS+UUCkte9BNgRsKSaCvq3ozKkDTtceXqwNboAQl8HwKqDETPlie4w
 LmvHfrxaquXqTxvwrLgzg==
UI-OutboundReport: notjunk:1;M01:P0:1bGGXNW5mbc=;m6HMwaarNcIGbCzeyCaqnc9sK2I
 H4BrKuHVUx0S+K3XB+QrZcY42KT188I0lA69abda2B0x+r14Hzp6F/fcQbmysnE5R2H9JPGgf
 UUrrdvkd9F2XwxBnb6szT1fI+tgyLvkjVM52lT2wwgTYj1Sx1iHRcPVcFovlJTD8zzxWyiUOf
 lnSTh4zJtZ+AgKTdwust/L79CtE2+uHXIIQYPyDAG6PclhKyYKrp968EYWMCkTHTGMDJ7rSs1
 euTWk/K7WGvqDGdiXywWM4DXQjuFKL8ru4qcnRcRjot+ucWONsQh+quASeQ3dgC/t8Xb+mxgQ
 Gv+7uBPX1VEtr7FiceOeCDMH5g4qagxLBbzTUKq7qjLnRqBhGemzkMo69UeAAUe2zfzKQ1SnK
 Kbmqf1rOCQBVQ5Lujjoxe2AX5wkratM4L81sxV/1e2EAZIQpKtUCeTcO/IpBH3pWPzfK5A6nk
 7I+sa1eLLJApHXFimbiJSvxHWVynOyHW3JusQfLgeesuPr6IDr7wQZCgXdaT3pJVjNZdkTIPI
 moLjLFhVrLscz7QH3HHCS0MtEGuaEJ12/uJPeNjqm9xURDaxkq3gjtn7aSdWk3FPpBAuHYwl2
 n8iwXU4tqQKtMyIq9SHXKcGOL9FPCIczreFnhQaIIlU+pDxpxRTTCCKt6ZmAeCABw9UQKnzRp
 509SxCp5LIGSew89E6vpHYKW7IXs/nZe0spXAGYFeiKxnDHjtqkztnHOXbaTpf7Nxh7nh3ffD
 g3IJ4sKc07m67ojsACPudl6L3Mje6L33o0U+50l8vTeeVM71yyDL86dLOlJWCNjkrTpPS8Mlu
 h/RMsrxA46tINMYfEf367efkfZs4PDjU2cBGJElW003asIW8t1ARYgmPzMCD3EEcnOS1YXiX2
 9cGvTLd43U7OzNKKokto6kKw2uNTBTxcNCsaPyYrx0N6c/z9hDBtN+PiPmW0eKFLKTS3qHgtL
 nlKB7Q==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.09.23 um 09:05 schrieb Jeff King:
> On Sat, Sep 02, 2023 at 12:12:56PM +0200, Ren=C3=A9 Scharfe wrote:
>
>> And I don't understand why the callback returns 1 (PARSE_OPT_NON_OPTION=
)
>> on error, but that's a different matter.
>
> Yeah, that doesn't make sense at all.

Actually it does: any non-zero return from a callback is interpreted as an
error.  "return error(...);" would be shorter, but "error(...); return 1;"
is not wrong.  Sorry for the noise!

Ren=C3=A9

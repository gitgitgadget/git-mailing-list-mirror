Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62BB4C0015E
	for <git@archiver.kernel.org>; Fri, 21 Jul 2023 16:43:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjGUQnb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jul 2023 12:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjGUQnZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2023 12:43:25 -0400
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9D62D46
        for <git@vger.kernel.org>; Fri, 21 Jul 2023 09:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1689957792; x=1690562592; i=l.s.r@web.de;
 bh=wNlSXIl98uYL+ydn/VTBDYyDWtwYfe2sl4GFtw8ERNw=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=wVH6w55EsOgmWX+ijB71rDCsTjo0lykl1dOY5xKdjEeHepoqu078fTfQP876Ja+6pv5tqi+
 BY7Ogh8G5gJ27xJTDEewhim+blw7WGOauHVk5QrXfAXf8zy+pfRZLweCVW1SN1aqNtXsNEjYS
 f2wONybU6SPyyvSOJ/CVV1GN8Fwy4zfGtUBM6fBcwlddCfpPgjN4jmNaFo9PYYNNFvddvvJ+U
 eMGmNLaxPKojq0RfsVDlZ5ObXpvu3G2jE7QFqWdraKMi4FwBzRyTUhqp7E7/tD/ZsSlaJwZ9Q
 Vi8XH4q+C2UleLfNRkRnnJaLbtZKDXmCLlTcw/k/RcPvQHcCxKJQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.150.179]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MwjK2-1py3g946KA-00yNur; Fri, 21
 Jul 2023 18:30:36 +0200
Message-ID: <b4912737-4ee1-11a5-847e-39c8eb2967d0@web.de>
Date:   Fri, 21 Jul 2023 18:30:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH] show-branch: fix --no-sparse
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
References: <d392a005-4eba-7cc7-9554-cdb8dc53975e@web.de>
 <xmqqo7k9fa5x.fsf@gitster.g> <3f590f19-11a2-36d7-2520-1d1625ca1a25@web.de>
 <xmqqwmytxr59.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqwmytxr59.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VKwyqSVF0f8Fx8+Od3CIZ9S/tT7CjEsC+OkLWBfJrqC2T3fX2o3
 3W842u91HVyLDxSALlUu8YoxABMh168mXzcXHgBsT5ZHcms6Loynjqu764jfAUSTmsAj62K
 ngXV8NwLWdJxuaYcgoGzojLaGXUD3kOHW4FB3ccBWSMThwPT85aLtu5ud88emwFOINfUMyq
 Uzio+sQVmzqMzaf4CLb2Q==
UI-OutboundReport: notjunk:1;M01:P0:jjfuKo7mi1Q=;G0RhjNHIaN5tKMbwxSd7n1Trifo
 ix9cjvDr6TeWfDStFH4v0Uu7ZII8jiZqBaR1RD+IcU1Vj/BKbcqk7IkRXO6GlUTRFPBDD3LrU
 IVljOui+xOndDC07ui/YaHQWRW76Z4Ny6zmRnPWSPQh4N4A42mEOX1xTlswjc8qOz+CX7EnfX
 Eny2xC7MEw/vjeH22xKn+V5VRL33Jlmiz618wIf022tDwMuJ0ubBA/cQhAjdzZkvcUMnnuXuo
 VQSTKURAeKzWdM01PnB95WjMhV1r/2C9D23aQTlWko1DjbqOhFUWJJq3HTy1Ndhb2v7diUdIr
 ygEuAvbFigYq5Ct3A8y5v0ihlHQzTXKlWaCrP53abFWk8evERnyPemeaLNbc+lWCzJNBUfY5O
 Gb4rJUVJ1oG/mXyOrhUOkTpPiS3ZEwFDzrI0T5aTSC9LCTXY7qAIGiA9S0bnywh1xhyeVqX0z
 3lt+SfRXnQEZAi2YwTYZjO0ezd6qOc/abfWLiIcl8O7b6Z+C2O3xEqPWR51cFV52dk+MnxnP6
 2t/VOHX3kx3i6xVSzEyyOo+g+aCpGHY5bCGotP55azUzFBqfUkt0pMyOkeXCwpQLSvGbUERBA
 PVJbdIW/6kgWt73Ihycxw64/FzebWvTMLfz1+AkNO9PP98dFs5XZBsg47eagBDW/0/EJVcFhf
 rIwOP5DJ35hu/def2HJzjGBBGeUP7t9mgxzTP+aSSD6NacCe7hH+davLRztSlBWqM5uORzKGU
 88wGdJRHtVFllGBZ3ujP8VLrFDlUdNsPoD1ZzJDn8L5Zjrs+QcHich9ZXuFByUAzkhbiw5Yun
 7R36E7L+zRzrNHlTlng9Rl3B0mBMN7A8PtFYEUfByDt7hOVmwIChka6gfWJYjAGLvT+TiV5FD
 kgrGHsTyuxHvBQtOyGsq0g//7FDPE2jcG7BpfxW5QSzHIo4kal9dl1EXcLKl8WblHtFE/afc1
 ETFMwQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 21.07.23 um 16:42 schrieb Junio C Hamano:
>
> Hmph, am I expected to compare these patches with what I sent a few
> days ago and pick whichever are the better ones?  Can I delegate
> that task to somebody else ;-)?
>
>         jc/am-parseopt-fix		<xmqqr0p5gjv3.fsf@gitster.g>
>         jc/branch-parseopt-fix		<xmqqjzuxgjmi.fsf@gitster.g>
>         jc/describe-parseopt-fix	<xmqqy1jcgbiv.fsf@gitster.g>
>         jc/parse-options-reset		<xmqq1qh4c998.fsf@gitster.g>
>         jc/parse-options-short-help	<xmqq5y6gg8fn.fsf@gitster.g>
>         jc/parse-options-show-branch	<xmqqh6pzc15n.fsf@gitster.g>
>         jc/transport-parseopt-fix	<xmqqedl4gag8.fsf@gitster.g>

Aww, didn't see them.

Most differences are cosmetic, but in git describe you use two
OPT_SET_INT_F for the two OPT_SET_INT_Fs for --exact-match and
=2D-no-exact-match.  The callback I chose is a little uglier on the
inside, but prettier on the outside -- occupies a single line in short
help.  Reminds me of the --[no-]keep-cr simplification in git am.

And you don't seem to have touched pack-objects; please check those two
patches of mine.

Ren=C3=A9

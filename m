Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E987DC433C1
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 18:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 923A461993
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 18:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbhCVSFq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Mar 2021 14:05:46 -0400
Received: from mout.web.de ([217.72.192.78]:56499 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230423AbhCVSFW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Mar 2021 14:05:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1616436314;
        bh=JWzfP3/HUQO4pyBWdENBksNdiD3Oo85Cj0LVRGIEbKg=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ZFNPgH1wnLSitkjKUsvAWQjc+uk2/5ZXZX8wymbMiTOtOg9vaSlVo2Ml6HcdmOTso
         mECmk5n4lPgM7sz7yL92YkzGtZolhQTiuIVzsh83HbDTAA/vj8BEkKF3+Nq3Jc/qWy
         QeD5ofVFCvrj9KPICp9fY6iUeZXhGeM5dXlUxVWc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.22.17]) by smtp.web.de
 (mrweb106 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1MovnY-1m1JmW0cD0-00qKD2; Mon, 22 Mar 2021 19:05:14 +0100
Subject: Re: [PATCH v4 4/4] Makefile/coccicheck: set SPATCH_BATCH_SIZE to 8
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Eric Wong <e@80x24.org>
References: <20210306192525.15197-1-avarab@gmail.com>
 <cover.1616414951.git.avarab@gmail.com>
 <51b782bb9b6270a0b1f69df8fe9e2e4f5aead2a2.1616414951.git.avarab@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe=2e?= <l.s.r@web.de>
Message-ID: <9b1a8473-9117-abcd-497f-d217fa03813e@web.de>
Date:   Mon, 22 Mar 2021 19:05:12 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <51b782bb9b6270a0b1f69df8fe9e2e4f5aead2a2.1616414951.git.avarab@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4F5BTuReHHCBm++Cnfwkudb9qVYORzioQpDCUrsebRO7vTIk9H/
 NOPidkLU+NCDWlcPgby5kwUjsiS2IhUOF0TgTegYhxRk7oX5h46E/pYynwkrnexGzokL5FK
 Vv9MOOQVYycF15Q5qDgnayiXgqr0G46HlI7x9aMV36BzZXRdGlJ/tPOWh/vR1FVn+p5gzgr
 PlypsiUZfPxFkawjIp4fg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ydWaF9IAv5E=:Vc7dTOiUMWFaZfo7XxzJ/0
 DM+yhZK9b9xTC60SjAnZEhpYbNEn4ApYtfmM7mXaYsr9QGIN3JinQE+fTRjuPqrcnkXAUyk9o
 iF/VOSy9Iqm+yshNzgwIXj225wR0PuR4oiSYwydZDeCMO9vlZFQESoTsKajconM5wQKyycAIi
 f2qgQE8Gvv7Y9gQVLO9L+TrXJb0rpkQi70isd8IgWhsAQB4RQ5724rU10R+bSuB2ZZ5cL+Nrx
 jX+Oi5t1V9GchIJnB2BsrsYPIUxGGyT1mOUXLSk0FGmkBE/tmTwxbfo/zJZTTJRy3gPGrQIqY
 O8a/YZZaIYoVkRfbjKRv8p8bt012sesUiF9uzVMeT+4kmngTf0Nte1S42SZI1kujJNh74RKaX
 eIv5kX+vp2wiZTnftY5rYQBbnQIKVlRUNoQKyYAbH08Tlj/pprKpmd4wlt/+weS1oF/IM4234
 N0dGUoED5wTP4kqsG4MzoHyoKDYTVsMUlblxNXUoMKDUMN+mWBbVzWvTdI/vi67NtCSg3PAye
 Zgp07RWWdYyV2Tni2tVuy6aVMa/j6cfQt6hDvN/Xo+XIDywPPdRffE/2/WmdvhbJXSC+EiKhT
 PLEhAZoyqRTlR1l52QW9fTEyOpIlVwPhMvAdGmxz2suN7Vq/3EqHA2f++mt7AWwb1+du4tI6E
 Zh8ocW3cdp4hcctbjL5KS+H65dCxROIEF52EO4EYz28ne+ediZmLgpBP9z6M/55SHDhJJK7z1
 1uydB3pssQMUXM8L7veUXUgYSjCu5VbyKIEKkZ0ZRXprPB9D6mhDuaVp6Q8venJ7mdTSrwJZc
 bHdya6/RYYqqPOlxkB7jQbcY8divRfdy7ouE18BnihH1wmnPm1D5fMwCJgmIp0p0KqCvuA9+5
 /5T9yTKNa22cQx/BtJ5g==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 22.03.21 um 13:11 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> Change the "xargs -n X" limit for running spatch from 1 to 8, as
> suggested by Jeff King[1]. Now that we're not using --all-includes
> anymore this is going to take much less memory, so bumping the limit
> should be OK.

But --all-includes is still used, so does this patch still make sense?

>
> 1. https://lore.kernel.org/git/YEIGzXMDax83cwAx@coredump.intra.peff.net/
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index eaac14275bb..543fe472482 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1204,7 +1204,7 @@ SPATCH_FLAGS =3D --all-includes --include-headers-=
for-types --patch .
>  # For the 'coccicheck' target; setting SPATCH_BATCH_SIZE higher will
>  # usually result in less CPU usage at the cost of higher peak memory.
>  # Setting it to 0 will feed all files in a single spatch invocation.
> -SPATCH_BATCH_SIZE =3D 1
> +SPATCH_BATCH_SIZE =3D 8
>
>  # For the 'coccicheck' target; SPATCH_XARGS can be used to manually
>  # tweak the xargs invocation. By default we invoke "xargs -n 1", and
>

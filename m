Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68486C00140
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 09:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbiHJJUm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 05:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbiHJJUc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 05:20:32 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B075D0F2
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 02:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660123228;
        bh=59aho4Xp2GB/SeGf8UQ5YWgMc0UtEtV6300+5rW5VE0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=LeEbiNOCpVCBQTRh6/3PfUK+3C81Fcmr4nADH8ztDCgb9G9wpx3jXqdFWZopM83Py
         yttlFvEn8OKABPeHTVn97PVUn+IBptukO7gAGHwEk93XgsuUZAXqDmn0rC+U9gwJ5K
         gRr9HVK5PMVYZcPecMklgneEtGY4xQ6lZo3dIe0k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.204.74] ([89.1.214.151]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MMXQF-1o4Jzg3b7P-00Jddv; Wed, 10
 Aug 2022 11:20:27 +0200
Date:   Wed, 10 Aug 2022 11:20:29 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
cc:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v5 3/6] pack-bitmap-write: learn pack.writeBitmapLookupTable
 and add tests
In-Reply-To: <68r08n47-9o07-351s-710q-786q69429q86@tzk.qr>
Message-ID: <4rs1s351-73np-4sq8-p6o8-r7178rp0p0n0@tzk.qr>
References: <pull.1266.v4.git.1658325913.gitgitgadget@gmail.com> <pull.1266.v5.git.1658342304.gitgitgadget@gmail.com> <59b465e5a7817c145172f25e73ad807c7ba67e84.1658342304.git.gitgitgadget@gmail.com> <p3r70610-8n52-s8q0-n641-onp4ps01330n@tzk.qr>
 <CAPOJW5xBUaAJtOvrefwbXv_WDTLa=6PTL5kEoOpRQfqqFAx3oA@mail.gmail.com> <6s4n3600-q5p7-92sr-4206-non3s8rr3n46@tzk.qr> <CAPOJW5yUi471cfAXuXaM4BCzVsfZ15J1Era4NuEpxEnmY6md9Q@mail.gmail.com> <p69r38sn-1ppn-q66q-9089-59394pq78772@tzk.qr>
 <CAPOJW5zYndyqwyN8xOcRQnwebqXciY-25hNL3fU=V5ac8fCpNA@mail.gmail.com> <s714sq49-o13q-5417-0o21-6397s3646q9o@tzk.qr> <CAPOJW5yNQvO3quG91jjC9pT-+NNhJta+H_E2R9-1wUzR+rPXnw@mail.gmail.com> <68r08n47-9o07-351s-710q-786q69429q86@tzk.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:+odpxi8vzqcmDbGIRfEjan+kWX1oM1BhKj/zRSUxoyxiI9vynMc
 7WPdWBnkb9FKGITVG3KshqP5YDvZwZ2ORxAes4tD51/EOA85ZW+dFrNQlmHjPvASXF1BD/I
 Bf4NOA5FuAiw5xj+bhNYh+ysdGrF2sTz3hyHyD2WLYJqmaMxoihRt1kGkHknf/tl4M+6GOh
 D1yc5OMP4Hbgt4FcSViSg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sVVVSOM0X1c=:mErgnBwLxc525grAHnAwmn
 OWrSRIiQeC25St6XhQ0+n+JxFP1ihErlDt4sAkwHexV5aS+weVdiZk04bD51cRHKLNcz/Sv2l
 ija/kmoxIxtll50KGLTY5/PNd/og0Bru3mizl/QOC5EvV25PIEhfomY674QVFufe21gJ9jSjZ
 WzVDIdFIgEIBBKBeWjvDIWzqYzC7wkF0yUbSUOMsTMIG+zgmqb92weEV3D9e5ZHFUnotYdXkr
 xRUXy1F+b4vIUzrak2t6FjyfPI33fCPDUiFTBmfKntuk/fhMortsv04S1tCI9B6Vwaa51GeB5
 qKeDElTISSwdAxHm5zr869ALvbvNNytMmWkXljijTe3u5wtuSW6exuHQI6S3darAz5n86fpnB
 E0PwtbkaqXUXIh7PPKx88/GTHwse5ZiQbWqJ9PR6QyKAab8G5lneFNS5i+GXEifTZ1QHTp/j4
 QM0G/KX9cSmjpy0HbSGwEAjvO2e/tH6BRzaB3Z+HEb5YPd0ombeknW3EKy8ajVw5Sg8SBfpj+
 qeQ6Iyv5I5gDPlq/kZTsp35mOoocFEE2BoZpPddyuC3bsOhtG0gtD/ktddijblQcQnPeXVipM
 IZEEabjDcn2gPDC+kT349foGaEXBGf8ihDJV/AEErPI4fWPCPl+Le/aD0mPBSxO3Q7yrzy6bP
 DHWKFSkjjboyWdHN/J0PTfK7yJpATEEpqe52FnY0iy8JHn5OReaLXYsGKEox2z4D310nvElU0
 JoinL+Wtoah+EY/bGKR5BPjO1zb+ieQe3NcMzDlG2It2UokE/5vrfCw9AxuTeD49rV34Y/CFg
 24LwqEaI1iuNgocJ56WMQcuPy2YsJJfChlMlFYwLw7kmjimcfaQk0+Xp7LDNZFQtR4FTNx7yS
 zpYOA5kdnXPSDLZpSAhTIuaXKreyUs4LDFprXGqPFHQOuI8w1Q7AUlRw7MMZeHGduiOmVJ4FF
 JmvTL5g8AoIyj+1l/WJ06VQWs5gMB1q+D+Czd6319nknZV7UllRPjaNcoCB32Inm7tHkOsPsy
 BkDPed6ZE/yr/DgVpeWdFxXmh0MLJRjwfVGjRtMnw4Dgsu28Dphebt+B7dEF7Fk3lAChG77Ii
 hI5rCAyl1xlhXMk4ei5hFl6YX8+7v7D1mzM5OaGieWccqzd5Jx1QK+5Mw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Abhradeep,

On Wed, 10 Aug 2022, Johannes Schindelin wrote:

> On Tue, 9 Aug 2022, Abhradeep Chakraborty wrote:
>
> >  I noticed in the 'setup partial bitmaps' test case that if we comment
> > out the line `git repack &&` , it runs successfully.
> >
> >     test_expect_success 'setup partial bitmaps' '
> >         test_commit packed &&
> >         # git repack &&
> >         test_commit loose &&
> >         git multi-pack-index write --bitmap 2>err &&
> >         ...
> >     '
>
> That's interesting. Are the `.bitmap` and `.midx` files updated as part =
of
> that `repack`?

I instrumented this, and saw that the `multi-pack-index` and
`multi-pack-index*.bitmap` files were unchanged by the `git repack`
invocation.

Re-generating the MIDX bitmap forcefully after the repack seems to fix
things over here:

=2D- snip --
diff --git a/t/lib-bitmap.sh b/t/lib-bitmap.sh
index a95537e759b..564124bda27 100644
=2D-- a/t/lib-bitmap.sh
+++ b/t/lib-bitmap.sh
@@ -438,7 +438,10 @@ midx_bitmap_partial_tests () {

 	test_expect_success 'setup partial bitmaps' '
 		test_commit packed &&
+ls -l .git/objects/pack/ &&
 		git repack &&
+git multi-pack-index write --bitmap &&
+ls -l .git/objects/pack/ &&
 		test_commit loose &&
 		git multi-pack-index write --bitmap 2>err &&
 		test_path_is_file $midx &&
=2D- snap --

This suggests to me that the `multi-pack-index write --bitmap 2>err` call
in this hunk might reuse a stale MIDX bitmap, and that _that_  might be
the root cause of this breakage.

What do you think?

Ciao,
Dscho

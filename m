Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11BF0C00140
	for <git@archiver.kernel.org>; Mon,  8 Aug 2022 13:40:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243354AbiHHNkJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Aug 2022 09:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243341AbiHHNkH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Aug 2022 09:40:07 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A506BC98
        for <git@vger.kernel.org>; Mon,  8 Aug 2022 06:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1659965997;
        bh=wh8K2fDIiqefI2Pzyu172UnuNhnjq/vd4t7+KeZkWc0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=aNK9VlXw8lJ1gFD9c/OvkQlEvFkjLm653bYmPumpNH6CTLmHajNHxnd2WSTHt9g1/
         FbJMEJBgdZ9Zx3+kNn85BNQzuvWAwnBlAUycfT3f9nN9MFI4V1DV7DPXtH2lhry1Yk
         +oYM4NFsTMhJPHqE0qByjL0C+mDKSPbenNQAB0MQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.21.182.192] ([89.1.214.151]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MQMuR-1nypJ745YX-00MMFY; Mon, 08
 Aug 2022 15:39:57 +0200
Date:   Mon, 8 Aug 2022 15:40:09 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] tests: fix incorrect --write-junit-xml code
In-Reply-To: <xmqq35f38yeb.fsf@gitster.g>
Message-ID: <s4s2qr56-2948-p025-rrq7-qq56p9oo844r@tzk.qr>
References: <pull.1288.git.1657789234416.gitgitgadget@gmail.com> <xmqq35f38yeb.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:kUnuZeoROLr64MaclIw7HKGtOxgQDZVRu1ciW+ZzrUpWhdlOFIr
 2VBep1uiC75bhkJP5f8OBB1z/D+nmfTiph0hF3B3N0vifK1j1C5hGEatLNtMbFQ/Q+vWj+C
 t/8CjEZTrPhfHDCFLsjIPjkw1UT5G3n4m0bbXYFZbkZWqZt97r5uoyjSjPylkEVfmZDHp+3
 Yo8zsmNwSPkOTrizHZsUA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Yl1q1NHmKkI=:mgBnbXDUhqAF+0GrFV1Cum
 cr7B0lwOIEi5utE8vWu0jXZOeVcr/2KnrTmCfqNHxu+47bU7jTFpfMXMbvBCxjNRaU4Y0G6C/
 QiE2o9GQG04J/VZx4O/ojenbstjqHvBrk+Tc8BiDtEDY2DaeZpgw1rAEI2xI4n9D7JDOX98XN
 IhBqNoT0IMtob1IBDLsrdK/mfwqzVZPWmeXTGGBI7Q06nYPMtbJLsxj6Ss/zNDUVlV+2Tx25H
 ZAmPhbdtaEWcTrNaEtGdjQo8qwx8Xxg25FxHv9c1hB+aIpjmBZ3EIWMfpkH4R/V4/MTOo4gl4
 9Foh5ZX8/W087DCG1BNAph5RaHePHdpygl0xhFvQ7x8i5H0SmKaO9lANR1/XEfy3PYbjt9MQi
 9/tP72antVdGDS7gQkxZlSMWkZAKroRy/6NNheGbZiaLup0VLcD0DeSgEUE7FNmVfoRu/ajgk
 ySZDJzcYL92vVYJGffzrqi7RJ1i7Y2nOj+CSkQnm/1moZo9BhkRfNFoJkSUDAcoi9SLhgzx46
 1xKn+wV76S1x3jCaQLN7jIXKR2p/REN79EnT3qsPenCWAwoPsVt0OdX22eKGYTPv9kPPdCWZW
 5UsqsFQiUOH7L2cshmxLFYZTZnv212jjUMIAK3/bfm0G6JOF3WhRkgaEHxR8sRI0mzhdFlD3a
 Uzmql4+WMKDrKqrn5xNgIhTyiKed7lVnYyCT9FVmvDaIL4mHoBaOk0QcBFMAdElMHRCakVJAu
 baO3ZtA74mUiQivvORP8XoED3MklS3UlibXxBGZfakeBDfz6QgLPfca9vYfLRyvdbi4nVaPEK
 uKEyv1mJr6WezA3jHNbDLF57VCu41BDYfygh5mYUiqbP0A4FhBKNiBg1o7WPQlPM0RPraR2Qr
 LEeWBdiDKnJ3IQ74bhttRpu9+ge5O0YaESneLTn2a2DEBwwu3uPrCDJCrm+baqaBBw8LBp+K2
 DPAcAdcbnkJCkalUn7yO/eYymx8raVjMULsFTQjcolpgUA7n8PKrMhbfoRQoQ/lMKpYNRkEqB
 UGNDvzKC9SEnIhIrCxdLiKf9f8XEU9jmzm6hPhEy4ls2GTJ/K0KJPuf4PjJuImhwWtxUFXA69
 uKilrBsu0eylipRb1PI1+DdgZHv1p0PMavac4l7rV6c4gj8pcB8NJ8jHw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 14 Jul 2022, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> >     Unfortunately, I noticed this regression no earlier than when I ne=
eded
> >     to validate Git for Windows v2.37.1. Since v2.37.1 was an embargoe=
d
> >     release, I could not use GitHub Actions for the CI testing, so I h=
ad to
> >     reinstate Git's Azure Pipeline.
>
> I wonder if it would make your life easier

It would make my life easier if Chesterton's Fences were left alone ;-)

> if the same GitHub Actions CI stuff were available for the Cabal
> repository we use for embargoed work, by allowing you to use the same
> validation for usual releases and the enbargoed ones?

GitHub Actions are available in the Cabal repository. The problem is that
due to the private nature of said repository, the number of included build
minutes is limited.

I did manage to get GitHub to sponsor the Git project specifically to
increase said build minutes. But that only scratches the problem at the
surface.

I still think that we need to slow the heck down with refactoring for
refactoring's sake because it's not only the CI builds that are affected.
I pay a lot of time to accommodate for those refactorings, and so do
others, and the benefit of most of those refactorings escapes me. My best
guess is that they adapt Git's source code to individual tastes, which is
of course a losing game because too many individuals with too many
different tastes are involved in the Git project. Unless we start valuing
particular individuals' tastes over others', which I believe we should not
do.

You asked me in private to provide more reviews for those refactorings so
that they see some push-back, but I lack the bandwidth for that.

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> >  t/test-lib-junit.sh | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/t/test-lib-junit.sh b/t/test-lib-junit.sh
> > index c959183c7e2..79c31c788b9 100644
> > --- a/t/test-lib-junit.sh
> > +++ b/t/test-lib-junit.sh
> > @@ -46,7 +46,7 @@ finalize_test_case_output () {
> >  	shift
> >  	case "$test_case_result" in
> >  	ok)
> > -		set "$*"
> > +		set -- "$*"
> >  		;;
> >  	failure)
> >  		junit_insert=3D"<failure message=3D\"not ok $test_count -"
> > @@ -65,17 +65,17 @@ finalize_test_case_output () {
> >  			junit_insert=3D"$junit_insert<system-err>$(xml_attr_encode \
> >  				"$(cat "$GIT_TEST_TEE_OUTPUT_FILE")")</system-err>"
> >  		fi
> > -		set "$1" "      $junit_insert"
> > +		set -- "$1" "      $junit_insert"
> >  		;;
> >  	fixed)
> > -		set "$* (breakage fixed)"
> > +		set -- "$* (breakage fixed)"
> >  		;;
> >  	broken)
> > -		set "$* (known breakage)"
> > +		set -- "$* (known breakage)"
> >  		;;
> >  	skip)
> >  		message=3D"$(xml_attr_encode --no-lf "$skipped_reason")"
> > -		set "$1" "      <skipped message=3D\"$message\" />"
> > +		set -- "$1" "      <skipped message=3D\"$message\" />"
> >  		;;
> >  	esac
>
> OK.  Ancient shells did not understand "--" and it was idiomatic to
> say "set x ...; shift", but we already do assume "set --" is usable
> everywhere we care about in many of our scripts and tests.
>
> Looks good to me.
>
> Thanks.  Will queue.

Thank you,
Dscho

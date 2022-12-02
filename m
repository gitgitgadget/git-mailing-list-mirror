Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2878C47088
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 16:00:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233864AbiLBQAV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Dec 2022 11:00:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233827AbiLBQAK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2022 11:00:10 -0500
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205779A4CD
        for <git@vger.kernel.org>; Fri,  2 Dec 2022 07:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1669996793; bh=OUvIezK7xB0icguPLYRa4GBfoesDB1iH+snagfReIls=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=LfR23eVykN2jRuCl1bluVktifO+nG/kiqsbfhHQxh106GvpQ0wSxEsAzsDJeqfgdn
         ydVWMWJSio1SFwlc5Nqu+0dq+Cj99WnUoCidCFO30OGha9Lu0kgXfp8EM6ETORBHZt
         2NTwObFh9nWUnJao5O9Y1BWMffiSpnnHCu+Ua1Fq+Q+U88xwgAiPaphLU8hrivr2jI
         GnlHrf49qnCaeWO/xi1ONYBPzI/mFEKEdQGhitmGOrAEzNHbMEp/xdqFgS9Ld70VIg
         vhY6T7H5u+7Yz0C4js3CAgb+Ffnx3EzlCTcFzV/FcxA+bdfjdrAY8OPiIPWsrO6p/X
         C30ShenfWqxqA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.154.159]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M6YJB-1p3dYG2ZuD-006sjf; Fri, 02
 Dec 2022 16:59:53 +0100
Message-ID: <8cfb5bc5-6e17-4cac-cc2f-2f900f14fa60@web.de>
Date:   Fri, 2 Dec 2022 16:59:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH v3 2/8] auto-crlf tests: don't lose exit code in loops and
 outside tests
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Torsten_B=c3=b6gershause?= =?UTF-8?Q?n?= 
        <tboegi@web.de>
References: <cover-v2-0.8-00000000000-20221202T000227Z-avarab@gmail.com>
 <cover-v3-0.8-00000000000-20221202T114733Z-avarab@gmail.com>
 <patch-v3-2.8-394d5e46494-20221202T114733Z-avarab@gmail.com>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <patch-v3-2.8-394d5e46494-20221202T114733Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MFOA6s2npKuEIP4sSVZ9C7spaxU4/aWHZkoCSJy+d+Ve08m2FYC
 4CSdGtPW+RyglxqS2+HbD2dLhx0PNswH5ez/LziaAZBNHCE6SpPRVcIjjPvO/woAGDGrKxV
 tyQWOHIll0UzbhZcXulMLmyIt2GXZYD2/WZR9p3lpuHSMpQCWhFZ3tLfHzPPu6KF0FBN9at
 hli37K54bNmxfMVk4omUQ==
UI-OutboundReport: notjunk:1;M01:P0:gq2O9qWoHn4=;CmDhCrpf79YAxZr8umQH1W+3V/D
 iNExhrHc66cBJgDE+BdYinON2H7Sa+TUm+Sns7fhJBrTSV643yDls1WI4r85yA83+1cHJOIu+
 HvTsoDia0qzOoB+gqLBCIc36x3FzEBG6fplzvZ/9QMUrNQQ/mCIyaxldcHAWpUeDV0KVg0CDW
 q5u/WKkM6WrRmZy2K6p6FXNpfsrg0rNaaN5VgtNQbtXA3Ita9PgqtFQi7s3PXx1PXDIzVYUgf
 Dg8GMV8F3jUYTCVWucQ/e3mJHffCLAw2ev+ODrOmo1vJOEkWJ6nYUtyKIQqKu6EUUrn7uZow/
 io+JKpuDUfm7l8baAjuzaJ6BLBWg6EIg2sRQ16e05OIxe/FuuDsvq83NfX62VZbR92t/VUwMX
 wRrzPaOQrTowFrZ9bz4qWmLVnW3l3DU1SvFN7G/Cz/i83Dkp7qxxuty/66tyNeLfI6cSfRLLA
 VEh1hjP3nDFxU1KfbMEG0xBepeNojyGC0Z3QPZnAl68chrrdy1m00JYuIJXM5NqelE/K7mq3H
 dfK1xOwxBR0mclAi4RJPQ2FHKZLzKKognRVJFzv6lIRqot1cHt3GPpNTDC6E6TMVOSJ4obCIp
 aMZ34iYNAoxSf4IzpKUnbVJS4Bx/8TXUnt1G4tmNUkstJCAl25FoXKci3Ye7VLIeFSG9kO8/p
 TpfBTn09gz/gIGu+Qx69EjgW+waEdo7URAJ/Xbu1h2v8Qy8i8R36rE2u0vIm9bqbqGQlVjFcK
 rjE6AzRU+SkzeWCW8rFEL2IvpX5FB3kjDaaajadmT18l/nwffLxOKob+3HUbxlqcou/Syx7IX
 ai4ggf2CGwUw77kWOpuzDwEH2TbF13iDhlJdbin8Mg6HV9gs8Zs3sAbUJEMruWievAPfpR3Xx
 kg0MsLsdgl4q/4KiTteECyHsufNHIR3H2tDLrc0MM1gj+VtTFymr4jyJaYPLf2Kun8JtNJOx8
 O7x5Hg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 02.12.22 um 12:52 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> Change the functions which are called from within
> "test_expect_success" to add the "|| return 1" idiom to their
> for-loops, so we won't lose the exit code of "cp", "git" etc.
>
> Then for those setup functions that aren't called from a
> "test_expect_success" we need to put the setup code in a
> "test_expect_success" as well. It would not be enough to properly
> &&-chain these, as the calling code is the top-level script itself. As
> we don't run the tests with "set -e" we won't report failing commands
> at the top-level.
>
> The "checkout" part of this would miss memory leaks under
> SANITIZE=3Dleak, this code doesn't leak (the relevant "git checkout"
> leak has been fixed), but in a past version of git we'd continue past
> this failure under SANITIZE=3Dleak when these invocations had errored
> out, even under "--immediate".
>
> Helped-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  t/t0027-auto-crlf.sh | 60 +++++++++++++++++++++++++-------------------
>  1 file changed, 34 insertions(+), 26 deletions(-)
>
> diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
> index a94ac1eae37..23f2e613401 100755
> --- a/t/t0027-auto-crlf.sh
> +++ b/t/t0027-auto-crlf.sh
> @@ -70,7 +70,8 @@ create_NNO_MIX_files () {
>  				cp CRLF        ${pfx}_CRLF.txt &&
>  				cp CRLF_mix_LF ${pfx}_CRLF_mix_LF.txt &&
>  				cp LF_mix_CR   ${pfx}_LF_mix_CR.txt &&
> -				cp CRLF_nul    ${pfx}_CRLF_nul.txt
> +				cp CRLF_nul    ${pfx}_CRLF_nul.txt ||
> +				return 1
>  			done
>  		done
>  	done
> @@ -101,7 +102,8 @@ commit_check_warn () {
>  	do
>  		fname=3D${pfx}_$f.txt &&
>  		cp $f $fname &&
> -		git -c core.autocrlf=3D$crlf add $fname 2>"${pfx}_$f.err"
> +		git -c core.autocrlf=3D$crlf add $fname 2>"${pfx}_$f.err" ||
> +		return 1
>  	done &&
>  	git commit -m "core.autocrlf $crlf" &&
>  	check_warning "$lfname" ${pfx}_LF.err &&
> @@ -121,15 +123,19 @@ commit_chk_wrnNNO () {
>  	lfmixcr=3D$1 ; shift
>  	crlfnul=3D$1 ; shift
>  	pfx=3DNNO_attr_${attr}_aeol_${aeol}_${crlf}
> -	#Commit files on top of existing file
> -	create_gitattributes "$attr" $aeol &&
> -	for f in LF CRLF CRLF_mix_LF LF_mix_CR CRLF_nul
> -	do
> -		fname=3D${pfx}_$f.txt &&
> -		cp $f $fname &&
> -		printf Z >>"$fname" &&
> -		git -c core.autocrlf=3D$crlf add $fname 2>"${pfx}_$f.err"
> -	done
> +
> +	test_expect_success 'setup commit NNO files' '
> +		#Commit files on top of existing file
> +		create_gitattributes "$attr" $aeol &&
> +		for f in LF CRLF CRLF_mix_LF LF_mix_CR CRLF_nul
> +		do
> +			fname=3D${pfx}_$f.txt &&
> +			cp $f $fname &&
> +			printf Z >>"$fname" &&
> +			git -c core.autocrlf=3D$crlf add $fname 2>"${pfx}_$f.err" ||
> +			return 1
> +		done
> +	'
>
>  	test_expect_success "commit NNO files crlf=3D$crlf attr=3D$attr LF" '
>  		check_warning "$lfwarn" ${pfx}_LF.err
> @@ -163,15 +169,19 @@ commit_MIX_chkwrn () {
>  	lfmixcr=3D$1 ; shift
>  	crlfnul=3D$1 ; shift
>  	pfx=3DMIX_attr_${attr}_aeol_${aeol}_${crlf}
> -	#Commit file with CLRF_mix_LF on top of existing file
> -	create_gitattributes "$attr" $aeol &&
> -	for f in LF CRLF CRLF_mix_LF LF_mix_CR CRLF_nul
> -	do
> -		fname=3D${pfx}_$f.txt &&
> -		cp CRLF_mix_LF $fname &&
> -		printf Z >>"$fname" &&
> -		git -c core.autocrlf=3D$crlf add $fname 2>"${pfx}_$f.err"
> -	done
> +
> +	test_expect_success 'setup commit file with mixed EOL' '
> +		#Commit file with CLRF_mix_LF on top of existing file
> +		create_gitattributes "$attr" $aeol &&
> +		for f in LF CRLF CRLF_mix_LF LF_mix_CR CRLF_nul
> +		do
> +			fname=3D${pfx}_$f.txt &&
> +			cp CRLF_mix_LF $fname &&
> +			printf Z >>"$fname" &&
> +			git -c core.autocrlf=3D$crlf add $fname 2>"${pfx}_$f.err" ||
> +			return 1
> +		done
> +	'
>
>  	test_expect_success "commit file with mixed EOL onto LF crlf=3D$crlf a=
ttr=3D$attr" '
>  		check_warning "$lfwarn" ${pfx}_LF.err
> @@ -294,12 +304,10 @@ checkout_files () {

The context lines right here are:

	create_gitattributes "$attr" $ident $aeol &&
	git config core.autocrlf $crlf &&

Those better be covered by test_expect_success as well, right?  Wrap them =
and
the whole loop in a single test_expect_success, like you did above?

>  	pfx=3Deol_${ceol}_crlf_${crlf}_attr_${attr}_ &&
>  	for f in LF CRLF LF_mix_CR CRLF_mix_LF LF_nul
>  	do
> -		rm crlf_false_attr__$f.txt &&
> -		if test -z "$ceol"; then
> -			git checkout -- crlf_false_attr__$f.txt
> -		else
> -			git -c core.eol=3D$ceol checkout -- crlf_false_attr__$f.txt
> -		fi
> +		test_expect_success "setup $f checkout ${ceol:+ with -c core.eol=3D$c=
eol}"  '
> +			rm -f crlf_false_attr__$f.txt &&
> +			git ${ceol:+-c core.eol=3D$ceol} checkout -- crlf_false_attr__$f.txt
> +		'
>  	done
>
>  	test_expect_success "ls-files --eol attr=3D$attr $ident aeol=3D$aeol c=
ore.autocrlf=3D$crlf core.eol=3D$ceol" '

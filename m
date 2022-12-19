Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA15C4167B
	for <git@archiver.kernel.org>; Mon, 19 Dec 2022 12:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbiLSMLC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 07:11:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbiLSMKM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 07:10:12 -0500
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4758910FF6
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 04:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1671451680; bh=8s6ohaiXtlmvRTHpTbQfxVCUK6PrWx2Mgyh15VpaguE=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=lOV+3h8+6AXR3ijH4+J0Zr/sKFp/8OKOVHgVJcy+UaFt73zUk2jK9tI9T2+gEMSNR
         0Vn3FkK88wiNJ6/+yWFFpF7PAz2tQC2e3S4Q51uB8deQ8RAqYfYLz7d3bugIX/xD/k
         ULIYu4+7VifaNsVOwO9fmbZ3ZU3idlGYk78rkhBTPE0W+hF3vFrLw2ZeZpciYuBzz+
         3meMXudE6LiU9og/vrTsM1S+i0ktjVKZAizqvR+AcDh2NWtmyKYz8HVRQuUKhFuwrZ
         xMtawf+FZpwChowGk1MeR5V8uWQawLa1aKhOWGNo8gNrh9xGOhCcft2tlCUKi2Ev7x
         ZG8g9NgyH1eYQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.151.35]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MkEhH-1oRtph1w7N-00kHRb; Mon, 19
 Dec 2022 13:08:00 +0100
Message-ID: <1182283a-4a78-3c99-e716-a8c3e58a5823@web.de>
Date:   Mon, 19 Dec 2022 13:07:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Subject: Re: [PATCH v4 1/6] auto-crlf tests: don't lose exit code in loops and
 outside tests
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Torsten_B=c3=b6gershause?= =?UTF-8?Q?n?= 
        <tboegi@web.de>
References: <cover-v3-0.8-00000000000-20221202T114733Z-avarab@gmail.com>
 <cover-v4-0.6-00000000000-20221219T101240Z-avarab@gmail.com>
 <patch-v4-1.6-68d276dd421-20221219T101240Z-avarab@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <patch-v4-1.6-68d276dd421-20221219T101240Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YOXk70dEQ9VkJqOR5B29IaSacPVk2/P7omarjzVIl0xh/aFBrKf
 wFVUnu/+Nj9GIimPIsPWAmgbgn+rwhxr4OnuwW3rx3LlmU/njEApnZ90Ex7oya/34m4SY9d
 QR7IiTXXjzV/+ZOtgN+6/ghoDTMPsS9xMVnuVCjRLKmMvbF1QdIbQcjvHapPJbkEEAQAwml
 cZe1+yIxO0GIL/JbGyM1Q==
UI-OutboundReport: notjunk:1;M01:P0:qF7aTlrTsEQ=;5I0Ms7g9PNGE0rW2ZaL1HGXNWUV
 24xbLr66Ko5H5EPgzMZe6+K6Rpuix74IR93IC+DID+tR8o3lKOabHPH2zMhft5pj8ZFn/pp6p
 nv01iD5Oq9HAIPxaAnT7svccBeoPP9t+Hi9n66bvhgQ7uPO1t/N2UhPdfQr4HlenM3jFrHDY6
 2nu3OhCd/p1qZ5NuzsIQqCWgY430ll5A11+tGE/D2UK6U31VBvciyUObvL79i2U0/dUkZlrlU
 KeXqILxIJQTNw0ntStfT34WxNYhBtGkvVFo7QzeDLutIS28+c53RSfiqD6/Jy96fE7O6f/yNJ
 FiKLn36lscb3+/84DG4GgW3d06PqFBcghR2p2G6HazWwgAqMarM1pqo67FSaxRbMjsK2Ksy4s
 0z1DQ2P657brmWigMkOWnHjaXxJjsMQu4Pvs2snPcbcAmAcFVH13CQ9axbbouheOA+esVE9QJ
 NmuBh/dt8yLm1goWfToCDd4S/Vm3NCAtDLPwg4wNzO+bQMNtRRdvfYK06Vq5CBP6j71a1/y3t
 GST29ROMm1/1w6Gic6dpPBXc7hhOavULDc1Bqru/wBR3lUfYKxh/n72AFgOFsR5Cg9MJHI6XZ
 XbutjMZ7syLHjpyuz5seThssUjKJzG15+438ZTWb5/fuS6gN5bKerTT2eE0gtudv6PezfcRN5
 K8q3awNA9zI+3ZS7LgFhI6T3ScIO4yZvDxNMoGTnmRF+9oFqr2FcWYEO6DclboOxd6ogkgQVl
 popmcIC3W/Zbx/Mag9oK637wvrrvD2KGvJqEM4QyS05uIcwdjharUdL1widMr662TmtkCdehe
 6h952Vred9F9jLzn6eBLtE5L0YXWXFY8UEGSxXp9CBwLIXu80j/Pwmw1qc8yZGLZEjanbs0Lk
 UlaA1tCqB9Am2Fg87G8hrHRYxJ4CwHsIzoe4OPAw0xw9Lmo5kaRXDAD0WqaX60FqAiOiU4sYc
 jNBFFg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 19.12.22 um 11:19 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
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
>  t/t0027-auto-crlf.sh | 66 +++++++++++++++++++++++++-------------------
>  1 file changed, 38 insertions(+), 28 deletions(-)
>
> diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
> index a94ac1eae37..2f57c8669cb 100755
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
> @@ -289,17 +299,17 @@ checkout_files () {
>  	lfmixcrlf=3D$1 ; shift
>  	lfmixcr=3D$1 ; shift
>  	crlfnul=3D$1 ; shift
> -	create_gitattributes "$attr" $ident $aeol &&
> -	git config core.autocrlf $crlf &&
> +	test_expect_success "setup config for checkout attr=3D$attr ident=3D$i=
dent aeol=3D$aeol core.autocrlf=3D$crlf" '
> +		create_gitattributes "$attr" $ident $aeol &&
> +		git config core.autocrlf $crlf
> +	'
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

OK, but why have test_expect_success inside the loop here, while a simlila=
r
loop is inside the two test_expect_success bodies above?  Do we really nee=
d
five invocations here instead of one?  It's just setup code.

>  	done
>
>  	test_expect_success "ls-files --eol attr=3D$attr $ident aeol=3D$aeol c=
ore.autocrlf=3D$crlf core.eol=3D$ceol" '

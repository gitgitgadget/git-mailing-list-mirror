From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] t0027: check the eol conversion warnings
Date: Fri, 05 Dec 2014 15:15:21 -0800
Message-ID: <xmqqfvctofhy.fsf@gitster.dls.corp.google.com>
References: <547B7AF8.80700@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Dec 06 00:15:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xx262-0007Bh-FB
	for gcvg-git-2@plane.gmane.org; Sat, 06 Dec 2014 00:15:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752965AbaLEXP2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Dec 2014 18:15:28 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50812 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752914AbaLEXPZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Dec 2014 18:15:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F19DC24E6E;
	Fri,  5 Dec 2014 18:15:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=9FQR6lou8XBB
	fJ6HlfiRJl2MfCI=; b=pzhfPcCVFqR/ovB2eQQA2PsR34QMP9fUxbVhF7MuRBFo
	fSQB0bMhH9s/TTvNSZEuJnRajxgUI8JPomNZlTMO9de3unDZbNRntbffTthPjCkB
	ljNr+4fB4uEdDX8Jnhd3UwkbybANY01MXdhVIkB0RRcI2QXqUh1KlWnOZ7ovrbs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ScYSCh
	Dy7gms6Ekv4ItTEQAkN3UeCX1+J+7PyDiTzWQao5L+x6WKTT1Pq40FHge4yL9faJ
	UvKG6S7IQ2JpRoLPNlvfg+SjFhf24/tpyG0ViiDG+ihy8xX5HnRPKUw2v2LKLKhx
	rZKalo1rdOuYqz7q1cxPAa6/3J05nPL0Es9OU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E895124E6D;
	Fri,  5 Dec 2014 18:15:23 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6763D24E69;
	Fri,  5 Dec 2014 18:15:22 -0500 (EST)
In-Reply-To: <547B7AF8.80700@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershausen?=
 =?utf-8?Q?=22's?= message of
	"Sun, 30 Nov 2014 21:15:52 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 964A4CB4-7CD4-11E4-A932-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260913>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> Depending on the file content, eol parameters and .gitattributes
> "git add" may give a warning when the eol of a file will change
> when the file is checked out again.
>
> There are 2 different warnings, either "CRLF will be replaced..." or
> "LF will be replaced...".
>
> Let t0027 check for these warnings:
> call create_file_in_repo() with additional parameters,
> which will be used to call check_warning().
>
> When a file has eol=3Dlf or eol=3Dcrlf in .gitattributes, it is handl=
ed
> as text and should be normalized.
> Add missing test cases in t0027.
>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---

Thanks; nobody seems to have shown interest in this and it fell
through the cracks it seems.  I didn't make a connection to the
previous discussion when I saw this v2, and backburnered it.

The patch is clear that the change to check the expected "X will be
replaced by Y" is added to existing combinations, and also for the
lf & crlf cases the existing tests were not checking earlier.

Will queue.

> Changes since V1:
> - Simplified the diff
> - Fixed a bug (LF_mix_CR.err was mixed with CRLF_mix_LF)
> - Changed the commit message
>  t/t0027-auto-crlf.sh | 82 ++++++++++++++++++++++++++++++++++++++++++=
----------
>  1 file changed, 66 insertions(+), 16 deletions(-)
>
> diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
> index 2a4a6c1..452320d 100755
> --- a/t/t0027-auto-crlf.sh
> +++ b/t/t0027-auto-crlf.sh
> @@ -55,16 +55,41 @@ create_gitattributes () {
>  	esac
>  }
> =20
> +check_warning () {
> +	case "$1" in
> +	LF_CRLF) grep "LF will be replaced by CRLF" $2;;
> +	CRLF_LF) grep "CRLF will be replaced by LF" $2;;
> +	'')
> +		>expect
> +		grep "will be replaced by" $2 >actual
> +		test_cmp expect actual
> +		;;
> +	*) false ;;
> +	esac
> +}
> +
>  create_file_in_repo () {
>  	crlf=3D$1
>  	attr=3D$2
> +	lfname=3D$3
> +	crlfname=3D$4
> +	lfmixcrlf=3D$5
> +	lfmixcr=3D$6
> +	crlfnul=3D$7
>  	create_gitattributes "$attr" &&
> +	pfx=3Dcrlf_${crlf}_attr_${attr}
>  	for f in LF CRLF LF_mix_CR CRLF_mix_LF CRLF_nul
>  	do
> -		pfx=3Dcrlf_${crlf}_attr_${attr}_$f.txt &&
> -		cp $f $pfx && git -c core.autocrlf=3D$crlf add $pfx
> +		fname=3D${pfx}_$f.txt &&
> +		cp $f $fname &&
> +		git -c core.autocrlf=3D$crlf add $fname 2>"${pfx}_$f.err"
>  	done &&
> -	git commit -m "core.autocrlf $crlf"
> +	git commit -m "core.autocrlf $crlf" &&
> +	check_warning "$lfname" ${pfx}_LF.err &&
> +	check_warning "$crlfname" ${pfx}_CRLF.err &&
> +	check_warning "$lfmixcrlf" ${pfx}_CRLF_mix_LF.err &&
> +	check_warning "$lfmixcr" ${pfx}_LF_mix_CR.err &&
> +	check_warning "$crlfnul" ${pfx}_CRLF_nul.err
>  }
> =20
>  check_files_in_repo () {
> @@ -140,22 +165,47 @@ test_expect_success 'setup master' '
>  '
> =20
> =20
> -test_expect_success 'create files' '
> -	create_file_in_repo false "" &&
> -	create_file_in_repo true  "" &&
> -	create_file_in_repo input "" &&
> =20
> -	create_file_in_repo false "auto" &&
> -	create_file_in_repo true  "auto" &&
> -	create_file_in_repo input "auto" &&
> +warn_LF_CRLF=3D"LF will be replaced by CRLF"
> +warn_CRLF_LF=3D"CRLF will be replaced by LF"
> +
> +test_expect_success 'add files empty attr' '
> +	create_file_in_repo false ""     ""        ""        ""        ""  =
      "" &&
> +	create_file_in_repo true  ""     "LF_CRLF" ""        "LF_CRLF" ""  =
      "" &&
> +	create_file_in_repo input ""     ""        "CRLF_LF" "CRLF_LF" ""  =
      ""
> +'
> +
> +test_expect_success 'add files attr=3Dauto' '
> +	create_file_in_repo false "auto" ""        "CRLF_LF" "CRLF_LF" ""  =
      "" &&
> +	create_file_in_repo true  "auto" "LF_CRLF" ""        "LF_CRLF" ""  =
      "" &&
> +	create_file_in_repo input "auto" ""        "CRLF_LF" "CRLF_LF" ""  =
      ""
> +'
> +
> +test_expect_success 'add files attr=3Dtext' '
> +	create_file_in_repo false "text" ""        "CRLF_LF" "CRLF_LF" ""  =
      "CRLF_LF" &&
> +	create_file_in_repo true  "text" "LF_CRLF" ""        "LF_CRLF" "LF_=
CRLF" ""        &&
> +	create_file_in_repo input "text" ""        "CRLF_LF" "CRLF_LF" ""  =
      "CRLF_LF"
> +'
> +
> +test_expect_success 'add files attr=3D-text' '
> +	create_file_in_repo false "-text" ""       ""        ""        ""  =
      "" &&
> +	create_file_in_repo true  "-text" ""       ""        ""        ""  =
      "" &&
> +	create_file_in_repo input "-text" ""       ""        ""        ""  =
      ""
> +'
> +
> +test_expect_success 'add files attr=3Dlf' '
> +	create_file_in_repo false "lf"    ""       "CRLF_LF" "CRLF_LF"  "" =
      "CRLF_LF" &&
> +	create_file_in_repo true  "lf"    ""       "CRLF_LF" "CRLF_LF"  "" =
      "CRLF_LF" &&
> +	create_file_in_repo input "lf"    ""       "CRLF_LF" "CRLF_LF"  "" =
      "CRLF_LF"
> +'
> =20
> -	create_file_in_repo false "text" &&
> -	create_file_in_repo true  "text" &&
> -	create_file_in_repo input "text" &&
> +test_expect_success 'add files attr=3Dcrlf' '
> +	create_file_in_repo false "crlf" "LF_CRLF" ""        "LF_CRLF" "LF_=
CRLF" "" &&
> +	create_file_in_repo true  "crlf" "LF_CRLF" ""        "LF_CRLF" "LF_=
CRLF" "" &&
> +	create_file_in_repo input "crlf" "LF_CRLF" ""        "LF_CRLF" "LF_=
CRLF" ""
> +'
> =20
> -	create_file_in_repo false "-text" &&
> -	create_file_in_repo true  "-text" &&
> -	create_file_in_repo input "-text" &&
> +test_expect_success 'create files cleanup' '
>  	rm -f *.txt &&
>  	git reset --hard
>  '

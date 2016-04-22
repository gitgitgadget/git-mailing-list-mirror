From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 01/10] t0027: Make more reliable
Date: Fri, 22 Apr 2016 15:03:30 -0700
Message-ID: <xmqqbn51nvwt.fsf@gitster.mtv.corp.google.com>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
	<1461335908-5013-1-git-send-email-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: tboegi@web.de
X-From: git-owner@vger.kernel.org Sat Apr 23 00:03:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atjAy-00011u-Ic
	for gcvg-git-2@plane.gmane.org; Sat, 23 Apr 2016 00:03:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753128AbcDVWDj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Apr 2016 18:03:39 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50714 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751868AbcDVWDi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Apr 2016 18:03:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 55ACF1388E;
	Fri, 22 Apr 2016 18:03:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=O8ikoyWdA9fH
	J8p9YHGMNGLqMGQ=; b=eMAfvu3ZeOHptwPWNXOteqpf48daaKuhz1TD3+KlL7Ks
	OF+mdnmucwzm1SV0Ulugbk06Bre+Knk4JRlVX9326IB+lpWdYP9OY/SQkyRjrE7j
	9w0N/eJNrvE79waZSyfbCU/pFyOh4UTlt4/biFZgokjVd1zYM2e2NDI/WvWH2BE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=A//FUW
	Gzd7LZLeJLVULArnsFE04t3KwDlUQZnrTpsDq3mX0cZTvPFsn2AOfcF6uQEDGBFD
	kTs3CQfX74qhGGyKAMXthPAEb3uTBPuTivJrgV0y492nsn01RtyKoKkf2GV16WtX
	MIRSKVUvzQeslKARWVV38nae0sMRIWo/aabUU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4E8E51388D;
	Fri, 22 Apr 2016 18:03:32 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AFFA413881;
	Fri, 22 Apr 2016 18:03:31 -0400 (EDT)
In-Reply-To: <1461335908-5013-1-git-send-email-tboegi@web.de> (tboegi@web.de's
	message of "Fri, 22 Apr 2016 16:38:28 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0D1B99A4-08D6-11E6-B18A-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292283>

tboegi@web.de writes:

> From: Torsten B=C3=B6gershausen <tboegi@web.de>
> Subject: Re: [PATCH v6 01/10] t0027: Make more reliable

"Make more reliable" does not sound very grammatical.

> Make the commit_chk_wrnNNO test in t0027 more reliable:

Neither is the colon at the end.

> When the attributes of a commited file are changed and the file is ot=
herwise
> unchanged, Git may not detect that the next commit may need to treat =
the
> file as changed.
> This happens when lstat() doesn't detect a change, since neither inod=
e,
> mtime nor size are changed.
>
> Add a singe "Z" character to change the file size.
> Ignore it when comparing the files later.
>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---
>  Changes since v5:
>  - send the whole series, now 10/10
>  - Removed the "will change in future" in one commit msg
>  - Don't leak the filer in 4/10
>  t/t0027-auto-crlf.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
> index f33962b..9fe539b 100755
> --- a/t/t0027-auto-crlf.sh
> +++ b/t/t0027-auto-crlf.sh
> @@ -12,7 +12,7 @@ fi
> =20
>  compare_files () {
>  	tr '\015\000' QN <"$1" >"$1".expect &&
> -	tr '\015\000' QN <"$2" >"$2".actual &&
> +	tr '\015\000' QN <"$2" | tr -d 'Z' >"$2".actual &&
>  	test_cmp "$1".expect "$2".actual &&
>  	rm "$1".expect "$2".actual
>  }
> @@ -114,6 +114,7 @@ commit_chk_wrnNNO () {
>  	do
>  		fname=3D${pfx}_$f.txt &&
>  		cp $f $fname &&
> +		printf Z >>"$fname" &&
>  		git -c core.autocrlf=3D$crlf add $fname 2>/dev/null &&
>  		git -c core.autocrlf=3D$crlf commit -m "commit_$fname" $fname >"${=
pfx}_$f.err" 2>&1
>  	done

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] t: mailmap: add simple name translation test
Date: Tue, 14 Feb 2012 12:10:20 -0800
Message-ID: <7v8vk56us3.fsf@alter.siamese.dyndns.org>
References: <1329235894-20581-1-git-send-email-felipe.contreras@gmail.com>
 <1329235894-20581-3-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Marius Storm-Olsen" <marius@trolltech.com>,
	"Jim Meyering" <jim@meyering.net>,
	"Jonathan Nieder" <jrnieder@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 14 21:10:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxOho-0003uR-3k
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 21:10:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759595Ab2BNUKX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Feb 2012 15:10:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34027 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754400Ab2BNUKW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2012 15:10:22 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8729A753E;
	Tue, 14 Feb 2012 15:10:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=mF/oNscNogzUBZ9COm4yHn1jBgY=; b=ezwaJQOkxBkalk1M9sHZ
	nam/a5ttb1MaPHztJMQ6H09qVEnjE/ziQ2Bu63LoOJ8zoac8C3bo29Krun+L7US/
	hrBRHIa0HRw05ZEGu7gDyxoPsn7V3BqB8FXEBKVHMmjzaau8Y6WSHvS8m2EyaazN
	zZMCaZ8gE1kOAH1SGO9UHTQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=RXHQXnl+TFY5VM5vgxb3RNTKgYCL0TP1AmttalktdI6KTp
	e7MQdeA7+igM8x2SRngqB32bzwNcUfhkHSTQCvuy3wkNr7zD5BjJPrUnow+Teqgn
	hGqWZ2xoXNxC2is/adwPe0FbJ7qeFAQ+HMXVwQ8t9Yc0dFOixVT/AMxlOiGps=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7E384753D;
	Tue, 14 Feb 2012 15:10:22 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D7793753C; Tue, 14 Feb 2012
 15:10:21 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EC71003E-5747-11E1-BDC6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190745>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---

It was clear that we didn't have any test for "blame -e" hence it was no
brainer to judge that the patch 1/2 is good without any description.

But I am scratching my head, deciphering what this patch adds.

It appears to me that the existing tests that map author@example.com from
the original "A U Thor" to "Repo Guy" and inspect names and mails in
various output already cover this "Wrong with <right@company.xx> can be
corrected to Mr. Right" case this patch adds.

What am I missing?  Instead of explaining it to me, can it be explained in
the log message?

Thanks.

>  t/t4203-mailmap.sh |   14 ++++++++++++++
>  1 files changed, 14 insertions(+), 0 deletions(-)
>
> diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
> index db12265..fc3855a 100755
> --- a/t/t4203-mailmap.sh
> +++ b/t/t4203-mailmap.sh
> @@ -157,6 +157,9 @@ A U Thor <author@example.com> (1):
>  CTO <cto@company.xx> (1):
>        seventh
>  
> +Mr. Right <right@company.xx> (1):
> +      eight
> +
>  Other Author <other@author.xx> (2):
>        third
>        fourth
> @@ -196,6 +199,11 @@ test_expect_success 'Shortlog output (complex mapping)' '
>  	test_tick &&
>  	git commit --author "CTO <cto@coompany.xx>" -m seventh &&
>  
> +	echo eight >>one &&
> +	git add one &&
> +	test_tick &&
> +	git commit --author "Wrong <right@company.xx>" -m eight &&
> +
>  	mkdir -p internal_mailmap &&
>  	echo "Committed <committer@example.com>" > internal_mailmap/.mailmap &&
>  	echo "<cto@company.xx>                       <cto@coompany.xx>" >> internal_mailmap/.mailmap &&
> @@ -204,6 +212,7 @@ test_expect_success 'Shortlog output (complex mapping)' '
>  	echo "Other Author <other@author.xx>         <nick2@company.xx>" >> internal_mailmap/.mailmap &&
>  	echo "Santa Claus <santa.claus@northpole.xx> <me@company.xx>" >> internal_mailmap/.mailmap &&
>  	echo "Santa Claus <santa.claus@northpole.xx> <me@company.xx>" >> internal_mailmap/.mailmap &&
> +	echo "Mr. Right <right@company.xx>" >> internal_mailmap/.mailmap &&
>  
>  	git shortlog -e HEAD >actual &&
>  	test_cmp expect actual
> @@ -212,6 +221,9 @@ test_expect_success 'Shortlog output (complex mapping)' '
>  
>  # git log with --pretty format which uses the name and email mailmap placemarkers
>  cat >expect <<\EOF
> +Author Wrong <right@company.xx> maps to Mr. Right <right@company.xx>
> +Committer C O Mitter <committer@example.com> maps to Committed <committer@example.com>
> +
>  Author CTO <cto@coompany.xx> maps to CTO <cto@company.xx>
>  Committer C O Mitter <committer@example.com> maps to Committed <committer@example.com>
>  
> @@ -248,6 +260,7 @@ OBJID (Other Author DATE 4) four
>  OBJID (Santa Claus  DATE 5) five
>  OBJID (Santa Claus  DATE 6) six
>  OBJID (CTO          DATE 7) seven
> +OBJID (Mr. Right    DATE 8) eight
>  EOF
>  test_expect_success 'Blame output (complex mapping)' '
>  	git blame one >actual &&
> @@ -264,6 +277,7 @@ OBJID (<other@author.xx>          DATE 4) four
>  OBJID (<santa.claus@northpole.xx> DATE 5) five
>  OBJID (<santa.claus@northpole.xx> DATE 6) six
>  OBJID (<cto@company.xx>           DATE 7) seven
> +OBJID (<right@company.xx>         DATE 8) eight
>  EOF
>  test_expect_success 'Blame output (complex mapping)' '
>  	git blame -e one >actual &&

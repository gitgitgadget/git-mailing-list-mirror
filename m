From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 14/13] test-wildmatch: avoid Windows path mangling
Date: Tue, 20 Nov 2012 12:11:25 -0800
Message-ID: <7vd2z8rq4y.fsf@alter.siamese.dyndns.org>
References: <7vvcdco1pf.fsf@alter.siamese.dyndns.org>
 <50AB2B0F.8090808@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eQ==?= =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?= Duy 
	<pclouds@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Nov 20 21:11:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TauAY-0003kz-Bs
	for gcvg-git-2@plane.gmane.org; Tue, 20 Nov 2012 21:11:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752091Ab2KTUL2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Nov 2012 15:11:28 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41542 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751426Ab2KTUL1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Nov 2012 15:11:27 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2FD8C926E;
	Tue, 20 Nov 2012 15:11:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=TLlm8ogjxX+b
	X+rFrKRMocCz+Qo=; b=t5TkUS7O5vbO/bdCTMF5pbraWCCFEexfbxQ1MEDPxHtT
	aS194QMoaAMqa2ypWY6mq5rhbISQBYrH7aHTfHqWwiHBuuyT3uZFqATxIwYyf22z
	46Y32so3QYjlR+p06T4HJzZGbuWM0iiS0Y34PZTqyQVvXMSgdebZ958vqe0YBE8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=lvJfLw
	JrPwfxjeVx4UfP0w8xsP3BFxKHSrLU3z8IXhUx3eVaJwEd6oSyc/IRFsl/+P41Oo
	Fhue9VkUyMDVkAhqjLE3VonJUWz4DvhUj4zb0SpQOUcnj6fe48AF4vh/pVGflFCJ
	0g9iiCLYYGU3QlUybZitI06egXLXiy3p3yhGA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D086926D;
	Tue, 20 Nov 2012 15:11:27 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 752D99267; Tue, 20 Nov 2012
 15:11:26 -0500 (EST)
In-Reply-To: <50AB2B0F.8090808@viscovery.net> (Johannes Sixt's message of
 "Tue, 20 Nov 2012 08:02:39 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 769B344A-334E-11E2-9B35-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210109>

Johannes Sixt <j.sixt@viscovery.net> writes:

> From: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
>
> The MSYS bash mangles arguments that begin with a forward slash
> when they are passed to test-wildmatch. This causes tests to fail.
> Avoid mangling by prepending "XXX", which is removed by
> test-wildmatch before further processing.
>
> [J6t: reworded commit message]
>
> Reported-by: Johannes Sixt <j6t@kdbg.org>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  Works well, and I'm fine with this work-around.
>
>  -- Hannes

Thanks, but you need to fix your format-patch somehow.

> @@ -187,8 +187,8 @@ match 0 0 '-' '[[-\]]'
>  match 1 1 '-adobe-courier-bold-o-normal--12-120-75-75-m-70-iso8859-1=
' '-*-*-*-*-*-*-12-*-*-*-m-*-*-*'
>  match 0 0 '-adobe-courier-bold-o-normal--12-120-75-75-X-70-iso8859-1=
' '-*-*-*-*-*-*-12-*-*-*-m-*-*-*'
>  match 0 0 '-adobe-courier-bold-o-normal--12-120-75-75-/-70-iso8859-1=
' '-*-*-*-*-*-*-12-*-*-*-m-*-*-*'
> -match 1 1 '/adobe/courier/bold/o/normal//12/120/75/75/m/70/iso8859/1=
' '/*/*/*/*/*/*/12/*/*/*/m/*/*/*'
> -match 0 0 '/adobe/courier/bold/o/normal//12/120/75/75/X/70/iso8859/1=
' '/*/*/*/*/*/*/12/*/*/*/m/*/*/*'
> +match 1 1 'XXX/adobe/courier/bold/o/normal//12/120/75/75/m/70/iso885=
9/1' 'XXX/*/*/*/*/*/*/12/*/*/*/m/*/*/*'
> +match 0 0 'XXX/adobe/courier/bold/o/normal//12/120/75/75/X/70/iso885=
9/1' 'XXX/*/*/*/*/*/*/12/*/*/*/m/*/*/*'
>  match 1 0 'abcd/abcdefg/abcdefghijk/abcdefghijklmnop.txt' '**/*a*b*g=
*n*t'
>  match 0 0 'abcd/abcdefg/abcdefghijk/abcdefghijklmnop.txtz' '**/*a*b*=
g*n*t'
>  diff --git a/test-wildmatch.c b/test-wildmatch.c

This hunk claims that there are 8 lines in preimage and postimage,
but it is not the case.  It has only 7 lines each.

You also have the first line of the next patch "diff --git" somehow
indented.  How did this happen?


> index 74c0864..e384c8e 100644
> --- a/test-wildmatch.c
> +++ b/test-wildmatch.c
> @@ -3,6 +3,14 @@
>   int main(int argc, char **argv)
>  {
> +	int i;
> +	for (i =3D 2; i < argc; i++) {
> +		if (argv[i][0] =3D=3D '/')
> +			die("Forward slash is not allowed at the beginning of the\n"
> +			    "pattern because Windows does not like it. Use `XXX/' instead=
=2E");
> +		else if (!strncmp(argv[i], "XXX/", 4))
> +			argv[i] +=3D 3;
> +	}
>  	if (!strcmp(argv[1], "wildmatch"))
>  		return !!wildmatch(argv[3], argv[2], 0);
>  	else if (!strcmp(argv[1], "iwildmatch"))

And again this claims that the preimage has 6 lines while the
postimage has 14.  Somebody is overcounting, or perhaps you removed
the first pre-context by hand without adjusting the line number?

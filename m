From: konglu@minatec.inpg.fr
Subject: Re: [PATCH_v1] add 'git credential' plumbing command
Date: Sat, 09 Jun 2012 21:52:36 +0200
Message-ID: <20120609215236.Horde.J-h4cnwdC4BP06mEUeqxRlA@webmail.minatec.grenoble-inp.fr>
References: <1339267502-13803-1-git-send-email-Javier.Roucher-Iglesias@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Javier Roucher <jroucher@gmail.com>,
	Pavel Volek <Pavel.Volek@ensimag.imag.fr>,
	NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>,
	ROUCHER IGLESIAS Javier <roucherj@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Javier.Roucher-Iglesias@ensimag.imag.fr
X-From: git-owner@vger.kernel.org Sat Jun 09 22:21:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SdSAW-00035B-Vo
	for gcvg-git-2@plane.gmane.org; Sat, 09 Jun 2012 22:21:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752103Ab2FIUVS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Jun 2012 16:21:18 -0400
Received: from v-smtp.minatec.grenoble-inp.fr ([147.173.216.28]:47369 "EHLO
	v-smtp.minatec.grenoble-inp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751299Ab2FIUVR (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Jun 2012 16:21:17 -0400
Received: from localhost (www02.minatec.grenoble-inp.fr [147.173.216.15])
	by v-smtp.minatec.grenoble-inp.fr (Postfix) with ESMTP id DD1F51A161E;
	Sat,  9 Jun 2012 21:52:36 +0200 (CEST)
Received: from reverse.completel.net (reverse.completel.net [92.103.38.66])
 by webmail.minatec.grenoble-inp.fr (Horde Framework) with HTTP; Sat, 09 Jun
 2012 21:52:36 +0200
In-Reply-To: <1339267502-13803-1-git-send-email-Javier.Roucher-Iglesias@ensimag.imag.fr>
User-Agent: Internet Messaging Program (IMP) H4 (5.0.17)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199555>


Javier.Roucher-Iglesias@ensimag.imag.fr a =E9crit=A0:

> +git-credential - Providing and strore user credentials to git

s/Providing/Provides/ & s/strore/store

> +-If git-credential system have the password already stored
> +git-credential will answer with by STDOUT:

s/have/has/

> +Then if the password is correct, (note: is not git credential
> +how decides if password is correct or not. Is the external system
> +that have to authenticate the user) it can be stored using command
> +'git crendential approve' by providing the structure, by STDIN.

Wouldn't the note be "it's not git credential that decides if the passw=
ord is
correct or not. That part is done by the external system" ?

> +1. The 'git credential fill' makes the structure,
> +with this structure it will be able to save your
> +credentials, and if the credential is allready stored,
> +it will fill the password.

s/allready/already/

> +void cmd_credential (int argc, char **argv, const char *prefix){
> +	const char *op;
> +	struct credential c =3D CREDENTIAL_INIT;
> +	int i;
> +
> +	op =3D argv[1];
> +	if (!op)
> +		usage(usage_msg);
> +
> +	for (i =3D 2; i < argc; i++)
> +		string_list_append(&c.helpers, argv[i]);
> +
> +	if (credential_read(&c, stdin) < 0)
> +		die("unable to read credential from stdin");
> +
> +	if (!strcmp(op, "fill")) {
> +		credential_fill(&c);
> +		if (c.username)
> +			printf("username=3D%s\n", c.username);
> +		if (c.password)
> +			printf("password=3D%s\n", c.password);
> +	}
> +	else if (!strcmp(op, "approve")) {
> +		credential_approve(&c);
> +	}
> +	else if (!strcmp(op, "reject")) {
> +		credential_reject(&c);
> +	}
> +	else
> +		usage(usage_msg);

Braces for the last "else" part. In general, the structure should be

       if (...) {
                /*code*/
       } else if (...) {
                /*code*/
       } else {
                /*code*/
       }

If juste one block needs brances, all the other "else if"/"else" part
need it too.

BTW, please be aware of the white spaces (here mostly in the doc) :).

Lucien Kong.

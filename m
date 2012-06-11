From: roucherj <roucherj@telesun.imag.fr>
Subject: Re: [PATCH v3] add 'git credential' plumbing command
Date: Mon, 11 Jun 2012 21:14:00 +0200
Message-ID: <0425823888ed7e40d9332e148ac9e77a@telesun.imag.fr>
References: <1339440294-8010-1-git-send-email-Javier.Roucher-Iglesias@ensimag.imag.fr>
 <20120611210745.Horde.72y3YnwdC4BP1kIBup3BWrA@webmail.minatec.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <Javier.Roucher-Iglesias@ensimag.imag.fr>, <git@vger.kernel.org>,
	Javier Roucher <jroucher@gmail.com>,
	Pavel Volek <Pavel.Volek@ensimag.imag.fr>,
	NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>,
	ROUCHER IGLESIAS Javier <roucherj@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: <konglu@minatec.inpg.fr>
X-From: git-owner@vger.kernel.org Mon Jun 11 21:14:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeA4O-0001xs-8s
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 21:14:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751004Ab2FKTOO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Jun 2012 15:14:14 -0400
Received: from mx2.imag.fr ([129.88.30.17]:47276 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751009Ab2FKTOK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 15:14:10 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q5BJ4tnK000972
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 11 Jun 2012 21:04:55 +0200
Received: from web-ensimag.imag.fr (web-ensimag [195.221.228.24])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id q5BJE0nR015426;
	Mon, 11 Jun 2012 21:14:00 +0200
Received: from web-ensimag.imag.fr (localhost [127.0.0.1])
	by web-ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens) with ESMTP id q5BJE0Ck017116;
	Mon, 11 Jun 2012 21:14:00 +0200
Received: (from apache@localhost)
	by web-ensimag.imag.fr (8.13.8/8.13.8/Submit) id q5BJE04I017115;
	Mon, 11 Jun 2012 21:14:00 +0200
X-Authentication-Warning: web-ensimag.imag.fr: apache set sender to roucherj@telesun.imag.fr using -f
In-Reply-To: <20120611210745.Horde.72y3YnwdC4BP1kIBup3BWrA@webmail.minatec.grenoble-inp.fr>
X-Sender: roucherj@telesun.imag.fr
User-Agent: Roundcube Webmail/0.5.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 11 Jun 2012 21:04:56 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5BJ4tnK000972
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: roucherj@telesun.imag.fr
MailScanner-NULL-Check: 1340046299.20778@pkQWP0g4t/BqMICHqcQe6w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199709>

On Mon, 11 Jun 2012 21:07:45 +0200, konglu@minatec.inpg.fr wrote:
> Javier.Roucher-Iglesias@ensimag.imag.fr a =C3=A9crit=C2=A0:
>
>> +Git-credential permits to the user of the script to save:
>> +username, password, host, path and protocol. When the user of=20
>> script
>> +invoke git-credential, the script can ask for a password, using the=
=20
>> command
>> +'git credential fill'.
>> +Taking data from the standard input, the program treats each line=20
>> as a
>> +separate data item, and the end of series of data item is signalled=
=20
>> by a
>> +blank line.
>> +
>> +		username=3Dadmin\n
>> +		protocol=3D[http|https]\n
>> +		host=3Dlocalhost\n
>> +		path=3D/dir\n\n
>> +
>> +-If git-credential system has the password already stored
>> +git-credential will answer with by STDOUT:
>> +
>> +		username=3Dadmin
>> +		password=3D*****
>> +
>> +-If it is not stored, the user will be prompt for a password:
>> +
>> +		> Password for '[http|https]admin@localhost':
>
> Whitespaces detected (and also some more after in the doc)
>
>> diff --git a/builtin/credential.c b/builtin/credential.c
>> new file mode 100644
>> index 0000000..a6b6962
>> --- /dev/null
>> +++ b/builtin/credential.c
>> @@ -0,0 +1,37 @@
>> +#include <stdio.h>
>> +#include "cache.h"
>> +#include "credential.h"
>> +#include "string-list.h"
>> +
>> +static const char usage_msg[] =3D
>> +"credential <fill|approve|reject>";
>> +
>> +void cmd_credential (int argc, char **argv, const char *prefix) {
>> +	const char *op;
>> +	struct credential c =3D CREDENTIAL_INIT;
>> +	int i;
>> +
>> +	op =3D argv[1];
>> +	if (!op)
>> +		usage(usage_msg);
>> +
>> +	if (credential_read(&c, stdin) < 0)
>> +		die("unable to read credential from stdin");
>> +
>> +	if (!strcmp(op, "fill")) {
>> +		credential_fill(&c);
>> +		if (c.username)
>> +			printf("username=3D%s\n", c.username);
>> +		if (c.password)
>> +			printf("password=3D%s\n", c.password);
>> +	}
>> +	else if (!strcmp(op, "approve")) {
>> +		credential_approve(&c);
>> +	}
>> +	else if (!strcmp(op, "reject")) {
>> +		credential_reject(&c);
>> +	}
>> +	else {
>> +		usage(usage_msg);
>> +	}
>> +}
>
> Structure:
>
> if (!strcmp(op, "fill")) {
> 	credential_fill(&c);
> 	if (c.username)
> 		printf("username=3D%s\n", c.username);
> 	if (c.password)
> 		printf("password=3D%s\n", c.password);
> } else if (!strcmp(op, "approve")) {
> 	credential_approve(&c);
> } else if (!strcmp(op, "reject")) {
> 	credential_reject(&c);
> } else {
> 	usage(usage_msg);
> }


I will change the structure, thanks.

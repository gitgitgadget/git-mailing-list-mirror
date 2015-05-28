From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH/RFC] create a skeleton for the command git rebase --status
Date: Thu, 28 May 2015 14:36:30 +0200
Message-ID: <vpq382gri9d.fsf@anie.imag.fr>
References: <1432814891-4717-1-git-send-email-guillaume.pages@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
To: Guillaume =?iso-8859-1?Q?Pag=E8s?= 
	<guillaume.pages@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu May 28 14:36:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yxx3B-0004FG-2Z
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 14:36:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753693AbbE1Mgg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 May 2015 08:36:36 -0400
Received: from mx2.imag.fr ([129.88.30.17]:55428 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753357AbbE1Mgg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2015 08:36:36 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t4SCaSLI023573
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 28 May 2015 14:36:28 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t4SCaUhg009094;
	Thu, 28 May 2015 14:36:30 +0200
In-Reply-To: <1432814891-4717-1-git-send-email-guillaume.pages@ensimag.grenoble-inp.fr>
	("Guillaume \=\?iso-8859-1\?Q\?Pag\=E8s\=22's\?\= message of "Thu, 28 May 2015
 14:08:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 28 May 2015 14:36:29 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t4SCaSLI023573
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1433421391.01668@2ld4uaxeG8gLywCAnoLJHg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270145>

Guillaume Pag=E8s <guillaume.pages@ensimag.grenoble-inp.fr> writes:

> It is an almost empty code I send to validate the global architecture
> of this command.  I choose to write

Avoid personal wording (I choose to write ... because -> The code is
written ... because). What matters in the commit message is the reason
for the choice, not who made it.

> +BUILTIN_OBJS +=3D builtin/rebase--status--helper.o

No builtin/rebase--status--helper.c in your patch, is it intended?

> +status)
> +	git rebase--status--helper
> +	die

"die" is used to exit with an error code ($? !=3D 0). You just mean exi=
t
$? here, to exit with the same code as the helper.

And actually, you don't need to keep your script alive while the helper
is ran, so you can write

exec git rebase--status--helper

> --- /dev/null
> +++ b/rebase--status.c
> @@ -0,0 +1,6 @@
> +#include "rebase--status.h"
> +
> +int rebase_status(){
> +	printf("Rebase in progress\n");

=2E.. or not.

Avoid leaving incorrect things like this in intermediate steps, even if
you're going to fix them eventually. It's too easy to forget the actual
fix and leave a "Rebase in progress" message even when there's no rebas=
e
in progress. And reviewers may get confused.

I'd have written stg like

	printf("git rebase --status is not yet implemented");

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/

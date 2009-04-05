From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: Running 'git pull' from an unnamed branch
Date: Mon, 6 Apr 2009 00:28:03 +0200
Message-ID: <200904060028.03542.markus.heidelberg@web.de>
References: <3f4fd2640904051433u199587c3wc9bf080d138944e7@mail.gmail.com> <200904052342.44856.markus.heidelberg@web.de> <3f4fd2640904051515x797e10b5ia20543f207084a60@mail.gmail.com>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Reece Dunn <msclrhd@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Apr 06 00:29:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqaqJ-0002GO-DD
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 00:29:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753820AbZDEW17 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Apr 2009 18:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753817AbZDEW17
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 18:27:59 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:47669 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753704AbZDEW16 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Apr 2009 18:27:58 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate03.web.de (Postfix) with ESMTP id 4A6F7FA0226D;
	Mon,  6 Apr 2009 00:27:56 +0200 (CEST)
Received: from [89.59.118.104] (helo=.)
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1Lqaom-0003r5-00; Mon, 06 Apr 2009 00:27:56 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <3f4fd2640904051515x797e10b5ia20543f207084a60@mail.gmail.com>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1+2cUa7rRdL4sg37bRJMG8wrlOou/uN8r7ibqBb
	UE+HYg3cAqoxZ+jPV/0TH6nJ58cHdK4a2iyjNf++mhBs/2yt8m
	YLA0JDxUSpnPZl1mctsQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115728>

Reece Dunn, 06.04.2009:
> 2009/4/5 Markus Heidelberg <markus.heidelberg@web.de>:
> > Reece Dunn, 05.04.2009:
> >> + =A0 =A0 echo "You may not be on a branch. In this case, you need=
 to move"
> >> + =A0 =A0 echo "onto the branch you want to pull to (usually maste=
r):"
> >> + =A0 =A0 echo " =A0 =A0git checkout <branch>"
> >> + =A0 =A0 echo
> >
> > Not being on a branch is not the general case when you receive this
> > message. Maybe determining if you are not on a branch and adjusting=
 the
> > message acordingly is an option.
>=20
> So, something like:

>  git-pull.sh |   40 +++++++++++++++++++++++-----------------
>  1 files changed, 23 insertions(+), 17 deletions(-)
>=20
> diff --git a/git-pull.sh b/git-pull.sh
> index 8a26763..f263c04 100755
> --- a/git-pull.sh
> +++ b/git-pull.sh
> @@ -90,23 +90,29 @@ error_on_no_merge_candidates () {
>=20
>  	curr_branch=3D${curr_branch#refs/heads/}
>=20
> -	echo "You asked me to pull without telling me which branch you"
> -	echo "want to merge with, and 'branch.${curr_branch}.merge' in"
> -	echo "your configuration file does not tell me either.  Please"
> -	echo "name which branch you want to merge on the command line and"
> -	echo "try again (e.g. 'git pull <repository> <refspec>')."
> -	echo "See git-pull(1) for details on the refspec."
> -	echo
> -	echo "If you often merge with the same branch, you may want to"
> -	echo "configure the following variables in your configuration"
> -	echo "file:"
> -	echo
> -	echo "    branch.${curr_branch}.remote =3D <nickname>"
> -	echo "    branch.${curr_branch}.merge =3D <remote-ref>"
> -	echo "    remote.<nickname>.url =3D <url>"
> -	echo "    remote.<nickname>.fetch =3D <refspec>"
> -	echo
> -	echo "See git-config(1) for details."
> +	if [ -n "$curr_branch" ]; then
> +		echo "You asked me to pull without telling me which branch you"
> +		echo "want to merge with, and 'branch.${curr_branch}.merge' in"
> +		echo "your configuration file does not tell me either.  Please"
> +		echo "name which branch you want to merge on the command line"
> +		echo "and try again (e.g. 'git pull <repository> <refspec>')."
> +		echo "See git-pull(1) for details on the refspec."
> +		echo
> +		echo "If you often merge with the same branch, you may want to"
> +		echo "configure the following variables in your configuration"
> +		echo "file:"
> +		echo
> +		echo "    branch.${curr_branch}.remote =3D <nickname>"
> +		echo "    branch.${curr_branch}.merge =3D <remote-ref>"
> +		echo "    remote.<nickname>.url =3D <url>"
> +		echo "    remote.<nickname>.fetch =3D <refspec>"
> +		echo
> +		echo "See git-config(1) for details."
> +	else
> +		echo "You may not be on a branch. In this case, you need to"
> +		echo "move to the branch you want to pull to (usually master):"
> +		echo "    git checkout <branch>"
> +	fi
>  	exit 1
>  }
>=20

Yes, on something like this I thought, but the proposed solution is not
the right thing to do, see the response from Bj=F6rn.

Maybe something like "You are not on a branch, so there cannot be a
configuration for git-pull. You have to explicitly tell the repository
and refspec." or so.

Markus

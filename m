From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] difftool/mergetool: make the form of yes/no questions
 consistent
Date: Tue, 12 Apr 2016 14:27:37 +0100
Message-ID: <20160412132737.GB11013@serenity.lan>
References: <1460465982.3214.7.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Nikola Forrrr <nforro@redhat.com>
X-From: git-owner@vger.kernel.org Tue Apr 12 15:27:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apyME-0004a0-Ai
	for gcvg-git-2@plane.gmane.org; Tue, 12 Apr 2016 15:27:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964868AbcDLN1u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Apr 2016 09:27:50 -0400
Received: from mta02.prd.rdg.aluminati.org ([94.76.243.215]:60935 "EHLO
	mta02.prd.rdg.aluminati.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933871AbcDLN1t (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Apr 2016 09:27:49 -0400
Received: from mta02.prd.rdg.aluminati.org (localhost [127.0.0.1])
	by mta.aluminati.local (Postfix) with ESMTP id B829E230A5;
	Tue, 12 Apr 2016 14:27:47 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by mta02.prd.rdg.aluminati.org (Postfix) with ESMTP id B22133425;
	Tue, 12 Apr 2016 14:27:47 +0100 (BST)
X-Quarantine-ID: <HWrDpwiKpzFv>
X-Virus-Scanned: Debian amavisd-new at mta02.prd.rdg.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.249
X-Spam-Level: 
X-Spam-Status: No, score=-0.249 tagged_above=-9999 required=5
	tests=[ALL_TRUSTED=-1, KAM_INFOUSMEBIZ=0.75, URIBL_BLOCKED=0.001]
	autolearn=no autolearn_force=no
Received: from mta.aluminati.local ([127.0.0.1])
	by localhost (mta02.prd.rdg.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id HWrDpwiKpzFv; Tue, 12 Apr 2016 14:27:41 +0100 (BST)
Received: from serenity.lan (unknown [10.2.0.10])
	by mta02.prd.rdg.aluminati.org (Postfix) with ESMTPSA id C688834E2;
	Tue, 12 Apr 2016 14:27:38 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <1460465982.3214.7.camel@redhat.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291260>

On Tue, Apr 12, 2016 at 02:59:42PM +0200, Nikola Forrrr wrote:
> Every yes/no question in difftool/mergetool scripts has slightly
> different form, and none of them is consistent with the form git
> itself uses.
>=20
> Make the form of all the questions consistent with the form used
> by git, i.e. "Question [y/n]? ".
>=20
> Signed-off-by: Nikola Forr=F3 <nforro@redhat.com>
> ---
>  git-difftool--helper.sh | 4 ++--
>  git-mergetool--lib.sh   | 2 +-
>  git-mergetool.sh        | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/git-difftool--helper.sh b/git-difftool--helper.sh
> index 2b11b1d..84d6cc0 100755
> --- a/git-difftool--helper.sh
> +++ b/git-difftool--helper.sh
> @@ -44,10 +44,10 @@ launch_merge_tool () {
>  			"$GIT_DIFF_PATH_TOTAL" "$MERGED"
>  		if use_ext_cmd
>  		then
> -			printf "Launch '%s' [Y/n]: " \
> +			printf "Launch '%s' [Y/n]? " \
>  				"$GIT_DIFFTOOL_EXTCMD"
>  		else
> -			printf "Launch '%s' [Y/n]: " "$merge_tool"
> +			printf "Launch '%s' [Y/n]? " "$merge_tool"

I think the case in these two is correct as-is.  The "Y" is capitalised
because it is the default and will take effect if the user just presses
ENTER.

=46rom a quick look, the two cases below do not have this behaviour (th=
e
user must enter either "y" or "n"), so it is correct that they are not
capitalized.

The change from ":" to "?" and normalization of "?" placement below
seems reasonable.

>  		fi
>  		read ans || return
>  		if test "$ans" =3D n
> diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> index 54ac8e4..92adcc0 100644
> --- a/git-mergetool--lib.sh
> +++ b/git-mergetool--lib.sh
> @@ -100,7 +100,7 @@ check_unchanged () {
>  		while true
>  		do
>  			echo "$MERGED seems unchanged."
> -			printf "Was the merge successful? [y/n] "
> +			printf "Was the merge successful [y/n]? "
>  			read answer || return 1
>  			case "$answer" in
>  			y*|Y*) return 0 ;;
> diff --git a/git-mergetool.sh b/git-mergetool.sh
> index 9f77e3a..2e0635a 100755
> --- a/git-mergetool.sh
> +++ b/git-mergetool.sh
> @@ -396,7 +396,7 @@ done
>  prompt_after_failed_merge () {
>  	while true
>  	do
> -		printf "Continue merging other unresolved paths (y/n) ? "
> +		printf "Continue merging other unresolved paths [y/n]? "
>  		read ans || return 1
>  		case "$ans" in
>  		[yY]*)
> --=20
> 2.4.11

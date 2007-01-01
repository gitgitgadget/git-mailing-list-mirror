From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] Documentation: update git-pull.txt for clone's new default behavior
Date: Mon, 1 Jan 2007 15:59:44 -0800 (PST)
Message-ID: <535252.4420.qm@web31811.mail.mud.yahoo.com>
References: <20070101213906.GA23857@fieldses.org>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>,
	Luben Tuikov <ltuikov@yahoo.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 02 00:59:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1X4G-0004XE-US
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 00:59:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932566AbXAAX7p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 Jan 2007 18:59:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754700AbXAAX7p
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jan 2007 18:59:45 -0500
Received: from web31811.mail.mud.yahoo.com ([68.142.207.74]:46366 "HELO
	web31811.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754695AbXAAX7p (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Jan 2007 18:59:45 -0500
Received: (qmail 4946 invoked by uid 60001); 1 Jan 2007 23:59:44 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=nlWVCcFA6gs6KjQho6F1B3iViLlMaM4AZi7b8DIunqHo/vv4P+UDclm4OefM2abl2Sm+2zUXv9PzOs1HKIJw9DBRZKbbB3SVfnUJvfyzNpoWAS0fnxlOpXBWc4yxL5iQ8wFhLO6qRgtGgCHsxFscB5wOfwzPFVjtpWlDKGrvjiM=;
X-YMail-OSG: mqGbuEMVM1l8RnlDIXLa6T0E1A9Yuad5_DMStJwHKpWqzes23QeQ5VzJTBLrVYur3w--
Received: from [71.84.31.238] by web31811.mail.mud.yahoo.com via HTTP; Mon, 01 Jan 2007 15:59:44 PST
To: "J. Bruce Fields" <bfields@fieldses.org>,
	Junio C Hamano <junkio@cox.net>
In-Reply-To: <20070101213906.GA23857@fieldses.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35748>

--- "J. Bruce Fields" <bfields@fieldses.org> wrote:
> On Sun, Dec 31, 2006 at 05:44:37PM -0800, Junio C Hamano wrote:
> > How about doing this?  The difference this time around is that
> > if you have non-wildcard refspec listed first, which usually
> > is the case for people with established git workflow with
> > existing repositories, we use the old-and-proven rule to
> > merge the first set of refs.  An earlier round botched this
> > completely by basing the logic on lack of branch.*.merge,
> > which broke for many people.
> 
> Updated man page assuming that change; does this look any better?
> 
> --b.
> 
> [PATCH] Documentation: update git-pull.txt for new clone behavior
> 
> Update examples, stop using branch named "origin" as an example.
> Remove large example of use of remotes; that particular case is
> nicely automated by default, so it's not so pressing to explain, and
> we can refer to git-repo-config for the details.
> 
> Signed-off-by: "J. Bruce Fields" <bfields@citi.umich.edu>
> ---
>  Documentation/git-pull.txt |   69 ++++++++++++++++----------------------------
>  1 files changed, 25 insertions(+), 44 deletions(-)
> 
> diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
> index 2a5aea7..13be992 100644
> --- a/Documentation/git-pull.txt
> +++ b/Documentation/git-pull.txt
> @@ -37,17 +37,27 @@ EXAMPLES
>  --------
>  
>  git pull, git pull origin::
> -	Fetch the default head from the repository you cloned
> -	from and merge it into your current branch.
> -
> -git pull -s ours . obsolete::
> -	Merge local branch `obsolete` into the current branch,
> -	using `ours` merge strategy.
> +	Update the remote-tracking branches for the repository
> +	you cloned from, then merge one of them into your
> +	current branch.  Normally the branch merged in is
> +	the HEAD of the remote repository, but the choice is
> +	determined by the branch.<name>.remote and
> +	branch.<name>.merge options; see gitlink:git-repo-config[1]
> +	for details.
> +
> +git pull origin next::

No.

> +	Merge into the current branch the remote branch `next`;

So, "origin" now means "current branch".

NACK!

   Luben


> +	leaves a copy of `next` temporarily in FETCH_HEAD, but
> +	does not update any remote-tracking branches.
>  
>  git pull . fixes enhancements::
>  	Bundle local branch `fixes` and `enhancements` on top of
>  	the current branch, making an Octopus merge.
>  
> +git pull -s ours . obsolete::
> +	Merge local branch `obsolete` into the current branch,
> +	using `ours` merge strategy.
> +
>  git pull --no-commit . maint::
>  	Merge local branch `maint` into the current branch, but
>  	do not make a commit automatically.  This can be used
> @@ -61,48 +71,19 @@ release/version name would be acceptable.
>  Command line pull of multiple branches from one repository::
>  +
>  ------------------------------------------------
> -$ cat .git/remotes/origin
> -URL: git://git.kernel.org/pub/scm/git/git.git
> -Pull: master:origin
> -
>  $ git checkout master
> -$ git fetch origin master:origin +pu:pu maint:maint
> -$ git pull . origin
> +$ git fetch origin +pu:pu maint:tmp
> +$ git pull . tmp
>  ------------------------------------------------
>  +
> -Here, a typical `.git/remotes/origin` file from a
> -`git-clone` operation is used in combination with
> -command line options to `git-fetch` to first update
> -multiple branches of the local repository and then
> -to merge the remote `origin` branch into the local
> -`master` branch.  The local `pu` branch is updated
> -even if it does not result in a fast forward update.
> -Here, the pull can obtain its objects from the local
> -repository using `.`, as the previous `git-fetch` is
> -known to have already obtained and made available
> -all the necessary objects.
> -
> -
> -Pull of multiple branches from one repository using `.git/remotes` file::
> +This updates (or creates, as necessary) branches `pu` and `tmp`
> +in the local repository by fetching from the branches
> +(respectively) `pu` and `maint` from the remote repository.
>  +
> -------------------------------------------------
> -$ cat .git/remotes/origin
> -URL: git://git.kernel.org/pub/scm/git/git.git
> -Pull: master:origin
> -Pull: +pu:pu
> -Pull: maint:maint
> -
> -$ git checkout master
> -$ git pull origin
> -------------------------------------------------
> +The `pu` branch will be updated even if it is does not
> +fast-forward; the others will not be.
>  +
> -Here, a typical `.git/remotes/origin` file from a
> -`git-clone` operation has been hand-modified to include
> -the branch-mapping of additional remote and local
> -heads directly.  A single `git-pull` operation while
> -in the `master` branch will fetch multiple heads and
> -merge the remote `origin` head into the current,
> -local `master` branch.
> +The final command then merges the newly fetched `tmp` into master.
>  
>  
>  If you tried a pull which resulted in a complex conflicts and
> @@ -112,7 +93,7 @@ gitlink:git-reset[1].
>  
>  SEE ALSO
>  --------
> -gitlink:git-fetch[1], gitlink:git-merge[1]
> +gitlink:git-fetch[1], gitlink:git-merge[1], gitlink:git-repo-config[1]
>  
>  
>  Author
> -- 
> 1.5.0.rc0.gac28
> 
> 

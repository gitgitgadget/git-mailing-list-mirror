From: Bradley Wagner <bradley.wagner@hannonhill.com>
Subject: Re: git pull question
Date: Sun, 25 Jul 2010 23:43:31 -0400
Message-ID: <AANLkTi=wXGBMUekUhtHS1KCOhjgac3ET8rmSCwUPHzQ3@mail.gmail.com>
References: <AANLkTimHg2wtNj2BmJKJfoisoqNEExC=jNU5wB95Bsre@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: geoffrey.russell@gmail.com
X-From: git-owner@vger.kernel.org Mon Jul 26 05:43:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdEbJ-0003ce-N9
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 05:43:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753419Ab0GZDnc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Jul 2010 23:43:32 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:43013 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753404Ab0GZDnc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Jul 2010 23:43:32 -0400
Received: by qyk8 with SMTP id 8so1617792qyk.19
        for <git@vger.kernel.org>; Sun, 25 Jul 2010 20:43:31 -0700 (PDT)
Received: by 10.224.95.222 with SMTP id e30mr5416446qan.237.1280115811461; 
	Sun, 25 Jul 2010 20:43:31 -0700 (PDT)
Received: by 10.229.184.204 with HTTP; Sun, 25 Jul 2010 20:43:31 -0700 (PDT)
In-Reply-To: <AANLkTimHg2wtNj2BmJKJfoisoqNEExC=jNU5wB95Bsre@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151802>

> Hi,
>
> Assuming I already have a branch called brA
>
> $ git checkout master
> $ git pull origin refs/heads/brA:brA
>
> The pull here seems to update both the current branch as well as brA?
> Is this intentional?

I believe this is intentional.

A git pull always pulls into (at least) the currently checked out
branch, in your case "master". By adding the <dst> param after the
colon in the <refspec> you're saying to go ahead and fast-forward
merge the local branch called "brA" if possible.

This is almost equivalent to saying:

git checkout brA
git pull origin brA
git checkout master
git pull origin brA

assuming everything can be fast-forward merged.

Read the the portion of git-pull man entry regarding the <refspec> for
a more thorough explanation:
http://www.kernel.org/pub/software/scm/git/docs/git-pull.html

However, I'm not entirely clear myself on the meaning of this note in
the documentation:

Note
You never do your own development on branches that appear on the right
hand side of a <refspec> colon on Pull: lines; they are to be updated
by git fetch. If you intend to do development derived from a remote
branch B, have a Pull: line to track it (i.e.  Pull: B:remote-B), and
have a separate branch my-B to do your development on top of it. The
latter is created by git branch my-B remote-B (or its equivalent git
checkout -b my-B remote-B). Run git fetch to keep track of the
progress of the remote side, and when you see something new on the
remote branch, merge it into your development branch with git pull .
remote-B, while you are on my-B branch.

>
> Cheers,
> Geoff.
>
> PS. git is at 1.6.2.3
>
> --
> 6 Fifth Ave,
> St Morris, S.A. 5068
> Australia
> Ph: 041 8805 184 / 08 8332 5069
> http://perfidy.com.au
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html

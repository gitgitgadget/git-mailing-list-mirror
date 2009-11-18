From: Jason Sewall <jasonsewall@gmail.com>
Subject: Re: Hey - A Conceptual Simplication....
Date: Wed, 18 Nov 2009 08:31:42 -0500
Message-ID: <31e9dd080911180531r1f693d7bi3d9408ef8219cce0@mail.gmail.com>
References: <005a01ca684e$71a1d710$54e58530$@com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, torvalds@osdl.org
To: George Dennie <gdennie@pospeople.com>
X-From: git-owner@vger.kernel.org Wed Nov 18 14:31:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAkdS-0005sA-Pa
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 14:31:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757030AbZKRNbi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Nov 2009 08:31:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757026AbZKRNbi
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Nov 2009 08:31:38 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:20566 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757022AbZKRNbh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Nov 2009 08:31:37 -0500
Received: by fg-out-1718.google.com with SMTP id d23so2231946fga.1
        for <git@vger.kernel.org>; Wed, 18 Nov 2009 05:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=txhL2abyBdyb1EbOqkkBy5yfObNOCkZlF5m0yDcshk0=;
        b=uJ/7PLkxhhf90Ar5pg4gwEYbzKcAuwfGCvf9GRYP5zh+JM4Bd4QzOuchZjjcDbJ0ON
         e0Ex6GkaHYxv6mzr+y5J5C/486O0Ss4U8dZwkiU8c2eRpLsOIVO8vtcIyiSah+12L2ba
         425kEmm5KAcLl59HHvHeuX/lCW1iArflkrqMc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=txKssnCpBgystXFrpDg3E1NIbhUyovlN9KkL6/y6Zpe2I7yDaOqL/B8kydadv0PgZo
         EKCSQN2d4XkjtJQqv3wp+PYK+s+Kjzuq3lTouQyckS6Xk0HY91e6SQbwPggTcqjCFJ1v
         F3kUwhvsVoWe1lab6R1YlDrgrAwlfBnqErwvw=
Received: by 10.216.89.129 with SMTP id c1mr319975wef.35.1258551102810; Wed, 
	18 Nov 2009 05:31:42 -0800 (PST)
In-Reply-To: <005a01ca684e$71a1d710$54e58530$@com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133171>

On Wed, Nov 18, 2009 at 7:55 AM, George Dennie <gdennie@pospeople.com> =
wrote:
>
> In particular, why is Git not treating the entire working tree as the
> versioned document (qualified of course by the .gitignore file).
>
> Instead, Git is treating a manually maintained list of files within t=
he
> working tree as the versioned document, this list being initialized a=
nd
> manually amended by the "Git add/rm/mv" commands, etc.

Isn't fastidiously maintaining a .gitignore file to contain everything
you *don't* want in the project more confusing than explicitly
specifying things you *do* want in the project?

> The result is conceptual complexity and rather counter-intuitive beha=
vior.
> For example, adding and renaming files outside of Git is not consider=
ed
> editing the version until you subsequently do a "Git Add ." Contrast =
that
> with editing or deleting files outside of Git. Yet adding and renamin=
g files
> and folders is a significant part of substantive projects, especially=
 in the
> early stages and experimental branches.
>
> Granted, this is not a big deal functionally, but what is being lost =
is
> conceptual simplicity (and consistency, in my book) and conceptual
> simplicity is a key value point, if not THE key.

In fact, it's a big deal in functionality, but the utility is in being
able to to specify exactly what I want to be part of each commit. One
of git's great features is the ability to specify *exactly* what you
want to be part of each commit, down to the line. This means that each
commit can be extremely fine grained and represent specific bug fixes
and or features.

If you have a bunch of debugging code sitting around in your working
tree after you've tracked down a problem, you don't want to commit all
of those printfs, etc. - you want to commit the fix. This has
ramifications from making diffs of history cleaner to making git
bisect actually useful.

> Also can we augment checkout to totally CLEAN the working directory p=
rior to
> a restore. If necessary we can augment .gitignore to stipulate those =
files
> or folders that should be excluded from the cleaning. This suggestion=
 is in
> recognition of the fact that if you =C2=A0are not versioning the file=
, it is
> typically trash; which becomes the case when the entire working treat=
 is
> treated as the versioned document.

This is even worse. It's already pretty easy to trash your working
directory by reflexively typing git checkout -f, and you want to

> Consequently, I recommend the following new commands:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0"Git commit -x" =C2=A0 -- performs a "Git =
add ." then a "Git commit"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0"Git checkout -x" -- that clean the workin=
g tree prior to perform a
> checkout

I see that Jan has replied with some loaded guns, *ahem* aliases. Go
ahead and use them, but I recommend you look at the diffs in git.git
or some other repository that takes advantage of making commits as
compact as possible, and learn how to use git add -p.

Jason

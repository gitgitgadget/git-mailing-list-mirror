X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: svn versus git
Date: Thu, 14 Dec 2006 09:08:34 +0000
Message-ID: <200612140908.36952.andyparkins@gmail.com>
References: <200612132200.41420.andyparkins@gmail.com> <20061213225627.GC32568@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 14 Dec 2006 09:09:04 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=faGByvFnfRP3emxsoWd1T7E7D6T6G9JNxW+rX7yT6hWxO09fW0bDCSY8GvxDv2F3L4Mma8f3tvDlG5leaYp8O2wD96PMieoKxSQkcmI8Jx1zQTq9/NXDDUWCC9eOEDwUQvCukqkXMRgSggQcj/jevLi9zDQ2DgDvzimcLmUf+oE=
User-Agent: KMail/1.9.5
In-Reply-To: <20061213225627.GC32568@spearce.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34288>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GumaF-0004NU-Ve for gcvg-git@gmane.org; Thu, 14 Dec
 2006 10:08:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932105AbWLNJIo (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 04:08:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932107AbWLNJIo
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 04:08:44 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:19271 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S932105AbWLNJIm (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec
 2006 04:08:42 -0500
Received: by ug-out-1314.google.com with SMTP id 44so433424uga for
 <git@vger.kernel.org>; Thu, 14 Dec 2006 01:08:41 -0800 (PST)
Received: by 10.67.117.18 with SMTP id u18mr1052650ugm.1166087321060; Thu, 14
 Dec 2006 01:08:41 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id 29sm1778484uga.2006.12.14.01.08.40; Thu, 14 Dec 2006 01:08:40 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Wednesday 2006 December 13 22:56, Shawn Pearce wrote:

>   git cat-file -p $REV:$file
>
> not sure how much easier it gets than that.  Load in the bash
> completion from contrib/completion and you can even tab complete
> the $file part.

Yes.  I was a little unfair on that one; I forgot about the REV:file syntax.  
However, it's still not simple for a new user; I think I'd say "draw" if 
the "-p" weren't a requirement.

> Documentation flaw that the above wasn't clear?  Or is "-file" and
> "-p" the losing part for Git?

Yep.  Especially when combined with the fact that the command is called 
git-cat-file.  A new user could be forgiven for thinking that meant that they 
could cat one of their files held by git.  Also: they have to read a man page 
to find out that they need an option and which option is correct.  I reckon 
git-cat-object would be a better name ("no chance!", I hear you cry ;-))

I've just noticed as well that the documentation is wrong:
 $ git-cat-file HEAD:Makefile
 usage: git-cat-file [-t|-s|-e|-p|<type>] <sha1>
The square brackets indicate "optional", and those items clearly aren't.  I'll 
fix the documentation.

> > svn cleanup::
> > git fsck-objects::
> > git prune::
> > git repack::
> >
> > Subversion wins, as it only has one command and you don't need to
> > understand the repository in order to understand what its doing.
>
> True, but I'm not sure its fair to Git.  svn cleanup is also a
> technical command that one needs to learn either when something
> went wrong or later once the user has gotten used to using SVN.

My point is that a user can run "svn cleanup" without thinking, or needing to 
really know what it does.  Not so for git's maintenance commands.  Also, 
there are more commands.  I'm not saying they're not useful or necessary, but 
it's certainly more complicated than subversion.

For example: I used subversion for a long time - I don't think I ever had 
cause to run "cleanup", I'm not even really sure what it does.  I /have/ had 
cause to learn what git's maintenance commands do; which in turn meant I had 
to learn how the git repository works.  (I personally don't mind learning 
those things, but it's wrong to expect every user to do so).

> The last time I ran fsck-objects was when I was trying to debug
> that empty tree object missing in git-merge-recursive.  Usually I
> don't see repository corruption, and even there wasn't any.

Me too.  I've never run it in fact; but the command exists and therefore needs 
learning.

> or git merge now.  :-)

Hurrah!  However, at the time I wrote the comparison (and with 
1.4.4.1.g3ece-dirty I've got here) git-merge is still the old, more 
complicated, command line.

> This is one of Git's killer features over SVN.  Git does merges
> right.  SVN doesn't.  Though I keep hearing its on their TODO list.

Absolutely.  Although, even if SVN does implement it, it's going to be a hack.  
It'll just be an extra svn:special property set somewhere in the repository, 
or similar.  I can't see how they can do merges properly with the methodology 
that SVN uses.

> Some people like having the empty directory tracked by the VCS, as
> then the build system doesn't need to create it.  I perfer keeping

You're right; as it happens I'd prefer it if git could store empty 
directories.  However, in terms of "what I have to learn", git definitely 
wins this category because there is nothing to learn - make whatever 
directories you like; it will generally sort itself out.

> How is it unfriendly?  What specifically would you change to make
> it more friendly?

$ git-ls-tree v1.0.0
100644 blob 906e98492080d2fde9467a9970fc92d7a8cfeaf8    Makefile

I'm a newbie:  what's that number at the front?  What's a blob?  What's that 
great big number - I've only seen commit hashes that look like that, and that 
isn't one.  Definitely not friendly.

$ svn list -r 14
Makefile

It could probably be fixed by making git-ls-files capable of understanding 
tree-ish.

> >  - svn cleanup: git-fsck-objects, git-prune and git-repack all need too
> >    specific knowledge of git.
> >
> >    They also need running too often on the user's initiative.  It would
> >    be nice, for example, if git-reset, git-rebase and git-branch could
> >    detect when a prune is going to be needed and give the user a hint.
>
> You don't want to prune every time these happen.  When you start to

You are correct of course.  They don't need running regularly, and in a way 
that makes it worse.  How is a user who isn't familiar with git internals 
meant to know they should run git-prune?  How are they meant to know when 
they should run it?  How are they meant to know that it is git-reset, et al, 
that create conditions that need them to run git-prune?

> make use of the reflog pruning too often is a huge loss.  I actually
> maybe prune my active repositories once every couple of months,
> the extra garbage hanging out is usually peanuts.

Personally I like my repository pruned fairly often.  This makes it much 
easier to find the commit I need to restore when I've accidentally done a 
git-reset I didn't mean to.  If I had to search through three months worth of 
dead objects it would take me all day.  However, I don't think that affects a 
new user at all.  Recovery from disasters should be expected to be hard.

> As to the former it depends on your OS (Windows you want to pack
> more often) but git-count-objects gives you a good indication of how
> many loose objects exist.  git-fsck-objects probably only needs to
> be run if something is not working right and you suspect an object
> is missing.

Yep, /I/ know.  How is my imaginary new user meant to know?

My rhetorical questions are the key to making git friendly I think.  Each one 
represents a hole - it's not that there is no answer, it's that there 
shouldn't be a question.  The hard part (as always I suppose) is that we have 
to imagine a new user; this makes all my babblings above highly subjective.  
As such I won't be that upset if I'm told to "blow it out my ear".  Whatever 
that means.


Andy

-- 
Dr Andy Parkins, M Eng (hons), MIEE

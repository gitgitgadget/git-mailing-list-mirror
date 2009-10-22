From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Any way to "flatten" a series of changes in git
Date: Thu, 22 Oct 2009 23:57:14 +0200
Message-ID: <200910222357.15189.jnareb@gmail.com>
References: <26ae428a0910221303n493fb7s701269d694110685@mail.gmail.com> <m3hbtrdu1r.fsf@localhost.localdomain> <26ae428a0910221411l73aa7cbak5c060925ccdf4cea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Howard Miller <howard@e-learndesign.co.uk>
X-From: git-owner@vger.kernel.org Thu Oct 22 23:57:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N15ew-0005JY-Hg
	for gcvg-git-2@lo.gmane.org; Thu, 22 Oct 2009 23:57:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756480AbZJVV5Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2009 17:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755951AbZJVV5Q
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Oct 2009 17:57:16 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:5527 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751815AbZJVV5P convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Oct 2009 17:57:15 -0400
Received: by fg-out-1718.google.com with SMTP id 16so3782638fgg.1
        for <git@vger.kernel.org>; Thu, 22 Oct 2009 14:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=aAG8oQ8GQlUTnqUYTmcHFPvjfiNjEEufIgcEIwRicvw=;
        b=FpI5O0jHNqUAXyT/uy0Knk8CiwVL3kBwvTpOlzO7e22Vsygai0tgaUcqANFdDG49Hz
         0XfSiPPrtFwdJDEQaCllHECtuSdE8Dqd+WDgUeRvXz1+7fg8vMUR/YFPC0Mshb/HBhzY
         0dDs+mjhuXl9niAzeYy5F5w3TLu0m5oWARt8M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=FEnuuulS2QbMUXdFyNTd+nsf22J79+cg+XhbwLVRl3PKnSSlMjIzZwrnleheV/oo2s
         ZwadZyo3gHSqgynxMK8e/JRosxfR9L3Lso5+CBPVFMIMIxM7WwW69Qu9LgCKY9GSvL+F
         VRmPWolZr/c+9MLDcK1wP8wUoqYkcaWCHoPWY=
Received: by 10.86.227.1 with SMTP id z1mr5141079fgg.56.1256248639413;
        Thu, 22 Oct 2009 14:57:19 -0700 (PDT)
Received: from ?192.168.1.13? (abvi94.neoplus.adsl.tpnet.pl [83.8.206.94])
        by mx.google.com with ESMTPS id l12sm2104835fgb.22.2009.10.22.14.57.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 22 Oct 2009 14:57:18 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <26ae428a0910221411l73aa7cbak5c060925ccdf4cea@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131069>

On Thu, 22 Oct 2009, Howard Miller wrote:

> > You can use either "git merge --squash" or "git rebase --interactive"
> > (changing 'pick' to 'squash').
> >
> 
> Actually thinking some more.... I don't understand something about
> this. I don't actually want to merge or rebase with anything. I just
> want to say "make those commits a series of commits on a branch into
> just one commit with a new message". I seriously suspect I'm missing
> the point somewhere but what has that got to do with merging or
> rebasing?

Actually using "git merge --squash" is a bit different from using
"git rebase --interactive".


1. "git merge --squash"

>From documentation:

  --squash::
        Produce the working tree and index state as if a real
        merge happened (except for the merge information),
        but do not actually make a commit or
        move the `HEAD`, nor record `$GIT_DIR/MERGE_HEAD` to
        cause the next `git commit` command to create a merge
        commit.  This allows you to create a single commit on
        top of the current branch whose effect is the same as
        merging another branch (or more in case of an octopus).

This means for example if you did your changes on a separate 
topic branch, and you want to merge your changes into 'master'
branch, you would do

  $ git checkout master
  $ git merge side-branch

which would result in the following history:


   ---*---*---*---*---*---*---*---M         <-- master
       \                         /
        \-.---.---.---.---.---.-/           <-- side-branch


If you used '--squash' option to git-merge, because changes were
made in throwaway topic branch, and as you said only final result
matter, you would get:

  $ git checkout master
  $ git merge --squash side-branch

   ---*---*---*---*---*---*---*---M'        <-- master
       \                         
        \-.---.---.---.---.---.             <-- side-branch


where commit M' has the same contents (the same tree) as commit M
in previous example, but is not a merge commit.

If you simply want to squash last say 5 commits into one, you can
use "git merge --squash" for it in the following way:

  $ git reset --hard HEAD~5
  $ git merge --squash --no-ff HEAD@{1}

which means basically: rewind to state 5 commits back, then merge
in changes from before rewind, squashing them.  The --no-ff is needed
because otherwise it would be fast-forward and no commit would be
created.


2. "git rebase --interactive"

The interactive rebase is meant to edit commits being rebased, but
it can be used simply to edit commits.  It includes 'squash' command
that can be used to concatenate (squash) commits.

So to squash last say 5 commits into one, you would use

  $ git rebase --interactive HEAD~5

then edit provided list of commands and commits to read something like
this:

   pick deadbee The oneline of this commit
   squash fa1afe1 The oneline of the next commit
   ...
   squash beedead The oneline of the that commit

i.e. replace 'pick' command by 'squash' command.

This is a very powerfull command, and can be used for example to turn
series of say 5 commits into series of say 2 commits; not simply squashing
to a single commit, but reducing number of commits (and presumably
cleaning up those commits).


HTH (hope that helps)
-- 
Jakub Narebski
Poland

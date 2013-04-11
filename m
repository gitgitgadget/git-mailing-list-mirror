From: Luke Diamand <luke@diamand.org>
Subject: Re: git p4 submit failing
Date: Thu, 11 Apr 2013 21:19:42 +0100
Message-ID: <CAE5ih78rw1_oE2SFQFnfUSfRfDGRW0pVC7TL1qgxwdcOFbBdCw@mail.gmail.com>
References: <CAG4Fb8ejKCpUqZ+YVQT=S2-p6YcNo5+s81j2Jrx8q1ijtu8yqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Christopher Yee Mon <christopher.yeemon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 11 22:19:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQNyG-0003bX-9K
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 22:19:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752153Ab3DKUTn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 16:19:43 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:52728 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750731Ab3DKUTm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 16:19:42 -0400
Received: by mail-ob0-f178.google.com with SMTP id ni5so1728086obc.23
        for <git@vger.kernel.org>; Thu, 11 Apr 2013 13:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=7ETre98skvS34osbb9UixgaoKpI7QQK8pXo0CQaHM7w=;
        b=E+To+eELigoD3kIT7s5mphi76ldWH+qdlCR7E+1GfdNX6CU/tNohd7ojZ73YauSF7s
         mQnH0yNs5hjKBZTYRNu+YlAEBBKWv/3lDTvMN8vDfiGq3leMGa7pFdO9O4eEqcsqblwh
         mzp1xKw7sqK+EEd1/xXVlNuiMN4Ju+q/543AI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:x-gm-message-state;
        bh=7ETre98skvS34osbb9UixgaoKpI7QQK8pXo0CQaHM7w=;
        b=L0Dl7NpMW/JDin4tL2koXU5W9D0fnkZc+5cJYrgNjtVLSDsXASnvZNxKOc4RMSDTW5
         tSXWDa1+r1O4uH26aUqFVG5uveTOiF7iCDFBqbhIyLtI8qMoAwkeLR/nCk1LsFGGRjLS
         QCfjVlVWyoVMGhOZ6fNy+T5HJWPVBKP9Nfipx2YmYdNzrIohppd/QYgKueHB+CnQpYSx
         umvhpvcxUMITr4kNWmaNmut4g43k8/VXkRWfmET4z3ueCcKL+W7JkyxB2CNrS6O97enC
         2qNHkJXMc2tZGNsNI9n7Fv45tl5e1LHKqEAR4SIV0B779nsWbr3MjQ5od5YPJh4UmPPN
         JlMQ==
X-Received: by 10.60.101.163 with SMTP id fh3mr2904478oeb.95.1365711582303;
 Thu, 11 Apr 2013 13:19:42 -0700 (PDT)
Received: by 10.60.141.161 with HTTP; Thu, 11 Apr 2013 13:19:42 -0700 (PDT)
In-Reply-To: <CAG4Fb8ejKCpUqZ+YVQT=S2-p6YcNo5+s81j2Jrx8q1ijtu8yqw@mail.gmail.com>
X-Gm-Message-State: ALoCoQkRL/91aHtj56V9IChuXCEXXXcvCFUeEsxIsbloeiRBAX6iwT+PBT6gtqMwcmXGpkHR3dkE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220924>

Just a thought, but check the files that are failing to see if they've
got RCS keywords in them ($Id$, $File$, $Date$, etc). These cause all
sorts of nasty problems.

That's assuming it's definitely not a CRLF line ending problem on Windows.

On Thu, Apr 11, 2013 at 8:01 PM, Christopher Yee Mon
<christopher.yeemon@gmail.com> wrote:
> I tried running git p4 submit on a repo that I've been running as an
> interim bridge between git and perforce. Multiple people are using the
> repo as a remote and its being periodically submitted back to
> perforce.
>
> It's been working mostly fine. Then one day out of the blue I get this
> error. I can no longer push any git commits to perforce. (This is from
> the remote repo which I am pushing back to perforce)
>
> user@hostname:~/Source/code$ git p4 submit -M --export-labels
> Perforce checkout for depot path //depot/perforce/workspace/ located
> at /home/user/Source/git-p4-area/perforce/workspace/
> Synchronizing p4 checkout...
> ... - file(s) up-to-date.
> Applying ffa390f comments in config xml files
> //depot/perforce/workspace/sub/folder/structure/first.xml#3 - opened for edit
> //depot/perforce/workspace/sub/folder/structure/second.xml#3 - opened for edit
> //depot/perforce/workspace/sub/folder/structure/third.xml#3 - opened for edit
> //depot/perforce/workspace/sub/folder/structure/forth.xml#3 - opened for edit
> //depot/perforce/workspace/sub/folder/structure/fifth.xml#1 - opened for edit
> error: patch failed: sub/folder/structure/first.xml:1
> error: sub/folder/structure/first.xml: patch does not apply
> error: patch failed: sub/folder/structure/second.xml:1
> error: sub/folder/structure/second.xml: patch does not apply
> error: patch failed: sub/folder/structure/third.xml:1
> error: sub/folder/structure/third.xml: patch does not apply
> error: patch failed: sub/folder/structure/forth.xml:1
> error: sub/folder/structure/forth.xml: patch does not apply
> error: patch failed: sub/folder/structure/fifth.xml:1
> error: sub/folder/structure/fifth.xml: patch does not apply
> Unfortunately applying the change failed!
> //depot/perforce/workspace/sub/folder/structure/first.xml#1 - was edit, reverted
> //depot/perforce/workspace/sub/folder/structure/second.xml#3 - was
> edit, reverted
> //depot/perforce/workspace/sub/folder/structure/third.xml#3 - was edit, reverted
> //depot/perforce/workspace/sub/folder/structure/forth.xml#3 - was edit, reverted
> //depot/perforce/workspace/sub/folder/structure/fifth.xml#3 - was edit, reverted
> No commits applied.
>
> I thought it could be the .gitattributes setting that I had which was
> this at the time was this:
>
> * text eol=lf
>
> My global core.autocrlf setting was also false.
>
> So I remade a new remote repo, and changed core.autocrlf to input and
> changed .gitattributes to this
>
> * text=auto
>
> *.php text eol=lf
> *.pl text eol=lf
> *.pm text eol=lf
> *.sh text eol=lf
>
> *.vbs text eol=crlf
> *.bat text eol=crlf
> *.ps1 text eol=crlf
>
> *.bdb binary
> *.mtr binary
>
> Then I started to realize that it could just be the files in the
> initial commit that are suspect, because when i made edits to other
> files in the repo then tried to push them back with git p4 submit,
> those files submitted successfully  But the files in the commit where
> I initially got the failure still give me this problem.
>
> Here's what it looks like when I retested with a fresh git repo cloned
> from perforce with git p4 clone and tried to do the git p4 submit with
> verbose turned on on only one of the suspecting files
>
> user@hostname:/code$ git p4 submit -M --export-labels --verbose
> Reading pipe: git name-rev HEAD
> Reading pipe: ['git', 'config', 'git-p4.allowSubmit']
> Reading pipe: git rev-parse --symbolic --remotes
> Reading pipe: git rev-parse p4/master
> Reading pipe: git cat-file commit 0457c7589ea679dcc0c9114b34f8f30bc2ee08cf
> Reading pipe: git cat-file commit HEAD~0
> Reading pipe: git cat-file commit HEAD~1
> Reading pipe: ['git', 'config', 'git-p4.conflict']
> Origin branch is remotes/p4/master
> Reading pipe: ['git', 'config', '--bool', 'git-p4.useclientspec']
> Opening pipe: ['p4', '-G', 'where', '//depot/perforce/workspace/...']
> Perforce checkout for depot path //depot/perforce/workspace/ located
> at /home/user/Source/git-p4-area/perforce/workspace/
> Synchronizing p4 checkout...
> ... - file(s) up-to-date.
> Opening pipe: p4 -G opened ...
> Reading pipe: ['git', 'rev-list', '--no-merges', 'remotes/p4/master..master']
> Reading pipe: ['git', 'config', '--bool', 'git-p4.skipUserNameCheck']
> Reading pipe: ['git', 'config', 'git-p4.detectCopies']
> Reading pipe: ['git', 'config', '--bool', 'git-p4.detectCopiesHarder']
> Reading pipe: ['git', 'show', '-s', '--format=format:%h %s',
> 'ef3b95f5fec193fe2612b28e2e3b5e7f8ba9419e']
> Applying ef3b95f making test change
> Opening pipe: p4 -G users
> Reading pipe: ['git', 'log', '--max-count=1', '--format=%ae',
> 'ef3b95f5fec193fe2612b28e2e3b5e7f8ba9419e']
> Reading pipe: git diff-tree -r -M
> "ef3b95f5fec193fe2612b28e2e3b5e7f8ba9419e^"
> "ef3b95f5fec193fe2612b28e2e3b5e7f8ba9419e"
> //depot/perforce/workspace/sub/folder/structure/first.xml#3 - opened for edit
> <stdin>:17: trailing whitespace.
> <!-- comment line 1 -->
> <stdin>:18: trailing whitespace.
> <!-- comment line 2 -->
> <stdin>:19: trailing whitespace.
> <!-- comment line 3 -->
> error: patch failed: sub/folder/structure/first.xml:1
> error: sub/folder/structure/first.xml: patch does not apply
> Unfortunately applying the change failed!
> Reading pipe: ['git', 'config', '--bool', 'git-p4.attemptRCSCleanup']
> //depot/perforce/workspace/sub/folder/structure/first.xml#3 - was edit, reverted
> No commits applied.
> Reading pipe: ['git', 'config', '--bool', 'git-p4.exportLabels']
> Opening pipe: ['p4', '-G', 'labels', '//depot/ipstor.maple/automation/...']
> Reading pipe: ['git', 'tag']
> Reading pipe: ['git', 'config', 'git-p4.labelExportRegexp']
>
> In any case, I'm starting to think it could be a legitimate bug, which
> is why I am submitting it here. Does anyone have any ideas for
> suggestions on diagnosing what could be wrong?
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

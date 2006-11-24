X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de>
Subject: Re: [PATCH] config option core.showroot to enable showing the diff of the root commit
Date: Fri, 24 Nov 2006 08:53:56 +0100
Message-ID: <slrnemd98k.a3v.Peter.B.Baumann@xp.machine.xx>
References: <200611211341.48862.andyparkins@gmail.com> <8aa486160611210609h1c2d229ekf0b5e8aeb4f21f11@mail.gmail.com> <slrnem694k.4lm.Peter.B.Baumann@xp.machine.xx> <Pine.LNX.4.64.0611210820100.3338@woody.osdl.org> <20061121180643.GC7201@pasky.or.cz> <ejvfng$cj6$1@sea.gmane.org> <20061121182135.GD7201@pasky.or.cz> <7v64d8y4tu.fsf@assigned-by-dhcp.cox.net> <slrnemaqt1.esn.Peter.B.Baumann@xp.machine.xx> <7virh5khrc.fsf@assigned-by-dhcp.cox.net> <slrnemcc0b.ncc.Peter.B.Baumann@xp.machine.xx> <7vejrthf2y.fsf@assigned-by-dhcp.cox.net> <7vzmahfx6q.fsf@assigned-by-dhcp.cox.net>
NNTP-Posting-Date: Fri, 24 Nov 2006 07:54:44 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 100
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: mason.hofmann.stw.uni-erlangen.de
User-Agent: slrn/0.9.8.0 (Linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32192>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnVtQ-0005zK-IS for gcvg-git@gmane.org; Fri, 24 Nov
 2006 08:54:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934382AbWKXHyh (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 24 Nov 2006
 02:54:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757638AbWKXHyh
 (ORCPT <rfc822;git-outgoing>); Fri, 24 Nov 2006 02:54:37 -0500
Received: from main.gmane.org ([80.91.229.2]:21734 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1757634AbWKXHyg (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 24 Nov 2006 02:54:36 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GnVtI-0005xn-NG for git@vger.kernel.org; Fri, 24 Nov 2006 08:54:32 +0100
Received: from mason.hofmann.stw.uni-erlangen.de ([131.188.24.36]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Fri, 24 Nov 2006 08:54:32 +0100
Received: from Peter.B.Baumann by mason.hofmann.stw.uni-erlangen.de with
 local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>;
 Fri, 24 Nov 2006 08:54:32 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On 2006-11-24, Junio C Hamano <junkio@cox.net> wrote:
>> "git-diff-tree --color HEAD" (with explicit command line
>> instruction to color it) still colours its output, but "[diff]
>> color = auto" in ~/.gitconfig would not affect the coloring.
>> Hence, "git-diff-tree HEAD" with the configuration entry gives
>> monochrome.
>>
>> "git diff HEAD" on the other hand looks at '[diff] color = auto"
>> and will color its output without being told on the command
>> line.
>
> Since this is about "log" family that deals with revision
> structure, how about....
>
> -- >8 --
> [PATCH] config option log.showroot to show the diff of root commits
[...]

Patch looks good.

One question, what's the difference between git-log -p and git-whatchanged -p?
I could only see it differ in the root commit handling.

Interesting parts marked with | as first character of the line.

  git-repo-config --get log.showroot
  false

  git-log -p 8bc9a0c769ac1df7820f2dbf8f7b7d64835e3c68
  commit 8bc9a0c769ac1df7820f2dbf8f7b7d64835e3c68
  Author: Linus Torvalds <torvalds@ppc970.osdl.org>
  Date:   Thu Apr 7 15:16:10 2005 -0700

      Add copyright notices.

      The tool interface sucks (especially "committing" information, which is just
      me doing everything by hand from the command line), but I think this is in
      theory actually a viable way of describing the world. So copyright it.

  diff --git a/cat-file.c b/cat-file.c
  index 74a0a23..d8f0121 100644
  --- a/cat-file.c
  +++ b/cat-file.c
  @@ -1,3 +1,8 @@
  +/*
  + * GIT - The information manager from hell
  + *
  + * Copyright (C) Linus Torvalds, 2005
  + */
   #include "cache.h"

   int main(int argc, char **argv)

  [... rest of the diff ...]

| commit e83c5163316f89bfbde7d9ab23ca2e25604af290
| Author: Linus Torvalds <torvalds@ppc970.osdl.org>
| Date:   Thu Apr 7 15:13:13 2005 -0700
|
|     Initial revision of "git", the information manager from hell
|
  [ ... as specified in log.showroot, no diff of the root commit ...]

  git-whatchanged -p 8bc9a0c769ac1df7820f2dbf8f7b7d64835e3c68
  commit 8bc9a0c769ac1df7820f2dbf8f7b7d64835e3c68
  Author: Linus Torvalds <torvalds@ppc970.osdl.org>
  Date:   Thu Apr 7 15:16:10 2005 -0700
  
      Add copyright notices.
      
      The tool interface sucks (especially "committing" information, which is just
      me doing everything by hand from the command line), but I think this is in
      theory actually a viable way of describing the world. So copyright it.
  
  diff --git a/cat-file.c b/cat-file.c
  index 74a0a23..d8f0121 100644
  --- a/cat-file.c
  +++ b/cat-file.c
  @@ -1,3 +1,8 @@
  +/*
  + * GIT - The information manager from hell
  + *
  + * Copyright (C) Linus Torvalds, 2005
  + */
   #include "cache.h"
   
   int main(int argc, char **argv)

  [... rest of the diff ...]
|
| [ ... no commit message etc from the root commit is shown ...]
|

As you can see, the root commit isn't shown. Is this intentional?
Or is it just me not getting the different meaning of git-log and
git-whatchanged?

Setting "log.showroot = true" the output of the 2 commands is identical.

Peter

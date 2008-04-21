From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [ANNOUNCE] GIT 1.5.5.1
Date: Tue, 22 Apr 2008 03:56:10 +0400
Message-ID: <20080421235610.GB2631@dpotapov.dyndns.org>
References: <7vej8yako4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 01:57:11 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jo5sf-0007Gq-FC
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 01:57:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753693AbYDUX4S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2008 19:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753950AbYDUX4S
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Apr 2008 19:56:18 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:26624 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753678AbYDUX4R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2008 19:56:17 -0400
Received: by fg-out-1718.google.com with SMTP id l27so1948228fgb.17
        for <git@vger.kernel.org>; Mon, 21 Apr 2008 16:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=LbLec8oMZyjtG7EALZShZpUqKsuJMR1/JXsfqA4clAw=;
        b=nuvOBwlWvIPJdLz4sXWoXVfp/V5b6e9FVUxdZ2u5mAiENWSKepTg/jSupaQgzMU9lbVAceSw7QNoa5gYq/Ug0S2QQyhJcbgdwy1GIFPZYcgCHH1AvI5/dxcs7wXfGdoHS/Xk0/EMaRA1B0l7ZHe7ZqW4f4m7SUdEXT/j+jlqwn0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=fkRLCCpKapg4QrgpmjHQuTaQ6C00ZqS4jIPvBO5EidhDqALVXZHlS2wu/3ZCWJ0Em0UJoojOAkERMNIIjoYgvYy/d+O/O14Yp1IFLHZ42HukswQUxXihoVJ7hHRzXC2F+4KvzOQFGk8FbcZ1s6TtbSthqvMvDz/Vn6coUlZx554=
Received: by 10.86.59.2 with SMTP id h2mr14385937fga.78.1208822175704;
        Mon, 21 Apr 2008 16:56:15 -0700 (PDT)
Received: from localhost ( [85.140.171.25])
        by mx.google.com with ESMTPS id z37sm8109151ikz.1.2008.04.21.16.56.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 21 Apr 2008 16:56:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vej8yako4.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80043>

Hi Junio,

It looks like my patch to documentation has been lost. I sent
it about a week ago, and there has been no feedback to it, so
I believe it is okay.

The --prune option for 'git gc' was one of those options that you
need to use from time to time, but it was perceived by many users
as dangerous and many users were completely unaware of it, thus
often it was not used as intended.

Johannes' patch removed this option, which IMHO was a significant user
interface improvement.  Unfortunately, there are still a few places in
the documentation where this option is mentioned.  One of them is
"Everyday GIT", which is intended for beginners. I believe it is very
confusing for anyone who starts to use GIT to see an undocumented option
among recommended practice.

So, please, consider this patch for inclusion or provide any feedback
as to what kind of improvements may be needed for its inclusion.

Thanks,
Dmitry

-- >8 --
From: Dmitry Potapov <dpotapov@gmail.com>
Date: Mon, 14 Apr 2008 15:52:00 +0400
Subject: [PATCH] Documentation: git-gc --prune is deprecated

25ee9731c137d0a24b0f4879eb0b0cce9b77d5b0 made the '--prune' option
deprecated and removed its description from the git-gc man page. This
patch removes all references to this option from the rest of the Git
documentation.
---
 Documentation/everyday.txt    |    6 ++----
 Documentation/git-clone.txt   |   10 ++++++----
 Documentation/user-manual.txt |   17 +----------------
 3 files changed, 9 insertions(+), 24 deletions(-)

diff --git a/Documentation/everyday.txt b/Documentation/everyday.txt
index fdbd15a..e598cdd 100644
--- a/Documentation/everyday.txt
+++ b/Documentation/everyday.txt
@@ -48,14 +48,12 @@ $ git gc <3>
 repository health reasonably well.
 <2> check how many loose objects there are and how much
 disk space is wasted by not repacking.
-<3> repacks the local repository and performs other housekeeping tasks. Running
-without `--prune` is a safe operation even while other ones are in progress.
+<3> repacks the local repository and performs other housekeeping tasks.
 
 Repack a small project into single pack.::
 +
 ------------
 $ git gc <1>
-$ git gc --prune
 ------------
 +
 <1> pack all the objects reachable from the refs into one pack,
@@ -182,7 +180,7 @@ $ git pull <3>
 $ git log -p ORIG_HEAD.. arch/i386 include/asm-i386 <4>
 $ git pull git://git.kernel.org/pub/.../jgarzik/libata-dev.git ALL <5>
 $ git reset --hard ORIG_HEAD <6>
-$ git gc --prune <7>
+$ git gc <7>
 $ git fetch --tags <8>
 ------------
 +
diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 9758243..c1bf814 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -65,10 +65,12 @@ OPTIONS
 +
 *NOTE*: this is a possibly dangerous operation; do *not* use
 it unless you understand what it does. If you clone your
-repository using this option, then delete branches in the
-source repository and then run linkgit:git-gc[1] using the
-'--prune' option in the source repository, it may remove
-objects which are referenced by the cloned repository.
+repository using this option and then delete a branch or use
+any other git command that makes any previous existing commit
+unreachable, then after some time linkgit:git-gc[1] may remove
+unreachable objects, and this will break the cloned repository.
+Because some git commands may run git-gc, it may happen at any
+time after gc.pruneExpire time since commits became unreachable.
 
 
 
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 565aeb9..86b91a5 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1548,22 +1548,7 @@ dangling tree b24c2473f1fd3d91352a624795be026d64c8841f
 
 Dangling objects are not a problem.  At worst they may take up a little
 extra disk space.  They can sometimes provide a last-resort method for
-recovering lost work--see <<dangling-objects>> for details.  However, if
-you wish, you can remove them with linkgit:git-prune[1] or the `--prune`
-option to linkgit:git-gc[1]:
-
--------------------------------------------------
-$ git gc --prune
--------------------------------------------------
-
-This may be time-consuming.  Unlike most other git operations (including
-git-gc when run without any options), it is not safe to prune while
-other git operations are in progress in the same repository.
-
-If linkgit:git-fsck[1] complains about sha1 mismatches or missing
-objects, you may have a much more serious problem; your best option is
-probably restoring from backups.  See
-<<recovering-from-repository-corruption>> for a detailed discussion.
+recovering lost work--see <<dangling-objects>> for details.
 
 [[recovering-lost-changes]]
 Recovering lost changes
-- 
1.5.5

--

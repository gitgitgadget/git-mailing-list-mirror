From: Christian Halstrick <christian.halstrick@gmail.com>
Subject: Why does "git reset --hard" fail on file/folder conflicts?
Date: Tue, 13 Oct 2015 08:36:20 +0200
Message-ID: <CAENte7i8jv5ET7v15HS-4bqbaGpdNkHFyX7upMHAmc0ykd1Mjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 13 08:36:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZltCX-0007l1-Kp
	for gcvg-git-2@plane.gmane.org; Tue, 13 Oct 2015 08:36:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752071AbbJMGgl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2015 02:36:41 -0400
Received: from mail-wi0-f175.google.com ([209.85.212.175]:38428 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752000AbbJMGgl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2015 02:36:41 -0400
Received: by wieq12 with SMTP id q12so15517169wie.1
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 23:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=rGSCsKGoocZrMRIKUUP8PUdTYbI8nCEeQutPEw6ZK5k=;
        b=sGT61cmyVoN/B2Y5VwbHv2VJLVWGopwb8kgYclm2U9OStZ+irmBH1U9jY021Cf9+5P
         mRo9oX+nRPCsOFZJJJUTJk0IkxGsxHuxrY9Nqd9rsUKi71Fd8S2kmZEFmTeEKCUniut/
         PyLPRsKTq9eDH1muAPrKar1IBoixnUNl7JnEKc+gDTWWFZ1kAKmXARY3IrfvajiLMGxa
         LTg9RiXMy4wjF7+3jm3nuBZqaiktq3StEyfdSd/daezqdt6Ii1qDJNBplUhYuuQa4qrY
         SxemJEwRwXjo+slgj55zdeOOe6CPKYRoZYQ50C8JTpL6XO/CkLD/LRintw0QURNX+CRe
         OnmA==
X-Received: by 10.180.76.177 with SMTP id l17mr19201457wiw.16.1444718200149;
 Mon, 12 Oct 2015 23:36:40 -0700 (PDT)
Received: by 10.28.7.206 with HTTP; Mon, 12 Oct 2015 23:36:20 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279482>

Hi,

git doesn't want to do a git reset hard when for a certain path the index
contains a tree, worktree contains a file and the commit to reset to
contains nothing. Is it a bug or is it intended? I would expect git to
simply delete that path from index and worktree.

> git init
Initialized empty Git repository in /tmp/y/.git/
> touch a
> git add a
> git commit -m addA
[master (root-commit) fa08136] addA
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 a
> mkdir d
> touch d/f
> git add d/f
> rm -fr d
> touch d
> git reset --hard HEAD
warning: unable to unlink d/f: Not a directory
HEAD is now at fa08136 addA

Ciao
  Chris

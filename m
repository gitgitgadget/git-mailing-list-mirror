From: =?ISO-8859-1?Q?Fr=E9d=E9ric_Heitzmann?= 
	<frederic.heitzmann@gmail.com>
Subject: Need to set GIT_WORK_TREE when setting GIT_DIR !?
Date: Fri, 9 Mar 2012 23:51:48 +0100
Message-ID: <CALeToSUaPzdr=u7FfwHEtEanphVP5LZ09QdQXno52PLBTK0H-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 09 23:52:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S68fp-0004ig-PO
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 23:52:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030408Ab2CIWw3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Mar 2012 17:52:29 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:46229 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757545Ab2CIWw2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2012 17:52:28 -0500
Received: by dajr28 with SMTP id r28so1963666daj.19
        for <git@vger.kernel.org>; Fri, 09 Mar 2012 14:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=3EyIIfzpvV0WnwBwOOJ/r927qC4p9qIJ5wCJ3CzRiL8=;
        b=X96oIgh/9HcbR/Dl1mcGAvEA/qDkLgK0x2k0LrOip+JSbfhlBIveC1xZykRQwnN/Ro
         icHzSAuwBKi39khLK6+AYXyho02YGXYLl60IkFBpI5UesP9hZq+jqnBP7LOqaeMakXqe
         O/NWprRJJrCC9i3SyV2BcVBe2SoWRu1goasVISVSHli79D3O+u0DoTBgJ/BeoK8tSUBQ
         HBknYy1Z9xy5h7AbVnZj8ZQLikbrb/mfctqSM69A29gFY3Gtf8GwBwINUUKUAfkZ9qRT
         8/G6DFTmxjgs6jiTlPHZ18NmWYO1kDq5Y7RbU2z8fLaQHrFeL/9lrvP7zt9gV6COr47j
         vHqQ==
Received: by 10.68.225.198 with SMTP id rm6mr6881154pbc.65.1331333548297; Fri,
 09 Mar 2012 14:52:28 -0800 (PST)
Received: by 10.68.220.103 with HTTP; Fri, 9 Mar 2012 14:51:48 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192753>

Hi all,

I want to set GIT_DIR to another path than <project_dir>/.git.
Unfortunately, git add or git status failed with the following error:

fatal: This operation must be run in a work tree

Unless I also set GIT_WORK_TREE, git status|add|stash|clean|... always fail.

git or git-config man pages does not state anything like this.
Did I miss something ?

#test-case :

export GIT_DIR=$PWD/.gita &&
git init
echo "file a" >> a.txt &&
git add a.txt			#fail
git status 			#fail

export GIT_WORK_TREE=$PWD
git status			#pass
git add a.txt &&
git commit -m'file a'		#pass

unset GIT_WORK_TREE
git status			#fail, it does not look like some bug related to a newly
created, empty repository

Note: that using --git-dir instead of GIT_DIR give the same errors.

--
Fred

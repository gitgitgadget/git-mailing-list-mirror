From: Yann Dirson <ydirson@altern.org>
Subject: [BUG] a couple of stgit bugs
Date: Fri, 12 Jan 2007 23:52:16 +0100
Message-ID: <20070112225216.GB9761@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 12 23:52:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5VG1-0007xu-VP
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 23:52:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161151AbXALWwT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Jan 2007 17:52:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161153AbXALWwT
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jan 2007 17:52:19 -0500
Received: from smtp6-g19.free.fr ([212.27.42.36]:47314 "EHLO smtp6-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161151AbXALWwS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jan 2007 17:52:18 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp6-g19.free.fr (Postfix) with ESMTP id DB249435A7;
	Fri, 12 Jan 2007 23:52:16 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 207CC2015; Fri, 12 Jan 2007 23:52:16 +0100 (CET)
To: Catalin Marinas <catalin.marinas@gmail.com>
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36722>

Here are another couple of (probably long-standing) bugs I noticed
today on 0.11, but which still hold on current HEAD:

- "stg status <files>" does not restrict output to listed files/dirs:

yann/git/stgit$ ./stg status stgit/
? contrib/stg-cvs.new
? contrib/stg-cvs.orig
? contrib/stg-cvs.rej
? stgit/commands/pick.py.orig
? stgit/stack.py.orig


- "stg refresh" still does not work in subdir:

git/stgit/examples$ ../stg refresh
Checking for changes in the working directory... done
Refreshing patch "test"...error: examples/examples/gitconfig: does not exist and --remove not passed
fatal: Unable to process file examples/gitconfig
stg refresh: Failed git-update-index

Traceback (most recent call last):
  File "../stg", line 43, in ?
    main()
  File "/export/work/yann/git/stgit/stgit/main.py", line 262, in main
    command.func(parser, options, args)
  File "/export/work/yann/git/stgit/stgit/commands/refresh.py", line 145, in func
    backup = True, sign_str = sign_str)
  File "/export/work/yann/git/stgit/stgit/stack.py", line 667, in refresh_patch
    committer_email = committer_email)
  File "/export/work/yann/git/stgit/stgit/git.py", line 540, in commit
    changes = update_cache(files)
  File "/export/work/yann/git/stgit/stgit/git.py", line 523, in update_cache
    raise GitException, 'Failed git-update-index'
stgit.git.GitException: Failed git-update-index

Best regards,
-- 
Yann.

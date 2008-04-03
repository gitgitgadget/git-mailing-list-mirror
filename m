From: "James Kingston" <james.kingston@gmail.com>
Subject: newbie with broken workflow
Date: Thu, 3 Apr 2008 16:45:42 -0500
Message-ID: <9d27c6320804031445p3fc80115n59218673dd587795@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 03 23:46:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhXGP-0002KD-3U
	for gcvg-git-2@gmane.org; Thu, 03 Apr 2008 23:46:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755440AbYDCVpp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Apr 2008 17:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755146AbYDCVpp
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Apr 2008 17:45:45 -0400
Received: from el-out-1112.google.com ([209.85.162.177]:25993 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755440AbYDCVpo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Apr 2008 17:45:44 -0400
Received: by el-out-1112.google.com with SMTP id v27so1845189ele.17
        for <git@vger.kernel.org>; Thu, 03 Apr 2008 14:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=POOwih4pZ1vlQXWWXT9x/OpDofSrxGAtLMLjX0oaeos=;
        b=T9Obd89VSpg7CSUDWMIZhuZs0xQeE22kwu0m6c5Zqo7Eaaq3L2u+QNIiA+xVXZdiYoQLqEt4NJhN5+5Epo0Bxs6zoArlkYw/X+qnzEZZoj43tpGhYjJGZDs++Bnrrg8YvQERvzAxbhpBcmH9I9TDQo3lD8+c4v/HkALbkldwvxQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=sXFZ21DLjfUDyI4tk18qpJ81QwcHyu1Y4qIlmtgHNFiNVXs5+PNtELaxqKXog3tP+IVfBHRZTXj25fjDaObLYl2snqoB9MiOZH3nrijDHQT8BPmqA/p9ThELp/WPFxSsADz9w+POg5CQJLc45VMH8ns/CbhZh3hz1GXrWNflvhg=
Received: by 10.114.149.2 with SMTP id w2mr720150wad.29.1207259143030;
        Thu, 03 Apr 2008 14:45:43 -0700 (PDT)
Received: by 10.114.57.6 with HTTP; Thu, 3 Apr 2008 14:45:42 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78784>

I am a few days into git and have settled into a workflow that is
apparently very broken, and I'd appreciate it if someone with a more
experienced eye can point out where I went wrong.

The official SCM tool at my work is ClearCase Remote Client, and it's
vile... pessimistic locking, huge bureaucracy just to create a branch
(I love experimental branches), no licenses for the native client.  My
plan was to use git (Git-1.5.4-preview20080202.exe) to track my
clearcase view directory, and push changes into that repo when
convenient from my working directory repo (clearcase makes
non-checkedout files read only, which makes working directly in the
view directory Ugly).

Here is a timeline of how I tried to do this:

/c>	cd /c/cc
/c/cc> 	git init
/c/cc> 	git add *
/c/cc> 	git commit
/c/cc> 	mkdir /c/wd
/c/cc> 	cd /c/wd
/c/wd>	git clone /c/cc
/c/wd>	cd cc/
/c/wd/cc>  ls
/c/wd/cc>  vi config.ini
/c/wd/cc>  git checkout -b config_changes
/c/wd/cc>  git diff
/c/wd/cc>  git add config.ini
/c/wd/cc>  git commit
/c/wd/cc>  git checkout master
/c/wd/cc>  git merge config_changes
/c/wd/cc>  vi config.ini
/c/wd/cc>  git push /c/cc
/c/wd/cc>  cd /c/cc
/c/cc> 	vi config.ini # doesn't show the change made in experimental
branch, though gitk shows the patch
/c/cc> 	git status # says that config.ini has been modified
/c/cc> 	git add config.ini # grasping as straws
/c/cc> 	git commit # changes nothing, as far as I can tell
/c/cc> 	git reset --hard #still changes nothing.  My diffs are there
in the log, just out of reach

I have much to learn, but in the short term I just need to get those
changes into clearcase so QA can pull them

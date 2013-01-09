From: Alexander Gallego <gallego.alexx@gmail.com>
Subject: git branch case insensitivity (Possible bug)
Date: Wed, 9 Jan 2013 10:46:34 -0500
Message-ID: <CAL+iW28LdnNiho4KksLX_S_-+bKX+77GPJ0zqQfkz4JpBJRskw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 09 16:47:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tsxs5-0000yT-4i
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 16:47:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758024Ab3AIPq5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2013 10:46:57 -0500
Received: from mail-wi0-f179.google.com ([209.85.212.179]:41113 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758010Ab3AIPq4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2013 10:46:56 -0500
Received: by mail-wi0-f179.google.com with SMTP id o1so608623wic.0
        for <git@vger.kernel.org>; Wed, 09 Jan 2013 07:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=n3KGr7aLNEGpMU1s7v4BdztVlL98Z/WkmYsGJ2CioJ0=;
        b=TdqJ+J3tmxv2Naf2WzXxhGmNKcUaxTKRFd41rfEjMW0B0JjiudYQ3k3EO6L35XXTdQ
         8zP5PNDsiW6Aq3p2KQRCeAjgJcHef2exFPQhKrhQNNUHyhZlvu2+BGSsGyjEUQv7DDX/
         UNZ99Iv3FPqI5g4iTvepNu4Ffy1Lhbf6L074ZLFsXWOmMV68NhSzMQMtLjD6MH02t429
         iNtXQKWcXakfH++R9nuHvS4YBjH4Vp5F+6zIUBSFaejADm2A/O/BggCTymvuxUECwoMQ
         E3SsNpj/EeM3qnbJ/QMYIjZU9ZPTCRCXY6ay+ho1iYyGS/uw5B0+qjT38bO+CmJYDz9j
         1DBA==
Received: by 10.180.90.106 with SMTP id bv10mr4037137wib.12.1357746415462;
 Wed, 09 Jan 2013 07:46:55 -0800 (PST)
Received: by 10.194.242.69 with HTTP; Wed, 9 Jan 2013 07:46:34 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213062>

Hello,

Here is a pastebin where I've reproduced the steps on a clean git repo.

http://pastebin.com/0vQZEat0



Brief description of the problem:



1.Basically one creates a local branch call it 'imp_fix' (branch off
master --> this doesn't matter)
2.One does work, commit, etc
3.One rebases imp_fix with master via: (inside imp_fix) git rebase master
4.One checks out master via: git checkout master
5.One merges an incorrect name "imp_Fix" (notice the capital F)
6.The expected output is that git would say, silly you --> that branch
does not exist.
7. Instead it merges (what I think is incorrectly) imp_fix.


Kindly let me know if I can provide more details.






For your convenience here is the paste:

agallego@agallego-macpro.local] /tmp
$ git clone git@bitbucket.org/agallego/gitbug
Cloning into 'gitbug'...
warning: You appear to have cloned an empty repository.

[agallego@agallego-macpro.local] /tmp
$ cd gitbug

[agallego@agallego-macpro.local] /tmp/gitbug
$ ls

[agallego@agallego-macpro.local] /tmp/gitbug
$ echo "Trying to reproduce a bug" > README

[agallego@agallego-macpro.local] /tmp/gitbug
$ ls
README

[agallego@agallego-macpro.local] /tmp/gitbug
$ git add .

[agallego@agallego-macpro.local] /tmp/gitbug
$ git commit -am "adding readme"
[master (root-commit) 0bfd62a] adding readme
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 README

[agallego@agallego-macpro.local] /tmp/gitbug
$ git push origin master
Counting objects: 3, done.
Writing objects: 100% (3/3), 230 bytes, done.
Total 3 (delta 0), reused 0 (delta 0)
remote: bb/acl: agallego is allowed. accepted payload.
To git@bitbucket.org:agallego/gitbug
 * [new branch]      master -> master

[agallego@agallego-macpro.local] /tmp/gitbug
$ git checkout imp_fix
error: pathspec 'imp_fix' did not match any file(s) known to git.

[agallego@agallego-macpro.local] /tmp/gitbug
$ git branch imp_fix

[agallego@agallego-macpro.local] /tmp/gitbug
$ git checkout imp_fix
Switched to branch 'imp_fix'

[agallego@agallego-macpro.local] /tmp/gitbug
$ echo "imp_fix" >> README

[agallego@agallego-macpro.local] /tmp/gitbug
$ git commit -am "step 2, create an imp_fix branch and then merge"
[imp_fix 178c8f3] step 2, create an imp_fix branch and then merge
 1 files changed, 1 insertions(+), 0 deletions(-)

[agallego@agallego-macpro.local] /tmp/gitbug
$ ls
README

[agallego@agallego-macpro.local] /tmp/gitbug
$ git rebase master
Current branch imp_fix is up to date.

[agallego@agallego-macpro.local] /tmp/gitbug
$ git checkout master
Switched to branch 'master'

[agallego@agallego-macpro.local] /tmp/gitbug
$ git merge imp_Fix
Merge made by the 'recursive' strategy.
 README |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

[agallego@agallego-macpro.local] /tmp/gitbug
$ git push origin master
Counting objects: 6, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (2/2), done.
Writing objects: 100% (4/4), 392 bytes, done.
Total 4 (delta 1), reused 0 (delta 0)
remote: bb/acl: agallego is allowed. accepted payload.
To git@bitbucket.org:agallego/gitbug
   0bfd62a..f99f8a1  master -> master






Sincerely,
Alexander Gallego

---*---
------*
*  *  *

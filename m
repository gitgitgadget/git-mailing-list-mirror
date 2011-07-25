From: =?UTF-8?B?UMOpdGVyIEFuZHLDoXMgRmVsdsOpZ2k=?= <petschy@gmail.com>
Subject: Surprise at git stash pop
Date: Mon, 25 Jul 2011 17:45:56 +0200
Message-ID: <CAG3eYYRdvi-JdPfZmH_1EhEpjdweZFc6NS54btEz0nWy=O3+vA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 25 17:46:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlNM2-0004jT-NQ
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jul 2011 17:46:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751912Ab1GYPp6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jul 2011 11:45:58 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:42637 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751396Ab1GYPp5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2011 11:45:57 -0400
Received: by gwaa18 with SMTP id a18so2669584gwa.19
        for <git@vger.kernel.org>; Mon, 25 Jul 2011 08:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=WJDBf7NzUGKbAE3ut3EnaaoJyQSEBD7q88JI2jCIJ1I=;
        b=DSFMAMUYsX8CACfZcBzSU1jT4O99WSp54ksyE4kq6NzRVNK7yPDW1ZKoGwant6hzJr
         dgX71s9/iHoHQT3CdaZnrJC9ziPAQKA7UcQt0dlYDJTyTyCaR3lKFwbi4NrCiJAgbknD
         bXbQfJ+vmiErffcMRNxk2cmHQWwPIV8SE/Pxg=
Received: by 10.236.175.66 with SMTP id y42mr50492yhl.380.1311608757111; Mon,
 25 Jul 2011 08:45:57 -0700 (PDT)
Received: by 10.147.34.14 with HTTP; Mon, 25 Jul 2011 08:45:56 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177797>

Hello,

'git stash pop' erased my local modifications, but not all of them.
Here is the dump of my terminal window with comments:

1) 1 item in the stash:

petschy@stormbringer:~/...$ git stash list
stash@{0}: WIP on 20110207-oracle: 089709b Merge branch
'20110207-oracle' of ssh:.... into 20110207-oracle

2) the status of the working tree

petschy@stormbringer:~/...$ git status
# On branch 20110207-oracle
# Your branch is ahead of 'origin/20110207-oracle' by 2 commits.
#
# Changes not staged for commit:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#
#    modified:   SQLQueryCache.cpp
#    modified:   SQLQueryCache.hpp
#    modified:   ../../server/plugins-src/ads/AdsPlugin.cpp
#    modified:   ../../server/plugins-src/ads/AdsPlugin.hpp

3) querying the details of the stashed item

petschy@stormbringer:~/...$ git stash show stash@{0}
 build-configs.def |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

4) popping it, naively

petschy@stormbringer:~/...$ git stash pop
Auto-merging build-configs.def
CONFLICT (content): Merge conflict in build-configs.def

5) surprise, surprise!

petschy@stormbringer:~/...$ git status
# On branch 20110207-oracle
# Your branch is ahead of 'origin/20110207-oracle' by 2 commits.
#
# Unmerged paths:
#   (use "git reset HEAD <file>..." to unstage)
#   (use "git add/rm <file>..." as appropriate to mark resolution)
#
#    both modified:      ../../build-configs.def
#
# Changes not staged for commit:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#
#    modified:  SQLQueryCache.cpp

ALL of the local modifications to SQLQueryCache.hpp, AdsPlugin.cpp/hpp
simply disappeared! Is this the expected behaviour? I don't think so.
Since the stash contained only one file, which had nothing to do with
the pending modifications, I thought it's safe to pop. And even if the
local modifications and the stashed files overlap, I'd expect a
warning, at least. Half day's work gone. And if this is business as
usual, why not all my local modifications were wiped?

Regards, Peter

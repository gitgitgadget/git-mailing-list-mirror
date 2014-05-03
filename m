From: Asmodehn Shade <asmodehn@gmail.com>
Subject: git subtree pull same remote different prefix problem
Date: Sat, 3 May 2014 17:44:35 +0900
Message-ID: <CANH8SB-wUscFS4rsmfm2O9N1uEKBf+vC3y-H5_qQRmEmOprGEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 03 10:45:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgVZE-0001qU-Ja
	for gcvg-git-2@plane.gmane.org; Sat, 03 May 2014 10:45:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050AbaECIo5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2014 04:44:57 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:47291 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750920AbaECIo4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2014 04:44:56 -0400
Received: by mail-wi0-f172.google.com with SMTP id hi5so2479080wib.11
        for <git@vger.kernel.org>; Sat, 03 May 2014 01:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=y8c2xqYkF44HLBj36E8v1EDOK7C2FrwobWUHAY15Nus=;
        b=bz4MELziY3h4tgOSrAYJrvwCp1OWh1JfsC2z9F6LRg7A8OR6pyoT+5X5Z2lwJIYI6x
         zTSCfFSeDFY21UMUSZEPRGc+fufSJ/8YydXaA48C/pY/wwEWnmoAErgwTRnjECfOhuxV
         V2H9Ivt5XNnnNIpuddMTXAAQYqO7UPpRTNZp+jKQ61IqpCgi3P15FByb6j5QiXg+TZse
         vn7GLDrkAaimj2XO8HjfRQHjqTe2P8lJYMXNnro1Z1pgUegyZIfQDu92tJVPPu/HLEhr
         HBmV9eJzJX7gQZK4GWsefZhrklkGI+S2jI5+Nax0b7HF1Bq0zvp4FwbwwNvTeecmcywk
         QJFQ==
X-Received: by 10.180.76.146 with SMTP id k18mr6722775wiw.5.1399106695895;
 Sat, 03 May 2014 01:44:55 -0700 (PDT)
Received: by 10.194.143.105 with HTTP; Sat, 3 May 2014 01:44:35 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248027>

Hello,

I am currently using git subtree in a project :
https://github.com/asmodehn/wkcmake

This is basically a set of cmake scripts that help writing convention
based (folder hierarchy, etc.) cmake builds.

My setup is that "master" has the set of scripts needed. and many
other branches ("test" and "tests/*" most notably) have tests projects
for these scripts. Travis run build of these to check if the build
setup works as expected.

The "test" branch has a hierarchy of dependent projects (ProjectA,
ProjectB, ProjectC) , all using the wkcmake scripts to build.

So I am using git-subtree to pull and push  "ProjectA/CMake"
ProjectB/Custom CMake" "ProjectC/CMake".

I had enough trouble with push to stop using it( merge not happening
as I thought it would ). Not sure if I am to blame or not for these...
Anyway now, after a commit into the test branch, I instead split the
CMake subtree to a new branch, and merge in manually back to master.
That seems to work okay so far.

However I realized that when I do :
 git subtree pull -P ProjectA/CMake git@github.com:asmodehn/
wkcmake.git origin master
 git subtree pull -P "ProjectB/Custom CMake"
git@github.com:asmodehn/wkcmake.git origin master
 git subtree pull -P ProjectC/CMake
git@github.com:asmodehn/wkcmake.git origin master

I get only one merge commit into the "test" branch. All the other
subtree pull returns "Already up to date" even though the content of
the working directory in the prefix passed is NOT uptodate.

The possible behavior that I could understand would be :
- One subtree pull update all prefixes, with only one merge commit,
and the prefix doesnt really matter anymore ( could be problematic...
)
- Each subtree pull update the appropriate prefix with one merge commit each.

So I am curious : I this a scenario that subtree doesnot support ?
Am I using it wrong ?
Is it a current limitation/bug of subtree that is on the roadmap to be
addressed sometime in the future ?

Thanks a lot for the help.
--
AlexV

From: Dmitry Kakurin <dmitry.kakurin@gmail.com>
Subject: Bootstraper for Git Dev Environment for Windows (Light version)
Date: Sun, 5 Aug 2007 04:00:14 -0700
Message-ID: <2B8D8540264E4205BD1E4605770422BF@ntdev.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="koi8-r";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 05 13:00:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHdqR-0004kI-ON
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 13:00:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757799AbXHELAU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 07:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757102AbXHELAU
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 07:00:20 -0400
Received: from wa-out-1112.google.com ([209.85.146.180]:55815 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754819AbXHELAS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 07:00:18 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1436077wah
        for <git@vger.kernel.org>; Sun, 05 Aug 2007 04:00:18 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:to:subject:date:mime-version:content-type:content-transfer-encoding:x-priority:x-msmail-priority:x-mailer:x-mimeole:from;
        b=Zbi+RmqdjwqRFxW9BiqE/p7TadTyQAz5l5lQ/fCVS/JEbKSsdjKRePXsTFrDJVhF/27Qh+yRc2dJwZi5XZFI+fBA/YhPAgReD97qm4V1TJAWf9xShrYQmvDafgijf26CqJZxpIKf0pWCHiw8QYmG/kjZzIA4xr6XNZbmx8LDfmg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:to:subject:date:mime-version:content-type:content-transfer-encoding:x-priority:x-msmail-priority:x-mailer:x-mimeole:from;
        b=VzacbtkV2X+l5TLDjwhXTVdUieLscp7HitrQ3b9H6G45d8L32GzstMe8zIx9z0oT/LhXgiWyDltxJlT3+hOAqNsgIn7Ci9ADhh1h2RJ5Lp2BQhkscwvV7sTPzap4BN1GXT0KNDK6FRM4YIFlpYgO8eoPDnJ5uiBnjjQ1B56LMp0=
Received: by 10.115.107.1 with SMTP id j1mr4643789wam.1186311617066;
        Sun, 05 Aug 2007 04:00:17 -0700 (PDT)
Received: from dmitrykl2 ( [71.112.20.227])
        by mx.google.com with ESMTPS id m30sm5294212wag.2007.08.05.04.00.16
        (version=SSLv3 cipher=OTHER);
        Sun, 05 Aug 2007 04:00:16 -0700 (PDT)
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Windows Mail 6.0.6000.16480
X-MimeOLE: Produced By Microsoft MimeOLE V6.0.6000.16480
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54992>

Please give it a try and tell me how it works for you:
http://msysgit.googlecode.com/files/GitMe-1.exe (1.6 MB)

Here is the idea that this installer implements:
Now that we have both msysGit and mingw git as .git repositories here is what we can do:
* Create a small bootstrap download with git-clone and it's dependencies
* After you download and run it, it will first clone msysGit repository
* Then it will clone mingw.git repository
* Start msys and run 'make install' for git
* Clear leftovers of bootstrap

There are huge advantages IMHO:
* the bootstrap download is very small (1.6MB) and will (almost) never change
* msysGit will not contain git sources at all (this causes very inconvenient overlap between 2 repositories right now)
* after initial setup process user will be left with 2 fully-functioning repositories (msysGit and git), so staying up to date with 
both mingw.git and msys dev/build environment will be trivial: just use git pull for both.

If we want to stick with this installer here is what we need to do:
* Remove /git directory from msysGit.git
* Bring mingw.git up to date so we can remove patching step from installer

If you want to change it/see how it works internally do the following:
* start the GitMe.exe
* answer yes to popup dialog
* cmd window will open and ask you for installation directory, don't enter anything, just leave this window alone

At this point all installer files will be unpacked in %temp%\RarSFX0\GitMe.
Setup.cmd is the one to look at/tweak.

To repack just use any compressor that can create SFX archives that can also start a file execution. I've used WinRAR.
But the whole idea is that this bootstrap download should require very little/no tweaking. All changes should happen in msysgit.git 
and mingw.git.

- Dmitry

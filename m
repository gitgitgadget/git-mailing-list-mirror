From: Edward Marshall <marshallx7a@gmail.com>
Subject: Windows git bash - child processes see system PATH environment
 variable instead of user...
Date: Wed, 17 Feb 2016 21:31:30 +0000
Message-ID: <CAN2vHUFYqKDDEJpGtxJ9aD+8abe-krnHBy7cm1tMm0+bh5ykBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 17 22:31:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aW9h9-0007iU-Fs
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 22:31:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424060AbcBQVbc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2016 16:31:32 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:36174 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423542AbcBQVbb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2016 16:31:31 -0500
Received: by mail-wm0-f48.google.com with SMTP id g62so181714684wme.1
        for <git@vger.kernel.org>; Wed, 17 Feb 2016 13:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=k+ApzgGeWzw4GBRtNYt8mJdLNVEJGch1kdC0dSHT8Cc=;
        b=bTS/06f4jmnzQwuPXPNFWK8KKWTffM4ElfzoBhxejjToYcqMqhAcOi/1cEWwj2nJme
         q1mka79+8CbKkAw2Fi82iryPq2mJ34Nxhbc1lvrL26gRuo4ld8PtbQrh/ckLTAWhRFdb
         iSa/ceW/ElFWIBbz29u05ORDq2gN3KnXMovdNsNkDlNBGw1WiZJ9zzlHco8K8T/8p2wG
         HH2RkSJHfdj+i+1GVq4iljtrYeSNiITinoh/o6/OTBuIfa8usRamhjkzNDeNaZ5x9Yga
         UAu9sv0weg8bUHWTZE6UHLZ0Kcs0EkDpv6vqy9tSkKQZcrBvoXZHYgZR2EbUdFYGKToZ
         tD7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=k+ApzgGeWzw4GBRtNYt8mJdLNVEJGch1kdC0dSHT8Cc=;
        b=AHKrxejvh09YSE5xgOVOtEx/eF3P2mU5R9FZxo/Oc1gyfU3U4OUhQCNNO8NluhCFQb
         H9a8cjxUh+rN11bQZwGih1C73ERW1MzpN4FL4S7tJhMKfAQhB4EnVk7cePPVnDJ5u0Ex
         Ew/bSQyGO2AOl+0KMv5faIBZBl9aIO513TMP+Sl/71vSJNW5f1Vti/W8u72b7h2ZCZ7c
         eN/D5MqDsiLgD62Zwtg0AqoKRfKPON0LF/ymlljZQv7Ji7OE3zjxdjdUCHQOYdPOHc9M
         2vI+tyA2xI5lK3x0RcQKUYp+pbqwONLE+WcY0gIlCZbHDXKUdeQQPFJgZ3bBo18N127s
         1RFw==
X-Gm-Message-State: AG10YOQEVqSglSui52Kq5utSy/3KDoSPUG+pBRkF+m0FW0aC+s/ovR5qqnyf1PaLHzjPaHA6BZpN1lNB+7Yltw==
X-Received: by 10.28.188.138 with SMTP id m132mr28059618wmf.29.1455744690126;
 Wed, 17 Feb 2016 13:31:30 -0800 (PST)
Received: by 10.194.102.193 with HTTP; Wed, 17 Feb 2016 13:31:30 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286556>

This happens on my Windows 7 Home Premium x64 SP1 Desktop, but not on
my Windows 10 Pro x64 laptop.

Everything used to work fine until I updated my Desktop to the latest
version of Git (the laptop has the same version but was a totally
clean install as it is a new laptop)

Edward@Edward-PC MINGW64 /f/Work
$ echo $PATH
...(USER PATH)...

Edward@Edward-PC MINGW64 /f/Work
$ cmd
Microsoft Windows [Version 6.1.7601]
Copyright (c) 2009 Microsoft Corporation. All rights reserved.

F:\Work>echo %PATH%
echo %PATH%
...(SYSTEM PATH)...

The same is true of any child process (e.g. node.js) - they all see
SYSTEM PATH now instead of USER PATH.
I have tried clean reinstalling git.
I have tried both the 64-bit and 32-bit versions of git.

Used Process Explorer to investigate the environment of the processes
on the 2 machines. The only significant difference I can see is the
PATH variable in cmd.exe.

If I double-click bash.exe (instead of the shortcut to git-bash.exe)
then the user PATH is seen by child processes.
Double clicking git-bash.exe, still has the problem.
Running bash -l from a cmd window, has the problem.

Run bash.exe, then
sh
echo $PATH
// Shows user path
cmd
echo %PATH%
// Now shows system path
So bash saw user path, sh saw user path but then cmd was passed the
system path?!

Run bash.exe followed by cmd, cmd, cmd, etc - cmd always sees user path.
So bash -l and sh both see user path but then only forward system path
to child processes...

sh definitely used to work as well as the git bash shortcut (I know
because I run git bash > grunt > sh and that now sees the
wrong/incomplete path when before it was working fine)

I have spent most of this frustrating day trying to figure out what is
going wrong but do not have a clue.

I have no .bashrc or .bash_profile files on either system (no idea
what these are for but a colleague was trying to help diagnose the
problem - they ultimately came up empty).
As far as I can tell the 2 systems are set up exactly the same (apart
from the different Windows versions of course).
Path length is not an issue as the (working) laptop has a huge path
whereas the (not working) desktop has less than 500 characters.

Unfortunately I don't know what version of git I had before, and older
versions aren't offered for download so I can't trial and error.
Really wishing I hadn't upgraded!

Any assistance would be much appreciated as I am totally pulling my
hair out now.

Many thanks and kind regards,

Edward Marshall

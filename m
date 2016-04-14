From: Krzysztof Voss <k.voss@usask.ca>
Subject: Cannot checkout a branch / worktree shows multiple branches for the
 same directory
Date: Thu, 14 Apr 2016 13:51:19 -0600
Message-ID: <CACB1J8XEXcy+Wewcwx_0UWZbQz-WeWUVnK_yAHw5uTBnr2fpVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 14 22:06:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqnX5-0001ft-Vd
	for gcvg-git-2@plane.gmane.org; Thu, 14 Apr 2016 22:06:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751824AbcDNUG2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2016 16:06:28 -0400
Received: from mail08.usask.ca ([128.233.195.240]:42423 "EHLO mail.usask.ca"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751150AbcDNUG1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2016 16:06:27 -0400
X-Greylist: delayed 905 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Apr 2016 16:06:27 EDT
Received: from mail-yw0-f169.google.com (209.85.161.169) by Mail08.usask.ca
 (192.168.228.179) with Microsoft SMTP Server (TLS) id 15.0.1178.4; Thu, 14
 Apr 2016 13:51:20 -0600
Received: by mail-yw0-f169.google.com with SMTP id i84so115274613ywc.2
        for <git@vger.kernel.org>; Thu, 14 Apr 2016 12:51:20 -0700 (PDT)
X-Gm-Message-State: AOPr4FXtOfxNn5LKQFCkCXO81Dn2t2YgvUih1lfmC4hzajfxc2jGVXLkgmFf2milE+/nZeyp24bcxfzOTlH7Sw==
X-Received: by 10.129.157.205 with SMTP id u196mr10287739ywg.198.1460663479185;
 Thu, 14 Apr 2016 12:51:19 -0700 (PDT)
Received: by 10.129.72.132 with HTTP; Thu, 14 Apr 2016 12:51:19 -0700 (PDT)
X-Gmail-Original-Message-ID: <CACB1J8XEXcy+Wewcwx_0UWZbQz-WeWUVnK_yAHw5uTBnr2fpVg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291562>

Hi,

I stumbled upon an interesting problem when checking out a branch.
I had to switch to a testing branch to merge in some changes from yet
another branch, but when I tried to check out the testing branch I got
a message saying that I'm already on the target branch.

I used worktree a few times, but the checkouts were always in their
own directories.
It crossed my mind that this behaviour may be related, so I took a
look at the worktree list and noticed that according to that list
there are three branches at the same time in one directory.

It may be a conicidence and I have no confidence in saying that these
issues are related.
Can someone shed some light on this issue for me?


    $ git --version
    git version 2.7.0.235.g07c314d

    $ git status -uno -sb
    ## ticket-22444
    M src/core/parsers/ParserBase.py
    M src/core/parsers/test/ParserBase_test.py

    $ git stash
    Saved working directory and index state WIP on ticket-22444:
7c5edaa #22444 refactoring
    HEAD is now at 7c5edaa #22444 refactoring

    $ git co testing
    fatal: 'testing' is already checked out at '/home/k/workspace/moyo'

    $ pwd
    /home/k/workspace/moyo

    $ git branch | grep '*'
    * ticket-22444

    $ git worktree list
    /home/k/workspace/moyo  7c5edaa [ticket-22444]
    /var/home/k/moyo-lsf  349613d (detached HEAD)
    /home/k/workspace/moyo  265b7f9 (detached HEAD)
    /home/k/workspace/moyo  c852282 [testing]

    $ uname -a
    Linux k 3.13.0-83-generic #127-Ubuntu SMP Fri Mar 11 00:25:37 UTC
2016 x86_64 x86_64 x86_64 GNU/Linux

    $ cat /etc/lsb-release
    DISTRIB_ID=Ubuntu
    DISTRIB_RELEASE=14.04
    DISTRIB_CODENAME=trusty
    DISTRIB_DESCRIPTION="Ubuntu 14.04.4 LTS"


Thanks,
Krzysztof

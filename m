Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E6BAC4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 00:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7221560EB6
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 00:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbhGVX1G (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 19:27:06 -0400
Received: from miwoqo.han-solo.net ([83.138.82.154]:22965 "EHLO
        miwoqo.han-solo.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232550AbhGVX1F (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 19:27:05 -0400
X-Greylist: delayed 1517 seconds by postgrey-1.27 at vger.kernel.org; Thu, 22 Jul 2021 19:27:05 EDT
X-KSD:  <git@vger.kernel.org>
Received: from [192.168.178.20] (ip4d1575b8.dynamic.kabel-deutschland.de [77.21.117.184])
        (authenticated bits=0)
        by miwoqo.han-solo.net (8.15.2/8.15.2) with ESMTPSA id 16MNgLcO069485
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 01:42:21 +0200 (CEST)
        (envelope-from oliver.niebuhr@oliverniebuhr.de)
X-Authentication-Warning: miwoqo.han-solo.net: Host ip4d1575b8.dynamic.kabel-deutschland.de [77.21.117.184] claimed to be [192.168.178.20]
To:     git@vger.kernel.org
From:   Oliver Niebuhr <oliver.niebuhr@oliverniebuhr.de>
Subject: [Bug Report] Git does not push signingkey ID to GPG
Message-ID: <dfeebef5-6f48-082d-f49d-832863ff62a8@oliverniebuhr.de>
Date:   Fri, 23 Jul 2021 01:42:20 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello.

Using 'git commit -S' (uppercase S) to gpg sign a commit does not work. 
It seems that Git does not push the ID to GPG.

When I use 'git commit --gpg-sign=[KEY]', it works as expected.

What do I try to achieve: Automate adding 'Signed-off-by' and 
automatically sign with the gpg key.

It should work from CMD Line as well from within an IDE.

I have edit the .gitconfig File accordingly and added

[user]
signingkey = NNN
[commit]
gpgsign = true
[alias]
amend = commit -S -s --amend
cm = commit -S -s
commit = commit -S -s
tag = tag -S -s
[gpg]
program = C:\\Program Files (x86)\\GnuPG\\bin\\gpg.exe

The Git User Name and eMail Address are the same which are set in the 
used GPG Certificate.

Using '-S' from the Windows CMD Shell and Git Bash leads to an error. 
Neither typing the command manually or using it through an alias works.

When I switch '-S' with '--gpg-sign=NNN' everything works as it should 
from CMD Line - but not when I use for example SmartGit and enable 'Sign 
all Commits'. After countless hours looking through the Web, I am not 
out of Ideas.

Here is the Trace:
C:\Dev\GitRepos\Test>git cm
00:30:36.873133 exec-cmd.c:237      trace: resolved executable dir: 
C:/Dev/Git/mingw64/bin
00:30:36.874133 git.c:744           trace: exec: git-cm
00:30:36.874133 run-command.c:667   trace: run_command: git-cm
00:30:36.876134 git.c:396           trace: alias expansion: cm => commit 
-S -s
00:30:36.876134 git.c:805           trace: exec: git commit -S -s
00:30:36.876134 run-command.c:667   trace: run_command: git commit -S -s
00:30:36.883142 exec-cmd.c:237      trace: resolved executable dir: 
C:/Dev/Git/mingw64/libexec/git-core
00:30:36.884143 git.c:455           trace: built-in: git commit -S -s

hint: Waiting for your editor to close the file... 00:30:36.889147 
run-command.c:667       trace: run_command: GIT_INDEX_FILE=.git/index 
'"C:/Dev/GitGuis/GitExtensions/GitExtensions.exe" fileeditor' 
C:/Dev/GitRepos/Test/.git/COMMIT_EDITMSG
00:30:45.064284 run-command.c:667       trace: run_command: 'C:\Program 
Files (x86)\GnuPG\bin\gpg.exe' -bsau ''
gpg: skipped "": Invalid user ID
gpg: signing failed: Invalid user ID
error: gpg failed to sign the data
fatal: failed to write commit object

Windows: Windows 10 Pro, 21H1, 19043.1100
Git Version: git version 2.32.0.windows.2
GPG Version: gpg (GnuPG) 2.2.28, libgcrypt 1.8.8, Copyright (C) 2021 g10 
Code GmbH

Thank you in advance!
Oliver Niebuhr

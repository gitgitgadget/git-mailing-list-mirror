From: =?UTF-8?Q?Bj=C3=B8rnar_Snoksrud?= <snoksrud@gmail.com>
Subject: workdirs: cannot clone a local workdir directory
Date: Wed, 15 Jul 2015 11:40:18 +0200
Message-ID: <CA+cck7GR1Gs+OvhweQZFs0=5uKu=RwEgY=0_0CZSCDqtDWrR2A@mail.gmail.com>
Reply-To: bjornar@snoksrud.no
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 15 11:40:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZFJAw-0000GI-By
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jul 2015 11:40:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754052AbbGOJkV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jul 2015 05:40:21 -0400
Received: from mail-yk0-f179.google.com ([209.85.160.179]:36785 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753929AbbGOJkT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jul 2015 05:40:19 -0400
Received: by ykay190 with SMTP id y190so31304853yka.3
        for <git@vger.kernel.org>; Wed, 15 Jul 2015 02:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:date:message-id:subject:from:to:content-type;
        bh=2YZoEQocMEKV9cKGvzTniJz2ABANtM3ms1cVKVBKb7E=;
        b=hfiHnucPEcT8pie+Oxv2S27OZnxDqSmHcqECxx5twrWQGPwu8GfGDVG3cKsP8ZZf66
         Gk9Vr2vy1e/4Vuqxtt3gtSUKCjEQ6CtgkTPsBAVMhUCI14/JI9ca6Sk9KTTJLOM6y9Dg
         KwgvOQZUbpPP3ZEE4QbAIfCDyNtlZyhrMYaJzvawhH4iGMRXsZ9NtJY7xc3QEBR/S0v6
         uhOnEYSu2ycx1bb4X4rpvxJMv5Q/HCUKyX8/KagcfwNg/1uZqxnaUoRNn5kJmksfgb+M
         +0yvOUFfRCkTDUNQin68LJazaovaGrbIOn2DILvCCwxjjB4MNLnF3g/t1xAtGSHS5xH1
         A4Ag==
X-Received: by 10.13.197.3 with SMTP id h3mr3110396ywd.139.1436953218944; Wed,
 15 Jul 2015 02:40:18 -0700 (PDT)
Received: by 10.129.71.3 with HTTP; Wed, 15 Jul 2015 02:40:18 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273982>

I reported this before, but now I have a nice topic to hang it on -

I have re-reproduced the bug using a build from master as of today,
using the new worktree commands.

Reproduction:
Creating a repo `foo`, checkout --to'ing it to ../bar, then try to
clone both resulting repositories..

$ git --version
git version 2.4.4.600.g6397abd
$ mkdir foo
$ cd foo
$ git init
Initialized empty Git repository in /bar/foo/.git/
$ git commit -m init --allow-empty
[master (root-commit) c6da399] init
$ git branch bar
$ git checkout bar --to ../bar
Enter ../bar (identifier bar)
Switched to branch 'bar'
$ cd ../bar
$ cd bar
$ git status -sb
## bar
$ cd ..
$ git clone bar baz
Cloning into 'baz'...
fatal: '/path/bar' does not appear to be a git repository
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.
$ git clone foo baz
Cloning into 'baz'...
done.



-- 
bjornar@snoksrud.no

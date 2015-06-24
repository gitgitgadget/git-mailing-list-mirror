From: =?UTF-8?Q?Bj=C3=B8rnar_Snoksrud?= <snoksrud@gmail.com>
Subject: Cannot clone a linked working directory.
Date: Wed, 24 Jun 2015 12:38:37 +0200
Message-ID: <CA+cck7FB6QPz1Pec11TPXxxAhwKR78K9swgsQjMrZPhKJzi_iw@mail.gmail.com>
Reply-To: bjornar@snoksrud.no
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 24 12:38:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7i4u-0002ZU-Ey
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jun 2015 12:38:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751617AbbFXKij (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2015 06:38:39 -0400
Received: from mail-yh0-f41.google.com ([209.85.213.41]:36578 "EHLO
	mail-yh0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750966AbbFXKii (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2015 06:38:38 -0400
Received: by yhan67 with SMTP id n67so14793577yha.3
        for <git@vger.kernel.org>; Wed, 24 Jun 2015 03:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:date:message-id:subject:from:to:content-type;
        bh=fxm2lBu9E1a67St+/EE07jscD+4bo9p7Aru3JMDr2as=;
        b=tmrBYJRdx1i/bcgffu03kN2EN5UhWQW86pVYrIDlGJ/BVNL56qd4yNbjZ+M77UFUhB
         SckYsjKSh7kve3hZzEd2s37rXcCsxQbEgwW1Y+60U+qRlW5/GVvMs2HmARWEDLb0xW9E
         18AcCwhGa5WzyUzgW0EhfEXGBcfxAj26lY9gHPVts1rPVVn4w24nfhvujhqq+usGSWto
         U91xvjOnK6HxWNVxKLPm3FrXs2dKpETKf+0g8vjvu3vtSEcNBAeXtAwyIeCfXMjBOT5P
         8583DivGb0tYH65EnKLKdRJ82c+Q1oz6sc0QJjgHeQ/P0ZpyF9NjihwodQEzWpKeuQwN
         x9ZA==
X-Received: by 10.13.233.199 with SMTP id s190mr45046442ywe.164.1435142317976;
 Wed, 24 Jun 2015 03:38:37 -0700 (PDT)
Received: by 10.129.71.3 with HTTP; Wed, 24 Jun 2015 03:38:37 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272548>

Summary:
When creating a linked working directory with `git checkout --to`, you
cannot clone from the local path. This works when cloning the main
repository directory.

I couldn't find anything the the documentation for `git checkout` that
indicates that this shouldn't work.

Repro:
Creating a repo `foo`, checkout --to'ing it to ../bar, then try to
clone both resulting repositories -

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

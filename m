From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH jx/clean-interactive] t0060: skip a few relative_path
 tests on Windows
Date: Thu, 13 Jun 2013 17:40:21 +0800
Message-ID: <CANYiYbHQ307TroSd6Lk=5zg68jdKxGeA4N=hWGfaz1W29NhNVw@mail.gmail.com>
References: <51B98186.2020100@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Jun 13 11:40:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Un415-0005VG-RB
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 11:40:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758254Ab3FMJkY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jun 2013 05:40:24 -0400
Received: from mail-we0-f169.google.com ([74.125.82.169]:44696 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755464Ab3FMJkX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 05:40:23 -0400
Received: by mail-we0-f169.google.com with SMTP id n57so7880783wev.28
        for <git@vger.kernel.org>; Thu, 13 Jun 2013 02:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=2Wwzpwdxd29BS0Eu50OdsVjqR6KGveDUfMKhSqeuTL8=;
        b=eSa1m0PtxOPx2846jKGx5KVWAl7LuNWRNPBwWf+n2boFQlreAd5DFQ4aDnSNzIaBAD
         pvtxcYphDC6UT4OtHx2JKpbpTkdtuP/tb2nZuMgTVAwUF/EO+QQPWsTa+4IYOi95SpNH
         YxkiwIgrt21SmYQe1aIsayvMcE0sj2/TteJtA8xSRgDCw6EHxByMgnX7dIaVKrWBpdWR
         4FbeKptKDu/8a901lhjgFWR+smMzwzaX7fd28trC1B8R+O4bin7EDNtPUN3GWsPKYrFb
         e/s8sahomT3kjBLK06qLy2jSwpNCi46eL3X6QeFRzxnSp3oCAu6jIpRILKZQwYIJj0HF
         oAPw==
X-Received: by 10.180.87.162 with SMTP id az2mr7061447wib.10.1371116421553;
 Thu, 13 Jun 2013 02:40:21 -0700 (PDT)
Received: by 10.194.176.129 with HTTP; Thu, 13 Jun 2013 02:40:21 -0700 (PDT)
In-Reply-To: <51B98186.2020100@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227710>

2013/6/13 Johannes Sixt <j.sixt@viscovery.net>:
> From: Johannes Sixt <j6t@kdbg.org>
>
> The bash on Windows rewrites paths that look like absolute POSIX paths
> when they are a command-line argument of a regular Windows program, such
> as git and the test helpers. As a consequence, the actual tests performed
> are not what the tests scripts expect.
>
> The tests that need *not* be skipped are those where the two paths passed
> to 'test-path-utils relative_path' have the same prefix and the result is
> expected to be a relative path. This is because the rewriting changes
> "/a/b" to "D:/Src/MSysGit/a/b", and when both inputs are extended the same
> way, this just cancels out in the relative path computation.
>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  t/t0060-path-utils.sh | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>

Thank you for pointing out this cross-platform issue.
I test your patch on Mac OS X, but not test it on msys yet.
Since this issue is from the very first commit of this series
and this series are still in pu, so I move your patch as
patch 02/16 of this series.

You can get the update series in my clone on GitHub:

    $ git remote add jiangxin git://github.com/jiangxin/git.git
    $ git fetch jiangxin jx/clean-interactive
    $ git log --oneline -16 jiangxin/jx/clean-interactive

    c646c test: add t7301 for git-clean--interactive
    92d4a git-clean: add documentation for interactive git-clean
    22e3d git-clean: add ask each interactive action
    5fcb8 git-clean: add select by numbers interactive action
    77ef8e git-clean: add filter by pattern interactive action
    02327 git-clean: use a git-add-interactive compatible UI
    2322 git-clean: add colors to interactive git-clean
    06fad git-clean: show items of del_list in columns
    6ae8b git-clean: add support for -i/--interactive
    1eeb5 git-clean: refactor git-clean into two phases
    3f903 Refactor write_name_quoted_relative, remove unused params
    8ccdf Refactor quote_path_relative, remove unused params
    13da5e quote.c: remove path_relative, use relative_path instead
    1208ee path.c: refactor relative_path(), not only strip prefix
    95b06 t0060: skip a few relative_path tests on Windows
    22247 test: add test cases for relative_path

And commit 95b06 may squash to previous commit 22247.

-- 
Jiang Xin

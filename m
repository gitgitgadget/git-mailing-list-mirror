Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28AC8C433F5
	for <git@archiver.kernel.org>; Mon,  2 May 2022 16:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386217AbiEBQGe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 May 2022 12:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386274AbiEBQGI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 May 2022 12:06:08 -0400
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D922613F81
        for <git@vger.kernel.org>; Mon,  2 May 2022 09:01:57 -0700 (PDT)
Date:   Mon, 02 May 2022 16:01:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bytieful.com;
        s=protonmail2; t=1651507314;
        bh=L8Bkc798Q8PhEWUHhKOuNc+CKJ/VeiAYMLKXLITHBog=;
        h=Date:To:From:Reply-To:Subject:Message-ID:Feedback-ID:From:To:Cc:
         Date:Subject:Reply-To:Feedback-ID:Message-ID;
        b=csy8hIV86/UjEE3g5hg2iojpqpc7KH5f9BaG/pzwwchbLgdqlPybIgAyys9E+h07Z
         IWwa/iCI8Zc1YgnP0YiYO7n/k0FtPoGnDK1pZGN9peSTuYvlCuaqPbOLND/0Ci/Iaa
         Eyo3TMLnetq7e9PFR+XQrYhkWoMOZfYCFzrthrQrUhbMmxwPNfvihtwOEaYByydvxW
         0cRYDh7g3/NC1YBSCqQZu1ztnqigDsr21eY6Lh466hakMpXTFIfR4M4lvCY1mBl4HY
         SVownHphdjWT3JqJ8NeypmzsOt4DXffCa5vK2tyfJPFgH9AKkfZdqMrLyIh4OFwyHP
         1TsyiID+g5RaQ==
To:     git@vger.kernel.org
From:   Erik Aigner <erik@bytieful.com>
Reply-To: Erik Aigner <erik@bytieful.com>
Subject: Support -- pathspec in git-stash show command
Message-ID: <52447774-42E2-4578-8AB9-6F355E56CA80@bytieful.com>
Feedback-ID: 37933895:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

1) Create a stash containing multiple files including `foo/bar.txt`
2) perform `git stash show -p stash@{0} -- foo/bar.txt

What did you expect to happen? (Expected behavior)

The stash patch output would be limited to only the provided pathspec `foo/=
bar.txt`

What happened instead? (Actual behavior)

Error message "Too many revisions specified: 'stash@{0}' 'test/foo.txt'"

What's different between what you expected and what actually happened?

The manpage for git-stash states that the SHOW command should support any a=
rgument the git-diff command also accepts,
but apparently the trailing "-- <pathspec>" does not work with "git stash s=
how".

Anything else you want to add:

For symmetry with git-diff, git-show should also support a pathspec paramet=
er. The reason for this is that `git stash show`
has the stash specific `--include-untracked` paramenter, which git-diff doe=
sn't have.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.32.0 (Apple Git-132)
cpu: arm64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Darwin 21.4.0 Darwin Kernel Version 21.4.0: Fri Mar 18 00:47:26 PDT =
2022; root:xnu-8020.101.4~15/RELEASE_ARM64_T8101 arm64
compiler info: clang: 13.1.6 (clang-1316.0.21.2.3)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh


[Enabled Hooks]
pre-commit

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1528C49EA5
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 15:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCFDB61249
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 15:52:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbhFXPzL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 11:55:11 -0400
Received: from lsp.net ([78.46.242.34]:53254 "EHLO lsp.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231294AbhFXPzK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 11:55:10 -0400
X-Greylist: delayed 610 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Jun 2021 11:55:10 EDT
dkim-signature: v=1; a=rsa-sha256; d=lsp.net; s=lsp191015;
        c=relaxed/relaxed; q=dns/txt; h=From:Subject:Date:Message-ID:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=Bb0cdTvqyEkFiYp4Kyhgv4qDpP6QDrX6uJ9+tTvQbvo=;
        b=bNtjagNmLqkwDww6WjvMMrAp9P8I/1+K5pJI3VfxdykG/OT+mtKwl6D2BIN5SWKxsf8jUnYwBEZqhcvcFtJ/umMpP5bRefB4RmzAlMp/SVBghDMGoOEyOx8xyCz55CqsnjMWunmUngdg8OYUufKQEbpIvqvzr4+poq8ElWY28u/qR5yVqUUIFmlrC+iAxgYiKoFhWyQa9PSryIkHNI5Z8lfAjpOLorSAEms+6bTKI0wkuJhbH7BoVJZu+S
        +ertIqLdlHSmuNQS24TLDplsdcJaBQVAPWrcZtw6uRitugRZ9JZrlmWrWSzB0zkviufAmCGgagsYjC/goMKif2MSE5Jg==
Received: from [192.168.178.21] (zpt30-1_migr-78-197-22-30.fbx.proxad.net
 [78.197.22.30]) by lsp.net with ESMTPSA (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
 bits=128) ; Thu, 24 Jun 2021 17:42:40 +0200
To:     git@vger.kernel.org
From:   Claas Augner <claas.augner@lsp.net>
Subject: Bug: git-stash fails for new file not staged for commit
Message-ID: <f139a5e1-242a-e23b-6eda-b8b49423d70b@lsp.net>
Date:   Thu, 24 Jun 2021 17:42:39 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

 > What did you do before the bug happened?

I tried to stash a new file that I added with `git add --intent-to-add`:

```
$ touch foo
$ git add --intent-to-add foo
$ git stash
```


 > What did you expect to happen?

The file should have been stashed.


 > What happened instead?

The stash failed with the following error message:

```
error: Entry 'foo' not uptodate. Cannot merge.
Cannot save the current worktree state
```


 > What's different between what you expected and what actually happened?

Instead of stashing the file, the stash fails with an error message.


 > Anything else you want to add:

Background: https://github.com/okonet/lint-staged/issues/990


[System Info]
git version:
git version 2.32.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.4.72-microsoft-standard-WSL2 #1 SMP Wed Oct 28 23:40:43=20
UTC 2020 x86_64
compiler info: gnuc: 9.3
libc info: glibc: 2.31
$SHELL (typically, interactive shell): /usr/bin/zsh


[Enabled Hooks]
applypatch-msg
pre-applypatch
post-applypatch
pre-commit
prepare-commit-msg
commit-msg
post-commit
pre-rebase
post-checkout
post-merge
pre-push
pre-receive
update
post-receive
post-update
push-to-checkout
pre-auto-gc
post-rewrite
sendemail-validate

-------------------------------------------
LSP.net GmbH
Prinzregentenstr. 40
10715 Berlin / Germany
T +49 30 20896331
Web: https://www.LSP.net
Blog: https://blog.LSP.net

Return-Path: <SRS0=eUpu=4B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC892C352A3
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 18:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C810E206CC
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 18:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPR2JiQW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbgBMS7O (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Feb 2020 13:59:14 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36034 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbgBMS7N (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Feb 2020 13:59:13 -0500
Received: by mail-wm1-f68.google.com with SMTP id p17so7963625wma.1
        for <git@vger.kernel.org>; Thu, 13 Feb 2020 10:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=394OSXX43Dg1O2qWRMNq8FDnNpiEDupTHzBZsNGVFv0=;
        b=NPR2JiQWk3O2927VsKl3xF5j3gwuN1iWJdlfOrrJWW0dJhEq6iVRkG6Nmc0flJCT6f
         KjfrplbdPnNHbgq1hW/YjtgzqldPKuIp8IYPhb2OgiC9j2ocBe6Q2Wze1Xj5cawLCSXG
         752ejv4pkSh/BE6DfzVZbNXoOntja5AxSnzw3B1kKzvCERjXNXhCg6/94y1XinFVjCoF
         DzHtzxdbJY/c4hVerhQ19ftTMiK+Kf3pFcxXz50KBrnNuKNggvCG7GlhSbHnUoAj87Hq
         LHhgGT6wkAh1qiSG6AMDjn2DzL46RdZ8qkYUqHsBO6rgSeGmiWfwhVB+tc7IIJmQK30t
         wlrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=394OSXX43Dg1O2qWRMNq8FDnNpiEDupTHzBZsNGVFv0=;
        b=lvIuCOTcipNmTxFjichk86lLuwMhEHR0kF4LWbzr5+96VxYXsxKyLneqMdqMfTdjxS
         7XxDcUztHNNBodNUARXRDFtfmBZmCOTrEGvvPUFrIdPB70SEzN2g/QalvFh3a0VAqXoF
         TOGouGU94497O+PYWPb4MiWdFagz8WthYpWzCcZ0NunKaoSXhBf0xK+GhrOwJtqJhstM
         brMiualNxZNRB+cc0W/kR6XsE7kMVkA7gZT2m2D7eo4AOW4aL1K+e77NrcQ9C9ENcvbS
         zi5a694cW4mS8Md7TVqqkn0mv6VpzC9fjXUP/UuH14N1uadIdsG383XpYuCYpGFpVzRj
         BnEg==
X-Gm-Message-State: APjAAAWkhz3ppGreRPYziG9MkaPGWQpwFRdJjmE/TwAZjvzh1KRwtfF6
        wC2d3ihmHnCPmU54nZ+qlH14vqPr
X-Google-Smtp-Source: APXvYqzWJEJNy3LzLHxUyg0nXrfEs/TdYd7sqUaFQ3MFAEW28KH6wzAbfGqQVgBVAG2XStHNOUcEOQ==
X-Received: by 2002:a1c:7d8b:: with SMTP id y133mr7402414wmc.165.1581620351926;
        Thu, 13 Feb 2020 10:59:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c9sm3873346wrq.44.2020.02.13.10.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 10:59:11 -0800 (PST)
Message-Id: <pull.535.git.1581620351.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 13 Feb 2020 18:59:07 +0000
Subject: [PATCH 0/3] [GSoC] receive.denyCurrentBranch: respect all worktrees
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Hariom Verma <hariom18599@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The receive.denyCurrentBranch config option controls what happens if you
push to a branch that is checkout into a non-bare repository. By default, it
rejects it. It can be disabled via ignore or warn. Another yet trickier
option is updateInstead.

When receive.denyCurrentBranch is set to updateInstead, a push that tries to
update the branch that is currently checked out is accepted only when the
index and the working tree exactly matches the currently checked out commit,
in which case the index and the working tree are updated to match the pushed
commit. Otherwise, the push is refused.

However, this setting was forgotten when the git worktree command was
introduced: only the main worktree's current branch is respected. [ fixes:
#331 ]

Incidently, this change also fixes another bug i.e. 
receive.denyCurrentBranch = true was ignored when pushing into a non-bare
repository's unborn current branch.

Thanks, @dscho for helping me out.

Regards, Hariom

Hariom Verma (3):
  get_main_worktree(): allow it to be called in the Git directory
  t5509: initialized `pushee` as bare repository
  receive.denyCurrentBranch: respect all worktrees

 builtin/receive-pack.c           | 37 +++++++++++++++++---------------
 t/t5509-fetch-push-namespaces.sh |  2 +-
 t/t5516-fetch-push.sh            | 11 ++++++++++
 worktree.c                       |  1 +
 4 files changed, 33 insertions(+), 18 deletions(-)


base-commit: 232378479ee6c66206d47a9be175e3a39682aea6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-535%2Fharry-hov%2Fdeny-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-535/harry-hov/deny-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/535
-- 
gitgitgadget

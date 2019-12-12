Return-Path: <SRS0=AaZj=2C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B340C2D0C9
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 14:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 321AE2253D
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 14:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OldeYnjb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729745AbfLLOga (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Dec 2019 09:36:30 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34201 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729698AbfLLOga (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Dec 2019 09:36:30 -0500
Received: by mail-wr1-f68.google.com with SMTP id t2so3014496wrr.1
        for <git@vger.kernel.org>; Thu, 12 Dec 2019 06:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MybhsUPZ79z1yOcG4p/4lYvkTj+f6wafOZ8uoXydn3A=;
        b=OldeYnjbFi2DrVTnCibsaYDpfbNCnDpBHhF5n+EyE2rJ1hxQ3do/ZLHJDvR3Za5+EW
         nfHCnEMWg/zdlNBtQnInKZTsodE7T/Boo8qwADue8UX43/qygeUAsHnrl1o1uw/fkf0i
         MKYDwOJcMvodCzhxfbPq77c9+Gx3P0dc7gr9fU6+EJJCsx8Cs+7WTveVap7sZ4BvA48d
         fIYQM4hUec5VvfuNtWBB20gRl1lq5XmICevsrVwkwG4Kwz6/2gCUcwVeMA67XMYGAfk4
         +s34uAwMx8oJzqwkCyG4NOIMw6hpFVT0kwqKldA1DGLOylhRomlglRAj7B3ByYAN/wNg
         wycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MybhsUPZ79z1yOcG4p/4lYvkTj+f6wafOZ8uoXydn3A=;
        b=pILhh3JwhahuE6JOUnH8uoKCfiKuBhOVwOcaGJz/D3ntEpT5hBnl6LDF47X9OlKA5Z
         mBxaWB2BDLB153PQfsf0nsH2UErz+Wye4RRozZbbobLyOMfEcuvZxGxU0XBFx56MZcRY
         SN4d/m34jf0wdEUlOXZdf6xAbBCWmDOQtlKz4njyZlKBmnMpmg2F4OWUkCgtaQCKOnWm
         kP+KipS/O3ckT5bJ/VxtFBSFebojUTE64lMnrtP5SA+9InFFdGgC5uVLrRNuFUTVh+7V
         hRqKsMPC2V5sCBA4k6x+nu25Ez6lybVDIARHng82ZFXZZ7f8QMNZ1B3wNbvTmu7STsKR
         OlPw==
X-Gm-Message-State: APjAAAVDwOUBeOSr/VFyXXGePmNGKAkbsxMevK6/OhWlBmknd6vEnFUH
        quWM6Z1tafmFA557Ky1wx1qWFILN
X-Google-Smtp-Source: APXvYqy+4mUPHygEh54fdtRh/1yNdGJhuDLf18UkpW+Ny7tTHCYnIz0OKPsPO5f2fcWJS4xCG5RD0Q==
X-Received: by 2002:adf:f1c6:: with SMTP id z6mr7026410wro.279.1576161387837;
        Thu, 12 Dec 2019 06:36:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 188sm443996wmd.1.2019.12.12.06.36.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Dec 2019 06:36:27 -0800 (PST)
Message-Id: <c0980519ed319295c273d358b0547340cc511a6b.1576161385.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.490.git.1576161385.gitgitgadget@gmail.com>
References: <pull.490.git.1576161385.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 12 Dec 2019 14:36:11 +0000
Subject: [PATCH 02/16] commit: forbid --pathspec-from-file --all
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano" 
        <gitster@pobox.com>, Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>

I forgot this in my previous patch `--pathspec-from-file` for
`git commit` [1]. When both `--pathspec-from-file` and `--all` were
specified, `--all` took precedence and `--pathspec-from-file` was
ignored. Before `--pathspec-from-file` was implemented, this case was
prevented by this check in `parse_and_validate_options()` :

    die(_("paths '%s ...' with -a does not make sense"), argv[0]);

It is unfortunate that these two cases are disconnected. This came as
result of how the code was laid out before my patches, where `pathspec`
is parsed outside of `parse_and_validate_options()`. This branch is
already full of refactoring patches and I did not dare to go for another
one.

Fix by mirroring `die()` for `--pathspec-from-file` as well.

[1] Commit e440fc58 ("commit: support the --pathspec-from-file option" 2019-11-19)

Co-authored-by: Phillip Wood <phillip.wood123@gmail.com>
Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 builtin/commit.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/commit.c b/builtin/commit.c
index 2db2ad0de4..893a9f29b2 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -347,6 +347,9 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 		if (interactive)
 			die(_("--pathspec-from-file is incompatible with --interactive/--patch"));
 
+		if (all)
+			die(_("--pathspec-from-file with -a does not make sense"));
+
 		if (pathspec.nr)
 			die(_("--pathspec-from-file is incompatible with pathspec arguments"));
 
-- 
gitgitgadget


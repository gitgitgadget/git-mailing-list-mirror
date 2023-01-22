Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5349BC54EED
	for <git@archiver.kernel.org>; Sun, 22 Jan 2023 06:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjAVGNC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Jan 2023 01:13:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjAVGMw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jan 2023 01:12:52 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463C018A93
        for <git@vger.kernel.org>; Sat, 21 Jan 2023 22:12:50 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id e19-20020a05600c439300b003db1cac0c1fso6990533wmn.5
        for <git@vger.kernel.org>; Sat, 21 Jan 2023 22:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bQT8ZRnPmMCCn/HjLUYgksMaDlS8hm85UOkuFMXUm2Q=;
        b=fNfYG78HuHt3hWZ7cnXnTKbOHmphFHZsClbk2NNFbYzbUfBkwUBogW/NQ9p/dqdwxW
         c68zvfErAYf4+gAiwnd/sMLJ8k/ef5mbGzgAJNaCkSsGnoACFY/BpKYP8mbrIG5LAlwu
         pk5OyXx5tzubCfE0YWK9RO8+jAECLUoI+ut2zh57KgsWiAEmh/JIUgElBDJjpxpR+k05
         +FhpoIur7YX8ue9z7n9jaKclntNbYwMNs6JorCtBehFG8SlzMJ51pyeg/tV6PL3xVhvT
         5EvAsM5UO4Ms0me5Ba749f34WvBB5NSbuHE43J9p6Sqk7UdJ+/k+FoDvsl27XBQqsQK+
         92Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bQT8ZRnPmMCCn/HjLUYgksMaDlS8hm85UOkuFMXUm2Q=;
        b=nyqAnWX9KXnISl5w/j6xViKjxKLvKZ4fqyYUxhGPlmdTWIkxK7WGjBd3IZHPs8vZdb
         tlqRYKwp/KLcGbcZPCH2RQ3C0xvtSiUGglf+R/N99RpuInea0Ce7PRmhJoot2loGJwuJ
         y8B+yUBqqElp/zBhB2Zo4SlwTFaroGnG6OEk9QILumNSTmzXtXunocyVYlwPCwsabvZW
         7tL/8XwQEtQPgXmOraZmP8bDn93gMGREPNfnn6Pv/STWtctnbKPZxf0ATMJpsfDLR3Mx
         eCVM0j25q/PYg7uTrKBMGgmkpfSmfCDF208loxzQuzvYLnjCxKsjhjCHTxLGwg0jM1A2
         QBbA==
X-Gm-Message-State: AFqh2kq6hBbhU1PY+hCrKhWzxXVzv/Kxi4DCaZ+OmKRv/1mqmlmuiRiE
        q6gcrrsq7YkkZ3h50WNV6WiZPo8aII0=
X-Google-Smtp-Source: AMrXdXsCcyHBpZ4vkh2bnRKVuSR2DRv0P7vOZPY9MqN56NZHuzS8QbR7wTeCX+88haDO0Sq16zOeVA==
X-Received: by 2002:a05:600c:539a:b0:3d9:ef72:190d with SMTP id hg26-20020a05600c539a00b003d9ef72190dmr19189251wmb.19.1674367968652;
        Sat, 21 Jan 2023 22:12:48 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l18-20020a1c7912000000b003db00747fdesm7008727wme.15.2023.01.21.22.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 22:12:48 -0800 (PST)
Message-Id: <a8adf7fda61f6651d739c2209c38775b59923eec.1674367961.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1466.v4.git.1674367961.gitgitgadget@gmail.com>
References: <pull.1466.v3.git.1674266126.gitgitgadget@gmail.com>
        <pull.1466.v4.git.1674367961.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 22 Jan 2023 06:12:39 +0000
Subject: [PATCH v4 8/9] rebase: put rebase_options initialization in single
 place
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/rebase.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index ed7475804cb..2358605b254 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -134,6 +134,8 @@ struct rebase_options {
 		.exec = STRING_LIST_INIT_NODUP,		\
 		.git_format_patch_opt = STRBUF_INIT,	\
 		.fork_point = -1,			\
+		.reapply_cherry_picks = -1,             \
+		.allow_empty_message = 1,               \
 	}
 
 static struct replay_opts get_replay_opts(const struct rebase_options *opts)
@@ -1158,8 +1160,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	prepare_repo_settings(the_repository);
 	the_repository->settings.command_requires_full_index = 0;
 
-	options.reapply_cherry_picks = -1;
-	options.allow_empty_message = 1;
 	git_config(rebase_config, &options);
 	/* options.gpg_sign_opt will be either "-S" or NULL */
 	gpg_sign = options.gpg_sign_opt ? "" : NULL;
-- 
gitgitgadget


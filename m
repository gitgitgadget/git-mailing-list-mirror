Return-Path: <SRS0=KYeX=53=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3209C2BB86
	for <git@archiver.kernel.org>; Sat, 11 Apr 2020 01:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC68B2082D
	for <git@archiver.kernel.org>; Sat, 11 Apr 2020 01:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0kPsU8E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgDKBDH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 21:03:07 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37424 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbgDKBDG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 21:03:06 -0400
Received: by mail-wm1-f67.google.com with SMTP id z6so4431647wml.2
        for <git@vger.kernel.org>; Fri, 10 Apr 2020 18:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cwO3T4kpcBK2FOtxRAPUjX2u87eyKgSLVIKbRGrqg5g=;
        b=S0kPsU8EydQxVSErhH+izu5yvHhR3vhkN++o5GPn1nREFljKWofDP54q+F/fA2vzGi
         rRp7XORxpPPg9DCEKrs53h37xusCUNAnGS9+AmqaBwwei76o5QO0BQEl8rsdJJcZaugq
         +n1kWKNzjqJKlrtZSMoowFHKscYw1jO4Aisa2QJV6RfxeAhSbxeimmUiGc/qWNdvlnJ+
         L+UdfIQ38bgxBiSjOje6Vm+zzghrdCH4Hj5Lnl3lsG3fhIsN0HZfSTdprNhUVkeBYD58
         jl3UF315mRjXoDhCv+K/es6YIqmS2UtfnvSNQOU3AfvJXc4F35Ndn+M0LDX/Yl1N4DBf
         FFwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cwO3T4kpcBK2FOtxRAPUjX2u87eyKgSLVIKbRGrqg5g=;
        b=XqbodIP+fFXduS5iqz40zKQhfDVZNjT9oCaYK0oqys2FyY/QVWCOnlZZs1Km86p3xY
         Hp18KrfQLVE4u5XkQ8N3nenfatcM2+yWuvJYEgeRRj5U03lTR4d2yvyUzQDofd3X3tSx
         yM/ne4oXiTgU2izrnavxJ7hA6dDWoirtUAGQ8KqZePbqxqTO3Gbj5MBX3HWWwy8GgYQ1
         r+15U6D7fsisiPbolKU0zArnSaqxSxZAcIIjv1+NAWkg29fFSGblAyhCIklki5OBDHgJ
         ubzyVYj4to0cs98qnd0r70g2aIeVK6l8u5Svwn0UsMjkiElGqsbbJL+1uf3Tb6uOAuyD
         AS1A==
X-Gm-Message-State: AGi0PuZst7XvlmCKFhAHPzKNiK3T133Ci5/fWSmiPJXjDxS4+5ZmEcHo
        lH7dEeVrFe/y8167niEMvrkfZUd3
X-Google-Smtp-Source: APiQypK3AjX9PMLxC3T746eMTd1lic68jsciLQfQr2UqUtnPhMRQKx/cHiF3mPX6qt/9dAdtcP31cg==
X-Received: by 2002:a1c:730d:: with SMTP id d13mr4954540wmb.103.1586566984888;
        Fri, 10 Apr 2020 18:03:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n6sm5032478wrs.81.2020.04.10.18.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 18:03:04 -0700 (PDT)
Message-Id: <bb5ce39d0283f14095d87dd0645e641ae799f16c.1586566981.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.609.git.1586566981.gitgitgadget@gmail.com>
References: <pull.609.git.1586566981.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 11 Apr 2020 01:03:00 +0000
Subject: [PATCH 2/3] commit: write commit-graph with bloom filters
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, jnareb@gmail.com, garimasigit@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The GIT_TEST_COMMIT_GRAPH environment variable updates the commit-
graph file whenever "git commit" is run, ensuring that we always
have an updated commit-graph throughout the test suite. The
GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS environment variable was
introduced to write the changed-path Bloom filters whenever "git
commit-graph write" is run. However, the GIT_TEST_COMMIT_GRAPH
trick doesn't launch a separate process and instead writes it
directly.

Update the "git commit" builtin to write changed-path Bloom filters
when both GIT_TEST_COMMIT_GRAPH and GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS
are enabled.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/commit.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index d3e7781e658..d2fdfdc4363 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1701,7 +1701,9 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		      "not exceeded, and then \"git restore --staged :/\" to recover."));
 
 	if (git_env_bool(GIT_TEST_COMMIT_GRAPH, 0) &&
-	    write_commit_graph_reachable(the_repository->objects->odb, 0, NULL))
+	    write_commit_graph_reachable(the_repository->objects->odb,
+					 git_env_bool(GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS, 0) ? COMMIT_GRAPH_WRITE_BLOOM_FILTERS : 0,
+					 NULL))
 		return 1;
 
 	repo_rerere(the_repository, 0);
-- 
gitgitgadget


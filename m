Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76AB620357
	for <e@80x24.org>; Mon, 10 Jul 2017 21:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754867AbdGJV4j (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 17:56:39 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:32813 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754829AbdGJV4h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 17:56:37 -0400
Received: by mail-lf0-f68.google.com with SMTP id t72so12344199lff.0
        for <git@vger.kernel.org>; Mon, 10 Jul 2017 14:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IEm8v6FE32BIq7TCCbt59UUDOdr//grO+ffoEqQ3UuA=;
        b=Qo17jQhMrIfb51c5Yq5zPcigQlSGBL71WjywrT45qBnkVqXBSRwPXAahvQDErF2ymG
         EqbBKzG5rELgTTjn3ij0stomR4gWDaD01+d0Aywy1Py8fMMChzN7Zhy6kJ4IP9EnDba5
         SgHZYi6zPiqfU18L81K0sprdhCmqzZt9MplZbrjB1MpSPQ5jCf7+35n54zllytCUTVLS
         nS/QbAi4I0HghC5w/i2fAasjhF3XSu5U5Umgxlv7LyHfr3Fo2J9ZbwOlwP+XfE0FLphm
         yqICSxgPNAKyBJmQZ6RdZiDeF1755gfF1T2OhxDfMc1kwB7eNJuUA41hOZ6EKIPPptsa
         /Diw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IEm8v6FE32BIq7TCCbt59UUDOdr//grO+ffoEqQ3UuA=;
        b=r0/s6iQgyZ6FeJHUhoIqaeXO0dlVKYCyK7DGbA1h/Nu40/kRR0HPChGz8IzaFKOuPS
         WCgpYX7BPPQqgLWwjXI7D8gdk6s6Lf+via4QlfgobAYa+GOQQvMpo7iW2YghsL6BVbZT
         mNIf6hh0kJr0mBJO3X15HCNcaJjp1UQK0407IbDlTLMSDTyKRDgTUEmqHMz67Ufenq49
         PBnOLDvfuzZ2VTqGTG39hlBSVH2IGQT/Wsy43c/UBV0EULWi3ytCnAB7ZtQ23QgCPbxt
         brNIz0/kN3rQa3urWgiFdJA1SAe5JuoQUJUqd4jhCWP4iBd52PAKkAyMyoG56OaljOaE
         9qjQ==
X-Gm-Message-State: AIVw113k/2v2SAOAqJj6pVm2HyP87mK1mC9gd1rvN5QLr7/9elIyE5cm
        WTtvCgF7efDzxkk0Gf0=
X-Received: by 10.25.37.208 with SMTP id l199mr2108091lfl.181.1499723790457;
        Mon, 10 Jul 2017 14:56:30 -0700 (PDT)
Received: from localhost.localdomain (78-66-223-92-no2204.tbcn.telia.com. [78.66.223.92])
        by smtp.gmail.com with ESMTPSA id x13sm2617077ljd.64.2017.07.10.14.56.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Jul 2017 14:56:29 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Brandon Williams <bmwill@google.com>
Subject: [PATCH 5/7] tag: handle `pager.tag`-configuration within the builtin
Date:   Mon, 10 Jul 2017 23:55:18 +0200
Message-Id: <c5bb98f94757b94c09d0be27dce0df9d07d9eb6f.1499723297.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.13.2.653.gfb5159d
In-Reply-To: <cover.1499723297.git.martin.agren@gmail.com>
References: <cover.1499723297.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the mechanisms introduced in two earlier patches to ignore
`pager.tag` in git.c and let the `git tag` builtin handle it on its own.

This is in preparation for the next patch, where we will want to handle
slightly different configuration variables depending on which options
are used with `git tag`. For this reason, place the call to
setup_auto_pager() after the options have been parsed.

No functional change is intended. That said, there is a window between
where the pager is started before and after this patch, and if an error
occurs within this window, as of this patch the error message might not
be paged where it would have been paged before. Since
operation-parsing has to happen inside this window, a difference can be
seen with, e.g., `git -c pager.tag="echo pager is used" tag
--unknown-option`. This change in paging-behavior should be acceptable
since it only affects erroneous usages.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 builtin/tag.c | 2 ++
 git.c         | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 01154ea8d..e0f129872 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -446,6 +446,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, prefix, options, git_tag_usage, 0);
 
+	setup_auto_pager("tag", 0);
+
 	if (keyid) {
 		opt.sign = 1;
 		set_signing_key(keyid);
diff --git a/git.c b/git.c
index 696eaf87a..4d05452a3 100644
--- a/git.c
+++ b/git.c
@@ -489,7 +489,7 @@ static struct cmd_struct commands[] = {
 	{ "stripspace", cmd_stripspace },
 	{ "submodule--helper", cmd_submodule__helper, RUN_SETUP | SUPPORT_SUPER_PREFIX},
 	{ "symbolic-ref", cmd_symbolic_ref, RUN_SETUP },
-	{ "tag", cmd_tag, RUN_SETUP },
+	{ "tag", cmd_tag, RUN_SETUP | IGNORE_PAGER_CONFIG },
 	{ "unpack-file", cmd_unpack_file, RUN_SETUP },
 	{ "unpack-objects", cmd_unpack_objects, RUN_SETUP },
 	{ "update-index", cmd_update_index, RUN_SETUP },
-- 
2.13.2.653.gfb5159d


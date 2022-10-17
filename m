Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1235CC4332F
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 13:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiJQNSN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 09:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbiJQNR4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 09:17:56 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4B95C9E8
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 06:17:54 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id m29-20020a05600c3b1d00b003c6bf423c71so12260733wms.0
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 06:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LF+NGj9dormuMpuEtDjpx1ozsfBQtYr1oEqnz9zZelw=;
        b=Ku5lrJ7STgAAAB5sH41bLS4mM1QOevLYPpF/+p1uVMZZGA7LMk18+oOUE6nB6WGKIp
         oGwTORmy5s7W5Mdsfp80OLYYvJf3L/1wnu/zVxdFD8DSkk9eKbz4c7185WoXjSN6E9Sl
         3hiZECW2Co2c7Up2ipJekqOY4fpKXB3qL8K/6zllL9dsCw/iJFOdYlR9rICadBLCxK4b
         NTym/fsKoMot5Db+io3pqiD9In2C6nOQz/OTDau8uDk7elpTYiacbfFZdQ3jIPXDTZ64
         zlrXu3AYOUbPkGoCapyTZD7dBK5vTENKZ6+k5bjxYoxL8GnfQGkv+XqOvaiN1S0xKkXP
         6cNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LF+NGj9dormuMpuEtDjpx1ozsfBQtYr1oEqnz9zZelw=;
        b=O4V+Ha9WTyu5Iu/mKxHY5/26RaOHPrEo+GLzJeSw/fITjqCiSu0G68hHQrsRBC+Tu0
         lzu7gf6TVVx9KWoOPlaKImhjWuxevS2JFBl7zXCG49HC0fkB2UkoqSHjdfiaz0cLeCQ0
         RSHJmNukJtv9jrznBPlcmn7qTC/LD5666YmI+RDkv3rWRfyqxcyzlReYsTCvq6exMLEb
         Y+lb+4my5VeMDXQ/CpY6MuBfnnsuDrglG5D2Q66VAToQ936S2k0GaTwdQDOywzoEpM5s
         UL3KWHNitarf6YoM7ihkwnLqP0pAm6y/uGfYzZK2upKEq0kzD07JOPGqtVp2iDSJlD+g
         8JRw==
X-Gm-Message-State: ACrzQf16UvOLuUMJV3m7xmYvEf/HsRRZ60Bb0QIkj6BqzL3LTzPCaDZY
        ZT6peiAd0qu3Y5+7i0mmv5Ct1gEbPLQ=
X-Google-Smtp-Source: AMsMyM4fsj6QVvhhfoS0siczhpgq3pPNPOb5wkxXxXwKLWVL43kTUDEc8vyZSFxzyywGAx7tnfW4mw==
X-Received: by 2002:a05:600c:46ce:b0:3c6:f243:8d74 with SMTP id q14-20020a05600c46ce00b003c6f2438d74mr6861889wmo.166.1666012672370;
        Mon, 17 Oct 2022 06:17:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l1-20020a5d4bc1000000b0022afe4fb459sm3624747wrt.51.2022.10.17.06.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 06:17:51 -0700 (PDT)
Message-Id: <bd24409a266798aba5fffb5fde2e70065ba28a0c.1666012665.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1323.v4.git.1666012665.gitgitgadget@gmail.com>
References: <pull.1323.v3.git.1665650564.gitgitgadget@gmail.com>
        <pull.1323.v4.git.1666012665.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 17 Oct 2022 13:17:43 +0000
Subject: [PATCH v4 6/8] rebase: factor out branch_base calculation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Separate out calculating the merge base between 'onto' and 'HEAD' from
the check for whether we can fast-forward or not. This means we can skip
the fast-forward checks when the rebase is forced and avoid calculating
the merge-base between 'HEAD' and 'onto' when --keep-base is given.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index d70b9b248fa..90ae8fd8de7 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -871,13 +871,9 @@ static int can_fast_forward(struct commit *onto, struct commit *upstream,
 	struct commit_list *merge_bases = NULL;
 	int res = 0;
 
-	merge_bases = get_merge_bases(onto, head);
-	if (!merge_bases || merge_bases->next) {
-		oidcpy(branch_base, null_oid());
-		goto done;
-	}
+	if (is_null_oid(branch_base))
+		goto done; /* fill_branch_base() found multiple merge bases */
 
-	oidcpy(branch_base, &merge_bases->item->object.oid);
 	if (!oideq(branch_base, &onto->object.oid))
 		goto done;
 
@@ -887,7 +883,6 @@ static int can_fast_forward(struct commit *onto, struct commit *upstream,
 	if (!upstream)
 		goto done;
 
-	free_commit_list(merge_bases);
 	merge_bases = get_merge_bases(upstream, head);
 	if (!merge_bases || merge_bases->next)
 		goto done;
@@ -902,6 +897,20 @@ done:
 	return res && is_linear_history(onto, head);
 }
 
+static void fill_branch_base(struct rebase_options *options,
+			    struct object_id *branch_base)
+{
+	struct commit_list *merge_bases = NULL;
+
+	merge_bases = get_merge_bases(options->onto, options->orig_head);
+	if (!merge_bases || merge_bases->next)
+		oidcpy(branch_base, null_oid());
+	else
+		oidcpy(branch_base, &merge_bases->item->object.oid);
+
+	free_commit_list(merge_bases);
+}
+
 static int parse_opt_am(const struct option *opt, const char *arg, int unset)
 {
 	struct rebase_options *opts = opt->value;
@@ -1669,6 +1678,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		if (!options.onto)
 			die(_("Does not point to a valid commit '%s'"),
 				options.onto_name);
+		fill_branch_base(&options, &branch_base);
 	}
 
 	if (options.fork_point > 0)
@@ -1698,13 +1708,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	 * Check if we are already based on onto with linear history,
 	 * in which case we could fast-forward without replacing the commits
 	 * with new commits recreated by replaying their changes.
-	 *
-	 * Note that can_fast_forward() initializes branch_base, so we have to
-	 * call it before checking allow_preemptive_ff.
 	 */
-	if (can_fast_forward(options.onto, options.upstream, options.restrict_revision,
-		    options.orig_head, &branch_base) &&
-	    allow_preemptive_ff) {
+	if (allow_preemptive_ff &&
+	    can_fast_forward(options.onto, options.upstream, options.restrict_revision,
+			     options.orig_head, &branch_base)) {
 		int flag;
 
 		if (!(options.flags & REBASE_FORCE)) {
-- 
gitgitgadget


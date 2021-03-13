Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F60AC43381
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 13:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3071B64F32
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 13:43:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233695AbhCMNm4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Mar 2021 08:42:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233423AbhCMNmq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Mar 2021 08:42:46 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749F2C061574
        for <git@vger.kernel.org>; Sat, 13 Mar 2021 05:42:46 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id a188so3760737pfb.4
        for <git@vger.kernel.org>; Sat, 13 Mar 2021 05:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2bXx0RP2s2KtOj0KNgjWdikeSWx2iyRHCYDjCMimRM4=;
        b=l+N8R5bbpD4w0OqlHbfp0TQiO5Km0ikdafL2rSaND5UKqd1C3K3JrR1Vp21MZX2jSC
         fI0LJd6ce4qK8Sb3r3IjYg/beDN75AeWjyX07a9HsfKHqt2hZYKb2dsfI0vswkrGqAcS
         g2mtfGFeCD0RSs4N2uC7N3MmbfgQlnfwZsPW2T4bPMPqInT9/85Xig6LQbVTTTrK/Tv5
         Qv28uWcoslf+Ei8+pGxUPnKAQHRoZfBUvw2qAnAp90QmBvgCokptn7y+l2BnQA2BgJ2i
         llsXvsTFYZmeX6QAd/iGi5scurXxnDRREf59Ma6kZuyhLlodFHHoYx7lpsgd8YxsmkFW
         Z7Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2bXx0RP2s2KtOj0KNgjWdikeSWx2iyRHCYDjCMimRM4=;
        b=dacf/vlq2zUTaDxSGhnBh07jphaRmK0S9nm0K/z1hc0hoXUvpM4Bl4O/DCFCHmhVZt
         FXYNQhQuxplNMqjznyeW8IXKfYb4iVZ6Ao+2bECE6fxCVXYyi9ZEnbnERuL6jomO17YB
         k7D3orxhI89MAHPS+tQqeWbLnPCkR0fjMmcGJT8N/SmaF6+Ath0TvFfdvlkcLBRtGN+T
         JxGh84P9PEeXYkuf8BpHfHVgXtrkODEHcL0MuoHVtQY0GjKwP3rwn6KULlQ263yUQPuy
         sBNzI1x/jvqTTWoO95jLqtH8ejatNq3pMN1LHOut6JYX5EGrTcj68DXVllKhJu3/LkS6
         1Isg==
X-Gm-Message-State: AOAM531HW6APZWkiXEe/pnwAQ/5aIkQvm/Xg+BGv/auRJxmFVLLiz/rH
        zQHHZn8fad/kuNXmH4vBU18XYPoU4z2U2g==
X-Google-Smtp-Source: ABdhPJwspNJ7EA7vVHtfIXxAF5xHrDcewueQg9gU//yrO6oDmn9Dzm/uQIpzmdZDbU5vZwDPPbboEA==
X-Received: by 2002:a65:538f:: with SMTP id x15mr14304014pgq.429.1615642965354;
        Sat, 13 Mar 2021 05:42:45 -0800 (PST)
Received: from localhost.localdomain ([2409:4050:2d98:f55e:3466:3377:eaba:8d02])
        by smtp.googlemail.com with ESMTPSA id y20sm8657809pfo.210.2021.03.13.05.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Mar 2021 05:42:44 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com,
        phillip.wood123@gmail.com, sunshine@sunshineco.com,
        Charvi Mendiratta <charvi077@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v5 3/6] commit: add a reword suboption to --fixup
Date:   Sat, 13 Mar 2021 19:10:10 +0530
Message-Id: <20210313134012.20658-4-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210310194306.32565-1-charvi077@gmail.com>
References: <20210310194306.32565-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`git commit --fixup=reword:<commit>` aliases
`--fixup=amend:<commit> --only`, where it creates an empty "amend!"
commit that will reword <commit> without changing its contents when
it is rebased with `--autosquash`.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 builtin/commit.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 55712fdc7b..749d32205a 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1188,6 +1188,19 @@ static void finalize_deferred_config(struct wt_status *s)
 		s->ahead_behind_flags = AHEAD_BEHIND_FULL;
 }
 
+static void check_fixup_reword_options(int argc, const char *argv[]) {
+	if (whence != FROM_COMMIT) {
+		if (whence == FROM_MERGE)
+			die(_("You are in the middle of a merge -- cannot reword."));
+		else if (is_from_cherry_pick(whence))
+			die(_("You are in the middle of a cherry-pick -- cannot reword."));
+	}
+	if (argc)
+		die(_("cannot combine reword option of --fixup with path '%s'"), *argv);
+	if (patch_interactive || interactive || all || also || only)
+		die(_("reword option of --fixup is mutually exclusive with --patch/--interactive/--all/--include/--only"));
+}
+
 /* returns the length of intial segment of alpha characters only */
 static size_t skip_suboption(char *fixup_message) {
 	const char alphas[] = "abcdefghijklmnopqrstuvwxyz";
@@ -1275,8 +1288,9 @@ static int parse_and_validate_options(int argc, const char *argv[],
 		 * We limit --fixup's suboptions to only alpha characters.
 		 * If the first character after a run of alpha is colon,
 		 * then the part before the colon may be a known suboption
-		 * name `amend` or a misspelt suboption name. In this case,
-		 * we treat it as --fixup=<suboption>:<arg>.
+		 * name like `amend` or `reword`, or a misspelt suboption
+		 * name. In either case, we treat it as
+		 * --fixup=<suboption>:<arg>.
 		 *
 		 * Otherwise, we are dealing with --fixup=<commit>.
 		 */
@@ -1284,9 +1298,14 @@ static int parse_and_validate_options(int argc, const char *argv[],
 		if (len && fixup_message[len] == ':') {
 			fixup_message[len++] = '\0';
 			fixup_commit = fixup_message + len;
-			if (!strcmp("amend", fixup_message)) {
+			if (!strcmp("amend", fixup_message) ||
+			    !strcmp("reword", fixup_message)) {
 				fixup_prefix = "amend";
 				allow_empty = 1;
+				if (*fixup_message == 'r') {
+					check_fixup_reword_options(argc, argv);
+					only = 1;
+				}
 			} else {
 				die(_("unknown option: --fixup=%s:%s"), fixup_message, fixup_commit);
 			}
@@ -1575,10 +1594,10 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		OPT_STRING('c', "reedit-message", &edit_message, N_("commit"), N_("reuse and edit message from specified commit")),
 		OPT_STRING('C', "reuse-message", &use_message, N_("commit"), N_("reuse message from specified commit")),
 		/*
-		 * TRANSLATORS: Leave "[amend:]" as-is, and
-		 * only translate <commit>.
+		 * TRANSLATORS: Leave "[(amend|reword):]" as-is,
+		 * and only translate <commit>.
 		 */
-		OPT_STRING(0, "fixup", &fixup_message, N_("[amend:]commit"), N_("use autosquash formatted message to fixup or amend specified commit")),
+		OPT_STRING(0, "fixup", &fixup_message, N_("[(amend|reword):]commit"), N_("use autosquash formatted message to fixup or amend/reword specified commit")),
 		OPT_STRING(0, "squash", &squash_message, N_("commit"), N_("use autosquash formatted message to squash specified commit")),
 		OPT_BOOL(0, "reset-author", &renew_authorship, N_("the commit is authored by me now (used with -C/-c/--amend)")),
 		OPT_BOOL('s', "signoff", &signoff, N_("add a Signed-off-by trailer")),
-- 
2.29.0.rc1


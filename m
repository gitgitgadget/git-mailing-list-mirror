Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E4E3C4321E
	for <git@archiver.kernel.org>; Wed, 30 Nov 2022 20:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiK3Ubm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Nov 2022 15:31:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiK3UbU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2022 15:31:20 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0146E83252
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 12:31:01 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id k18-20020a170902c41200b001896d523dc8so15318164plk.19
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 12:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6ZAi/d3yauFyq9ST7Ptxe9GujkLxsPKbmBtXc/BCexc=;
        b=i8lVeAlqmxTGnmYwm+0/5n8hSTZzwQu5S/sKYNsutL5z0HYnTKL90iVm/AlQ1g8Fld
         Nf+wQmpbFo94WB0zpd9MUtPadGZDsiiG7pOxXXaqV8NdfPlgNGBpIkJRcWsy/aFBPsuI
         788cOd3e9yvI4FQ6LauEU0xlsRC/X4uJdPRqvob5ycE564ZDSd+TEiTe5LLFQLEhSzUd
         l/AtQUFNgIdG2rAO+mwr7QIWRsPEvyFWnsXEduz/54q7hrzvFvomv+EdC5RpWLavrMuW
         G+majJ60Yu5p++JEEIHaH/RBESebaQgsdy+VmEdTJMc5+ihLAxIIHjzwalxS6iOtXocL
         Dqpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6ZAi/d3yauFyq9ST7Ptxe9GujkLxsPKbmBtXc/BCexc=;
        b=0Xq9z7JN0CrDiy+3ErugAKy0AsrCgnEKMpTRuritfx7qKglQoowKK237u48BwrArcp
         SdSTo8LxicJ1NtluQux2+oRStnU6lEWhcNEOb8YvbZ2QQa5LHyQrvUZ4x/e0Fog0MNRU
         hOhO18+xjNCJY9U1TzXo+b9NpKnMAUZQ/GRZ6MGkAkNgHroRzQFPcpsOSS52VB3ZWyg7
         1OsNayKGZmBQXM9Ze7NkB+2tmY43s6WnkI1MIDvwZ6qEEJUHt8N8EtyMbrxNK17I1f9+
         EQwvgxYA2taAcE9fF4BdjN05EeI7qhH2O0S/VovgJAzPVRqxJp87KQ/oL+vMvliWS+yx
         z2Nw==
X-Gm-Message-State: ANoB5pmGCvcjGSBFh4yoTxHAUIeWzbBf7essmrYTOVSZHYveXl39krX2
        Vv6kVhjfZ++4bL8Qm4fAlncvcJ+Du/JytrnVmAfpO5st1UX7AsHNDtrNkOrECodVPkLQez3PuJK
        qmiOoS8ORKIRNY2StafjbQMBXW98hQ2bPLdYOxIndSgbUXEw33eBXLG8O2arTPcm2iJ6OCs5wxL
        WM
X-Google-Smtp-Source: AA0mqf7Wwj2WafJw9IqtSqrC9ILaBzB3U6Wa2k/0bffhOrCbqT4R4xUy9hOoujC++8BlUJtMgcf2DvrU1kTG/89fWhff
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:d086:b0:219:227d:d91f with
 SMTP id k6-20020a17090ad08600b00219227dd91fmr2321890pju.0.1669840260639; Wed,
 30 Nov 2022 12:31:00 -0800 (PST)
Date:   Wed, 30 Nov 2022 12:30:49 -0800
In-Reply-To: <cover.1669839849.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1669839849.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <6af8dcebd14d803fc8d2a01fbcc7f42ff380719d.1669839849.git.jonathantanmy@google.com>
Subject: [PATCH 4/4] commit: don't lazy-fetch commits
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When parsing commits, fail fast when the commit is missing or
corrupt, instead of attempting to fetch them. This is done by inlining
repo_read_object_file() and setting the flag that prevents fetching.

This is motivated by a situation in which through a bug (not necessarily
through Git), there was corruption in the object store of a partial
clone. In this particular case, the problem was exposed when "git gc"
tried to expire reflogs, which calls repo_parse_commit(), which triggers
fetches of the missing commits.

(There are other possible solutions to this problem including passing an
argument from "git gc" to "git reflog" to inhibit all lazy fetches, but
I think that this fix is at the wrong level - fixing "git reflog" means
that this particular command works fine, or so we think (it will fail if
it somehow needs to read a legitimately missing blob, say, a .gitmodules
file), but fixing repo_parse_commit() will fix a whole class of bugs.)

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 commit.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/commit.c b/commit.c
index 572301b80a..17e71f5be4 100644
--- a/commit.c
+++ b/commit.c
@@ -508,6 +508,13 @@ int repo_parse_commit_internal(struct repository *r,
 	enum object_type type;
 	void *buffer;
 	unsigned long size;
+	const struct object_id *real_oid;
+	struct object_info oi = {
+		.typep = &type,
+		.sizep = &size,
+		.contentp = &buffer,
+		.real_oidp = &real_oid,
+	};
 	int ret;
 
 	if (!item)
@@ -516,11 +523,18 @@ int repo_parse_commit_internal(struct repository *r,
 		return 0;
 	if (use_commit_graph && parse_commit_in_graph(r, item))
 		return 0;
-	buffer = repo_read_object_file(r, &item->object.oid, &type, &size);
-	if (!buffer)
+
+	/*
+	 * Git does not support partial clones that exclude commits, so set
+	 * OBJECT_INFO_SKIP_FETCH_OBJECT to fail fast when an object is missing.
+	 */
+	if (oid_object_info_extended(r, &item->object.oid, &oi,
+	    OBJECT_INFO_LOOKUP_REPLACE | OBJECT_INFO_SKIP_FETCH_OBJECT) < 0) {
+		die_if_corrupt(r, &item->object.oid, real_oid);
 		return quiet_on_missing ? -1 :
 			error("Could not read %s",
 			     oid_to_hex(&item->object.oid));
+	}
 	if (type != OBJ_COMMIT) {
 		free(buffer);
 		return error("Object %s not a commit",
-- 
2.38.1.584.g0f3c55d4c2-goog


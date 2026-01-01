Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF8C1F875A
	for <git@vger.kernel.org>; Thu,  1 Jan 2026 21:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767301445; cv=none; b=hLDpzY+mwDwA5NSmhs3TwDh61KNtTzhuWZFgdS4sMbMxYsZ6Oa6yqP306tEbAItWm4LIa4HJtofQU17SZzwqwgSLCC2fxe0onSHt3ySnfTZqlx8T/FiqaG45TXohgmwPWM2itm06+G3wTjY7OqamxvhWqiGVm77X3YRV9GAO+RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767301445; c=relaxed/simple;
	bh=r2sq1/PDZsoNNxoobMzItdoqfsxMnelJ5qldcTMaYqU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=VYbl7jHN6Ig4krUfWuB0xkozn1vEuaFcRvvS/W8og4n7yby2DnHFY1j5uBeZ0w9cTqtrpiu8yryKkkBA2eR6kyqV9O2YQ3tsgq+MOgPPoDCVqZHdxgjyv3iF1r3iwsSFdjbedEDOnqGSsIWSC1SHa+G+l16FDDACFgV2YGQA7kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MhIySJ8R; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MhIySJ8R"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42fb0fc5aa9so4760837f8f.1
        for <git@vger.kernel.org>; Thu, 01 Jan 2026 13:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767301440; x=1767906240; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H+MLscVSC7p/rA49ScFczHa4gh3vq/+mmI7QUWwA5xg=;
        b=MhIySJ8RWUeyByEDOqCpa9qqIH0FF9HxHuXwBQC+EI+WCcE1/yGSVmiNv5D4TCLQeT
         6lJjqpzX0kSxCRZRGe1oeN2Y0wdPTTi9aUuXogIqoP/kO6zNWfHL1/i3XD6PmDR4VJIC
         EYTDO+8SRMVByErdIh0liH1I4TeG9jBp5P7L7OZyJrQA68iRZ91qg1g6D5+wn28kn82V
         91DOgMLUauG36SZhpZuIJ4/lwoyxw7iySZHlCKp9WBA00NkmOVuNdbc029nfeFd3H6J7
         FjvLhJvTAc9w77UfO/mmbxXC67GgYLLWn9qAvyr35NhV5MON8bgHbI/qpJyTB/PjVC1W
         UelQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767301440; x=1767906240;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H+MLscVSC7p/rA49ScFczHa4gh3vq/+mmI7QUWwA5xg=;
        b=J15oIYW27/NZwxj3p63bs66GlsfSs5uImp1DNcSsstrvA+vuzcF9W8BvQgurtjlqV8
         dXimjDlF8qrM4z3RiXNTuNmb+KUIk1+fjjFQwUj8nQJKD+u8OhBfir776LyRsxl4MQTW
         BQ60ffNTMSIKkICCN9g2eHuWtN/ZWHxgtKRB5pdVu4MM9TUx1qeG59oDFuiPxM7KBQyM
         Q4G35HDbBSqKSXo3I9xHhrMt8tbYkQbBq3X1yvX5fb1ivWD7NVcD+qr9lo6T/oZwS89r
         tqApGrGsU3/xRgoH9XLuYC3eXE5csf+mLMkcZYJaU6GPMmNN79b3QD/qzX7gyFRd5Gkl
         sN/Q==
X-Gm-Message-State: AOJu0YyVIFQzFmXKjyLkdhuGZWAUKJW4uX00F530IuZDN6dLgFSGCq8i
	CyMl/eB8GxuzVNyC+1u7BSZCQtcXZbXAoYX6CG6eiU5l2hmpKXFXs750fxRyeXi2
X-Gm-Gg: AY/fxX7Qkqnst81cVfdV3FnVAdbHKEKBxqHbiFi4OPRzhM6idHrBiEra4DBihkpdlN1
	Pa826WymY5pkVDLVbeMfgs9kzMcPb9KePgUZEQuhtxTZodBJcLXaFDTck9Xfr15PzEewahM0LTM
	+ZZYtriDDLARdmvbk2rLAFpvcncilUbxeope1XfuAKSOdLGqhw+CBUB9muwoRd5CFa7TSI8PvWd
	klyemv0mO+ChOrQ131AYYmZG4GZ4ibusvGMwTo5LFRkZAYcRzN7feY/axmWm2pYzpAyukr9igXE
	9pRi7Eyl9gwxlLIpd4Ab1UrizcynReJEuaiJchOfALHIu25oV6w62J8kC9b7YMAfofaIUhlgZJq
	UQZGdz7ZFmkX5zYgDD6Fjn5306ZdsJvl3z9jA4rHkld+J6YlezJU3FkArcX9IeMjm3JW94OAFTq
	TD4s+MhJ5z4dJyg2a2vNAT5ou+VytwGI37PACqmw==
X-Google-Smtp-Source: AGHT+IGp/N3tCclrkzy+GcIz4WyEbV7Dci6xLety8h4fA9OTFjlfvAUn+8WJQ03v7qH+sy3Socfv8g==
X-Received: by 2002:a05:6000:178e:b0:425:769e:515a with SMTP id ffacd0b85a97d-4324e50b8fdmr52546996f8f.42.1767301439961;
        Thu, 01 Jan 2026 13:03:59 -0800 (PST)
Received: from localhost ([105.117.11.89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43264613923sm66328841f8f.26.2026.01.01.13.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jan 2026 13:03:59 -0800 (PST)
Date: Thu, 1 Jan 2026 22:04:08 +0100
From: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [GSoC PATCH v2] add -p: show user's hunk decision when selecting
 hunks
Message-ID: <aVbgkySezz8YV6sN@Adekunles-MacBook-Air.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSxQhqwzT34hIjV8@Adekunles-MacBook-Air.local>

When a user is interactively deciding which hunks to use or skip for
staging, unstaging, stashing etc, there is no way to know the
decision previously chosen for a hunk when navigating through the
previous and next hunks using K/J respectively.

Improve the UI to explicitly show if a user has previously decided to
use a hunk (by pressing 'y') or skip the hunk (by pressing 'n').
This will improve clarity when and aid the navigation process for the
user.

Reported-by: Reported-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
---
Changes in v2:
--------------
- Modified subject to indicate GSoC participation and user's hunk decision.
- Modified the code to detect the user's decision for each front-end set
  that uses the interactive patch machinery
- Changes the decision phrase to 'previous decision: _decision_' from
  'Selected/Deselected'
- Placed the decision phrase before the [choices] instead of after the [choices].
 add-patch.c | 84 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 47 insertions(+), 37 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 173a53241e..bc7a340d21 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -42,10 +42,10 @@ static struct patch_mode patch_mode_add = {
 	.apply_args = { "--cached", NULL },
 	.apply_check_args = { "--cached", NULL },
 	.prompt_mode = {
-		N_("Stage mode change [y,n,q,a,d%s,?]? "),
-		N_("Stage deletion [y,n,q,a,d%s,?]? "),
-		N_("Stage addition [y,n,q,a,d%s,?]? "),
-		N_("Stage this hunk [y,n,q,a,d%s,?]? ")
+		N_("Stage mode change%s[y,n,q,a,d%s,?]? "),
+		N_("Stage deletion%s[y,n,q,a,d%s,?]? "),
+		N_("Stage addition%s[y,n,q,a,d%s,?]? "),
+		N_("Stage this hunk%s[y,n,q,a,d%s,?]? ")
 	},
 	.edit_hunk_hint = N_("If the patch applies cleanly, the edited hunk "
 			     "will immediately be marked for staging."),
@@ -64,10 +64,10 @@ static struct patch_mode patch_mode_stash = {
 	.apply_args = { "--cached", NULL },
 	.apply_check_args = { "--cached", NULL },
 	.prompt_mode = {
-		N_("Stash mode change [y,n,q,a,d%s,?]? "),
-		N_("Stash deletion [y,n,q,a,d%s,?]? "),
-		N_("Stash addition [y,n,q,a,d%s,?]? "),
-		N_("Stash this hunk [y,n,q,a,d%s,?]? "),
+		N_("Stash mode change%s[y,n,q,a,d%s,?]? "),
+		N_("Stash deletion%s[y,n,q,a,d%s,?]? "),
+		N_("Stash addition%s[y,n,q,a,d%s,?]? "),
+		N_("Stash this hunk%s[y,n,q,a,d%s,?]? "),
 	},
 	.edit_hunk_hint = N_("If the patch applies cleanly, the edited hunk "
 			     "will immediately be marked for stashing."),
@@ -88,10 +88,10 @@ static struct patch_mode patch_mode_reset_head = {
 	.is_reverse = 1,
 	.index_only = 1,
 	.prompt_mode = {
-		N_("Unstage mode change [y,n,q,a,d%s,?]? "),
-		N_("Unstage deletion [y,n,q,a,d%s,?]? "),
-		N_("Unstage addition [y,n,q,a,d%s,?]? "),
-		N_("Unstage this hunk [y,n,q,a,d%s,?]? "),
+		N_("Unstage mode change%s[y,n,q,a,d%s,?]? "),
+		N_("Unstage deletion%s[y,n,q,a,d%s,?]? "),
+		N_("Unstage addition%s[y,n,q,a,d%s,?]? "),
+		N_("Unstage this hunk%s[y,n,q,a,d%s,?]? "),
 	},
 	.edit_hunk_hint = N_("If the patch applies cleanly, the edited hunk "
 			     "will immediately be marked for unstaging."),
@@ -111,10 +111,10 @@ static struct patch_mode patch_mode_reset_nothead = {
 	.apply_check_args = { "--cached", NULL },
 	.index_only = 1,
 	.prompt_mode = {
-		N_("Apply mode change to index [y,n,q,a,d%s,?]? "),
-		N_("Apply deletion to index [y,n,q,a,d%s,?]? "),
-		N_("Apply addition to index [y,n,q,a,d%s,?]? "),
-		N_("Apply this hunk to index [y,n,q,a,d%s,?]? "),
+		N_("Apply mode change to index%s[y,n,q,a,d%s,?]? "),
+		N_("Apply deletion to index%s[y,n,q,a,d%s,?]? "),
+		N_("Apply addition to index%s[y,n,q,a,d%s,?]? "),
+		N_("Apply this hunk to index%s[y,n,q,a,d%s,?]? "),
 	},
 	.edit_hunk_hint = N_("If the patch applies cleanly, the edited hunk "
 			     "will immediately be marked for applying."),
@@ -134,10 +134,10 @@ static struct patch_mode patch_mode_checkout_index = {
 	.apply_check_args = { "-R", NULL },
 	.is_reverse = 1,
 	.prompt_mode = {
-		N_("Discard mode change from worktree [y,n,q,a,d%s,?]? "),
-		N_("Discard deletion from worktree [y,n,q,a,d%s,?]? "),
-		N_("Discard addition from worktree [y,n,q,a,d%s,?]? "),
-		N_("Discard this hunk from worktree [y,n,q,a,d%s,?]? "),
+		N_("Discard mode change from worktree%s[y,n,q,a,d%s,?]? "),
+		N_("Discard deletion from worktree%s[y,n,q,a,d%s,?]? "),
+		N_("Discard addition from worktree%s[y,n,q,a,d%s,?]? "),
+		N_("Discard this hunk from worktree%s[y,n,q,a,d%s,?]? "),
 	},
 	.edit_hunk_hint = N_("If the patch applies cleanly, the edited hunk "
 			     "will immediately be marked for discarding."),
@@ -157,10 +157,10 @@ static struct patch_mode patch_mode_checkout_head = {
 	.apply_check_args = { "-R", NULL },
 	.is_reverse = 1,
 	.prompt_mode = {
-		N_("Discard mode change from index and worktree [y,n,q,a,d%s,?]? "),
-		N_("Discard deletion from index and worktree [y,n,q,a,d%s,?]? "),
-		N_("Discard addition from index and worktree [y,n,q,a,d%s,?]? "),
-		N_("Discard this hunk from index and worktree [y,n,q,a,d%s,?]? "),
+		N_("Discard mode change from index and worktree%s[y,n,q,a,d%s,?]? "),
+		N_("Discard deletion from index and worktree%s[y,n,q,a,d%s,?]? "),
+		N_("Discard addition from index and worktree%s[y,n,q,a,d%s,?]? "),
+		N_("Discard this hunk from index and worktree%s[y,n,q,a,d%s,?]? "),
 	},
 	.edit_hunk_hint = N_("If the patch applies cleanly, the edited hunk "
 			     "will immediately be marked for discarding."),
@@ -179,10 +179,10 @@ static struct patch_mode patch_mode_checkout_nothead = {
 	.apply_for_checkout = 1,
 	.apply_check_args = { NULL },
 	.prompt_mode = {
-		N_("Apply mode change to index and worktree [y,n,q,a,d%s,?]? "),
-		N_("Apply deletion to index and worktree [y,n,q,a,d%s,?]? "),
-		N_("Apply addition to index and worktree [y,n,q,a,d%s,?]? "),
-		N_("Apply this hunk to index and worktree [y,n,q,a,d%s,?]? "),
+		N_("Apply mode change to index and worktree%s[y,n,q,a,d%s,?]? "),
+		N_("Apply deletion to index and worktree%s[y,n,q,a,d%s,?]? "),
+		N_("Apply addition to index and worktree%s[y,n,q,a,d%s,?]? "),
+		N_("Apply this hunk to index and worktree%s[y,n,q,a,d%s,?]? "),
 	},
 	.edit_hunk_hint = N_("If the patch applies cleanly, the edited hunk "
 			     "will immediately be marked for applying."),
@@ -202,10 +202,10 @@ static struct patch_mode patch_mode_worktree_head = {
 	.apply_check_args = { "-R", NULL },
 	.is_reverse = 1,
 	.prompt_mode = {
-		N_("Discard mode change from worktree [y,n,q,a,d%s,?]? "),
-		N_("Discard deletion from worktree [y,n,q,a,d%s,?]? "),
-		N_("Discard addition from worktree [y,n,q,a,d%s,?]? "),
-		N_("Discard this hunk from worktree [y,n,q,a,d%s,?]? "),
+		N_("Discard mode change from worktree%s[y,n,q,a,d%s,?]? "),
+		N_("Discard deletion from worktree%s[y,n,q,a,d%s,?]? "),
+		N_("Discard addition from worktree%s[y,n,q,a,d%s,?]? "),
+		N_("Discard this hunk from worktree%s[y,n,q,a,d%s,?]? "),
 	},
 	.edit_hunk_hint = N_("If the patch applies cleanly, the edited hunk "
 			     "will immediately be marked for discarding."),
@@ -224,10 +224,10 @@ static struct patch_mode patch_mode_worktree_nothead = {
 	.apply_args = { NULL },
 	.apply_check_args = { NULL },
 	.prompt_mode = {
-		N_("Apply mode change to worktree [y,n,q,a,d%s,?]? "),
-		N_("Apply deletion to worktree [y,n,q,a,d%s,?]? "),
-		N_("Apply addition to worktree [y,n,q,a,d%s,?]? "),
-		N_("Apply this hunk to worktree [y,n,q,a,d%s,?]? "),
+		N_("Apply mode change to worktree%s[y,n,q,a,d%s,?]? "),
+		N_("Apply deletion to worktree%s[y,n,q,a,d%s,?]? "),
+		N_("Apply addition to worktree%s[y,n,q,a,d%s,?]? "),
+		N_("Apply this hunk to worktree%s[y,n,q,a,d%s,?]? "),
 	},
 	.edit_hunk_hint = N_("If the patch applies cleanly, the edited hunk "
 			     "will immediately be marked for applying."),
@@ -1448,6 +1448,7 @@ static int patch_update_file(struct add_p_state *s,
 	ssize_t i, undecided_previous, undecided_next, rendered_hunk_index = -1;
 	struct hunk *hunk;
 	char ch;
+	const char *hunk_use_decision;
 	struct child_process cp = CHILD_PROCESS_INIT;
 	int colored = !!s->colored.len, quit = 0, use_pager = 0;
 	enum prompt_mode_type prompt_mode_type;
@@ -1564,8 +1565,17 @@ static int patch_update_file(struct add_p_state *s,
 			      (uintmax_t)(file_diff->hunk_nr
 						? file_diff->hunk_nr
 						: 1));
+		if (file_diff->hunk_nr) {
+			if (hunk->use == USE_HUNK)
+				hunk_use_decision = _(" (previous decision: use) ");
+			else if (hunk->use == SKIP_HUNK)
+				hunk_use_decision = _(" (previous decision: skip) ");
+			else
+				hunk_use_decision = " ";
+
+		}
 		printf(_(s->mode->prompt_mode[prompt_mode_type]),
-		       s->buf.buf);
+			hunk_use_decision, s->buf.buf);
 		if (*s->s.reset_color_interactive)
 			fputs(s->s.reset_color_interactive, stdout);
 		fflush(stdout);
-- 
2.39.5 (Apple Git-154)


Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26471EEA49
	for <git@vger.kernel.org>; Fri,  2 Jan 2026 18:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767379862; cv=none; b=quTJplWK31dLQDddUkPGTJ7Ijqzg8qcXjkyl9lAllnOsFFK8ky++w0ZW2YeP89IMZAhroawhZFe7AFagWkkkVSehjx5es9PYPBQ96fy9TGuI0rSwB/rJjnjtohojyx3Oo0XAeBOA1qmEszXXNk2rtG83VpSKdNG2Kf6VlyBDMN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767379862; c=relaxed/simple;
	bh=H/YLyyFDNKymDjQ2ND6IWqbTRuchSahNXDf3jYKWZfY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=k6S0iaK7ZqMpvWmLlVWgLdhqIP423x7kJkLhSLN6KtpX+Di6QrKGJGKcJ51qX4VHFj4ct/OZ1ClQO+JIP2m9bxUlZqkIB824M/Gsf/mGD+B40CWMTrJK1ybGQCpKstue0SYdqjF6IK+KmMJ8CHviTVGeWtSzqdmr5gJiw5hvLpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gFGCw0pF; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFGCw0pF"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4779cc419b2so97088805e9.3
        for <git@vger.kernel.org>; Fri, 02 Jan 2026 10:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767379859; x=1767984659; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NXfBYZhzHjFgMi/mcM3BcXWpSKpPIUN7o/DnFZN0Mts=;
        b=gFGCw0pFIP9AlEsB8uIFWolsFnujIUowSQYM+Ql9NYse0/67Mbysb8dEFYVy4IjHFG
         n9ZoeYVCc5/FaH5/G+PNxfxLWf80jCBzstHmKPzXjrkzJFKrC/TELpHJ/24xyb5hsIpF
         6sb5Idt/8lbz6VaqpUd2vpGISnYxg/4f3Sy23hmAUxmAeoPgQ68XA3y+gVsgnkf7PCls
         LThyIRishli1kX+0/pILCM/CbWg8ps4WrCp6DjNcKd9lmELjE8d1wdWCiBGWaiHO2M+h
         N8hbeTOhg7lFkNAMQpPodoOfYyYjclYpHvu3Nha3TaVrfO4nIq254oW5M8cSST3OW73i
         DyGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767379859; x=1767984659;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NXfBYZhzHjFgMi/mcM3BcXWpSKpPIUN7o/DnFZN0Mts=;
        b=Xkg6D9MAPe9s3FVYkCqWLJoI9m5DwJKYuKZRSHApTrQP2xLYiRBhX+b4/prW49vmpW
         D9NiqKIFypx/gHWFkEEgq8eIzlMF4x3dAqinPTZhg8hGwCouvUE9imdxJPlrgEIevLbP
         CjR/93dE5tiE7EZo0FCeNndMPCVl36dQ0XgzHjyyA1BzG3CbEyzSN6+Uw8k3Lm9b3plA
         8BtxDIMVJHJ5Tf+rAOXdTn0VfhXeKfhMzLLmbj8wwgKdrCA7aLJSniwy7t/QWdTz1sEe
         C91BCYbl20Ds8Boz4S93fRSulo38GGqW8WJYg2VY7aD9h/ULs6NNZvZ6Nv8wQpFsnlvh
         gAcA==
X-Gm-Message-State: AOJu0Yx4EKmNkuVr9JOvVO2ExOlHKNDZV3KBkhpS9WCJAeyw7EEw311U
	p35E1BnJiNrPjJ758W3lEfQqdi8vgc0WM7Yk1ldndccSWv+bP3QZll4qAbOMuW1x
X-Gm-Gg: AY/fxX7wyd41WHA9is8t9rOSB28dIcXx+IRThvtYY1PPX9KJQy+BefATP7vKEQdGfZY
	97S5LFxATU1o9YMV1S3R+kAWe6DJek8aSciFZdFp/Zfrbb/eWmserMJ/e4sUeYBB61SwX224QaN
	yMEPytUzMiuGPU2NqD6I1X+oTaWIyN4YrsDy0q8+5vaAjTRT2FDRbBM8C5Si98vn05Wu3O9U204
	/gDx9kN/g24gBjkY422wYhJVX4ilIzcjCaiSb/1hCqqqOlH+pXQJMjcqTJ6X+6a0RITsa7OrQCE
	jRef7Rb0MkEzxNnRwa4cWzjY2+7d4BljN8Pvi7pR7cgYTIrAoW3L+2Iw2EZ36YDiOLexMFeVoAh
	jzVjJ6CKHIyq7DWEOpXwiuyETUyibdf86Zyo1nyYtdh5cIwywR3DZ6yrALs+zXRCq2iFXhhOV82
	sTTrh4pubP211hZJ5yic07leQbwg==
X-Google-Smtp-Source: AGHT+IFNQRTtuf1/+TPp9YqkWYv3t1VxXpwZLkOYAr47Cyr4RaeKD/oXrkpgwNDl1vapIEGx+NxB5A==
X-Received: by 2002:a5d:5392:0:b0:42f:edb6:3642 with SMTP id ffacd0b85a97d-4324e704c03mr43907423f8f.60.1767379858462;
        Fri, 02 Jan 2026 10:50:58 -0800 (PST)
Received: from localhost ([105.117.2.49])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324e9ba877sm86914748f8f.0.2026.01.02.10.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 10:50:58 -0800 (PST)
Date: Fri, 2 Jan 2026 19:51:05 +0100
From: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [GSoC PATCH v3] add -p: show user's hunk decision when selecting
 hunks
Message-ID: <aVgTmYhosEiGG3th@Adekunles-MacBook-Air.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aVbgkySezz8YV6sN@Adekunles-MacBook-Air.local>

When a user is interactively deciding which hunks to use or skip for
staging, unstaging, stashing etc, there is no way to know the
decision previously chosen for a hunk when navigating through the
previous and next hunks using K/J respectively.

Improve the UI to explicitly show if a user has previously decided to
use a hunk (by pressing 'y') or skip the hunk (by pressing 'n').
This will improve clarity when and aid the navigation process for the
user.

Reported-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
---

Changes in v2:
--------------
- Modified t3701-add-interactive.sh for conform to new changes

 add-patch.c                | 84 +++++++++++++++++++++-----------------
 t/t3701-add-interactive.sh | 14 +++----
 2 files changed, 54 insertions(+), 44 deletions(-)

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
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 4285314f35..e856683496 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -527,7 +527,7 @@ test_expect_success 'goto hunk 1 with "g 1"' '
 	_10
 	+15
 	_20
-	(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?_
+	(1/2) Stage this hunk (previous decision: use) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?_
 	EOF
 	test_write_lines s y g 1 | git add -p >actual &&
 	tail -n 7 <actual >actual.trimmed &&
@@ -540,7 +540,7 @@ test_expect_success 'goto hunk 1 with "g1"' '
 	_10
 	+15
 	_20
-	(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?_
+	(1/2) Stage this hunk (previous decision: use) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?_
 	EOF
 	test_write_lines s y g1 | git add -p >actual &&
 	tail -n 4 <actual >actual.trimmed &&
@@ -554,7 +554,7 @@ test_expect_success 'navigate to hunk via regex /pattern' '
 	_10
 	+15
 	_20
-	(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?_
+	(1/2) Stage this hunk (previous decision: use) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?_
 	EOF
 	test_write_lines s y /1,2 | git add -p >actual &&
 	tail -n 5 <actual >actual.trimmed &&
@@ -567,7 +567,7 @@ test_expect_success 'navigate to hunk via regex / pattern' '
 	_10
 	+15
 	_20
-	(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?_
+	(1/2) Stage this hunk (previous decision: use) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?_
 	EOF
 	test_write_lines s y / 1,2 | git add -p >actual &&
 	tail -n 4 <actual >actual.trimmed &&
@@ -579,11 +579,11 @@ test_expect_success 'print again the hunk' '
 	tr _ " " >expect <<-EOF &&
 	+15
 	 20
-	(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]? @@ -1,2 +1,3 @@
+	(1/2) Stage this hunk (previous decision: use) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]? @@ -1,2 +1,3 @@
 	 10
 	+15
 	 20
-	(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?_
+	(1/2) Stage this hunk (previous decision: use) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?_
 	EOF
 	test_write_lines s y g 1 p | git add -p >actual &&
 	tail -n 7 <actual >actual.trimmed &&
@@ -810,7 +810,7 @@ test_expect_success 'colors can be overridden' '
 	<BOLD>-old<RESET>
 	<BLUE>+new<RESET>
 	<CYAN> more-context<RESET>
-	<YELLOW>(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]? <RESET>
+	<YELLOW>(1/2) Stage this hunk (previous decision: use) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]? <RESET>
 	EOF
 	test_cmp expect actual
 '
-- 
2.39.5 (Apple Git-154)


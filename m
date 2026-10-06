Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAB822425B
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 07:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791270522; cv=none; b=b2nHW0C22UJ5IZ/ZIy6l9AecT2XVRA+OgYFV9vsxRR2e+TX//zVzsQvAi3UsC6YcD66ekHOyzoaCpORyCAwiSM1CEw9XwtanafYaISoZmIH2LEMyAp5lCGFyHiSdL3HgyBjQZbkZWFJlsKnus2pf6DXSqzh4lLEJM4LzeqPAjqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791270522; c=relaxed/simple;
	bh=i+VbwV1/mCRBGDXACjA0/DayCItyPgd2zSL2MPFEgGs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=a5fvj2tWJOMycCwq55gO/cU8TtYO7OAydtWa1XhPT6mQ6rVtv1GPjsAgMlMk19NTdFAPfFBtVt3EKFEFVAFidBU2aqWlzNME9zhZgW0VIZ4oYaP+SN8lf6KRDVxwCDf5ECjsGCopblqANF0KHuqJu1wI888R2zb1Nq7ANRqJPBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kuBWDENl; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kuBWDENl"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-4c382ece86fso100250b6e.1
        for <git@vger.kernel.org>; Tue, 06 Oct 2026 00:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791270520; x=1791875320; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YbxG08ez0VPjE+S9q5R8/14A+Db2LN0h2uCCxCr3Zf0=;
        b=kuBWDENl4h438rHFEdANZTwqGnfLxgejaEx4Va+uIDKLLNEkupl+78aGTwuS4bcABm
         zjs4ik7TgLY2VX/vPAuX74QTI2Am7QeeD2w+LwRAOpz+LaE2ZmYUVd8x4HiDGms98/Zn
         lrxBPJMSxB/D8WtqjP/QeVSiuoo3tRlBKVVIpDfpbDsKnP1nkj1h4E7SUYAZaotPAdvP
         4fSJfvWNoMe16Qd5PcGzv4T5IgfJ4i0ipuXBvLcClEJaR2BzpqXeGGKmgr8ct+ycjCDf
         7tn0SnFP6KeJxCOadg3oJI/QQgCZA3shBIEefjH6jeJYjamjXDtLCwTWBtkJoxe8/Gnr
         H4EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791270520; x=1791875320;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YbxG08ez0VPjE+S9q5R8/14A+Db2LN0h2uCCxCr3Zf0=;
        b=ufvhQdcf+Lg6MAbxNRM5lA4lIdpPsMgaPpkT/gqQfEMifrvVp9mO/KWGIJIH9bkzYG
         M8x9o16h9oILN700+JlCocqsYO7L81ngi5CQrF4yK2orcpaUrcPGPat9vAmRa/USszwH
         bC5yftsaXtWOY0zrSb6T8yUHbgApge5vDHRkB+t3JsUKu3/LzIYPZWKKn2dYz+PotlaG
         Rt6iZEps1llMFzEPr71ESmSFJvtw4jrBzbUye1K4LEvDGh3tb1TwG5SsamPrLuEf7wCE
         R+G4zMHxbZSWSaXVGp41oaJS5o6mNoriwlsD0ekdbCtlMoPIlpOlw7JUP+GVrgl4xZt9
         eCDQ==
X-Gm-Message-State: AFuF++nJrsPlncoUlUPymRLzuSEEg/J+b5LAzbSJVwtypkkkMozs/yli
	kWCXpFaNmxQ+GX/MPO4mv6bIfLO7+AHJG1b0NAtL+ZQdNb3VgSbWq35LPuWA0Son
X-Gm-Gg: AYBFou3i4dxWwIFkJJ9/0enATWtqTpagSL2vWtjwub7CDRnxQRWoMSGszKW2naIa5CF
	QsNLVatmFru41dbgbGMLll46JxIxRCFoA4mh+Kdmlxt9bGXKkP0dKrpUphl26zVB/2mVfnFU1VD
	PJeWsbQr78t7+JlUWxKy5FBcYjBHRZArY7eMSAHn16JcupqUXACA5C8T8ZfAaP2Ja2MTAWI7SH+
	4UBJQ6Cwdq5zjVhRtAz+LYYZS8+89HpCG2YsG+kkF/vH1mycRZIID1nKJdgjMLlIkHAGtUOXv20
	rrBtJCMW5OWyF84jg9FrEOr9KlrQ9RJRYFpnC7FOZ80wmqSneGX33j5W1ZNiZ6LXb2LY40QARAQ
	vg0pyuqMkhVnPZxLLneBJnZmjQ7zEam4T7sLH6f18QeCVVabb2+4DtVQhE3eAHVJ0Q9uOX0G59t
	vuwg3bpR8u0euBItep7Gi+GC7UX21cNLQNkZJQh+dqrr5azTrglvVGB6Wju6bnm8URU/TaewZJz
	EPvyHWIEPbz9Q==
X-Received: by 2002:a05:6808:1782:b0:4f5:1cd4:d2be with SMTP id 5614622812f47-4fb3a56265amr662717b6e.0.1791270519760;
        Tue, 06 Oct 2026 00:08:39 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.187.250])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4facb18966fsm1734601b6e.14.2026.10.06.00.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 00:08:37 -0700 (PDT)
Message-Id: <b44f4cdeaff64a5099adfc9dd325033e8c38f7b4.1791270504.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2437.git.git.1791270504.gitgitgadget@gmail.com>
References: <pull.2437.git.git.1791270504.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 06 Oct 2026 07:08:22 +0000
Subject: [PATCH 4/6] push: name the branch to pull from when it is not the
 upstream
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

When someone else pushed to the branch you push to, such as a topic
branch on your fork, "git push" is rejected with a hint to run
"git pull" first. If that branch is not your upstream, the pull merges
the upstream and leaves the push branch diverged, so the push is
rejected again.

Name the branch that diverged and suggest pulling from it:

  hint: Updates were rejected because 'origin/topic' has diverged
  hint: from your current branch. Use 'git pull origin topic'
  hint: to integrate the remote changes.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 builtin/push.c           | 37 +++++++++++++++++++++++---
 t/t6040-tracking-info.sh | 57 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+), 3 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 2377b5af55..82435beab5 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -12,6 +12,7 @@
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
+#include "refs.h"
 #include "refspec.h"
 #include "run-command.h"
 #include "remote.h"
@@ -295,6 +296,11 @@ static const char message_advice_pull_before_push[] =
 	   "use 'git pull' before pushing again.\n"
 	   "See the 'Note about fast-forwards' in 'git push --help' for details.");
 
+static const char message_advice_pull_from_branch_before_push[] =
+	N_("Updates were rejected because '%s' has diverged\n"
+	   "from your current branch. Use 'git pull %s %s'\n"
+	   "to integrate the remote changes.");
+
 static const char message_advice_checkout_pull_push[] =
 	N_("Updates were rejected because a pushed branch tip is behind its remote\n"
 	   "counterpart. If you want to integrate the remote changes, use 'git pull'\n"
@@ -322,11 +328,35 @@ static const char message_advice_ref_needs_update[] =
 	   "remote changes, use 'git pull' before pushing again.\n"
 	   "See the 'Note about fast-forwards' in 'git push --help' for details.");
 
-static void advise_pull_before_push(void)
+static void advise_pull_before_push(struct remote *push_remote)
 {
+	struct branch *branch = branch_get(NULL);
+	struct remote *remote = NULL;
+	const char *upstream = NULL;
+	char *tracking = NULL;
+	char *tracking_name = NULL;
+
 	if (!advice_enabled(ADVICE_PUSH_NON_FF_CURRENT) || !advice_enabled(ADVICE_PUSH_UPDATE_REJECTED))
 		return;
-	advise(_(message_advice_pull_before_push));
+
+	if (branch) {
+		remote = repo_remote_for_push_tracking(the_repository,
+						       push_remote);
+		tracking = apply_refspecs(&remote->fetch, branch->refname);
+		upstream = branch_get_upstream(branch, NULL);
+	}
+	if (tracking)
+		tracking_name = refs_shorten_unambiguous_ref(
+			get_main_ref_store(the_repository), tracking, 0);
+
+	if (tracking && (!upstream || strcmp(tracking, upstream)))
+		advise(_(message_advice_pull_from_branch_before_push),
+		       tracking_name, remote->name, branch->name);
+	else
+		advise(_(message_advice_pull_before_push));
+
+	free(tracking_name);
+	free(tracking);
 }
 
 static void advise_checkout_pull_push(void)
@@ -370,6 +400,7 @@ static int push_with_options(struct transport *transport, struct refspec *rs,
 	int err;
 	unsigned int reject_reasons;
 	char *anon_url = transport_anonymize_url(transport->url);
+	struct remote *remote = transport->remote;
 
 	transport_set_verbosity(transport, verbosity, progress);
 	transport->family = family;
@@ -404,7 +435,7 @@ static int push_with_options(struct transport *transport, struct refspec *rs,
 		return 0;
 
 	if (reject_reasons & REJECT_NON_FF_HEAD) {
-		advise_pull_before_push();
+		advise_pull_before_push(remote);
 	} else if (reject_reasons & REJECT_NON_FF_OTHER) {
 		advise_checkout_pull_push();
 	} else if (reject_reasons & REJECT_ALREADY_EXISTS) {
diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index 4074c6663a..9eb810e158 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -809,4 +809,61 @@ test_expect_success 'status.compareBranches after a clean rebase of the push bra
 	test_cmp expect actual
 '
 
+test_expect_success 'push to a push branch someone else updated suggests pulling from it' '
+	(
+		cd test &&
+		git checkout -b feature20 origin/main &&
+		advance work20 &&
+		git push origin feature20
+	) &&
+	git checkout feature20 &&
+	advance other20 &&
+	git checkout - &&
+	(
+		cd test &&
+		advance mine20 &&
+		git fetch &&
+		test_must_fail git push origin feature20 2>../actual
+	) &&
+	url=$(git -C test config remote.origin.url) &&
+	cat >expect <<-EOF &&
+	To $url
+	 ! [rejected]        feature20 -> feature20 (non-fast-forward)
+	error: failed to push some refs to ${SQ}$url${SQ}
+	hint: Updates were rejected because ${SQ}origin/feature20${SQ} has diverged
+	hint: from your current branch. Use ${SQ}git pull origin feature20${SQ}
+	hint: to integrate the remote changes.
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'push to the upstream branch' '
+	(
+		cd test &&
+		git checkout -b feature21 origin/main &&
+		advance work21 &&
+		git push -u origin feature21
+	) &&
+	git checkout feature21 &&
+	advance other21 &&
+	git checkout - &&
+	(
+		cd test &&
+		advance mine21 &&
+		git fetch &&
+		test_must_fail git push 2>../actual
+	) &&
+	url=$(git -C test config remote.origin.url) &&
+	cat >expect <<-EOF &&
+	To $url
+	 ! [rejected]        feature21 -> feature21 (non-fast-forward)
+	error: failed to push some refs to ${SQ}$url${SQ}
+	hint: Updates were rejected because the tip of your current branch is behind
+	hint: its remote counterpart. If you want to integrate the remote changes,
+	hint: use ${SQ}git pull${SQ} before pushing again.
+	hint: See the ${SQ}Note about fast-forwards${SQ} in ${SQ}git push --help${SQ} for details.
+	EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget


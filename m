Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1D641687B
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 18:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792001525; cv=none; b=VKatcRh4ZDgHJOxTygqeSKfx4cabSJG9cYfl9MebH0Gn0jHN4RJFLkJOxTo/8PuTt4/jrcr/2afKOCF3gdqbbCPu6eIcCoFcvMGAYGION2o/HSR8OP63sowEEkiSYV9bwhYIoPJlu5dpidMUyta7nVDtme8J1OhnuNxmsjsKpQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792001525; c=relaxed/simple;
	bh=7gBqxYYJMjQZYILSnXPQ/s7FZ0RZQXHQBl5eQZt2lJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R+Tjg7ml1UVsZlFXKJS9QkvKE+Tbr63dBfmVThNJ3CFOXKFwLq0yN2GpErTpbn1NB6ICR8JSKzLKv8WLB7H6MXNf49p+LfzLOikpUfQ4xAUCGh191at8JLAS7x/1NkmYpXdVsQ7s56RSYRtIFgbO4I0Oz3HOeX6K1RAhl8B9o7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gitlab.com; spf=pass smtp.mailfrom=gitlab.com; dkim=pass (1024-bit key) header.d=gitlab.com header.i=@gitlab.com header.b=WvRXk89x; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gitlab.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gitlab.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gitlab.com header.i=@gitlab.com header.b="WvRXk89x"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48dee593f18so576282f8f.3
        for <git@vger.kernel.org>; Wed, 14 Oct 2026 11:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gitlab.com; s=google; t=1792001521; x=1792606321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yw8oDiOCzlGcAIDOMErK8mLjhMN4khazP2BrORZLmxo=;
        b=WvRXk89xXyHCvOUwGhBv3hrR4ausQcVCJ1RzHTKfTYVGDL/1t+mOT+pXHIhAPSHg8g
         UV45o19jffWwah3ot6xaoIZ033+MJLIXNU5AwGxJXuG4Zyy3wFBAt2XB1waf4Gp4V/YH
         JV8XMdOWPrvVVkoZffGR0DKOAbovcTDswXHTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792001521; x=1792606321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yw8oDiOCzlGcAIDOMErK8mLjhMN4khazP2BrORZLmxo=;
        b=jVbdzGaTKsKb54Ka9ibutR+4SX+4mBxMJ7DjSCAZ2WfWFPL2FVS+qLb1Y8WqIUCpDm
         QHIIkr813ZuzLZoKa6g8ujeARY3neuDuwvaTntSWW7ECmQNbK/vOIMQMQIizo5X1Ub/7
         x6hCavmHk1r8xGa0knsN4fgzYUd6lEb65aCBiJ9TLaMO48fRmoyO5pC2JTa8HmuZQ0Vi
         qh6VHsCtJ+LtmrAo0BHeDq0omxdRHBonybBz+6thc1bPnG124sHeD1zek4dHj0wIdjP0
         hQXuzIYEfcJ2SqdMxmqjZtQucMF2kUBL9UtCyj6HL/Jkx2k+f4yrLU7/OzyUR6SNNw7M
         NAjw==
X-Gm-Message-State: AFq9FYIhAz0Yt6yBs1zdVGXdQchwLRt3zJI2NBkN3kpzl1ypCL+KoJ86
	O6X8BDuYde7GcIl7B1WdwrSyvJ+mt+2K6U+vPHLAPz/p5NWkHDBx4YOw5hSFjxxHw/QZQSmxEOM
	c/ejLPBfTbg==
X-Gm-Gg: AYBFou2jI9kO5UYJb+HM9D+ojrydp/DfV8ON6GksdgbW4p8si1JvjOYpfGw2vrrIUWA
	4GI+HbMCT5NWnhn8N67FM3iYDGc1psDhf4GE+bEG8HKWcbKeY2/AygRm6kmYrFFBr9AbrIudTdm
	IHmyU/Hu+GhoPMYTruv+YME21HbgKU8s6qLx1uelwAVJ0qQc4LWgJp8blhQZviAdEkzkv34jNF7
	V9DJPo/BOtlZ6kZHp+JrXL31vT70A78Y5MSpwQF3oTxGgLSgztR/yqO0U7Xw3qeXfBdRgbyyRMr
	D0TbzkQEsI5UTwySgSr31YHnIam3Q1VMPSLih6amMwm5OKB8l4yRSl/hcGmXl1KnzdLbMDkdcz/
	dZ+jljaQHt3IylXR1utSVipEQjslSlPoS/OYySCbpUzClVjVDdM+pesqsVyixcFypbwzYGAuQjE
	CWKUV2P4Hu3zYrfAaQ7aqtL5mcGnZ/zMKYClpco9hUDNihpWK9csIZKkG9dn01RJNTl8tM8WDzx
	vnt4Cf6etG1Q/Id80orp5g0nN6J6iuRsTx9DA0=
X-Received: by 2002:a5d:5f84:0:b0:48b:86:5563 with SMTP id ffacd0b85a97d-48dbaae6f0bmr32001199f8f.27.1792001521499;
        Wed, 14 Oct 2026 11:12:01 -0700 (PDT)
Received: from iwiedler--20220823-X3P9M ([2001:9e8:a86:1382:f12e:5410:6774:61fc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0ab4f34sm13806721f8f.28.2026.10.14.11.12.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 14 Oct 2026 11:12:01 -0700 (PDT)
From: Igor Wiedler <iwiedler@gitlab.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	jltobler@gmail.com,
	Igor Wiedler <iwiedler@gitlab.com>
Subject: [PATCH v2 1/2] connected: negate alternate refs in deepening fetches too
Date: Wed, 14 Oct 2026 20:11:33 +0200
Message-ID: <20261014181134.56220-2-iwiedler@gitlab.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261014103507.35317-1-iwiedler@gitlab.com>
References: <20261014103507.35317-1-iwiedler@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The connectivity check spawned by check_connected() uses

  git rev-list --objects --stdin --not --all --quiet --alternate-refs

where 39b44ba771 (check_everything_connected: assume alternate ref
tips are valid, 2019-07-01) added "--alternate-refs" so that the walk
from the fetched tips stops at the refs of any alternate object store,
on the assumption that the alternate is already fully connected.

That only works because "--alternate-refs" comes after "--not".
cf1e7c0770 (fetch-pack: write shallow, then check connectivity,
2018-07-02) drops "--not --all" for deepening fetches, since those
need to verify the whole chain up to the new shallow boundary rather
than stopping at refs we already had. For such fetches we therefore
run

  git --shallow-file ... rev-list --objects --stdin --quiet --alternate-refs

with the alternate's refs as positive revisions, and rev-list
enumerates every object reachable from them. Unless one of those refs
happens to lie inside the newly fetched shallow range, where the
grafts cut the walk short, that is the alternate's entire history.

This is slow for setups that attach a large alternate to a fresh
repository and then do a shallow fetch of a ref that is a few commits
ahead of the alternate, which is how CI runners share a clone of a
big repository between jobs. With a 7M-object alternate (a bare clone
of gitlab-org/gitlab), "git fetch --depth 1" transfers an empty pack
in under a second and the connectivity check then takes 227s. With
the alternate's refs negated the same rev-list finishes in 0.0s.

Pass "--not" in both cases, before the branch that adds "--all" for
non-deepening fetches, so that "--alternate-refs" is negated for
deepening fetches as well. Such a fetch still has to reach the new
shallow boundary from the fetched tips without stopping at our own
refs, which is what cf1e7c0770 wanted. It stops at the alternate's
refs, as every other fetch already does. Move "--alternate-refs" up
next to "--all" so that the arguments that bound the walk are in one
place.

Add tests to t5618 that check the arguments of the rev-list child via
GIT_TRACE2_EVENT for a regular and for a deepening fetch. The result
of the check is the same either way for a complete alternate, so
there is no behavioural difference to assert on. The difference is
only in which objects are walked.

Helped-by: Patrick Steinhardt <ps@pks.im>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Igor Wiedler <iwiedler@gitlab.com>
---
 connected.c               |  6 ++++--
 t/t5618-alternate-refs.sh | 12 ++++++++++++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/connected.c b/connected.c
index 929b9bd28d..cdf103bba5 100644
--- a/connected.c
+++ b/connected.c
@@ -121,15 +121,17 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 	strvec_push(&rev_list.args, "--stdin");
 	if (repo_has_promisor_remote(the_repository))
 		strvec_push(&rev_list.args, "--exclude-promisor-objects");
+
+	/* define where the traversal should stop */
+	strvec_push(&rev_list.args, "--not");
 	if (!opt->is_deepening_fetch) {
-		strvec_push(&rev_list.args, "--not");
 		if (opt->exclude_hidden_refs_section)
 			strvec_pushf(&rev_list.args, "--exclude-hidden=%s",
 				     opt->exclude_hidden_refs_section);
 		strvec_push(&rev_list.args, "--all");
 	}
-	strvec_push(&rev_list.args, "--quiet");
 	strvec_push(&rev_list.args, "--alternate-refs");
+	strvec_push(&rev_list.args, "--quiet");
 	if (opt->progress)
 		strvec_pushf(&rev_list.args, "--progress=%s",
 			     _("Checking connectivity"));
diff --git a/t/t5618-alternate-refs.sh b/t/t5618-alternate-refs.sh
index 2fb6d549d3..4cc39af0f0 100755
--- a/t/t5618-alternate-refs.sh
+++ b/t/t5618-alternate-refs.sh
@@ -58,4 +58,16 @@ test_expect_success 'log --source shows .alternate marker' '
 	test_cmp expect actual
 '
 
+test_expect_success 'connectivity check of a fetch excludes alternate refs' '
+	GIT_TRACE2_EVENT="$PWD/fetch.trace" git fetch origin &&
+	test_subcommand_flex git rev-list --objects --stdin --not --all \
+		--alternate-refs --quiet <fetch.trace
+'
+
+test_expect_success 'connectivity check of a deepening fetch excludes alternate refs' '
+	GIT_TRACE2_EVENT="$PWD/deepen.trace" git fetch --depth=1 origin one &&
+	test_subcommand_flex git rev-list --objects --stdin --not \
+		--alternate-refs --quiet <deepen.trace
+'
+
 test_done
-- 
2.56.0


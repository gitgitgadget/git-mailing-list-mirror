Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8BA21CFE0
	for <git@vger.kernel.org>; Fri, 28 Aug 2026 22:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787957533; cv=none; b=EJWeMIrSwIvIbr5QM+LgiyrYOfLq9N++IouP5So3Cl2+k/ISxMVn2alQ0BWuO9xqvRNmRzStTWVY80dcg+q2R0G7tQNyjiW5QFHaBOC4+BWNzRBNV/eNYBswD2AC1oNaQmnsSncHB68BhAtZUminVK6NRwdLG5fHX1C8tJ7zjSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787957533; c=relaxed/simple;
	bh=9fOKEHxvcqyNDycSbcgN3L2rWfrP1sLM7oH8o5T7VUs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i8XNSTN8cuPNTH6vMoNLAakORe1r7cZnPX7EuXILssNumbQD0I6q06pK2M4xdgMF9jnAqEEp66MxDFy+yosPCTnmYEWuvkwrLTWjvbkJY5igq/M7iWzrjXKhceFMl9GmE/pPvBCtEBJ9tPg3RcVj8nd+AhNmP0SnrWKL8XUG9As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mW3FFmLQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lp7tLLhT; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mW3FFmLQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lp7tLLhT"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 4E23D1D00045;
	Fri, 28 Aug 2026 18:52:11 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 28 Aug 2026 18:52:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1787957531; x=
	1788043931; bh=w1YCSaBiXuZlIv8ea7IHcfxCBrqtDESa/nCwyGAe5SA=; b=m
	W3FFmLQYsHeltf0pf9korEH+6gAdSpw/K5GYrsta4Ikt1iRS3/u3Orn2epNKA+mY
	mo1WnKIzmIwLdF4upk0z8m+OQR3s6HAh05LVCMvbFsn7+R2jAZHk2ZPFKxSEMpb4
	E1iZiMl91fwAne5NsWtqV6whnLsUJeF2egZBiOniCFRC3wQIFbOVqLgbY2oWmTGt
	t+KcqmKSmvtdY0YS5eC0DdjJR+45q6N5rrVBPcF4gnjv1GQOC1PNGSzTiPvReP3+
	3c9S1SuDZxjLMzeW3hCUDci3CGUzpxbNZQPG/LPLzRYO3xMWV1XIs8PPn0iueeom
	uvn2SKQG6WMhHng2aZNpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1787957531; x=1788043931; bh=w1YCSaBiXuZlIv8ea7IHcfxCBrqt
	DESa/nCwyGAe5SA=; b=lp7tLLhTQvnzHLg1PGVhzoJnpePDf95L3H2QszN4gLpV
	0ZvXNSTB+fUZV5yhw+7pGKR3abNIB8xVAZjAOVorrCk8VHeUSGUsxAqLyC4XOB5h
	DzSOm2jfaWb1X+koyNE4Y0Zr632i3PkN5ocWNdRqZWevuEyMp7OBZ1R7/cEwNV3N
	sKtQzW9YDibYXBJFBb2vPG30MpvT9X71rQo4MPekFQq+VXXvjawN96y7IJLmJkgw
	ie3yhB7hUXWm4EejFb3ZLh7f1Cv8uJmY6N7AQqlCKopb9egn8VhyJ9Q19YotAB7H
	20JMRK45TpvV0KQQAY9186sBCQYOzqqUQK/mZ0uHvA==
X-ME-Sender: <xms:GxGSastTvxUuhHzfflY39kemfhpf_wMHR_Xx5nTnlfXl7BseA-2c1Q>
    <xme:GxGSaveudkkFGspNPi92NwDFZHFZN2wpj6ENt4iMVZ3NUk0E7qV47PlHSniQuU6kj
    IPaOHbh6ERDd862VC7a0hfcwqkw6aqzcy3gfyL4Nf_YQUyejuRc0e4>
X-ME-Received: <xmr:GxGSalZft5qxJT-fwesmVR0FwvpuvG8hDnKw6xKTOTQiMVrP4QPpfoWDAD5cnCxWFlsqInuu8Rk4o5LKb5y2XgHB4mEBdtb5NA>
X-ME-Proxy-Cause: dmFkZTEC+LQSNrvb6E/M1Xll0EuUaS4YcEOHyU7TsRVWIW+NQMTY7E+vmioirGGvNQl4jA
    owPQNp1nmr/zh39kFmIJE1YssyS0h8se6+MSIHYg6w7oxBCDO5CM/zG42gSevsm1iQzpgo
    4xpJ7l6Fpl3IhZBppALJCr4SbUF+BpDWO283+tGMT/7Jk9fYxTp7Ad7msHZobwxjUK9V8P
    X/1o2zSHVxUEa4rJhJWoHrEaGWceEuk1qoqamZqqTrNQ7Xy/RtJRNu52YDg4SN2hm8kq9+
    05QB1LTaUCwEyOSc88uKmq1PzT8WLFQlzwa/MAXdoybCaJZFy8AHh7zk8SRV9lPgZOqfmj
    wlPgpdy7vhtiHdS+xbvrWOvZYZRlyEYLjcRIfNq+DP1/j+hd82VZpgDHg3xJekcwfjx/7S
    5cNxa5JyNF8WqppPWsEcr6sdJ0gau25/aytkJoPNu35M1pjLsXATQuPCX3WbYz4r5k2Ogg
    M8iwFf3w+XJBD1oJX4b9CUwjUOJ/Q2Oqv7K+9nwlJBKUtKZXBTh7IrrsmsWv5RujKXAwTE
    qjb8712WYROnEVilcH4ZMwpukFLkuHkjKMUDEvo1i1GLSfgNpc8mCL+ElA/o4sBoCgu2mI
    f4c60PgSCZjlBUm+N8aWCw6pm4Q/1AuAefbEJ2buSZwEpJqFVPAZ4kxwSVMQ
X-ME-Proxy: <xmx:GxGSaqUk3T5fffx0Ue63SqV9uWi3It8LmiBKS4oDk0nO15CwxUaAKA>
    <xmx:GxGSavhV9zpM_PupQTE-SnrPDjFcWuN5uiwRm6g8-qcLn3BJflkgLg>
    <xmx:GxGSagVWxEBhqnf0VBaf-8scgLZ1jPezfgee6QKC3gYJNIE-sGsdcg>
    <xmx:GxGSauPQEXfS-3uVvX919O7CeDVwxQu-4Qz9674aGbMC61CgytfYyQ>
    <xmx:GxGSaoEjOU9x7DDdhHetLNaZLx_hwZbV11GC3gxVMreoTqErkn8sJTCJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Aug 2026 18:52:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 2/8] checkout: validate new branch name in checkout_branch()
Date: Fri, 28 Aug 2026 15:52:00 -0700
Message-ID: <20260828225206.310500-3-gitster@pobox.com>
X-Mailer: git-send-email 2.55.0-884-g76cf8659c2
In-Reply-To: <20260828225206.310500-1-gitster@pobox.com>
References: <xmqqh5kd3lm3.fsf@gitster.g>
 <20260828225206.310500-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In checkout_main(), new branch name validation is performed before
dispatching to checkout_branch() or checkout_paths().  Checking out
paths does not create new branches, so this validation only belongs
in checkout_branch().

Move the validate_branchname() and validate_new_branchname() calls
from checkout_main() into checkout_branch().  checkout_paths()
checks and fails if '.new_branch' is set before doing anything,
which indicates that this change is safe and makes good sense.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/checkout.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 774e4fd5b3..14542626e9 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1734,6 +1734,17 @@ static int checkout_branch(struct checkout_opts *opts,
 		free(full_ref);
 	}
 
+	if (opts->new_branch) {
+		struct strbuf buf = STRBUF_INIT;
+
+		if (opts->new_branch_force)
+			opts->branch_exists = validate_branchname(opts->new_branch, &buf);
+		else
+			opts->branch_exists =
+				validate_new_branchname(opts->new_branch, &buf, 0);
+		strbuf_release(&buf);
+	}
+
 	if (!new_branch_info->commit && opts->new_branch) {
 		struct object_id rev;
 		int flag;
@@ -2062,17 +2073,6 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 			die(_("you must specify path(s) to restore"));
 	}
 
-	if (opts->new_branch) {
-		struct strbuf buf = STRBUF_INIT;
-
-		if (opts->new_branch_force)
-			opts->branch_exists = validate_branchname(opts->new_branch, &buf);
-		else
-			opts->branch_exists =
-				validate_new_branchname(opts->new_branch, &buf, 0);
-		strbuf_release(&buf);
-	}
-
 	if (opts->patch_mode || opts->pathspec.nr)
 		ret = checkout_paths(opts, &new_branch_info);
 	else
-- 
2.55.0-884-g76cf8659c2


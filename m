Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC59E32B99F
	for <git@vger.kernel.org>; Fri, 31 Oct 2025 14:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761920550; cv=none; b=rS2JvrvE905kv79iKtzr6i/pbeb0ZPKr+OMADIrEReZM1d4TpUCLXmGQq6NO7smYn1CakDrdzxWPNi3z7Ei/dz6cyv6podSaS1EFNpNAlfqIJuGfoax4wO3aQNSyiSlbIf4DTQ5y5X8dtP/mqwhJgafNtYbvlG5jNe7Q455+8Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761920550; c=relaxed/simple;
	bh=P/JdFLU6tafGaJWOamcNGNib0MW+QSqLpfISZDR0K9I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JpyumkFqBB/xQN8p8gI0dFYMEbWeGwkARerEWNwPpSYr2mItfk057BYAQhswRT976DlgzJP4k0iLg44V9oQSUgyFtcPh3IHWUeDwxx7mCKTxQ/gM8cD+nBI8iyMxP8HChbE5gLOSGBPBpJDtgWWxfztP+k4Pm7vRBAElqScow5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gwVz5+bA; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwVz5+bA"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-475c9881821so22037945e9.0
        for <git@vger.kernel.org>; Fri, 31 Oct 2025 07:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761920547; x=1762525347; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KIQqJ2mKsYrdKJKrUPfmk+aLgzzJACBSIq2X6xRbmcI=;
        b=gwVz5+bAiu8vHPiZptccnYFyxoFEJguUc0r5tpjuAeJ/J8wXL1UOrR9SvYlPqJK6VU
         c6jpO0YNC6xCFg5cVSZTMTBABOEnNiCqvh4o780i/2tPj6kyGctE1ruwome85Nu85cIJ
         g9pI/eA90cBvTezEiME7kehirHDkSUwvoUhzzvLgzjQT2IMi2vzM0McOYUuBRnRI0qn4
         sn0AO2hVrByMMGRmXqLFgOFgUhhepLay5JTLA8jsNM6NdK85lOrddk7EdvRUMPz0LGo+
         DrJpTlm8bWY+K58K7oYPXXL5oj90k5+ZgzO5ciJArBjiw9E61JGW4LMkAf0axRS80/Yx
         POtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761920547; x=1762525347;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KIQqJ2mKsYrdKJKrUPfmk+aLgzzJACBSIq2X6xRbmcI=;
        b=Oqjxc9w+mg9hFP28FF4Si27uJsQENPV013hMdGnpGVvo0RcckBcsaJqzzfwkiDNFHp
         j+mF6pLZW1L9S8D5EQeW9x1yCG/ykqWXWTIi99EaNfVd0q8Ue37GpMSUc1x+3e8ynB9U
         F9OtUmuR6EikFleRYJDy4daGpc8veIqcJOJLHw8h9iTweoJg+ofJS1MIUSJWhCW4gG6G
         otjqnQVFv8Sov9B1mWvmlGodu9bpZqSELEeuXufQnsfwft0zh4jx98cxxRKDxN4ges5O
         eVYRoUZsi4735+B6BS4gUrRTw8cLg0W0Eo4YH3omejCHiG/CJJvkfaQi8eO/VMbdKrNZ
         KQ2g==
X-Gm-Message-State: AOJu0YxGKGSwonnSBTTkMH+E9yATRHqFZONVje/AxacMWspIjImjYYrE
	7g5U0WrG3nTBulEB5mZAMRPeYPB+JgGlLkNUU3AlzoPnpisllhcmHU8yxaSXUHBT
X-Gm-Gg: ASbGncuNIRdXOr+cCetZIcV2RRihx/o6a1K5lbPre5Wq3JWSTA1O2IUoDVyNJE3Mjmo
	q40bOPWXQWbe302bIP1qVzrQC3ybW30WtlSMp3s5k6pdvKyhzeJ+CP1h4l8Apodjub+c3gwWqks
	8uMzlKcg8HFJs6UD5owGPrp2kVygd9ynDi7OtMifr0S9NV7IAk1cJTBC2ddOd9KK24ToitCQhQR
	toCtsZs3jnQA7hIIv9aI8q0XKlvl5ECdBTnHo2zmLsba2/SThsNlhamOBXxEOxJGHGLguqYbSVB
	QrlhwuwteOw9EAI6uaUsTOKKdlRFJL1Ld14RGyJ9lYU3lK2/uSYkEWcogoqBq0L59qgB4Mnr8IK
	Hmdp+S1LEAiTcnQBejy/ONL3nir3yEF57wR5fKiyHDDZyQYby5d1tKJyx7zCf3oIPHe1LI43TAF
	lNS78=
X-Google-Smtp-Source: AGHT+IHdYYRyBg1MtXGgcxcA8lbOmCmPJ2uujXX5LUz2oc/Ij9PPTxT2jKowduDD+p+PuisG7qzDcg==
X-Received: by 2002:a05:600c:4f11:b0:46e:3b58:1b40 with SMTP id 5b1f17b1804b1-477300681c9mr46150125e9.4.1761920546467;
        Fri, 31 Oct 2025 07:22:26 -0700 (PDT)
Received: from [127.0.0.2] ([213.61.187.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c2eae9csm570435e9.1.2025.10.31.07.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 07:22:26 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 31 Oct 2025 15:22:24 +0100
Subject: [PATCH 4/5] maintenance: add checking logic in
 `pack_refs_condition()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-562-add-sub-command-to-check-if-maintenance-is-needed-v1-4-a03d53e28d0e@gmail.com>
References: <20251031-562-add-sub-command-to-check-if-maintenance-is-needed-v1-0-a03d53e28d0e@gmail.com>
In-Reply-To: <20251031-562-add-sub-command-to-check-if-maintenance-is-needed-v1-0-a03d53e28d0e@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3593; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=P/JdFLU6tafGaJWOamcNGNib0MW+QSqLpfISZDR0K9I=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGkExh5L1RCPkdDZO+O4rKiaYGZ0cbndUXK4+
 WGeTs2mQ9qTfIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpBMYeAAoJED7VnySO
 Rox/YmYL/iUROJpifoJAHi/ylER51oyjpeWrZVNtgXQzBbPCDbWU3KnzSJZdweUOppJz+jXgQ7W
 xv9uDVjwIhvU1w46Bmc1L6mk92gBjfRk/RKxzsEqjIT53MhhJd4eLzrGnSoR/7UHsRYCLmSINvL
 FkxpP1sJPRQIfti1eFS59ZrdOIyaSRly/sU4+zoTVZ5xAE9vJetQCkC8aBh3tti9QTS/eR1NDZF
 ZTozeQrCJbHYqHkCxNHRWflyZcreyyRtrR8AusZsRI7FgEFXVn89EUU4btv3ZpPIm63G+uYFZ6M
 rcgfX/3vMvCqFlAwVTftKfRT97QsLlMnhNAjd29h7B6oNQeU9Vs8nUu6MjCiKTJCXnY2sswXBq3
 96ddPSpSMzxkOHvoQOOQx5abif53AXXIpDlBW+ePtiok38SAe/LFan1LYDTQJcAP2xLXuGqbiiB
 tBdLWNXq09lT1M/xymhao1YN2dlhxHpw1+cxA8631XaIIlho58w2nb7q2Fc6bPPuBNDNWgHFkr6
 CI=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The 'git-maintenance(1)' command support an '--auto' flag. Usage of the
flag ensures to run maintenance tasks only if certain thresholds are
met. The heuristic is defined on a task level, wherein each task defines
a 'auto_condition', which states if the task should be run.

The 'pack-refs' task is hard-coded to return 1 as:
1. There was never a way to check if the reference backend needs to be
optimized without actually performing the optimization.
2. We can pass in the '--auto' flag to 'git-pack-refs(1)' which would
optimize based on heuristics.

The previous commit added a `refs_optimize_required()` function, which
can be used to check if a reference backend required optimization. Use
this within `pack_refs_condition()`.

This allows us to add a 'git maintenance is-needed' subcommand which can
notify the user if maintenance is needed without actually performing the
optimization, without this change, the reference backend would always
state that optimization is needed.

Since we import 'revision.h', we need to remove the definition for
'SEEN' which is duplicated in the included header.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/gc.c | 30 +++++++++++++++++++++---------
 object.h     |  1 -
 2 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index c6d62c74a7..72177305ff 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -35,6 +35,7 @@
 #include "path.h"
 #include "reflog.h"
 #include "rerere.h"
+#include "revision.h"
 #include "blob.h"
 #include "tree.h"
 #include "promisor-remote.h"
@@ -285,12 +286,26 @@ static void maintenance_run_opts_release(struct maintenance_run_opts *opts)
 
 static int pack_refs_condition(UNUSED struct gc_config *cfg)
 {
-	/*
-	 * The auto-repacking logic for refs is handled by the ref backends and
-	 * exposed via `git pack-refs --auto`. We thus always return truish
-	 * here and let the backend decide for us.
-	 */
-	return 1;
+	struct string_list included_refs = STRING_LIST_INIT_NODUP;
+	struct ref_exclusions excludes = REF_EXCLUSIONS_INIT;
+	struct refs_optimize_opts optimize_opts = {
+		.exclusions = &excludes,
+		.includes = &included_refs,
+		.flags = REFS_OPTIMIZE_PRUNE | REFS_OPTIMIZE_AUTO,
+	};
+	bool required;
+
+	// Check for all refs, similar to 'git refs optimize --all'.
+	string_list_append(optimize_opts.includes, "*");
+
+	if (refs_optimize_required(get_main_ref_store(the_repository),
+				   &optimize_opts, &required))
+		return 0;
+
+	clear_ref_exclusions(&excludes);
+	string_list_clear(&included_refs, 0);
+
+	return required;
 }
 
 static int maintenance_task_pack_refs(struct maintenance_run_opts *opts,
@@ -1090,9 +1105,6 @@ static int maintenance_opt_schedule(const struct option *opt, const char *arg,
 	return 0;
 }
 
-/* Remember to update object flag allocation in object.h */
-#define SEEN		(1u<<0)
-
 struct cg_auto_data {
 	int num_not_in_graph;
 	int limit;
diff --git a/object.h b/object.h
index 1499f63d50..832299e763 100644
--- a/object.h
+++ b/object.h
@@ -79,7 +79,6 @@ void object_array_init(struct object_array *array);
  * list-objects-filter.c:                                      21
  * bloom.c:                                                    2122
  * builtin/fsck.c:           0--3
- * builtin/gc.c:             0
  * builtin/index-pack.c:                                     2021
  * reflog.c:                           10--12
  * builtin/show-branch.c:    0-------------------------------------------26

-- 
2.51.0


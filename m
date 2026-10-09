Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549D4360EE1
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 09:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791537222; cv=none; b=sELg9isnAW35N21proVWr/pmd004qso6aXExJG4V32RhBIejuMjlNEWCh5Q8WKXnTDQOEBltCd3alHE9jbRqQ1ZpS5QdeBbOgVQXII+Vm0HVP6AsSbtdYJRskdSGKDoGmVe69rnzpW5JQeHSTU93Ka60LVFHdsTnquiCeuGyJmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791537222; c=relaxed/simple;
	bh=JNi9O/G873ZdorLoR0Kq1mkwlrxJlVuRhx0YKblxmnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VYixMwz8oG2CCyVlVrKGshhFkIjpSvAiXOf4P9p/VUgSqTazYSbSsZgXC7AmRSlgc5vb7GUgql5oxvY9iBMGohYksJfvGTAdWgVO01cvekczVR9RqQSZoA4o+AsMrdYs73m/mPf9owRMJsFLPsV/zi9Gas3J62Op9nN5ljuIqqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q45PWqsZ; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q45PWqsZ"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48b060ec084so2745566f8f.0
        for <git@vger.kernel.org>; Fri, 09 Oct 2026 02:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791537218; x=1792142018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=utd/Nf3k+OrpRR2oXkxSjpCtjrbSZ0s3AerQyUQWqX0=;
        b=Q45PWqsZKZnLUPS9oJ9FV6+W7/jNXWZKVEGBwSOZ+f8lDQP6sGtm2seIL71tYMZe7s
         3b+kw7kZidsAT9nHN7EE98N/85oBHwhsedmcq9W66Jd/KhNmVgw6KXglqFA9lRaaZTh1
         vhs9k1uP6oSQUPqh8sFWmOEDSPIUvkJ4e+S3NcsETChIFT9hnEyFNiyOZtIofOHlTw1Y
         bekhvb4Fq1hJjXGplyrk++V4llMiNpas2ZoM0P+DBbauR1OTvJC4B24z4+Qj7Z8DSKQ5
         Xu9oNQZ09t1jzKUFGVwiuLD4/sj7LAnEOW0JfacPhD86XlI9sjRPa/y2e8grNCTxGdhJ
         27tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791537218; x=1792142018;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=utd/Nf3k+OrpRR2oXkxSjpCtjrbSZ0s3AerQyUQWqX0=;
        b=K907825JgW4UpQLH/pfowap1492Ipn05eQ2UXPenq9KTU2iR2ckWixYwIA8Y2mYIu2
         PlQClD11H1oiiMgJe1cZUntuWKNHWbNv0L+nE8VGQZEfvlDDPw59fYnyJaSoCkaNtleM
         VM7Cf8LdmCwrgLbzyhUWc5SU2fKWJL0GVYBeuAtFXXbdhzso4S9R+MI6zsi2joHfhvNk
         Ftp4VE1BEOOswhi6FJQChEB6zohDgvObZ0+7x31vtc5FUrxgkTRk4jG6KVdJa+D4rIFd
         /VJH4yHAZGaph7TrdciyInwxZOGPxKD1RHB3kzWShH4VIc7oLdfhI/aOzT1vLn+tXubK
         qgug==
X-Gm-Message-State: AFq9FYIf7nzX6frXEzy2Z7gqFA5NJuOPgk+VcN2U6oThnJr/nfwCj2VI
	WnJTHiM2ALb+R/dx4/tiyeSaEP42P04EObpCCJtiH80iAOczGTIr4E1x1iQTPA==
X-Gm-Gg: AYBFou3SICbprymgo5P2VMl5MLkvcrcJYi6ISqDH1c32THKLh/2jFTi0Ltk4UQdAClf
	L9fnjOI9KoBo16pgDgzYhZ938El56P/LfA4Nh7OAngOYmNcjUxn9OBXPebir+xe4mtXsn+bsZ8I
	u7G2CcDLvLk140TN0VAdyBf03AIy94OAogag+oJ8yyxmC1rEDi045kBpLFsLv+TJAWg3HnSTVHz
	FOty6mwUhwDJFM2EikALcszmv1j5Hrjlp9RBI6nUhPPhWXVQ59yU6ZtXQwnpzNcnkZh1L1fjTPR
	Z/FzE7jG6LDRlDa7HpTVuAlKPm+DGT+sCn4T2onDJkNbZoncxxirHyTjaPg/1bR4kvsaUvVTMXu
	SVjtdgoYkWV/RRoEXIO9370GBzpri/Lyft8v5ezdkLiSYQCvHSrpXujdREPUniQxNuP397l8YYv
	OP1Ah/l3hrFToygKY5RG3OGDB7YGE1NBGWUjkgQNv5GNCRthrfNpQRF2Z6v8plhfNMwY84dYIoh
	A==
X-Received: by 2002:a05:6000:29d3:b0:48b:3b4:1c8e with SMTP id ffacd0b85a97d-48dbaadebbdmr1611304f8f.20.1791537218444;
        Fri, 09 Oct 2026 02:13:38 -0700 (PDT)
Received: from berwick ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db93d6069sm2657813f8f.0.2026.10.09.02.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 02:13:37 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v3 1/2] remove_branch_state: convert boolean argument to flags
Date: Fri,  9 Oct 2026 10:13:24 +0100
Message-ID: <86ef0f848a35c66b2d68f96c5f307a6c80f74c78.1791537203.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.56.0.134.g299a3c16181
In-Reply-To: <cover.1791537203.git.phillip.wood@dunelm.org.uk>
References: <cover.1790761727.git.phillip.wood@dunelm.org.uk> <cover.1791537203.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Convert the "verbose" boolean argument to a flag so that we can add
more flags in a future commit.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 branch.c           | 4 ++--
 branch.h           | 3 ++-
 builtin/checkout.c | 6 +++++-
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/branch.c b/branch.c
index 22f4f46b96..8bc7a395a7 100644
--- a/branch.c
+++ b/branch.c
@@ -871,9 +871,9 @@ void remove_merge_branch_state(struct repository *r)
 	save_autostash_ref(r, "MERGE_AUTOSTASH");
 }
 
-void remove_branch_state(struct repository *r, int verbose)
+void remove_branch_state(struct repository *r, unsigned flags)
 {
-	sequencer_post_commit_cleanup(r, verbose);
+	sequencer_post_commit_cleanup(r, flags & REMOVE_BRANCH_STATE_VERBOSE);
 	unlink(git_path_squash_msg(r));
 	remove_merge_branch_state(r);
 }
diff --git a/branch.h b/branch.h
index e9b1f7b37d..42d1b12918 100644
--- a/branch.h
+++ b/branch.h
@@ -127,6 +127,7 @@ int validate_branchname(const char *name, struct strbuf *ref);
  */
 int validate_new_branchname(const char *name, struct strbuf *ref, int force);
 
+#define REMOVE_BRANCH_STATE_VERBOSE (1u << 0)
 /*
  * Remove information about the merge state on the current
  * branch. (E.g., MERGE_HEAD)
@@ -137,7 +138,7 @@ void remove_merge_branch_state(struct repository *r);
  * Remove information about the state of working on the current
  * branch. (E.g., MERGE_HEAD)
  */
-void remove_branch_state(struct repository *r, int verbose);
+void remove_branch_state(struct repository *r, unsigned flags);
 
 /*
  * Configure local branch "local" as downstream to branch "remote"
diff --git a/builtin/checkout.c b/builtin/checkout.c
index c0f0d2c700..bdd2d816b6 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -950,6 +950,8 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 {
 	struct strbuf msg = STRBUF_INIT;
 	const char *old_desc, *reflog_msg;
+	unsigned flags = 0;
+
 	if (opts->new_branch) {
 		if (opts->new_orphan_branch) {
 			enum log_refs_config log_all_ref_updates = LOG_REFS_UNSET;
@@ -1044,7 +1046,9 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 						   old_branch_info->path);
 		}
 	}
-	remove_branch_state(the_repository, !opts->quiet);
+	if (!opts->quiet)
+		flags |= REMOVE_BRANCH_STATE_VERBOSE;
+	remove_branch_state(the_repository, flags);
 	strbuf_release(&msg);
 	if (!opts->quiet &&
 	    !opts->force_detach &&
-- 
2.56.0.134.g299a3c16181


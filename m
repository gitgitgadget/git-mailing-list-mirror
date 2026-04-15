Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185B73E3DB5
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 16:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776270271; cv=none; b=uggpW+Tl1qw/lNCVvMogf/cSOfjqpeMF9IM+gdWar1BR27Q5GZwc43ucCv6oX8Wb00TIsZOPK/IIyAH8IsMqBdCdLhkf9ZAUFV33mdGVKwfqbhSrmIUFFpr9eXzO3w53lPSc3Cw3T2nTOvoL6hLw4o4t/1yx1N/d0Krnf9qHmKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776270271; c=relaxed/simple;
	bh=8kfNHTLf88QUizxh/ERs1eZR5wQo0Tdtk0yyamX9Dew=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Xq/aAE5tdbSiomUNgM3yHWYU0WA8bfZspE9Kgo7oFPO0uiPUQquuo81pKeYmkh4ltGXnt5ze1jWZWBBS/SUOq0p/6zgYO2evDOo4BPsPrcwV9OkYaosgU0PXW1WHWFmB0z6ZXzeZ49+SAwxovWVoG+ZSdMc+g3WCjplzCCjSJlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DMros0av; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMros0av"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-46fc5b8a068so2433657b6e.3
        for <git@vger.kernel.org>; Wed, 15 Apr 2026 09:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776270267; x=1776875067; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vfI140ofMyE62mQjg6oLyFecqqsy2avPp3tJ+m9QJeI=;
        b=DMros0av3+gB8rp/TnRcfewXa9lFP61voT4JcDrfaFbmyeUv3nKtYKZzH8Qmgm9VLY
         YeuNCf8VEFyEcfDfARy5RUZSpG4Xo77kMbegZE3HwdN7zWkWR6hjhmwXFRPZRUDXP3Fz
         jVvZXbU1qWcS9rLoQIaavWyi44In6MaQTYosbzedxt+cAY3DlBaHwq5X3UmWKyzy8MI/
         Que4tSUE0g8GYv5PHGVIxewDrLCRBGcoCqszlWATndnhS3R5slTB5BzPedNzYvmYKw68
         Zejg0jhh1eXSBxq/xbF55dwe6pbSLSF6VcqruxWL0o/q4erfsGom0L66l4PyMzkA9K6y
         h1MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776270267; x=1776875067;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vfI140ofMyE62mQjg6oLyFecqqsy2avPp3tJ+m9QJeI=;
        b=dCW+9tRRd9UkZwshiZa3C4fsyIuIj/lhtU1I0lUNVJaOEw0BSuGalGfwvf/Y0qL3TN
         u/S5NvmjuCKTnwVfqJcllLAQxE1qzu4NK3YBh0RiGyxqt8NYohTOeOPWYZSI+i6Fb7dB
         fCbQ82S9UlhB6XcNxa5SPoszBB3LlLhYzu881S/Cp+ezNjAbvp/s5PepEQ7xV9NYUJ/J
         vcP0yO94TFuC2zzMACeUONZToNsithS53rGMlgzHBzGft9YaONhMRIcDAsJ1jzVyOgEd
         vJlush+jqXLo/91dZkRPTTbPTe1vcE57EhgLmu0L3CEAMDbUboVNjjNAkp8LdKwRqZUB
         37zQ==
X-Gm-Message-State: AOJu0YxfL7ihBHQgpebqNZYhm4+ooX4iOB5y0RqMebKvxpoKqNDwD1Ds
	wOhnrO0ZzYsMkAJ+OrrOjUVGY700DfxjcObYT9ad8DrRDDSsD5eBSkWYiJneuA==
X-Gm-Gg: AeBDieukyCTb/9o1ix/7+RGIuQ7y0gJc77Dn/YaF97kUlu7x56T4EiizJvr2swT5Kpv
	kT33PPeAqkF029AhHFpnv0ztKz9GtOP/yAJ0D4rfsg367tlMVHwOcaSMO//9NpkBTLvSpBcwnHy
	dq8NLXkZOK7ghqzw2sg4j0Cf0AXJOYoUJgAnohcHkNy292KZjQOCxSlzDOEi29uUVXQkdjMN/EC
	B4iYxJdGHWUed0wH9S+Uyd5skgGgkyeoMzyA353yINLF1WXmycjFMJgAdBz88PEVN9t+Q9Bra3/
	ZQRJqQUfqn+n9Qjimr5tGjWustW8NyPSJLuAL2dAaqCdkVAPCBMtvDakOoYe48iuoo/JhyZmvjA
	vDqX/jH/Cn4f1v/Sqfc1ygTPCxsUU3hlWfSQPHqRFPgDbt69lHJYsGjpfXD+1QhjMACuMJ0pnMc
	3sd4ke9sAtYGjR/QzrGl3U4/CRl4uU2d6MEUM=
X-Received: by 2002:a05:6808:4f0e:b0:46e:bd63:716d with SMTP id 5614622812f47-478a050544fmr11172731b6e.40.1776270267390;
        Wed, 15 Apr 2026 09:24:27 -0700 (PDT)
Received: from [127.0.0.1] ([52.154.21.53])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4797a387ba5sm1128453b6e.7.2026.04.15.09.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 09:24:25 -0700 (PDT)
Message-Id: <191058d8e3f6794261215653aeecc4cada423171.1776270259.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2234.v14.git.git.1776270259.gitgitgadget@gmail.com>
References: <pull.2234.v13.git.git.1776251517.gitgitgadget@gmail.com>
	<pull.2234.v14.git.git.1776270259.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 15 Apr 2026 16:24:18 +0000
Subject: [PATCH v14 4/5] checkout: rollback lock on early returns in
 merge_working_tree
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Chris Torek <chris.torek@gmail.com>,
    Jeff King <peff@peff.net>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

merge_working_tree() acquires the index lock via
repo_hold_locked_index() but several early return paths exit
without calling rollback_lock_file(), leaving the lock held.
While this is currently harmless because the process exits soon
after, it becomes a problem if the function is ever called more
than once in the same process.

Add rollback_lock_file() calls to all early return paths.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 builtin/checkout.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index e031e61886..c80c62b37b 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -783,8 +783,10 @@ static int merge_working_tree(const struct checkout_opts *opts,
 	struct tree *new_tree;
 
 	repo_hold_locked_index(the_repository, &lock_file, LOCK_DIE_ON_ERROR);
-	if (repo_read_index_preload(the_repository, NULL, 0) < 0)
+	if (repo_read_index_preload(the_repository, NULL, 0) < 0) {
+		rollback_lock_file(&lock_file);
 		return error(_("index file corrupt"));
+	}
 
 	resolve_undo_clear_index(the_repository->index);
 	if (opts->new_orphan_branch && opts->orphan_from_empty_tree) {
@@ -797,14 +799,18 @@ static int merge_working_tree(const struct checkout_opts *opts,
 	} else {
 		new_tree = repo_get_commit_tree(the_repository,
 						new_branch_info->commit);
-		if (!new_tree)
+		if (!new_tree) {
+			rollback_lock_file(&lock_file);
 			return error(_("unable to read tree (%s)"),
 				     oid_to_hex(&new_branch_info->commit->object.oid));
+		}
 	}
 	if (opts->discard_changes) {
 		ret = reset_tree(new_tree, opts, 1, writeout_error, new_branch_info);
-		if (ret)
+		if (ret) {
+			rollback_lock_file(&lock_file);
 			return ret;
+		}
 	} else {
 		struct tree_desc trees[2];
 		struct tree *tree;
@@ -814,6 +820,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 		refresh_index(the_repository->index, REFRESH_QUIET, NULL, NULL, NULL);
 
 		if (unmerged_index(the_repository->index)) {
+			rollback_lock_file(&lock_file);
 			error(_("you need to resolve your current index first"));
 			return 1;
 		}
@@ -857,15 +864,19 @@ static int merge_working_tree(const struct checkout_opts *opts,
 			struct strbuf sb = STRBUF_INIT;
 			struct strbuf old_commit_shortname = STRBUF_INIT;
 
-			if (!opts->merge)
+			if (!opts->merge) {
+				rollback_lock_file(&lock_file);
 				return 1;
+			}
 
 			/*
 			 * Without old_branch_info->commit, the below is the same as
 			 * the two-tree unpack we already tried and failed.
 			 */
-			if (!old_branch_info->commit)
+			if (!old_branch_info->commit) {
+				rollback_lock_file(&lock_file);
 				return 1;
+			}
 			old_tree = repo_get_commit_tree(the_repository,
 							old_branch_info->commit);
 
@@ -897,8 +908,10 @@ static int merge_working_tree(const struct checkout_opts *opts,
 			ret = reset_tree(new_tree,
 					 opts, 1,
 					 writeout_error, new_branch_info);
-			if (ret)
+			if (ret) {
+				rollback_lock_file(&lock_file);
 				return ret;
+			}
 			o.ancestor = old_branch_info->name;
 			if (!old_branch_info->name) {
 				strbuf_add_unique_abbrev(&old_commit_shortname,
@@ -920,8 +933,10 @@ static int merge_working_tree(const struct checkout_opts *opts,
 					 writeout_error, new_branch_info);
 			strbuf_release(&o.obuf);
 			strbuf_release(&old_commit_shortname);
-			if (ret)
+			if (ret) {
+				rollback_lock_file(&lock_file);
 				return ret;
+			}
 		}
 	}
 
-- 
gitgitgadget


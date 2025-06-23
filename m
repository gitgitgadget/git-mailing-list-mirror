Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9935F22B8D5
	for <git@vger.kernel.org>; Mon, 23 Jun 2025 23:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750722252; cv=none; b=l7Qg6vlZL5q3SI79uzYgiPPpVexn0IugNb9fssD2gjO/qaD8T0Ztr9bz0NvszIweOjj+WCKmIwyM3DNxTdLqYgKXSFLfAjFLWF2Rvb7lRxtSDJGvQJHnbomaiY/pNSUvItOTVC9az+qIh6fWZChfcatcD5fq+vkTRBqg6y0D3eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750722252; c=relaxed/simple;
	bh=7Dx0PzD4a6scp9ctQxdDKeGS3LIk+cvBZe1G8Q8iR+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cytlNWBRtWfN+rU7cpu/nxFisg91+loi/Q7A+6LyCDfIu4W7mCXnORHLO44Pkbwjeeywq+g7o+qFYMYiGnpvJIjAibF+L7VxieHwX3qqqHYpgdwZ0mWobM2JaX/VbLLRsiT2OcIKEC8J/yIVh5vFizW/vKhef2S2MK9RMgU5UwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IwSNzWKX; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IwSNzWKX"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-747c2cc3419so3417468b3a.2
        for <git@vger.kernel.org>; Mon, 23 Jun 2025 16:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750722249; x=1751327049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iB8mTQ0Fae0LK5ctig8j9gKp1lIETAJvt+fpukDqMys=;
        b=IwSNzWKXwp9HiAHgqo/jMGf0rPd7o3dAy7VTSig2Vm+gxPXzXz1p6ulsl4KH88XIN1
         FON9c8hxbtp/FxGXbJXfxEYEb3XrPzm31kXiZ9z/NcmChUpy4Xqx89pMdYSGIHiF7gJY
         fFYZtYOvHtosSK/oytenUTOcDVsmHXtVewAc61hDLsPZGHAZovB+pCShPz4KcvD69tCM
         xlWynk+UnogE41TdJucJqaGfRaDQ037TY+6RbuLAIKEBK2rm2IzkiiDJXSve4CmEJPrV
         bPor0RhKRVeBg3WJswNrYnY70xr35pLzAhHreFiFJX/Z/aK4/xdYfHFXZNGpzJRURlRG
         TNCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750722249; x=1751327049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iB8mTQ0Fae0LK5ctig8j9gKp1lIETAJvt+fpukDqMys=;
        b=lUsYkTZIlP6MbiYquZKnIUPbTpM9O2JjNrgMt2cIpgtgWSFxtzv++7I8ut0qJHIVek
         jKIahqqTYbyCrtmUq6b5AMCzG4AT7VVDI4JsV0n6Ktx/uNVnjkQ976bJlAeeEq7qbj/K
         Jbllchfx+iXCHNCSbG5IQY8/Ila1r1B6IIwWu4EM2dRiZWey88O8AqL03zynPCLG+Dlj
         11V9XdfGFzxhNNVPDEZT2a4ldt5pTlDyfGkGcEY/Cm+zgu2ThsckDAyoxUCZfAut1xN5
         eKxF2iaHTP6T+y/hqPK/vluR8F43+kxVQifISwLp415UzyoOzxze3b9WNSVYFwBfCZno
         fcag==
X-Forwarded-Encrypted: i=1; AJvYcCWZL2Lz0ja+kHYqQt0bXIfj7DfQYkEkQIUUs8Vtc+jxsbPDmwWv8Dq6NEwFnZ8wAOQIYCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLkOJ1LKyyUgcIXx1w9iJDXfBPdTyr2c9PV9eAkdEiceA86+58
	um9y/WnOFBIiIxLrgnj/KSJ1J+Bj9o/kGqBEPKyDAFAovKJ3OJsJGUwK
X-Gm-Gg: ASbGncuPUv3gPLGpyec5G7RVdmpiVnB0/HubgB7yE+nzUtB2heUXrDFJR+tRr1y8nuy
	KwCcZHG/wXyUJ1rYkZEoU6aJBeTG45LCsKO81XcMs+agzEhTS/9FbdQFtfPra0mbOHUbbCccPxW
	CD63gBA/Y3fh656HkZgSbFJ3TAMxYaTphqJCvHR1dY5NQ2lHudluGvb9VhKCfHho1azv3HCGgkB
	Bkk8yQJZw4usUxjQih03/qJbYzmoNuy4Uyutu5sOtSn6bRHcaYmlHEs/VIS08fuX6eVACyn31NS
	yxJWHyk0Mexm08sFaBtWKfQqiJzgQB0gSMUGboyeYfIiXH3xteR/bsNbKyc=
X-Google-Smtp-Source: AGHT+IF9azBKI2XTrGqsBvQPivBqvPrUmgRu44bSc9zdXB6cfjEY/Gs3bbh/MNXF+QfzuKlm/pVO/A==
X-Received: by 2002:a05:6a00:22c4:b0:746:27fc:fea9 with SMTP id d2e1a72fcca58-7490da49eccmr18889785b3a.11.1750722248741;
        Mon, 23 Jun 2025 16:44:08 -0700 (PDT)
Received: from dev-phord.dev.purestorage.com ([208.88.159.128])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-749c882cc92sm252856b3a.82.2025.06.23.16.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 16:44:08 -0700 (PDT)
From: Phil Hord <phil.hord@gmail.com>
X-Google-Original-From: Phil Hord
To: gitster@pobox.com
Cc: peff@peff.net,
	git@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Phil Hord <phil.hord@gmail.com>
Subject: [PATCH v2 1/2] fetch-prune: optimize dangling-ref reporting
Date: Mon, 23 Jun 2025 16:43:26 -0700
Message-ID: <20250623234327.335490-2-phil.hord@gmail.com>
X-Mailer: git-send-email 2.50.0.84.g5d85fe910b.dirty
In-Reply-To: <20250623234327.335490-1-phil.hord@gmail.com>
References: <20250623234327.335490-1-phil.hord@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phil Hord <phil.hord@gmail.com>

When pruning during `git fetch` we check each pruned ref against the
ref_store one at a time to decide whether to report it as dangling.
This causes every local ref to be scanned for each ref being pruned.

If there are N refs in the repo and M refs being pruned, this code is
O(M*N). However, `git remote prune` uses a very similar function that
is only O(N*log(M)).

Remove the wasteful ref scanning for each pruned ref and use the faster
version already available in refs_warn_dangling_symrefs.

In a repo with 126,000 refs, where I was pruning 28,000 refs, this
code made about 3.6 billion calls to strcmp and consumed 410 seconds
of CPU. (Invariably in that time, my remote would timeout and the
fetch would fail anyway.)

After this change, the same operation completes in under a second.

Signed-off-by: Phil Hord <phil.hord@gmail.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
---
 builtin/fetch.c  | 20 ++++++++++----------
 builtin/remote.c |  4 ++--
 refs.c           |  4 +++-
 3 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 40a0e8d24434..65d606c6de08 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1383,9 +1383,13 @@ static int prune_refs(struct display_state *display_state,
 	int result = 0;
 	struct ref *ref, *stale_refs = get_stale_heads(rs, ref_map);
 	struct strbuf err = STRBUF_INIT;
+	struct string_list refnames = STRING_LIST_INIT_NODUP;
 	const char *dangling_msg = dry_run
-		? _("   (%s will become dangling)")
-		: _("   (%s has become dangling)");
+		? _("   %s will become dangling after %s is deleted")
+		: _("   %s has become dangling after %s was deleted");
+
+	for (ref = stale_refs; ref; ref = ref->next)
+		string_list_append(&refnames, ref->name);
 
 	if (!dry_run) {
 		if (transaction) {
@@ -1396,15 +1400,9 @@ static int prune_refs(struct display_state *display_state,
 					goto cleanup;
 			}
 		} else {
-			struct string_list refnames = STRING_LIST_INIT_NODUP;
-
-			for (ref = stale_refs; ref; ref = ref->next)
-				string_list_append(&refnames, ref->name);
-
 			result = refs_delete_refs(get_main_ref_store(the_repository),
 						  "fetch: prune", &refnames,
 						  0);
-			string_list_clear(&refnames, 0);
 		}
 	}
 
@@ -1416,12 +1414,14 @@ static int prune_refs(struct display_state *display_state,
 					   _("(none)"), ref->name,
 					   &ref->new_oid, &ref->old_oid,
 					   summary_width);
-			refs_warn_dangling_symref(get_main_ref_store(the_repository),
-						  stderr, dangling_msg, ref->name);
 		}
+		string_list_sort(&refnames);
+		refs_warn_dangling_symrefs(get_main_ref_store(the_repository),
+					   stderr, dangling_msg, &refnames);
 	}
 
 cleanup:
+	string_list_clear(&refnames, 0);
 	strbuf_release(&err);
 	free_refs(stale_refs);
 	return result;
diff --git a/builtin/remote.c b/builtin/remote.c
index 0d6755bcb71e..4de7dd373ae5 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1522,8 +1522,8 @@ static int prune_remote(const char *remote, int dry_run)
 	struct string_list refs_to_prune = STRING_LIST_INIT_NODUP;
 	struct string_list_item *item;
 	const char *dangling_msg = dry_run
-		? _(" %s will become dangling!")
-		: _(" %s has become dangling!");
+		? _(" %s will become dangling after %s is deleted!")
+		: _(" %s has become dangling after %s was deleted!");
 
 	get_remote_ref_states(remote, &states, GET_REF_STATES);
 
diff --git a/refs.c b/refs.c
index dce5c49ca2ba..e2075a98c844 100644
--- a/refs.c
+++ b/refs.c
@@ -461,7 +461,9 @@ static int warn_if_dangling_symref(const char *refname, const char *referent UNU
 		return 0;
 	}
 
-	fprintf(d->fp, d->msg_fmt, refname);
+	skip_prefix(refname, "refs/remotes/", &refname);
+	skip_prefix(resolves_to, "refs/remotes/", &resolves_to);
+	fprintf(d->fp, d->msg_fmt, refname, resolves_to);
 	fputc('\n', d->fp);
 	return 0;
 }
-- 
2.50.0.84.g5d85fe910b.dirty


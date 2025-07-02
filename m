Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7680372637
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 01:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751418812; cv=none; b=WQwpEtblbXJZNu94+icRmuyXeKFzQj0JAHO+3cfTovUeosjcZuzdMQV1i7yEmJD4yzEp7uAE3gHv7lWK4Vwg6+Hwxb2LNGmKtwqbE7UtPIoMgc7J/TJTHhfFjOZbIbuuwrcOCOsFYzNMC3IJGqeaMAQIOPUcQsiD4S7hvwcg0UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751418812; c=relaxed/simple;
	bh=jMSo5IihxO/ChuoO9L3TgksSD6VFVQnx82gL1Q8q+gw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FaqNQljfYVsJGijnf8v94ih1qH5WjAIel8p4zPo/GF8xVXdmy+LaG+KyDWODUQGmN3CY4UWFQglNz/NmvqafxbHuvtZyLu8RZFD1efX8SuoA7KbfkJRsfmuCN45Re2c8pAMSXueT7FmPDHs16XJ+H6oVgeGRRWjxlStbi2jyrkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PYUrxHRp; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYUrxHRp"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-23508d30142so48058995ad.0
        for <git@vger.kernel.org>; Tue, 01 Jul 2025 18:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751418810; x=1752023610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BCdcko9Zl16dssbQejub8rsftgxkRFM01gIwOFqJB38=;
        b=PYUrxHRpzNIvzPbOE3JSfw4qBSrXkjDM37a/QUzKc9vdyK96OzaCC68TkiA/61PFcv
         p8fE3UQHIz4r3Fie9xvOR3BNTs21oKaRsXcgmGQQsS3ciCPxrnU5kDPExbbq7mg0VtHl
         UU3qVmoc9U/nEK0rJNmn4dWQxAEPfexXbs7fE7BOAQmoiA5H6HETDBr3dIsMylMP/9Nl
         Bo1NCVZEWweKpmhZ0KkvyGP7YpS4in+nIxgYxOMVHsV+IQYehlOSUKhHL9zT05Em6Lv5
         swNG2sr5ZLiy50LgyK+/gvFL9/sXzLfoemhUhCBLUsv+y5Zq2k/RzeOk4hjn7fY6TSLO
         qVVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751418810; x=1752023610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BCdcko9Zl16dssbQejub8rsftgxkRFM01gIwOFqJB38=;
        b=BxhLgOFlrRHgiyo7AZZsuESRGFoopmPzcrx/vLiMWfaPQhH3Ehf5z+T4Z13SoWmTW7
         Prw3hQoFCUusttYN4l7P+a43NvRkOQpr2oyxkmk9Xqx6hNmtnezafNzGl7yYH0kYd4vK
         wRQ8us4h0ycJtt9WyMCjGCi4J9x9VKFnSmXsFLXDPfB3CtzCTd5dzmg77CxG/KMRF+oP
         w3jxJc+IU3GDq+lLlsgW2P+obAdl/ehaQq++fICHMZ+nZfjHnzrNL8KXnnqThNAQhafQ
         B34uYljTkM0zZumf9+Z8mrOiDrryPKKBUNF/T3xztpFWvgKTvNu4uL/1CmA37azDztUW
         FNPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdkek0hp1ul94SBjdncZhEPtBKZgbC8nZ1/MR8xpDToyoOkP3xJJDUwKbGDzKP2ecMk9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSpPoczaI+R9CezWiSqO0ejmyeK5GPJPhbRXPgQn+z4N6QMYVR
	NbnK/paeSzrR62Gy2L7JRdgxeLiovbh6LY1Ift0pH6Si7lwr7OYGyqAVgL4zVw==
X-Gm-Gg: ASbGncvM6jS1ADCmot0sQBR2TnFPaPj+1pqynL9fUF+Iy4zuVWvt/h4wMa1KK/8xM+F
	JGgLJx5EVP1zpV9JcVefpw8OHozDePDu+N2vNSEX1Ryt9Ibw6fOBmzoENXLwXUeEmglszJ1B/Yu
	IOVstwA9XULdkUjvA5QRQNrFTYCD8FSKnAEIbnHG8dyBlRodJolUNj99wT98KlwaFgj5v6hc18Q
	IICi4io9nlFVgXpFRRYWbsIVG6VvRCsboCHTLo6lCBaPwIU6bh6MJdDqf5rrq4GVtjfJcukak2f
	162uFb1PTKSnCVjM+meDZ2X5T9WF8zluDhF2m+5xfEwCJUZJR/di7T0Csqc=
X-Google-Smtp-Source: AGHT+IFvqW142D374yCbHcEufiI1a1Z4tuLM/jPqUnIijsM/lytyJPXzTj5tSxm1iB60c2/knh1eBg==
X-Received: by 2002:a17:902:e886:b0:234:a139:120b with SMTP id d9443c01a7336-23c6e48cd9fmr11618805ad.11.1751418809782;
        Tue, 01 Jul 2025 18:13:29 -0700 (PDT)
Received: from dev-phord.dev.purestorage.com ([208.88.159.129])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3af74fsm123208125ad.148.2025.07.01.18.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 18:13:29 -0700 (PDT)
From: Phil Hord <phil.hord@gmail.com>
X-Google-Original-From: Phil Hord
To: gitster@pobox.com
Cc: peff@peff.net,
	git@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Phil Hord <phil.hord@gmail.com>
Subject: [PATCH v4 1/3] fetch-prune: optimize dangling-ref reporting
Date: Tue,  1 Jul 2025 18:12:13 -0700
Message-ID: <20250702011214.2835529-3-phil.hord@gmail.com>
X-Mailer: git-send-email 2.50.0.149.g1bab277d62
In-Reply-To: <20250702011214.2835529-2-phil.hord@gmail.com>
References: <20250702011214.2835529-2-phil.hord@gmail.com>
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
version already available in refs_warn_dangling_symrefs. Change the
message to include the original refname since the message is no longer
printed immediately after the line that did just print the refname.

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
 refs.c           |  2 +-
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index d48262bdc717..04d10c9e781a 100644
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
index dce5c49ca2ba..651fb2d41299 100644
--- a/refs.c
+++ b/refs.c
@@ -461,7 +461,7 @@ static int warn_if_dangling_symref(const char *refname, const char *referent UNU
 		return 0;
 	}
 
-	fprintf(d->fp, d->msg_fmt, refname);
+	fprintf(d->fp, d->msg_fmt, refname, resolves_to);
 	fputc('\n', d->fp);
 	return 0;
 }
-- 
2.50.0.149.g1bab277d62


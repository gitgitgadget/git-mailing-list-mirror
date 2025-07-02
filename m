Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680251519A6
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 01:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751418815; cv=none; b=ko+A6zHtzQOCEmS0o22/1ERDlBKPr43AqHqb19G0J2Mub6AfShFhebjg2hlQzgek7fkeJjWdVKPRoQyHT60oL219TtIJ1UJ51zpeFeReq/5Qn9sWmhFRa3557Y1SrTnvmscmYJwefl/PxJdEwzZOrMI+K/ov6jP8S2qgISMIWHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751418815; c=relaxed/simple;
	bh=CQGvVbGdJKFt/OsnQmtCP/UbDe80dlqx5Ag5ZR/R13U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PO+aQ00rUwQsRgwzVdL31aCKoq40c9tNUdVOeoMl/Or0SmGru0CeImaj7TioUqvKS7+o1E/3t2wo49xUBTSXm6JFav14JrQdH/lBMBbfC12ag4ovZm0jr6qVAbL4E8rUo5n4aYY0X2ohKrxFJBKqY2RhiQD8n3B6rJNNOyyh+ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K675IIaP; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K675IIaP"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-235ef62066eso78655945ad.3
        for <git@vger.kernel.org>; Tue, 01 Jul 2025 18:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751418814; x=1752023614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uuLY+89KRhlcNl4kC4hua+WSk4lTB7AaVC2Iq3sUZNA=;
        b=K675IIaPHuPOMJL+nOueA9WlVhbnFJWZvYYxos3MXdIbKPiNZBka37pkg10RURoBNz
         KcaQyghouR4F74xOaw+NAppNpYHvSkbjrsPFPd8Tqw3kN1BGoRGVxWDholaR0l9XjOtX
         d7OePoAl3+mJ4Je9lqW0pnP4KAyNIZF3BeT/cTzSzFsL0SD/AUYZdLGW5SWhVFTFfoD1
         RhaIu+baJxKf+1lBwp0yWBu075sEpfkCUFwmWnqVcgAbBZn0aGAHMFrlhKmU7ZGxZhr+
         Wbq+bSp2/bwR+zeBcS9ar4AT9Jnq8y278c8+fUeIrDbL9FtZFWRXBSdp1NxkdUxJAL+2
         37SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751418814; x=1752023614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uuLY+89KRhlcNl4kC4hua+WSk4lTB7AaVC2Iq3sUZNA=;
        b=M3mY8wBA3+T+uJKFphiGIK9Ls4/b5Qx3E7BmT4asR+wUvL8QKYLoHiJxFLg9YH9FgR
         4W2ELdsaQxw6/i69KpvXqlEL3Mgod9+J87hHndhyhvPJ1c4PJwmXV8AdlCyzUocfov+w
         xoHkvnVhSGHzol2L6hQkddAJR+kG+R7ntzRNhwKvZg3dwjLbPVL6iFlWPC6UaZDw3XlT
         YU4/MdPqAm1eiCqg2bkrl8fqG+6QQbsTGXDQWAR7SxCGo8RjdMClm1bfNR8xUz8RgVre
         J2RGACE24X/gUiCWGb4tPhnSayeWRwikfcQHf6fkpZrezJjZ2yAPeBwcLC+lcY7aVw3g
         TBAA==
X-Forwarded-Encrypted: i=1; AJvYcCUD12tbSebw13JVmxMK9DRdNsESkUaFWM6evLya0xzGvgnuaynZ4OOkPPFzhu4rNshVovc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR64XNf1BJ82OJbe/owT7ENzNTkoMM4ioXJNUVTeMyz1EbNzJk
	4lbBo5/qqlNvXP0Z3awaDNSQR/LitGu6a55XcEg5Vv66t0zlC4yPZKmx
X-Gm-Gg: ASbGncsvAZ3mF2sli8ziF2DV25SMALtyCdsv0GY0VL32/ffUyz1oP1esdYJibG5Mau2
	nw58gVyTM3Ff0T73qtag3rvL5HyuLQDYgZ5KnV3o1TkFFOa0nnfKoXBlDIJDHADiUkRo7BDTB0O
	UKk07/+64apWKt48I2jlfLuUXz/gDAtvx84r7oqaIvhg3x9VAqs+wLR90BoGBO7pqco7jOVwgvu
	DbXbYVAskkJXyql2vpKuKgSCEdrBzjSR+u+ug/gQHt+kVR8FdMEoAZ0kv7MGgGzSPOPX9PainmM
	FRHWetQF9eSdDqLa0IvcAAxB5jGpDG+x5I7X9HxO42lEQ8NiUKimL1lgjUc=
X-Google-Smtp-Source: AGHT+IFB5p/pi1nj6hQW6qkKzoPrw3ui3/W3Qf5NcbP3+ry4G/H8cMgcn85zDDUs0wX9VeH7Ke4L0A==
X-Received: by 2002:a17:903:19e7:b0:234:d292:be7a with SMTP id d9443c01a7336-23c6e4e4c8fmr11636785ad.1.1751418813601;
        Tue, 01 Jul 2025 18:13:33 -0700 (PDT)
Received: from dev-phord.dev.purestorage.com ([208.88.159.129])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3af74fsm123208125ad.148.2025.07.01.18.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 18:13:33 -0700 (PDT)
From: Phil Hord <phil.hord@gmail.com>
X-Google-Original-From: Phil Hord
To: gitster@pobox.com
Cc: peff@peff.net,
	git@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Phil Hord <phil.hord@gmail.com>
Subject: [PATCH v4 3/3] clean up interface for refs_warn_dangling_symrefs
Date: Tue,  1 Jul 2025 18:12:15 -0700
Message-ID: <20250702011214.2835529-5-phil.hord@gmail.com>
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

The refs_warn_dangling_symrefs interface is a bit fragile as it passes
in printf-formatting strings with expectations about the number of
arguments. This patch series made it worse by adding a 2nd positional
argument. But there are only two call sites, and they both use almost
identical display options.

Make this safer by moving the format strings into the function that uses
them to make it easier to see when the arguments don't match. Pass a
prefix string and a dry_run flag so the decision logic can be handled
where needed.

Signed-off-by: Phil Hord <phil.hord@gmail.com>
---
 builtin/fetch.c  |  5 +----
 builtin/remote.c |  5 +----
 refs.c           | 17 +++++++++++------
 refs.h           |  3 ++-
 4 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 04d10c9e781a..fc72f2119c56 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1384,9 +1384,6 @@ static int prune_refs(struct display_state *display_state,
 	struct ref *ref, *stale_refs = get_stale_heads(rs, ref_map);
 	struct strbuf err = STRBUF_INIT;
 	struct string_list refnames = STRING_LIST_INIT_NODUP;
-	const char *dangling_msg = dry_run
-		? _("   %s will become dangling after %s is deleted")
-		: _("   %s has become dangling after %s was deleted");
 
 	for (ref = stale_refs; ref; ref = ref->next)
 		string_list_append(&refnames, ref->name);
@@ -1417,7 +1414,7 @@ static int prune_refs(struct display_state *display_state,
 		}
 		string_list_sort(&refnames);
 		refs_warn_dangling_symrefs(get_main_ref_store(the_repository),
-					   stderr, dangling_msg, &refnames);
+					   stderr, "   ", dry_run, &refnames);
 	}
 
 cleanup:
diff --git a/builtin/remote.c b/builtin/remote.c
index 4de7dd373ae5..f672799e0d92 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1521,9 +1521,6 @@ static int prune_remote(const char *remote, int dry_run)
 	struct ref_states states = REF_STATES_INIT;
 	struct string_list refs_to_prune = STRING_LIST_INIT_NODUP;
 	struct string_list_item *item;
-	const char *dangling_msg = dry_run
-		? _(" %s will become dangling after %s is deleted!")
-		: _(" %s has become dangling after %s was deleted!");
 
 	get_remote_ref_states(remote, &states, GET_REF_STATES);
 
@@ -1555,7 +1552,7 @@ static int prune_remote(const char *remote, int dry_run)
 	}
 
 	refs_warn_dangling_symrefs(get_main_ref_store(the_repository),
-				   stdout, dangling_msg, &refs_to_prune);
+				   stdout, " ", dry_run, &refs_to_prune);
 
 	string_list_clear(&refs_to_prune, 0);
 	free_remote_ref_states(&states);
diff --git a/refs.c b/refs.c
index 07197c239e33..5602c18dbd5b 100644
--- a/refs.c
+++ b/refs.c
@@ -439,7 +439,8 @@ struct warn_if_dangling_data {
 	struct ref_store *refs;
 	FILE *fp;
 	const struct string_list *refnames;
-	const char *msg_fmt;
+	const char *indent;
+	int dry_run;
 };
 
 static int warn_if_dangling_symref(const char *refname, const char *referent UNUSED,
@@ -447,7 +448,7 @@ static int warn_if_dangling_symref(const char *refname, const char *referent UNU
 				   int flags, void *cb_data)
 {
 	struct warn_if_dangling_data *d = cb_data;
-	const char *resolves_to;
+	const char *resolves_to, *msg;
 
 	if (!(flags & REF_ISSYMREF))
 		return 0;
@@ -458,19 +459,23 @@ static int warn_if_dangling_symref(const char *refname, const char *referent UNU
 		return 0;
 	}
 
-	fprintf(d->fp, d->msg_fmt, refname, resolves_to);
-	fputc('\n', d->fp);
+	msg = d->dry_run
+		? _("%s%s will become dangling after %s is deleted\n")
+		: _("%s%s has become dangling after %s was deleted\n");
+	fprintf(d->fp, msg, d->indent, refname, resolves_to);
 	return 0;
 }
 
 void refs_warn_dangling_symrefs(struct ref_store *refs, FILE *fp,
-				const char *msg_fmt, const struct string_list *refnames)
+				const char *indent, int dry_run,
+				const struct string_list *refnames)
 {
 	struct warn_if_dangling_data data = {
 		.refs = refs,
 		.fp = fp,
 		.refnames = refnames,
-		.msg_fmt = msg_fmt,
+		.indent = indent,
+		.dry_run = dry_run,
 	};
 	refs_for_each_rawref(refs, warn_if_dangling_symref, &data);
 }
diff --git a/refs.h b/refs.h
index 07f21824d480..25bed4d792e7 100644
--- a/refs.h
+++ b/refs.h
@@ -453,7 +453,8 @@ static inline const char *has_glob_specials(const char *pattern)
 }
 
 void refs_warn_dangling_symrefs(struct ref_store *refs, FILE *fp,
-				const char *msg_fmt, const struct string_list *refnames);
+				const char *indent, int dry_run,
+				const struct string_list *refnames);
 
 /*
  * Flags for controlling behaviour of pack_refs()
-- 
2.50.0.149.g1bab277d62


Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294D9470422
	for <git@vger.kernel.org>; Wed, 19 Aug 2026 12:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787141885; cv=none; b=dmkwKyd/SIJG9iLqo7IzADPVMNqIn13SwEFcnX6l6wQwreamRR378GAULGQ4xlUxJwrA2OiuJIknx7e91gYNWCNs+Xka+M+P21JcJfD7LOhMXqyj/GIetkAy6dtOBrVPWquTKRL/7FjSPzhUhc6f8G0ML6sBrt6YP7u7E5f1yCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787141885; c=relaxed/simple;
	bh=iIiJrmlDs9hY8mPD4HCOy3X8yHQsI8bYTWeAC1Atoqc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HtLdCnfsbe9VU9SM3F5oxf9w2R8doGiKvNqb+ZYmVAmJFtllD7I+UzVrcUJHSfd7b6GdF6z26s/Rc2K3Ai52zChLcRoQJWIvs2iRsPOaSPbxXhEaFJBHaXZZrzpXkdUTNHBKNs5cW6mRdFQB18cFddqJoXqol8mexon/rDsHJoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=V+ghHr2R; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Os6x+oAD; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="V+ghHr2R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Os6x+oAD"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 2E18AEC00E5;
	Wed, 19 Aug 2026 08:18:03 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 19 Aug 2026 08:18:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787141883;
	 x=1787228283; bh=IIM8tlVD5E8RXlgG+GAuzt3ibFCCFVbceafcQ8yAZGM=; b=
	V+ghHr2Ru+S6sdMEkgiOuTa73QJ7SaktXI/R7X1ljJxBmM3aWsTCbHmRsChgbybE
	D/JJ6uRxWlFFmVCFwh7RyrHjaGTQ8vvh4/L5Md1Pe+aEa2rF6ugzFiy8ZG3+6qGd
	t+GQpRMA10eB22yV7BluHSMgw/TFAGI7arK9ysPrh3RQp6m9624J1NOpzsfM4Koc
	EWHv6RVGf0BlMivbG+f5ZzLpdjAWvXCsyqVj36b9FCy5hOTQkP6GQPwQLinxgio7
	08g9Ob7w9gPrbGi+mkgVr0zt8c3uAwa6qAttHoRrIM+KAtyVg1G0z5cp0YzCqypz
	nXJuz2mKec7IjY/d7s4C3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787141883; x=
	1787228283; bh=IIM8tlVD5E8RXlgG+GAuzt3ibFCCFVbceafcQ8yAZGM=; b=O
	s6x+oADYzSnGlQ3pCBGJQqUDOT0apd0XVaINoGkKY1tdKgdItZz+qwyqIkQvNpOo
	Ly7pgXCSxZAU/arwIGB8mYzIlDl37kFYM98YAwioOikqy4hTlm/FW9wAF8w75pLS
	81jeAL1jVAZoXVSpc6n+bv0uQ9ni8XL5fZP7B5msFrTzi2bI0MR76RlrOMYr1sf4
	EVEOot50Z0EM+tgmtpGHHsraCR90+2Ckw78jbjWrz0lIMiTITrsChJr6g515LElR
	sLx5LDvIVYyazynqweZAB6jf5kfECNVqH2unC2XXgOV+NYZSmJYzPMYlRWrux6Om
	FnTeWOIRW3hYim3/bJTHA==
X-ME-Sender: <xms:-56FatDLNCKdVUE0OD6SadB0zmMrY-CcgEVSIzMqdYqzUkchA0yRsw>
    <xme:-56FarudoHdQeKTzhH9SNMJrB-mWIu-lLGNOD-jH2etwFJ1-2fRkHYKuIPKJ8FAYi
    -7b4H46Ot0uJoV1two6Xm3WyP5QiyoDKutboXR2cJQWPo3rCi-pHQ>
X-ME-Received: <xmr:-56FaqZzV_f2qEIsWi4mQ5Tf32r32QFa5zxxnVdVy5cZGNTL9wt0PlJJniGGi1HYZkfJQdu4irxHOvj0_UPDHB5qPZ70mUgRO0EL3VQH>
X-ME-Proxy-Cause: dmFkZTF5mvSyHAwZNZEJLvdRLYwrNd6nj3F/OPlsiVb/McU7FBZtMInkPMxcRjhwRSPFHL
    WUm0rG0cjgDwa2Gh6qh1SLgIou2chAX5ZgP/1gXUR1vcTnXZvTU9haB+ZjXfR8PqHoV0mT
    yFCQgjenzzujCx6/VUrwAF3/Qro1c+XMYk7AFBZaoY+ewAjIUq/HO0s5BtCKKXPFns/It8
    9sbenjmEVzlOv2FYEUi3TWaQBHwTcUixH6KM2lD6Gst0FYYVriPig0bbHUyLXvDoARD92l
    wnFFv5vVxy1k7xYdbg/KUyIUF72UNvwF6UgqIcOBqHw9pklODFjYS4gk3zOO4KzbW4WhfS
    4WqSDegdVPTq6eVaTMvXt0muYd6LYBU9yUBGbtESSYYIWWcKnB8J2544oOG3iknYnJyZ0e
    50Havi4HX9XvJdm06n0iLKFJv2CaOb1HtA208ZoLO3IPUqBVF2wMH3j1qwK2cSdtwdToa5
    O776YYiH0upk0Z5PAs9h8X/B9gKIy36k9BesS1r4BU0hJNBnpIr/xKWrXKdiqRHoIKKQ0W
    94A2ngUtT1KTr4GJ7Uvr9ImXluzzO9GzvQbTJOGRmtwk74bKTg4x7EFw9uMT9IkJFGQSmb
    Ik887pbIPs1kQI6wSN2VhoiXqLz9TB5M9ZJzlCcTqxuSpz6LKpGucrwFGTog
X-ME-Proxy: <xmx:-56FamXf8VxWKw3NMtTVHIM_qsvI4i4bZX3TJYsX2z29iIHP2htT4Q>
    <xmx:-56Fam7HZAay1BaRfmV0NI7JTuyzIbWlsBuKY7zduEvxs9Z1r_M0gg>
    <xmx:-56FaphwEl0p0NVALNbFR6XQNU92yI0aqt1byrDQO1jJpagJbgOHtQ>
    <xmx:-56Fald49H-arlv2lC8ua-6SF5RLV15frrBRTcWB3Xd147De4czhDw>
    <xmx:-56FannvxzlNUmbMzKw8QeRpor7PCyUTdEHCIVCe7WPkSAdgoK4boFUZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Aug 2026 08:18:02 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 57cedeaa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 19 Aug 2026 12:18:01 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 19 Aug 2026 14:17:23 +0200
Subject: [PATCH v2 5/5] odb: handle `OBJECT_INFO_DIE_IF_CORRUPT`
 generically
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-pks-odb-generic-corrupt-objects-v2-5-a984e3a0ad6f@pks.im>
References: <20260819-pks-odb-generic-corrupt-objects-v2-0-a984e3a0ad6f@pks.im>
In-Reply-To: <20260819-pks-odb-generic-corrupt-objects-v2-0-a984e3a0ad6f@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

When a lookup with `OBJECT_INFO_DIE_IF_CORRUPT` fails we want to die in
case the object exists, but cannot be read. This flag is handled in two
different spots right now:

  - `do_oid_object_info_extended()` calls `has_packed_and_bad()` to
    check whether the object is known to be corrupt in any packfile.
    This function reaches into the internals of the packed source and
    thus breaks the abstraction provided by our object sources.

  - The loose source handles the flag itself and dies directly in
    `read_object_info_from_path()`, which means that we die even in
    cases where another source may still have a good copy of the
    object.

Besides being inconsistent, it also ties us to the specific backend used
by the database sources because `has_packed_and_bad()` assumes that they
use the "files" backend. Any other backend will instead cause us to die
when calling `odb_source_files_downcast()`, even if the object was
simply nonexistent.

In the preceding commits we've carved out the infrastructure to make
this mechanism fully generic. On the one hand, all backends now tell us
whether the object is missing or corrupt via their return values. And
on the other hand, they have been taught to provide a readable error
message to the caller.

Adapt `do_oid_object_info_extended()` to use those new mechanisms. This
means that we won't die immediately anymore when a loose object is
corrupt, and we properly handle backends other than the "files" backend.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c                        | 46 ++++++++++++++++++++++++++++++--------------
 odb/source-loose.c           | 10 ++--------
 packfile.c                   | 17 ----------------
 packfile.h                   |  1 -
 t/t1060-object-corruption.sh | 18 +++++++++++++++++
 5 files changed, 52 insertions(+), 40 deletions(-)

diff --git a/odb.c b/odb.c
index 83a53f7f6b..6bbea64033 100644
--- a/odb.c
+++ b/odb.c
@@ -15,7 +15,6 @@
 #include "object-name.h"
 #include "odb.h"
 #include "odb/source-inmemory.h"
-#include "packfile.h"
 #include "path.h"
 #include "promisor-remote.h"
 #include "quote.h"
@@ -551,8 +550,11 @@ static enum odb_read_status do_oid_object_info_extended(struct object_database *
 							const struct object_id *oid,
 							struct object_info *oi, unsigned flags)
 {
+	struct strbuf corrupt_err = STRBUF_INIT;
 	const struct object_id *real = oid;
+	enum odb_read_status ret;
 	int already_retried = 0;
+	bool corrupt = false;
 
 	if (flags & OBJECT_INFO_LOOKUP_REPLACE)
 		real = lookup_replace_object(odb->repo, oid);
@@ -568,9 +570,14 @@ static enum odb_read_status do_oid_object_info_extended(struct object_database *
 	while (1) {
 		struct odb_source *source;
 
-		for (source = odb->sources; source; source = source->next)
-			if (!odb_source_read_object_info(source, real, oi, flags, NULL))
-				return 0;
+		for (source = odb->sources; source; source = source->next) {
+			ret = odb_source_read_object_info(source, real, oi, flags,
+							  corrupt_err.len ? NULL : &corrupt_err);
+			if (!ret)
+				goto out;
+			if (ret != ODB_READ_NOT_FOUND)
+				corrupt = true;
+		}
 
 		/*
 		 * When the object hasn't been found we try a second read and
@@ -578,11 +585,15 @@ static enum odb_read_status do_oid_object_info_extended(struct object_database *
 		 * caches or reload on-disk state.
 		 */
 		if (!(flags & OBJECT_INFO_QUICK)) {
-			for (source = odb->sources; source; source = source->next)
-				if (!odb_source_read_object_info(source, real, oi,
-								 flags | OBJECT_INFO_SECOND_READ,
-								 NULL))
-					return 0;
+			for (source = odb->sources; source; source = source->next) {
+				ret = odb_source_read_object_info(source, real, oi,
+								  flags | OBJECT_INFO_SECOND_READ,
+								  corrupt_err.len ? NULL : &corrupt_err);
+				if (!ret)
+					goto out;
+				if (ret != ODB_READ_NOT_FOUND)
+					corrupt = true;
+			}
 		}
 
 		/*
@@ -605,16 +616,23 @@ static enum odb_read_status do_oid_object_info_extended(struct object_database *
 		}
 
 		if (flags & OBJECT_INFO_DIE_IF_CORRUPT) {
-			const struct packed_git *p;
 			if ((flags & OBJECT_INFO_LOOKUP_REPLACE) && !oideq(real, oid))
 				die(_("replacement %s not found for %s"),
 				    oid_to_hex(real), oid_to_hex(oid));
-			if ((p = has_packed_and_bad(odb->repo, real)))
-				die(_("packed object %s (stored in %s) is corrupt"),
-				    oid_to_hex(real), p->pack_name);
+			if (corrupt) {
+				if (corrupt_err.len)
+					die("%s", corrupt_err.buf);
+				die(_("object %s is corrupt"), oid_to_hex(real));
+			}
 		}
-		return -1;
+
+		ret = corrupt ? ODB_READ_ERROR : ODB_READ_NOT_FOUND;
+		goto out;
 	}
+
+out:
+	strbuf_release(&corrupt_err);
+	return ret;
 }
 
 static int oid_object_info_convert(struct repository *r,
diff --git a/odb/source-loose.c b/odb/source-loose.c
index b57ee2701a..540b2dd40d 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -192,15 +192,9 @@ static int read_object_info_from_path(struct odb_source_loose *loose,
 	ret = 0;
 
 out:
-	if (ret && ret != ODB_READ_NOT_FOUND) {
-		if ((flags & OBJECT_INFO_DIE_IF_CORRUPT))
-			die(_("loose object %s (stored in %s) is corrupt"),
+	if (ret && ret != ODB_READ_NOT_FOUND && errmsg)
+		strbuf_addf(errmsg, _("loose object %s (stored in %s) is corrupt"),
 			    oid_to_hex(oid), path);
-		if (errmsg)
-			strbuf_addf(errmsg, _("loose object %s (stored in %s) is corrupt"),
-				    oid_to_hex(oid), path);
-	}
-
 	if (stream_to_end)
 		git_inflate_end(stream_to_end);
 	if (map)
diff --git a/packfile.c b/packfile.c
index 3cde39a01c..cd38be088d 100644
--- a/packfile.c
+++ b/packfile.c
@@ -985,23 +985,6 @@ void mark_bad_packed_object(struct packed_git *p, const struct object_id *oid)
 	oidset_insert(&p->bad_objects, oid);
 }
 
-const struct packed_git *has_packed_and_bad(struct repository *r,
-					    const struct object_id *oid)
-{
-	struct odb_source *source;
-
-	for (source = r->objects->sources; source; source = source->next) {
-		struct odb_source_files *files = odb_source_files_downcast(source);
-		struct packfile_list_entry *e;
-
-		for (e = files->packed->packs.head; e; e = e->next)
-			if (oidset_contains(&e->pack->bad_objects, oid))
-				return e->pack;
-	}
-
-	return NULL;
-}
-
 off_t get_delta_base(struct packed_git *p,
 		     struct pack_window **w_curs,
 		     off_t *curpos,
diff --git a/packfile.h b/packfile.h
index 3229a6ed47..573fe003d0 100644
--- a/packfile.h
+++ b/packfile.h
@@ -329,7 +329,6 @@ int packed_object_info_with_index_pos(struct odb_source_packed *source,
 				      uint32_t *maybe_index_pos, struct object_info *oi);
 
 void mark_bad_packed_object(struct packed_git *, const struct object_id *);
-const struct packed_git *has_packed_and_bad(struct repository *, const struct object_id *);
 
 int has_object_pack(struct repository *r, const struct object_id *oid);
 int has_object_kept_pack(struct repository *r, const struct object_id *oid,
diff --git a/t/t1060-object-corruption.sh b/t/t1060-object-corruption.sh
index 502a5ea1c5..d2ef468b45 100755
--- a/t/t1060-object-corruption.sh
+++ b/t/t1060-object-corruption.sh
@@ -145,4 +145,22 @@ test_expect_success 'partial clone of corrupted repository' '
 	test_must_fail git -C corrupt-partial checkout --force
 '
 
+test_expect_success 'corrupted loose commit can be read from alternate' '
+	git init repo-a &&
+	tree=$(git -C repo-a write-tree) &&
+	commit=$(git -C repo-a commit-tree $tree </dev/null) &&
+
+	cp -r repo-a repo-b &&
+	(
+		cd repo-b &&
+		echo ../../../repo-a/.git/objects >.git/objects/info/alternates &&
+		corrupt_byte "$commit" 1
+	) &&
+
+	git -C repo-a cat-file -p "$commit" >expect &&
+	git -C repo-b cat-file -p "$commit" >actual 2>err &&
+	test_cmp expect actual &&
+	test_grep "inflate: data stream error" err
+'
+
 test_done

-- 
2.55.0.822.g20453c30eb.dirty


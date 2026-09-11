Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAE1485CC1
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 13:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789133258; cv=none; b=LtVUt1BOXVKKjrfRRl++qLJaPPd69WhWczizstmE9pwkszmYalRAT9RcMut0vmQRW9swX3a6nPLr3W5KLIGILKG8Vvfj7R7XMs3qObEOiT7No1LaHs/bBWExiIftDUiHbjeF7dIwBOYceEMWzKgcwGh/5IDVxsRGJvJlYuJQ0hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789133258; c=relaxed/simple;
	bh=XH5921Dv71LRIL4yZ8wYScSE+k3kkDa5vgSMx2u7U7E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FmFibCagi1l/9kmnBfgBDkcwUhHt6XBOUyPjsnwOCM8c3qV5r2JBKRb9ffT0XeOluVJhq831VVZ+tlClSnGeomkLMN2vZ0qyVZetr38TwMOYs3SrvMfJy1yMe+JUP5W0A7x1YOYNYR/IOCIfOM68N5hmdYHnijV3pyrINTmDoLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IvHizzjI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nIQhP1HZ; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IvHizzjI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nIQhP1HZ"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9AE6114001CC;
	Fri, 11 Sep 2026 09:27:35 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 11 Sep 2026 09:27:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1789133255;
	 x=1789219655; bh=ByPqWRZmTD7fzLtnlqQ9J8I1ZqmEDBVwBaLgYuncQH4=; b=
	IvHizzjIDITnlTJS8OY7ivZorRODORdChBc6kks4pp0l52FkhL4b7UjF9oa1YHND
	HQemYn/7xsXwP+GrQSC3LD/8DIGWbEbsZdLQUxlPux7XIWLiKvEJSx70yBE1/qJ8
	1CVSM+MCs2a3LwscOsEgUBUOrsiUVIyOkPymNMfewjq31M3Nkw4aVcgJsxICeBd5
	bcGivlN4N/LVoY2MPmaOzTp/V/w1jb1WbgTRIAJBxQf+QEB+EBVzLtI1/o6Ihech
	BASYNE/TqQ6enTh91baLLR5GVYK4xklX6+vtE0JP2iDyG2FkGGhFHcU777evIzgQ
	4tiNgyzhP6/3D5PPAWsYdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789133255; x=
	1789219655; bh=ByPqWRZmTD7fzLtnlqQ9J8I1ZqmEDBVwBaLgYuncQH4=; b=n
	IQhP1HZHtT+leKWg1jAR3rEul1u489ct/Ym65I0G7RCAZDDlLVhqQrDYxobDa/Hk
	hoPZ7T8vVUkzi5/MHu+o+0ec5Uy7svTSdZSzNTP0KN8nSC25NtTUCrJvj8BZik4u
	jo8QjQoi4mvrEjyN1dezuZQneP3y5blFQXiYWt6cEZpnF4fdToFTzhPX5gs0i79U
	+LdtPWO7zgUS0xTLfrSro6T53mF4u0hO8hDqK7giNV5pAiMDkblJdEJUad+VFNiH
	cWzxAOMQM5fTJAQOzXtGekTG5/fcb57WOip/FlIokPNe+EH0vdGYGIi3HMcb1Zfv
	li71YD1uIX2ojbDT4NtjA==
X-ME-Sender: <xms:xwGkam4UI8R98FQZ_Ynj1JP6kBjEQqOCKPs_X3MOYYgDzXFZYkJVHA>
    <xme:xwGkanV-hPJxbZEU_G1h7Sy0POC0YNApnvrxErfWzFV6GUjrjxxtSQZhrbtOFB3C_
    NdH2AqiFzV7K69Jll1wDR1WNIXaf0i3ayf_3RsiqKRop8W_9cqb>
X-ME-Received: <xmr:xwGkai3-YIrge_O-kvnzvABoaeLfEUMDm0jZEMwGNxuhZyTOlFqgnshD3JIedhWeNcahQQ>
X-ME-Proxy-Cause: dmFkZTFhKNTY4gaJzL8unHorI0O2mIjovbOSn/bb4FfWdQC69pOMNnSpJupj+k3b5RRAEh
    CKbErTW3WczRhRJwwrJkvaRsvQIzXEXE2C+BN/DKoL4Gbfz/Eo1tEu7eUCGtvI2UYkaIkN
    pdzF4Cl414GlPSVfplCLhQTY1vxDPnsAjpUCtDjPcnIgviIidiwFFMtURzMpzxs3Vu7cEM
    3nEkQWJ43K7d/I7qMYYZ6hxKZuNC1lSeitb76YKd6w//fOV1p7l3EElcNKMWcMdULICz/K
    NpH5skcEvh10Ou1QeaUv5hQYKlpJ4gF4a0EGGL8oCdZIc9NRujjRUNoZU+qfCLCaHmP9Ic
    T6UNrrDYmQXB61JgIBc51DOi3+HNsyAP7OOsXSh4zu0VsrfgvLacEdTDBPasshazarR5J9
    20nLSgcirsGyyp+obPISLcvxvG2h3+NXCS83sLOVuaL9aH1cSWAVJYxqufytTbTRXRERHd
    dXWe88fax0RLnKk0rNZT8glPjMdpD8n5wo0AAEeB2l0qc/IfAjzFDSS6vpWoPomWjz3iSV
    /u7F5yCPW7Lltm61bg+oai3tAvgk9kdUL+ny350e04mRY0tF5zUw/fnAl7gP2bvYnxwzjd
    ug7udkkfCX1wMyjSz+BauJl6VXFEbhWvQSuQIa+a3134X9REv4CKwWz2uxBg
X-ME-Proxy: <xmx:xwGkas0q709qSgNKKbeX2FR74jKV7W2YWNZJpU5UYnuWTkOB_Mb8pQ>
    <xmx:xwGkat_ipo5wacCbpUvwrzQdXYbcZ1mzu61RflX3bq5Iy7mJTdJ1Tw>
    <xmx:xwGkah10CD9hClOLvPWP2TJ0GHL7Ejjo1rWz-Oy_9WSjgGQmWeGF0g>
    <xmx:xwGkai-Ieg3t0vD3UylbBvP0PGgBBQ2k9mJck9F827mADGttAGLHqQ>
    <xmx:xwGkavXsPxbihQleWobVeQ6JhMF-ZP3q9s-EL2ZsMU9Y_oqlXlRWxCjp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Sep 2026 09:27:34 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c539cd1f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 11 Sep 2026 13:27:33 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 11 Sep 2026 15:27:26 +0200
Subject: [PATCH v3 02/10] builtin/fsck: merge `fsck_obj_buffer()` and
 `fsck_obj()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-pks-odb-source-fsck-v3-2-ef2fdc085e38@pks.im>
References: <20260911-pks-odb-source-fsck-v3-0-ef2fdc085e38@pks.im>
In-Reply-To: <20260911-pks-odb-source-fsck-v3-0-ef2fdc085e38@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.15.2

The interfaces of the functions `fsck_obj()` and `fsck_obj_buffer()` are
somewhat similar to one another. The only difference between those two
is that `fsck_obj()` takes an already-parsed object as input, whereas
`fsck_obj_buffer()` parses the buffer and then calls `fsck_obj()`.

Furthermore, `fsck_obj()` has no callers other than `fsck_obj_buffer()`.

Refactor the code by merging those two functions. This makes it obvious
which function does what, and it allows us to get rid of the early
return in `fsck_obj()` in case `SEEN` is set as the only caller
unconditionally clears that bit before calling it anyway.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fsck.c | 47 ++++++++++++++++++++---------------------------
 1 file changed, 20 insertions(+), 27 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 3c4127f4d8..bed8481893 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -401,14 +401,27 @@ static void check_connectivity(struct repository *repo)
 	}
 }
 
-static int fsck_obj(struct repository *repo,
-		    struct object *obj, void *buffer, unsigned long size)
+static int fsck_obj_buffer(const struct object_id *oid, enum object_type type,
+			   unsigned long size, void *buffer, int *eaten, void *cb_data)
 {
+	struct repository *repo = cb_data;
+	struct object *obj;
 	int err;
 
-	if (obj->flags & SEEN)
-		return 0;
-	obj->flags |= SEEN;
+	/*
+	 * Note, buffer may be NULL if type is OBJ_BLOB. See
+	 * verify_packfile(), data_valid variable for details.
+	 */
+	obj = parse_object_buffer(repo, oid, type, size, buffer, eaten);
+	if (!obj) {
+		errors_found |= ERROR_OBJECT;
+		err = error(_("%s: object corrupt or missing"),
+			    oid_to_hex(oid));
+		goto out;
+	}
+
+	obj->flags &= ~REACHABLE;
+	obj->flags |= HAS_OBJ | SEEN;
 
 	if (verbose)
 		fprintf_ln(stderr, _("Checking %s %s"),
@@ -417,6 +430,7 @@ static int fsck_obj(struct repository *repo,
 
 	if (fsck_walk(obj, NULL, &fsck_obj_options))
 		objerror(repo, obj, _("broken links"));
+
 	err = fsck_object(obj, buffer, size, &fsck_obj_options);
 	if (err)
 		goto out;
@@ -442,32 +456,11 @@ static int fsck_obj(struct repository *repo,
 	}
 
 out:
-	if (obj->type == OBJ_TREE)
+	if (obj && obj->type == OBJ_TREE)
 		free_tree_buffer((struct tree *)obj);
 	return err;
 }
 
-static int fsck_obj_buffer(const struct object_id *oid, enum object_type type,
-			   unsigned long size, void *buffer, int *eaten, void *cb_data)
-{
-	struct repository *repo = cb_data;
-	struct object *obj;
-
-	/*
-	 * Note, buffer may be NULL if type is OBJ_BLOB. See
-	 * verify_packfile(), data_valid variable for details.
-	 */
-	obj = parse_object_buffer(repo, oid, type, size, buffer, eaten);
-	if (!obj) {
-		errors_found |= ERROR_OBJECT;
-		return error(_("%s: object corrupt or missing"),
-			     oid_to_hex(oid));
-	}
-	obj->flags &= ~(REACHABLE | SEEN);
-	obj->flags |= HAS_OBJ;
-	return fsck_obj(repo, obj, buffer, size);
-}
-
 static int default_refs;
 
 static void fsck_handle_reflog_oid(struct repository *repo,

-- 
2.55.0.1074.ge7621b4bad.dirty


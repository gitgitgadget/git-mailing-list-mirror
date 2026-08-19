Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2237B472536
	for <git@vger.kernel.org>; Wed, 19 Aug 2026 12:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787141878; cv=none; b=RTQObAOaOVh5Mg/ZPTLrBmdtQQ3zFsnOLrSbeFeeXj7l+HX2k/vmtb0LX1eFLQ+DodGt0nStBiEJsfzi54xIs1OsY/eed//UzV4nDHsbm91KrtZ7Shd2V1tNUmDhi4J0BKgGsWz0+LPHwJK+t8TMVqe4cVljemuRYznfGWHd7QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787141878; c=relaxed/simple;
	bh=2G8iTizckgBoUc2x+vhCubPLrwtqHbwj8+orjuDWcd8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R4qMN/HsDfZo0txeRWbOkMkQeIfGY0eI1ZLXI1RtrJ7kpvmqTPJbBmQO8HlsScZoYu0bVMsiNkINzmi66j8hJqrj0QtlopeCu3w7Buc6MqD2eP7q67OVU6/N8Zfck3AAumecsCaminRtb0JT8uD86gad9/Om4TAq7oew+phAy4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ou9lJmWQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O3uZgMsB; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ou9lJmWQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O3uZgMsB"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 6E2D3EC016F;
	Wed, 19 Aug 2026 08:17:56 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 19 Aug 2026 08:17:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787141876;
	 x=1787228276; bh=X2qRA0NzWj8IxXQxY4zsM9I/jrEGoF+l9BqAM7F8JYo=; b=
	Ou9lJmWQdU2en5yUhsTwks2DMlOid5FF0zI0XEd+tr2w+4sdCcwXg1crv1MMKjZo
	Ji5l/E8o2lvKH4g3NrVfyRKYATijLSmzKngJtD5CCK81+SDoG4gJHG91RBYUyG1I
	Yg29tFULtAy0n+YZnhtWUphl4Tl8f+pMTrwVNcUH7C6v9u9r+FeaO09PTiwP15gB
	VpSKXpi3foUj0UwK6s+M2mQ2FGctKikBvJjHAnZlaQ+g4DBaEud8x65MGK4HKN6K
	AVD73nc7xfjwwbrWDfE67OT6t+p/w2xrYjraBp584ykt4qkZokAgMW7nXEXbxb8r
	+LyIqBNKtKEeJaxqeDZ8fA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787141876; x=
	1787228276; bh=X2qRA0NzWj8IxXQxY4zsM9I/jrEGoF+l9BqAM7F8JYo=; b=O
	3uZgMsBRUHyqH57aeEAWoihqlZJSMyrPtEWuY9ltXP5ncGffn6kc9BMZawqLoFz8
	37ioi/S238KCqf3M9eg/G53bxUNbrQGJ5vyCNlguJGZRZ+PFwI4iP8Zab7+VzvNU
	iumAWhBwLLgIi2CvAfb+WdybXekDNGz/5w4DZ68XMeZYNzoq5qClrz/y+NReaSOs
	YsKZK/FtQEgiFhpf3bMLI9vJnY5nA0KcSyOq1Z6XUdIVAbXrRIMtrkgO3RXCMPeE
	yXZf9stxCRBsMdDSKFltSXAXYT1GZqS5XEtjQ/DxK1Pz61K7b4EWvyIf4ech/oDM
	SqWqPQs1ZjOwPaKJ9WfTA==
X-ME-Sender: <xms:9J6Fasgdu8U-bwQoL0yth0fwBJgZuxn8uQdXVv40y7w8I6p2e3W3YA>
    <xme:9J6FarD9YAogtHJppC6DPg0Yb54lxjskYzQAP5Ys1V4k0B6FubvgjgBLN-v7-z-KB
    vSZHNf5XkXhBcRoxgDfiXaUGURK66Uu0kSYrgRT7HYuyvDyN6rySQ>
X-ME-Received: <xmr:9J6FahsawUGiK8AS__NhY7x0_r_FG1LDoPX1VIcNVa4h4nlE37BGSTYMU8Aq1RnToYeLpuaFQhscIpFUq2n92j3WeudMS4zijl1MOJgr>
X-ME-Proxy-Cause: dmFkZTFnlB1tXVhnVkST8OJxcCpBuTXNYq/1CJ+43DX5iiA7lJ3lNkYfjYvvCP6t2fcUQp
    ga9LXGTeHLUr278FPui2sztKme1qJuZVMh2Hkqe5rOr3EIBv35A8F0lqEnHtk5zbv7wygm
    ahRuc0tO35wLUcR0ohoa7LFTTo29yoSZFZqHKOZtPitSTsjkpVV6tgn5eDvD2lFeGBhMZW
    rVDektv1mLck7nWdy/06eH5Hrr+sAbufERzBwNX0/kpGSj9uBlCrNBfDfK/XdrqFjb4YIo
    oGnf5lbZUVg2NynHn91fAPlj3RdD9tDWO4oVVokB4C+0JpZTuarzi31MiIvs4T9l6yokpI
    oiiB76+m4YAve8vxprB1arDIlEw8cwmw7rpOI4ZaQZAR5PkD8+QVfk1gXW6ExpMBuosIUp
    RtXHRMfltAI67pFdg+n/OR+DMPnVqLocyjPVUE2oc7Gp+zoEIocdTgcilUhcYGG7zbA75C
    sAv2OFtAbRaYJpat6Xu1RX/5WykDkJgh8WczhYD0kwRWRWfDKSr2yEEQsTyCvD4mdygXw0
    hJGBlBx47INjz5+aMEC69Gmr6hDZvGJTa3+zpCWrFrPM9WH6RZrGKzRKvClw11eEvhr+8t
    SQcwR7En01//wIE+ZEOP2Hy+kfM5YrvhR8hHWo9YdDygbjqA/w9otMz976TQ
X-ME-Proxy: <xmx:9J6Faoaoah-VdcbWDzgMhvWSAEgDKz186QXaSnF4a22ndMoBVXdRWA>
    <xmx:9J6FasWiIK38kh5SbItZdrqmTc4YcZM_j5pK0ZJaoNTfLKVCNcABIA>
    <xmx:9J6Fak43Vop8OVdkxmiQKAhXGkF2XTWmw33Pxwf3CrHwPGZa7yW9Lg>
    <xmx:9J6FavhS4teFAbsGvO9tTJf2Ag9J-xP2CO-1vrvFX0_FfZtIUYdcgA>
    <xmx:9J6Fav6vGkoMVyKS_OsDSR2GkBqeLCFDZv5GKJNHllfI5MDN9vXxi-qA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Aug 2026 08:17:55 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0347380e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 19 Aug 2026 12:17:55 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 19 Aug 2026 14:17:21 +0200
Subject: [PATCH v2 3/5] odb/source: let callers discern missing and corrupt
 objects
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-pks-odb-generic-corrupt-objects-v2-3-a984e3a0ad6f@pks.im>
References: <20260819-pks-odb-generic-corrupt-objects-v2-0-a984e3a0ad6f@pks.im>
In-Reply-To: <20260819-pks-odb-generic-corrupt-objects-v2-0-a984e3a0ad6f@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

As explained in the preceding commits, reading objects can either fail
because the object truly does not exist or because it exists, but its
data is corrupt. Some callers do care about this distinction, but there
is no way to tell these two cases apart right now.

Introduce a new `ODB_READ_NOT_FOUND` value that ought to be returned by
the backends in case the object truly does not exist and adapt backends
to use it.

Note that we don't yet return this error from `odb_read_object_info()`
itself. This will be fixed in a subsequent commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.h                         |  2 ++
 odb/source-files.c            | 20 +++++++++++++++++---
 odb/source-inmemory.c         |  2 +-
 odb/source-loose.c            | 31 +++++++++++++++++++------------
 odb/source-packed.c           |  2 +-
 t/unit-tests/u-odb-inmemory.c |  3 ++-
 6 files changed, 42 insertions(+), 18 deletions(-)

diff --git a/odb.h b/odb.h
index 43cbcc3aba..1264d4ce7d 100644
--- a/odb.h
+++ b/odb.h
@@ -440,6 +440,8 @@ enum odb_read_status {
 	ODB_READ_OK = 0,
 	/* The read resulted in a generic error. */
 	ODB_READ_ERROR = -1,
+	/* The object could not be found. */
+	ODB_READ_NOT_FOUND = -2,
 };
 
 /*
diff --git a/odb/source-files.c b/odb/source-files.c
index a28aa5042d..e88fd1d399 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -65,12 +65,26 @@ static enum odb_read_status odb_source_files_read_object_info(struct odb_source
 							      enum object_info_flags flags)
 {
 	struct odb_source_files *files = odb_source_files_downcast(source);
+	enum odb_read_status ret_packed, ret_loose;
 
-	if (!odb_source_read_object_info(&files->packed->base, oid, oi, flags) ||
-	    !odb_source_read_object_info(&files->loose->base, oid, oi, flags))
+	ret_packed = odb_source_read_object_info(&files->packed->base, oid, oi, flags);
+	if (!ret_packed)
 		return 0;
 
-	return -1;
+	ret_loose = odb_source_read_object_info(&files->loose->base, oid, oi, flags);
+	if (!ret_loose)
+		return 0;
+
+	/*
+	 * Reading the packed object may have failed even though the object
+	 * exists, for example because it is corrupt. Report this failure to
+	 * the caller in case neither of the sources was able to read the
+	 * object, and prefer the error of the packed source in case both
+	 * reads have failed.
+	 */
+	if (ret_packed != ODB_READ_NOT_FOUND)
+		return ret_packed;
+	return ret_loose;
 }
 
 static int odb_source_files_read_object_stream(struct odb_read_stream **out,
diff --git a/odb/source-inmemory.c b/odb/source-inmemory.c
index 53d2e3a852..3f3bd12de3 100644
--- a/odb/source-inmemory.c
+++ b/odb/source-inmemory.c
@@ -66,7 +66,7 @@ static enum odb_read_status odb_source_inmemory_read_object_info(struct odb_sour
 
 	object = find_cached_object(inmemory, oid);
 	if (!object)
-		return -1;
+		return ODB_READ_NOT_FOUND;
 
 	populate_object_info(inmemory, oi, object);
 	return 0;
diff --git a/odb/source-loose.c b/odb/source-loose.c
index ad8662842d..3c942a1069 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -91,11 +91,16 @@ static int read_object_info_from_path(struct odb_source_loose *loose,
 		struct stat st;
 
 		if ((!oi || (!oi->disk_sizep && !oi->mtimep)) && (flags & OBJECT_INFO_QUICK)) {
-			ret = quick_has_loose(loose, oid) ? 0 : -1;
+			ret = quick_has_loose(loose, oid) ? 0 : ODB_READ_NOT_FOUND;
 			goto out;
 		}
 
 		if (lstat(path, &st) < 0) {
+			if (errno == ENOENT) {
+				ret = ODB_READ_NOT_FOUND;
+				goto out;
+			}
+
 			ret = -1;
 			goto out;
 		}
@@ -113,9 +118,12 @@ static int read_object_info_from_path(struct odb_source_loose *loose,
 
 	fd = git_open(path);
 	if (fd < 0) {
-		if (errno != ENOENT)
-			error_errno(_("unable to open loose object %s"), oid_to_hex(oid));
-		ret = -1;
+		if (errno == ENOENT) {
+			ret = ODB_READ_NOT_FOUND;
+			goto out;
+		}
+
+		ret = error_errno(_("unable to open loose object %s"), oid_to_hex(oid));
 		goto out;
 	}
 
@@ -155,7 +163,7 @@ static int read_object_info_from_path(struct odb_source_loose *loose,
 
 		if (parse_loose_header(hdr, oi) < 0) {
 			ret = error(_("unable to parse %s header"), oid_to_hex(oid));
-			goto corrupt;
+			goto out;
 		}
 
 		if (*oi->typep < 0)
@@ -165,7 +173,7 @@ static int read_object_info_from_path(struct odb_source_loose *loose,
 			*oi->contentp = unpack_loose_rest(&stream, hdr, *oi->sizep, oid);
 			if (!*oi->contentp) {
 				ret = -1;
-				goto corrupt;
+				goto out;
 			}
 		}
 
@@ -173,21 +181,20 @@ static int read_object_info_from_path(struct odb_source_loose *loose,
 	case ULHR_BAD:
 		ret = error(_("unable to unpack %s header"),
 			    oid_to_hex(oid));
-		goto corrupt;
+		goto out;
 	case ULHR_TOO_LONG:
 		ret = error(_("header for %s too long, exceeds %d bytes"),
 			    oid_to_hex(oid), MAX_HEADER_LEN);
-		goto corrupt;
+		goto out;
 	}
 
 	ret = 0;
 
-corrupt:
-	if (ret && (flags & OBJECT_INFO_DIE_IF_CORRUPT))
+out:
+	if (ret && ret != ODB_READ_NOT_FOUND && (flags & OBJECT_INFO_DIE_IF_CORRUPT))
 		die(_("loose object %s (stored in %s) is corrupt"),
 		    oid_to_hex(oid), path);
 
-out:
 	if (stream_to_end)
 		git_inflate_end(stream_to_end);
 	if (map)
@@ -221,7 +228,7 @@ static enum odb_read_status odb_source_loose_read_object_info(struct odb_source
 	 * second time.
 	 */
 	if (flags & OBJECT_INFO_SECOND_READ)
-		return -1;
+		return ODB_READ_NOT_FOUND;
 
 	odb_loose_path(loose, &buf, oid);
 	return read_object_info_from_path(loose, buf.buf, oid, oi, flags);
diff --git a/odb/source-packed.c b/odb/source-packed.c
index dce68a57f7..9b19405380 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -61,7 +61,7 @@ static enum odb_read_status odb_source_packed_read_object_info(struct odb_source
 		 */
 		if (bad_pack)
 			return -1;
-		return 1;
+		return ODB_READ_NOT_FOUND;
 	}
 
 	/*
diff --git a/t/unit-tests/u-odb-inmemory.c b/t/unit-tests/u-odb-inmemory.c
index ddf2db5c81..3e5068080c 100644
--- a/t/unit-tests/u-odb-inmemory.c
+++ b/t/unit-tests/u-odb-inmemory.c
@@ -72,7 +72,8 @@ void test_odb_inmemory__read_missing_object(void)
 	const char *end;
 
 	cl_must_pass(parse_oid_hex_algop(RANDOM_OID, &oid, &end, repo.hash_algo));
-	cl_must_fail(odb_source_read_object_info(&source->base, &oid, NULL, 0));
+	cl_assert_equal_i(odb_source_read_object_info(&source->base, &oid, NULL, 0),
+			  ODB_READ_NOT_FOUND);
 
 	odb_source_free(&source->base);
 }

-- 
2.55.0.822.g20453c30eb.dirty


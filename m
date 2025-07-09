Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5552D12E4
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 11:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752059889; cv=none; b=MmIeeDWaOQhCk7FiiZB74ird+jDIWjTOUxFiEF7te/hiNRrmxwy6WT94S5JYfZtAc6RyKHISg9Dutj8q3DydqZrXnAagGyxMtkDFTAawsuLZoodoajxVuOukAVJCtwHOl1XIBQNda80E/eKp3WVjPgAw4lmC4vTlly+bAfBfJWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752059889; c=relaxed/simple;
	bh=x+eY+UGF3889wK6h+vQ3zKJYVsN/hFWCKxk8P3a1MtU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bHZpS8NyiIHMJjcORdvXwbIgPf+BabaqNI4FaioQ/3Xx8rWLVOfLyLmj6HxOmUUGqcNIGwoMyUbDKVFr8C7EsjjSU8Ze0ZU94arAEEcE2JDWVbCovgoGy9SbDi0PLZDST5bCUBSEswlmHmq88eaBP2CSVxPcUnhCrQL54bbY8Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CRAZywzy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Jg20HxV+; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CRAZywzy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jg20HxV+"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 74007EC03F8
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 07:18:02 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 09 Jul 2025 07:18:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752059882;
	 x=1752146282; bh=dp4FFLmOTLty/EsBZzuwQI4/7PvkjZE2wyi7u6qtZaY=; b=
	CRAZywzyVmfbKe345XKpBe3/LWDrZcvmQZzyWceV7ovAuYtDiG/MAX34H1yxCBxV
	p1JD9oM0VK/EiH0Tl2c4amqa4Q7j5LQe7ZY6K96xyl9n1OcNKD732mWICsCAKp4T
	MSJUH8X5zvP8iF3MV4GTTBo9h3VcS/GbuUpnBviQdQ2CZEYAxRuIu0DX+c1yvhBQ
	VRZUM66Pg7KFhWRBtdPqVr++RnSUt3wd7A2eOVsvh8dPKm8YPB1ZFZkntvgxygvZ
	Hk5JCk8jhIBk5mO/uzVBu2y+ETtSPFLJlSjty5nkmASNUagVLHJ9xVDfo2X6DkxQ
	OTQ3b/ocYdZa/6oqucTLJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752059882; x=
	1752146282; bh=dp4FFLmOTLty/EsBZzuwQI4/7PvkjZE2wyi7u6qtZaY=; b=J
	g20HxV+Pg+QL2CVWQCxsfPXma1aZHgxwbWazBZlazQaD0hZWt9GTnSJgCnCqjTSg
	J5DB4j/reNxkw3dsse3kYkzms8dhi9D/nRF2GWWhFk9kUn0jXypSsGeltOzRWhxa
	YRJcnVsgaCtpw18YaeF/rft2CTF5FgZapa6n2zJK0JNjpt4OSZ1XtKqW64WZlKzh
	BRvGnJL0akhStPmaF5QFYQDROVs6UCqQgQrklIsoFyE/q6NytvHa8HtZp0R10zn1
	ne30BWzXmj1jm7Y6bfMeNm556nR6kXVtdQOkCxAqvPwhplr4mGr4RgTNPZP440dp
	SLUpMZxBQLP8r9bnVbGNA==
X-ME-Sender: <xms:6k9uaMz7aKnNkqPIj6R_Cnp6kxLx1yjklsHwN9NWSMjFiQeHjZqGGg>
    <xme:6k9uaCTpHvgCvW2jV7CYhZqEVrTYF9JZF93wGkoKnllw3SqFpgjD8t4B8iVstyxJ_
    Ro7r8fXpfR6tFWpIQ>
X-ME-Received: <xmr:6k9uaHsdRfi2EjxPxNRFc0AxEHHf158oRWhuYNtXFKbTHZRDlnhVur-LEUzXW7X7_Mh-9fSbHNGHdwxa-BeiaOCh_QnWpFc2sRl3A73kbGIaLA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefjeegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:6k9uaMsEc0ZtsE7hNeAGVKxd0Q5NBIZaGGeFYVG573MbBqCCDf3G-w>
    <xmx:6k9uaFxZFoyUTH9I0qAS1Dn9nPN776ETjl57jKMNxt4DP1L-g3l0aw>
    <xmx:6k9uaKi9m_Hv-QrtSlWQalsHkR_ptJjXmnPXuJD8CMDKqzzTLj3HCw>
    <xmx:6k9uaBBQKCscwZSfeObB1bajcfNNMUEfeVuibAmeoCnSv9GTx8lpSQ>
    <xmx:6k9uaHryZOf2tArYAVPaKsnUNx317Eda-C4VID9nKa3Vmq6bQQld7dAb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 9 Jul 2025 07:18:01 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b7212850 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Wed, 9 Jul 2025 11:18:01 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 09 Jul 2025 13:17:24 +0200
Subject: [PATCH 14/19] object-file: get rid of `the_repository` in
 `read_loose_object()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-pks-object-file-wo-the-repository-v1-14-62627b55707f@pks.im>
References: <20250709-pks-object-file-wo-the-repository-v1-0-62627b55707f@pks.im>
In-Reply-To: <20250709-pks-object-file-wo-the-repository-v1-0-62627b55707f@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

The function `read_loose_object()` takes a path to an object file and
tries to parse it. As such, the function does not depend on any specific
object database but instead acts as an ODB-independent way to read a
specific file. As such, all it needs as input is a repository so that we
can derive repo settings and the hash algorithm.

That repository isn't passed in as a parameter though, as we implicitly
depend on the global `the_repository`. Refactor the function so that we
pass in the repository as a parameter.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fsck.c | 2 +-
 object-file.c  | 9 +++++----
 object-file.h  | 3 ++-
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index f0854ce5d84..e9112d884f0 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -633,7 +633,7 @@ static int fsck_loose(const struct object_id *oid, const char *path,
 	oi.sizep = &size;
 	oi.typep = &type;
 
-	if (read_loose_object(path, oid, &real_oid, &contents, &oi) < 0) {
+	if (read_loose_object(the_repository, path, oid, &real_oid, &contents, &oi) < 0) {
 		if (contents && !oideq(&real_oid, oid))
 			err = error(_("%s: hash-path mismatch, found at: %s"),
 				    oid_to_hex(&real_oid), path);
diff --git a/object-file.c b/object-file.c
index b894379d22c..f7c07acadc9 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1535,7 +1535,8 @@ static int check_stream_oid(git_zstream *stream,
 	return 0;
 }
 
-int read_loose_object(const char *path,
+int read_loose_object(struct repository *repo,
+		      const char *path,
 		      const struct object_id *expected_oid,
 		      struct object_id *real_oid,
 		      void **contents,
@@ -1574,9 +1575,9 @@ int read_loose_object(const char *path,
 	}
 
 	if (*oi->typep == OBJ_BLOB &&
-	    *size > repo_settings_get_big_file_threshold(the_repository)) {
+	    *size > repo_settings_get_big_file_threshold(repo)) {
 		if (check_stream_oid(&stream, hdr, *size, path, expected_oid,
-				     the_repository->hash_algo) < 0)
+				     repo->hash_algo) < 0)
 			goto out_inflate;
 	} else {
 		*contents = unpack_loose_rest(&stream, hdr, *size, expected_oid);
@@ -1584,7 +1585,7 @@ int read_loose_object(const char *path,
 			error(_("unable to unpack contents of %s"), path);
 			goto out_inflate;
 		}
-		hash_object_file(the_repository->hash_algo,
+		hash_object_file(repo->hash_algo,
 				 *contents, *size,
 				 *oi->typep, real_oid);
 		if (!oideq(expected_oid, real_oid))
diff --git a/object-file.h b/object-file.h
index 1b1ab95423d..52f7979267d 100644
--- a/object-file.h
+++ b/object-file.h
@@ -210,7 +210,8 @@ int check_and_freshen_file(const char *fn, int freshen);
  *
  * Returns 0 on success, negative on error (details may be written to stderr).
  */
-int read_loose_object(const char *path,
+int read_loose_object(struct repository *repo,
+		      const char *path,
 		      const struct object_id *expected_oid,
 		      struct object_id *real_oid,
 		      void **contents,

-- 
2.50.1.327.g047016eb4a.dirty


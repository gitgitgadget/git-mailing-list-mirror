Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040FF322A30
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 06:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766039315; cv=none; b=hBQl5l4jqC9ZYouF2zIP7G9IyqXbO37GZHM2pmqf03e6df2gpCMlEqCG7Z9xttQX2nGQR/esbimbrXm24JNkdAkfPq9hVJwIaGT9PnHKT6kcVoiFnKbpNxJTPi9cJLAoVirQvk/NQqmoh2P7eRdDtmPjrqkZUTh2m+NZSY0VV4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766039315; c=relaxed/simple;
	bh=jpb/qG3nXwOeUI9BpMUp71WG7ZMvJ/zATozjkLjv1xQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XS7GWc0e7e+s3bEuRK576LL9xfMo889dqUBqacLV38EFHE1+9F3C7ACIL3y4CFff/aLxRnEtqLruDJRfzqX99jErHxZDj+PDSV7kfQCvt//5ziMZ/UeHzftUQpnzps0n+zvHo9jbr6CUjb0TsBCj6gA3Bbq71MV3e/RotTr5yrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FsPZYeDs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XH+N48MP; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FsPZYeDs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XH+N48MP"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 2F2E41D000A7;
	Thu, 18 Dec 2025 01:28:32 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 18 Dec 2025 01:28:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1766039312;
	 x=1766125712; bh=Y4unC439ToyNahjDHGBXo4MOp+gvFjcaiz8grDKDUwE=; b=
	FsPZYeDs6KvDB9SJnJoTzxIh855bNjQwwk0ncDfJoL5htFKtBAnzo0Iis4jjdf+L
	5obYAm32OSddthHNUV7Qz/STUdrXfkO0xHcVtYyCJEIP44hyvt7G7pB+O8XNTo+4
	MxvJFOj89+BFtJWjJf630eXi6hcwj793o/WG6PtVDQnjU2YbzhXlpH1tiaztnAh1
	vswLVzgZgRFoW7LhyW3rWv8pXhTqjP1TLBfbvVDzVkz0kjHHzn1E46ibjOZAbTR2
	EyBlL4+fhGSXcmjI9ipgz42UhtoDuEf0YZOZjK78Hls+CWOA1+ZzY11Ia8YNDFQE
	3wG6yM8H2AIZLVFGuh020g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766039312; x=
	1766125712; bh=Y4unC439ToyNahjDHGBXo4MOp+gvFjcaiz8grDKDUwE=; b=X
	H+N48MPwzLvKjE6jlNQLbXFdJ/fhd+6/YbjaAjVG5DXxTtAHZVPFRkw++OyPmk84
	9xXz5CT3Xq524aoamF8O1WjOxnpYIy8+NYoRHwJknngsy6gbLz/s3jnNdNAqKaRU
	Xp47jaVbr1wivqcOz1NpwUTaZhzxVVDOWdFBJ0HQodJBMaOKt7UJpIwspeGbTseN
	hM0P6Uh5+Qw7fX3xYbHwJ+IrAZ3gQ8S4ZJw0DXConNKpwgxWOCPWlKncaqGyERZ0
	Ig5kR8fL2ntldcFuR2KVC+8TYcrvyMNXIzHoSOBleCRB/P2UNLmN7E9Q7XJ4YO6q
	5UU1B1y4nA+IiYRYIJUJw==
X-ME-Sender: <xms:D59DacIQNuAW9uu0kGAkZfGgGjUPgCkLauf4dHgoMdIeCRw32v4ZJQ>
    <xme:D59DaTlmvWqoyIWBLBKe0pUsdOE5-c8w507P5asZreBhRqyKioWukQbxOZzqmSQI6
    Ld2qlHgeoykTdpOTgjOtekVMb1rEyXaKybhp-h-fRvxFsbDlCGHlw>
X-ME-Received: <xmr:D59DaaHEhXtrw8dLVTdhoouATlS1XPuEjGX_RaVnIvlLxGuFwc12t1HH5fgGF35Q-TU77nyR3kY3hfqXrxB4QMh7pxrWeBN3dpJoJnMu3g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeggeejtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epkeeiveevgeeiveeiueevfeehffegueehteehgeffffekieejtdeufeelffdvveelnecu
    ffhomhgrihhnpehprggtkhgvugdrihhsnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghplhgrthhtnhgvrhesnhhvihguih
    grrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:D59DaTHi05FS1jIp326QhXkgfisf8t_cnptx1O8CWKu2vSa9mhsH_Q>
    <xmx:D59DaXPQ_OHP0D2073xfkpeI4jYnkGBSmhJ2rh5mXlWIY-TGR3nuMA>
    <xmx:D59DaSGUgUqVkKMzwgRIKaQj6glDnxP1zsYIgpfKRjsAeunRULnUFg>
    <xmx:D59DaePBgL6AbcG4ovB4eFjQ_c39Fag8XsBFnMKuud2Qj62uWgOEFg>
    <xmx:EJ9DacsywBhKJgIiU8Cn_F-aaFRRKU0GgZCRwuP7ns9E38fjGML1fNk2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Dec 2025 01:28:31 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 15cbba93 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 18 Dec 2025 06:28:30 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 18 Dec 2025 07:28:13 +0100
Subject: [PATCH 3/8] packfile: extend `is_delta` field to allow for
 "unknown" state
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-b4-pks-odb-read-object-info-improvements-v1-3-81c8368492be@pks.im>
References: <20251218-b4-pks-odb-read-object-info-improvements-v1-0-81c8368492be@pks.im>
In-Reply-To: <20251218-b4-pks-odb-read-object-info-improvements-v1-0-81c8368492be@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Aaron Plattner <aplattner@nvidia.com>
X-Mailer: b4 0.14.3

The `struct object_info::u::packed::is_delta` field determines whether
or not a specific object is stored as a delta. It only stores whether or
not the object is stored as delta, so it is treated as a boolean value.

This boolean is insufficient though: when reading a packed object via
`packfile_store_read_object_info()` we know to skip parsing the actual
object when the user didn't request any object-specific data. In that
case we won't read the object itself, but will only look up its position
in the packfile. Consequently, we do not know whether it is a delta or
not.

This isn't really an issue right now, as the check for an empty request
is broken. But a subsequent commit will fix it, and once we do we will
have the need to also represent an "unknown" delta state.

Prepare for this change by introducing a new enum that encodes the
object type. We don't use the "unknown" state just yet, but will start
to do so in the next commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.h      |  7 ++++++-
 packfile.c | 17 ++++++++++++++---
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/odb.h b/odb.h
index 73b0b87ad5..afae5e5c01 100644
--- a/odb.h
+++ b/odb.h
@@ -343,7 +343,12 @@ struct object_info {
 		struct {
 			struct packed_git *pack;
 			off_t offset;
-			unsigned int is_delta;
+			enum packed_object_type {
+				PACKED_OBJECT_TYPE_UNKNOWN,
+				PACKED_OBJECT_TYPE_FULL,
+				PACKED_OBJECT_TYPE_OFS_DELTA,
+				PACKED_OBJECT_TYPE_REF_DELTA,
+			} type;
 		} packed;
 	} u;
 };
diff --git a/packfile.c b/packfile.c
index 79ad9d7179..9bce52f912 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2160,8 +2160,18 @@ int packfile_store_read_object_info(struct packfile_store *store,
 	if (oi->whence == OI_PACKED) {
 		oi->u.packed.offset = e.offset;
 		oi->u.packed.pack = e.p;
-		oi->u.packed.is_delta = (rtype == OBJ_REF_DELTA ||
-					 rtype == OBJ_OFS_DELTA);
+
+		switch (rtype) {
+		case OBJ_REF_DELTA:
+			oi->u.packed.type = PACKED_OBJECT_TYPE_REF_DELTA;
+			break;
+		case OBJ_OFS_DELTA:
+			oi->u.packed.type = PACKED_OBJECT_TYPE_OFS_DELTA;
+			break;
+		default:
+			oi->u.packed.type = PACKED_OBJECT_TYPE_FULL;
+			break;
+		}
 	}
 
 	return 0;
@@ -2532,7 +2542,8 @@ int packfile_store_read_object_stream(struct odb_read_stream **out,
 	oi.sizep = &size;
 
 	if (packfile_store_read_object_info(store, oid, &oi, 0) ||
-	    oi.u.packed.is_delta ||
+	    oi.u.packed.type == PACKED_OBJECT_TYPE_REF_DELTA ||
+	    oi.u.packed.type == PACKED_OBJECT_TYPE_OFS_DELTA ||
 	    repo_settings_get_big_file_threshold(store->odb->repo) >= size)
 		return -1;
 

-- 
2.52.0.351.gbe84eed79e.dirty


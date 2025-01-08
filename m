Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63959202C43
	for <git@vger.kernel.org>; Wed,  8 Jan 2025 19:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736363699; cv=none; b=uyJ4isC0RmfAJMNvOBSVb8xn9NW14vrBO/lkSW3XsnFoEwXiocK9Ucby93ijBZVIdzwWDZLpb5S/r2OCAC3JbnKj+krk2X35qx4GixQUCwzcDevtoev8YHXOP5xVU6wWbe903uR05soRDAS3O1EE4TL3+6XBOtQP2tBmou8SC7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736363699; c=relaxed/simple;
	bh=0R8CMZ2t8B2qiNxcowckwjvrCL6YH9uzs7njIirFzNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y0G6JJBJQ0BT81+EfPLPwUnvb+UAYHHlKCUtqPVSSKS8cTsw+wlRJznpuumSkIpjqJsunzH6QAdWkglemOt6AqA7kapSD1xpN4Hto0hPfkIWeSSDZs+Jzm0LgNzardDGZOMr3LvxipH66sqHMZzq9+OH7BUJZuYUv1gt0KjhRYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=cPFBAM9X; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="cPFBAM9X"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e4930eca0d4so73663276.3
        for <git@vger.kernel.org>; Wed, 08 Jan 2025 11:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1736363696; x=1736968496; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NL2kpIkDtmrtdsHAuH7/yDLd5xKXPl1QWSgXxmyWk4w=;
        b=cPFBAM9XhlQDne8M9bmlDVQqjU+T47A0DvsFDH06RIKf6iBFn7q7rHZrclsAsxTmeP
         zNl3Cf5PmiLTYK1ghN0eDvNNfcJz28yPI6MAIEPCpbExJbdkp9ibUmRVUfo9PoKVWK3+
         o/YgT3nEp3fUonk87aXRhLpt2AY+q5qym1dXhpkwD47BttUNdlgDOeVV1q6OCPeYA/gC
         8Df2N+ruzBqMGjyAY93vdaRDonPUB3TzJmklMeGAaPdODHtgolSHrjmixoZVSfvKY9y+
         OgCdS0Drng37bgxFgRi/yU7+vBwJZszHkDORMcg4VPKlT7t8XxCvan+gT8EJ/fTzb1L5
         S24A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736363696; x=1736968496;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NL2kpIkDtmrtdsHAuH7/yDLd5xKXPl1QWSgXxmyWk4w=;
        b=eVbmaHNlR93GIhKxJLX8UNq29Mi0L2xUhSDYooEjCrLE/E92w3Bsb6sgF3EOsry4gh
         3pYF7lZ3tNwBur/KA1humX1p5CMMhw3pZ0fs9GHVBAi7xVy2DTlM8521DGx8ZOtnBUpX
         bpDS8M6uayICRMY/yLANPdHGoAEWzuWzY2CzshLmdGpvwczBvuKs4IoYITtyj72p8MFw
         tuuaJ2yMVhMhLyDdAQnDwq+D3z7MjRx3r+OvD1/4wqmZKKTo80i8G3TXNoq3QUqjhg5L
         HscefnwWe0TREYcvoHyUzW1vEUMaJfETfxRivyDF0iHPaCwDsIl5JnvCggOc9i5JPKtp
         Kwjg==
X-Gm-Message-State: AOJu0YzS4w+t3oIVs0CXTF/uEtKlCw2lfSOdBmRdgUyIFkshs1bXJwtx
	lERtTFidiDgp6XcZJe8zAQ5pDSO2VLbVSOQl5rTNHBgFf4ojBqwNP4llzoIAgV9W/1sBRC3VhPW
	GLSU=
X-Gm-Gg: ASbGncvI/A6N0NFpbfYRF+D7EZS0d5PDdvEyGLKo8Ua9a1sudSQgfjrenCuTLtCCqEB
	LtNBBfi2oY/CSUDYKBL1WbxIwO1OqjVzCgNbxYzj4QE2o0FoHLpPk2bCr2TqK7eS4WIcJ56B/K3
	RcQmCev/B+eoL2dnntY0NPiXxQZ3eON7ycyRV4URiT5EHHmfvHaDfh4dfD8hLACBplC3QJ7/D5y
	qM4aOOHontGgto1CIAtQ1KzQ+FS66bkzF7CXpJdtrfWbnUWTOkCcJBxITfIHYPWs/Thq7bkl7wj
	h1t9mGJiXv+Ms2eJl8aQ1oc6ihas
X-Google-Smtp-Source: AGHT+IFoKNCv2VzIs032DzXn2deOaFDtYS1MenRmTCGBl8vPiKXXfiS/Fm4Rxea3NjNvnVwa+rTmEQ==
X-Received: by 2002:a05:690c:b1d:b0:6ef:4b7a:eb07 with SMTP id 00721157ae682-6f5313254c8mr35721487b3.36.1736363696073;
        Wed, 08 Jan 2025 11:14:56 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f3e73e8939sm95062557b3.19.2025.01.08.11.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 11:14:55 -0800 (PST)
Date: Wed, 8 Jan 2025 14:14:54 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 8/8] hash.h: drop unsafe_ function variants
Message-ID: <f5579883816b8b5ce68d8a8ff27da4f8bb84573b.1736363652.git.me@ttaylorr.com>
References: <cover.1732130001.git.me@ttaylorr.com>
 <cover.1736363652.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1736363652.git.me@ttaylorr.com>

Now that all callers have been converted from:

    the_hash_algo->unsafe_init_fn();

to

    unsafe_hash_algo(the_hash_algo)->unsafe_init_fn();

and similar, we can remove the scaffolding for the unsafe_ function
variants and force callers to use the new unsafe_hash_algo() mechanic
instead.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 hash.h        | 15 ---------------
 object-file.c | 15 ---------------
 2 files changed, 30 deletions(-)

diff --git a/hash.h b/hash.h
index 23cf6876e50..6dcbf6ab835 100644
--- a/hash.h
+++ b/hash.h
@@ -282,21 +282,6 @@ struct git_hash_algo {
 	/* The hash finalization function for object IDs. */
 	git_hash_final_oid_fn final_oid_fn;
 
-	/* The non-cryptographic hash initialization function. */
-	git_hash_init_fn unsafe_init_fn;
-
-	/* The non-cryptographic hash context cloning function. */
-	git_hash_clone_fn unsafe_clone_fn;
-
-	/* The non-cryptographic hash update function. */
-	git_hash_update_fn unsafe_update_fn;
-
-	/* The non-cryptographic hash finalization function. */
-	git_hash_final_fn unsafe_final_fn;
-
-	/* The non-cryptographic hash finalization function. */
-	git_hash_final_oid_fn unsafe_final_oid_fn;
-
 	/* The OID of the empty tree. */
 	const struct object_id *empty_tree;
 
diff --git a/object-file.c b/object-file.c
index 43efa4ca361..c4b42dd4be9 100644
--- a/object-file.c
+++ b/object-file.c
@@ -230,11 +230,6 @@ const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
 		.update_fn = git_hash_unknown_update,
 		.final_fn = git_hash_unknown_final,
 		.final_oid_fn = git_hash_unknown_final_oid,
-		.unsafe_init_fn = git_hash_unknown_init,
-		.unsafe_clone_fn = git_hash_unknown_clone,
-		.unsafe_update_fn = git_hash_unknown_update,
-		.unsafe_final_fn = git_hash_unknown_final,
-		.unsafe_final_oid_fn = git_hash_unknown_final_oid,
 		.empty_tree = NULL,
 		.empty_blob = NULL,
 		.null_oid = NULL,
@@ -250,11 +245,6 @@ const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
 		.update_fn = git_hash_sha1_update,
 		.final_fn = git_hash_sha1_final,
 		.final_oid_fn = git_hash_sha1_final_oid,
-		.unsafe_init_fn = git_hash_sha1_init_unsafe,
-		.unsafe_clone_fn = git_hash_sha1_clone_unsafe,
-		.unsafe_update_fn = git_hash_sha1_update_unsafe,
-		.unsafe_final_fn = git_hash_sha1_final_unsafe,
-		.unsafe_final_oid_fn = git_hash_sha1_final_oid_unsafe,
 		.unsafe = &sha1_unsafe_algo,
 		.empty_tree = &empty_tree_oid,
 		.empty_blob = &empty_blob_oid,
@@ -271,11 +261,6 @@ const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
 		.update_fn = git_hash_sha256_update,
 		.final_fn = git_hash_sha256_final,
 		.final_oid_fn = git_hash_sha256_final_oid,
-		.unsafe_init_fn = git_hash_sha256_init,
-		.unsafe_clone_fn = git_hash_sha256_clone,
-		.unsafe_update_fn = git_hash_sha256_update,
-		.unsafe_final_fn = git_hash_sha256_final,
-		.unsafe_final_oid_fn = git_hash_sha256_final_oid,
 		.empty_tree = &empty_tree_oid_sha256,
 		.empty_blob = &empty_blob_oid_sha256,
 		.null_oid = &null_oid_sha256,
-- 
2.48.0.rc2.33.gaab3d23ed4c

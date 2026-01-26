Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D587D2C08D5
	for <git@vger.kernel.org>; Mon, 26 Jan 2026 09:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769421087; cv=none; b=KK74qUimTPFSFveYpRnX1dI1j5tGsPOw5RaJDWqQhSC9A6mdY4kf4svngZXBLi+4el5vLHJjImowY63bO99qkQsImWczfDQWTWcS2jy+613FTRDJPWnqbAUsSh/godA9a3+4E0DWLz3uwOIHSjWze7qtEnlknlE9JkIyYUrwz7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769421087; c=relaxed/simple;
	bh=Mak6wINpe0ptCtYBHlnqsH1cL7H6iA4wNxFyRBFrH0U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=omVRMpI7kEQLjaYvlc+r6pnLJm4OgNHNzhjOiXGE4XUs3lSyq+CEL0OF2hzqOW3uyPoZMdciYsNWppyg1WilxWKYS8J5mtgTp0HLl8M9CT4hb25ArSYUWNzEgy7s6+0oz1P5leS9SfcBIpeMSQRB1lSVLmRhKtfqGHFOwYnZ0a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CtbmC0M5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dmsCYxa1; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CtbmC0M5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dmsCYxa1"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E00487A0044;
	Mon, 26 Jan 2026 04:51:23 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 26 Jan 2026 04:51:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1769421083;
	 x=1769507483; bh=o+KObzns3po8J/8++ANVHV3z947oA+FetL8s/09FMAQ=; b=
	CtbmC0M5qA3kglU3XWCNuNQ9Xpn5/UNxT0K+vAEvAIMajiGpZAlZuYi8DV9Bjd5r
	DYHv5woGv1AofvWHN9nrdRF5Gym9SWNoeDNqF6iwoG850vTjzW9C3PtjPsyekofS
	jK2oc1x5QwwsBosVF2xd/+UsBEMxpcEG0hl5/49dgctcPKEheYU/R7u5PIwG0O/r
	mxaePyk/Xr0aCQjahz834PGuqCGjhpTnUPWDgEQ/tFPI3Z/PuAoJAVxtVlcol1i0
	fphuMiDlpYTAnLDawo/SaJa+sX0U6rP8vFYiigEmKO4J88jX1BshS5R3pFlGSX3M
	jfI4XqZ5EpJUtraWR3z+lg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1769421083; x=
	1769507483; bh=o+KObzns3po8J/8++ANVHV3z947oA+FetL8s/09FMAQ=; b=d
	msCYxa13exxH8OyhP/CWxGIsL8JHbUKq8f2NSiMScSv3ZROcnhYIob7MyDSog+NN
	DzvWhf4rnreoZYWoM7jM0N4ooWy7rqZ7tAxcZoCi5ugnEarWRe5qSuKt+ffEL3um
	LEFq55sGWHL2kwMGpM5lvsJ/PjBNZehEeIX2sk79s8qTpNIZLCN/GjMpggYgLX4U
	oM3dqWTlOb7VxMwrAPfMeD85nLSr8n+6ncdth5OxDZkiN+BVUmnHi4q69rRS2Hbl
	R3XrVT/1aDl9kwWkDgiKdBuoG8WPh78KGSuXtCvDiEHk1+GiswHyQpZLUw8CFFJA
	P9KsYFDcQwreeVlwg2ZiQ==
X-ME-Sender: <xms:Gzl3aRLg8p4wR3oPrLH5rCWIPhbVlNNZcQ9kdTNL1a-mHf4QtI-WQg>
    <xme:Gzl3aUJUgHIl6wFJod_Euq6Wf4-V6VAIrRBIEez_g9o018-kUQjUrdMbTY1eFcU6S
    -7Mkb3YFYPGwmkvPt5ik811ZT97ucC7Mki-yg2mS5vsN3CjLSfIkg>
X-ME-Received: <xmr:Gzl3aes5GWMkDhjRVvzb2xSHbFuhCMzM-ZhLVkO4QSPtBvIXAvZnCcZF3PdH3grw1IH77T2oJfEgpaEQ2zNLBHCgESotBocoAacFqU7D37gBoA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheejfeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffufffkgggtgfgjfhfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetueeuhefhhfeitdeuhedttdeikeeftdduhedtheefhfegffevgeegtdfhheeuvden
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohep
    gedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghp
    thhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthh
    hikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:Gzl3aRTZiuNm2mHFqRkYXZF2vkyvWrtHmuBYXhx2uXxBV7LjM_lmcw>
    <xmx:Gzl3aUOb18S4cD2OpUHKCbcC9Zl9wo_zw9I3KJjcBDOP7ixO68xqFg>
    <xmx:Gzl3aWabpQ_OdwEzySYCe6qKCwrCoAwB48IR516c3VfcrC6a1TATaA>
    <xmx:Gzl3aezhE7FgqvyMauiaOseJakPT4cv-2PiWQuzcQtB72-Z_MzqatQ>
    <xmx:Gzl3aePTBMF8AcxVoZsYMsABsTqZxo41UNnXlw-DYR_9tXQ541jDTTUe>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Jan 2026 04:51:22 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8963d6e8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 26 Jan 2026 09:51:21 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 00/14] odb: introduce `odb_for_each_object()`
Date: Mon, 26 Jan 2026 10:51:16 +0100
Message-Id: <20260126-pks-odb-for-each-object-v4-0-5a64a038c791@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABU5d2kC/4XNzQ6CMAzA8VchO1uzFcaHJ9/DeIB1k2lkZCNEQ
 3h3BweDB+Lx37S/Tixob3Vgp2RiXo82WNfFyA4JU23d3TRYis2QY86FkNA/AjhqwDgPulYtuOa
 u1QA5b4pSkeaVIRave6+Nfa3y5Rq7tWFw/r0+GsUy/W+OAjjITJR1JUhSVZ3j5tE+2QKOuEGQ7
 yMYEeJSNYZSyk35g6RbROwjaUQEqowMYYZYfJF5nj+j10d7RQEAAA==
X-Change-ID: 20260115-pks-odb-for-each-object-60b78cde09fd
In-Reply-To: <20260115-pks-odb-for-each-object-v1-0-5418a91d5d99@pks.im>
References: <20260115-pks-odb-for-each-object-v1-0-5418a91d5d99@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.3

Hi,

this patch series introduces a generic `odb_for_each_object()` function
to iterate through objects and adapts callers to use it. The intent is
to make iteration through objects independent of the actual storage
backend.

The series is structured as follows:

  - Commits 1 to 2 do some cleanups for the for-each-object flags.

  - Commits 3 to 7 introduce the infrastructure for
    `odb_for_each_object()`.

  - Commits 8 to 13 convert a couple of callers to use the new
    interfaces.

  - Commit 14 drops now-unused functions.

The patch series is built on top of 8745eae506 (The 17th batch,
2026-01-11) with the following two series merged into it:

  - ps/read-object-info-improvements at a282a8f163 (packfile: move MIDX
    into packfile store, 2026-01-09).

  - ps/packfile-store-in-odb-source at 12d3b58b55 (packfile: drop
    repository parameter from `packed_object_info()`, 2026-01-12) .

Changes in v4:
  - Convert the `odb_for_each_object()` object info into a read-only
    request parameter. Instead, we now read into a "fresh" object info
    in the backends so that there can be no stale data.
  - Fix typo in `struct object_info *io` parameter.
  - Document what's still missing to convert `batch_each_object()` to
    use the generic `odb_for_each_object()` function.
  - Document ambiguity of the `mtime`.
  - Re-add the `ODB_FOR_EACH_OBJECT_LOCAL_ONLY` flag in
    `add_object_in_unpacked_pack()`. It shouldn't make any difference,
    but it makes the conversion a bit more straight-forward.
  - Link to v3: https://lore.kernel.org/r/20260121-pks-odb-for-each-object-v3-0-12c4dfd24227@pks.im

Changes in v3:
  - Fix error code propagation in last commit.
  - Link to v2: https://lore.kernel.org/r/20260120-pks-odb-for-each-object-v2-0-d05cbfd3d6f8@pks.im

Changes in v2:
  - Clarify the comment of `odb_for_each_object()` to point out that
    it's the callback that can abort iteration by returning a non-zero
    error code.
  - Document in the commit message that we don't yet convert all sites
    to use `odb_for_each_object()`.
  - Link to v1: https://lore.kernel.org/r/20260115-pks-odb-for-each-object-v1-0-5418a91d5d99@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (14):
      odb: rename `FOR_EACH_OBJECT_*` flags
      odb: fix flags parameter to be unsigned
      object-file: extract function to read object info from path
      object-file: introduce function to iterate through objects
      packfile: extract function to iterate through objects of a store
      packfile: introduce function to iterate through objects
      odb: introduce `odb_for_each_object()`
      builtin/fsck: refactor to use `odb_for_each_object()`
      treewide: enumerate promisor objects via `odb_for_each_object()`
      treewide: drop uses of `for_each_{loose,packed}_object()`
      odb: introduce mtime fields for object info requests
      builtin/pack-objects: use `packfile_store_for_each_object()`
      reachable: convert to use `odb_for_each_object()`
      odb: drop unused `for_each_{loose,packed}_object()` functions

 builtin/cat-file.c     |  36 ++++++++--
 builtin/fsck.c         |  57 ++++-----------
 builtin/pack-objects.c |  48 +++++++------
 commit-graph.c         |  46 +++++++++----
 object-file.c          | 125 ++++++++++++++++++++++-----------
 object-file.h          |  22 +++---
 odb.c                  |  31 +++++++++
 odb.h                  |  58 ++++++++++++++--
 packfile.c             | 184 +++++++++++++++++++++++++++++++++----------------
 packfile.h             |  19 ++++-
 reachable.c            | 129 ++++++++++------------------------
 repack-promisor.c      |   8 +--
 revision.c             |  10 ++-
 13 files changed, 462 insertions(+), 311 deletions(-)

Range-diff versus v3:

 1:  a080e62c44 =  1:  e7fa63f733 odb: rename `FOR_EACH_OBJECT_*` flags
 2:  7980f241a9 =  2:  b462808c07 odb: fix flags parameter to be unsigned
 3:  14b9251711 =  3:  00d77e9e45 object-file: extract function to read object info from path
 4:  93af71f3c7 !  4:  b9899bd1cb object-file: introduce function to iterate through objects
    @@ object-file.c: int for_each_loose_object(struct object_database *odb,
      
     +struct for_each_object_wrapper_data {
     +	struct odb_source *source;
    -+	struct object_info *oi;
    ++	const struct object_info *request;
     +	odb_for_each_object_cb cb;
     +	void *cb_data;
     +};
    @@ object-file.c: int for_each_loose_object(struct object_database *odb,
     +				      void *cb_data)
     +{
     +	struct for_each_object_wrapper_data *data = cb_data;
    -+	if (data->oi &&
    -+	    read_object_info_from_path(data->source, path, oid, data->oi, 0) < 0)
    ++
    ++	if (data->request) {
    ++		struct object_info oi = *data->request;
    ++
    ++		if (read_object_info_from_path(data->source, path, oid, &oi, 0) < 0)
     +			return -1;
    -+	return data->cb(oid, data->oi, data->cb_data);
    ++
    ++		return data->cb(oid, &oi, data->cb_data);
    ++	} else {
    ++		return data->cb(oid, NULL, data->cb_data);
    ++	}
     +}
     +
     +int odb_source_loose_for_each_object(struct odb_source *source,
    -+				     struct object_info *oi,
    ++				     const struct object_info *request,
     +				     odb_for_each_object_cb cb,
     +				     void *cb_data,
     +				     unsigned flags)
     +{
     +	struct for_each_object_wrapper_data data = {
     +		.source = source,
    -+		.oi = oi,
    ++		.request = request,
     +		.cb = cb,
     +		.cb_data = cb_data,
     +	};
    @@ object-file.h: int for_each_loose_object(struct object_database *odb,
     + * `odb_source_loose_read_object_info()` on the object.
     + */
     +int odb_source_loose_for_each_object(struct odb_source *source,
    -+				     struct object_info *oi,
    ++				     const struct object_info *request,
     +				     odb_for_each_object_cb cb,
     +				     void *cb_data,
     +				     unsigned flags);
 5:  ad0a28e2bb =  5:  03fe7d5b3b packfile: extract function to iterate through objects of a store
 6:  e87126ddee !  6:  4648a18a9b packfile: introduce function to iterate through objects
    @@ Commit message
         packfile: introduce function to iterate through objects
     
         Introduce a new function `packfile_store_for_each_object()`. This
    -    function is the equivalent to `odb_source_loose_for_each_object()` in
    +    function is equivalent to `odb_source_loose_for_each_object()`, except
         that it:
     
    -      - Works on a single packfile store and thus per object source.
    +      - Works on a single packfile store instead of working on the object
    +        database level. Consequently, it will only yield packed objects of a
    +        single object database source.
     
           - Passes a `struct object_info` to the callback function.
     
    @@ packfile.c: int for_each_packed_object(struct repository *repo, each_packed_obje
      
     +struct packfile_store_for_each_object_wrapper_data {
     +	struct packfile_store *store;
    -+	struct object_info *oi;
    ++	const struct object_info *request;
     +	odb_for_each_object_cb cb;
     +	void *cb_data;
     +};
    @@ packfile.c: int for_each_packed_object(struct repository *repo, each_packed_obje
     +{
     +	struct packfile_store_for_each_object_wrapper_data *data = cb_data;
     +
    -+	if (data->oi) {
    ++	if (data->request) {
     +		off_t offset = nth_packed_object_offset(pack, index_pos);
    ++		struct object_info oi = *data->request;
     +
    -+		if (packed_object_info(pack, offset, data->oi) < 0) {
    ++		if (packed_object_info(pack, offset, &oi) < 0) {
     +			mark_bad_packed_object(pack, oid);
     +			return -1;
     +		}
    -+	}
     +
    -+	return data->cb(oid, data->oi, data->cb_data);
    ++		return data->cb(oid, &oi, data->cb_data);
    ++	} else {
    ++		return data->cb(oid, NULL, data->cb_data);
    ++	}
     +}
     +
     +int packfile_store_for_each_object(struct packfile_store *store,
    -+				   struct object_info *oi,
    ++				   const struct object_info *request,
     +				   odb_for_each_object_cb cb,
     +				   void *cb_data,
     +				   unsigned flags)
     +{
     +	struct packfile_store_for_each_object_wrapper_data data = {
     +		.store = store,
    -+		.oi = oi,
    ++		.request = request,
     +		.cb = cb,
     +		.cb_data = cb_data,
     +	};
    @@ packfile.h: int for_each_object_in_pack(struct packed_git *p,
      
     +/*
     + * Iterate through all packed objects in the given packfile store and invoke
    -+ * the callback function for each of them. If given, the object info will be
    -+ * populated with the object's data as if you had called
    -+ * `packfile_store_read_object_info()` on the object.
    ++ * the callback function for each of them. If an object info request is given,
    ++ * then the object info will be read for every individual object and passed to
    ++ * the callback as if `packfile_store_read_object_info()` was called for the
    ++ * object.
     + *
     + * The flags parameter is a combination of `odb_for_each_object_flags`.
     + */
     +int packfile_store_for_each_object(struct packfile_store *store,
    -+				   struct object_info *oi,
    ++				   const struct object_info *request,
     +				   odb_for_each_object_cb cb,
     +				   void *cb_data,
     +				   unsigned flags);
 7:  f437198d7a !  7:  3ec85ee10f odb: introduce `odb_for_each_object()`
    @@ Commit message
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
    + ## object-file.h ##
    +@@ object-file.h: int for_each_loose_object(struct object_database *odb,
    + 
    + /*
    +  * Iterate through all loose objects in the given object database source and
    +- * invoke the callback function for each of them. If given, the object info
    +- * will be populated with the object's data as if you had called
    +- * `odb_source_loose_read_object_info()` on the object.
    ++ * invoke the callback function for each of them. If an object info request is
    ++ * given, then the object info will be read for every individual object and
    ++ * passed to the callback as if `odb_source_loose_read_object_info()` was
    ++ * called for the object.
    +  */
    + int odb_source_loose_for_each_object(struct odb_source *source,
    + 				     const struct object_info *request,
    +
      ## odb.c ##
     @@ odb.c: int odb_freshen_object(struct object_database *odb,
      	return 0;
      }
      
     +int odb_for_each_object(struct object_database *odb,
    -+			struct object_info *oi,
    ++			const struct object_info *request,
     +			odb_for_each_object_cb cb,
     +			void *cb_data,
     +			unsigned flags)
    @@ odb.c: int odb_freshen_object(struct object_database *odb,
     +			continue;
     +
     +		if (!(flags & ODB_FOR_EACH_OBJECT_PROMISOR_ONLY)) {
    -+			ret = odb_source_loose_for_each_object(source, oi, cb, cb_data, flags);
    ++			ret = odb_source_loose_for_each_object(source, request,
    ++							       cb, cb_data, flags);
     +			if (ret)
     +				return ret;
     +		}
     +
    -+		ret = packfile_store_for_each_object(source->packfiles, oi, cb, cb_data, flags);
    ++		ret = packfile_store_for_each_object(source->packfiles, request,
    ++						     cb, cb_data, flags);
     +		if (ret)
     +			return ret;
     +	}
    @@ odb.h: typedef int (*odb_for_each_object_cb)(const struct object_id *oid,
     + * Iterate through all objects contained in the object database. Note that
     + * objects may be iterated over multiple times in case they are either stored
     + * in different backends or in case they are stored in multiple sources.
    ++ * If an object info request is given, then the object info will be read and
    ++ * passed to the callback as if `odb_read_object_info()` was called for the
    ++ * object.
     + *
     + * Returning a non-zero error code from the callback function will cause
     + * iteration to abort. The error code will be propagated.
    @@ odb.h: typedef int (*odb_for_each_object_cb)(const struct object_id *oid,
     + * an arbitrary non-zero error code returned by the callback itself.
     + */
     +int odb_for_each_object(struct object_database *odb,
    -+			struct object_info *oi,
    ++			const struct object_info *request,
     +			odb_for_each_object_cb cb,
     +			void *cb_data,
     +			unsigned flags);
 8:  75c0e7fb54 !  8:  069bcb600b builtin/fsck: refactor to use `odb_for_each_object()`
    @@ Commit message
     
         Refactor these callsites accordingly.
     
    +    Note that `odb_for_each_object()` may iterate over the same object
    +    multiple times, for example when it exists both in packed and loose
    +    format. But this has already been the case beforehand, so this does not
    +    result in a change in behaviour.
    +
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## builtin/fsck.c ##
    @@ builtin/fsck.c: static int mark_used(struct object *obj, enum object_type type U
      
     -static void mark_unreachable_referents(const struct object_id *oid)
     +static int mark_unreachable_referents(const struct object_id *oid,
    -+				      struct object_info *io UNUSED,
    ++				      struct object_info *oi UNUSED,
     +				      void *data UNUSED)
      {
      	struct fsck_options options = FSCK_OPTIONS_DEFAULT;
 9:  5a1c71af5f =  9:  cb472da9d5 treewide: enumerate promisor objects via `odb_for_each_object()`
10:  b6dcd01b19 ! 10:  505243613c treewide: drop uses of `for_each_{loose,packed}_object()`
    @@ builtin/cat-file.c: static void batch_each_object(struct batch_options *opt,
     +	struct odb_source *source;
      
     -	for_each_loose_object(the_repository->objects, batch_one_object_loose, &payload, 0);
    ++	/*
    ++	 * TODO: we still need to tap into implementation details of the object
    ++	 * database sources. Ideally, we should extend `odb_for_each_object()`
    ++	 * to handle object filters itself so that we can move the filtering
    ++	 * logic into the individual sources.
    ++	 */
     +	odb_prepare_alternates(the_repository->objects);
     +	for (source = the_repository->objects->sources; source; source = source->next) {
     +		int ret = odb_source_loose_for_each_object(source, NULL, batch_one_object_oi,
11:  92a8225bca ! 11:  3dc547bb9d odb: introduce mtime fields for object info requests
    @@ Commit message
         to request an object's mtime. This new field will be used in a
         subsequent commit.
     
    +    Note that the concept of "mtime" is ambiguous: given an object, it may
    +    be stored multiple times in the object database, and each of these
    +    instances may have a different mtime. Disambiguating these mtimes is
    +    nothing that can happen on the generic ODB layer: the caller may search
    +    for the oldest object, the newest object, or even the relation of object
    +    mtimes depending on the specific source they are located in. As such, it
    +    is the responsibility of the caller to disambiguate mtimes.
    +
    +    A consequence of this is that it's most likely incorrect to look up the
    +    mtime via `odb_read_object_info()`, as this interface does not give us
    +    enough information to disambiguate the mtime. Document this accordingly
    +    and tell users to use `odb_for_each_object()` instead.
    +
    +    Even with this gotcha though it's sensible to have this request as part
    +    of the object info, as the mtime is a property of the object storage
    +    format. If we for example had a "black-box" storage backend, we'd still
    +    need to be able to query it for the mtime info in a generic way.
    +
    +    We could introduce a safety mechanism that for example calls `BUG()` in
    +    case we look up the mtime outside of `odb_for_each_object()`. But that
    +    feels somewhat heavy-handed.
    +
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## object-file.c ##
    @@ odb.c: static int do_oid_object_info_extended(struct object_database *odb,
     
      ## odb.h ##
     @@ odb.h: struct object_info {
    - 	off_t *disk_sizep;
      	struct object_id *delta_base_oid;
      	void **contentp;
    -+	time_t *mtimep;
      
    ++	/*
    ++	 * The time the given looked-up object has been last modified.
    ++	 *
    ++	 * Note: the mtime may be ambiguous in case the object exists multiple
    ++	 * times in the object database. It is thus _not_ recommended to use
    ++	 * this field outside of contexts where you would read every instance
    ++	 * of the object, like for example with `odb_for_each_object()`. As it
    ++	 * is impossible to say at the ODB level what the intent of the caller
    ++	 * is (e.g. whether to find the oldest or newest object), it is the
    ++	 * responsibility of the caller to disambiguate the mtimes.
    ++	 */
    ++	time_t *mtimep;
    ++
      	/* Response */
      	enum {
    + 		OI_CACHED,
     
      ## packfile.c ##
     @@ packfile.c: static void add_delta_base_cache(struct packed_git *p, off_t base_offset,
    @@ packfile.c: int packed_object_info(struct packed_git *p,
     +			uint32_t index_pos;
     +
     +			if (load_pack_mtimes(p) < 0)
    -+				die(_("could not load cruft pack .mtimes"));
    ++				die(_("could not load .mtimes for cruft pack '%s'"),
    ++				    pack_basename(p));
     +
     +			if (maybe_index_pos)
     +				index_pos = *maybe_index_pos;
    @@ packfile.c: int packed_object_info(struct packed_git *p,
      				    struct pack_window **w_curs,
      				    off_t curpos,
     @@ packfile.c: static int packfile_store_for_each_object_wrapper(const struct object_id *oid,
    - 	if (data->oi) {
      		off_t offset = nth_packed_object_offset(pack, index_pos);
    + 		struct object_info oi = *data->request;
      
    --		if (packed_object_info(pack, offset, data->oi) < 0) {
    +-		if (packed_object_info(pack, offset, &oi) < 0) {
     +		if (packed_object_info_with_index_pos(pack, offset,
    -+						      &index_pos, data->oi) < 0) {
    ++						      &index_pos, &oi) < 0) {
      			mark_bad_packed_object(pack, oid);
      			return -1;
      		}
12:  658cbf8f12 ! 12:  0047a40d16 builtin/pack-objects: use `packfile_store_for_each_object()`
    @@ builtin/pack-objects.c: static int add_object_in_unpacked_pack(const struct obje
     +		if (packfile_store_for_each_object(source->packfiles, &oi,
     +						   add_object_in_unpacked_pack, NULL,
     +						   ODB_FOR_EACH_OBJECT_PACK_ORDER |
    ++						   ODB_FOR_EACH_OBJECT_LOCAL_ONLY |
     +						   ODB_FOR_EACH_OBJECT_SKIP_IN_CORE_KEPT_PACKS |
     +						   ODB_FOR_EACH_OBJECT_SKIP_ON_DISK_KEPT_PACKS))
     +			die(_("cannot open pack index"));
13:  a28907a4b6 = 13:  c3bde2e822 reachable: convert to use `odb_for_each_object()`
14:  7d235b6529 ! 14:  bf2f3c39a6 odb: drop unused `for_each_{loose,packed}_object()` functions
    @@ object-file.c: int for_each_loose_file_in_source(struct odb_source *source,
     -
      struct for_each_object_wrapper_data {
      	struct odb_source *source;
    - 	struct object_info *oi;
    + 	const struct object_info *request;
     
      ## object-file.h ##
     @@ object-file.h: int for_each_loose_file_in_source(struct odb_source *source,
    @@ object-file.h: int for_each_loose_file_in_source(struct odb_source *source,
     -
      /*
       * Iterate through all loose objects in the given object database source and
    -  * invoke the callback function for each of them. If given, the object info
    +  * invoke the callback function for each of them. If an object info request is
     
      ## packfile.c ##
     @@ packfile.c: int for_each_object_in_pack(struct packed_git *p,
    @@ packfile.c: int for_each_object_in_pack(struct packed_git *p,
     -
      struct packfile_store_for_each_object_wrapper_data {
      	struct packfile_store *store;
    - 	struct object_info *oi;
    + 	const struct object_info *request;
     @@ packfile.c: int packfile_store_for_each_object(struct packfile_store *store,
      		.cb = cb,
      		.cb_data = cb_data,

---
base-commit: 1ff0e42d332523a11cc3d61b8d8463db5f9f14e8
change-id: 20260115-pks-odb-for-each-object-60b78cde09fd


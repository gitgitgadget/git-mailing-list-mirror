Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B645E353A7F
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 07:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785915899; cv=none; b=OBiAV57UlDAl0ry03M863xAAUmHByE2snZMNETpNk1R9+ugOkShNFYBkkp5lw5/tnHYrp8DdhKpQvJkPKVj/YCS5YMjf9IByTyTjhSnhpOjwDqszBFFwL/yceCk3q9hbrbvo0fmR1nObG4Vcndj4Wno8wSthVXhxP0XS6HU24fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785915899; c=relaxed/simple;
	bh=AmPfTS+3TDssDeq5Mizusa5JUm8aZyOMQXoTFQ2PaRU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=qGKU/JTGLGVOHdSZ9ghnkjabunEoZUaU0Jy4NTmMM35hq9HQweQ08jE08n5m2KCTzALJf8pv8o4BGtaEL9d7wFZa2hcWvk1IjM2LOmUhLLNlmpQFMj1lGRiG5owB/4x1lDL309gQtmNAm6GAs5wC1p4cfVaY3rgYC4UwS2woMJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ygc0Ftjk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Utd1VVK7; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ygc0Ftjk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Utd1VVK7"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 99156140010B;
	Wed,  5 Aug 2026 03:44:56 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 05 Aug 2026 03:44:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1785915896;
	 x=1786002296; bh=KFoCFJoOa8lHR7MZxEIu5y9X9CVUzXB06GYFXISjNa0=; b=
	Ygc0Ftjksw0k5zSlBPVN/+CUScsBfLxU4fV/hi0ac51KQNP2qxvUedxvYXRSpfUS
	psMzMvJH3NFjr8Hj5KsnKe1EVLtEko/kcR+X0I6WUvA6PobRU1hicPPckdibp+5Z
	6jN8FEILe7K6PJwp6DKWHQhdIM1VXEEell98C/rd51uhZsz7SULoX+XUY/xq9AT7
	LjL6pTxiOEw9fWHvIGyqbF8doNpx8NlNRkMYG+jlTozs26UmVn3qj1QniJUdk0L3
	jH0tXkzk/IX8eknGBv5ErxSao8dOxSCzPDhj/1uT4tWjeqkEgbaVuHJHYyH8jkKm
	5+TFivm2X+eMMR/+SK34Zg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785915896; x=
	1786002296; bh=KFoCFJoOa8lHR7MZxEIu5y9X9CVUzXB06GYFXISjNa0=; b=U
	td1VVK7nyE8v5yj1kED1wF5HUa6di4gCqIJXD2f2DtfIbNTCbrLV71glHoyVvMBJ
	qs7181v8TJ4VW1ET52kEXIx2PUt5nsY6HFIEWdcDcdBbPwUHMAxdki5L6SUTBnyx
	t+1yS2dpTFs2bITd7jzFWLhjfLS3Eo3c+U8lsmjZRqf/EKpYib+sYJaqvuM/2AUj
	5liMD+PVgT8yzT/flcAQRk4XkH2ix8XUfpizVdkwwlZCV7jkEeD8jJR0RLu/ciBN
	WCYR0cClm37EX4rygIzKv2bgKYxeax4xt8NHJrqo44BVimy6FP3OAA/j8faY2ekH
	5ZFblW/nITiQg2fe3Kwow==
X-ME-Sender: <xms:-OlyasrjwVKX5UhdrmtDC6_eRWVNGzecjHIN1EgI9sz8cayMci2uIg>
    <xme:-OlyaqFwP0vyah9f6WfnSyi1zLI5YqoEveC8LHTO_nFZHMYvXZ_THabTFszhReYnQ
    yOZZTV7nETWKctleX5Jbf-jxHnDNcYtfmGnPJ1pyOeOuZoMzCPHZw>
X-ME-Received: <xmr:-OlyaumiHbDf5tqY3XrKKz4bLhNZOgrss7Xt7n9RPWV_9Nks2sj7npTGe2WYWw2emOkCchddO0dRrPlJDiEHqjwVqfnvykmrb4kECGItjg>
X-ME-Proxy-Cause: dmFkZTFySYuY4jxq7h0RdfyYcGzb01hvbKZfNL5X11LIsROWjTCpkDvqQL5s6VFWbPogde
    J/9iv6LYvcL/Cr0FpYa5cffEoUvFPlYHvmaAAHW9xZeBTAhASQQpY3yl7rdv5txMCSU5j0
    hLIuo/WOuReYIg4ZTDVioFekp7+wfG3XaOWR5kWcs4lDFt2fTvpDQRMZrTXaBPjmEY01jZ
    7DLZs81qLGoWIKU4e/t6epRVhkbaOZD6LUzekTehC/kvjPiUYJoB0qKK2sW6DRL0AHAKeb
    L9AYpYLyCUvBEQG1S7GCTg0/WDTRkGpySPQazvVHG1ZdJKrL8FXPX8N1Aez4r67WuO+0oW
    cc4cOJOX7r2Hdhe/34FP5FNvCbQdIopTies88j87BYtzySBxl2YbhrWgY9HvY0nXBne1VO
    k2JrolUncbmR1K4N/YDMfOY1qE4/B3a0xTWnxX8PubhirY1xzn+o0R6+IEaM/n30XFDpvF
    NqQLfBWtUeeJnTxLPOS1STDso7LcNn4ts7hGvjGZg3TTKmHgjIzAYtxxTbpzxBJSo3MeVT
    kfJ5sfEaYjKtd3APjGkR45WbztUwrnbPO2Zy0eOVqsDIIVZMfZElSMuLgkCH7jNAfDaEhe
    MvTuadpKiEDEJMNFgmUAyuEwKl6nWSV080kUx9ZaWNnEBxYIyb7jh4tISz0Q
X-ME-Proxy: <xmx:-Olyatk2ksIZpysESHLXtjD7TLp-eIQTkjHQ3hBpZitlTKrb7emP5Q>
    <xmx:-OlyavvL9V0J0fnhGlsuWcEMdvW3aq-XhfNzX25xJCX4l7uZiEDgYg>
    <xmx:-Olyagnd4JYe1UYue2uB1eVvepwNUuKVrUV67ZuQDAe3TlgfUrDL-Q>
    <xmx:-Olyaqs8c0RlJUYm-bYqj8TvHMqC3IFUB_jwtf-_HIh2RV3fGF_dRw>
    <xmx:-OlyaiHOomWO7VY-aBVuGubyayTnBPLr1G41mzTrEn5vWrjIufig--YP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 03:44:55 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 62288dcf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 5 Aug 2026 07:44:53 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/8] odb: unify read and write streams
Date: Wed, 05 Aug 2026 09:44:44 +0200
Message-Id: <20260805-pks-odb-stream-unification-v2-0-b8c369564641@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32Nyw6CMBBFf4XM2jGlvBpX/odhUdpBRsMjbSEaw
 r9bYO/yJOeeu4Inx+ThlqzgaGHP4xBBXhIwnR6ehGwjgxSyFJXMcXp7HG2DPjjSPc4Dt2x0iDP
 MstwaqatCKQUxMDlq+XPEH/XJfm5eZMJe3I2OfRjd93hf0t07j5T4e7SkKFCVthKkZJYXdI/yl
 Xuot237Ab5c7DjTAAAA
X-Change-ID: 20260724-pks-odb-stream-unification-334dc2a75888
In-Reply-To: <20260804-pks-odb-stream-unification-v1-0-86d70e82345e@pks.im>
References: <20260804-pks-odb-stream-unification-v1-0-86d70e82345e@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

Hi,

we have two different kind of object database streams in our code base:
`odb_write_stream` and `odb_read_stream`. While those are used for
different use cases, the provided functionality is ultimately the exact
same.

This patch series thus refactors these streams so that we have a single
`odb_stream`, only. This allows us to reuse the streams for different
kinds of purposes and makes them more generally useful overall. For
example, it's trivially possible now to create an object stream for any
given object and then write that stream into a different source.

The series is built on top of 5b2471720c (The 10th batch, 2026-08-03).

Changes in v2:
  - Use the correct object type when hashing in-memory objects.
  - Remove a stale comment.
  - Adapt a commit message to mention that renames will follow in
    subsequent commits.
  - Add another commit to rename `struct input_zstream_data`.
  - Link to v1: https://patch.msgid.link/20260804-pks-odb-stream-unification-v1-0-86d70e82345e@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (8):
      odb/streaming: track write stream size in the structure
      odb/streaming: drop `is_finished` field
      odb/streaming: support streaming arbitrary object types
      odb/streaming: rename `struct odb_read_stream`
      odb/streaming: consolidate read and write streams
      odb/streaming: rename `struct read_object_fd_data`
      odb/streaming: rename `struct input_zstream_data`
      odb/streaming: unify function names to create new streams

 archive-tar.c                 |   8 ++--
 archive-zip.c                 |  12 ++---
 builtin/index-pack.c          |   8 ++--
 builtin/pack-objects.c        |  18 ++++----
 builtin/unpack-objects.c      |  44 ++++++++++--------
 object-file.c                 |  76 +++++++++++++++---------------
 object-file.h                 |   2 +-
 object.c                      |   6 +--
 odb.c                         |   4 +-
 odb.h                         |   4 +-
 odb/source-files.c            |   7 ++-
 odb/source-inmemory.c         |  35 ++++++++------
 odb/source-loose.c            |  33 ++++++++------
 odb/source-packed.c           |   5 +-
 odb/source.h                  |  13 +++---
 odb/streaming.c               | 104 ++++++++++++++++++++----------------------
 odb/streaming.h               |  69 ++++++++++------------------
 odb/transaction.c             |   6 +--
 odb/transaction.h             |   8 ++--
 pack-check.c                  |   4 +-
 packfile.c                    |   8 ++--
 packfile.h                    |   4 +-
 t/unit-tests/u-odb-inmemory.c |  37 ++++++++-------
 23 files changed, 251 insertions(+), 264 deletions(-)

Range-diff versus v1:

1:  0085df877f = 1:  1966710c12 odb/streaming: track write stream size in the structure
2:  5fbbfd9010 = 2:  87c7981a6c odb/streaming: drop `is_finished` field
3:  52e5b87761 ! 3:  9aede44fba odb/streaming: support streaming arbitrary object types
    @@ object-file.c: int index_fd(struct index_state *istate, struct object_id *oid,
     
      ## odb/source-inmemory.c ##
     @@ odb/source-inmemory.c: static int odb_source_inmemory_write_object_stream(struct odb_source *source,
    - 	hash_object_file(source->odb->repo->hash_algo, data, total_read, OBJ_BLOB, oid);
    + 		goto out;
    + 	}
    + 
    +-	hash_object_file(source->odb->repo->hash_algo, data, total_read, OBJ_BLOB, oid);
    ++	hash_object_file(source->odb->repo->hash_algo, data, total_read,
    ++			 stream->type, oid);
      
      	ret = odb_source_inmemory_write_object(source, data, stream->size,
     -					       OBJ_BLOB, oid, NULL, NULL, 0);
    @@ odb/streaming.h: int odb_stream_blob_to_fd(struct object_database *odb,
      
      #endif /* STREAMING_H */
     
    + ## odb/transaction.h ##
    +@@ odb/transaction.h: struct odb_transaction {
    + 
    + 	/*
    + 	 * This callback is expected to write the given object stream into
    +-	 * the ODB transaction. Note that for now, only blobs support streaming.
    ++	 * the ODB transaction.
    + 	 *
    + 	 * The resulting object ID shall be written into the out pointer. The
    + 	 * callback is expected to return 0 on success, a negative error code
    +
      ## t/unit-tests/u-odb-inmemory.c ##
     @@ t/unit-tests/u-odb-inmemory.c: void test_odb_inmemory__write_object_stream(void)
      	struct odb_source_inmemory *source = odb_source_inmemory_new(odb);
4:  f178d441f0 = 4:  ca84a2b645 odb/streaming: rename `struct odb_read_stream`
5:  0d72d27078 ! 5:  838394bffc odb/streaming: consolidate read and write streams
    @@ Commit message
         new `struct odb_stream` base. Other than that though, the changes are
         rather straight forward.
     
    +    Some of the structures and functions are now somewhat misnamed. These
    +    will be fixed in subsequent commits.
    +
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## builtin/unpack-objects.c ##
6:  ced59bdc85 = 6:  850b7e081d odb/streaming: rename `struct read_object_fd_data`
-:  ---------- > 7:  c3fe9f8b0c odb/streaming: rename `struct input_zstream_data`
7:  f76f4350ef = 8:  4df81651ba odb/streaming: unify function names to create new streams

---
base-commit: 5b2471720c93ee30e5764a19f3d3b3ae9ec9712a
change-id: 20260724-pks-odb-stream-unification-334dc2a75888


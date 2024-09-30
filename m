Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A42F1714A5
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 08:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727683695; cv=none; b=IdxXqQo08vbw2y8DMHt+b74LDdpOIOW5gCGHQ3eh5p1FGOPCgZzN3pGnst2yfdsMDpkqKs2jjpTd8wVZJEHfPG9aXAAtRNT3Nxc/l3fgleLjxemJc1KiOGqDuiRibyZRV04VwVSF3thRVaAhdOxc5a9pZSDgwfdup74w5gPRQTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727683695; c=relaxed/simple;
	bh=oCsmv4HiELW3JI2zaMob1YcTeBhlR4LtJWfLgn8idBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AtmkfAV2mrWalf63VukJObpZU3kkJvtYjltCYSvnX/AvwW9GsdIOCTxW+B4Yg2H2F9UkNu5LiM3xzI2qbgVt3eX4sCeKqZ50+1b6C8VFaGRzhMf9TzTaythndyWhFFpJW42Q9vQtbhDOh9cSG2vX+d6Kzv0QGrmurNrdHJbFgqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qGdyURtd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FKyhS3aP; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qGdyURtd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FKyhS3aP"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3B2B01140227;
	Mon, 30 Sep 2024 04:08:13 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 30 Sep 2024 04:08:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727683693; x=1727770093; bh=Wog0xgwC1m
	7H7PoBIzazasb0Ae+8Vh9ExJYaicCazaI=; b=qGdyURtdH3Tu7aBuuXFHk5tH2T
	Moo8JUX4oYHnkSYL1Ng/OEZTkBmy3OYdI5LNNOTZ85wwd+X/OENCz8IzGAlebj9h
	zhs4XUpSEMsn35ZUqTZEgVHZkGNLSYptwdwgiM9L9M1FeJy5UNsrmJkFAfY+fSta
	X3AYOB289t0d4tkr+LPQXHd2GB0p46EYQ6R0Eb+thKmXtjz9QvLZQqoVO7OpfOnD
	XdUIrTmGBJ1pKrmfauI+3mAAmn8526gQK0FuNPs+l8m7r7rhmCpzBlU+Q9o7ThFY
	PmFXymaWRdyUqChRaBRttXnGhWyRyE3YIq9N7xqj+ZFxpkVCM+/gp0icDHbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727683693; x=1727770093; bh=Wog0xgwC1m7H7PoBIzazasb0Ae+8
	Vh9ExJYaicCazaI=; b=FKyhS3aPO6fBfIFhxx4F+bjKUcD/N7HdGvGgFS5zEHjP
	IwU+ssy4Qgi2e+/+w9ewszqPsHVvmMOMzJP9cpvz6PjADwJUXN/hOCKAsi+chsY9
	yd7YdZL73bm1BszE62MkMvyhUKHvLLFgnbjlRvwX4mRGPqmsc3kvr1TJWCDAyZ1F
	2j6+gK0N8y1iAoSK/wtMp4UtoaD4u8pH2loGjrVyiyPhXIPGMnnSRQA5fXWDVIlR
	SJa9OTph3U4VWoLt1Ze2niY9gGucItMo5sV68lfZaSH9e8cK5qtyKSaacsD+KmqU
	hydZEhpUp43lqtBw9vyGTxs/KweuI6dni3M4sr9GtA==
X-ME-Sender: <xms:bFz6ZrfHeEBIhSZefcSY0lOWU-2SP1sDJGloEp7A-JvcULg2Es9ixw>
    <xme:bFz6ZhOPhQ1pNIYf7Qv7xba-XqQyxVnGpI07n4HNBH899WStxdHoTNA2wF0r0ky4e
    X8Jk8IXPdVlayg8uw>
X-ME-Received: <xmr:bFz6ZkhVTRcPKyc3bYyYVtMWlJ62G0GbrFlDeTlZWFPJP_6VVotn4dgkg2xleuBY0dPBXlY6SG_l1mLYYd_-BtFw79OnWxCupBqvAcsOmwenyrg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduhecutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffrtefo
    kffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsuc
    dlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhr
    ohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenuc
    ggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffh
    ueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvghthhhomhhsohhnsegvugif
    rghrughthhhomhhsohhnrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:bFz6Zs9rz7lYajlJTa8a0NLnvAjD2nhyrXaMHpVHj4FAGG7O0bOSLw>
    <xmx:bFz6ZnulRJlvYnPF9JySc6Y__n-1nkZze1I18Yp45lrXSamUD800yQ>
    <xmx:bFz6ZrGTMaeqx0wne-StjlEdfVDchHWu_q_8oASrKjy2TXAHGFc0Aw>
    <xmx:bFz6ZuN5ltLlEtA9J40PWGzfQblbo6fKrNveHuFRvpoZILvIU0ZqPw>
    <xmx:bVz6ZhJC2opmWEkmEN7bTF9x-4qBg-zGQ-fPhT_qvUP_a3I0rpDAoWLf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Sep 2024 04:08:11 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5a1fc8c3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 30 Sep 2024 08:07:25 +0000 (UTC)
Date: Mon, 30 Sep 2024 10:08:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v3 00/22] refatble: handle allocation errors
Message-ID: <cover.1727680272.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726489647.git.ps@pks.im>

Hi,

this is the third version of this patch series that converts the
reftable library to start handling allocation errors. This is done such
that the reftable library can truly behave like a library and let its
callers handle such conditions.

There is only a single change compared to v1, namely that we use
`reftable_free()` instead of `free()`.

Thanks!

Patrick

Patrick Steinhardt (22):
  reftable/error: introduce out-of-memory error code
  reftable/basics: merge "publicbasics" into "basics"
  reftable: introduce `reftable_strdup()`
  reftable/basics: handle allocation failures in `reftable_calloc()`
  reftable/basics: handle allocation failures in `parse_names()`
  reftable/record: handle allocation failures on copy
  reftable/record: handle allocation failures when decoding records
  reftable/writer: handle allocation failures in `writer_index_hash()`
  reftable/writer: handle allocation failures in `reftable_new_writer()`
  reftable/merged: handle allocation failures in
    `merged_table_init_iter()`
  reftable/reader: handle allocation failures for unindexed reader
  reftable/reader: handle allocation failures in `reader_init_iter()`
  reftable/stack: handle allocation failures on reload
  reftable/stack: handle allocation failures in `reftable_new_stack()`
  reftable/stack: handle allocation failures in `stack_compact_range()`
  reftable/stack: handle allocation failures in auto compaction
  reftable/iter: handle allocation failures when creating indexed table
    iter
  reftable/blocksource: handle allocation failures
  reftable/block: handle allocation failures
  reftable/pq: handle allocation failures when adding entries
  reftable/tree: handle allocation failures
  reftable: handle trivial allocation failures

 Makefile                            |   1 -
 refs/reftable-backend.c             |  39 ++++--
 reftable/basics.c                   |  92 ++++++++++++++-
 reftable/basics.h                   |  13 +-
 reftable/block.c                    |  23 +++-
 reftable/block.h                    |   4 +-
 reftable/blocksource.c              |  25 +++-
 reftable/error.c                    |   2 +
 reftable/iter.c                     |  20 +++-
 reftable/iter.h                     |   2 +-
 reftable/merged.c                   |  84 ++++++++-----
 reftable/merged.h                   |   6 +-
 reftable/pq.c                       |   7 +-
 reftable/pq.h                       |   2 +-
 reftable/publicbasics.c             |  66 -----------
 reftable/reader.c                   |  68 ++++++++---
 reftable/reader.h                   |   6 +-
 reftable/record.c                   | 164 +++++++++++++++++++-------
 reftable/record.h                   |   6 +-
 reftable/reftable-basics.h          |  18 +++
 reftable/reftable-error.h           |   3 +
 reftable/reftable-malloc.h          |  18 ---
 reftable/reftable-merged.h          |   8 +-
 reftable/reftable-reader.h          |   8 +-
 reftable/reftable-stack.h           |   8 +-
 reftable/reftable-writer.h          |  12 +-
 reftable/stack.c                    | 177 ++++++++++++++++++++++------
 reftable/tree.c                     |  42 +++++--
 reftable/tree.h                     |  21 +++-
 reftable/writer.c                   | 150 +++++++++++++++--------
 t/helper/test-reftable.c            |  10 +-
 t/unit-tests/lib-reftable.c         |   8 +-
 t/unit-tests/t-reftable-basics.c    |  11 +-
 t/unit-tests/t-reftable-block.c     |  24 ++--
 t/unit-tests/t-reftable-merged.c    |  16 ++-
 t/unit-tests/t-reftable-readwrite.c |  61 ++++++----
 t/unit-tests/t-reftable-stack.c     |   4 +-
 t/unit-tests/t-reftable-tree.c      |  10 +-
 38 files changed, 853 insertions(+), 386 deletions(-)
 delete mode 100644 reftable/publicbasics.c
 create mode 100644 reftable/reftable-basics.h
 delete mode 100644 reftable/reftable-malloc.h

Range-diff against v2:
 1:  8c99ecc325 =  1:  8c99ecc325 reftable/error: introduce out-of-memory error code
 2:  4dcdf1d48e =  2:  4dcdf1d48e reftable/basics: merge "publicbasics" into "basics"
 3:  21fa9b15d9 =  3:  21fa9b15d9 reftable: introduce `reftable_strdup()`
 4:  f6ad92ffd0 =  4:  f6ad92ffd0 reftable/basics: handle allocation failures in `reftable_calloc()`
 5:  ad028020df !  5:  922783708d reftable/basics: handle allocation failures in `parse_names()`
    @@ reftable/basics.c: void parse_names(char *buf, int size, char ***namesp)
     +
     +err:
     +	for (size_t i = 0; i < names_len; i++)
    -+		free(names[i]);
    -+	free(names);
    ++		reftable_free(names[i]);
    ++	reftable_free(names);
     +	return NULL;
      }
      
 6:  df713fbe08 =  6:  d4676e8a6a reftable/record: handle allocation failures on copy
 7:  870bb003c0 =  7:  874e6a1c20 reftable/record: handle allocation failures when decoding records
 8:  1d47e42500 =  8:  42bc57fd00 reftable/writer: handle allocation failures in `writer_index_hash()`
 9:  caa71f0a77 =  9:  9edd1d84cd reftable/writer: handle allocation failures in `reftable_new_writer()`
10:  a84e9cadae = 10:  d4004a7f43 reftable/merged: handle allocation failures in `merged_table_init_iter()`
11:  20d3833014 = 11:  b2bd142021 reftable/reader: handle allocation failures for unindexed reader
12:  e35c3a705d = 12:  9b5fd52862 reftable/reader: handle allocation failures in `reader_init_iter()`
13:  ca3b57f151 = 13:  0f3e3d1585 reftable/stack: handle allocation failures on reload
14:  7377421a63 = 14:  c88645a251 reftable/stack: handle allocation failures in `reftable_new_stack()`
15:  244e8667c5 = 15:  92ad4fc934 reftable/stack: handle allocation failures in `stack_compact_range()`
16:  99f4868c38 = 16:  19acebd919 reftable/stack: handle allocation failures in auto compaction
17:  271839a626 = 17:  620658bffc reftable/iter: handle allocation failures when creating indexed table iter
18:  c41808e9d7 = 18:  48047dd4c9 reftable/blocksource: handle allocation failures
19:  9348b0a457 = 19:  08685605ba reftable/block: handle allocation failures
20:  445daf9464 = 20:  a66937b7af reftable/pq: handle allocation failures when adding entries
21:  c31f9e53f5 = 21:  c291114553 reftable/tree: handle allocation failures
22:  d0fe999371 = 22:  20f50c446a reftable: handle trivial allocation failures
-- 
2.46.2.852.g229c0bf0e5.dirty


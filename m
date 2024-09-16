Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516844D8CC
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 08:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726476606; cv=none; b=L/LTqrkxw8eQFST+RaEoD8VpcnepwMapGJW5MN/Z3Og9NEdZ9IUY+tw0UCTG85vnPSST4KEUV0vafOQt0kWgGV0HjZJGOqLv6+HR2vHJ7KDqW8otfx/CFPLs4vglFFd+m6EUJeTNUB4odNImQKp/QNvbeBMNXtuxr59kY/HEmDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726476606; c=relaxed/simple;
	bh=0XPUDJiRAh+LqGZ0ixRT7GQwdZC4B86Aj2nVCC1VtcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S+nNPo9y942tkhAN3oHXB7W9ab41GzH5UJI5ZysCR2tL/WcxLv+WMD21hwJUnzhsv16Wnx4TksWjtKp5eQEEkmQ8Y/77B+Zq5zy9bR4db0E52NkbrBOOJ+O8cDjJB6rlYLBYf7hJe2pl4OiYpamyxqBpcayeCi3memqyePmF47g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XP8Y2d5+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UteDETAJ; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XP8Y2d5+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UteDETAJ"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 69F5A1140242;
	Mon, 16 Sep 2024 04:50:03 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 16 Sep 2024 04:50:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726476603; x=1726563003; bh=wgQZWnrxon
	v0LYYjijm15DjPEYD5fBG8Eg0XIgBuy4Y=; b=XP8Y2d5+e6yBkmozT/k7wcIEOi
	2585o9yKWj94t3Y8uLYCx6xLTifxp3U4+/Vy0C3YpYdPYIj9GkBUqa+2Kn7Ykwt7
	w1yvMKwpiStxmB/Y0PUMe9lyoLDxuNvKFbot00YxeZb4+ckl81bUfKM3XDsSLT4R
	UgEILe2Ap6Nu7ACf4+R/3xoF8E1O4apYlg/krv8vG7cDbfavt6f9RDCds2XHKAwH
	xc0KI1sOU6CvWz6ZqTyWAk/emfyjxMmin7cIxcE+QdpntiTfrwu7I4GzCsQ5TIZx
	o77rLJJE2DeN3iB2clxu/7A4OtM7MiKx9zwLNUTmxj6Slig7wW6UmN8eaDoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726476603; x=1726563003; bh=wgQZWnrxonv0LYYjijm15DjPEYD5
	fBG8Eg0XIgBuy4Y=; b=UteDETAJDyFmsK8i8KozYZIXGIj/5RXE3SxpHoZO5dZv
	5GQLHDdeBI23pGwI0d9pJxDwwKymSekYyqj+osS5DdK5WwJAeQKfBu6ASOduMp8Q
	QXr3F4NHEZuIVHNtZc+kZiW6ppeAw4C6NdUawrNvfWMBnUuuoD7Kylf2vHBGhEHR
	mBlyXdapwT7SI6IzPdIa3K/29mhot/qDpSp2p7BOjPVEjTZw2FN3VqmF/TCjCuZB
	wcdguoV9PgTGmGl0+YNlCTsQKcsoQauXoN8js4fUJehqD4Mpi2fSurf3hza5iNBs
	k09R3FSfYduLnZHER51qk4nWPnsk9Rc1vbrdCAJhvg==
X-ME-Sender: <xms:O_HnZpvyL_KZcA3qCRKY3_OHGcraqr3al8OqltB029qclXVjT56nvg>
    <xme:O_HnZieqO4vnWLhTPMr--vcLGImKbV4C9DJ0Hwi81RzWpmmwJ1NWHu0QxOe1JEXli
    S6HiLREs8KaNRPBRQ>
X-ME-Received: <xmr:O_HnZszUmojjGTMPNw4KeM49RxaOq_YkDHdcQ3w2Wm53LBm_6NhuiIEaeEcqT0ojW_cn1nsoP6YKnNrgqZ2K_SI6-7rVi7PNsymLmk0hGNI7yfUN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekhedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepkhgrrhhthhhi
    khdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:O_HnZgNPD566n_QX-tvNWr3DeUaTYpCt1N8dYdoTlUuWGjY8G8-sMw>
    <xmx:O_HnZp8aibqC19uh3Qh5D8WeBflHDX9yloaQ6a7tmncse2IHIUc3Tw>
    <xmx:O_HnZgXMxYc1V4ClGNSL4jru38vQTqUQgNdh5nLIuO3CdkClgLSqxg>
    <xmx:O_HnZqftvWFdFhb-gkeMn5U9sM7VaBndmFcFSUsPSdU06lTf6Kb_-w>
    <xmx:O_HnZkbNl9cy309TlJhb-aHtTD4SS-4SD9ZjDapYSfJa9grUzq2TRIw8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Sep 2024 04:50:02 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a45d270a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Sep 2024 08:49:44 +0000 (UTC)
Date: Mon, 16 Sep 2024 10:49:58 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, karthik nayak <karthik.188@gmail.com>
Subject: [PATCH v2 0/6] refs/reftable: wire up exclude patterns
Message-ID: <cover.1726476401.git.ps@pks.im>
References: <cover.1725881266.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1725881266.git.ps@pks.im>

Hi,

this is the second version of my patch series that fixes preexisting
bugs with exclude patterns and wires them up for the reftable backend.

Changes compared to v1:

  - Some typo fixes in commit messages.

  - Mention that the newly introduced function in patch 1 will be used
    in patch 2, which is why it's declared in "refs.h".

  - Use `check()` instead of `check_int(ret, ==, 0)`.

  - Sort exclude patterns lexicographically. This fixes a bug where we
    might not correctly skip over some refs when patterns are passed to
    the reftable backend in non-lexicographic order. Add a test for
    this.

Thanks!

Patrick

Patrick Steinhardt (6):
  refs: properly apply exclude patterns to namespaced refs
  builtin/receive-pack: fix exclude patterns when announcing refs
  Makefile: stop listing test library objects twice
  t/unit-tests: introduce reftable library
  reftable/reader: make table iterator reseekable
  refs/reftable: wire up support for exclude patterns

 Makefile                            |   8 +-
 builtin/receive-pack.c              |  18 ++-
 refs.c                              |  35 +++++-
 refs.h                              |   9 ++
 refs/reftable-backend.c             | 133 ++++++++++++++++++++++-
 reftable/reader.c                   |   1 +
 t/t1419-exclude-refs.sh             |  49 +++++++--
 t/t5509-fetch-push-namespaces.sh    |   9 ++
 t/unit-tests/lib-reftable.c         |  93 ++++++++++++++++
 t/unit-tests/lib-reftable.h         |  20 ++++
 t/unit-tests/t-reftable-merged.c    | 163 +++++++++++++++-------------
 t/unit-tests/t-reftable-reader.c    |  96 ++++++++++++++++
 t/unit-tests/t-reftable-readwrite.c | 130 +++++++---------------
 t/unit-tests/t-reftable-stack.c     |  25 ++---
 trace2.h                            |   1 +
 trace2/tr2_ctr.c                    |   5 +
 16 files changed, 594 insertions(+), 201 deletions(-)
 create mode 100644 t/unit-tests/lib-reftable.c
 create mode 100644 t/unit-tests/lib-reftable.h
 create mode 100644 t/unit-tests/t-reftable-reader.c

Range-diff against v1:
1:  8d347bc5599 ! 1:  7497166422e refs: properly apply exclude patterns to namespaced refs
    @@ Commit message
         to the non-stripped ones that still have the namespace prefix. In fact,
         the "transfer.hideRefs" machinery does the former and applies to the
         stripped reference by default, but rules can have "^" prefixed to switch
    -    this behaviour to iinstead match against the rull reference name.
    +    this behaviour to instead match against the full reference name.
     
         Namespaces are exclusively handled at the generic "refs" layer, the
         respective backends have no clue that such a thing even exists. This
    @@ Commit message
         refs in the tests, and then we indeed surface the breakage.
     
         Fix this bug by prefixing exclude patterns with the namespace in the
    -    generic layer.
    +    generic layer. The newly introduced function will be used outside of
    +    "refs.c" in the next patch, so we add a declaration to "refs.h".
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
2:  0317a5a7ede = 2:  3dc6ae936c8 builtin/receive-pack: fix exclude patterns when announcing refs
3:  503c44e6cab = 3:  4ba503520e6 Makefile: stop listing test library objects twice
4:  3df4040dd3c = 4:  6747076420f t/unit-tests: introduce reftable library
5:  a281f936a2b ! 5:  3278cdf92fe reftable/reader: make table iterator reseekable
    @@ t/unit-tests/t-reftable-reader.c (new)
     +	block_source_from_strbuf(&source, &buf);
     +
     +	ret = reftable_reader_new(&reader, &source, "name");
    -+	check_int(ret, ==, 0);
    ++	check(!ret);
     +
     +	reftable_reader_init_ref_iterator(reader, &it);
     +	ret = reftable_iterator_seek_ref(&it, "");
    -+	check_int(ret, ==, 0);
    ++	check(!ret);
     +	ret = reftable_iterator_next_ref(&it, &ref);
    -+	check_int(ret, ==, 0);
    ++	check(!ret);
     +
    -+	ret = reftable_ref_record_equal(&ref, &records[0], 20);
    ++	ret = reftable_ref_record_equal(&ref, &records[0], GIT_SHA1_RAWSZ);
     +	check_int(ret, ==, 1);
     +
     +	ret = reftable_iterator_next_ref(&it, &ref);
    @@ t/unit-tests/t-reftable-reader.c (new)
     +	block_source_from_strbuf(&source, &buf);
     +
     +	ret = reftable_reader_new(&reader, &source, "name");
    -+	check_int(ret, ==, 0);
    ++	check(!ret);
     +
     +	reftable_reader_init_ref_iterator(reader, &it);
     +
     +	for (size_t i = 0; i < 5; i++) {
     +		ret = reftable_iterator_seek_ref(&it, "");
    -+		check_int(ret, ==, 0);
    ++		check(!ret);
     +		ret = reftable_iterator_next_ref(&it, &ref);
    -+		check_int(ret, ==, 0);
    ++		check(!ret);
     +
     +		ret = reftable_ref_record_equal(&ref, &records[0], GIT_SHA1_RAWSZ);
     +		check_int(ret, ==, 1);
6:  f3922b81db6 ! 6:  050f4906393 refs/reftable: wire up support for exclude patterns
    @@ refs/reftable-backend.c: static struct ref_iterator_vtable reftable_ref_iterator
      	.abort = reftable_ref_iterator_abort
      };
      
    ++static int qsort_strcmp(const void *va, const void *vb)
    ++{
    ++	const char *a = *(const char **)va;
    ++	const char *b = *(const char **)vb;
    ++	return strcmp(a, b);
    ++}
    ++
     +static char **filter_exclude_patterns(const char **exclude_patterns)
     +{
     +	size_t filtered_size = 0, filtered_alloc = 0;
    @@ refs/reftable-backend.c: static struct ref_iterator_vtable reftable_ref_iterator
     +	}
     +
     +	if (filtered_size) {
    ++		QSORT(filtered, filtered_size, qsort_strcmp);
     +		ALLOC_GROW(filtered, filtered_size + 1, filtered_alloc);
     +		filtered[filtered_size++] = NULL;
     +	}
    @@ t/t1419-exclude-refs.sh: test_expect_success 'several overlapping excluded regio
     +		assert_jumps 3 perf;;
     +	*)
     +		BUG "unhandled ref format $GIT_DEFAULT_REF_FORMAT";;
    ++	esac
    ++'
    ++
    ++test_expect_success 'unordered excludes' '
    ++	for_each_ref__exclude refs/heads \
    ++		refs/heads/foo refs/heads/baz >actual 2>perf &&
    ++	for_each_ref refs/heads/bar refs/heads/quux >expect &&
    ++
    ++	test_cmp expect actual &&
    ++	case "$GIT_DEFAULT_REF_FORMAT" in
    ++	files)
    ++		assert_jumps 1 perf;;
    ++	reftable)
    ++		assert_jumps 2 perf;;
    ++	*)
    ++		BUG "unhandled ref format $GIT_DEFAULT_REF_FORMAT";;
     +	esac
      '
      
-- 
2.46.0.551.gc5ee8f2d1c.dirty


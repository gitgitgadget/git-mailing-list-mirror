Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7FC2DFA49
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 10:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744797750; cv=none; b=uDagFAJZp/MX8vPkMTmhiovrGBUY9iUuT5SfC3rWwml8hiimnZkvdAUuqeyEj+qA2kZv9xT/Tx6X9POy6W9413syLr1m3UTYWkcRoVaXrpuYgja+JeTAsD5VjByYFF3/b0VVKvT9jFmkklyYZiFTsXqTim2YCgZkh52GWtwNBHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744797750; c=relaxed/simple;
	bh=z78YEYUP66CSxgEQEkVjtsLkLMb4aIX4uqqOBHoHE+g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=j0xOGFv4yaSVrPU63vapXYdVCT8e6aHA8L7JgNRIUtDudYNHZ620Aw9UDkopN5H5+S6m2WPXUUgwa6dtKl+dWFkVpVj/3edWDXGzjfR1DyzrGzR6RbURUVNUoXIKmsRS5thmIzf2wGaCprHhDDy86hzNQ4JzOTGWTtBsLABCjgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=geycy/Je; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j40c+0rR; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="geycy/Je";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j40c+0rR"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E726711400FD;
	Wed, 16 Apr 2025 06:02:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 16 Apr 2025 06:02:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744797746;
	 x=1744884146; bh=1BUjyGrXwXRSnmIPHCy7PQaXFVBeR2SMhekMzV+u36A=; b=
	geycy/JeYvhJuygM8GJbMpEidHISiVX1iRZGwRGtPuFP9SUpjBEF+0DqAw9nlUQa
	fX3+3z0WKqwxL40TgJ8+/kb6UANfmTeTJ8vxry4Sk5M6gxLeYLIBzhYjA70Mx2Q5
	LEsRHKiZTmQeb6YLHba2fxOkqm72bLJT9mRCmlfIpmnnTsBVLBRuFoTa5gHEGeVz
	Ye5Ui5uVh305REyIr8HDvlQh9v/uIdk5v2lJo3eSCN70xsSHAfC7hNR+Li3YusGY
	bbYsLX8oRM5vg/CEvqyH4KQMCkHqamfTeIRDhpLzetqRdYNZmLteub3CrRKGGsAp
	a6hDIS/OHNH5SwjLUT2/Jg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744797746; x=
	1744884146; bh=1BUjyGrXwXRSnmIPHCy7PQaXFVBeR2SMhekMzV+u36A=; b=j
	40c+0rRDaqUR+F8LDDAu23b+K8kn7gYSttzJVbxpkG0iWzrd3RSbSGTr5TORdUhn
	bWO7aOQG0AHZO69vbiBkY0fL3NSsa01s5X3XQBLWjJ03YXNW0YMA+X2mYZUQ/Vq1
	l81ftGT56VKYTpmS18e74oiV0myydsadtpaLlI+50GBxAOfEhtBg3ey2BA3913fX
	c7076ligsjvRxP/c9cXY6AoEogh7F3dxX3MP5nbYTq1IBlKwdoBDOcuAxEIJ30oR
	/B8f/bv2iM7mhUy1JywPcBAjrt3Do2jXMOx9y0mY+WgSAm+wgVzSYe9bdUB0QaY3
	HZwnOPAjhrFPkk6KC6cew==
X-ME-Sender: <xms:MoD_Zy8XJEBF3o7rPRES62T2neTRJX75d-Aag_Sxu6JauMh4Nzilwg>
    <xme:MoD_Zys1fCVkETGmRl1iZgGvmaAtWjYuWuko6e4oahzBrhAQwNEq4ipjwowFXHcZs
    qKD1iAfYkHFq8OT-Q>
X-ME-Received: <xmr:MoD_Z4Cdq9KXr8D_Tq0gAPnm4tGIaBSqZOh9Qt9WaP0nPxKwYA0QKuEXoFwNd0CUx13GAZP9hONaffip9HcLrFDlVWfshFbkp9V3cLeahXtnQA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdeitdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffufffkgggtgfgjfhfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeetueeuhefhhfeitdeuhedttdeikeeftdduhedt
    heefhfegffevgeegtdfhheeuvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhs
    rdhimhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehglhgruhgsihhtiiesphhhhihs
    ihhkrdhfuhdqsggvrhhlihhnrdguvgdprhgtphhtthhopehtmhiisehpohgsohigrdgtoh
    hmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdp
    rhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehlrdhsrd
    hrseifvggsrdguvgdprhgtphhtthhopehsiigvuggvrhdruggvvhesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:MoD_Z6d7dlnSPqatHqBctp63lXaZGBpMUkOlzEmMgFf8PBRGm49oiw>
    <xmx:MoD_Z3N0wpZwyBNnCnF77sG8FOKa2lEWFmI1RsPDmGSaj5acVF_3wQ>
    <xmx:MoD_Z0mDVXrrvkQnaDh4In-76F6UC0ROBCa2DT_xk_rottg5ixONUQ>
    <xmx:MoD_Z5sNRrL5r1IDKojUiCRo2UghJg70POIlgFjcSiFVDgx3xR1iIw>
    <xmx:MoD_Z0iT4KK0p800LFzHa2QSzC47yPvY5lWcVuwXyGWIOGBIpcR6aCgf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Apr 2025 06:02:25 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b5b28eee (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 16 Apr 2025 10:02:22 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 0/7] parse-options: harden handling of integer values
Date: Wed, 16 Apr 2025 12:02:09 +0200
Message-Id: <20250416-b4-pks-parse-options-integers-v3-0-d390746bea79@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACGA/2cC/43NTQ6CMBCG4auYrh0zU4p/K+9hXLRlgIkRmpYQD
 eHuFhbGnS7fyZdnJpU4Cid13kwq8ihJ+i5Hsd0o39quYZAqt9KoSzRI4AyEe4JgY2Low5D3CaQ
 buOGY4OSMc77WhEQqGyFyLc/Vv95yt5KGPr7WdyMt13/lkQDB7vXRVgZ94cwlj3fyUAs76i+Ky
 l+UzpRnPBhDlmqkDzXP8xus/ZpoEgEAAA==
X-Change-ID: 20250401-b4-pks-parse-options-integers-9b4bbcf21011
In-Reply-To: <20250401-b4-pks-parse-options-integers-v1-0-a628ad40c3b4@pks.im>
References: <20250401-b4-pks-parse-options-integers-v1-0-a628ad40c3b4@pks.im>
To: git@vger.kernel.org
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Todd Zullinger <tmz@pobox.com>, 
 =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>, 
 Phillip Wood <phillip.wood123@gmail.com>
X-Mailer: b4 0.14.2

Hi,

this patch series addresses the issues raised in [1] and [2]. As
discussed in [1], the series also introduces a couple of safeguards to
make it harder to misuse `OPT_INTEGER()` and `OPT_MAGNITUDE()`:

  - We now track the precision of the underlying integer types. This
    makes it possible to pass arbitrarily-sized integers to those
    options, not only `int` and `unsigned long`, respectively.

  - We introduce a build assert to verify that the passed variable has
    correct signedness.

Furthermore, the series introduces `OPT_UNSIGNED()` to adapt all
callsites that previously used variables with the wrong signedness.

Changes in v2:
  - Adapt computation of upper bounds to use similar logic to
    `maximum_signed_value_of_type()`.
  - Link to v1: https://lore.kernel.org/r/20250401-b4-pks-parse-options-integers-v1-0-a628ad40c3b4@pks.im

Changes in v3:
  - Introduce `errno` checks for `strto{u,i}max()`.
  - Note that the precision is in bytes.
  - Reject leading '-' when parsing unsigned integers.
  - Introduce bounded integer options. This patch is mostly a proof of
    concept that demonstrates that precision and ranges are orthogonal
    to one another, so I consider it to be an optional patch. It may be
    useful in the future, but I haven't converted any callsites to use
    bounds yet.
  - Link to v2: https://lore.kernel.org/r/20250415-b4-pks-parse-options-integers-v2-0-ce07441a1f01@pks.im

Thanks!

Patrick

[1]: <89257ab82cd60d135cce02d51eacee7ec35c1c37.camel@physik.fu-berlin.de>
[2]: <Z8HW6petWuMRWSXf@teonanacatl.net>

---
Patrick Steinhardt (7):
      global: use designated initializers for options
      parse-options: check for overflow when parsing integers
      parse-options: introduce precision handling for `OPTION_INTEGER`
      parse-options: introduce precision handling for `OPTION_MAGNITUDE`
      parse-options: introduce `OPTION_UNSIGNED`
      parse-options: detect mismatches in integer signedness
      parse-options: introduce bounded integer options

 apply.c                       |   4 +-
 archive.c                     |  35 ++++++---
 builtin/am.c                  |  28 +++++--
 builtin/backfill.c            |   4 +-
 builtin/clone.c               |  13 +++-
 builtin/column.c              |   2 +-
 builtin/commit-tree.c         |  12 ++-
 builtin/commit.c              |  62 +++++++++++----
 builtin/config.c              |  13 +++-
 builtin/describe.c            |  24 ++++--
 builtin/fetch.c               |  10 ++-
 builtin/fmt-merge-msg.c       |  27 +++++--
 builtin/gc.c                  |  12 ++-
 builtin/grep.c                |  18 +++--
 builtin/init-db.c             |  13 +++-
 builtin/ls-remote.c           |  11 ++-
 builtin/merge.c               |  38 +++++++--
 builtin/read-tree.c           |  11 ++-
 builtin/rebase.c              |  25 ++++--
 builtin/revert.c              |  12 ++-
 builtin/show-branch.c         |  13 +++-
 builtin/tag.c                 |  24 ++++--
 builtin/update-index.c        | 131 +++++++++++++++++++++----------
 builtin/write-tree.c          |  12 ++-
 diff.c                        |  13 +++-
 git-compat-util.h             |   7 ++
 parse-options.c               | 176 +++++++++++++++++++++++++++++++++++++-----
 parse-options.h               |  75 +++++++++++++++++-
 ref-filter.h                  |  15 ++--
 t/helper/test-parse-options.c |  51 ++++++++++--
 t/t0040-parse-options.sh      | 102 +++++++++++++++++++++++-
 31 files changed, 805 insertions(+), 188 deletions(-)

Range-diff versus v2:

1:  80c8b943e9b = 1:  3dc362ae91b global: use designated initializers for options
-:  ----------- > 2:  a5a71ad6da8 parse-options: check for overflow when parsing integers
2:  307eaeb463c ! 3:  1ad133c639e parse-options: introduce precision handling for `OPTION_INTEGER`
    @@ parse-options.c: static enum parse_opt_result do_get_value(struct parse_opt_ctx_
     +		} else if (!*arg) {
      			return error(_("%s expects a numerical value"),
      				     optname(opt, flags));
    --		*(int *)opt->value = strtol(arg, (char **)&s, 10);
    --		if (*s)
    --			return error(_("%s expects a numerical value"),
    --				     optname(opt, flags));
    --		return 0;
     +		} else {
    ++			errno = 0;
     +			value = strtoimax(arg, (char **)&s, 10);
     +			if (*s)
     +				return error(_("%s expects a numerical value"),
     +					     optname(opt, flags));
    -+
    ++			if (errno == ERANGE)
    ++				return error(_("value %s for %s not in range [%"PRIdMAX",%"PRIdMAX"]"),
    ++					     arg, optname(opt, flags), lower_bound, upper_bound);
    ++			if (errno)
    ++				return error_errno(_("value %s for %s cannot be parsed"),
    ++						   arg, optname(opt, flags));
     +		}
      
    +-		errno = 0;
    +-		*(int *)opt->value = strtol(arg, (char **)&s, 10);
    +-		if (*s)
    +-			return error(_("%s expects a numerical value"),
    +-				     optname(opt, flags));
    +-		if (errno == ERANGE)
     +		if (value < lower_bound || value > upper_bound)
    -+			return error(_("value %"PRIdMAX" for %s not in range [%"PRIdMAX",%"PRIdMAX"]"),
    -+				     value, optname(opt, flags), lower_bound, upper_bound);
    -+
    + 			return error(_("value %s for %s not in range [%"PRIdMAX",%"PRIdMAX"]"),
    +-				     arg, optname(opt, flags), (intmax_t)LONG_MIN, (intmax_t)LONG_MAX);
    +-		if (errno)
    +-			return error_errno(_("value %s for %s cannot be parsed"),
    +-					   arg, optname(opt, flags));
    ++				     arg, optname(opt, flags), lower_bound, upper_bound);
    + 
    +-		return 0;
     +		switch (opt->precision) {
     +		case 1:
     +			*(int8_t *)opt->value = value;
    @@ parse-options.h: typedef int parse_opt_subcommand_fn(int argc, const char **argv
       *   stores pointers to the values to be filled.
       *
     + * `precision`::
    -+ *   precision of the integer pointed to by `value`. Should typically be its
    -+ *   `sizeof()`.
    ++ *   precision of the integer pointed to by `value` in number of bytes. Should
    ++ *   typically be its `sizeof()`.
     + *
       * `argh`::
       *   token to explain the kind of argument this option wants. Does not
    @@ t/t0040-parse-options.sh: test_expect_success 'OPT_NUMBER_CALLBACK() works' '
      magnitude: 0
      timestamp: 0
      string: (not set)
    -@@ t/t0040-parse-options.sh: test_expect_success 'magnitude with units but no numbers' '
    +@@ t/t0040-parse-options.sh: test_expect_success 'overflowing integer' '
      	test_must_be_empty out
      '
      
3:  5bfb9af2262 ! 4:  01e56b43c77 parse-options: introduce precision handling for `OPTION_MAGNITUDE`
    @@ Commit message
     
      ## parse-options.c ##
     @@ parse-options.c: static enum parse_opt_result do_get_value(struct parse_opt_ctx_t *p,
    + 
    + 		if (value < lower_bound || value > upper_bound)
    + 			return error(_("value %s for %s not in range [%"PRIdMAX",%"PRIdMAX"]"),
    +-				     arg, optname(opt, flags), lower_bound, upper_bound);
    ++				     arg, optname(opt, flags), (intmax_t)lower_bound, (intmax_t)upper_bound);
    + 
    + 		switch (opt->precision) {
    + 		case 1:
    +@@ parse-options.c: static enum parse_opt_result do_get_value(struct parse_opt_ctx_t *p,
      		}
      	}
      	case OPTION_MAGNITUDE:
    @@ parse-options.c: static enum parse_opt_result do_get_value(struct parse_opt_ctx_
     +		}
     +
     +		if (value > upper_bound)
    -+			return error(_("value %"PRIuMAX" for %s exceeds %"PRIuMAX),
    -+				     (uintmax_t) value, optname(opt, flags), upper_bound);
    ++			return error(_("value %s for %s not in range [%"PRIuMAX",%"PRIuMAX"]"),
    ++				     arg, optname(opt, flags), (uintmax_t)0, (uintmax_t)upper_bound);
     +
     +		switch (opt->precision) {
     +		case 1:
    @@ t/t0040-parse-options.sh: test_expect_success 'i16 limits range' '
     +	test-tool parse-options --m16 65535 >out &&
     +	test_grep "m16: 65535" out &&
     +	test_must_fail test-tool parse-options --m16 65536 2>err &&
    -+	test_grep "value 65536 for option .m16. exceeds 65535" err
    ++	test_grep "value 65536 for option .m16. not in range \[0,65535\]" err
     +'
     +
      test_done
4:  75ff495b897 ! 5:  e7458eadea9 parse-options: introduce `OPTION_UNSIGNED`
    @@ Commit message
         parse-options: introduce `OPTION_UNSIGNED`
     
         We have two generic ways to parse integers in the "parse-options"
    -    subsytem:
    +    subsystem:
     
           - `OPTION_INTEGER` parses a signed integer.
     
    @@ parse-options.c: static enum parse_opt_result do_get_value(struct parse_opt_ctx_
     +		} else if (!*arg) {
     +			return error(_("%s expects a numerical value"),
     +				     optname(opt, flags));
    ++		} else if (*arg == '-') {
    ++			return error(_("%s does not accept negative values"),
    ++				     optname(opt, flags));
     +		} else {
    ++			errno = 0;
     +			value = strtoumax(arg, (char **)&s, 10);
     +			if (*s)
     +				return error(_("%s expects a numerical value"),
     +					     optname(opt, flags));
    ++			if (errno == ERANGE)
    ++				return error(_("value %s for %s not in range [%"PRIuMAX",%"PRIuMAX"]"),
    ++					     arg, optname(opt, flags), (uintmax_t)0, (uintmax_t)upper_bound);
    ++			if (errno)
    ++				return error_errno(_("value %s for %s cannot be parsed"),
    ++						   arg, optname(opt, flags));
    ++
     +		}
     +
     +		if (value > upper_bound)
    -+			return error(_("value %"PRIuMAX" for %s exceeds %"PRIuMAX),
    -+				     value, optname(opt, flags), upper_bound);
    ++			return error(_("value %s for %s not in range [%"PRIuMAX",%"PRIuMAX"]"),
    ++				     arg, optname(opt, flags), (uintmax_t)0, (uintmax_t)upper_bound);
     +
     +		switch (opt->precision) {
     +		case 1:
    -+			*(int8_t *)opt->value = value;
    ++			*(uint8_t *)opt->value = value;
     +			return 0;
     +		case 2:
    -+			*(int16_t *)opt->value = value;
    ++			*(uint16_t *)opt->value = value;
     +			return 0;
     +		case 4:
    -+			*(int32_t *)opt->value = value;
    ++			*(uint32_t *)opt->value = value;
     +			return 0;
     +		case 8:
    -+			*(int64_t *)opt->value = value;
    ++			*(uint64_t *)opt->value = value;
     +			return 0;
     +		default:
     +			BUG("invalid precision for option %s",
    @@ t/t0040-parse-options.sh: cat >expect <<\EOF
      m16: 0
      timestamp: 0
     @@ t/t0040-parse-options.sh: test_expect_success 'm16 limits range' '
    - 	test_grep "value 65536 for option .m16. exceeds 65535" err
    + 	test_grep "value 65536 for option .m16. not in range \[0,65535\]" err
      '
      
     +test_expect_success 'u16 limits range' '
     +	test-tool parse-options --u16 65535 >out &&
     +	test_grep "u16: 65535" out &&
     +	test_must_fail test-tool parse-options --u16 65536 2>err &&
    -+	test_grep "value 65536 for option .u16. exceeds 65535" err
    ++	test_grep "value 65536 for option .u16. not in range \[0,65535\]" err
    ++'
    ++
    ++test_expect_success 'u16 does not accept negative value' '
    ++	test_must_fail test-tool parse-options --u16 -1 >out 2>err &&
    ++	test_grep "option .u16. does not accept negative values" err &&
    ++	test_must_be_empty out
     +'
     +
      test_done
5:  20ab753baef = 6:  5b05451c346 parse-options: detect mismatches in integer signedness
-:  ----------- > 7:  7115a7a31aa parse-options: introduce bounded integer options

---
base-commit: 5b97a56fa0e7d580dc8865b73107407c9b3f0eff
change-id: 20250401-b4-pks-parse-options-integers-9b4bbcf21011


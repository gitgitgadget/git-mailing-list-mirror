Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E727E22FF21
	for <git@vger.kernel.org>; Thu, 17 Apr 2025 10:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744886992; cv=none; b=fGkYEUfztxbScQ2NyHAINgAgsy5hhyIyZnxFuLIGKzpur/IMAdFzUUzXu2tcg7KWH1ANiTFtt3gcWEWM3ZCIxwhInuRw8FgfNQH3kzu/rmqvdEA8qoodijTedZdOWbt9eg0vUa0JtcCmHv+GNL4NU/vEqcVuEhwsqneo9AiTjNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744886992; c=relaxed/simple;
	bh=V8zXrXVswCjIT3NgyrA1xog6p5n2Kv9Wg3tTy51Dt9w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=o5oLatONf3OUEiPuFX3e3LEDZ4SOYFEtsB4/jVAppme8r9g+kHfKW8RqXSA36VCFHnQbHbogoiKBqca5c3wqVpncgOeCu7F3ScG6+xxuJIpF8xmID1zfrmctA3C4n6gv4Emeg8YRphUSfXwKpCbRNiLybEstHQOvVlExSDOEbKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=l+/alJIV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iYEJXvRl; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="l+/alJIV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iYEJXvRl"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CAFD725401FE;
	Thu, 17 Apr 2025 06:49:47 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 17 Apr 2025 06:49:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744886987;
	 x=1744973387; bh=kIyvAsnIVq81yiuextB1ktpev+pR+KF9Qkr+quCySFY=; b=
	l+/alJIVRqvNAbK7twxpCNC+kMSn/+EkV7P3OX7G0/vn4uEa0cFFj20e8G+1bkPZ
	tpNOLgBWsWLnLXXeVnUm0tpulCjksDuvEwqfRg82cb6IvrAfpc+STXXKkAWp8JNn
	QTs1+mGUHLjSuxW7QoztcmOQSlFIWdacYj3K47rSVVoXV0AzmYwzUAPViOpk03UZ
	3dcA9vDH+YJsuot4B62k10d/k8tMgfywHvjXo4YbIT+zmKen9tiWldHvYVi3nhob
	GtkG9akWdn7veKN4B/YCr47du1Dp+JJUYfW5bkMXsj/g1d0FH6VDztZaOi4PpZu0
	AvpG6qr7asJS3qmm/w5rZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744886987; x=
	1744973387; bh=kIyvAsnIVq81yiuextB1ktpev+pR+KF9Qkr+quCySFY=; b=i
	YEJXvRlAZDQKzVJWWUAkVG0k4k4ZzNHHC8gbuvJ/+7HjwsZi+FHq8DAQC3MgwN6t
	l4wfXauygq3ngMxgrD7QR/vvXp3U1qV+ET3DP31QOCHdGLe6YMXrShIV9aW/sRll
	nTBpmcSkVhoaFgKDZ0SaP3A3+wOdfXBXoHgXfNgc5G+o7KggCGOWUzYo09ka9v+i
	AT6gAQlKX0rLnNrgnrZBdQCjg735PCvh2IngS5/tzsEORR9ihIK103mEBTUj5WDw
	hnb3y/Fa5Gn/mnK3+AK/vTCLVBNGjhKu6Nz+D0nzQIMA3U8GYnp6qdW+oADHEftx
	fRP+V2m+BCYdKCF3frc9A==
X-ME-Sender: <xms:y9wAaLvY78uFCYJrvA7_tOWw1TEPuoyNRnOQMAsRmBFIcZBcrFeZCw>
    <xme:y9wAaMdlMZC0F_ImGA9FJ2IhY6PQTZj_un3vLc1fEKIFtYR_23hEgSgsCykg9JYnK
    lzU6GpNPRTFUrmW7A>
X-ME-Received: <xmr:y9wAaOx3TSP-w7de2E9qNjiErq9Ln9F6ICO6WpV09ewpblfLHgJFfEtPwgaBPpARkhMWP56njo974PQNJ_zlXQoZj6RtYCToUx-njAtPEtzu5sXA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdeltdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffufffkgggtgfgjfhfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeetueeuhefhhfeitdeuhedttdeikeeftdduhedt
    heefhfegffevgeegtdfhheeuvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhs
    rdhimhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhlrghusghithiisehp
    hhihshhikhdrfhhuqdgsvghrlhhinhdruggvpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehtmhiisehpohgsohigrdgtohhmpdhrtghp
    thhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepphgvfhhfsehpvghffhdrnh
    gvthdprhgtphhtthhopehsiigvuggvrhdruggvvhesghhmrghilhdrtghomhdprhgtphht
    thhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:y9wAaKODLRxErym2MOFYqMoq1hl5C2D_KxQ_v2qug9W2I7NilBedjQ>
    <xmx:y9wAaL9CLdTTs6zhlvfnImdqimb69HpNpEDGElSWfRHYdK3DtWXTNQ>
    <xmx:y9wAaKWhN6wfbVg_nS0eg9IyZMb991oP7GzWnfOWxgMr1pTGZEcWJw>
    <xmx:y9wAaMeio9sLtLRXF6vrRJq8yVqJ4zLCYWwM49rvbflIl7govwpfyQ>
    <xmx:y9wAaNRxaF55SOMknBHDfq5cYl7eWGr8soCSXrkxoME2_yCc3sfgbq_o>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Apr 2025 06:49:46 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 537f5314 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 17 Apr 2025 10:49:40 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 0/7] parse-options: harden handling of integer values
Date: Thu, 17 Apr 2025 12:49:35 +0200
Message-Id: <20250417-b4-pks-parse-options-integers-v4-0-9cbc76b61cfe@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL/cAGgC/43NQQ6CMBCF4auYrh3TKQXElfcwLloYoDFC0xKiI
 dzdgYXBFS7/ycs3k4gUHEVxOUwi0Oii6zsOfTyIsjVdQ+AqbqGkSqWWCFaDf0TwJkSC3g+8j+C
 6gRoKEQqrrS1rhRJRsOED1e61+rc7d+vi0If3+m7E5fqvPCJIMJk6m0rLMrH6yuOTe4qFHdWGw
 nSPUkyVJHOt0WAt8YdKtlS2RyVMVUnBVmbJ5MWXmuf5A17Ylm5dAQAA
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

Changes in v4:
  - Adapt `OPTION_INTEGER()` to also accept unit factors. Like this, we
    can avoid introducing `OPTION_UNSIGNED()` because now the behaviour
    of `OPTION_INTEGER()` and `OPTION_MAGNITUDE()` are the same, except
    of course the signedness.
  - Rename `OPTION_MAGNITUDE()` to clarify this new world order, as the
    main difference isn't unit factors anymore but only the signedness.
  - Drop the PoC patch that introduces bounded integer options.
  - Fix an off-by-one error for the lower boundary in
    `git_parse_signed()`.
  - Link to v3: https://lore.kernel.org/r/20250416-b4-pks-parse-options-integers-v3-0-d390746bea79@pks.im

Thanks!

Patrick

[1]: <89257ab82cd60d135cce02d51eacee7ec35c1c37.camel@physik.fu-berlin.de>
[2]: <Z8HW6petWuMRWSXf@teonanacatl.net>

---
Patrick Steinhardt (7):
      parse: fix off-by-one for minimum signed values
      global: use designated initializers for options
      parse-options: support unit factors in `OPT_INTEGER()`
      parse-options: rename `OPT_MAGNITUDE()` to `OPT_UNSIGNED()`
      parse-options: introduce precision handling for `OPTION_INTEGER`
      parse-options: introduce precision handling for `OPTION_UNSIGNED`
      parse-options: detect mismatches in integer signedness

 Documentation/technical/api-parse-options.adoc |  10 +-
 apply.c                                        |   4 +-
 archive.c                                      |  35 +++++--
 builtin/am.c                                   |  28 ++++--
 builtin/backfill.c                             |   4 +-
 builtin/clone.c                                |  13 ++-
 builtin/column.c                               |   2 +-
 builtin/commit-tree.c                          |  12 ++-
 builtin/commit.c                               |  62 +++++++++---
 builtin/config.c                               |  13 ++-
 builtin/describe.c                             |  24 +++--
 builtin/fetch.c                                |  10 +-
 builtin/fmt-merge-msg.c                        |  27 +++--
 builtin/gc.c                                   |  16 ++-
 builtin/grep.c                                 |  18 ++--
 builtin/init-db.c                              |  13 ++-
 builtin/ls-remote.c                            |  11 ++-
 builtin/merge.c                                |  38 +++++--
 builtin/multi-pack-index.c                     |   2 +-
 builtin/pack-objects.c                         |   8 +-
 builtin/read-tree.c                            |  11 ++-
 builtin/rebase.c                               |  25 +++--
 builtin/repack.c                               |   8 +-
 builtin/revert.c                               |  12 ++-
 builtin/show-branch.c                          |  13 ++-
 builtin/tag.c                                  |  24 +++--
 builtin/update-index.c                         | 131 +++++++++++++++++--------
 builtin/write-tree.c                           |  12 ++-
 diff.c                                         |  13 ++-
 git-compat-util.h                              |   7 ++
 parse-options.c                                | 102 ++++++++++++++-----
 parse-options.h                                |  17 +++-
 parse.c                                        |   4 +-
 parse.h                                        |   1 +
 ref-filter.h                                   |  15 ++-
 t/helper/test-parse-options.c                  |  50 +++++++---
 t/t0040-parse-options.sh                       |  93 +++++++++++++-----
 37 files changed, 646 insertions(+), 242 deletions(-)

Range-diff versus v3:

-:  ----------- > 1:  99a003e994b parse: fix off-by-one for minimum signed values
1:  7a3f09bbbbd = 2:  014d716fe08 global: use designated initializers for options
2:  526a1a2f2c4 < -:  ----------- parse-options: check for overflow when parsing integers
-:  ----------- > 3:  e3644d6825c parse-options: support unit factors in `OPT_INTEGER()`
-:  ----------- > 4:  5c10f8d5866 parse-options: rename `OPT_MAGNITUDE()` to `OPT_UNSIGNED()`
3:  2c2a2685455 ! 5:  4aa18d68c03 parse-options: introduce precision handling for `OPTION_INTEGER`
    @@ Commit message
           - Even when a caller knows that they want to store a value larger than
             `INT_MAX` they don't have a way to do so.
     
    -    Funny enough, even if the caller gets everything correct the parsing
    -    logic is still insufficient because we use `strtol()` to parse the
    -    argument, which returns a `long`. But as that value is implicitly cast
    -    when assigning it to the `int` field we may still get invalid results.
    -
         In practice this doesn't tend to be a huge issue because users typically
         don't end up passing huge values to most commands. But the parsing logic
         is demonstrably broken, and it is too easy to get the calling convention
    @@ parse-options.c: static enum parse_opt_result do_get_value(struct parse_opt_ctx_
     +		} else if (!*arg) {
      			return error(_("%s expects a numerical value"),
      				     optname(opt, flags));
    -+		} else {
    -+			errno = 0;
    -+			value = strtoimax(arg, (char **)&s, 10);
    -+			if (*s)
    -+				return error(_("%s expects a numerical value"),
    -+					     optname(opt, flags));
    +-		if (!git_parse_int(arg, opt->value))
    +-			return error(_("%s expects an integer value"
    +-				       " with an optional k/m/g suffix"),
    ++		} else if (!git_parse_signed(arg, &value, upper_bound)) {
     +			if (errno == ERANGE)
     +				return error(_("value %s for %s not in range [%"PRIdMAX",%"PRIdMAX"]"),
     +					     arg, optname(opt, flags), lower_bound, upper_bound);
    -+			if (errno)
    -+				return error_errno(_("value %s for %s cannot be parsed"),
    -+						   arg, optname(opt, flags));
    ++
    ++			return error(_("%s expects an integer value with an optional k/m/g suffix"),
    + 				     optname(opt, flags));
    +-		return 0;
     +		}
    - 
    --		errno = 0;
    --		*(int *)opt->value = strtol(arg, (char **)&s, 10);
    --		if (*s)
    --			return error(_("%s expects a numerical value"),
    --				     optname(opt, flags));
    --		if (errno == ERANGE)
    -+		if (value < lower_bound || value > upper_bound)
    - 			return error(_("value %s for %s not in range [%"PRIdMAX",%"PRIdMAX"]"),
    --				     arg, optname(opt, flags), (intmax_t)LONG_MIN, (intmax_t)LONG_MAX);
    --		if (errno)
    --			return error_errno(_("value %s for %s cannot be parsed"),
    --					   arg, optname(opt, flags));
    ++
    ++		if (value < lower_bound)
    ++			return error(_("value %s for %s not in range [%"PRIdMAX",%"PRIdMAX"]"),
     +				     arg, optname(opt, flags), lower_bound, upper_bound);
      
    --		return 0;
     +		switch (opt->precision) {
     +		case 1:
     +			*(int8_t *)opt->value = value;
    @@ parse-options.c: static enum parse_opt_result do_get_value(struct parse_opt_ctx_
     +			    optname(opt, flags));
     +		}
     +	}
    - 	case OPTION_MAGNITUDE:
    + 	case OPTION_UNSIGNED:
      		if (unset) {
      			*(unsigned long *)opt->value = 0;
     
    @@ t/helper/test-parse-options.c: int cmd__parse_options(int argc, const char **arg
      		OPT_INTEGER('i', "integer", &integer, "get a integer"),
     +		OPT_INTEGER(0, "i16", &i16, "get a 16 bit integer"),
      		OPT_INTEGER('j', NULL, &integer, "get a integer, too"),
    - 		OPT_MAGNITUDE('m', "magnitude", &magnitude, "get a magnitude"),
    + 		OPT_UNSIGNED('u', "unsigned", &unsigned_integer, "get an unsigned integer"),
      		OPT_SET_INT(0, "set23", &integer, "set integer to 23", 23),
     @@ t/helper/test-parse-options.c: int cmd__parse_options(int argc, const char **argv)
      	}
      	show(&expect, &ret, "boolean: %d", boolean);
      	show(&expect, &ret, "integer: %d", integer);
     +	show(&expect, &ret, "i16: %"PRIdMAX, (intmax_t) i16);
    - 	show(&expect, &ret, "magnitude: %lu", magnitude);
    + 	show(&expect, &ret, "unsigned: %lu", unsigned_integer);
      	show(&expect, &ret, "timestamp: %"PRItime, timestamp);
      	show(&expect, &ret, "string: %s", string ? string : "(not set)");
     
    @@ t/t0040-parse-options.sh: usage: test-tool parse-options <options>
                                get a integer
     +    --[no-]i16 <n>        get a 16 bit integer
          -j <n>                get a integer, too
    -     -m, --magnitude <n>   get a magnitude
    +     -u, --unsigned <n>    get an unsigned integer
          --[no-]set23          set integer to 23
    -@@ t/t0040-parse-options.sh: test_expect_success 'OPT_MAGNITUDE() 3giga' '
    +@@ t/t0040-parse-options.sh: test_expect_success 'OPT_UNSIGNED() 3giga' '
      cat >expect <<\EOF
      boolean: 2
      integer: 1729
     +i16: 0
    - magnitude: 16384
    + unsigned: 16384
      timestamp: 0
      string: 123
     @@ t/t0040-parse-options.sh: test_expect_success 'short options' '
    @@ t/t0040-parse-options.sh: test_expect_success 'short options' '
      boolean: 2
      integer: 1729
     +i16: 9000
    - magnitude: 16384
    + unsigned: 16384
      timestamp: 0
      string: 321
     @@ t/t0040-parse-options.sh: file: prefix/fi.le
      EOF
      
      test_expect_success 'long options' '
    --	test-tool parse-options --boolean --integer 1729 --magnitude 16k \
    -+	test-tool parse-options --boolean --integer 1729 --i16 9000 --magnitude 16k \
    +-	test-tool parse-options --boolean --integer 1729 --unsigned 16k \
    ++	test-tool parse-options --boolean --integer 1729 --i16 9000 --unsigned 16k \
      		--boolean --string2=321 --verbose --verbose --no-dry-run \
      		--abbrev=10 --file fi.le --obsolete \
      		>output 2>output.err &&
    @@ t/t0040-parse-options.sh: test_expect_success 'abbreviate to something longer th
      	boolean: 0
      	integer: 0
     +	i16: 0
    - 	magnitude: 0
    + 	unsigned: 0
      	timestamp: 0
      	string: (not set)
     @@ t/t0040-parse-options.sh: test_expect_success 'superfluous value provided: cmdmode' '
    @@ t/t0040-parse-options.sh: test_expect_success 'superfluous value provided: cmdmo
      boolean: 1
      integer: 13
     +i16: 0
    - magnitude: 0
    + unsigned: 0
      timestamp: 0
      string: 123
     @@ t/t0040-parse-options.sh: test_expect_success 'intermingled arguments' '
    @@ t/t0040-parse-options.sh: test_expect_success 'intermingled arguments' '
      boolean: 0
      integer: 2
     +i16: 0
    - magnitude: 0
    + unsigned: 0
      timestamp: 0
      string: (not set)
     @@ t/t0040-parse-options.sh: cat >expect <<\EOF
    @@ t/t0040-parse-options.sh: cat >expect <<\EOF
      boolean: 5
      integer: 4
     +i16: 0
    - magnitude: 0
    + unsigned: 0
      timestamp: 0
      string: (not set)
     @@ t/t0040-parse-options.sh: test_expect_success 'OPT_CALLBACK() and callback errors work' '
    @@ t/t0040-parse-options.sh: test_expect_success 'OPT_CALLBACK() and callback error
      boolean: 1
      integer: 23
     +i16: 0
    - magnitude: 0
    + unsigned: 0
      timestamp: 0
      string: (not set)
     @@ t/t0040-parse-options.sh: test_expect_success 'OPT_NUMBER_CALLBACK() works' '
    @@ t/t0040-parse-options.sh: test_expect_success 'OPT_NUMBER_CALLBACK() works' '
      boolean: 0
      integer: 0
     +i16: 0
    - magnitude: 0
    + unsigned: 0
      timestamp: 0
      string: (not set)
    -@@ t/t0040-parse-options.sh: test_expect_success 'overflowing integer' '
    +@@ t/t0040-parse-options.sh: test_expect_success 'unsigned with units but no numbers' '
      	test_must_be_empty out
      '
      
4:  9c1a42f8d3f ! 6:  aa766336dd9 parse-options: introduce precision handling for `OPTION_MAGNITUDE`
    @@ Metadata
     Author: Patrick Steinhardt <ps@pks.im>
     
      ## Commit message ##
    -    parse-options: introduce precision handling for `OPTION_MAGNITUDE`
    +    parse-options: introduce precision handling for `OPTION_UNSIGNED`
     
         This commit is the equivalent to the preceding commit, but instead of
         introducing precision handling for `OPTION_INTEGER` we introduce it for
    -    `OPTION_MAGNITUDE`.
    +    `OPTION_UNSIGNED`.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## parse-options.c ##
     @@ parse-options.c: static enum parse_opt_result do_get_value(struct parse_opt_ctx_t *p,
      
    - 		if (value < lower_bound || value > upper_bound)
    + 		if (value < lower_bound)
      			return error(_("value %s for %s not in range [%"PRIdMAX",%"PRIdMAX"]"),
     -				     arg, optname(opt, flags), lower_bound, upper_bound);
     +				     arg, optname(opt, flags), (intmax_t)lower_bound, (intmax_t)upper_bound);
    @@ parse-options.c: static enum parse_opt_result do_get_value(struct parse_opt_ctx_
     @@ parse-options.c: static enum parse_opt_result do_get_value(struct parse_opt_ctx_t *p,
      		}
      	}
    - 	case OPTION_MAGNITUDE:
    + 	case OPTION_UNSIGNED:
     +	{
     +		uintmax_t upper_bound = UINTMAX_MAX >> (bitsizeof(uintmax_t) - CHAR_BIT * opt->precision);
    -+		unsigned long value;
    ++		uintmax_t value;
     +
      		if (unset) {
     -			*(unsigned long *)opt->value = 0;
    @@ parse-options.c: static enum parse_opt_result do_get_value(struct parse_opt_ctx_
     +		} else if (get_arg(p, opt, flags, &arg)) {
      			return -1;
     -		if (!git_parse_ulong(arg, opt->value))
    -+		} else if (!git_parse_ulong(arg, &value)) {
    ++		} else if (!*arg) {
    ++			return error(_("%s expects a numerical value"),
    ++				     optname(opt, flags));
    ++		} else if (!git_parse_unsigned(arg, &value, upper_bound)) {
    ++			if (errno == ERANGE)
    ++				return error(_("value %s for %s not in range [%"PRIdMAX",%"PRIdMAX"]"),
    ++					     arg, optname(opt, flags), (uintmax_t) 0, upper_bound);
    ++
      			return error(_("%s expects a non-negative integer value"
      				       " with an optional k/m/g suffix"),
      				     optname(opt, flags));
     -		return 0;
     +		}
     +
    -+		if (value > upper_bound)
    -+			return error(_("value %s for %s not in range [%"PRIuMAX",%"PRIuMAX"]"),
    -+				     arg, optname(opt, flags), (uintmax_t)0, (uintmax_t)upper_bound);
    -+
     +		switch (opt->precision) {
     +		case 1:
     +			*(uint8_t *)opt->value = value;
    @@ parse-options.h: struct option {
      	.help = (h), \
      	.flags = PARSE_OPT_NONEG, \
     
    + ## parse.c ##
    +@@ parse.c: int git_parse_signed(const char *value, intmax_t *ret, intmax_t max)
    + 	return 0;
    + }
    + 
    +-static int git_parse_unsigned(const char *value, uintmax_t *ret, uintmax_t max)
    ++int git_parse_unsigned(const char *value, uintmax_t *ret, uintmax_t max)
    + {
    + 	if (value && *value) {
    + 		char *end;
    +
    + ## parse.h ##
    +@@
    + #define PARSE_H
    + 
    + int git_parse_signed(const char *value, intmax_t *ret, intmax_t max);
    ++int git_parse_unsigned(const char *value, uintmax_t *ret, uintmax_t max);
    + int git_parse_ssize_t(const char *, ssize_t *);
    + int git_parse_ulong(const char *, unsigned long *);
    + int git_parse_int(const char *value, int *ret);
    +
      ## t/helper/test-parse-options.c ##
     @@ t/helper/test-parse-options.c: int cmd__parse_options(int argc, const char **argv)
      	};
      	struct string_list expect = STRING_LIST_INIT_NODUP;
      	struct string_list list = STRING_LIST_INIT_NODUP;
    -+	uint16_t m16 = 0;
    ++	uint16_t u16 = 0;
      	int16_t i16 = 0;
      
      	struct option options[] = {
     @@ t/helper/test-parse-options.c: int cmd__parse_options(int argc, const char **argv)
      		OPT_INTEGER(0, "i16", &i16, "get a 16 bit integer"),
      		OPT_INTEGER('j', NULL, &integer, "get a integer, too"),
    - 		OPT_MAGNITUDE('m', "magnitude", &magnitude, "get a magnitude"),
    -+		OPT_MAGNITUDE(0, "m16", &m16, "get a 16 bit magnitude"),
    + 		OPT_UNSIGNED('u', "unsigned", &unsigned_integer, "get an unsigned integer"),
    ++		OPT_UNSIGNED(0, "u16", &u16, "get a 16 bit unsigned integer"),
      		OPT_SET_INT(0, "set23", &integer, "set integer to 23", 23),
      		OPT_CMDMODE(0, "mode1", &integer, "set integer to 1 (cmdmode option)", 1),
      		OPT_CMDMODE(0, "mode2", &integer, "set integer to 2 (cmdmode option)", 2),
     @@ t/helper/test-parse-options.c: int cmd__parse_options(int argc, const char **argv)
      	show(&expect, &ret, "integer: %d", integer);
      	show(&expect, &ret, "i16: %"PRIdMAX, (intmax_t) i16);
    - 	show(&expect, &ret, "magnitude: %lu", magnitude);
    -+	show(&expect, &ret, "m16: %"PRIuMAX, (uintmax_t) m16);
    + 	show(&expect, &ret, "unsigned: %lu", unsigned_integer);
    ++	show(&expect, &ret, "u16: %"PRIuMAX, (uintmax_t) u16);
      	show(&expect, &ret, "timestamp: %"PRItime, timestamp);
      	show(&expect, &ret, "string: %s", string ? string : "(not set)");
      	show(&expect, &ret, "abbrev: %d", abbrev);
    @@ t/t0040-parse-options.sh
     @@ t/t0040-parse-options.sh: usage: test-tool parse-options <options>
          --[no-]i16 <n>        get a 16 bit integer
          -j <n>                get a integer, too
    -     -m, --magnitude <n>   get a magnitude
    -+    --m16 <n>             get a 16 bit magnitude
    +     -u, --unsigned <n>    get an unsigned integer
    ++    --u16 <n>             get a 16 bit unsigned integer
          --[no-]set23          set integer to 23
          --mode1               set integer to 1 (cmdmode option)
          --mode2               set integer to 2 (cmdmode option)
     @@ t/t0040-parse-options.sh: boolean: 2
      integer: 1729
      i16: 0
    - magnitude: 16384
    -+m16: 0
    + unsigned: 16384
    ++u16: 0
      timestamp: 0
      string: 123
      abbrev: 7
     @@ t/t0040-parse-options.sh: boolean: 2
      integer: 1729
      i16: 9000
    - magnitude: 16384
    -+m16: 32768
    + unsigned: 16384
    ++u16: 32768
      timestamp: 0
      string: 321
      abbrev: 10
     @@ t/t0040-parse-options.sh: EOF
      
      test_expect_success 'long options' '
    - 	test-tool parse-options --boolean --integer 1729 --i16 9000 --magnitude 16k \
    + 	test-tool parse-options --boolean --integer 1729 --i16 9000 --unsigned 16k \
     -		--boolean --string2=321 --verbose --verbose --no-dry-run \
    -+		--m16 32k --boolean --string2=321 --verbose --verbose --no-dry-run \
    ++		--u16 32k --boolean --string2=321 --verbose --verbose --no-dry-run \
      		--abbrev=10 --file fi.le --obsolete \
      		>output 2>output.err &&
      	test_must_be_empty output.err &&
     @@ t/t0040-parse-options.sh: test_expect_success 'abbreviate to something longer than SHA1 length' '
      	integer: 0
      	i16: 0
    - 	magnitude: 0
    -+	m16: 0
    + 	unsigned: 0
    ++	u16: 0
      	timestamp: 0
      	string: (not set)
      	abbrev: 100
     @@ t/t0040-parse-options.sh: boolean: 1
      integer: 13
      i16: 0
    - magnitude: 0
    -+m16: 0
    + unsigned: 0
    ++u16: 0
      timestamp: 0
      string: 123
      abbrev: 7
     @@ t/t0040-parse-options.sh: boolean: 0
      integer: 2
      i16: 0
    - magnitude: 0
    -+m16: 0
    + unsigned: 0
    ++u16: 0
      timestamp: 0
      string: (not set)
      abbrev: 7
     @@ t/t0040-parse-options.sh: boolean: 5
      integer: 4
      i16: 0
    - magnitude: 0
    -+m16: 0
    + unsigned: 0
    ++u16: 0
      timestamp: 0
      string: (not set)
      abbrev: 7
     @@ t/t0040-parse-options.sh: boolean: 1
      integer: 23
      i16: 0
    - magnitude: 0
    -+m16: 0
    + unsigned: 0
    ++u16: 0
      timestamp: 0
      string: (not set)
      abbrev: 7
     @@ t/t0040-parse-options.sh: boolean: 0
      integer: 0
      i16: 0
    - magnitude: 0
    -+m16: 0
    + unsigned: 0
    ++u16: 0
      timestamp: 0
      string: (not set)
      abbrev: 7
    @@ t/t0040-parse-options.sh: test_expect_success 'i16 limits range' '
      	test_grep "value -32769 for option .i16. not in range \[-32768,32767\]" err
      '
      
    -+test_expect_success 'm16 limits range' '
    -+	test-tool parse-options --m16 65535 >out &&
    -+	test_grep "m16: 65535" out &&
    -+	test_must_fail test-tool parse-options --m16 65536 2>err &&
    -+	test_grep "value 65536 for option .m16. not in range \[0,65535\]" err
    ++test_expect_success 'u16 limits range' '
    ++	test-tool parse-options --u16 65535 >out &&
    ++	test_grep "u16: 65535" out &&
    ++	test_must_fail test-tool parse-options --u16 65536 2>err &&
    ++	test_grep "value 65536 for option .u16. not in range \[0,65535\]" err
     +'
     +
      test_done
5:  ef204776e85 < -:  ----------- parse-options: introduce `OPTION_UNSIGNED`
6:  99e009d78c8 ! 7:  254e0f62a85 parse-options: detect mismatches in integer signedness
    @@ parse-options.h: struct option {
      	.precision = sizeof(*v), \
      	.argh = N_("n"), \
      	.help = (h), \
    -@@ parse-options.h: struct option {
    - 	.type = OPTION_MAGNITUDE, \
    - 	.short_name = (s), \
    - 	.long_name = (l), \
    --	.value = (v), \
    -+	.value = (v) + BARF_UNLESS_UNSIGNED(*(v)), \
    - 	.precision = sizeof(*v), \
    - 	.argh = N_("n"), \
    - 	.help = (h), \
7:  ed5b28998af < -:  ----------- parse-options: introduce bounded integer options

---
base-commit: 5b97a56fa0e7d580dc8865b73107407c9b3f0eff
change-id: 20250401-b4-pks-parse-options-integers-9b4bbcf21011


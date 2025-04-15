Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE60294A16
	for <git@vger.kernel.org>; Tue, 15 Apr 2025 12:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744719260; cv=none; b=RoiUwTdt+ozhVT2CfOLDHwZv0A36+tYqWLUa27GHkH0oIZKDZwhsw0XopbHW+Qd0V07hzGjuQRlUEwNyolKc3T2vkC3pRkNVef+kFxYmar/W5rUqV3WiMqwX2Cg5CnT3QiYH7tep2r+qek6+mJ8KwNVvg5MImY+LwK4UNRhaxAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744719260; c=relaxed/simple;
	bh=xTj/7hMKWMZ3QF5wVMf33OZdwEuV/Q1sUSx45aATnqY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=A3gZnWtbLRq8u0KuMQCXdny2MwHKhdvNXpju7LTpOxeJ3zLZmdS3viGe5pOFJvHx90kEUmHvLaixFYly/I27WWd7kznUjE7/fcu3QreidXTv+2Sok4+/Y6e4anN6GwBzub+L8h9KRJGV1DLxRyw+n8WhSjoiUn6L0DYheg3dzDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UAJMXf0q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ArG1IE1w; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UAJMXf0q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ArG1IE1w"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id AB86B13807A0;
	Tue, 15 Apr 2025 08:14:15 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 15 Apr 2025 08:14:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744719255;
	 x=1744805655; bh=DscF8svNBR1kj5VkjbIutEwCQ7dRyMGLgONZB9xwkL8=; b=
	UAJMXf0qSo3r60yX1nmsjL8MMbX2u8tskWyVWBa7i2K+Ft5IHVUfg4Jtwp3K5qaR
	da5jV+8sPXSSzLUcpYVWKCTo3onSJFxZCa+kew1tyhD4CkQBiMCqK4Tv4DZICv+g
	VlP168l78PHnnL8nsBO+4395CDMlxFZlhw+M325pamNyPOopBmwfWhfPfoLh8O/k
	c9aZUDT2tOIRPXhpd5d0dG+T9tdmg4ISrrUajLL00wHk1dtMPUyLcrmkdVd2yPJk
	OgCOX0+grFuBDBwK0fSVprDJkS72HwBF/mHcuKcl7qg0zfowSsbCEBxamNvqURe/
	zMyQZxkdRzRQpqtt0Brb6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744719255; x=
	1744805655; bh=DscF8svNBR1kj5VkjbIutEwCQ7dRyMGLgONZB9xwkL8=; b=A
	rG1IE1w3TZbQCEoJpFdM+3rV2Ot85LmvtrTiiIs+XVCd9p9AMKNSX5G3B+M452IC
	grFR5o75n49Rannbhw6ulJRzmlWzaOSO9TRNoYjmRw9YQFxQAnbtiRE4UoDgBwJz
	162/79R42yj/iGO4dIkdJoKktGUqixy9qNBsVpwgrB4zTKtRK4sedJlmC4WrN7YR
	TNFDqghk4da5Jqm6vzVSJK8ObXI2iLm5UckCNvun9WffR7Hx7dHhDUq7GJmd3nd0
	zQ2xm4V/czWQxGk8oWNt6bNqPA6IWY/ldst+0GPywg4KIcu+MPplZuB4ETobw1Bv
	GVfQQITwRyPIBTRv2ugSA==
X-ME-Sender: <xms:l03-Z6ty0wNvj-8YFdlPwsiVvDzCW3_4K_Z3R_vGmzLkU8JDrE394Q>
    <xme:l03-Z_eQp-HVrax3JcprubAu4oaWdh-RtnsQNQNXM1nq8hnyBRVQ30d_zi5HyFiGJ
    B3DREAutbWs4sZaPw>
X-ME-Received: <xmr:l03-Z1z7qm3twPl39onbXMNwQBzwOwFYHxDsxtGYC8B1L6S3urdZgH5eN-hrKyO-7CF2jEGgvHwcmXOSdc9OQ1huNYvR6OzE6YEPINoxJYm4FQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdefgeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffufffkgggtgfgjfhfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeetueeuhefhhfeitdeuhedttdeikeeftdduhedt
    heefhfegffevgeegtdfhheeuvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhs
    rdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlrdhsrdhrseif
    vggsrdguvgdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtth
    hopehglhgruhgsihhtiiesphhhhihsihhkrdhfuhdqsggvrhhlihhnrdguvgdprhgtphht
    thhopehsiigvuggvrhdruggvvhesghhmrghilhdrtghomhdprhgtphhtthhopehpvghffh
    esphgvfhhfrdhnvghtpdhrtghpthhtohepthhmiiesphhosghogidrtghomh
X-ME-Proxy: <xmx:l03-Z1MaVRXuq_KbstX1c32rySLYxFHCDYVCFNAKRsvsA3fOWwJLgQ>
    <xmx:l03-Z6-LqgX_mnBTZuedXbSddo8IeFV8ZWlAu8-7jFMjvihZVJ1wbQ>
    <xmx:l03-Z9VPV6ul94T5nncZaqlhje8ucQKU3wWx8c1IxfgPc3L9hMY_rQ>
    <xmx:l03-Zzft3yb8qMBckVKqjcQrZU4ZKNDBlDJI4Rk6IuDhEGw3D2NH_w>
    <xmx:l03-ZzHOc9YCccnRbu4KrNtmVw8KZHIEJbSdQ3ZvAjPS128V6ZgYzzk7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Apr 2025 08:14:13 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 74e9c658 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 15 Apr 2025 12:14:11 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/5] parse-options: harden handling of integer values
Date: Tue, 15 Apr 2025 14:14:04 +0200
Message-Id: <20250415-b4-pks-parse-options-integers-v2-0-ce07441a1f01@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI1N/mcC/42NQQrCMBBFr1Jm7UgSo6ir3kO6SNJpO4hpyISil
 N7d2BO4fJ/H+ysIZSaBe7NCpoWF51jBHBoIk4sjIfeVwShzVlZp9BbTUzC5LIRzKtUX5FhopCx
 489b7MBittIbaSJkGfu/9R1d5Yilz/ux3i/6t/5YXjQrdxVxdb1U4edtW+cgv6LZt+wJwGNWkx
 wAAAA==
X-Change-ID: 20250401-b4-pks-parse-options-integers-9b4bbcf21011
In-Reply-To: <20250401-b4-pks-parse-options-integers-v1-0-a628ad40c3b4@pks.im>
References: <20250401-b4-pks-parse-options-integers-v1-0-a628ad40c3b4@pks.im>
To: git@vger.kernel.org
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Todd Zullinger <tmz@pobox.com>, 
 =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>
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

Thanks!

Patrick

[1]: <89257ab82cd60d135cce02d51eacee7ec35c1c37.camel@physik.fu-berlin.de>
[2]: <Z8HW6petWuMRWSXf@teonanacatl.net>

---
Patrick Steinhardt (5):
      global: use designated initializers for options
      parse-options: introduce precision handling for `OPTION_INTEGER`
      parse-options: introduce precision handling for `OPTION_MAGNITUDE`
      parse-options: introduce `OPTION_UNSIGNED`
      parse-options: detect mismatches in integer signedness

 apply.c                       |   4 +-
 archive.c                     |  35 ++++++++---
 builtin/am.c                  |  28 ++++++---
 builtin/backfill.c            |   4 +-
 builtin/clone.c               |  13 ++++-
 builtin/column.c              |   2 +-
 builtin/commit-tree.c         |  12 +++-
 builtin/commit.c              |  62 +++++++++++++++-----
 builtin/config.c              |  13 ++++-
 builtin/describe.c            |  24 ++++++--
 builtin/fetch.c               |  10 +++-
 builtin/fmt-merge-msg.c       |  27 ++++++---
 builtin/gc.c                  |  12 +++-
 builtin/grep.c                |  18 ++++--
 builtin/init-db.c             |  13 +++--
 builtin/ls-remote.c           |  11 +++-
 builtin/merge.c               |  38 +++++++++---
 builtin/read-tree.c           |  11 +++-
 builtin/rebase.c              |  25 ++++++--
 builtin/revert.c              |  12 +++-
 builtin/show-branch.c         |  13 ++++-
 builtin/tag.c                 |  24 ++++++--
 builtin/update-index.c        | 131 +++++++++++++++++++++++++++++-------------
 builtin/write-tree.c          |  12 ++--
 diff.c                        |  13 +++--
 git-compat-util.h             |   7 +++
 parse-options.c               | 131 +++++++++++++++++++++++++++++++++++-------
 parse-options.h               |  23 +++++++-
 ref-filter.h                  |  15 +++--
 t/helper/test-parse-options.c |  46 ++++++++++++---
 t/t0040-parse-options.sh      |  57 +++++++++++++++++-
 31 files changed, 657 insertions(+), 189 deletions(-)

Range-diff versus v1:

1:  632c627b9ba = 1:  92d1cbd1153 global: use designated initializers for options
2:  65c450a4395 ! 2:  8d2400d7470 parse-options: introduce precision handling for `OPTION_INTEGER`
    @@ parse-options.c: static enum parse_opt_result do_get_value(struct parse_opt_ctx_
      	}
      	case OPTION_INTEGER:
     +	{
    -+		intmax_t upper_bound = (((intmax_t) 1 << (opt->precision * 8 - 1)) - 1);
    ++		intmax_t upper_bound = INTMAX_MAX >> (bitsizeof(intmax_t) - CHAR_BIT * opt->precision);
     +		intmax_t lower_bound = -upper_bound - 1;
     +		intmax_t value;
     +
3:  4946ca0f702 ! 3:  a9b0d8c1127 parse-options: introduce precision handling for `OPTION_MAGNITUDE`
    @@ parse-options.c: static enum parse_opt_result do_get_value(struct parse_opt_ctx_
      	}
      	case OPTION_MAGNITUDE:
     +	{
    -+		uintmax_t upper_bound = 0;
    ++		uintmax_t upper_bound = UINTMAX_MAX >> (bitsizeof(uintmax_t) - CHAR_BIT * opt->precision);
     +		unsigned long value;
    -+
    -+		/*
    -+		 * It's stupid, but the obvious way of calculating the upper
    -+		 * bound via `2 ^ n - 1` overflows.
    -+		 */
    -+		for (size_t i = 0; i < opt->precision * 8; i++)
    -+			upper_bound |= ((uintmax_t) 1 << i);
     +
      		if (unset) {
     -			*(unsigned long *)opt->value = 0;
4:  9728d57d5df ! 4:  743afbf539e parse-options: introduce `OPTION_UNSIGNED`
    @@ parse-options.c: static enum parse_opt_result do_get_value(struct parse_opt_ctx_
      	}
     +	case OPTION_UNSIGNED:
     +	{
    -+		uintmax_t upper_bound = 0;
    ++		uintmax_t upper_bound = UINTMAX_MAX >> (bitsizeof(uintmax_t) - CHAR_BIT * opt->precision);
     +		uintmax_t value;
     +
    -+		/*
    -+		 * It's stupid, but the obvious way of calculating the upper
    -+		 * bound via `2 ^ n - 1` overflows.
    -+		 */
    -+		for (size_t i = 0; i < opt->precision * 8; i++)
    -+			upper_bound |= ((uintmax_t) 1 << i);
    -+
     +		if (unset) {
     +			value = 0;
     +		} else if (opt->flags & PARSE_OPT_OPTARG && !p->opt) {
    @@ parse-options.c: static enum parse_opt_result do_get_value(struct parse_opt_ctx_
     +	}
      	case OPTION_MAGNITUDE:
      	{
    - 		uintmax_t upper_bound = 0;
    + 		uintmax_t upper_bound = UINTMAX_MAX >> (bitsizeof(uintmax_t) - CHAR_BIT * opt->precision);
     
      ## parse-options.h ##
     @@ parse-options.h: enum parse_opt_type {
5:  59aacc72548 = 5:  1e42672a439 parse-options: detect mismatches in integer signedness

---
base-commit: 5b97a56fa0e7d580dc8865b73107407c9b3f0eff
change-id: 20250401-b4-pks-parse-options-integers-9b4bbcf21011


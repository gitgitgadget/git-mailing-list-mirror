Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B59198E6F
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 09:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729502878; cv=none; b=UxMFgCtwUOtNr8egqOj47BoSLUdiKcJgm4XF3Qlm26qCgXYRGTeh6swd7hsvJY8SsySz146QFkUpix/d5MYWD0jbhoGfKnbEEgZ/k4Usmwyyx0KUG9Fj2+cxTVXdcow5Dbi/eIhA5PMmQoXWGgcQPOTq9uzoftnTv2QRkanRjtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729502878; c=relaxed/simple;
	bh=wvGfUTbSd4XWNlGCo5qB0za6YbpmESOgsSJACYMbfR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m+WXKihioUB9Jqz9SK42naI7c6MbgjtTXBN/12/i2PfnflyQQImbXiG+EG233u0ylVMDVSoHuRshVsskUChcgqc0z0cOiRsVUELItNyuh0rnq/sGQo5AxPCAVT9eW3/EclNZ9fxUFJsrdNN08Tg4hWFoVib9qamYDkd0Pi2Vj40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tbdCGyAH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jKSh+W5C; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tbdCGyAH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jKSh+W5C"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9D9E011401C6;
	Mon, 21 Oct 2024 05:27:54 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 21 Oct 2024 05:27:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729502874; x=1729589274; bh=jIAWvlHgS5
	T7pBu0uciwJnZnhthdejeERG3GG4unArI=; b=tbdCGyAHN+SQMl/n0FlTXazGcp
	b/HVQZDgzOOCF0qM4KfKHTNdT+Ntu3FWlsNUuluX69bJ++8+oGfHG/uFyyy84n+e
	/gpfDncHIvVVjixUW/UhQVqd9E1OpPkuYqlp+qKYpKoIP9xpHFcweLWTkCBNK8IR
	mFb2naqeKXDFq9gsOH2N32dfbr58TKljsiEWIIO2kjdDnPEfWji0NKHnAzfvIK9h
	hC8owlY4+P7jaVqt3jEAAbLFGlXCMlFGPaK1KJZrq6gbxGTBfECpdVEyOKP1fwmk
	W1h49lw5KCuxJnVkECYiU67jsMdVsU6VNmPETdjw13gPU6jVrG93dRgZ7+jQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729502874; x=1729589274; bh=jIAWvlHgS5T7pBu0uciwJnZnhthd
	ejeERG3GG4unArI=; b=jKSh+W5CUd0jOvuSPkuLArI3GlzK+xYrd+ChzsFnZPyQ
	WOXB32i7OAE7uPnWYznkw9YA9HMZB36aKhwBOlJfn2+QLk5y3NIR2SLD4pHlKSWR
	Ep6ArC+hkD3g8rdbbwKx0lduIC0GDLmeeYKl/1wGcNCXIkqj4ubCzJlTdkeZergK
	G0BnlHm/k5m0DyimtuKUyDQRxBFfwxwb/Da1tTTnbfXzcBbnAG6FeOvrAqv0u8cy
	AfAd78ibs4KlbNzH/eQEnK9WM/MluxEDe92ySGcr6W/xIgsOqLk5D7NUEA6qaOHw
	YtCa5fjXQIwI1giqLJnA9xewK7q0uz4PBNGhZF92gA==
X-ME-Sender: <xms:mh4WZ74MP3w-1wSnwSREmlzbnxdhD0qCLEyV_O7DHD6RWrzN9Fe-8g>
    <xme:mh4WZw49aVecy-qNJYEGrRiwuc6lO13hsUS9HiRT2KYf1nAWaBx1Uq-hkP4_JC0vP
    EjzLAjiLHvvj5sZOA>
X-ME-Received: <xmr:mh4WZyfr8SgB7pgew_OtwLtezqsjQg4q0kANtg0apJHO5C_YbmeZtScZofxp_B1R2oT8lnbPSYZ9WR6F_wNKGExGo1E7uY1b-ss2ObJ9mcUt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehledgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepthhoohhnsehi
    ohhttghlrdgtohhm
X-ME-Proxy: <xmx:mh4WZ8KVHaemyPgOiul7F1CeOkzv4cfmZhaDa8rMt5NkVJxRlpe6Pg>
    <xmx:mh4WZ_LTQEP1MtJrn_bG4N77k6p3ArzN0V0hq7wGYzSaSTuwDI0ZKQ>
    <xmx:mh4WZ1xGBKGCX1U_Ohs5BdjS1vEE9PTIM4wDUwiwb4oiZBgLuxkoRA>
    <xmx:mh4WZ7Iudn2QbPuZTrARLWKzl-2VMdlegTpf1JFyH3uMMVRAFpNGNg>
    <xmx:mh4WZ32bNJ5Hkvw-thpdB_IzYMs4Qqv8LpxQbCvNwRO0R9w6vUSEngr->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Oct 2024 05:27:53 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 50b233c4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 21 Oct 2024 09:26:24 +0000 (UTC)
Date: Mon, 21 Oct 2024 11:27:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>
Subject: [PATCH v2 00/22] Memory leak fixes (pt.9)
Message-ID: <cover.1729502823.git.ps@pks.im>
References: <cover.1728624670.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728624670.git.ps@pks.im>

Hi,

this is the second version of my 9th series of memory leak fixes.

Changes compared to v1:

  - Split up the trailer fixes into two separate patches so that we can
    explain them standalone.

  - Adapt the second trailer memory leak fix to instead pull up the
    strbufs out of the loop such that we can reuse them. This makes the
    code flow more naturally and optimizes the loop.

Thanks!

Patrick

Patrick Steinhardt (22):
  builtin/ls-remote: plug leaking server options
  t/helper: fix leaks in "reach" test tool
  grep: fix leak in `grep_splice_or()`
  builtin/grep: fix leak with `--max-count=0`
  revision: fix leaking bloom filters
  diff-lib: fix leaking diffopts in `do_diff_cache()`
  pretty: clear signature check
  upload-pack: fix leaking URI protocols
  builtin/commit: fix leaking change data contents
  trailer: fix leaking trailer values
  trailer: fix leaking strbufs when formatting trailers
  builtin/commit: fix leaking cleanup config
  transport-helper: fix leaking import/export marks
  builtin/tag: fix leaking key ID on failure to sign
  combine-diff: fix leaking lost lines
  dir: release untracked cache data
  sparse-index: correctly free EWAH contents
  t/helper: stop re-initialization of `the_repository`
  t/helper: fix leaking buffer in "dump-untracked-cache"
  dir: fix leak when parsing "status.showUntrackedFiles"
  builtin/merge: release outbut buffer after performing merge
  list-objects-filter-options: work around reported leak on error

 builtin/commit.c                          | 26 +++++++++++++++++------
 builtin/grep.c                            | 13 +++++++++---
 builtin/ls-remote.c                       |  1 +
 builtin/merge.c                           |  1 +
 builtin/tag.c                             |  2 +-
 combine-diff.c                            |  2 +-
 diff-lib.c                                |  1 +
 dir.c                                     | 12 +++++++++--
 grep.c                                    |  1 +
 list-objects-filter-options.c             | 17 ++++++---------
 pretty.c                                  |  1 +
 revision.c                                |  5 +++++
 sparse-index.c                            |  7 ++++--
 t/helper/test-dump-untracked-cache.c      |  2 ++
 t/helper/test-reach.c                     | 10 +++++++++
 t/helper/test-read-cache.c                |  2 --
 t/t4038-diff-combined.sh                  |  1 +
 t/t4202-log.sh                            |  1 +
 t/t4216-log-bloom.sh                      |  1 +
 t/t5702-protocol-v2.sh                    |  1 +
 t/t5801-remote-helpers.sh                 |  1 +
 t/t6112-rev-list-filters-objects.sh       |  1 +
 t/t6424-merge-unrelated-index-changes.sh  |  1 +
 t/t6600-test-reach.sh                     |  1 +
 t/t7004-tag.sh                            |  1 +
 t/t7031-verify-tag-signed-ssh.sh          |  1 +
 t/t7063-status-untracked-cache.sh         |  1 +
 t/t7500-commit-template-squash-signoff.sh |  1 +
 t/t7502-commit-porcelain.sh               |  1 +
 t/t7510-signed-commit.sh                  |  1 +
 t/t7513-interpret-trailers.sh             |  1 +
 t/t7519-status-fsmonitor.sh               |  1 +
 t/t7528-signed-commit-ssh.sh              |  1 +
 t/t7610-mergetool.sh                      |  1 +
 t/t7810-grep.sh                           |  1 +
 trailer.c                                 | 25 +++++++++++++++-------
 transport-helper.c                        |  2 ++
 upload-pack.c                             |  1 +
 38 files changed, 115 insertions(+), 35 deletions(-)

Range-diff against v1:
 1:  89b66411354 =  1:  89b66411354 builtin/ls-remote: plug leaking server options
 2:  1c42e194b20 =  2:  1c42e194b20 t/helper: fix leaks in "reach" test tool
 3:  cb4eee37b40 =  3:  cb4eee37b40 grep: fix leak in `grep_splice_or()`
 4:  6b2c8842ef5 =  4:  6b2c8842ef5 builtin/grep: fix leak with `--max-count=0`
 5:  7527b31a28f =  5:  7527b31a28f revision: fix leaking bloom filters
 6:  60af98cb2c7 =  6:  60af98cb2c7 diff-lib: fix leaking diffopts in `do_diff_cache()`
 7:  5d5f6867f91 =  7:  5d5f6867f91 pretty: clear signature check
 8:  0d503e40194 =  8:  0d503e40194 upload-pack: fix leaking URI protocols
 9:  9f967dfe5d5 =  9:  9f967dfe5d5 builtin/commit: fix leaking change data contents
 -:  ----------- > 10:  e3ffd59123f trailer: fix leaking trailer values
10:  ca5370d572d ! 11:  5b851453bce trailer: fix leaking trailer values
    @@ Metadata
     Author: Patrick Steinhardt <ps@pks.im>
     
      ## Commit message ##
    -    trailer: fix leaking trailer values
    +    trailer: fix leaking strbufs when formatting trailers
     
    -    Fix leaking trailer values when replacing the value with a command or
    -    when the token value is empty.
    +    We are populating, but never releasing two string buffers in
    +    `format_trailers()`, causing a memory leak. Plug this leak by lifting
    +    those buffers outside of the loop and releasing them on function return.
    +    This fixes the memory leaks, but also optimizes the loop as we don't
    +    have to reallocate the buffers on every single iteration.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
    @@ t/t7513-interpret-trailers.sh
      # When we want one trailing space at the end of each line, let's use sed
     
      ## trailer.c ##
    -@@ trailer.c: static char *apply_command(struct conf_info *conf, const char *arg)
    - static void apply_item_command(struct trailer_item *in_tok, struct arg_item *arg_tok)
    +@@ trailer.c: void format_trailers(const struct process_trailer_options *opts,
    + 		     struct list_head *trailers,
    + 		     struct strbuf *out)
      {
    - 	if (arg_tok->conf.command || arg_tok->conf.cmd) {
    --		const char *arg;
    -+		char *value_to_free = NULL;
    -+		char *arg;
    -+
    - 		if (arg_tok->value && arg_tok->value[0]) {
    --			arg = arg_tok->value;
    -+			arg = (char *)arg_tok->value;
    - 		} else {
    - 			if (in_tok && in_tok->value)
    - 				arg = xstrdup(in_tok->value);
    - 			else
    - 				arg = xstrdup("");
    -+			value_to_free = arg_tok->value;
    - 		}
    -+
    - 		arg_tok->value = apply_command(&arg_tok->conf, arg);
    --		free((char *)arg);
    -+
    -+		free(value_to_free);
    -+		free(arg);
    - 	}
    - }
    ++	struct strbuf tok = STRBUF_INIT;
    ++	struct strbuf val = STRBUF_INIT;
    + 	size_t origlen = out->len;
    + 	struct list_head *pos;
    + 	struct trailer_item *item;
      
    -@@ trailer.c: void format_trailers(const struct process_trailer_options *opts,
    - 		if (item->token) {
    - 			struct strbuf tok = STRBUF_INIT;
    - 			struct strbuf val = STRBUF_INIT;
     +
    + 	list_for_each(pos, trailers) {
    + 		item = list_entry(pos, struct trailer_item, list);
    + 		if (item->token) {
    +-			struct strbuf tok = STRBUF_INIT;
    +-			struct strbuf val = STRBUF_INIT;
    ++			strbuf_reset(&tok);
      			strbuf_addstr(&tok, item->token);
    ++			strbuf_reset(&val);
      			strbuf_addstr(&val, item->value);
      
    -@@ trailer.c: void format_trailers(const struct process_trailer_options *opts,
    - 			 * corresponding value).
    - 			 */
    - 			if (opts->trim_empty && !strlen(item->value))
    --				continue;
    -+				goto next;
    - 
    - 			if (!opts->filter || opts->filter(&tok, opts->filter_data)) {
    - 				if (opts->separator && out->len != origlen)
    + 			/*
     @@ trailer.c: void format_trailers(const struct process_trailer_options *opts,
      				if (!opts->separator)
      					strbuf_addch(out, '\n');
      			}
    -+
    -+next:
    - 			strbuf_release(&tok);
    - 			strbuf_release(&val);
    +-			strbuf_release(&tok);
    +-			strbuf_release(&val);
     -
      		} else if (!opts->only_trailers) {
      			if (opts->separator && out->len != origlen) {
      				strbuf_addbuf(out, opts->separator);
    +@@ trailer.c: void format_trailers(const struct process_trailer_options *opts,
    + 				strbuf_addch(out, '\n');
    + 		}
    + 	}
    ++
    ++	strbuf_release(&tok);
    ++	strbuf_release(&val);
    + }
    + 
    + void format_trailers_from_commit(const struct process_trailer_options *opts,
11:  8ca4344ed86 = 12:  60c3f6146f3 builtin/commit: fix leaking cleanup config
12:  16d969ed7b1 = 13:  ea81cd8db86 transport-helper: fix leaking import/export marks
13:  9e4bc5bf73f = 14:  b700ab9079f builtin/tag: fix leaking key ID on failure to sign
14:  8d305d9b1c8 = 15:  76bbcb3fe30 combine-diff: fix leaking lost lines
15:  f977a033cf4 = 16:  d6b96a4012d dir: release untracked cache data
16:  170cc61edaa = 17:  3aa6bac5079 sparse-index: correctly free EWAH contents
17:  8e10ee844c6 = 18:  132fe750906 t/helper: stop re-initialization of `the_repository`
18:  71fd1c76b8a = 19:  b8b702eeb28 t/helper: fix leaking buffer in "dump-untracked-cache"
19:  8ccc246432d = 20:  ad309ac1b37 dir: fix leak when parsing "status.showUntrackedFiles"
20:  bc2206aa47e = 21:  5e243f9ee53 builtin/merge: release outbut buffer after performing merge
21:  6a2baf0d3e5 = 22:  b75376e3725 list-objects-filter-options: work around reported leak on error
-- 
2.47.0.72.gef8ce8f3d4.dirty


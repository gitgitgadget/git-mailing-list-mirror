Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA27AD5B
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 06:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730787415; cv=none; b=gKSpWLeqRKt0r+oTZRJsHIP2KROwzUFVUqXyJk6DHDmMD1/+SLnCU4IspVvSXiVDjvRaLSIgIeIbPU060iDTWbLrVR4swMrcPMt9yh5iHRrmcEzBvsuEVr7s0jO7vIa6I2FFo9tOnDDIpNZH+wKOpAVxHvSKteNKnVg/a76uqE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730787415; c=relaxed/simple;
	bh=z9c2EMNgILQrDO/eENRm6b5Xr8sH0juaXIn30egz92Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ji0VA0z7b7wt3OtZwNFoLzd/dVbN2UceJiwbRXkv7qRt43IX54RP08/5Zpg7GgL2BcnJ3aSm3Kr3+NyJVWb5uQDrVsDOzb3agt29BeFP6J56lfi+FG0hBD1aMgfmVDhdV/SwMj4SfQDAEryneZsixwCCvZM127XP+/EVTBzJd1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bQePQEZ8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZHf1dVL0; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bQePQEZ8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZHf1dVL0"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C12F22540160;
	Tue,  5 Nov 2024 01:16:51 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 05 Nov 2024 01:16:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730787411; x=1730873811; bh=vnLjOQujn1
	anYYh1q1ByuC4Ayzw2jFH+dqtNADVEKBs=; b=bQePQEZ8ArFt949SUCgEMnon/o
	6xEy/Y2m9df99T5p6PkRw2bJ6xRPWhuW5eXZ5g9BCHoFUlD0C7v+17HdCVLcMAoW
	wLJUHOe/s+FOIM5H3C9IW0c8/xj1WtFvZBINpInnlsO8dsEzlfw2+q/b5dWAwNr1
	DE5aCpOeE3oSJW0CkU3eRKzF8Llg7hRTilrCT8cosJ68PBW186rNHvBbJL5aOZUH
	ZvLcYSb80FBa8ht/8UNHjHM82d1Rkz+6RlAJQz0Vx7d+TiCy0RfaIX0tLgNkD3RS
	jUV8dHKMeMhxN6ASih9P/q2Mr5R2L+wSjmo8PJfCVE4vt7gih8O6M386RfAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730787411; x=1730873811; bh=vnLjOQujn1anYYh1q1ByuC4Ayzw2jFH+dqt
	NADVEKBs=; b=ZHf1dVL0BGXlB29ms27zLC4u8KcePwf1avbIgpnc8bjHgKn9TCb
	D+j9cpr+dXL7TQgkgYGfwQuKAby2vI9Uyproa0rwfkkAQEgJ0UCw9876VBSv0vYv
	cV9aLcgdS3qaNYIIi3YkER7ZLxQWKMJ5sZ60prVXkO0sQlCmrWLYgGzwmQhlJK5L
	i5UrItEZIwxwy/DwvEKQKHD1zy7qEzeaVddRnOdzs3p/efXBMv2eWt1WW+D1z477
	ubK3biMVdIJL/KdRixWWaznvdH7nxpjN7xVjRSCh7ThOEtquDfOTEs7WrywFC3a0
	3H2XGnx381d0kfQ1kgCPy7fA7rxJ6huUUIA==
X-ME-Sender: <xms:U7gpZ5MbdBQJMXl5R1rQQm1jAcf9LHwVlPlXWGl1gq1FJIGUoFv6-A>
    <xme:U7gpZ7_rrzOCOCSEDtwT21ZVPYd7Q2rhWt_Zejrxbusnewd3nE34f_Bp7MLCztG02
    CRTWjprN2T0bLObHw>
X-ME-Received: <xmr:U7gpZ4RSKf11KAjw-N1sCgu9Nc2efnxRCNRhC5KudtZG-QUu9cXTCpXlmqeORdtZOaGzVCEJoFL-gCs7zNipdzkdKAmSUzepqSCDVtzoE8B8uA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeljedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoh
    epkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhr
    tghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhr
    rdgtohhm
X-ME-Proxy: <xmx:U7gpZ1smTrkMtDVKLrmDGqGWtEPoF6K3Ky67uext-0hpQxLpWic7Kw>
    <xmx:U7gpZxfb456PFtfAFKVa8MbKH6zxDa2m313lIaFGNWF-XM2Wl31ecw>
    <xmx:U7gpZx2P9ckOtZ2T6YTAGlqCRPqtOhXTbccXfjyZqZsAsusAHOh89Q>
    <xmx:U7gpZ9-OeyN8bc8i1hAzEwnYn9YaMiasr_rVCXPudd5ELNzmZFc3IA>
    <xmx:U7gpZ6G4njxcfTwQ-MzRUCteXzDfZSdOH-TWQ6bWXB0JE2uyzy22Nycf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Nov 2024 01:16:50 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 001ede3b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 5 Nov 2024 06:16:26 +0000 (UTC)
Date: Tue, 5 Nov 2024 07:16:40 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 00/22] Memory leak fixes (pt.9)
Message-ID: <cover.1730786195.git.ps@pks.im>
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

this is the third revision of my 9th series of memory leak fixes.
Changes compared to v2:

  - Remove an unnecessary cast.

  - Fix a duplicate newline.

  - Polish a couple of commit messages.

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
  builtin/merge: release output buffer after performing merge
  list-objects-filter-options: work around reported leak on error

 builtin/commit.c                          | 26 +++++++++++++++++------
 builtin/grep.c                            | 13 +++++++++---
 builtin/ls-remote.c                       |  1 +
 builtin/merge.c                           |  1 +
 builtin/tag.c                             |  2 +-
 combine-diff.c                            |  5 +++--
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
 trailer.c                                 | 22 +++++++++++++------
 transport-helper.c                        |  2 ++
 upload-pack.c                             |  1 +
 38 files changed, 115 insertions(+), 35 deletions(-)

Range-diff against v2:
 1:  89b66411354 !  1:  fbb9e68e2f2 builtin/ls-remote: plug leaking server options
    @@ Metadata
      ## Commit message ##
         builtin/ls-remote: plug leaking server options
     
    -    The server options populated via `OPT_STRING_LIST()` is never cleared,
    -    causing a memory leak. Plug it.
    +    The list of server options populated via `OPT_STRING_LIST()` is never
    +    cleared, causing a memory leak. Plug it.
     
         This leak is exposed by t5702, but plugging it alone does not make the
         whole test suite pass.
 2:  1c42e194b20 =  2:  17136f4bdb3 t/helper: fix leaks in "reach" test tool
 3:  cb4eee37b40 !  3:  74b21470194 grep: fix leak in `grep_splice_or()`
    @@ Commit message
         grep: fix leak in `grep_splice_or()`
     
         In `grep_splice_or()` we search for the next `TRUE` node in our tree of
    -    grep exrpessions and replace it with the given new expression. But we
    +    grep expressions and replace it with the given new expression. But we
         don't free the old node, which causes a memory leak. Plug it.
     
         This leak is exposed by t7810, but plugging it alone isn't sufficient to
 4:  6b2c8842ef5 =  4:  d716f93169a builtin/grep: fix leak with `--max-count=0`
 5:  7527b31a28f =  5:  aeb8a19d28d revision: fix leaking bloom filters
 6:  60af98cb2c7 !  6:  24d9d9b1358 diff-lib: fix leaking diffopts in `do_diff_cache()`
    @@ Commit message
         In `do_diff_cache()` we initialize a new `rev_info` and then overwrite
         its `diffopt` with a user-provided set of options. This can leak memory
         because `repo_init_revisions()` may end up allocating memory for the
    -    `diffopt` itself depending on the configuration. And as that field is
    -    overwritten we won't ever free that.
    +    `diffopt` itself depending on the configuration. And since that field is
    +    overwritten we won't ever free it.
     
         Plug the memory leak by releasing the diffopts before we overwrite them.
     
 7:  5d5f6867f91 !  7:  58ebef7e757 pretty: clear signature check
    @@ Metadata
      ## Commit message ##
         pretty: clear signature check
     
    -    The signature check in of the formatting context is never getting
    -    released. Fix this to plug the resulting memory leak.
    +    The signature check in the formatting context is never getting released.
    +    Fix this to plug the resulting memory leak.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
 8:  0d503e40194 =  8:  c5813079d44 upload-pack: fix leaking URI protocols
 9:  9f967dfe5d5 =  9:  f66fa4e0e25 builtin/commit: fix leaking change data contents
10:  e3ffd59123f ! 10:  dac63bae39e trailer: fix leaking trailer values
    @@ trailer.c: static char *apply_command(struct conf_info *conf, const char *arg)
     +		char *arg;
     +
      		if (arg_tok->value && arg_tok->value[0]) {
    --			arg = arg_tok->value;
    -+			arg = (char *)arg_tok->value;
    + 			arg = arg_tok->value;
      		} else {
    - 			if (in_tok && in_tok->value)
    +@@ trailer.c: static void apply_item_command(struct trailer_item *in_tok, struct arg_item *arg
      				arg = xstrdup(in_tok->value);
      			else
      				arg = xstrdup("");
11:  5b851453bce ! 11:  82269e5d5be trailer: fix leaking strbufs when formatting trailers
    @@ Metadata
      ## Commit message ##
         trailer: fix leaking strbufs when formatting trailers
     
    -    We are populating, but never releasing two string buffers in
    -    `format_trailers()`, causing a memory leak. Plug this leak by lifting
    -    those buffers outside of the loop and releasing them on function return.
    -    This fixes the memory leaks, but also optimizes the loop as we don't
    -    have to reallocate the buffers on every single iteration.
    +    When formatting trailer lines we iterate through each of the trailers
    +    and munge their respective token/value pairs according to the trailer
    +    options. When formatting a trailer that has its `item->token` pointer
    +    set we perform the munging in two local buffers. In the case where we
    +    figure out that the value is empty and `trim_empty` is set we just skip
    +    over the trailer item. But the buffers are local to the loop and we
    +    don't release their contents, leading to a memory leak.
    +
    +    Plug this leak by lifting the buffers outside of the loop and releasing
    +    them on function return. This fixes the memory leaks, but also optimizes
    +    the loop as we don't have to reallocate the buffers on every single
    +    iteration.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
    @@ trailer.c: void format_trailers(const struct process_trailer_options *opts,
      	size_t origlen = out->len;
      	struct list_head *pos;
      	struct trailer_item *item;
    - 
    -+
    +@@ trailer.c: void format_trailers(const struct process_trailer_options *opts,
      	list_for_each(pos, trailers) {
      		item = list_entry(pos, struct trailer_item, list);
      		if (item->token) {
12:  60c3f6146f3 = 12:  a627e03702e builtin/commit: fix leaking cleanup config
13:  ea81cd8db86 = 13:  40e0c2a2cac transport-helper: fix leaking import/export marks
14:  b700ab9079f = 14:  ffa5d9eae7e builtin/tag: fix leaking key ID on failure to sign
15:  76bbcb3fe30 ! 15:  70dd0cb6933 combine-diff: fix leaking lost lines
    @@ Commit message
         The `cnt` variable tracks the number of lines in a patch diff. It can
         happen though that there are no newlines, in which case we'd still end
         up allocating our array of `sline`s. In fact, we always allocate it with
    -    `cnt + 2` entries. But when we loop through the array to clear it at the
    -    end of this function we only loop until `lno < cnt`, and thus we may not
    -    end up releasing whatever the two extra `sline`s contain.
    +    `cnt + 2` entries: one extra entry for the deletion hunk at the end, and
    +    another entry that we don't seem to ever populate at all but acts as a
    +    kind of sentinel value.
     
    -    Plug this memory leak.
    +    When we loop through the array to clear it at the end of this function
    +    we only loop until `lno < cnt`, and thus we may not end up releasing
    +    whatever the two extra `sline`s contain. While that shouldn't matter for
    +    the sentinel value, it does matter for the extra deletion hunk sline.
    +    Regardless of that, plug this memory leak by releasing both extra
    +    entries, which makes the logic a bit easier to reason about.
    +
    +    While at it, fix the formatting of a local comment, which incidentally
    +    also provides the necessary context for why we overallocate the `sline`
    +    array.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## combine-diff.c ##
    +@@ combine-diff.c: static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
    + 	result_file.ptr = result;
    + 	result_file.size = result_size;
    + 
    +-	/* Even p_lno[cnt+1] is valid -- that is for the end line number
    ++	/*
    ++	 * Even p_lno[cnt+1] is valid -- that is for the end line number
    + 	 * for deletion hunk at the end.
    + 	 */
    + 	CALLOC_ARRAY(sline[0].p_lno, st_mult(st_add(cnt, 2), num_parent));
     @@ combine-diff.c: static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
      	}
      	free(result);
16:  d6b96a4012d = 16:  b248f266a91 dir: release untracked cache data
17:  3aa6bac5079 = 17:  76e9a6d5792 sparse-index: correctly free EWAH contents
18:  132fe750906 = 18:  70f16486d77 t/helper: stop re-initialization of `the_repository`
19:  b8b702eeb28 = 19:  f056d31ca50 t/helper: fix leaking buffer in "dump-untracked-cache"
20:  ad309ac1b37 = 20:  714c9286e7a dir: fix leak when parsing "status.showUntrackedFiles"
21:  5e243f9ee53 ! 21:  0ff65c1213b builtin/merge: release outbut buffer after performing merge
    @@ Metadata
     Author: Patrick Steinhardt <ps@pks.im>
     
      ## Commit message ##
    -    builtin/merge: release outbut buffer after performing merge
    +    builtin/merge: release output buffer after performing merge
     
         The `obuf` member of `struct merge_options` is used to buffer output in
         some cases. In order to not discard its allocated memory we only release
22:  b75376e3725 = 22:  d9e122bb5db list-objects-filter-options: work around reported leak on error
-- 
2.47.0.229.g8f8d6eee53.dirty


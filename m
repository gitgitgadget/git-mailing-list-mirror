Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30441BF2A
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 09:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724318235; cv=none; b=hjbZSsCcsK4m7D8zKxqxHs7BvCnDy5aHhwnwYgESWDmqX/ohxSGP7cjEuqFVjx95y2JIRuUP+l5XJwUDA8UB9Vf6K+g2g5Qyz07lXTj+K9mFNxg7vNVhTWKszKLjtUKLQwspsYKU9Nwg7YeJi1PpOkWiDsv7k09UKzsfbzK1Dn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724318235; c=relaxed/simple;
	bh=sA0NlfOCOGrfMnVvDIduJXtp2cgHSRWwXq/wDTzZdkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZOMu4yyd1irDOLncUQhZpHUKvuvgZnB0w95PmcwuyWeQqoi7vzlideuQHCJeMV3pU6MyA2wBA1tHXhOhWduYyIGohvOmwMM8DMn0V8CNvxyjYdYPvQdi+LGbMNj0JwIEQRxQ9D33TRmsl+vRi14xBR2Y3lEtDzudCge24S5uj7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UnVJye5H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OXZtVGzk; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UnVJye5H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OXZtVGzk"
Received: from phl-compute-08.internal (phl-compute-08.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 0AA82138FF75;
	Thu, 22 Aug 2024 05:17:12 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Thu, 22 Aug 2024 05:17:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724318232; x=1724404632; bh=tbaX7BzxKf
	tcn/4191gZDNFoOezGlhkLIlgzF5W43bw=; b=UnVJye5HVZMRQ7vHmr+UJJu/oR
	t7gYxHfu7z0+ZsDzXTL3ffAjVpbjjhNyhCYY/3FRpI4FYpZGbSMpt/4GI6nTwiDN
	KQQ6F1TfCBzv6/NNkqaqMdVVXoDpcXWwfK9fT4MEfCzZnXHa545xo7aY7uWc4Ef+
	dcThejLuMBpOmteHx4kxgMG7s2ldj0yEj8VDM6vEEJM4FoPzdrOhRqPLzf5q6j/q
	QTdSp/OUKgx+vix5+QpdXDINNL+Gd+uorpuDeNjW1T+GD0ekNJMwb56u4YnUoND6
	2d9OuEHE/BSnigo4qOO0BsdCQ8jEQgCklH6VLHqlEOtkaodWZvPQA+bj7eWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724318232; x=1724404632; bh=tbaX7BzxKftcn/4191gZDNFoOezG
	lhkLIlgzF5W43bw=; b=OXZtVGzkxn2GyvryjubIQ4f9rF3PxEBV6DJByzwCv6H0
	FictECZr19jnAre1ekatxjgJ5QFNuKIkXfXocW+q/wlEoNOM/G6p73xipXBGR6z4
	4znDQEMCdk2O96oZWYLtdcLJgHpYrDc7Lzc1P7rED3OTvE8488hmHJCiI7O9MA5z
	lsmFrDQ4JXhqHgaZjRF9isd3re0u5NNaPgPuy/+Mnp7rzwkx7HVjjeBSxFDqsuMS
	/rvHnRo8BvEDc3G+oMxC92gYawZNNLC/0FJdb4Z6bCFBMmKRQCVWapuKjvlrTcwp
	8HfK7xkcybpb81XSj78Iww8OzAxotWTH1Ov9bggdZQ==
X-ME-Sender: <xms:FwLHZhFIGqOhkx47Q7go5BZ0jlvjLnRR_50lQNARGcRRD_zOnOYbog>
    <xme:FwLHZmURkoSv4DgWIfnW39YCuWFBfQWyoB2qij8OBHUahA8n2wFjB2Z-bxQspWLvo
    54derfltqEgs7ldbA>
X-ME-Received: <xmr:FwLHZjJ-TkSRuwA-nZGCNdg_7oPwmHWeWhANryoKwN7VG5Rz1_okzGKQNQioo4k4QI_nayfkmV96LEka5xTcUN2jVxDKsZJO55NPmkVjgipT4sE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvtddguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpedthfeiteevke
    eggeekleeiffehvdefieeggfevhfdthffghfeltdelgfdtieejheenucffohhmrghinhep
    hhhtthhprdhshhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:FwLHZnETyJFiV1PMOjDhfmGl2OJKbAdCasZC13EQeoO1kuW1xIN--w>
    <xmx:FwLHZnWRF_qwc8eSyFKuAv6Y-JSFGh_ResEk2H5bgddLp7gIJzDFjQ>
    <xmx:FwLHZiOpercYjVP298BjvnTvh0ti9lsVuecclZpkEr-v70WN2ZOoXw>
    <xmx:FwLHZm0HEQx7BhRbwiHI1E5fx2zT4v8n5Py4KrvItHpxrdlVarpfaA>
    <xmx:FwLHZkh4FU579x7sDfwoafimGL7T2iX_MckOvM8GjaRRhXykQ9nc9jgw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Aug 2024 05:17:11 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6088dacd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 22 Aug 2024 09:16:35 +0000 (UTC)
Date: Thu, 22 Aug 2024 11:17:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 00/20] Memory leak fixes (pt.5)
Message-ID: <cover.1724315484.git.ps@pks.im>
References: <cover.1724159575.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724159575.git.ps@pks.im>

Hi,

this is version 2 of this patch series that fixes another set of memory
leaks.

Changes compared to v1:

  - Remove spaces between cast and variable.

  - Clarify why we move the `ctx.entries_nr` block.

  - Adapt sideband colors to use `git_config_get_string_tmp()` such that
    we do not have to allocate the strings in the first place.

  - Fix more memory leaks for config values in the remote state.

  - Refactor `unbundle()` to not free extra args passed by the caller
    anymore. Instead, this is now always done by the caler.

Thanks!

Patrick

Patrick Steinhardt (20):
  mailinfo: fix leaking header data
  convert: fix leaks when resetting attributes
  pretty: fix memory leaks when parsing pretty formats
  pretty: fix leaking key/value separator buffer
  builtin/merge-tree: fix leaking `-X` strategy options
  builtin/upload-archive: fix leaking args passed to `write_archive()`
  builtin/archive: fix leaking `OPT_FILENAME()` value
  midx-write: fix leaking hashfile on error cases
  builtin/repack: fix leaks when computing packs to repack
  t/helper: fix leaking multi-pack-indices in "read-midx"
  transport: fix leaking OID arrays in git:// transport data
  builtin/send-pack: fix leaking refspecs
  sideband: fix leaks when configuring sideband colors
  builtin/fetch-pack: fix leaking refs
  remote: fix leaking config strings
  remote: fix leaks when matching refspecs
  remote: fix leaking peer ref when expanding refmap
  builtin/fetch: fix leaking transaction with `--atomic`
  transport: fix leaking arguments when fetching from bundle
  transport: fix leaking negotiation tips

 archive.c                           | 10 ++++
 builtin/archive.c                   |  7 ++-
 builtin/bundle.c                    |  2 +
 builtin/fetch-pack.c                | 20 ++++---
 builtin/fetch.c                     |  8 +--
 builtin/merge-tree.c                | 13 ++++-
 builtin/repack.c                    | 36 +++++++++---
 builtin/send-pack.c                 |  1 +
 builtin/upload-archive.c            |  8 ++-
 bundle.c                            |  4 +-
 convert.c                           |  3 +
 mailinfo.c                          | 17 +++++-
 midx-write.c                        | 24 ++++----
 pretty.c                            | 13 ++++-
 remote.c                            | 85 +++++++++++++++++++++++------
 sideband.c                          | 15 +++--
 t/helper/test-read-midx.c           |  8 ++-
 t/t4150-am.sh                       |  1 +
 t/t4205-log-pretty-formats.sh       |  2 +
 t/t4301-merge-tree-write-tree.sh    |  1 +
 t/t5000-tar-tree.sh                 |  1 +
 t/t5003-archive-zip.sh              |  1 +
 t/t5100-mailinfo.sh                 |  1 +
 t/t5319-multi-pack-index.sh         |  2 +
 t/t5400-send-pack.sh                |  1 +
 t/t5401-update-hooks.sh             |  2 +
 t/t5408-send-pack-stdin.sh          |  2 +
 t/t5409-colorize-remote-messages.sh |  1 +
 t/t5501-fetch-push-alternates.sh    |  1 +
 t/t5505-remote.sh                   |  1 +
 t/t5510-fetch.sh                    |  1 +
 t/t5519-push-alternates.sh          |  1 +
 t/t5536-fetch-conflicts.sh          |  1 +
 t/t5548-push-porcelain.sh           |  1 +
 t/t5553-set-upstream.sh             |  1 +
 t/t5574-fetch-output.sh             |  1 +
 t/t5703-upload-pack-ref-in-want.sh  |  1 +
 t/t5812-proto-disable-http.sh       |  2 +
 t/t6050-replace.sh                  |  1 +
 t/t7704-repack-cruft.sh             |  1 +
 transport.c                         |  8 +++
 41 files changed, 237 insertions(+), 73 deletions(-)

Range-diff against v1:
 1:  69e30ea5179 =  1:  69e30ea5179 mailinfo: fix leaking header data
 2:  ed0f01bf92c =  2:  ed0f01bf92c convert: fix leaks when resetting attributes
 3:  82f3908f962 !  3:  8a1963685e7 pretty: fix memory leaks when parsing pretty formats
    @@ pretty.c: static int git_pretty_formats_config(const char *var, const char *valu
      		commit_formats_len++;
      	}
      
    -+	free((char *) commit_format->name);
    ++	free((char *)commit_format->name);
      	commit_format->name = xstrdup(name);
      	commit_format->format = CMIT_FMT_USERFORMAT;
      	if (git_config_string(&fmt, var, value))
      		return -1;
      
     -	if (skip_prefix(fmt, "format:", &commit_format->user_format)) {
    -+	free((char *) commit_format->user_format);
    ++	free((char *)commit_format->user_format);
     +	if (skip_prefix(fmt, "format:", &stripped)) {
      		commit_format->is_tformat = 0;
     -	} else if (skip_prefix(fmt, "tformat:", &commit_format->user_format)) {
 4:  696467780e6 =  4:  1c368a4489a pretty: fix leaking key/value separator buffer
 5:  53db2fc7206 =  5:  c62c5e9604e builtin/merge-tree: fix leaking `-X` strategy options
 6:  5b05a325218 =  6:  afdd7f90b13 builtin/upload-archive: fix leaking args passed to `write_archive()`
 7:  bad575df126 =  7:  38487f3f65b builtin/archive: fix leaking `OPT_FILENAME()` value
 8:  5f042ce5098 !  8:  693c93ddbf7 midx-write: fix leaking hashfile on error cases
    @@ Commit message
         hashfile and finalizing it anymore this is sufficient to fix the memory
         leak.
     
    +    While at it, also move around the block checking for `ctx.entries_nr`.
    +    This change is not required to fix the memory leak, but it feels natural
    +    to move together all massaging of parameters before we go with them and
    +    execute the actual logic.
    +
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## midx-write.c ##
 9:  5c820da9761 =  9:  6bca72e5c57 builtin/repack: fix leaks when computing packs to repack
10:  9caf5eeea93 = 10:  48b60279d18 t/helper: fix leaking multi-pack-indices in "read-midx"
11:  8e12c55536d = 11:  0cb440ef648 transport: fix leaking OID arrays in git:// transport data
12:  5d8e0a3d8b4 = 12:  f4300c9326b builtin/send-pack: fix leaking refspecs
13:  5d09959b642 ! 13:  28805c15a42 sideband: fix leaks when configuring sideband colors
    @@ Commit message
     
         We read a bunch of configs in `use_sideband_colors()` to configure the
         colors that Git should use. We never free the strings read from the
    -    config though, causing memory leaks. Fix those.
    +    config though, causing memory leaks.
    +
    +    Refactor the code to use `git_config_get_string_tmp()` instead, which
    +    does not allocate memory. As we throw the strings away after parsing
    +    them anyway there is no need to use allocated strings.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
    @@ sideband.c: static int use_sideband_colors(void)
      	const char *key = "color.remote";
      	struct strbuf sb = STRBUF_INIT;
     -	char *value;
    -+	char *value = NULL;
    ++	const char *value;
      	int i;
      
      	if (use_sideband_colors_cached >= 0)
    -@@ sideband.c: static int use_sideband_colors(void)
    - 	} else {
    + 		return use_sideband_colors_cached;
    + 
    +-	if (!git_config_get_string(key, &value)) {
    ++	if (!git_config_get_string_tmp(key, &value))
    + 		use_sideband_colors_cached = git_config_colorbool(key, value);
    +-	} else if (!git_config_get_string("color.ui", &value)) {
    ++	else if (!git_config_get_string_tmp("color.ui", &value))
    + 		use_sideband_colors_cached = git_config_colorbool("color.ui", value);
    +-	} else {
    ++	else
      		use_sideband_colors_cached = GIT_COLOR_AUTO;
    - 	}
    -+	FREE_AND_NULL(value);
    +-	}
      
      	for (i = 0; i < ARRAY_SIZE(keywords); i++) {
      		strbuf_reset(&sb);
      		strbuf_addf(&sb, "%s.%s", key, keywords[i].keyword);
    - 		if (git_config_get_string(sb.buf, &value))
    - 			continue;
    --		if (color_parse(value, keywords[i].color))
    +-		if (git_config_get_string(sb.buf, &value))
     -			continue;
    +-		if (color_parse(value, keywords[i].color))
    ++		if (git_config_get_string_tmp(sb.buf, &value))
    + 			continue;
     +		color_parse(value, keywords[i].color);
    -+		FREE_AND_NULL(value);
      	}
     +
      	strbuf_release(&sb);
14:  1c94195488d = 14:  aac84c5a2b7 builtin/fetch-pack: fix leaking refs
15:  97346d6f944 ! 15:  532328b7814 remote: fix leaking config strings
    @@ Commit message
         We're leaking several config strings when assembling remotes, either
         because we do not free preceding values in case a config was set
         multiple times, or because we do not free them when releasing the remote
    -    state. Plug those leaks.
    +    state. This includes config strings for "branch" sections, "insteadOf",
    +    "pushInsteadOf", and "pushDefault".
    +
    +    Plug those leaks.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## remote.c ##
    +@@ remote.c: static struct branch *make_branch(struct remote_state *remote_state,
    + 	return ret;
    + }
    + 
    ++static void branch_release(struct branch *branch)
    ++{
    ++	free((char *)branch->name);
    ++	free((char *)branch->refname);
    ++	free(branch->remote_name);
    ++	free(branch->pushremote_name);
    ++	for (int i = 0; i < branch->merge_nr; i++)
    ++		refspec_item_clear(branch->merge[i]);
    ++	free(branch->merge);
    ++}
    ++
    + static struct rewrite *make_rewrite(struct rewrites *r,
    + 				    const char *base, size_t len)
    + {
    +@@ remote.c: static struct rewrite *make_rewrite(struct rewrites *r,
    + 	return ret;
    + }
    + 
    ++static void rewrites_release(struct rewrites *r)
    ++{
    ++	for (int i = 0; i < r->rewrite_nr; i++)
    ++		free((char *)r->rewrite[i]->base);
    ++	free(r->rewrite);
    ++	memset(r, 0, sizeof(*r));
    ++}
    ++
    + static void add_instead_of(struct rewrite *rewrite, const char *instead_of)
    + {
    + 	ALLOC_GROW(rewrite->instead_of, rewrite->instead_of_nr + 1, rewrite->instead_of_alloc);
     @@ remote.c: static int handle_config(const char *key, const char *value,
      			return -1;
      		branch = make_branch(remote_state, name, namelen);
    @@ remote.c: static int handle_config(const char *key, const char *value,
      		return git_config_string(&remote->foreign_vcs, key, value);
      	}
      	return 0;
    -@@ remote.c: void remote_state_clear(struct remote_state *remote_state)
    +@@ remote.c: struct remote_state *remote_state_new(void)
    + 
    + void remote_state_clear(struct remote_state *remote_state)
    + {
    ++	struct hashmap_iter iter;
    ++	struct branch *b;
    + 	int i;
    + 
      	for (i = 0; i < remote_state->remotes_nr; i++)
      		remote_clear(remote_state->remotes[i]);
      	FREE_AND_NULL(remote_state->remotes);
    @@ remote.c: void remote_state_clear(struct remote_state *remote_state)
      	remote_state->remotes_alloc = 0;
      	remote_state->remotes_nr = 0;
      
    ++	rewrites_release(&remote_state->rewrites);
    ++	rewrites_release(&remote_state->rewrites_push);
    ++
    + 	hashmap_clear_and_free(&remote_state->remotes_hash, struct remote, ent);
    +-	hashmap_clear_and_free(&remote_state->branches_hash, struct remote, ent);
    ++	hashmap_for_each_entry(&remote_state->branches_hash, &iter, b, ent) {
    ++		branch_release(b);
    ++		free(b);
    ++	}
    ++	hashmap_clear(&remote_state->branches_hash);
    + }
    + 
    + /*
16:  e1d0be37636 = 16:  440b3d99372 remote: fix leaks when matching refspecs
17:  773fe580d75 = 17:  662ec4e6484 remote: fix leaking peer ref when expanding refmap
18:  9ede792550e = 18:  dbd8eaa2cb1 builtin/fetch: fix leaking transaction with `--atomic`
19:  b72f7d1ee39 ! 19:  4c5740afe43 transport: fix leaking arguments when fetching from bundle
    @@ Commit message
         transport: fix leaking arguments when fetching from bundle
     
         In `fetch_refs_from_bundle()` we assemble a vector of arguments to pass
    -    to `unbundle()`, but never free it. Fix this leak.
    +    to `unbundle()`, but never free it. And in theory we wouldn't have to
    +    because `unbundle()` already knows to free the vector for us. But it
    +    fails to do so when it exits early due to `verify_bundle()` failing.
    +
    +    The calling convention that the arguments are freed by the callee and
    +    not the caller feels somewhat weird. Refactor the code such that it is
    +    instead the responsibility of the caller to free the vector, adapting
    +    the only two callsites where we pass extra arguments. This also fixes
    +    the memory leak.
     
         This memory leak gets hit in t5510, but fixing it isn't sufficient to
         make the whole test suite pass.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
    + ## builtin/bundle.c ##
    +@@ builtin/bundle.c: static int cmd_bundle_unbundle(int argc, const char **argv, const char *prefix)
    + 			 &extra_index_pack_args, 0) ||
    + 		list_bundle_refs(&header, argc, argv);
    + 	bundle_header_release(&header);
    ++
    + cleanup:
    ++	strvec_clear(&extra_index_pack_args);
    + 	free(bundle_file);
    + 	return ret;
    + }
    +
    + ## bundle.c ##
    +@@ bundle.c: int unbundle(struct repository *r, struct bundle_header *header,
    + 	if (flags & VERIFY_BUNDLE_FSCK)
    + 		strvec_push(&ip.args, "--fsck-objects");
    + 
    +-	if (extra_index_pack_args) {
    ++	if (extra_index_pack_args)
    + 		strvec_pushv(&ip.args, extra_index_pack_args->v);
    +-		strvec_clear(extra_index_pack_args);
    +-	}
    + 
    + 	ip.in = bundle_fd;
    + 	ip.no_stdout = 1;
    +
      ## transport.c ##
     @@ transport.c: static int fetch_refs_from_bundle(struct transport *transport,
      		       &extra_index_pack_args,
20:  e8f479deeb2 = 20:  c3d2b035761 transport: fix leaking negotiation tips
-- 
2.46.0.164.g477ce5ccd6.dirty


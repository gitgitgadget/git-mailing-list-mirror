Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D946513D502
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 08:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731917173; cv=none; b=hqMauCe/LPIM7fcySKsZFMdfYbNhex+APUnW0USyPU6O+dqafDAQw9RO+qyo8w+8Z90VofnJ6CnOBGsifKI1UsHDKBR/TllVJv4JIGqu25eaidD+wTqJ5enqK9k4JqqqyYMoKBUqY2IEahKWFuqfxf9PHp26HLWJQBiidly4Gcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731917173; c=relaxed/simple;
	bh=NMiqtZvpJSy8woN+1kxm5usGp4UyuJDqzE3VOZFktPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mT44dT702lQjFR+E5kAd99OZh3kXpsASCS+Bzx2LAnBXR1ICUdTB2h2yI8QTv5P1SOymFKB+FN4ymQdI01KNGKN+v8Im1fIBfjq+q1otc5vuGNr4ueMzPGlRl0ukpdire6Vp/YBz4GuPeruA4m8dLf0bJGrbJITsL8ehybBAE8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=B+70XhJm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BxUeIcr8; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="B+70XhJm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BxUeIcr8"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E72C425400DB;
	Mon, 18 Nov 2024 03:06:10 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 18 Nov 2024 03:06:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731917170; x=1732003570; bh=51aSSRfuRB
	ra4huqLgIwzEfRc9IqTUhtZ31jPf/Ac3o=; b=B+70XhJmQyjD0jnSbdivdljhaE
	1fqG0y7pIAn1Z/zTh7aRMnpryh5Jhpx84iyy9DxVDAB1AtxDzDH1DfQjPtsBX3SV
	B5dJjK2B4R991vy5imhcd8t8kDn6xv35AJRlf/jNIMfq0u+OWe/ZO6+MpVT9B7lB
	DXyA4Z4gNMgaiUAp7RAAXWdftvlKPcAsmIr9KAVxpHkYdXzmALdJlclrjL2t06Xb
	ZYAHXOaT7P+IecRMTxbK+UvRcGGJFMDviPUfzRgbkzk/9OYf3c3DaCU4ZxzUvjEh
	NzlxvWbh7vidPe+FDnYFznnk2gJbMS/hs8mg/tPr3m515r25kVA8l1k9fHwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731917170; x=1732003570; bh=51aSSRfuRBra4huqLgIwzEfRc9IqTUhtZ31
	jPf/Ac3o=; b=BxUeIcr8oHYCtcOQLesMITAtBFnWQOI+7gAT70eIASQXYIZKNz7
	SCHHoCNPccUCShKrojF+5hUwDT98xpXkcJy/ADcRMUJKejXmAtVheOj7501CcxQ7
	nVVp/OzDk07yMRv/na15cEFiM9790GxMd45La1Fyny5P6tF3FAE6kbwpz6XNE8/k
	jy6sI0YXJPCRb8y8TtLZYPpDs+XG0fdpBHmnS8VDIhM3HkxTFx6u8tiEAEm0ckO+
	YXykVw/s/Fz2u3GELNaOCeZBWHGlafiv4OuJIuyY09z51IKHVyNHy8rEcLUMFgvn
	gZsaIhtxVM3AeeD8ChhAaxX8i7PPlO2XLtw==
X-ME-Sender: <xms:cvU6Z0eTwR51-GATQSvUQGGDr9EfqxXOWD80jj4CR6ntEljas5-ptQ>
    <xme:cvU6Z2ObJ6Iddif0IK5Z-abhDYHeTa-4MPrgY3NYjBU18QNxUM_0MgPo-MdBNMkq-
    _t-DjdFbnezF2MwlQ>
X-ME-Received: <xmr:cvU6Z1hzHLGtdXHjP5T8BOVs3UCHA35H68Zw9LItB6QQztjbpb6C2AlRpOgzCTHrrFXBVY2aOizg6yJE2zkMCrPuqLwNqiaUKBP5jfekQYrRoSz0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdelgdduudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    hkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgr
    hihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:cvU6Z5-YweLpX4CQX6qxInioLeivCtj1h8ztvRN4kk2XwErB8E9ugQ>
    <xmx:cvU6ZwuaZExO08gqc1nEaWvej_tNe1q_2-q3NZyDEHXmPnzSg8VrXg>
    <xmx:cvU6ZwEVRvbKFRM-v64wT5PnbyUW-DqH31EASEFowc7HXC0LMk6PlA>
    <xmx:cvU6Z_NoP4AJBAdq61rk3U_2p1tETd2VZ3dInS5GvMdBVBzwSfDIUQ>
    <xmx:cvU6ZyIDbFfZjWbrqZbfe6HxA2McaC5IcJ-41DTuGhff6JTTfJrjqrp7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Nov 2024 03:06:09 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0905b0c2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 18 Nov 2024 08:05:21 +0000 (UTC)
Date: Mon, 18 Nov 2024 09:05:59 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, me@ttaylorr.com, peff@peff.net
Subject: Re: [PATCH 3/8] midx-write: pass down repository to
 `write_midx_file[_only]`
Message-ID: <Zzr1Z7UEL9nCrybP@pks.im>
References: <20241115-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v1-0-761f8a2c7775@gmail.com>
 <20241115-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v1-3-761f8a2c7775@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v1-3-761f8a2c7775@gmail.com>

On Fri, Nov 15, 2024 at 02:42:16PM +0100, Karthik Nayak wrote:
> In the previous commit, we passed the repository field to all

Not quite accurate, since the preceding commit is instead passing the
repo via the context, not adapting the subcommands.

> subcommands in the `builtin/` directory. We utilize this to pass the
> repository field down to the `write_midx_file[_only]` functions to
> remove the usage of `the_repository` global variables.
> 
> With this, we remove all usage of global variables in `midx-write.c` and
> so we can remove the `USE_THE_REPOSITORY_VARIABLE` guard from the file.

Note that we typically use imperative commit messages, as if we were
instructing the code to change. So you should likely drop the "we" both
here and further up in "We utilize".

> diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
> index 85e40a4b6d3e47e9ec1ec27c094455e5ba75b5b0..2a938466f53aaa11096170554fe11a4ed46a25e4 100644
> --- a/builtin/multi-pack-index.c
> +++ b/builtin/multi-pack-index.c
> @@ -120,7 +120,7 @@ static void read_packs_from_stdin(struct string_list *to)
>  
>  static int cmd_multi_pack_index_write(int argc, const char **argv,
>  				      const char *prefix,
> -				      struct repository *repo UNUSED)
> +				      struct repository *repo)
>  {
>  	struct option *options;
>  	static struct option builtin_multi_pack_index_write_options[] = {

One thing I've briefly wondered: do we actually need the whole repo, or
do we only care about `packed_git`? I would have assumed that it should
be the latter as an MIDX only gets written for packfiles, but that is
likely only a naive assumption.

> diff --git a/midx-write.c b/midx-write.c
> index a384f7ddc8a396d0cffd528132bb8fcdc6b37e24..5af29899bbe279c7c3ff4bc2c65330620ce37ee2 100644
> --- a/midx-write.c
> +++ b/midx-write.c
> @@ -1,5 +1,3 @@
> -#define USE_THE_REPOSITORY_VARIABLE
> -
>  #include "git-compat-util.h"
>  #include "abspath.h"
>  #include "config.h"

Nice.

Patrick

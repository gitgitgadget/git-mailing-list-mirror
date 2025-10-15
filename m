Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308BC2D6625
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 21:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760563730; cv=none; b=DV6JmsK5mQDYwP9C9t1lGcJuSZ1H03sAP44rfnO+OyK/epo51U81TshNP8twO57elxlAOPe1lTTQy8J1Nopr9aKV9PkPjmjyZ75RgTS9GGixmcUu5j5JR2urvJLp3l+6zOULBMfEe6tykQ9rMhRy2iOG5beIj5tunwyHsq9+uwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760563730; c=relaxed/simple;
	bh=SSJieeKFWleUnguzUpg9e4cKFtjj/t4cCJvR07THYkQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jd8WTcofMVqEIBnB4qilKnORlZ6JtXa5Y0z/tGeaX49jpmcxhcfH6VZrUtzDNXH6G4S3MFFTtwAJOHGBHAM81vBDzFcT6mDWRhqAKJuyC+2l4G9S41nrZTunC/ollfR9JvZW9OpwQvTNeo3J9324bbINrnkEZUOoT6FMG59/S9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GQgptpUc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gn9dVpAb; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GQgptpUc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gn9dVpAb"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 42927EC0272;
	Wed, 15 Oct 2025 17:28:47 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Wed, 15 Oct 2025 17:28:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760563727; x=1760650127; bh=1GdesaqGob
	+Dm7GuuVcTiSN0vq89ROBG8l7C06caBrA=; b=GQgptpUcH78cVmHrnq1o5YXas1
	wXx47XpK/Os8cbpO2UE1DQXGlVPrf5Qb2Woe0vp2Og87MiJgRyOyazOnAZKBZDAe
	Aj7XnWuGxutQ3L01DMxRwtzvn4Hx1MciDrEUIDlJxx6Mqi/ZahqT5gTnv2BZ4QuF
	XtNgqwywnvCVzTy73lOv8mqTi5xsTyqL0elvR8RwPtjfXwvyzp1FrzhueTqk1fd2
	f4IJoccord1w9Dn7Jj80/CgE9zfyydCHhbkgCNxvlfQghN6QJx8NJe57aPBtxxbF
	CCFmDi9IdDMOxDcGruniesoYL1Jnct3se7Do+6b4vr7roSAohx9SAIux4pUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760563727; x=1760650127; bh=1GdesaqGob+Dm7GuuVcTiSN0vq89ROBG8l7
	C06caBrA=; b=gn9dVpAbgFJD/bVf9QzWz950lPWlgJJOw9B2YJBH8+7BPUGVzgL
	9+p2dO4O0eE0AMv93400TQclaMLmgvLS+Ctnh1Vt9Vwegm7UG+oD/VvF6rmK+Nbx
	jZkBn8WG+r1SD4FczYcBQ/JOtkFb3w69AC8MmLtj4mDTS3VW3/7Qo3fLsPb41QNy
	Jkp7BoWITkyUw6r46B8kIVf30HV+FUGDUG7vF12AoCoLEJqaN+9/SdJTO58CXOb3
	5EvcabQNOqyOyf05gsRMrTZFWpk5IamZZcRRTRTnpEOjdqye4Agw/xxtJ1SjEsX+
	o5FlQreWlU3DOXP8E56WLp1MKHhZ82Gp56w==
X-ME-Sender: <xms:DxLwaAiU0afKlVvUJxyGPfk-EtBL2TLIzVN_NHNkzqtHpX_cBMKygQ>
    <xme:DxLwaAD4yYlOJ0_u1cSRsnfmgg18daqo5OzWh9ZaMxvvbyEBqZc4FhCujr_LAfUr1
    iiQy3yvHwmBlgW8C_NbKkWnC7zKKWEgJBb2OhEPqvqoevgTer5e>
X-ME-Received: <xmr:DxLwaNGluC3xV-eeNOrjDxVcGLkDsMzfz2jUJGrbW4xzwEa1mrsmbi9R0qoq5oulPbITHYZ__DrxohDSYsm44qywBLl9qqFk83_3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdeggeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepffeiteeujeevfeehuddvjeduffeijeegfefhtddvkeefjeejhedtgeefgfei
    jedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgiivghkihgvlhhnvgifrhgvnhesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:DxLwaAJuZFBXyN5wKO1mhra9WG2RYbb-m0xfxEkBnko-y4W0iXA9qA>
    <xmx:DxLwaJnYsUhfkivhmBhV4Z2twb3rSp9FQQCUEYTHNiuulzlaymDkVg>
    <xmx:DxLwaAT99GUwe20ZV-Lm8FCdqivqDqXeEviTQ77rOurOTzJYGla7Mw>
    <xmx:DxLwaDJmPMTnJm662Q9EEBOrONEk8JVeE6KTV-kyOP1jrQJPkF6Ojw>
    <xmx:DxLwaEnbBV0pBKB9fAylprRUGjhlY4dccQJRybXlL0qenC9YVBT6AWBD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Oct 2025 17:28:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH 0/9] Xdiff cleanup part2
In-Reply-To: <pull.2070.git.git.1760563101.gitgitgadget@gmail.com> (Ezekiel
	Newren via GitGitGadget's message of "Wed, 15 Oct 2025 21:18:12
	+0000")
References: <pull.2070.git.git.1760563101.gitgitgadget@gmail.com>
Date: Wed, 15 Oct 2025 14:28:45 -0700
Message-ID: <xmqqa51rua5u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> The primary goal of this patch series is to convert every field's type in
> xrecord_t and xdfile_t to be unambiguous, in preparation to make it more
> Rust FFI friendly. Additionally the ha field in xrecord_t is split into
> line_hash and minimal_perfect hash.
>
> The order of some of the fields has changed as called out by the commit
> messages.
>
> Before:
>
> typedef struct s_xrecord {
> 	char const *ptr;
> 	long size;
> 	unsigned long ha;
> } xrecord_t;
>
> typedef struct s_xdfile {
> 	xrecord_t *recs;
> 	long nrec;
> 	long dstart, dend;
> 	bool *changed;
> 	long *rindex;
> 	long nreff;
> } xdfile_t;
>
>
> After part 2
>
> typedef struct s_xrecord {
> 	uint8_t const *ptr;
> 	size_t size;
> 	uint64_t line_hash;
> 	size_t minimal_perfect_hash;
> } xrecord_t;
>
> typedef struct s_xdfile {
> 	xrecord_t *recs;
> 	size_t nrec;
> 	bool *changed;
> 	size_t *reference_index;
> 	size_t nreff;
> 	ssize_t dstart, dend;
> } xdfile_t;

Excellent summary.

>
>
> Ezekiel Newren (9):
>   xdiff: use ssize_t for dstart/dend, make them last in xdfile_t
>   xdiff: make xrecord_t.ptr a uint8_t instead of char
>   xdiff: use size_t for xrecord_t.size
>   xdiff: use unambiguous types in xdl_hash_record()
>   xdiff: split xrecord_t.ha into line_hash and minimal_perfect_hash
>   xdiff: make xdfile_t.nrec a size_t instead of long
>   xdiff: make xdfile_t.nreff a size_t instead of long
>   xdiff: change rindex from long to size_t in xdfile_t
>   xdiff: rename rindex -> reference_index
>
>  xdiff-interface.c  |  2 +-
>  xdiff/xdiffi.c     | 29 +++++++++++------------
>  xdiff/xemit.c      | 28 +++++++++++-----------
>  xdiff/xhistogram.c |  4 ++--
>  xdiff/xmerge.c     | 30 ++++++++++++------------
>  xdiff/xpatience.c  | 14 +++++------
>  xdiff/xprepare.c   | 58 +++++++++++++++++++++++-----------------------
>  xdiff/xtypes.h     | 15 ++++++------
>  xdiff/xutils.c     | 32 ++++++++++++-------------
>  xdiff/xutils.h     |  6 ++---
>  10 files changed, 109 insertions(+), 109 deletions(-)
>
>
> base-commit: 143f58ef7535f8f8a80d810768a18bdf3807de26
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2070%2Fezekielnewren%2Fxdiff_cleanup_part2-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2070/ezekielnewren/xdiff_cleanup_part2-v1
> Pull-Request: https://github.com/git/git/pull/2070

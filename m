Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76A318E1F
	for <git@vger.kernel.org>; Thu, 26 Dec 2024 21:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735249120; cv=none; b=SpmZUTAeVGXZg66Z0sk4B/LJqqhoVKUyv2L0gmAMWnVnhOonFJNrj6LE0jcMWDY+8kZfjK/cBNesCFabnNWYhD8H15uceXv8UnorAWIuzC9Mv9MS6gziv00ZpjR9zVMR2qwNS7cTX+3tM82FcXTksu3qe1+ms/aO97eek8RwGkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735249120; c=relaxed/simple;
	bh=w+YajyIJ6S2K4dUWzC4OVWpuBKoDimYCamwhEmBQe1o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CSClTQc0nyzp44lmmBVgyWRQT9U1iIkR8WqcKFbpNTvasbRWexQdXd+gV/FBxjk6I9Vw4P+kqMcApnBh+1frkmcPsuLAaDYnyrAYxLDHRDnG2jNOjLPmR3TM9BDwC71dx/Cgn8t9i454i4964MhP8wzUYljFgkR+uOOv6Kq18fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=uA7HvyYk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=v4/glwUT; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="uA7HvyYk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="v4/glwUT"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EECB8114016A;
	Thu, 26 Dec 2024 16:38:37 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 26 Dec 2024 16:38:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1735249117;
	 x=1735335517; bh=Iz3xJPMvOcOi3StaSs5B1pkx2mzj78jCnF+u5hICIxc=; b=
	uA7HvyYkwmKuv2e8rWT8tSYnVSikoi891nwMl1VlHCZbFgIbFs2pQUaobGNEtpPp
	nvLto+KzPdjkugcZa/cppqpYjWgaXdDovCxcgxkEFvphOPV2nS/IuQrJJxfjVLDc
	S+Q2TBa+SKgSLw2ljj2o5w20fehmKVGqcgHqLiD5kc4fJ++ibJQBDuKvfr1OhK7k
	IMokcAAR7EumkOMc2FskPMdA9kcvJZcSgqMmGDxcVZGa4FpVivV4aSOradfbGehE
	q3HONzlicw3KBVy0JMJ5jFdYIcRjTjDkry4SEbXMZ6wDgDww+mxCA0XH5lAJJ7sG
	gJufD6ZM846ujqao9EJSmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735249117; x=
	1735335517; bh=Iz3xJPMvOcOi3StaSs5B1pkx2mzj78jCnF+u5hICIxc=; b=v
	4/glwUT6NL1CmWN2ZWQVj2eMHjuuoWdTS1eZNQnRANoboYe25oJ+Y1hLMAtUYDX7
	rhy/Oi1itLXg+qCs0QYl0lvaVQBJWG16syuGva62Y9ud9hKoAnR9msygOdec5Utx
	OjidtriZfGjscbyaYF0AwPBFqsyc+coXRDTcR2t9qWFed9UMEbFhEcSTLU2Ho+AQ
	LT9Vw5j7F1KpAqqRIQQLjcu8hgp8mafnxiGs2mroNeFrpcw2AoWgQHMxcXTcnPw2
	9xAdCHA++v/AB/AKv5go2z+sAwqWEDDBsaChdajR936ZTc4YIB9BWQE3P0lHQ4dG
	ad5fuB0j02HZaQP8qojow==
X-ME-Sender: <xms:3cxtZ131yhi_GuDgvxG-AF2G1KDoPj6xkdiTOyEcbnK_hjd0YbynuQ>
    <xme:3cxtZ8EijgY_HWUrGMa-yiNjrphxS660czuf184alrVgxomA-sJzYvO3gtfSQptv1
    gD_WW6d3M7epYNI4Q>
X-ME-Received: <xmr:3cxtZ16KCt0jhVbRiqJEsCexFh_SJt5LL8kdrmQA2_voaHbC2KlBOeF7L5fkLWRMIxIipmiZui4XFg5dMWddlMahcskXMrtQbg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddukedgudehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihhoucevucfjrghm
    rghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpe
    dtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveevfedtheenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehsohgvkhhklhgvsehfrhgvvghnvghtrdguvgdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:3cxtZy3KWO2TM5LGzFhnFJ2L6sPYo1ot-lIYXUoxjXgb-EDrI3G99w>
    <xmx:3cxtZ4FHMniGbVvftV1iPHZ_QwfVu4QKgHkfIQ4XTFkJVyoGmxboyw>
    <xmx:3cxtZz_0eKPdMKhBWM617LIxOBjJTbvGBQOAe5m_5Bjz4s5ZwUaKGg>
    <xmx:3cxtZ1kqooRipSHC1FVrbqgdcdP_S-tG8VCoBCQDmi1J3rl_jzye1w>
    <xmx:3cxtZ8ACDoaSM6OySmL-npRTfkOEBGqeHA0J6i74ukgXgwh2VQ-6RYo8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Dec 2024 16:38:37 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?S=C3=B6ren?= Krecker <soekkle@freenet.de>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/4] commit.c: Fix type missmatch warings from msvc
In-Reply-To: <20241223110407.3308-5-soekkle@freenet.de> (=?utf-8?Q?=22S?=
 =?utf-8?Q?=C3=B6ren?= Krecker"'s
	message of "Mon, 23 Dec 2024 12:04:07 +0100")
References: <20241223110407.3308-1-soekkle@freenet.de>
	<20241223110407.3308-5-soekkle@freenet.de>
Date: Thu, 26 Dec 2024 13:38:36 -0800
Message-ID: <xmqqttaqw2eb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Sören Krecker <soekkle@freenet.de> writes:

> Fix compiler warings from msvc in date.c for value truncation from 64
> bit to 32 bit integers.
>
> Also switch from int to size_t for all variables with result of strlen()
> which cannot become negative.
>
> Signed-off-by: Sören Krecker <soekkle@freenet.de>
> ---
>  commit.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/commit.c b/commit.c
> index 35ab9bead5..3d363260f3 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -466,8 +466,8 @@ int parse_commit_buffer(struct repository *r, struct commit *item, const void *b
>  	struct object_id parent;
>  	struct commit_list **pptr;
>  	struct commit_graft *graft;
> -	const int tree_entry_len = the_hash_algo->hexsz + 5;
> -	const int parent_entry_len = the_hash_algo->hexsz + 7;
> +	const size_t tree_entry_len = the_hash_algo->hexsz + 5;
> +	const size_t parent_entry_len = the_hash_algo->hexsz + 7;

We saw another change around hexsz in this series, but I seriously
doubt that it is sensible to define .hexsz member of git_hash_algo
as type size_t.  The whole _point_ of hash function is so that it
can be represented by a handful of bytes, so insisting size_t and
forcing us to suffer code churning like we see here is simply crazy.

Would it work equally well, if not better, if you instead fixed the
type of the .hexsz member (and its friends) to something more
reasonable, like "int"?

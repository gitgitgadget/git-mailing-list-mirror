Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4C7287259
	for <git@vger.kernel.org>; Wed,  1 Oct 2025 21:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759353554; cv=none; b=jGtpNmASAwxK9yDEf72NyVCrH/1AebtCuTDxbUfVhkOHnQFwHdz6p3XYirsgSzsVVjshl9FxMYJ2fh+RhKoqKDj0MR9YWgOYlryfU+sy7nd1tUuP50l0b9428MU4eAVPG3XqXpAoglEUGIdHs8TEVDy4GVts9+TptA3DwGwt1vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759353554; c=relaxed/simple;
	bh=X6YRmEvurbSju6Som3dGFSnlcmu7A+eviJ0DdP9mEIk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JRVgcHfOL9RSLFMGlCBnEKxqBYUnUuyRDrPMqV0OTS2GG1gzOmd5DNYTFS5hnHU+3CqR934n7MlfIHWNWsiOSRWpdiGk/xjoSGF/K5ngJbdB/YfLlXnKCHajj0YsA1PBJntvtBp3Rbo6h/rvCvdMjqd26DY5RaowbSVZ7dqhJfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=h21LlxuB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iZj99Le3; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="h21LlxuB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iZj99Le3"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4EFBC7A0186;
	Wed,  1 Oct 2025 17:19:11 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Wed, 01 Oct 2025 17:19:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759353551; x=1759439951; bh=WQIH1woQCJ
	K3ORLul420SCBsHVZ4ztRrZEol8hV6IkA=; b=h21LlxuB8TopbCSeUE5mnN0Abf
	SCmnSb/P9EVxEgO1NwBGRPRZsY42XF/xHlv8vCKCtD7DNkIxLe1fsQd49Z9doewU
	6+yNCsPhctXYjYGj3zjlmveKU23CZ5G9UggxsZQp6z5+PDabHG4xbPm8KnDSlX1y
	meuLky5mJ5OezK8VNErgDkeP2pyuK58/lOKXOnKz7mnH6CNeVSDCn1O599UeyIod
	RdP+cee1mekksvneS6NXqBMsPo+ghkvUtjgPBscK4n2oUnC1dKpQuDsDKs7seMQG
	lPvQqbATw66OWl+DJDYtdqBVXNCJq1UVeNWgMVB8theA7dT96YlnfUu2zLcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759353551; x=1759439951; bh=WQIH1woQCJK3ORLul420SCBsHVZ4ztRrZEo
	l8hV6IkA=; b=iZj99Le3fDFpq3K29JkBlxpBGUNbyuM8wOzWzAAwdEEREAkVItx
	UAqeG6LgCZ4JQ61j4kC0GL8LnzBUOiB1UHc5K3wPm9rlr5Us+YNDrIWpyQdZ/NtU
	jDImLXYKBarnNxpEdM91ekRaeX94gv9ynDOQb4xiBbXy1Rfu+pJh4NulWLNwZDvI
	CiYP3/S6X8WLLuiuebyHstyCzQ/JPGel0TZ2URfb62sgMO1k4nYXAdh9EpPPkMqB
	l15/LEOoPf3zfVkRXLHosFA0okwLkPQ+iPHMKPGlZZvk1ULMfy5ciPNdKC9DXp7W
	r46D+IllZ/rYfN8dGxA87P0p6A4K83uciKA==
X-ME-Sender: <xms:zprdaBG5sLlLlBngNmPlg6utGCXEyNX4D8IG4ivDpXw1FEqg2mtyfA>
    <xme:zprdaNXSXpN1m54FJcKXvntcKlRC-4QZZLYuLOPwVcXBRdBLFDvXm3Bf5Km-Eb069
    D456njYJhcDWYRWa2aQveMZKJIx_Cq_zrOiq3mRtXq-waCrfmIP>
X-ME-Received: <xmr:zprdaIIwEXGblUB6nYHQ414Q6htmSqvmvF7RjPWDT64rUI1uvjVWkFq-6BPg8Rs0g4RkVhyCereib2-2xiZr1vYgYUfgwHvBtmnE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekgedvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgesthdtredttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhephfffgfektedvhfejfffggffgvddvff
    ejiedvffffkeejleevgeefkeekvdevteffnecuffhomhgrihhnpegrlhhgohdrnhgrmhgv
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehsrg
    hnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:zprdaF-B3uIriKt0PYzsNNyocdi0blGSeGaLqS8Y6NOuifxraYWkmA>
    <xmx:zprdaDKlzdMpUHSM5OUjigSGkYnFkxqqKhohWCEjd08o32o3U-IOKg>
    <xmx:zprdaCmQqOUMGZ00YU-oSFQLfMJok2rYTrZ2suVXcowV50rR8XfCMQ>
    <xmx:zprdaPNKATYd6RyL5UlPd1-73t-L5N7F_TdlKH0B5zKXNluE7GlrNw>
    <xmx:z5rdaCKVx_FjOpK6ECml58zLlsX6KHGfALmtZ-0L5L70854dwd8r0Dfv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Oct 2025 17:19:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  git@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] Define an extended tree format
In-Reply-To: <20251001211140.GA140550@peff.net> (Jeff King's message of "Wed,
	1 Oct 2025 17:11:40 -0400")
References: <20251001005814.846992-1-sandals@crustytoothpaste.net>
	<20251001005814.846992-2-sandals@crustytoothpaste.net>
	<20251001174110.GA137600@peff.net> <20251001211140.GA140550@peff.net>
Date: Wed, 01 Oct 2025 14:19:09 -0700
Message-ID: <xmqqy0puz5f6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> The other unexpected thing is that the sequence above works today! I
> think it is mostly accidental, though. When we read the head of the
> submodule, we get a "struct object_id" with a different algo field. But
> we never pay attention to that field, and just treat it as if it is
> using our native algorithm.

Yeah, I recall that there was a discussion about this exact "yes, we
get by fine with SHA-1 commit object name 0-padded to the right,
when embedding SHA-1 submodule inside SHA-256 superproject",
countered by brian's "no, it may happen to work but you shouldn't
rely on it" recently.

> So it all works as expected, but I feel like it's mostly by accident. My
> gut feeling is that we probably wanted something like this to protect us
> from confusion:
>
> index 06ad74db22..295b0c6318 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -719,6 +719,8 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
>  	if (S_ISDIR(st_mode)) {
>  		if (repo_resolve_gitlink_ref(the_repository, path, "HEAD", &oid) < 0)
>  			return error(_("'%s' does not have a commit checked out"), path);
> +		if (oid.algo != hash_algo_by_ptr(the_repository->hash_algo))
> +			return error(_("object format %s of '%s' is incompatible with this repository (%s)"), hash_algos[oid.algo].name, path, the_repository->hash_algo->name);
>  		while (namelen && path[namelen-1] == '/')
>  			namelen--;
>  	}
>
> Of course that is strictly worse for somebody who is relying on the
> current accidental behavior. ;) And in the long run, I think this is the
> spot we'd want to hook to do whatever massaging we need (whether
> converting to the equivalent in-repo algorithm, or hacking up the name
> to store the foreign hash).
>
> I also won't be at all surprised if you've run across this already in
> your interop work.


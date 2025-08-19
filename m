Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF6030C35E
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 18:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755629820; cv=none; b=qXqP5JeOGW2PzvCPKiRJlUXNKf6JJX9InxjO3uKYrmtM2u/0wgC3fCkPLDKePjWLsHixRMdD4RA2UN57i3nWRa6v+AUfbjqEDDEQCiCp3awuEWLK9czORpFuzqelblckj7HSwY7mRmmc5Fc7hPfT0fSPDwk2QM9SvxoNLHpR2EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755629820; c=relaxed/simple;
	bh=eqnBSvj3/ohNJq19gGlAsqPPMtKypbVKmacq5NrCdBs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t6xX6DzrwgVtsbiX/cAHlPqdQwZd2StBtJjSyrxBRbVIp1X+fKnTO7lrFMxUkaOiHD/94CgmrxfgGyGmVAw+L4RUjhxPC/1Ka+MvvnYZEbrWo6oj4lzqYRxweEFcZ1N8sjS1fgO+95qKVPbnv4iiOODb4+v1oE8C57P0hKJbFnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TIqPJ9CN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NpTPXGja; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TIqPJ9CN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NpTPXGja"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BE8CB14001A2;
	Tue, 19 Aug 2025 14:56:56 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Tue, 19 Aug 2025 14:56:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755629816; x=1755716216; bh=ThmbUCccOj
	oetLVyMFc+GS6OPmfQ4DC0xfRHv8A1loU=; b=TIqPJ9CNQUIBjcUpzIFwckxxTh
	TwlAjSiWWawP6Wfa1Yg8JtRPLWQQMDxeiPeuZIN36chejrBp1PWOzlUiFyrmvcGf
	w05U9EI5JMdDDTxJnvrIiHmiU/pxhJNmUnvitlANY1w+IgFyBSe5ZB8qH0oHXgsC
	FfyrnG79kw1x6c1IlfNqMLEFum5UqBOSS9TQAZgkimiglGncsX+3K5y90cW2ZLFE
	0ibS7wTfLGiVN7u0ClgqVcNaxUal9hxA3e4tu3LwcXkvKKMuJiYE8eA7nApx4oX5
	5udCke40LLZbULUE0572nqycULS/B99AIJ4sXIlXB9WMrCuqQGEzmPvLKtuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755629816; x=1755716216; bh=ThmbUCccOjoetLVyMFc+GS6OPmfQ4DC0xfR
	Hv8A1loU=; b=NpTPXGjaA1Echh+4CEZ8X9d4Ecx+yjXwngahJ6cGdI1+saTMqQ7
	BFLHUdDSW7+rIJUAYNpXu74V3fjzc5tRN+Qm85BKMBHoC/TqCdxa18uSlVAg6CBO
	Diy/MFceLys9cmUjPWT/n0rAwPCxie7Sb1TNGjefFFXapg+d7vexoZXK3CRTe0TZ
	Iyh+UQ2zvgn+eiUuU19afTBjYIizrTwHEzElI5aulv1Exc4uzCJl/HtfoIlYsou5
	XGKwMde91oA0VX/Nnnn5lFlGVFvx/jrsSKLRYkDtg/oYLR3finYe23Mob/0BQ/ME
	HO3euxTd2Eg15fJCgRWx5HoNQABaovDPCQQ==
X-ME-Sender: <xms:-MikaLzvpnMkn0LG2OhlYpfVz9nFFUA4S6BE-5WdRvR08ZsVZEkECA>
    <xme:-MikaGgDRXf14atJPaN6mZIwVhQn_FH9KckDMMCnxWuuV-dQ1XUhdvbgwsHeZpJdG
    r524l4mKwEmNcuuHg>
X-ME-Received: <xmr:-MikaOxmHAZmf1hAFEKio3KkzfUMRRJHdgPCEvkoz30Cj_4HMvWVb4KWa_WtUNgpVxg6jWf-HV_HSPmDWWhYM7T_X2KLS4Ra0Ye98nY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheeivdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:-MikaBJWgRKMOyy-IFXv_DeCGlHX0-T7Iqxnp5B5J04PoLVgQrWk9w>
    <xmx:-MikaNRSjxOaix5ApJ6igzXjcQ_OVInOLDqoclolm59qeYyUnqkLjw>
    <xmx:-MikaBrGs7kvF0tuQjrLVLDrVbSSsTY8pUJp73kxAmt1cVr9rXb1qg>
    <xmx:-MikaKp1rSQbBRXE_56TPBRgzp7utsnTEOS8n41F8nKk29-jFxBEGQ>
    <xmx:-MikaGGiN7QEi4YHt6WxecrEqpZ4-IRe0xupOW_k4_lxAhPYpvZCdU1V>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Aug 2025 14:56:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 06/16] odb: move kept cache into `struct packfile_store`
In-Reply-To: <20250819-b4-pks-packfiles-store-v1-6-1660842e125a@pks.im>
	(Patrick Steinhardt's message of "Tue, 19 Aug 2025 10:19:35 +0200")
References: <20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im>
	<20250819-b4-pks-packfiles-store-v1-6-1660842e125a@pks.im>
Date: Tue, 19 Aug 2025 11:56:54 -0700
Message-ID: <xmqq8qjfdts9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> The object database tracks a cache of "kept" packfiles, which is used by
> git-pack-objects(1) to handle cruft objects. With the introduction of
> the `struct packfile_store` we have a better place to host this cache
> though.
>
> Move the cache accordingly.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  odb.h      |  9 +--------
>  packfile.c | 16 ++++++++--------
>  packfile.h |  5 +++++
>  3 files changed, 14 insertions(+), 16 deletions(-)
>
> diff --git a/odb.h b/odb.h
> index 2dc3bdc79d..f1736b067c 100644
> --- a/odb.h
> +++ b/odb.h
> @@ -124,17 +124,10 @@ struct object_database {
>  	unsigned commit_graph_attempted : 1; /* if loading has been attempted */
>  
>  	/*
> -	 * private data
> -	 *
> -	 * should only be accessed directly by packfile.c
> +	 * Should only be accessed directly by packfile.c
>  	 */

Hmph, would this be better done in the step [01/16]?  Or did the
removal of kept_pack_cache make the last piece of "private data"
disappear with this step?

>  	struct packfile_store *packfiles;
>  
> -	struct {
> -		struct packed_git **packs;
> -		unsigned flags;
> -	} kept_pack_cache;
> -
>  	/*
>  	 * This is meant to hold a *small* number of objects that you would
>  	 * want odb_read_object() to be able to return, but yet you do not want

Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84F52EA468
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 13:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772545350; cv=none; b=f8J8FohOIXWh4NkNWQOLTy7Ud1luxmXB8rbZ0/MDSc0LkGD3QfpH3XVLY7G9Y3k5un6WYjWeU3HYzZN0O9cXPzU0VxVvja1/TeSTeqNJO0xV9ElXKOqtbgRqH3msr/5RNqoJs/yHqUQOpwrHzLXIZ+NaV6VxYxs4xYGwtgWVFxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772545350; c=relaxed/simple;
	bh=1yjdljDSKZTS57K0qDol/iirfR4qivEobQxLuaMNi70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/chjXfs45/dQksR08vNB+3lc28xYbmw+tQ309QgFPMYB0KOKX0ReYWqsXEq/DScbYFX9flSc0vQ7foVxN1wN/mKekME+4873IlUmz9nPYU2yJ54NxGL264lR2uRGvIjsCGXvgaqWxU8nux9b6LOFUHf6twRxle2O9Q2GQtSbdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=k50seQE+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=biInxgGR; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="k50seQE+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="biInxgGR"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 0793FEC0551;
	Tue,  3 Mar 2026 08:42:28 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 03 Mar 2026 08:42:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1772545348; x=1772631748; bh=48nQtPHM08
	pIox73AIQoP9pHRhe+EMajLfgTZ9pKYdU=; b=k50seQE+lJxBKfkSZh5LVmT0Kl
	O7XKo1emqPdO4qWlJnJI/CywrlZRgRpK5AejUmNs3icMY6ZnKM5h60pkhxl9grTj
	RTdIYNrhzyNs2mGZ8HJ+b78kdmhBkb+JJNPirCYpqrlE/lv9F5d/LokvtQI4OWHA
	3GXF8M/SfYpS+iOIF6+iJge6AQUo1TJRhsuXOOPiUlHouBwpLX65rimuYF3QNLli
	mV/H+aPtYneHuiFqHhOTRpOJ4TKfMPkBJjaz3XgPUyONstZoKnPlz4LJRQlY32hL
	WoRWRG3v9vHV5zOSJBRti9M7icsMe6AGzVgygG5EQ9uMlLwSUk0N7lZKwzMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772545348; x=1772631748; bh=48nQtPHM08pIox73AIQoP9pHRhe+EMajLfg
	TZ9pKYdU=; b=biInxgGRdvdEHVx/V/gaForSE4tUcaeOmzZpLMIfdr6YgxHfxbN
	Ht08oQ5QwKMqR9gGhehNSd9yX2Cd/4TuN1sZ1I3fRCylEARivzRlbpxiyK9VUolI
	GR6OROkgX2hVUJGbskVO5PxvyiIb4toc1MCzekllZ8DPp/1/jjR7uCUyjc4Ps/9v
	Ip5jZ/c98wEnLBoBk0XZgtfX/ffK2VKehZ4d5OvmFtq2iLlqUeaa5cxxHSwtCIXZ
	x7T1H9EFBBxakyBDLTcwS3jT1LTSKkGAcvMHwDtM17ie6Uv/5vtW9rMx8LqkNRxR
	igY4bzQ8UauHn2oFrQohJlKe+lIc0dLzOYg==
X-ME-Sender: <xms:Q-Wmac6iXjqVMB0Ajlik07VeXa3qOBxX-UDklRvyc5TFLyoAf9Cm2Q>
    <xme:Q-WmaT4FDHPZoejE5tDhpwySnQBLkt3348-H8SXlLgwXMYydC7HdK546rhyjeUl0L
    x3D3LY8Vmx93WkaXg33-5r0OsSzWEA3LmHqpVI8GDVyv7VYaKjm8w>
X-ME-Received: <xmr:Q-WmaZHlRJbpb-nTJYZBUQuRJhDKjRe4pqC-7HATL0aei8Hb6MJANZppFCyZqdiyBHHygjhjQV1vih7yXEmTbvlpVqBBTbKQm2YZLIU49hTo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddviedtjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjrgihrghthh
    gvvghrthhhkhhulhhkrghrnhhivddttdehsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:Q-WmacRNHGmpb-u_SAhsziSL077Vfe529bwDysIIqmeq2SPa5SLcgQ>
    <xmx:Q-WmaSuyYcH7TtBGlsE862Uz32QcZ3EuInMhsD4Z5m1rXaokMCJ1CQ>
    <xmx:Q-Wmabxp50OWHEzQ5EUMfQ80k_tzDJKXz43g_qpU6q9xKAWppqemCQ>
    <xmx:Q-Wmac6fay9YVH8JH3crzMo-awzwHz47LX1liacFaUcbkAZz5dbrTw>
    <xmx:ROWmaaqaxnD0nv0YJzrlVB0Jhe2FCNUQZ7X8_3G1CX3zQVNxscdXapOM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Mar 2026 08:42:27 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f45e24b0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 3 Mar 2026 13:42:25 +0000 (UTC)
Date: Tue, 3 Mar 2026 14:42:22 +0100
From: Patrick Steinhardt <ps@pks.im>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/3] path: use the right datatype
Message-ID: <aablPlaCY-TAoCi-@pks.im>
References: <20260302142138.712273-1-jayatheerthkulkarni2005@gmail.com>
 <20260302142138.712273-3-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302142138.712273-3-jayatheerthkulkarni2005@gmail.com>

On Mon, Mar 02, 2026 at 07:51:37PM +0530, K Jayatheerth wrote:
> The strlen() function returns a size_t

Micronit: missing punctuation.

> Storing this in a standard signed int is a bad practice
> that invites overflow vulnerabilities if paths get absurdly long.
> 
> Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
> ---
>  path.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/path.c b/path.c
> index f613d8bbd1..56be5e1726 100644
> --- a/path.c
> +++ b/path.c
> @@ -58,7 +58,7 @@ static void strbuf_cleanup_path(struct strbuf *sb)
>  
>  static int dir_prefix(const char *buf, const char *dir)
>  {
> -	int len = strlen(dir);
> +	size_t len = strlen(dir);
>  	return !strncmp(buf, dir, len) &&
>  		(is_dir_sep(buf[len]) || buf[len] == '\0');

Makes sense. What's left out in the commit message is an explanation
that this change is safe to do without any further changes. But judging
by the diff it's used in contexts where we already expect a `size_t`
anyway, so it is.

Patrick

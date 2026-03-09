Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681843A6EFA
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 14:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773068379; cv=none; b=pm7pfII8nk2ycZe/Uvhn71hqBGuR+Y0Slj2KBb59Dofw63VTAWo+XPlk2WuZGDLiiS9Ib920zvKEWSAZt1Hsr3bgJYI9g8G0P4QnPaxVkDKB7aFlBzYWVl9QeM8tvrT3AQLMuwjBymvVRwp8ZIUhn9OpwUPXJRLj+bJaqEV55q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773068379; c=relaxed/simple;
	bh=q4hLH0jpi4T70wS5JebgIh309if2e/2KHyxUpdnN9Y0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QrVTJ4i4MnXlX6Z7xotrvSg0tVSiQ3ejYd6xZzRE3d9MAERjf4hZ/j9CqG++aU1+NClKMVlNbjiLwHnHoBkvv2MZz8zTAQLrj034aRmoYo7rmPo0vGMiXgFvcMd8OISm0xZOAzI6n4LsnE1+HQUOhKRYKJfbSMv2Mr5RbuDwCgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Dylsg4Uy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uD5YEenq; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Dylsg4Uy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uD5YEenq"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AF8EE14000F4;
	Mon,  9 Mar 2026 10:59:37 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 09 Mar 2026 10:59:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773068377;
	 x=1773154777; bh=rPBkdsWY9VAjz6YZPCdFGlX9w8vNMh1/L92EffwMeVU=; b=
	Dylsg4Uy2NsqmHnSUwvAawx+WBmLjgvcrLUt8dtfKo9xfZmKvfVQ8F27xlRAiW6h
	jmRlwI+vQqMzEYqAMgcXD8Ar/cdbI3qnrhtucNFyqVJW5ypAeQygdJhy2mC3H2wY
	Dx9JVHSgEKKmWix+AKUVTbp+8rPcx3cKvkFEHeeXB2Nv4QgM9rb06brA4oWtVzPf
	VTmw0cqSt4WBotX9jGajkBndFH4byVXH9IA7ZzUu9bWUPVXdSDG8Xk5fAeqrBj7h
	X1rcrgBQSmWAvdp8V9XQdjJpW24FAIp1POapHqYwLwyKPlWmK/l38/+CD3hElWjF
	2UP5L61qYIUug0E44wPzZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773068377; x=
	1773154777; bh=rPBkdsWY9VAjz6YZPCdFGlX9w8vNMh1/L92EffwMeVU=; b=u
	D5YEenqfCCIyxyStvnT27S+66/eNtc5oCnh1Rusj4skbKhnCU0pBVHCjrgXDFMXk
	iWJXsxZDZk5LN12lGZVakyYk20mDHzEUL+Y1uN6nYmXqozyoNmdX+Bk6ahSPkpVF
	6pQmrVFMjAuYdfSnVC4TIs73MF1/PvZ4epIAwarhNFtoRkudpB/Q+55PEw3E0o/E
	cO/Lbf+RJpL846/ewuiRrHNJpWZoFVdnCwqQ+CUPt3JyHJqyOQWR0U091qAQgmWn
	DV8xCit1pbMY8i44lepm6EYNanTlSThcVL9HlhyEzfgS8g+IHFS6V04KzYJvt1G4
	TtKSLP0lQNJj/dUxjAH6w==
X-ME-Sender: <xms:WeCuaV0qOGxAX5JbOgEFYfMMoIcmVtc8rEPT2INmXH5PUId6XRhwUg>
    <xme:WeCuafzYJjWCQRD06XlHu7F_yk1fqKQdRX3lQ3fkBPiC9h34vyYOyPnfw8XgC8O-Y
    6FzV9JYAg5aa5QM3JD3qt8Strz9OhYhgvRjk5c9dPUBYpT_K376cQ>
X-ME-Received: <xmr:WeCuafslkGHBDGh0ezIMc1Vf_2pz2gbSC2OEs2ygzEQa_pfv04ShSDr50YJ7V-_sGn4URg0E7THSsGiJ-6lOcsSvgasuZ_vhWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjeekgedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegtohhllhhinhdrfhhunhhkudesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheprghvrghrrggssehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhtohhlvggvsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:WeCuaZwd0Z3Y8_rN8RfVOo-CHxu54TZu_gjZlsZBg0U-dgnATSBlPA>
    <xmx:WeCuaaCS6QxMW2xadzV38OWGT0ZQIm9Esd5eG3LvBrRWwZHLqiHtDw>
    <xmx:WeCuafdM39MxhjEL6CZFbgyUtpHai5psG8sI7JhLGya1gIoVYrOlCg>
    <xmx:WeCuackl9giV00sqbfSJtGpiT_g8-oj5h_OMUGAMzl9rvxhelbWtYA>
    <xmx:WeCuaca-yPdwoZEU5hkjK4N0NYGc6VPJDXJAaUHUNeb0ddV6Ws2_Boxu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Mar 2026 10:59:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Collin Funk <collin.funk1@gmail.com>
Cc: git@vger.kernel.org,
    =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
    Derrick Stolee <stolee@gmail.com>,
    Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] dir: avoid -Wdiscarded-qualifiers in remove_path()
In-Reply-To: <3ad40c3d0762c2e8c14792dfb68cba9f63a883a3.1773026586.git.collin.funk1@gmail.com>
	(Collin Funk's message of "Sun, 8 Mar 2026 20:23:06 -0700")
References: <3ad40c3d0762c2e8c14792dfb68cba9f63a883a3.1773026586.git.collin.funk1@gmail.com>
Date: Mon, 09 Mar 2026 07:59:35 -0700
Message-ID: <xmqqbjgx6obs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Collin Funk <collin.funk1@gmail.com> writes:

> When building with glibc-2.43 there is the following warning:
>
>     dir.c:3526:15: warning: assignment discards ‘const’ qualifier from pointer target type [-Wdiscarded-qualifiers]
>      3526 |         slash = strrchr(name, '/');
>           |               ^
>
> In this case we use a non-const pointer to get the last slash of the
> unwritable file name, and then use it again to write in the strdup'd
> file name.
>
> We can avoid this warning and make the code a bit more clear by using a
> separate variable to access the original argument and it's strdup'd
> copy.

"it's" -> "its", if I am reading the above correctly?

>
> Signed-off-by: Collin Funk <collin.funk1@gmail.com>
> ---
>  dir.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

The changes make sense.  Thanks.

> diff --git a/dir.c b/dir.c
> index 026d8516a9..fcb8f6dd2a 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -3518,15 +3518,15 @@ int get_sparse_checkout_patterns(struct pattern_list *pl)
>  
>  int remove_path(const char *name)
>  {
> -	char *slash;
> +	const char *last;
>  
>  	if (unlink(name) && !is_missing_file_error(errno))
>  		return -1;
>  
> -	slash = strrchr(name, '/');
> -	if (slash) {
> +	last = strrchr(name, '/');
> +	if (last) {
>  		char *dirs = xstrdup(name);
> -		slash = dirs + (slash - name);
> +		char *slash = dirs + (last - name);
>  		do {
>  			*slash = '\0';
>  			if (startup_info->original_cwd &&

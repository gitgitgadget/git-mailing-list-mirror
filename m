Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BA11E0DA7
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 19:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728501991; cv=none; b=IiGaLQOmwQeio+WWIPwumj2EsFqicD/eejOTczPP0aGxJSWQ7IGJpacFk1Yhc5ExAFkVxt7pOeCFIGvEfb14jx8hpU3K14Tihje/CELK2qVTW1AeRh6U8UdokAFioLnQy95fRRJi/7Y0kwmdukxZwU79fXIUl0W1kx0khp3/zMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728501991; c=relaxed/simple;
	bh=UiKOJzfAMlCzh+eJmcw8lwx2W7zQSIqPKz+OCm5jQnk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YFUbxlUGJd7jCkYqLgP8FcAOl5Cn4JQozzAcJaZXeGjwSlQkxIHTK5bYZ++KPjwP2nWm9XOD9iipwieitHOR5yvc7MzZPzI35MyGTCQZbUKXnTb1gx0DPnV6yZoTfFE7TeT+QNPzKSuaZDpzZYH0IpRLiTfYvoYf6dQwzzjl8pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JuK74MrS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hss3OtNL; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JuK74MrS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hss3OtNL"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id E88BE13801BD;
	Wed,  9 Oct 2024 15:26:27 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Wed, 09 Oct 2024 15:26:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728501987; x=1728588387; bh=dosPQRHDqf
	ny+/p/3qYmareOaTdO3de313upyaq1jPo=; b=JuK74MrSv+hfqziBVdFtKH0RzH
	euFEGexjlgM1VVq8RcYNy4Fll6B88yiQKXgjdXhrffRz5+geWXTI4gi8nlQ6BAOc
	MI2RVrAJNQjOb5fAjpAfXD7fgdpJ5OQoyVe7FVGdUH6dB1ZtJVI7EY0bVRfzZmnB
	jS0dbFqUf/TeD+VewpYwjXcn6eU6WLyW4osxoMSSKxEt0q1aAiB01XI4U/tkd/yD
	hGlr247qa2ontz3uJ55Sxt3hSKLFyd7MVrYxAHIwYeFHGISMnF5/TK6zxrqA4kg9
	TDkcN2twSJhbp674I+xfIx13fwpiJBxXSdp5om0NZ+h1bgrAu1JXADh1ciNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728501987; x=1728588387; bh=dosPQRHDqfny+/p/3qYmareOaTdO
	3de313upyaq1jPo=; b=Hss3OtNLM3lTo2idm05+gGYQCCK0gXH5YJmeY5o2Qsm7
	0PMLRdqgQDNQaKNtIxlrPLJQktZy6a3yW/+YwlmK5rSSYdXVTI5Ti64cCyEeeTuX
	2cGiiFYYZ/fdjn9rSYSGxP1DlfSRUk+wz92iTVXDX6lX7uM48ROZj2LsDeJdcWcM
	g+HRamfBpOH63xUkgSiSWG+vXXbMa+CxJpOCMhsdhBB7iRF+MIXwqUeHPRl2ZP4C
	1h6Kl9n1hslcoc3sPOdDJMZbpEWIHmt90Hlz9wzdwYsSYoUmjIWVpAb3oN97iwIQ
	yWUFR21j3agrb0J1iaen3FggiIzFGnqCcmsa5mtNMg==
X-ME-Sender: <xms:49gGZzbDIW3eF5WrRMt9s-vlJ9cV_zTVBBohYlaAhc39Y4Sti6BkgQ>
    <xme:49gGZya-gN5Bd2XfDEBo6Ifa26w3klh1oLiSUzwijQ0p4h5ulPavuNsf56m7wVXqV
    eVf2KUqlCPeHaBZyg>
X-ME-Received: <xmr:49gGZ19yD57A7dUapPf36f3OTIfOtRPq5u3xP1zHS3vUTR_nyo2-a7LywYCM-2-xoOS2rk7iLlIevLD1yEhOQx0K-wQojRhjq3fm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeffedgudeflecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsvghntggvsehfvg
    hrughinhgrnhguhidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrgh
    druhhkpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehl
    rdhsrdhrseifvggsrdguvgdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvg
    hlihhnsehgmhigrdguvgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:49gGZ5p4zEPJKKWkcNq7PGPBIEkLZQx8TFuH18tigfPhyH8__s9hcQ>
    <xmx:49gGZ-p5pYg-cjn7KE08ZX5EPtkJXCsqRZJYGGv6qgcyP6CgZCsScQ>
    <xmx:49gGZ_TAm6pXxUvDpO1N63QEYN6ssfF7AEC1bfEOMuoC1yLSjfDTTw>
    <xmx:49gGZ2rxOX9i8mWUKzM7kxbKahWBXrp10XthalZIX36zqeKMla6ZyA>
    <xmx:49gGZ-Idztt2stWGkB-rQXM43fw08ApVvIF_WE3itShQ7AtBy8MpCRaS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Oct 2024 15:26:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Bence Ferdinandy <bence@ferdinandy.com>
Cc: git@vger.kernel.org,  phillip.wood@dunelm.org.uk, 	Taylor Blau
 <me@ttaylorr.com>,  =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  Johannes
 Schindelin
 <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v5 2/6] set-head: add new variable for readability
In-Reply-To: <20241009135747.3563204-2-bence@ferdinandy.com> (Bence
	Ferdinandy's message of "Wed, 9 Oct 2024 15:57:24 +0200")
References: <xmqq1q0xhu13.fsf@gitster.g>
	<20241009135747.3563204-1-bence@ferdinandy.com>
	<20241009135747.3563204-2-bence@ferdinandy.com>
Date: Wed, 09 Oct 2024 12:26:25 -0700
Message-ID: <xmqqttdlqdr2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bence Ferdinandy <bence@ferdinandy.com> writes:

> Instead of calling get_main_ref_store(the_repository) multiple times,
> call it once and store in a new refs variable. Although this change
> probably offers some performance benefits, the main purpose is to
> shorten the line lengths of function calls using this variable for
> better readability.
> ---
>
> Notes:
>     v5: new patch (split from the next patch as a preparatory step)

It is a good idea to help making it obvious that we are accessing
the same ref store.

The patch needs to be signed-off, though.



>  builtin/remote.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/remote.c b/builtin/remote.c
> index d8ff440027..353ffd2c43 100644
> --- a/builtin/remote.c
> +++ b/builtin/remote.c
> @@ -1404,6 +1404,7 @@ static int set_head(int argc, const char **argv, const char *prefix)
>  	int i, opt_a = 0, opt_d = 0, result = 0;
>  	struct strbuf buf = STRBUF_INIT, buf2 = STRBUF_INIT;
>  	char *head_name = NULL;
> +	struct ref_store *refs = get_main_ref_store(the_repository);
>  
>  	struct option options[] = {
>  		OPT_BOOL('a', "auto", &opt_a,
> @@ -1434,7 +1435,7 @@ static int set_head(int argc, const char **argv, const char *prefix)
>  			head_name = xstrdup(states.heads.items[0].string);
>  		free_remote_ref_states(&states);
>  	} else if (opt_d && !opt_a && argc == 1) {
> -		if (refs_delete_ref(get_main_ref_store(the_repository), NULL, buf.buf, NULL, REF_NO_DEREF))
> +		if (refs_delete_ref(refs, NULL, buf.buf, NULL, REF_NO_DEREF))
>  			result |= error(_("Could not delete %s"), buf.buf);
>  	} else
>  		usage_with_options(builtin_remote_sethead_usage, options);
> @@ -1442,9 +1443,9 @@ static int set_head(int argc, const char **argv, const char *prefix)
>  	if (head_name) {
>  		strbuf_addf(&buf2, "refs/remotes/%s/%s", argv[0], head_name);
>  		/* make sure it's valid */
> -		if (!refs_ref_exists(get_main_ref_store(the_repository), buf2.buf))
> +		if (!refs_ref_exists(refs, buf2.buf))
>  			result |= error(_("Not a valid ref: %s"), buf2.buf);
> -		else if (refs_update_symref(get_main_ref_store(the_repository), buf.buf, buf2.buf, "remote set-head", NULL))
> +		else if (refs_update_symref(refs, buf.buf, buf2.buf, "remote set-head", NULL))
>  			result |= error(_("Could not setup %s"), buf.buf);
>  		else if (opt_a)
>  			printf("%s/HEAD set to %s\n", argv[0], head_name);

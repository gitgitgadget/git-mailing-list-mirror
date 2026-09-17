Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DD33D3D1B
	for <git@vger.kernel.org>; Thu, 17 Sep 2026 19:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789673660; cv=none; b=D/V0d4Q4gi0j4+uo5hYKzB84tJimbOls2NbmTJSs+LliTVLES4SYZ02Tid31SPJ30cb2rXw4AXHb0w9LtHMvkvx2dAY0sPK2CGFdxLWLZJmsy2oWkcLOnsLVxt4lFKJelTEnBi5+JEWTG8hg4M1uYzfFYyVjM/+N5rvLIGvS8RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789673660; c=relaxed/simple;
	bh=Kgi+/QltrMrnKKTyUfu3VAf427wk0QS8kcGpr53le/Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qYrBaLe95DBXamifriNu7Tw0Nm/BY3BZ4QLsPwN5Mwb5BZafEo7RlWV/KvR675tpcapUh+JQ1NPConX0YtLtWhmD9mSPoqmYdVH4aHily/nkQ8+8aBmAUJ52EAYWE3TN/OSYT/HNC1gNVS55ltC2+wprGFsGPZO5bhf91+hJkQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QseluI30; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RvNaMTNk; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QseluI30";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RvNaMTNk"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 589467A0182;
	Thu, 17 Sep 2026 15:34:18 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Thu, 17 Sep 2026 15:34:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1789673658; x=1789760058; bh=SJQb5sQU+0
	EnilRZdR3/+PX6Pu5qvhOQL81789I04HE=; b=QseluI30tQm5SqQhAW+HEG1W7K
	ZTxCYaQiNY+A/dhxtnd8jTv4i1FnqSXQtNev5hU7KECMsDBNdS5HyJIVFwyayZCH
	TCrz0c9Fzfi+NvhbhvgZ+UgGfyDGkNQkd33ON1SnV2NMwppIxICYltJRZ1xV8kKC
	y3VZ/+XiDjkdMTI1+w2/r15G7WzVrEyQrFwbg83wEWQjIlBrzlCvFjJJWH+exuzd
	12zcYN/DCaM07QOmKQJqIZDYLqtT9egcG/ElQN+ijJoyqTc3zFkwsy4FKIPzKOV/
	XEq0Jw726TC007aV42JMw51gTC68DOo8OR73UKuwBTfDyXNkWKnOGfx4Z//w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789673658; x=1789760058; bh=SJQb5sQU+0EnilRZdR3/+PX6Pu5qvhOQL81
	789I04HE=; b=RvNaMTNkSoT3JemyVSmhm9JOGlv61mBJC9ypqM+6HrTPj91S73W
	qImGfhvRAdo9bL2BWM0vGWptEfI2KY/cjwkjb5+4b3Nkt0Ekb+rbsAcv2nmQyD8O
	8AeBDnJatMfcDAgSP/uQJ96IxfxoIlGy1yV35B6gjZSu1xs2K3hqTH5d87VhhPpZ
	XEMQ6wZtBOnXoH6/qwl9srpzibuTVeuAWnBhNhVOm2MM89u5T7l8yresTj4ntXE9
	U7y4DFnEQgyN/Dm8gqILHMsePLxAmmXzZYcqls/YuWdTVOaINZOge5WZYmz6mgFO
	5zXKkdB5G+DwlfyXEwc4CFPnYPJMuzSuQjA==
X-ME-Sender: <xms:ukCsanX-gBdwYAp25yCHjk2EiqXDcrzlm5l1QJpTc0qMXj9unWSgeg>
    <xme:ukCsamk2lFMBL1LhAhBkOyTmHiiTdSim4EuPveyYKS8_X9xoisOYjMc2Btdi05NXH
    gRwcT98a7LJ1I7rL1ZPL2N_CGd1d1XHDZSjoA90JPqus8OY3yyS0Ek>
X-ME-Received: <xmr:ukCsaoaOs2OYcC9c07HaBDATd4YVCb8-FzaNykW6SXUzGpT-JvxlXXMciEkaelhJ4__9LRUmPttUOniWa9e8b7jMDjmcP8kW2u6X>
X-ME-Proxy-Cause: dmFkZTG1LL9zBOd6gGB6YeS7GjChVpRQ272L9+joi9VNYMH4yHVZZNRydMWLXcYYJf9Rvj
    2sjt6Zf8bzuzZGCeKGtuF6JeE4XhEl6QGR41XMdkWT+eeR2KUuChQG2wGcFiPFiz9LVJ5s
    qKv4NbBsaCY+paLQaLWtSp7qoL0y7mR6va9DFU0koeJaYkHZU3uvVOy6WXBm27/U7gBs4E
    EeUV1M4g3Bvnrqgpf2p0w3VNQgBVb48qvKWFDF3nk67+If+qROckyIzR7NjPwR1y+aaSb8
    EvKdrzfNBZF28j5g1HFKPEjPNW8J1WjhmDtl8Cisy80wzd9UOWqQF4Ei9Z/0IzHmzCd5Pl
    r3ZFdoCMyHbWyGRj/GEbPIQqsm9Ou3ldzpU6pqah5ygKots8R10Gx/FqXkZg9vvIxqkN+o
    dnX7hFM3XGaK6Mjtd8e/VXPVISVnwrXMJxdw2VIkBpnWeQFgVpC86LKnYRbJQCwlinGtcq
    iX8JgUH3rhrEMvuzPdmrLprWMIjuEst2mcSpTSglMJeJCu4V7rlocW81Ge6fWa0Db2ILb+
    9DpAULWiMCBH07SELZW3OWcXgQ2RINXvc2elI2ws+A0t593y9uPwZvpVpI/dR7vIBrgNKl
    EIQE3C0lqMgPp+nrZztsHpMTBYjD/ou9rM8MzUw3bpnL7NIJqpA+4BxorNPA
X-ME-Proxy: <xmx:ukCsahMhKDaTLUIR0uVKIDKKxYtPxmFVi-TlckyzpfiHs7rDCJF_EA>
    <xmx:ukCsatZcksFJBF7UrLyHiOo8znjjTnCZBIT0BV4JFaHX9zJJTprVdg>
    <xmx:ukCsav0YmGLpHpy4WSyjpSXHmkE8NPjSKI8e90-eWI1VGezkF8cGkA>
    <xmx:ukCsajcFXZiFTh0orXzYWANL7F7NGHsfhpAGy_Srwx_RYTfNB9uTGw>
    <xmx:ukCsalz-qFIwK1w_0I0hLucVfCQnAJg8FbkknFfweUbYFCAbldp87fpO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Sep 2026 15:34:17 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 4/7] rerere: do not record failed conflict resolution data
In-Reply-To: <bd9e06e46c6debb5a8fc8f1d3821250ca110d5ef.1789667556.git.gitgitgadget@gmail.com>
	(Johannes Schindelin via GitGitGadget's message of "Thu, 17 Sep 2026
	17:52:33 +0000")
References: <pull.2231.git.1789667556.gitgitgadget@gmail.com>
	<bd9e06e46c6debb5a8fc8f1d3821250ca110d5ef.1789667556.git.gitgitgadget@gmail.com>
Date: Thu, 17 Sep 2026 12:34:16 -0700
Message-ID: <xmqq5x03u0xz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> @@ -778,7 +798,9 @@ static void do_rerere_one_path(struct index_state *istate,
>  	assign_variant(id);
>  
>  	variant = id->variant;
> -	handle_file(istate, path, NULL, rerere_path(&buf, id, "preimage"));
> +	if (handle_file(istate, path, NULL,
> +			rerere_path(&buf, id, "preimage")) < 0)
> +		goto out;
>  	if (id->collection->status[variant] & RR_HAS_POSTIMAGE) {
>  		const char *path = rerere_path(&buf, id, "postimage");
>  		if (unlink(path))

Good to see this one, which is the only unchecked call to the
handle_file() function, checked for an error.  Looking good.

Thanks.

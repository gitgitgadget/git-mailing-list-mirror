Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305691A5B9D
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 03:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783654866; cv=none; b=TSBIOb3SD/0fXjl5V6335wtaqd3Vt/GthhVWkKcAWAnwdLWMCQlvEmUyiTEkpfzBsSAhtgO4IpsCbqma107eaCQv28N4Vg35rOMbIUCWx0S0aZwEr+50l8/9l9bfT9/uXZaWqBLi53QgFoHOFrSPA/UGNd7jOREQms3rcwfC9CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783654866; c=relaxed/simple;
	bh=mklWZikDdOejd/rVZLmqRCJi52cA6HRJzNbxlujDo5Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lo9239f4XAN6hvy+czvP3lZFDv4kDlRxd7dBS4erHkyMnHJQi5ec/4u9VGXIOamewnDNC0eLbxA555P4ySoQ+qfzfDsG36A45nM+IeaXKLS0HG6S7lQp/xRrVv87EEUK9ciqJAo/eyFd82nPYWqMd7Q6onaNDIcSvlaRGJEfl+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rUUaxc8I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cxM/1UWT; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rUUaxc8I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cxM/1UWT"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 89D6D1D00014;
	Thu,  9 Jul 2026 23:41:04 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 09 Jul 2026 23:41:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783654864; x=1783741264; bh=aBQSiXLdAs
	Sm/moUSnlCAbX5fb7tprqDF/mYEKjYyO4=; b=rUUaxc8I3exJzYjjMWZl7XPJ1m
	M3lzBf3lhCcpz+wYqQZc1HGiIVnnmxk6IP0zStvYwgUscwGpL3rF4EFSoWeysLzm
	uf3QnrG3b6KCZkVSyDotkqcTP5A4Bnuusma3xE/U7AEqKFFxcleKI9c8S12Ie5+T
	HTxxi2O/EyFRzXtlGStiesL9yEkrfHk6g7Py7MFj/mb4dWE72GXfjX78ODL29VFT
	fzBSc9iaggmpf1+q/XKi1RYMhoI+AyW61q+FMLrsZVAAOTvWYKIq/WnGQhOJeum8
	oPV2FqBw7ebksOeJxieu40iuDORZqoVdeqLErq8qi21q8LEuXF8GWZiOMpZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783654864; x=1783741264; bh=aBQSiXLdAsSm/moUSnlCAbX5fb7tprqDF/m
	YEKjYyO4=; b=cxM/1UWTbL9LYOPvfKot01aM+M3Ca+JtLDgvC/WDGoc9TM4fmuF
	D4uMHzTxWmZeUDwGtB+n87OjF1hUipgHz2eIxJiuLqmLARECbWGU93CQWTWEc2xM
	dB6ERqDFJuUM10lRxJx97btr2fdnZCDHp25Td2mlWKk5RgAInvGtGOSCJtwMkWLt
	QejNq+gHiOhNGqxsu9TZCGn7KaXMOjZJrj5644UCbNrKcj9VqQaeXjh4UsuAGOad
	VN65KwA/2vUNCJhapKV+A4x0zGfOyvnM7dgr+qPIyk0b0ZBIaQKCMknmH25g2nRe
	vWHNSbz9MVYw/JRMOQ6587k1B5b33AcC9tQ==
X-ME-Sender: <xms:0GlQah8gNdE1V46GkigqavjpagQ__Y0g-8ThWB4IWn-I2To2nsi9ow>
    <xme:0GlQastHPbCBD5uoTOZ_l948aPrJWY0H_PlnugQH1m79_20KPp-nZvVDxIxkhN0tV
    p6hJW2EU46swB9SAGjMbMzvCUzkGgazWHVnBtne-DVlqtl-E0jonmw>
X-ME-Received: <xmr:0GlQakABpr_4PbFEmus52hTNHtq-rm5mbNHuteii1QHzwMi6iCK-0kbWlrlVZx_FUsSwIsex8LcCUm436hvjLkMRZYk4_Xp0un7lbpQ>
X-ME-Proxy-Cause: dmFkZTEMmxIDI/7Gp43Q8zw7mJZ6BPUaBrnFfya2kFjLxzvRlleVFpE+ZfMdIwC6qr36bm
    120PBKRBXMY+xnXTOyVb10uoQNRCD/nWeWziBKYAYgcRFjtd2qgzngzOaO6wzW9uynfg3n
    Jx+lYlkFclvuvtX8NEwh05nZmLbqZwjElEA/yDxK2sWmceAcof2HQ8AD2NdYUNRHrsIg0I
    d6OkTPY5gQA0YU4nK1H9aVjpXPZw9VFRE1B+22Hz8B3ezjPYlEQy89BxOhNBg4GuCqgFOS
    uoMsbCOxP3ucA/ROm13ioyg2oCwo7Wx87UQZ+Yvf7ozPUEqch8y0exm41M+A4qQxrORkXG
    8YPGkrhnp13WHJQIWdtkWUMf7me+RWjQCh4jnq1mh76sKdOqvvbv369u5FxUuEXC1TKZyG
    hPbMsG07qmlWeY8igbI/jmfHVf6YvrIblurvkSIR1R7jT4CY6N9nUNj39so2d1ynLCzphS
    nV5wFYmUW8D2Cdmaxri2O4id0+CSZ509UIxgghuOO9tsTqACAN+eECdXU577ogPhv/WrMY
    4jA2fR2IVPAUeaRECy+E2HLh0LgQTbtND0Lv6bBPgTWnAbFr5PURxxxv06JsybE+oYLqig
    6iuLQ/ias/E9nsqnKjM6eNS/yOmRLzJyqgma+haDhJDYcVkDVy7f3U9fUtVA
X-ME-Proxy: <xmx:0GlQakUW7j6UklPJ36WqyxisPnPA4mhME2DiWAJwYyd04avl8A27yA>
    <xmx:0GlQaiCvPr62DrIrMuRMdSRh5Byiv7N4pGKWOdN0P-WHfYQjI3JgHA>
    <xmx:0GlQan-eHdKJORLb0kGJmHEZU2oSNbIZFDgT8dDqy9VZCh4ht2G6Qg>
    <xmx:0GlQapGpAdr0JVb-dfkG3yYQI18HLtdjpUONMaAggUypKDoTv3JBPA>
    <xmx:0GlQahaghBCB250aF2orhGSHhJt2Xu6dhPP-0siPsh2Fd7jy4lUUvXyV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jul 2026 23:41:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 08/11] revision: avoid dereferencing NULL in
 `add_parents_only()`
In-Reply-To: <0675767797f103b79ab936e01bfd06747725bcad.1783590159.git.gitgitgadget@gmail.com>
	(Johannes Schindelin via GitGitGadget's message of "Thu, 09 Jul 2026
	09:42:35 +0000")
References: <pull.2174.git.1783590159.gitgitgadget@gmail.com>
	<0675767797f103b79ab936e01bfd06747725bcad.1783590159.git.gitgitgadget@gmail.com>
Date: Thu, 09 Jul 2026 20:41:02 -0700
Message-ID: <xmqqzezzfr5d.fsf@gitster.g>
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

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> This function resolves revision suffixes like commit^@ (all parents),
> commit^! (commit minus parents), and commit^-N (exclude Nth parent). It
> calls `get_reference()` in a loop to peel through tag objects until it
> reaches a commit.
>
> The existing NULL check after `get_reference()` only handles the
> ignore_missing case, but get_reference() can return NULL through three
> distinct paths:

Nicely spotted.  It sounds like something a test can ensure does not
to regress in the future, unless I am misreading this explanation.
Could you include such a test?

Thanks.

> diff --git a/revision.c b/revision.c
> index e91d7e1f11..7f3999b551 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -1903,8 +1903,13 @@ static int add_parents_only(struct rev_info *revs, const char *arg_, int flags,
>  		return 0;
>  	while (1) {
>  		it = get_reference(revs, arg, &oid, 0);
> -		if (!it && revs->ignore_missing)
> -			return 0;
> +		if (!it) {
> +			if (revs->ignore_missing)
> +				return 0;
> +			if (revs->do_not_die_on_missing_objects)
> +				return 0;
> +			return -1;
> +		}
>  		if (it->type != OBJ_TAG)
>  			break;
>  		if (!((struct tag*)it)->tagged)

Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CE7373BFE
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 08:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786610944; cv=none; b=Snzultcnvs9phTPqxOLgtgxEjfeRiD6qxzT4pcd9OlYRSFIDZ9Rz18HTmNMqY8kmoCVbwWM3Oa+Cg64roD602CvWA4L1c++nOekLyFO9MtV7cuCA4qnPHoVHZJkzFc7/oWoVxWMRc0ozTjgL1mp6asU4ipuijumRXoRrlns17Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786610944; c=relaxed/simple;
	bh=RehLMDjJm/WYvkIHi8IMt1V6+BOwxo4GhehGfGFtGrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pklZWpDm/i+R0TnkDn07a3x7xrxLYOAxwmiBcULbnr2UMA2x9Fvbm780p6cCZ29P1J2LJs5jlbAWkPs5Rgcf3/Kva4cwre8vhgqDMhz15rBBeGX6VxlouWyG+HflWNz/tBhzNIduFGL/l8PZcKxHkzmbXQUxHZOrFFiMyDY/jUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lPRyS561; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NO4ekGHx; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lPRyS561";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NO4ekGHx"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id B701A1D00055;
	Thu, 13 Aug 2026 04:49:01 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 13 Aug 2026 04:49:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1786610941; x=1786697341; bh=HaPW0NtJN7
	/AHN/myQviwrKgV5KHYr8ihjnsFQsI3kE=; b=lPRyS5610nRbjFRXsbaxAqehbY
	YRbHQVdMe8z/ED5SveRDgWANW/qCjaK/PrJ4l5yXGKESPVretzpsOuw0sCwxelCE
	/HGdC8tZ4ieCsCAzWze4YRIYyIUt8GaXzeN7/qYOVXrKGXavalF6+sHoJXvcRkdE
	HA8Y0/1wz9IXDi8Dsv4UAN2aUgiMMTR826OtYJ64iJvMs9Io8aGFXoyEVqGZ/q49
	S7gBYI4eU9rMlV8M7dD+kz51mTZyRP+kWRzc/3AOpD4JEoLHRMmtHqm/n3q5Qktq
	VH38CWQEh3Qo0OlAh4/q8cJwJHmzQjfnB0HivNsd/cOdGgEipLqBab10zl8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786610941; x=1786697341; bh=HaPW0NtJN7/AHN/myQviwrKgV5KHYr8ihjn
	sFQsI3kE=; b=NO4ekGHxv+KTTdxaXeMP39KLPlloTNNb3HKQ6UQwQPF3uwhn1M2
	LU1FNBH+Be3wKhJsil3KzdhepZCZKWx3L3Y/gDbNbcRds7YkytKimixUOc0LfIpq
	3qIhknhrCc1HYwCO87kPONZsdhOJ8txzej3cuNhJOvk8XM9myQGzexR7ze2tJBAz
	NLRJKtlRdip10r5h26JAR96yYyg5qVd4L8X4N/1UOuCf46r+rCyeK+5NPgBGq8kD
	FBGiLQdsRFAW36zcmSz8+ZPU+eVj8DZtVs7NF7go4SIKq39s7ayMNxYfYuC6a2px
	be3FYzGlkU2h4gJ+NJGkFRvekaQDCDxIbeA==
X-ME-Sender: <xms:_YR9ajdjkdneq6gelpxOIjejm_39cEp5xfaL2byhZ8rGWERNCgxwWg>
    <xme:_YR9as7pL2LahBYM5QwoBKCeldtUVYZSVSIrYNywrZU_LwYEYlPcy5krz02XgqX7v
    0em-xzakehN1fyP6XgA8JE1-t36AAz755zmSXfJAJfzysTityKe2Q>
X-ME-Received: <xmr:_YR9amX7IFGrbSPQ8qWiHXGHmOgXH1-h2qeJiYLs7bgF-YXo7mw_z9JCcDc5_5RifvZ-clSeh5CXYFa5BalMcdXAIgDKYvp5VuQi4Bzct5N8>
X-ME-Proxy-Cause: dmFkZTGD5AWXFrQiFHWeHRWnpy+LownMaGCjod0S/XfDsWQ4+HI18NoZwkQigqrQb/ilGF
    yG+CdUTDchQZCxxRoO+EK1Q6czHchb6LVEWqtwOulU2bm3b/e7VYcnoLuhh0LSP5CFBI05
    rz6CVTkkMZEG9Kw0fAJtRpLhrxkMez/U9apq8v5VzfHrkaGFn3ErPZvDFHrdkywgnpHgjk
    Iy+kPBWZpRXjuyCJJuPoNzMiQVR0YDUptdmz3k6wUYrMfzOOO4mjTmknbd2Iny8Q5f6ua4
    SvrbEuVD/4wm5CgwFwi/llQgoVE4AvIUxIP7cgz7unggMkwSbLXH96pJNgcAAKy0Nsshq1
    PlwH3NnD0c0YicNol9Hm9duPHctTVdEL5zUBejjxWmr++++onqm8/L1QhskjCkNrTDBCCh
    vts4RVizLOMexyYcXKaPY0LF3Nw6gqFkQB/yPDj5aBL2MHTi5ycXb/PpP7oDg3/k2JNj2s
    paqmYGLnira4eKU+1bRdcH0R4eFfoT6NqZQKC5aYBYNlQ04rz3y8/rxynctx2tZ6pwo7ij
    7+tHvcXwQW+SwirxgW3vifhBYcpnkxaYvopSn6jK598ZnW8ZwO/rHnNT7XKM1FZJ+zvtqp
    Z77M5Sg8plfbUxobvWRQSC1PrIKIRTT9zqUfo1lY+zfY1Q5g9/+kuGX8Aa5Q
X-ME-Proxy: <xmx:_YR9ar438We6xi1qyRunMq0jk6kgdrVTqLTLdYeu4wGoiJ35AjsfKg>
    <xmx:_YR9aho_Z4fnNJW-Undpw826yU1367RWZkIMmZMxhhGKRlEWlEkNhA>
    <xmx:_YR9aulYz7BtrxkqB7WYzx4H0crLdVjmoYQ39EPJDjSiHKJugkWGcw>
    <xmx:_YR9atOn_qSOampSwwPV9OI5yEXaZ1kA7HKvuwaBc-rNidRtFCGuVA>
    <xmx:_YR9av5c3bHeh9NkGffutdeRzhqbKKBNzp4I5Mg8D3J1s_2K6TTE0KFp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Aug 2026 04:49:00 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a437937e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 13 Aug 2026 08:48:57 +0000 (UTC)
Date: Thu, 13 Aug 2026 10:48:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH 1/3] t5334: expose shared `nth_line()` helper
Message-ID: <an2E6OV1Fr7wKFhn@pks.im>
References: <cover.1781294771.git.me@ttaylorr.com>
 <a3a51a1ebbf1ba67592a1c884ae7ace526c6aae1.1781294771.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3a51a1ebbf1ba67592a1c884ae7ace526c6aae1.1781294771.git.me@ttaylorr.com>

On Fri, Jun 12, 2026 at 04:07:08PM -0400, Taylor Blau wrote:
> diff --git a/t/lib-midx.sh b/t/lib-midx.sh
> index e38c609604c..b522dbdb0f4 100644
> --- a/t/lib-midx.sh
> +++ b/t/lib-midx.sh
> @@ -34,3 +34,9 @@ compare_results_with_midx () {
>  		midx_git_two_modes "cat-file --batch-all-objects --batch-check --unordered" sorted
>  	'
>  }
> +
> +nth_line() {
> +	local n="$1"
> +	shift
> +	awk "NR==$n" "$@"
> +}

It feels a bit weird to have such a general function in "lib-midx.sh",
but so be it.

Patrick

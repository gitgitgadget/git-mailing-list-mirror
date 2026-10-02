Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C953F3C3F7F
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 18:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790964193; cv=none; b=slhYq64uZpbyB5Tactz+45ng9yQN0iPv+xh0YY4MCUrcS61rQiX4h/XffTQvajDNn144vKhMk/E55lfEHkf8scUktdBFtc56tAGx6V64yj0nG9wyumy+wchFlR8m1OAwEyGcUV1TIbGzbeO06ZAiFKpUasdpZImX3LrxlOn9iCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790964193; c=relaxed/simple;
	bh=F9KQB7YCeixacECKQDJ4iTtuGQhXI9ZEbqDchXrslnk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jDclWinF662oK5Hqx+A6T+e3sIhVdegQpypvWQiuk0t+dkcZAmP9BTBL+MMdnhRWcDMzhp+OzIpKCWA78H7ALGOFxUpZcp8XVl5Qz3YUgwfzftANCD1Xvur3E44pB8lg8k4cowIBW78Mg8iDywANOFNLyqwZH3ewYiwVkKqoHtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Mvn82OLs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n0ZwD7KV; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Mvn82OLs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n0ZwD7KV"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 37FB61D000AE
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 14:03:09 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 02 Oct 2026 14:03:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790964188; x=1791050588; bh=rmMrKZfbs8
	ok+tehbwu4qnFRulx8ZvPekeTWNv3Mnzk=; b=Mvn82OLsIwufNDTfSSAriFBlcs
	W5rLinWTvAvBdKHemtegZJY6V+8EZ69uQv/W0RzqYWRrB6WPVBq7BPIWjn90ueQP
	gS6B6DYVg/gCyErXMRutOxvLZDOLEZjLNW6Yg2B3sWYn1a794GiXMZosybqk9R3J
	QMMlvcG9D/gKenDNleWiz934hNessj+bjoIvOtQNtBBPA8g70Y8cH7UWN38Zu+Q/
	LfcDMXO0nOyR8xEma63neCqBcd4mEPULV9malRjb8bns8CH6XKzpBKsq47gbs5Gw
	Sg0nQYhSujJb2wflHVo+OxfzYOuNRZXXwP0xyx+KH2Si9AmBeP5N+Cqw35Og==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790964188; x=1791050588; bh=rmMrKZfbs8ok+tehbwu4qnFRulx8ZvPekeT
	WNv3Mnzk=; b=n0ZwD7KVvqIbdGVeNb0EE96vY5Gr1cpYDOJEFcpRPc2T0qgV7M6
	Gf/HJ36skKhWcXHTUjrqRrH4gQ4dYf5Hh3VfE6IAclRXK9iN1ZYzNDPvXQUq/ab7
	fIJGkow4CitxhRQYBNeAGZW8kfhRVMZl9k5EJvxvftT7LNhe6qgfWCr3zH/FEm1J
	cJS8FrhMqdRILlAh90yr7c+Y+EzLe8+aWx1PnLfzlHLL6TVnGIMdW/0RXBWOZKEn
	67u/3y0pkQ6z5WuOXFH87ZKrCjQ9Eoz2ECfwvxoYW6oZmGDe6Y8oZqS0ZZw8iWRH
	moCr4n0kvX3zNTQ66FSqQvsPo2ovQB9mOtA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790964188; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:fXC1d/jnVLKMMWDFvjGYG/YvZCws8aIuICki/Wi9rIAD5RF
	JKk80EHQvk8FOKdAAbCb2JN6aog1OluE17Pzaz8GoBdowubFsGvts9k2gPUBnjvv
	SFtBmEzojxUzlzgmo0gPPsmcQr+iOG8xHPuiPtCnOfGGWWILIErL68v/79B9c0U4
	UKPC3EriLBMKLxcFF0flL5O9WvL2LGGACop98bjVxvxiJkjjdU9lVJL+F7LREXwC
	wYPxwvLcKQ43S0tpCqKLKLFeuCsFfKyuRDlTWNYGCVqCZ0AUgHMqdsllk+GKTR6K
	l3Nn9gGTiLQ291ZN/Sxx8z7dWpiz7cwciadUmTQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:35A20X3BjX2eNDEMf1uZt4u8NtnOzHAeMcBiJ4Qz9M8=:F9KQB7YCeixacECKQDJ4iTtuGQhXI9ZEbqDchXrslnk=;
X-ME-Sender: <xms:3PG_avmx_Fh6fWpkZ698x08c_eBA6Q8G1D9zfwBAOEWurp1o5hLf-w>
    <xme:3PG_ap09OE5m11_7VO9vP7Hf2CjWJekRajw-ZNWVq31EOibRB9LfXdnKDuVGunWdb
    kV2dVZagAzKGG5rfhg5fstMTdSnwhynydRGt_0lOy9B8JH2Qi2D4RU>
X-ME-Received: <xmr:3PG_aqpX8zWuOeWRHRo10uugdO6AU69eggwXBGd1mjVwmsbYvCjxNrMoMfgEpoph9wf2pnA8xmM6ayQzbVkgULpF19-JAO6Wwrhv>
X-ME-Proxy-Cause: dmFkZTEucESUJTa5HlTPT0oNgmcsACb4zOBbdIK0dmzSHKa8tRecI8mgvXlcfUzKT7fJmy
    DMSo5cswku0OosIIMukvy4Tf8TPBU62Y4EywDs9K9F9Q102NRjqCdzT/BXW9otPDqGZORq
    FRTPr52F2gBxDAawMt8Vc1/RrQWRccqDMgc2SJpbTu9CMw0HXIcH4lCI7kpJ/2HgYYvvW3
    cIGH590xKpLd+1+J9X8iGRrv82t933Wgy0mDHza6HpzMAQBtMZQ8IlFLUQP2k/N5p/1LIZ
    zrfvZSFwVlzwI7OrCZk7abk2qYkWxVOGa/RoKoBXYGSxqmuY9aeDkigRxKpx67zg+s54Zs
    JaFsM5Cg+8DZr5wb0dhch7B0ZjyXeT3fu3ZXXzX88LVEjfWOb8Ysn0FC2VOWTZkwfibLr2
    7SHNN9ZL5NdgygdG4y2Zgx/fYdDT1WnIwQrWmrpgjCItZTauaazmUwZWCobkMR5Gcq2DaR
    Sm9vAu20XeRpWW0SeMdeuZEbSYv5nMRyvnf3GzMXmCoTzUD7fjjo99UIfl6zdMUvlhd2Wa
    Pk0WLhq7roA2P1bkom5J9gkhpttMTL2vfVD0ZOEFgqovwe+WCSAQAVZ87kwRZXmrjdV4C7
    vDrZCF0foDXahFlXxkCIIilDercVxdBDG+jmB5NaEYeFF3z43FD0W6Ek8p5Q
X-ME-Proxy: <xmx:3PG_amcdN69pG21a1l9O9oGeVdJNWihF-WnxHwXv0i_QxJoykLTj8Q>
    <xmx:3PG_appEFzmw0J56yfPoLb3-v8Pyzwl1VMg-I8hguXTTo_zIEg6czQ>
    <xmx:3PG_anHfGE8luzxDkk8rcyRA3AVnOX6iWIXAVmkmr-X3jYD3VmUBZA>
    <xmx:3PG_apu8bYgcp2JlpIyEimJLEaPVI1c1lJ6xlMCCirPrqBStxXCaJg>
    <xmx:3PG_amL2ZgvQg46tA3n8p6nwYLMeLot1yvz-bseh2gaGc2AksRah4s0M>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Oct 2026 14:03:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH] doc: don't require a SYNOPSIS in section 7
In-Reply-To: <xmqqv77kvwgr.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	02 Oct 2026 10:33:24 -0700")
References: <pull.2246.git.1790957227881.gitgitgadget@gmail.com>
	<xmqqv77kvwgr.fsf@gitster.g>
Date: Fri, 02 Oct 2026 11:03:07 -0700
Message-ID: <xmqq7bk0vv38.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> diff --git c/Documentation/lint-man-section-order.perl w/Documentation/lint-man-section-order.perl
> index 02408a0062..ce60c34809 100755
> --- c/Documentation/lint-man-section-order.perl
> +++ w/Documentation/lint-man-section-order.perl
> @@ -55,8 +55,23 @@ sub report {
>  
>  my $last_was_section;
>  my @actual_order;
> +my $section_tweak_done;
>  while (my $line = <>) {
>  	chomp $line;
> +
> +	if (!$section_tweak_done) {
> +		# assume the first line is formatted like 'gitglossary(7)'
> +		my $firstline = <>;

Ah, this was obviously buggy.  Not <>, but we should use $line here.

> +		$firstline =~ m/\((\d)\)/;
> +		my $man_section_number = $1;
> +
> +		if ($man_section_number == "7") {
> +			# section 7 usually do not have SYNOPSIS
> +			$SECTIONS{SYNOPSIS}{required} = 0;
> +		}
> +		$section_tweak_done = 1;
> +	}
> +
>  	if ($line =~ $SECTION_RX) {
>  		push @actual_order => $line;
>  		$last_was_section = 1;

Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14823E5EFA
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 21:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792014295; cv=none; b=Pj94w47hYbkVYBQaRLu7c1JBpU9F+JocnkpVUZOFOGK8L4m+UCMDFxM3pXvJk7l9Opd3oQ90uLl2MnLPC70DaC/Y55Jik1jdbvqcJCQQuZ/FWG9dvR5AUXKURzLi6HQJxjuETJSBPeIpkrbECE/t0hLns6QE3nHxGAAwGfxoY98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792014295; c=relaxed/simple;
	bh=KsHkEuocJT9Xx7VEzQqYztmsQKL1LDKDXLcAS+oyCQM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ncVuZYgq0bV191AZo1fMqfBWH7XYttluDtC4RVtznUKN46QV6fR9+y0XB85omG+w7jOMV0Puyz3TNKQmBaC96j5F+pKwBDxuPlvVBBIi1fCjE9VklAcf4LtWxTdKica7RBfOb1niHv4S4DpemQaOxgfedeTnfao6LH7bdJ/6ngI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WWYdWmnd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BOqbhsvK; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WWYdWmnd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BOqbhsvK"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 24005140012F
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 17:44:53 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 14 Oct 2026 17:44:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792014293; x=1792100693; bh=XOIXXouPe2
	UCxc4O85mjAdI0wKdYkk9bPG3ZNjvCwYY=; b=WWYdWmndjzu+KGCw7jiBw9ZSlY
	4uycOpyuIVKNJDTIsAj4pTIZ2u4oaHW34jc9lYMCH0qfoVgffIT0DWA61pANVOI7
	gb8XjWjs3dV2cdla1KjxwuV8QSvCLY3usePmqvC8OfnUQ+yCVllD+103k516X1aj
	n40DUBQ407pBx+XLAiby1dOfBt3ueFyZXnqu5R4O70syHTRidMiL/KG0DLmyWbrj
	q1/Ur7pPu9PaqW/J8w63/Hn0pV5JHePF6GAuahFtiF2hwFpLsvTb+Yi7atZuYVnC
	kz77q3+oIGJI3DW1kCDHgWUzFIZn0eJ3NuTE9UmCycwMALxDSaBgKgPQv/tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792014293; x=1792100693; bh=XOIXXouPe2UCxc4O85mjAdI0wKdYkk9bPG3
	ZNjvCwYY=; b=BOqbhsvKrTeI/bm5DSMLj60MhGdjW25H2R9dmbFPaV7rIMvLFhy
	TfLYXKbFmozMk0tTDHz5pLrHiyG0DSfTK6jSfFKbxcrDK57Z9+182IhsjkemvJPz
	TeYIpYjrJDKhnDvKKMjf4rftmrYBkmeWj9LbKD+lhmvXhpYngKvl9UNmyXrVfgTf
	dk9eXFu6iHWDcHVSh6wT/4/GPuTO5VBAn89p+9iVDdBokRR+JhBnJVvTyjqgoi8M
	xiFuBErYbuaXSP3gS5zm/h2soP9pwRJxt+IQZVD4e8wWwyeW0cu9+i+Tu8Lnkhx1
	CONi2/5J7NDywU7J+NoGEHP0hrdiKLRQJ5Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792014293; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:TDyF5OHALkaTuyu74l3wh487T+DINOryMEe7ub+Nl0elYb7
	kGv338ZYJIVXClQEGpsIFHnJzT0zDzktH40huq2QAUvF2f0ThbXhabJwlKFXUOmd
	X55FshKX3V2yTnuhnfLg+Q015U/XYCRxXUE5wxmqdf5+yMN/37AtehwIXmh3gXGa
	LfyNVSlAJ59cYDm9Fi9N4zDeowGjlLa1JEIqDkwGOwI6/S6i47d4dRxVIvuBWe1V
	paxLy0qNYwQElv411oNIQtF4ETF4wsdDnG/59ehPlGZ8l9czUhR8XzL1ZdtXH/ue
	yCx7QlFSEO15Pdqt4mzZZ23EMetLTOdfIePymeA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:oW8KdTlbQad4ueiLFA1LMiDBQXMl1UlF3OnzYjPJuVA=:KsHkEuocJT9Xx7VEzQqYztmsQKL1LDKDXLcAS+oyCQM=;
X-ME-Sender: <xms:1PfPavNiTfF5pntPMbDfJRuH91PYd_vjYhS93EPMElDSEOSvj3cgyg>
    <xme:1PfPag80DJqg3TUWcUVIh6ff5sbgIn83eHNP6lXhdmD2OXB4JhkQLi9_aiddPIYQf
    0_Jh6oAsATiAeILwJD316uWlPrXIc-eSF3raoTdXBUKhOscLSTTRtk>
X-ME-Received: <xmr:1PfPajSytftFNlU4BxQX1aoi1FAhqnoHdGTR5a9yA-jcaXXk51Y6iV85on0q0KbmDggNwNime5YO0_LeWhBL8IiiALrIm80jBMyb>
X-ME-Proxy-Cause: dmFkZTFsQfYeCaWWkCT8M5VOyI8YRvkgYq8PBqAz3LUzFFGuHePxAl6ILvqpcSoOl+PUpU
    U+p1GYPYXhuaXryeKufrF1DnVvVZUCe9+lJbzvombmJM4diWnqGUAgcdy0/WmmMG2dE8H8
    EPHYr3OF0F12MVU2tst4xliUhJkYye6A35eLwYGOdlmE7BgcaH+kNMSMx07RJNpZiu9tre
    oXD9iDyoPqVTeHrJuVGnLIHIMSWygitw+BQWpTbI6NjqUFtvCVW37XJyeGUd5mwY8ywvbN
    GDvaLdFyw2hJSC2NmozToOZED01I0wl1pDSbX5ajQwYC/BEbSUPK+I/tptlPv63XkD+nZC
    iwUVBw0oewlgiNyn7NQOZ0R3CHJJTgfRfo0tE2JtQfL9OfSuvUxjb5EE8Dh9oL7jJ9tfma
    9BqYgh5ACPU4rNQsVjov9gtlzv8ux6/stlnhNPB+Uu1u/Fac2g5+EO8uy8Ji8kHePiAFQr
    dGKG58+50KcZwnUDjJkuzWoVxBnD+8qY+o3XnnC0+2STvH+rq1nzluklu3JwkzLve/WIOT
    UH61pD/KYLzR8cuWH05Z5Ztnw1SrJ3LvlioIp4prsLOGI0RbO/8VlnIivbxuvObz5yUSt1
    VaoKVpIsuKHFejAwPbaea64YofhITWWKx8pDbJi5K4M8SKtT64QpW8+Ybydw
X-ME-Proxy: <xmx:1ffPaimmh6PDLfGz0wlsq6x7yXZvDK3jFG7EmDknj6RdkbG4i3O9CA>
    <xmx:1ffPajTLF-m2NIAcU2OehQBbj1oFksavpJW-_wlxhDcFd_MJJdOS0Q>
    <xmx:1ffPagOLOFpyBVg2XmcpsAKa_6ibvbg6v8uPC3U08VRScQxzfTVJmw>
    <xmx:1ffPasX1pn8RMY4qKXyXv0wPmX32VVthrjjKPok74K7yXtBY0se4HQ>
    <xmx:1ffPagrvaav_s6K6ShRKqx4p_u9ia15IY8aYn4GDAoiGanpoqBr_2SvQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Oct 2026 17:44:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 5/5] date: avoid overflow in approxidate relative-time
 multiplication
In-Reply-To: <a4e602b9e726081aaaf73c627548b823a4d35477.1791958171.git.gitgitgadget@gmail.com>
	(Johannes Schindelin via GitGitGadget's message of "Wed, 14 Oct 2026
	06:09:31 +0000")
References: <pull.2253.git.1791958171.gitgitgadget@gmail.com>
	<a4e602b9e726081aaaf73c627548b823a4d35477.1791958171.git.gitgitgadget@gmail.com>
Date: Wed, 14 Oct 2026 14:44:51 -0700
Message-ID: <xmqq4ieoq7n0.fsf@gitster.g>
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

> On platforms where `time_t` is unsigned (and where the pre-processor
> allows us to determine this fact), reject counts that are too large and
> report a parse error. Narrowing them first could otherwise produce
> negative or truncated values that become bogus offsets. Leave signed
> `time_t` count parsing unchanged.

Does this mean that "git log -p" in a project that were made on
reasonably sized platforms and then cloned to my box may cause the
history traversal to stop with an error when a commit has author or
committer timestamp that would not fit the time_t on my box?

It would have been horrible regression than showing the entire
history with patches with bogus timestamp if it were the case.

But I do not think that is what happens.  approxidate_careful() is
only used to parse input by local user (e.g., "git commit
--date="...", "git log @{...}"), and the changes in this patch would
not affect behaviours of other uses of timestamps, so we are safe.

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  date.c | 26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
>
> diff --git a/date.c b/date.c
> index 014065b419..0d65804d2f 100644
> --- a/date.c
> +++ b/date.c
> @@ -1298,7 +1298,18 @@ static const char *approxidate_alpha(const char *date, struct tm *tm, struct tm
>  	while (tl->type) {
>  		size_t len = strlen(tl->type);
>  		if (match_string(date, tl->type) >= len-1) {
> -			update_tm(tm, now, tl->length * *num);
> +			time_t length = tl->length, num_t = *num;
> +			time_t seconds;
> +#ifndef is_unsigned_type
> +			seconds = length * num_t;
> +#else
> +			time_t max_val = is_unsigned_type(length)
> +				? maximum_unsigned_value_of_type(length)
> +				: maximum_signed_value_of_type(length);
> +			seconds = mult_overflows(length, num_t)
> +				? max_val : length * num_t;
> +#endif
> +			update_tm(tm, now, seconds);
>  			*num = 0;
>  			*touched = 1;
>  			return end;
> @@ -1368,8 +1379,15 @@ static const char *approxidate_digit(const char *date, struct tm *tm, int *num,
>  	}
>  
>  	/* Accept zero-padding only for small numbers ("Dec 02", never "Dec 0002") */
> -	if (date[0] != '0' || end - date <= 2)
> +	if (date[0] != '0' || end - date <= 2) {
> +#ifdef is_unsigned_type
> +		if (is_unsigned_type((time_t)0) &&
> +		    (number > INT_MAX ||
> +		     number > maximum_unsigned_value_of_type((time_t)0)))
> +			return NULL;
> +#endif
>  		*num = number;
> +	}
>  	return end;
>  }
>  
> @@ -1398,6 +1416,10 @@ static timestamp_t approxidate_str(const char *date,
>  		if (isdigit(c)) {
>  			pending_number(&tm, &number);
>  			date = approxidate_digit(date-1, &tm, &number, time_sec);
> +			if (!date) {
> +				*error_ret = 1;
> +				return 0;
> +			}
>  			touched = 1;
>  			continue;
>  		}

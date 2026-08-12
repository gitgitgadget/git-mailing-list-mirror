Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2247332628
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 06:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786514872; cv=none; b=szu23ShM9ULpii8lcOTtP3WnWBJW9WJhj5b4qjEXtq1smr+VahrABe0sTSNRGAb5O8tj0awCJMClTLrhCrGWdA5JpiGaA74Wq9lz/g/O5n6iy8PPJPOC/XMHbkpCrgIMgWG3uiNsrGgxcYBi4u3eNjrgC30iT17Y7/o/bNTt8p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786514872; c=relaxed/simple;
	bh=FfCmOrh7uhCxFNCsBqigruJ3d4UhknJB40JoyNtqLuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FH4PmTbNb0zu8uioDLrVZnk8EJgnNq75+XQ2rucP0OVe48Do/Jpo+xameP6L0EZkX6W+uB67I9r0r2pGBVz2lJg6VaxhHpHz3PB19SPgZsqFEgo8x0tiF7SvNFNTAds+uxsPRBArItgCsIvaJ74h3MT1EOFP3MZMvFZjDOn1dBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=avrFMuq+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H5S4MSCI; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="avrFMuq+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H5S4MSCI"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 0334DEC020E;
	Wed, 12 Aug 2026 02:07:50 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 12 Aug 2026 02:07:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1786514870; x=1786601270; bh=LYt1NjnC/A
	7O6AuONKdEXg+YNoKo5uLrfXQIhkPbKVE=; b=avrFMuq+2GdEzDNx7E2ZTAM7a3
	cSKlkkWO6TFIX+PZOL77KMWLrMfSuGfTY9ukRfwCFJrrgvlXy9vl0ImOI9aRHxaL
	6u0RVxpaOrgA6WNcgNw98YZZgATttC9TKgK3f5JbjKQc/QktEfhaF7r/vyK8mIdn
	5GhYyis0MyQ7OlS2AH95tRK3gDzVbDFT4JNHuEasUANxu1Ws0fkbXMZP6Sd84Khw
	2K8IZb/J9eKYB9tuJybo88UHTxT0kCfIDqqRqiU9LMR9ZdzB7yUuj8b3NeAeat4x
	4IfbfP9I7neyIlD1NtJswiaPjb5OkOj0R17hOy0Rti0utCCfbTEpWOyywnKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786514870; x=1786601270; bh=LYt1NjnC/A7O6AuONKdEXg+YNoKo5uLrfXQ
	IhkPbKVE=; b=H5S4MSCIFdxMsuxSszIKjbBU3xu1rrRfqyyPANFgKTziw83Gbb4
	bHK2nZ6qXWOXPHkca+EGf/48kGBqbyo3XD1IupA7p0Jrs+RCcmiwDjeWdZyYUY5w
	9IPnbxXdrzfb63m17PCbl4GwkZ9ehz1kQDjyegWe1kdMeMomfEhg7kdURjZL7/aK
	mzRfYrYenjJ497YQ+kblfgkV8spS+fYEKBUdAtQRIupK2bhY4CppJD+XN+yu23fw
	XYpm+FR+vtrRz76Kppl8gW9oXT6VYRTP8Tc5xz5WZgyHaxLZsygCqwGcZ5v7NS+Q
	/axAL+9tirqXCDaJc3M/DxT6MRbompRPX3Q==
X-ME-Sender: <xms:tQ18an3Ms1sjO_ZA0qQmNi9QJBFkO2dAev1V9cBp6CHfGoKjcSO4NA>
    <xme:tQ18athWVDBcu5V_ticxrPRK9-xV-8cilwupbfDmR-k8GIurN2i9qMePiCy-mdqE4
    QDmwS82VHl6GQczneAV_jIPvd0L4LShMJW2dFG5ZN9JvfeAAazbIw>
X-ME-Received: <xmr:tQ18alQSje1RGn11yhKFx03qmuUnfekdKxQDxvbgDboRxNguWwZnwpKZb7M8YPkStvCu1_gxNKmjHh2N0am-pPO5is8X086suu08GYjGjQ>
X-ME-Proxy-Cause: dmFkZTEScmcLv460d+mGWNHedLf8KgdEnoKaLTOruDpgoVeHKf9SjxtKXyy6nvAuXdEjV3
    BjZZyWzocOVuFdTxPlYdtjcIyQ+HYF2mL7ywlHJJKk1I9bnlKnjQJR6ZpLaxyLbO1Bev/C
    pmMxGcJtWq3GBVk8282J+7y7hgxnoOTCcaTRJy8ramju0VvwJSFPSwN+1V3qYqrE0V8t6W
    3u2/O2UvzsrVFriAr8GSSZYcl89L+9VV0NQYtFzAehCaDPWEzfJO5Ein365vqCeLli0kNC
    jRX/ka3jyRYX4hgwLxt7DOzsMBYZuJX1TKWecW9VNB59xNvTK+jPtee0oB63acHrHBNJBQ
    xUvxrRV3dh2uYeJquifGH95j+9VAYC8vZ+5GkM65y1CEZoJMOIpcrOdbO1V1RMV5nCDDnh
    DPdjImrL/YBdUE7sxUSXJYogAhSu8Lzp0XYu4rURtZ/J/gAJ+miTYja3BkAHOo4FDuSa0Y
    wPkNcaGZzryyNAv92E1qy18RWyk17gfZplFS0wTiCWgo041b52kRsS0c4jbUfregYvDA6r
    yrBLfn0EB0RIctHEzKw7/t4m6lJ0VZPqXv6avmU5DLHp9wx+IBWu8+Rbk0UbLDD0GWizNb
    pg5j8Tj9yGs6klrn1KsSTqtIKaY21Owd3HANiOTaz02jVNu0iZ0iFtNhZSiQ
X-ME-Proxy: <xmx:tQ18amjJwolO2xFYMoOCGqA8x5-YS-cfSatqO7o1HlYu4hgm1C-s4w>
    <xmx:tQ18at6sJO-s-lNFmVv2jQjuJOHTGvXZQM_qwvPIjC8HRifWv_rk8Q>
    <xmx:tQ18arCPJrGJ6tmySRPkYtvPIEM_buB4pbE6z6AWoqEIMUjaGMK0_Q>
    <xmx:tQ18asZXlpb7TOnpGGfp0AtAFuS_9qZICTHt7q85-AeqmhdeBxHvew>
    <xmx:tg18ahj_6cj3YaGI9VgEQ6K4_Ud3qSBcTmH-U5dqSIx9J3c4ZhaZdyIE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 02:07:49 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7166d758 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Aug 2026 06:07:48 +0000 (UTC)
Date: Wed, 12 Aug 2026 08:07:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v3 8/9] odb: return temporary ODB source when set
Message-ID: <anwNsTpB7XwZa8hh@pks.im>
References: <20260809190106.1565882-1-jltobler@gmail.com>
 <20260811175415.2044235-1-jltobler@gmail.com>
 <20260811175415.2044235-9-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811175415.2044235-9-jltobler@gmail.com>

On Tue, Aug 11, 2026 at 12:54:14PM -0500, Justin Tobler wrote:
> When invoked, `odb_set_temporary_primary_source()` installs a temporary
> object directory as the new primary ODB source. A caller that wants to
> operate on the ODB source of the open transaction must assume that it is
> the first entry in the ODB source list which is a bit awkward and
> fragile.
> 
> Instead, return the newly installed source directly and report the
> previous primary source via a new `prev_source` out parameter. Propagate
> the installed source through `tmp_objdir_replace_primary_odb()` and
> start storing it in the "files" ODB transaction so a subsequent commit
> can easily access it without relying on the ODB source list ordering.

Makes sense. I'm looking forward to the day where we get rid of this
mechanism altogether.

Patrick

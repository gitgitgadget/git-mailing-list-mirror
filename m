Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCEC3BBFDB
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 11:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784286736; cv=none; b=qNZpFKIooSOhBiXAD0voYsXktxydokzHokyLgXYq2QdnXWSjBG/nn+b3owBJIApaCUr1VMBagWX509cp2X9dthwswln1UVuXwXz1sJfxbI9k5Y6ZH1LauUaOrtV5C38WXvdZPlf/jgmSdEgishdZDf4Vu8nhdCo9DyKFe81emBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784286736; c=relaxed/simple;
	bh=XHzmaryGnqmtbh3RgTAjNLXcqKczbbM1P+UrHnV2m4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQabB7zS8ewDinfujEojrBHGnAZG55toSPTJ0Yn1lvbKUSvHmPl46333vcu8GTyoI7CRoJOP7weBzJf7Vff2Ik5aXYYqh0Y0xLjJxi3+0YadGvxo9/vXtcIDQL41lWqiQaFowkHNlm4DueaTQBjHIBSHlmGUVBVeY91MxBGgqi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dWhvzPPA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DKWZfGuG; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dWhvzPPA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DKWZfGuG"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E2DB57A008A;
	Fri, 17 Jul 2026 07:12:08 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 17 Jul 2026 07:12:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1784286728; x=1784373128; bh=fLf6rxqo+k
	+JCz4uM0Eq8m++Ptts7PkbntWO3Q+ukeA=; b=dWhvzPPA5MQMtOX61tE/QZvfCN
	0oqD243LtDZyl4ng79r6a9wtVa8WhaLQhzPjDf4Ab6bJtDNiEvMDhqWrpWQeQrWT
	G6kQ6UvTPl1z8TKMhXJYUFMYl+6/DA02j1NXiaWEx0Dj1z+jzULTLFshOG2t0kw3
	RDPBbapisqHd85LtWkWEUXLS3+e8G0VICt4xWsz4cBuQMwhPzGcZevNo7jnAXlb1
	OEOaN9W2ExfXMlkc+RJU4V9v14aRT93oUwX7t1PdPKCiouUe21frrhb7V8I52xZk
	iLrLSOMSBEwbtAlUJrIHDZh07KsJWPdYptWAdNkVi6cP9lAJhEYBlQ8Mg7Og==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784286728; x=1784373128; bh=fLf6rxqo+k+JCz4uM0Eq8m++Ptts7PkbntW
	O3Q+ukeA=; b=DKWZfGuGj9N4ngOyXdPuE9389F5P5f8medVUxieD+PL2aOrWhvt
	PsAj3Yxc8gkYrWRzCtyMCmvuDRvZEOuxQPAkmsJauA1n4ieMD8vkyWgNfV//fA3n
	R1WcFD05/ftgoryQGMBoDPFLgQzd+B1vRPhUWqCNl1vhnJw8evIyXRbxJLJUMw1M
	6rrCcFPwx8wAc8lwHPJa5xlY6lZ3Ma+uE7aGckQBtu+8rEaeQhOHPK/xldjEyCvx
	EX+BXd1m+N45xNuYG13EFxXSvKtfiz/qe/vn8umwUXO3ZASEn+xK0AbD9MpDeOs6
	ZzHKKlsHLOewmpPhr1PptYKUD5P4HdYkwKQ==
X-ME-Sender: <xms:CA5aavIYvKsw_oMXlj0-_MOxX59-VA3UoI3uIsbpvUSr0DXEovHY8g>
    <xme:CA5aapKqK9FqUXXiKojnVumYcMCDrWxQQDDNznshyOrs-D_dKuPaepZ8JkMLJAfME
    afcGbunSQ-PJ_e49bgBialwk0KoBZowFgs82F8NdStYoQIC12qj>
X-ME-Received: <xmr:CA5aalXCt1nUL_pca7ifidPSfSwiIVFkw-jt_TOiq9EWkrsZLPHN_gTxcw-UPvtfli-iPlSKjWJPgFy6i8vLgofL02I106weMHhVL_JWk2A>
X-ME-Proxy-Cause: dmFkZTFymHFrJFnCuwK/ACpk39t2pEtDtlK/faysvqUbB6yv2/B9NYUD+7qoSLSxhaWncn
    w6vAmGObsuDeDBRPvkW3/AVvzCS/uUE2f6+I+2ZMjCH5XbT98LSvgNiTaY/gYWd3NGtvzn
    3nvYdLWIqQTVCBRxH+uC11BwFKEWxLNuqY8jbIHDiqVoRM6dxkva82qxdyYplitJ+K/RLY
    WjGhrdGJYR1dbW/pyt7OO515XvQ6p2Qnoyei/D4YZvQLii57AZvPXPIVC6NjG+ItEhS24/
    hfZqL4e4/pJRSclUXLJp7GHY3mymJ5YXO3SXClR+xagBQ17OZ2hfX/VZV8kot9oc1TitAc
    E8uLodV055K7COvvdA7l+2ZKNgyYZs+YCi4q3DZGn6wKaX5J3zr791C822UYseYWp+Hc3c
    UMW4x8LG9GyeVR/sOaENlovaYvLlF8laWpggPhRCWwwPIsidkmSnSxncegeUwHCEP5VaXa
    IJtErKvZwzya5We8Bbu39XjSJ4I03huBjc4KpRyYxGtl/HUSrXpXz8oiwytCq1RuE+1pnA
    h1pFsoKIlY7T1DhHOOtyGKjWlBgwccOBYW59ijBrCoh4kzU5mi4L7DCbtInH1JfN+n2UKc
    WxAnzL2xBBy8ZKpHCzefGLp90R4+7MwJoGRz4BQR2t8tFdR09AWxJ5+Hm4TQ
X-ME-Proxy: <xmx:CA5aajhlDFD86xB-D34SLe-QkhEJKLtkCzHEdTLni_yvFvfBE0lcbg>
    <xmx:CA5aao_mnQGHOVOnLX_sNwb7S0t51fBJv7zoSzPaJOzYsEEB7-6iUA>
    <xmx:CA5aalCQy7gzmGlkttkukkYlV5CRmsXm0I9drv9xUUi7sz8A1j4H7A>
    <xmx:CA5aatIEqdfDQfzdY-bOGa93MZR7lGdCFod_34YsAEWTednEDjQ6Tg>
    <xmx:CA5aaiiIGu6UJncay22gUDi4cnd-VMvDO8lfmebVSlGAYM-5Gu0cK8Uv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jul 2026 07:12:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e3cc33e3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 17 Jul 2026 11:12:06 +0000 (UTC)
Date: Fri, 17 Jul 2026 13:12:03 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/6] MyFirstContribution: what if I don't get a reply?
Message-ID: <aloOAwOtutgPbJu2@pks.im>
References: <20260711192650.2417665-1-gitster@pobox.com>
 <20260711192650.2417665-3-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260711192650.2417665-3-gitster@pobox.com>

On Sat, Jul 11, 2026 at 12:26:46PM -0700, Junio C Hamano wrote:
> Tell readers that pinging is a perfectly sensible thing to do when
> they do not see a response.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/MyFirstContribution.adoc | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
> index 4832e5bad5..fc2ce2e785 100644
> --- a/Documentation/MyFirstContribution.adoc
> +++ b/Documentation/MyFirstContribution.adoc
> @@ -1438,6 +1438,19 @@ substantial rework, and mention which parts of the current series will become
>  obsolete so reviewers can avoid spending time on them until the updated series
>  is ready.
>  
> +=== What if I don't get a reply?
> +
> +If you don't receive any review comments after a week or two, do not
> +assume your patch has been accepted or merged.  In the Git project,
> +silence does not equal approval.  It usually means reviewers are busy
> +or haven't noticed your contribution.

Should we also add the third reason: reviewers are simply not interested
in the patch? It's a bit brutal, but that's quite a common reason, too.
In the best case we'd of course tell the submitter that we don't want
the patch to not leave them hanging.

> +If your patch is overlooked, it is perfectly acceptable to send a
> +polite ping to the thread.  You can do this by replying to your own
> +cover letter (or patch) to ask if anyone has had a chance to look at
> +it.  You can also CC additional people who might be interested; use
> +the `git-contacts` script (mentioned earlier) to find relevant contributors.

And this paragraph here can remain as-is regardless of which of the
three reasons applies.

Patrick

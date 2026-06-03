Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB02D22424C
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 06:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780469703; cv=none; b=BGRN9KqqvMI6tny7mvIU0xPezj+Z69N3mWnwYpY9iznek7/lYvpjFBSFbxPk4kq4wfqanDDo2mwrrr0DKPn6SGTIsjKKJ+qhd8m8Kkp8ujnvn09EmLcjlob2yv+sBNP7XwkXfXUOnbGz0TXJRMljJrvxfZx31WHqCSuiBzgRQgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780469703; c=relaxed/simple;
	bh=FnhI81R6nxkd+JdUdUbw/pnJNZT16SyXR3mi7P6R8aQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fEBb4B2p8OlfahF4OeLrXG2Tkpeg7gtzpGRoOcW2HnsIMrV9eiqTEqOQuib3kGYjkXsEk1DE+HfBk31b4txEtYSB1ZgAKNiSf2It4KsdLwPnQVItN1C/n5162FOlct+eafNzEqqiyxjrlC3PDovhVrREoQ/v8tUIRiX337xcmC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=E7H9bJCF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a6VkxpmL; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="E7H9bJCF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a6VkxpmL"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 349D21D000F0;
	Wed,  3 Jun 2026 02:55:01 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 03 Jun 2026 02:55:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1780469701; x=1780556101; bh=5sQ5Mt1iqQ
	KIvesHtZ0lT6U4kfPhiN/ypBU35KzzjRU=; b=E7H9bJCFMlPu4DvuLxbO42+l12
	LOwevw7E6qT5W27OUJHwRSrCqa9/Yj6pxylmGY89kOl9rP6WtdgUoDkDjxMoBgIQ
	lZS/mQP26OLg4aHRXxZlT03S0yWSKRT9pFiiXWzU5q0jIiUXzEdUcNI8fIDiGju0
	4sG05tPTg2hGxeoE6K23EvSj1wQqAuGfoyHnhNwzlj0Fu+/48CA+nLuKrALwkZNP
	X4o08wQ4ieHaiBQib6LPKC7CAkJBeLuOlLondwdtocPNcVxTZZ2YthZdw4kEogvU
	c9ScJUOAA5E4679HAEH4rdLfORQVqSFCA8SPUWkSfl3U6xO4s7Ehp6enwaWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780469701; x=1780556101; bh=5sQ5Mt1iqQKIvesHtZ0lT6U4kfPhiN/ypBU
	35KzzjRU=; b=a6VkxpmL9QKdBg602sYouqdo7kvSyhR81RZ/mrgoLmJJZHBRmhh
	M4dxYRnRN+bn+x4G5COVGp2rSiafgWGjtfR8LM6c+76ehxOiMGKQbKbNWMawVRU+
	eJfr5CDkHtVzzy37tFAeen15D5r1Irlkicdk3fg0r54v0c64kK8meUP/3dd3oRkh
	jxcZmSGlXZUiLo/d8OuWirtl4aV0pk8qOaLOSrqdJq/YJgyAQ2uiCGN/oBTBuFv7
	lmUr3HEIrNyHwXgM/lak53kr7xhI4aJWI8zjCmnhSq89t5s9TtMvd3Kj5N0AeCzm
	4+EBhZE4vJcdTIZy+5NeAs1vQrwja18HgVg==
X-ME-Sender: <xms:xM8fagR4-pQFePYiYkUE4MT1ncmXnOeri_o7ractjqGASL2mxzyk-Q>
    <xme:xM8falOp-kPgUgljtr2ShZgykEyQu6-FKYrzRa3g55IYQLkx8yExt_2D_pP5J-zq9
    zvCedekryBWJtE0cLZbCvRCZ6ZkBxOkbKyfhdWZ6IC99OuBbD6XSgY>
X-ME-Received: <xmr:xM8farOy3GwPYHKagJoWvXZqg-zOGSTY0CKiwzcJhNO3gr13y8bpJfmMaQ7PWxsT9VshdW3uSDTJsG_ZzphIWHE-k6xgYEKwKYJ8D8Y3Qkxa>
X-ME-Proxy-Cause: dmFkZTGcpigh/uNOhM7tiwbNS/U6CLwQ18pZVYfOi4JKZRwWAgo0yynhr/0zbbh0nSgUMJ
    gsBICm2psKxEQ4fkNca9QXuZ3a/zON5JXSDyYmSOChILjDNOdFxv/hve6+sCO83uVihX2e
    CMuHjAndDXeuBWudYKmDLBB4fqfMy+ojPZPvLTDftcxUVgPQlndYGeCohDrp/0HWI9scXU
    YrxOLtP4E74IgwIJ7BpfbYjdWrWFRx5x0Bs3BjwqN8Gdc8SMe0jLJWCN2lXugZRdE5WZCp
    yhxBtt1XzGLDbqp7w1XS3KNnAQuJK4OwP9K/VGINM/N8lBvbYI/ASztqhGYzetMA7f5jUq
    VTQ3nDA5uEbBStQoTRn/f/Lh/luwVuhG27Jvb9lSMYC0QvzkyM778FvuFTd47KINmVlCX9
    iMSG9FXRabuFS3ZjyUY4eAjPzasukjgF1+etMz2EifO0N4spVE23MNV32xWg+ZohUVuYgx
    FHKdi+hPP8qTWJhnzFJX+eEepmgbvNCg/fqDISW2KAvY6Sl/Z3ok702Pfz2ZEoAqZNaHKs
    8gFGKMSlfMApeXSWcAKiIZy1P5dSSgVqUqmOh6BeSB49cTVJEgsBy8xgajM53SBSTFrbnw
    5BBBvbnaIB/dPiD0Z0I5pQui8UGR3suc255IBflIlP102SOc+5+tmq1KnP6A
X-ME-Proxy: <xmx:xM8fattrU4JHhPNArtn3_55saYxdN8s2unpT08I55X4qCBFD0aOddA>
    <xmx:xM8fatUpsTJPy9zlkZ_0IsgT-77l2BVBNihJZHcGT0wsvQzY10ydpQ>
    <xmx:xM8fatuu8RFr-k4A-BEA8M2plBLZxzcFDt9xAaD26OJ0TIPZZgxDCg>
    <xmx:xM8fahU_t1Axh5D7eSiJ_cL57MgJMfjOEF3EbC7utkEz92kUyloPsQ>
    <xmx:xc8faj1syDP6MXP_0S2pkJeWnswWb6L4Oo-GjJCTZpAZL1W1ORBRSNIF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jun 2026 02:55:00 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4e175fff (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 3 Jun 2026 06:54:59 +0000 (UTC)
Date: Wed, 3 Jun 2026 08:54:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Weijie Yuan <wy@wyuan.org>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Documentation/MyFirstContribution: recommend the use
 of b4
Message-ID: <ah_PwOsbYfDCx0H2@pks.im>
References: <20260602-pks-b4-v1-0-a7ae5a49e9cf@pks.im>
 <20260602-pks-b4-v1-2-a7ae5a49e9cf@pks.im>
 <ah8ALHMDVA2Gzz10@wyuan.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah8ALHMDVA2Gzz10@wyuan.org>

On Wed, Jun 03, 2026 at 12:09:16AM +0800, Weijie Yuan wrote:
> > +Contributors are encouraged to use `b4`, which automates much of the
> > +bookkeeping that is otherwise done by hand.
> 
> So for statement like this and with my personal experience, I would say
> b4 is a more suitable option for senior contributors, as they already
> know, for example, what Message-ID and range-diffs are. But apparently,
> whose who use forges may not know.

I think it's perfectly suitable for newcomers, too. It automates so many
of the concepts that a contributor has to learn way less about mailing
list specific concepts, which reduces the learning curve.

> Back to the patch, I think regarding b4 as a more advanced contribution
> way for those who had contributed via mailing lists for more than one
> time is a better expression or formulation. Here I mean "b4 prep", other
> usage like "b4 mbox" and "b4 am" are of course more basic, and be
> mentioned as tips when interacting with Git mailing list.
> 
> A bit too wordy, in conclusion: Suggest that new contributors master
> classic git operations first. When they are familiar with those process,
> b4 might be a good option.

Ah, that's what you're hinting at. So you mean to say that folks should
first understand the basics before basically automating all of the parts
for them?

I guess I can see where you're coming from, but I'm not sure I agree
with this a 100%. My main goal is to make it easier for new community
members to contribute to Git, and that means that we should automate all
the hard parts as far as possible. This saves those new contributors
from frustration, and it means that reviewers on the mailing list won't
have to teach every single new contributor about how they should thread
the mails, generate range-diffs and the like.

So in the end, it saves both their and our time, but the learning
opportunity is of course a bit diminished. I'd gladly accept that
tradeoff though.

Thanks for your input!

Patrick

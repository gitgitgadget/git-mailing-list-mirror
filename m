Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5867833AD9B
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 21:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790977091; cv=none; b=ZE5fhl+H5yj2n0VB03zSpMH4CWk4E6SUHvmF1o10gmvbxLDrMGUQ0SvRh/2aOYPO48pf5/4+anpkonsd0CsNUF5iAl5AkugIOliDyy1vhlW8jDOgVWFxCKqc1szFqg6OkyuEYbs9d4r8U+AWr8BNCpM6JCEC446aAXyr1hQcEKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790977091; c=relaxed/simple;
	bh=KlOkvm2JHsmDLCEMbGM3Vm/udVE5S54pKxwBcbVbIMw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HbAHhx5/1geZn30KSEWLAk3TYZm2JIvTD7tNfMJui4rs7DMby+DRsWrQkUmCI3NSBcISc+nGdxlFodCMVeLBC9XUnrchgO69R86mXBUl2DYomLYKGnKKF7Lt5OgNZw6cYyk+A+UnJxw8lxJ89UjsQROTB+qX1ICHUqrbd81hM1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=vpdxLvKI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vc/TCDAh; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="vpdxLvKI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vc/TCDAh"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 968FA7A00F8
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 17:38:09 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 02 Oct 2026 17:38:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790977089; x=1791063489; bh=HkWbsJ8eQ/
	ubDaGOR6VXQpx1dNhdNPBfoQNe2yDx+/w=; b=vpdxLvKIKib7bRpYW8lYnTOCg8
	TzhLH7luQMiNu1avZvHXA5IKb4L4dLyhnAkG7I7iNRwTYvO0r1JQtpOzwregYvE8
	AvIso7GJAY1r6IrL7jWm1K4Ehb7wck0DpecT9SoQYIvbcdLP+GKaP04odZUQZga+
	WzCAJRcHXMxGYLj4nCk12m+O3xy1Sygn4nw4EvCr3p7665b5Gq5hUUpLRMa1f6nC
	sHsH471d6f/ryRhwX+oVPl/YDyN+K5zR2reaP8CpdQDxYdJFeHg96pSpqRHDocMZ
	33OTQaY0Xq2XaF+3sCzOxTpCSPJePqdJ8eOTfAv8s0S0TcF+VtlRRHLnU3dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790977089; x=1791063489; bh=HkWbsJ8eQ/ubDaGOR6VXQpx1dNhdNPBfoQN
	e2yDx+/w=; b=vc/TCDAhs253zIcWioy6HCOJO3MhXTWJ9dZ5jmE5EVZcBvrhLWx
	ccXg7mEwdlnXJ+R6s9hMCjMJ6VnDIQRRYsZo/6Xm8opGkp7blGCwcrcoWxhzHnAT
	q8BK8lZrjvbQshMUDYXmrHY0S48nIh+7ECamWCbIyB9/rlwhijb5DaaX6xWll0Yp
	36XcfPKPoIS3btNyqoCKTSfQkxy4hmwIADHZlhvT5OziQT3muvbszmaKFZLCPA5/
	+daVfoYfoTTNOHYFpmEIZ9JOCXBViUzTnfg5hqK7csTUCAf58yAlZmhSnIzh2rrk
	gLiFhjpYezASurPeL2QCurBKF1SwD5+7hyQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790977089; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:pTS6p4VEVc1tHeIVmGOAzCsRVglCxCGnJE1Yjuw8MGSJP16
	2FN/ObvlNRPAn4Olm4NgF4/cpqBWN6p30rQc2kD/zH5yCR4FJEWwSGUDgnkZ5C5C
	x5HgCuzFFOb4DNP61yADRJbAdUycKCP0qTdn2RAZoOM5Z9oGZz+O//i39HL79LfC
	C1cpCfiDvrO7918qoQJsAUfjskHuRvFU/oNowXYhkyPHB1AGWY23o4NIBrse8aUW
	4zs674lmYFxEHnz13udpxGacSAg6zKOqz49TyDetbdEO3wNr8DaBS/iyf/r5Vu5U
	2rDppP5eLNitRfdHtEdUeNO9dfWq6M4lZZ9efnA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:ZswPnlZOA8himQICaIkf5XwkJUCUdK9g3HZiIKd7dsM=:KlOkvm2JHsmDLCEMbGM3Vm/udVE5S54pKxwBcbVbIMw=;
X-ME-Sender: <xms:QCTAar5K6o7BGhqYm9yjPiY38gtjsU07ifuAsCU4nAZCHtuOFML8WQ>
    <xme:QCTAaknIgftbh_moiJQaBmsmcLn2pXRpHq2gR5MmcF9TFycEY8RX3TL2SiITrlGuB
    PGH0NZzOQqAqLO8UwVsF962JRx9WP91tnDnIjj4YH9hOTfCu0_QpQc>
X-ME-Received: <xmr:QCTAasQ3Q-pJEa3neNRhM9fmHsi0I_au7KEVg6tdkxaYrvb-06dKtuhIHqqPl48LOFkxQfaVZSogFZZArOTyK1pxpOEyRcRakY6d>
X-ME-Proxy-Cause: dmFkZTFShg3Ob+KM16/H0yiLggyKWSev1xcOtQmd9ba2zkgHwOi+dmpFFVAJHZZJ94zlX+
    FNLVCeNtlDWIDl4lC+Iam8FIW6fk0Sv5ra58Z7eiFYhWfMtMGvNMjBxnVi7pbi13hIYl4r
    w7mdELw5QmzSsysYJBRVzvvL7nDYdnvhONxbYMBRZt4sx0rMZkaH0PhA4j++8lhJldQ14F
    hCXcA1FakcpUhVjB46jmyFIsCgDiTjBLnWg4DI6msW+F+0QZl2Ggk5XLq766zaNkmv4rSG
    RKSgfahCRgghYJ/w+EWhd818A7H5xWlaNkjTMn1NBClMRt5v9rNDhjtRsZUS+ofLT9O4pZ
    l9hH9pDoRII0vPzuHhYJQr47LGUB6haDbqA1m4SAAso9NV8I45+AZDmH2kyYgKG9N/aA1s
    BMYaN+JffiDckyyolGvYhzWqK5qmqSqCBmRaSjzuk7QsydbiUytuBkLhcE3tO3U1CZnqu7
    rNx6h+WezDjbMt3+VhlkK4SC1SBALYO2QlEaKD5Njst5hZqoL4QzjJDQgHAJeniTJ3zD+5
    /SqDFinsIUT5MtKUpUEbKrnR9yMrCGpaCytbKgxZCLszYHj4pI4YSs94x9EXBQrsv79xtj
    OMbd9QQI1MkoOUscmZAdHNOtavHCro/GBEkD9p57hcKo+II7CgnMhaUqAEPw
X-ME-Proxy: <xmx:QCTAajFGVmdG0ftPZtOUqfjf1YtJfXjoNsJO6RHPoSJuhOzuJc4mFA>
    <xmx:QCTAahG4bRyM5MKIijQUkfmBH8X_200Uy_pwarL9Soni88iLHcVQrQ>
    <xmx:QCTAahTE8qpYYP7T4IWL8dNDo2ABTBD89nKvFSKcPM-04sXXKwSU1w>
    <xmx:QCTAaiLr_w0W45WOB1E1xMvw2BwYU9ZGoFIlt4dnT2f44B8lfsaigA>
    <xmx:QSTAane71jkJox7gT-DIOu84GisVk47st-nuQy9XXvS81lbMy35ixxX5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Oct 2026 17:38:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans" <julia@jvns.ca>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,  "Julia Evans"
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  "Patrick Steinhardt"
 <ps@pks.im>
Subject: Re: [PATCH 2/7] [doc] git-merge: link to new merge conflicts guide
In-Reply-To: <7861e492-6fa4-4768-afdd-65cd346b85be@app.fastmail.com> (Julia
	Evans's message of "Fri, 02 Oct 2026 14:53:19 -0400")
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
	<a1686a2d82ef9357ecff07c1247092d3dd5ecf95.1790261062.git.gitgitgadget@gmail.com>
	<CALnO6CDdoqE2hyZMJg6OZkzNtcnjNXRz=HO4q6cZVpF_wbTXyw@mail.gmail.com>
	<2f71028f-d58e-400f-a02e-7a25c032d889@app.fastmail.com>
	<4e579181-e93a-4746-8c2d-b127cb0e053d@app.fastmail.com>
	<xmqqh5j4vvor.fsf@gitster.g>
	<7861e492-6fa4-4768-afdd-65cd346b85be@app.fastmail.com>
Date: Fri, 02 Oct 2026 14:38:07 -0700
Message-ID: <xmqqjynzvl4w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans" <julia@jvns.ca> writes:

>>  - "cannot guess" would be more direct than "will not try to guess".
>
> The way I think about it as a user is that Git takes an intentionally conservative
> approach and I appreciate the conservatism. Compared to a more aggressive
> syntax-aware merge system like `mergiraf` which has done merges I don't
> agree with.

Your disagreement with their result suggests that they guessed when
they could not do so reliably.  I agree that our approach is more
conservative, but we can call it being more honest.

;-).

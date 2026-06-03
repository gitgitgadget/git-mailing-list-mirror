Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD7D22424C
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 06:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780469710; cv=none; b=i4gsoWmSRzxJodkzdTXkuMMHye1qB9O9ww64D5ZylXGW3Be+g/zdpMlZX6mqNwUAlEnAK8wdaC5VjIgn9U1AhEF9XokgxxSy7s3y8leo58zQCEqr3tmYJUbyZVqYM2yzdesq3JCb4r3t3fOaP0exfDRQaqIIPHfPMBLVtxwWlts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780469710; c=relaxed/simple;
	bh=XV/lkF4ZsRKwdVPU/QNK556gJWxjbNA1VhMedvLJF0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OtgfcRIX2NXXPZFMqnUBgptshe/sPG/vsz9VjYuX0jQsW6B4fj9ll7w+ltpFReLx1//5RkakUi1mS3eI8aIqwG8/Xhm2UC/MfeVwHJuIsTrVdIVumen4dA458m6D4oVl82sGRJaLeKQrgohR7OVCQF3/iac0npB5iZhm6NOCd0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=btfr5NBx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AOWmORYC; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="btfr5NBx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AOWmORYC"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id DE7EA1D0010A;
	Wed,  3 Jun 2026 02:55:08 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 03 Jun 2026 02:55:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1780469708; x=1780556108; bh=VsyPUKU8u+
	MegO3S7SmATYajk+VoSUlPmtu3eOfYcjI=; b=btfr5NBx6blXHnP7bkk8s0N92N
	99Ak4rfE/+CjIbGJn9Hfzck3rn/HrkKcGI4bx3lBqLbqkmtXnJHOuKFBTvK/E7Fh
	k28DdneNyQakdhkHNgacYK4UTzMbxuDi05cj0JhwlNr2iMx2zeTXbtboM1L9EXbc
	693NMs4Tt9KIcCV1oJ7UddH874P+lqa4l/Nebs9H7lqaqUKjeginI9cdNjtZmlEQ
	H6NneAefCoVXJwtNGCTXBRxC3hLOqJ4zt0K6gS2ilOWnrnZipIYySbKkZ5EY02uZ
	7rIQe2BtXV5Cyie3QGnbCZ07CwQdDazDZeV55n40xvQM/g2KyuAmBR7llSnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780469708; x=1780556108; bh=VsyPUKU8u+MegO3S7SmATYajk+VoSUlPmtu
	3eOfYcjI=; b=AOWmORYCbPTbhm8jPDzaba9fzZAFT3GS2lOb/DMb6dRwYhvVNc/
	UQRDYdZ2taQXLO1W7eN1zpzKu/E9bSIk9i8mCqIFC+U3m2mgoq8ke+U++/vCfZY0
	P15jRlt95auF42Q7cTg5oFmCJIeFNXXOKe97v8GklwM6Go8q8gMlkI8Z6cXRQYjc
	LG8R9db/XoOqAreBTPpKOciPUpqlT3HO3YWebK/uK6bqmPICIkKaDAanxj227LPI
	uqMiG1r/qoWXVvglDR6gvgDZDOXkF2/v5K58fLBzUwqnCgsab5ibBJBF/WkY49Zj
	g5w6nMw5mI6f9m7XFmCwSnQyODOd10EkDIA==
X-ME-Sender: <xms:zM8famd5ty9FTo19-cg44ttcqQpq7p0Fhywu6dBLTJI-N2O5dz2Nag>
    <xme:zM8fanP7U8iMeZrJwLnD1Bztlqjs7oMAVBg7d_Wdpr06F-OSF40u4znKo5dnEkodg
    V__qW79ZiGHWKSV9GaM186z9c4AlorXfxQ4A_tpCZt4PxgPmScv>
X-ME-Received: <xmr:zM8fashvmbUyB5QgY59ihGCOiEtxWKAkEUdOGv24yYrxjgUHi72pcNi3DJOUXimkAGO85YNQ-hoB1W_gYKeAuOuqG8XjL9Mb6vwQ6E9iCXxl>
X-ME-Proxy-Cause: dmFkZTGcpigh/uNOhM7tiwbNS/U6CLwQ18pZVYfOi4JKZRwWAgo0yynhr/0zbbh0nSgUMJ
    gsBICm2psKxEQ4fkNca9QXuZ3a/zON5JXSDyYmSOChILjDNOdFxv/hve6+sCO83uVihX2e
    CMuHjAndDXeuBWudYKmDLBB4fqfMy+ojPZPvLTDftcxUVgPQlndYGeCohDrp/0HWI9scXU
    YrxOLtP4E74IgwIJ7BpfbYjdWrWFRx5x0Bs3BjwqN8Gdc8SMe0jLJWCN2lXugZRdE5WZCp
    yhxBtt1XzGLDbqp7w1XS3KNnAQuJK4OwP9K/VGINM/N8lBvbYI/ASztqhGYzetMA7f5jhN
    cQrHGsrX72P4jEjirhXhzz0cate5gnaeoGridI4MreQpAL/WvKAYxxF6+vxCfAQRl+9RNP
    PnjWkJips0wIpDdcgWyy9EzdOJ/dRs65lhNoCAYjVWBD5w+Tsv13Crr8K95bb9WiIdt130
    XMMk4FzKgizIh8zlGhzo4wfT3i3vlFq5pPb5h6m9b8DX+Ttvr+KYjlcwNDucztk/qIHUVh
    7l0J4T5LLVAkFHxoKKNhYN1s0ifKXgdRJkPv1sb5h7ppLiZgxPxoeMxgtjcq1egS5ZcBR8
    wy6lJMpqGOjvovFk8LC4O9UWo3t0QJDk3NXzTgm1i8oYVbLxCkBOFNPgpfNA
X-ME-Proxy: <xmx:zM8fai1WQoJErfjTJAgYDlHJzXLrv42NSqN_gAY7BjI7NolyoKeWtg>
    <xmx:zM8fauhUaDScDLc06zJWUReQIbq0OtZAZj8UJ4vtPL53hIMGruioXw>
    <xmx:zM8faqfkKtHcVXwhKnZKn8-i16Wwh1DjhZohtoRIYSOuTb-fDx9POA>
    <xmx:zM8fapl4kLwe6nl87Q5z4yereWuNpXBawvKDfu0IuLSIwy6hvOEPvA>
    <xmx:zM8faqw0gX5UbBk511bhRm-7OUh82zdIjyEhQzDetpbJOVxf-xQvLNsg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jun 2026 02:55:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9b198350 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 3 Jun 2026 06:55:07 +0000 (UTC)
Date: Wed, 3 Jun 2026 08:55:04 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Weijie Yuan <wy@wyuan.org>
Cc: Tuomas Ahola <taahol@utu.fi>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] b4: introduce configuration for the Git project
Message-ID: <ah_PyDwO1Sffr5yq@pks.im>
References: <20260602-pks-b4-v1-0-a7ae5a49e9cf@pks.im>
 <20260602-pks-b4-v1-1-a7ae5a49e9cf@pks.im>
 <20260602170955.Z4b7y%taahol@utu.fi>
 <ah-Nhr2PboWUq6eU@wyuan.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah-Nhr2PboWUq6eU@wyuan.org>

On Wed, Jun 03, 2026 at 10:12:22AM +0800, Weijie Yuan wrote:
> On Tue, Jun 02, 2026 at 08:09:55PM +0300, Tuomas Ahola wrote:
> > Huh?  Doesn't MyFirstContribution speak *against* shallow threading?
> >
> > 	        [...]  make sure to replace it with the correct Message-ID for your
> > 	**previous cover letter** - that is, if you're sending v2, use the Message-ID
> > 	from v1; if you're sending v3, use the Message-ID from v2.
> 
> I don't get it. Doesn't shallow threading means every following patches
> are replying to the cover letter? Replying to the previous one is
> --chain-reply-to, if I'm not mistaken.

Shallow threading basically means that all patches are sent as a
response to the current cover letter, and the current cover letter is
always attached to the cover letter of the _first_ version.

So this quote is definitely at odds with the configuration I have
proposed. It's actually quite surprising to me that we recommend deep
threading -- I personally find it extremely hard to navigate as the
nesting eventually gets way too deep.

You know -- I'll include a patch that changes the wording there to also
use shallow nesting, mostly to kick off a discussion and arrive at a
decision there.

Thanks!

Patrick

Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D2436215B
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 17:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792085132; cv=none; b=P6YLhpxRcljhmTsW1OEWI58QO7LfHncEwy5z7degMrBVBSFppKoyq0QJkeEYIThSiJfLtzvqJ5qV1R5Cgoj3fn9sClfghfOUa6Z0hqgbTO5wEgyFvo7bRfi7EfLxuSDyLyp/rs2eP8UdUwnkeZAwCPPxcbgr7Xw+a06rc5ddRyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792085132; c=relaxed/simple;
	bh=DPYZ2wYDJeecldeMoP1tYCSK5YQ9C5bNapUlIclZUUg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CAdEAKFaKrpRz82KjMmTfjPsB6nzagcCi344cxF+15/FQ5NGChvK/zGVEmel002qofW8vTX8OeN+sDSoXLRcnL4Je/KDLXo/Qljy5IcF/EuUuv+h011reDmnkHXhX2gZA2Sd/RVvyF/ArJRjc8UBUPe4Qk4dsFsik4A+Nw7QK6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fIIRbQBD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UX5T6VQj; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fIIRbQBD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UX5T6VQj"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 3903F1D000DE
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 13:25:23 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 15 Oct 2026 13:25:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792085122; x=1792171522; bh=2lA23n7asu
	OiIfLeF2O0YtuSFDgIgCopEKlhjcpMnhI=; b=fIIRbQBDjRG70CbOPa8knQeQBI
	x87i+Zt4TuwTUVM5rEmgW4nK4rpdww3j/nqBpHPH5gOUbdFtY2eztEM+a9EeliWe
	hVnQhpbpfrq4U74Zq8CrSP7CwcYYfAI5qVPz2gAvLW9gLb//3On+eqAtUHf/0WFU
	0l7PAPgZC133fB1jS578p3AMqXXRpM4XksbAFynN53bjJjsk6smD2C8Xkd3bPcEh
	UYElERTtU/ini2T6z8fkm7UKj9IpbJvSyF8NRkICZ2ZlbGAwSwn+c+zo6/f+uwsL
	Z5zm+EFCglJPNjvY/tE8Uc9a8CAFliXNNj/rBWo4joIF7Q9cXcQnoNlNgfDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792085122; x=1792171522; bh=2lA23n7asuOiIfLeF2O0YtuSFDgIgCopEKl
	hjcpMnhI=; b=UX5T6VQj+BRwG/Gfb4rjRysJbOd6/ckmTwebpeh1vwKvdn1AWX/
	d3GEJTANUVBoY30F03W8Yk+kjHNIUhbFsnnxfMOqHv91pASFqzRPU+GWms9FnAVI
	MtVoDghlZgALQTXBYupXjAzAXDb4AsD7o//rVRxGOmFfsjfPYHOAl+47+/yjaP64
	KBZbiQOysG3XJT6kJYE05A2sDBkfKxPT9AVTk/K8L6ZH50IJMTAqpvYJVALNyTMp
	bQM54uzceNd0uPOW0u9nyfiSygDxcCi50PdaqOJy71BMzAfTlhFlgrZSaFU0dp5K
	yrG64jIkvaEYZ1Q1pryxn2eKwfhzUiaWZWA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792085122; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:IvxiK+z8rab7h/krymYfmQRuVOpvjyd+77xc6CWfTgUJ4Pd
	n5S9hKhbtq9nacY2A1jAzsoBTVqlFPNqWwjvNm1WuuxmE9Va6F1pTv/sMQVRIvTt
	GmQ8zfl1atlCBMWrmY8qJ+G3lIedMZotqAk0TPxckCTTbxoXQUJX2DQR/6+QeD5q
	sxQzFUmJ8v36i3Wyh7Q5RLs32zk9KRIohHgkG1yh+Q18dgyM18K9vslRV8I3wr1h
	MPA71KXnyV695nLqWxu7qBEYcMDkvchXuow3bv/EaVDftIcJxcEwYvC94pSoF8Fs
	UtorRulVAehpDTmM6PMxX0e1uRFDPffultjadEQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:cLvXML1+/gB23LynQgiqBGv+MhlSoJc9bAlo7vj5jPY=:DPYZ2wYDJeecldeMoP1tYCSK5YQ9C5bNapUlIclZUUg=;
X-ME-Sender: <xms:ggzRaoACQflk5sF5T14NYyFgBfIab88w_QpGaXVQhODw9q_HWN_NrA>
    <xme:ggzRauNRXs7UVV4UJnKPrV_UP6zSXRLpeHZwDL2rCdyOFWSOSbi36LypZSWjdRSnu
    B2BpC0Wo4YDb-9KBrYwkoBGkaR1NQue0iG80yXgQiBR2HA-Nf0KMsk>
X-ME-Received: <xmr:ggzRalYqwjvz-ubSWyGsePIr9sjPtktv7US8URRDDN6G9abqNi-A9hu6WCJ_xpgZDoG0SQ4007maK2AAEHCboDOCZqWGb0GhRZYC>
X-ME-Proxy-Cause: dmFkZTEWvWGm874kbUz/48c4v2C51ItbchpgkU4mEYtG3x7DyPhIWx1dgpQTEvcTFxgvr3
    muTeC1USVRCfBLGx5ctOGJGe9kQSzym7BEKbPk3vaYo7ygdlBFxWUmo2L2jI3FYFUcgBcv
    pJ/JS4msPSF0vAmPUmgvyyGNoGfCGb0833Dd1ZentpArogwArRi+6KdRMYseucU7rXMvmZ
    HZyUfo3unJnCUHNRLUNVIyrh98Oca/tOSIYp9aacA4PSIp25zg7BZOizDpjIN/CBrftNxt
    PcHNeDPQ9X0Nj0ShAQbCwEyY1AN4kVktg2lnl0MTiesUQUxrve3GGWaJ4+Wpdo79o5xRSB
    7Nnd6pPsjxffmyxsxI8IJV2BjDCTi5LQdniNqTBi4FP27lfUigSd5fJBaj0gIeoa5DPq24
    MOv+Miou0QzL1t7chpLoxdJvJrM9Cu/2mK4QuFKk2cyjl9ZE6b6rgKb1LvKTu1zTGItZBY
    3cNvGGGqYkVPt+BxXzDdd7QfEQxEiHBvfPVhu2A31fXX2ZOQt/awomGRlUXtockelv8AB3
    ZAB6tquDuHwpAph4Uu0J6+gz1Ka/WWdDsjuhzppO88S23AJzssaeP+7v433+U6lNcskJ6I
    wix3P0whyUOB7M363HjELCQcJXARkLtW/JMYQiLziZ+FVlc2DYc9iP1OGvSw
X-ME-Proxy: <xmx:ggzRalu66mK9fe9GAgE8MhtPo-rujqdXvDeJoqw1nUmzZqRLiBcKgg>
    <xmx:ggzRavPpuB1-lA3RgVtGUnUR8_aXIKQ3TBXlbn-78kl9HXrI-DiybA>
    <xmx:ggzRak4NIL9P9eMDRGLFDINEck1k8rEkNP33oRTI5y-_Ji1l2kFExQ>
    <xmx:ggzRatQ0iiI1RLoxuZ-dEGjyWXATHdvEzBulrNnqKxDYeM68Eb2J6Q>
    <xmx:ggzRatrpMAISFs1-VW5S9oNn0S1dN1ajg1g8hu6SmrVSlTXPRZKbp4Vn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 13:25:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Igor Wiedler <iwiedler@gitlab.com>,  git@vger.kernel.org,  ps@pks.im,
  jltobler@gmail.com
Subject: Re: [PATCH v2 2/2] odb: ignore refs of shallow and grafted alternates
In-Reply-To: <20261015065754.GB1979109@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 15 Oct 2026 02:57:54 -0400")
References: <20261014103507.35317-1-iwiedler@gitlab.com>
	<20261014181134.56220-3-iwiedler@gitlab.com>
	<20261015065754.GB1979109@coredump.intra.peff.net>
Date: Thu, 15 Oct 2026 10:25:20 -0700
Message-ID: <xmqqqzhqoozj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> The thread has been talking about check_connected(), but the same
> problem applies to advertising alternates for transfer. But your fix
> here takes care of both, because it works at the lowest level. Good.

;-)

> This is a direct test of --alternate-refs, which is probably reasonable
> and the simplest way of doing it. I think you could also construct a
> case where a fetch or push causes the recipient repo to be corrupted (it
> claimed to have object X because of the alternate, so the other side
> didn't send it, but since _we're_ not shallow, now fsck, etc, fails).
> But I don't think there's a particular need to construct that full case
> for the tests.

Yeah, thanks for thinking it through thoroughly.  I appreciate it
very much.


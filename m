Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864694908DF
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 17:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788285515; cv=none; b=KFnyj37O7CBFANNCjDe+ri/GjuTkb8hMNUKGsTsHLiPO1rIFCjmQT1aSMI7Cz8cWNpXgQ6b5cuTWF/FeEDkcfJGkLp0r2/ax9BRJ0FG2j3PXQwqwED2aQkPuHPtqw5jAJoH/WephmRemC0cu0aXh/dxspVPwqTBsje2uBOT6JH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788285515; c=relaxed/simple;
	bh=UrTbVs7quP873qVqo0O5Z7c9AVAyCGTvkDrC19GruDc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=L+wnSnqx66CupXIRBIqr0KcXDujMqFzjLPk3WMMJxonBi5MSW9rTLoh5ZZhWT/obfQLf2w+rdWiRvqWZGU6BiyE/zz1/WWWI9MjYQICFVXHZjGjQGLhesGZ2SkBeaB4i1cRMm6hX9F7OGHgMpX1BINp8MW6zx1lgoeprFP2tWyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iIWock+p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fnjDXTEe; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iIWock+p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fnjDXTEe"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id BE31E1D0011D;
	Tue,  1 Sep 2026 13:58:33 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 01 Sep 2026 13:58:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1788285513; x=1788371913; bh=UrTbVs7quP
	873qVqo0O5Z7c9AVAyCGTvkDrC19GruDc=; b=iIWock+p+YhgKDNUooyunNoVPm
	S56YR8Ukh1K5TrOxDAJwva1dh1D1zI3MaQ1dMLZCs5Ht1cq6jRRAzZ58IsMaNjx8
	IPRSNVQq3jHCmcgKAU7a0+etSdskUBWxJgLhIqLcI9AqAhBq4NqtKzzN53NIm9G/
	2bje+uqJRipwaNotmr0SqJZ2RZAAWMcSVQcH728n4icjMpAZ38bhC8Wvzwv3ylLu
	kpVOsDwEq/7y5mn+mgzfszDG66VW9hN5HsswDzcNz9GYV+FsoCsiqELm5/mbC8Ub
	Ndnrc0CbAIf+E7uDXNs5UHSrAm6A4SAhO5+ZVkqg2+yEsjD/FKsYnjMVLRZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1788285513; x=1788371913; bh=UrTbVs7quP873qVqo0O5Z7c9AVAyCGTvkDr
	C19GruDc=; b=fnjDXTEegQS3hFHjkkZ+ZG2GVbZ+y/Q/mJjDfKHYNapKgTKtBOv
	slfobx05eVHrUNye9YBxeXo2ajOIwB4sXpy5jsj+p1mhWB5mWeLNk0gp4fE6cexU
	Vz53/JpE3U9zXLjBGKI2pl4inz4QHt8JxcnN6LjsAA8c64sULs6s9wUFxlYzGbkt
	Y1RjtNZHQ3fa2EY+9yRK07VqMXurc5ufhs0eJO05RtX2y3PRnSeJor+qkKkN5zD7
	IK7Vvi0MsB/uJkbp1ICcs1jJNgH6tTEx5W60Mu5YNPNrj/3mGwufVAN579ij3E+N
	rRsOVVKJRRu/PTPoFUppijDEt+LtMWe/SNQ==
X-ME-Sender: <xms:SRKXahLclXjlGsoryi--nsJ32TmfXIYxhBbiBXN9i_htLm2RwQphgA>
    <xme:SRKXakKgTdtSzwJ6DhqBER-et1WiMIw3XshSsiTJMRgGlYPrxVPBE4OoBepM-LS3Z
    GffcCyljk7ftebW6Qw5YGUtvf00KgA2KkWNTTvdP9RLEo3Hgi1Jv1g>
X-ME-Received: <xmr:SRKXauuVyoSIxWG-c_UJvrYGnIqOIz1E_-EfwA27KVNKL67z5-krYwXmohLa66knBq6j4OwDoITxkesStbZ_onzcaEa-8CPVVw>
X-ME-Proxy-Cause: dmFkZTErv5dvhJXTyV5x89TWKWVok8tp8ijzPGoWrvChRZ5xTbHYR7iceHSB5pQb/3zuxx
    U/8h+k8bAlf5VQu8ZnHMoHerOdb/ZEtNfT8qszjIYkT1EPLmiLiPi4TKVS/3/pHy87Y8LR
    H1swD/mpV8kAGfTH/sle0dKLyJ5lBRM2263dzHq58eB7BFiNRu734Zf/NVb1rgeE08nd7F
    UOCdUO2fQGv29XUCHGpuVcQc6BUtE1+qcjuLCneA+dzWyTCU6Wpc+3S3olQIZjnc9FH9XH
    vkm39ewJjGX+5cPUfH+Kq+6fTVO2DM9kmK+D2IEIRDi46L0Uqk/uVVo7CdIsgi8X/shOaG
    SeTjwmUMv3hxWT27uqv/afgmZ/LsJGSTw4lG/rozAMHL26O+cg2nuAhwzoTLoykDDdPucV
    cxYLAl6vSUrHa70DxW+kTCRF4nvm4MfIztlgr5WeWOdbePMx92OYTOnJKc6i1a/SQM27Tk
    FXoob5udTRGD+bjGnzJcYw0THWtpsKg2sIsrPbu3gywRvnB8hwAs0y1VzSnz4QCOqUpfdg
    xIRRPxfUWcpq8xrL36nP9P2yrwLWqAgqg4FgRY25wLGd65ZUqbW6WgweL6Ux2tPaY807iL
    2wjmBmAkSmb8oP1QbkXtb+clA6j60f+UkNh72H42j4GFdBgBF5PIeleJgjYw
X-ME-Proxy: <xmx:SRKXahQFt2QIczpgCPOKaNNcfbG4QtNlgwqY2eICPexj46ffLg8d5Q>
    <xmx:SRKXakNXLgSRQ7fG72ZpdPD8ns9TW_VnGvrrlYJZSEk4C9ZddUereQ>
    <xmx:SRKXamane0SVScrazXP15_gsosX2S2dVE02IrkqJAJaEHWmngi6aLQ>
    <xmx:SRKXauz9_o5LHhT4Jcc5RhVPRRDFZ2Pp5vrq5r8_fpDet3eCku2qCQ>
    <xmx:SRKXahosxU_-_ULVBFuOJZR-xmrPHKtwRPGGEj6BR6lTo0in5TiNI1LR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Sep 2026 13:58:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH] ci: fix missing Ruby dependency in "documentation" job
In-Reply-To: <20260901084737.GA2973751@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 1 Sep 2026 04:47:37 -0400")
References: <20260901-b4-pks-ci-fix-documentation-job-v1-1-a8257ee2a9a4@pks.im>
	<20260901084737.GA2973751@coredump.intra.peff.net>
Date: Tue, 01 Sep 2026 10:58:32 -0700
Message-ID: <xmqqcxuwsvjr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> But these days I'd guess everybody is using v2.0.x (which seems to work
> fine) for local builds. We probably ought to do the same in CI. If we
> have to catch issues in one, I'd rather it be the one people are likely
> to actually use.
>
> It's possible that we could benefit from building with both in order to
> support the older version. But given its age I doubt it's worth it. We
> can still take bug fixes if somebody finds a problem, but we don't
> necessarily need to spend cycles building every commit with 1.5.8.

Yup, thanks for a dose of sanity.

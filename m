Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E813CB2D5
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 19:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791487219; cv=none; b=EfuFMDwcxw6p6FxUXLaw04HPcqMlL1zksBWJSrC/bFGeZ9Hpb8P+GOUmvTl66ag3jAhCDckB7rTBLRTXRBW9VuR6gM9NQr8DiMgEU39QJbPWSGuGNv0tu+anEAax3UZZUHZV11GcEXg/IWUFpFA563wuDypqgNsrFH9cV+Kv4QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791487219; c=relaxed/simple;
	bh=t4keaiLbs/4UcmbgI6BGG0Icq8oFUGcbGwVgBWZbcNQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=skIkSDXADPJFC5gbENRuVtD8Ywp7aACCszb/ePvpkahRKgiFtVquq96la8UfOxmfF6PFGl+ZXaaJZxEwkHFVGT2bpEHSND+mE9oJ6a/pVBvCXAPvSN0C//vLRAmx49HxhJZnqDCGLX5NawtfOfa1tByRzgUw6l7jAHTJ60imrLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=qLd7TIGN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uQyaf0VG; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="qLd7TIGN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uQyaf0VG"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B7A9214001D5
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 15:20:14 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Thu, 08 Oct 2026 15:20:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791487211;
	 x=1791573611; bh=t4keaiLbs/4UcmbgI6BGG0Icq8oFUGcbGwVgBWZbcNQ=; b=
	qLd7TIGNHGKUw71TUykW4lscxsSczq3n/51CzyOrAnldyuPMLvQtYeA9DOdkfvLX
	9615cHgEbeUsnaxrTjQ93FxR+NGU53XkfoGIR8TNJSKsL52Qm7lMuMb7bYhj+4o7
	OPWyP/rXjAJRnIdqYMc1YfYBY03z0EPkiRlH4Tk6VzxZ6+xi/+KCCmsxNul04RRp
	XQszxHX/0XV4ZNwwLI2Ry/9I7tZzTlCwTeWUzeIEwj0dFqomTQvQHJSCegPOaRZ6
	P5vwHvh9dbafBTZglQnB9PkKdk5ra6xr5R0jc8KhOLcp38qVQlWPW7p2pILnvyRU
	CeJhhfdiqdnBu7xAL0mKbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791487211; x=
	1791573611; bh=t4keaiLbs/4UcmbgI6BGG0Icq8oFUGcbGwVgBWZbcNQ=; b=u
	Qyaf0VG5WdWXotKBGRZu6Werp15bsFxlb35t8x91XPFh2LKnEdWgFMzR3fKeX70+
	uQfWieUBo2EJwaV8nQWAZa3aLbN6g6ITiw1x4DZYw+zGgwBQN6K19py6smdXWKNu
	WxPI1F473YXP4vLlf+2jh/fmR9AxhM0O8b0CwQnle9WIs370ZpRKlzk+3nSSUPc5
	Ggel9KpyCNed1+0KUSoLsodQgQfiOf3AOZ3k8FcgzEvt03fCmpHOyEd/1IfNydRC
	GwVinCkytiQXlvLEm5NstTmEW8V7Jwrqv0an3w3xWQHoVzDo/fed2z6Abt4pP0op
	C4nfe6bad7tMx73ZsXXQg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791487211; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:F3MegrWQ7P24qZrpjPhduRs/Ycw9nEer0UFtwO6gEb+uqrc
	Y2+fCbqhZLJecRwtVHdwtetDwitYwqiKFqUEtxmPtn6w7aeX0CYpSmkHK55iFmgJ
	JxRx4Wm0T9OQPug8HCQUyfU0wjl8ndTLRliUgkPiuKk2KDdyQ+URYu4ycefw1uPk
	Dhk0R5gMvk6DUojqFcJt+GQ4vNd3RM4kQ7bS4JvMoIJl6SGL2OoBncYNKPLhS1df
	y/GSPVDnUu8jHAUGbLoyfGj6mmtxQyCcmioU/0gDit39TuISc6Chucj/3t/ziGPe
	U9A7KKcunjQlkmF71noZg6YtyjrKAb5206RaBkA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:u0Iup48a+zfjSEfpaU7GPrUmehGYzYXUAE9jCKHUt0E=:t4keaiLbs/4UcmbgI6BGG0Icq8oFUGcbGwVgBWZbcNQ=;
X-ME-Sender: <xms:6ezHapZLg49twnBOgxkLQd4xNiJnczcWtLv33XcenV7RGs1ACySLzHM>
    <xme:6ezHarPGpq6HofbLn1MyK2EFNKd_Yu7c_7EBftURWT7xuQbCa322qct79fzzxwGtQ
    kWyIEyFIEOhwfkl2InPd0RyGdJNfU9JsI0spEQlcCXkuHYnnJIzlQ>
X-ME-Proxy-Cause: dmFkZTEQBLMxdl4q1a4ev2kqgUFvs9UWizkcCDyPNdikyz0FPObN5BVmGDVmYiy6ys7Dgs
    QbEN4BTYsiF0xwoJfzj4avT+CrNA/rQN2bl11vo4X+1i4ZgJCqXc5+f5/70cExxxzaBXvW
    AUxxVajDAczVM3YKgJ95RG2dmXZGYTCt+ahMb9L47QTLumwbRjne599icaMupgsoT5qpp7
    uWT0syghhWWd/+OLzAvxHnaRqC0kFSKPplBJANnkAUY8Lql3OmE+G5eMpbXp7fk5DYH9w8
    KGFlpaBD06joI5AP0tjh8gJGV9u7a7fM8PHLU7t4f9u79ImyvISqJWqoIvEoteXgrlnwGX
    xw84AIWaJR7608jR9SWX4jQH3wCAXsdsUJ4VNZkV27i/MgRJ6JYktaqeicCoCFubUFzeVt
    QcaQOEYKxR3bnyOgtwCUGVskfNmmQNjjU5+SKXbXxauRdQx2eUMnggHu6dCtmauyb1n9X2
    +uifdlOeRDTyy3a1zDK8sigqzB74q95TIQwZyCyuVSNrtbk6aPEvtL+qylhREZxEDKRvVV
    dFwMHbiMiJ/f2YG8TSeAid0zNmoW7uZaYFsaXvLZXYQx54wDKvlKzAMg0r6QW/tDNvbqRX
    6nfuICQIOh4WdwNZ6EqoehcRpbOXUAIqhi2jBha3REOa0h+nFZjOJVQjD5dQ
X-ME-Proxy: <xmx:6-zHatcTpXyxs1GmhyxxZxg5-uMq1_F2wg6LX2JblOwVL6eXJyHEWQ>
    <xmx:6-zHasvG8aOusSi70SMU0-kwEiZiZhK_-ND3ap8BEqPSyih_7C8miA>
    <xmx:6-zHamnDxYjuiVsVF8tvwe_0iHv3ciz4KYQjhuQgZw43HwucF-ELZg>
    <xmx:6-zHamzjjCBNhy05UDVdvHGS7r8NWMAxwcyl_YtB8g3cWSklqG-z5A>
    <xmx:6-zHahwIf3FlKSZPZXRjKjMFRpqbX8Te79EjPSADn_7K2TEYyXC3BIX1>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id BF15322C009E; Thu,  8 Oct 2026 15:20:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A0qHOqaLSuBZ
Date: Thu, 08 Oct 2026 21:19:49 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Maciej Ciemborowicz" <maciej.ciemborowicz@gmail.com>,
 "Junio C Hamano" <gitster@pobox.com>
Cc: "Patrick Steinhardt" <ps@pks.im>, git@vger.kernel.org,
 "Karthik Nayak" <karthik.188@gmail.com>
Message-Id: <e64d1300-6c37-4ae4-9377-77dd16f3cf19@app.fastmail.com>
In-Reply-To: 
 <CACQ=SRHRp4vKpV5JagAXS1n4iX-LJ7fm78OwMGB5fke2CTC4FQ@mail.gmail.com>
References: <20260920165037.88524-1-maciej.ciemborowicz@gmail.com>
 <cover.1791452597.git.maciej.ciemborowicz@gmail.com>
 <asdsIjNEUOpaAnX5@pks.im>
 <CACQ=SRGtpYLCcAaJz+yUR564wTm8wsMy1qn7hZ_iJfDTc_KTeQ@mail.gmail.com>
 <CACQ=SRGOdtUvxDEBeXz93nrC01oRaTALx6EztyBEfuCtnmTk-Q@mail.gmail.com>
 <xmqqqzi02o22.fsf@gitster.g>
 <CACQ=SRHRp4vKpV5JagAXS1n4iX-LJ7fm78OwMGB5fke2CTC4FQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] refs: run copy and rename through transactions
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 8, 2026, at 21:06, Maciej Ciemborowicz wrote:
>[snip]
> And the only thing I can do to feel that I'm being honest about it is
> to be transparent and explain exactly what my workflow for developing
> this patch looks like.

Augment option #1 with stating upfront that one is using a coding agents
and to what degree. That=E2=80=99s full transparancy and people can then=
 choose
to engage or not.

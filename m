Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFB3302753
	for <git@vger.kernel.org>; Sun, 30 Aug 2026 22:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788130702; cv=none; b=oBDLMHl81otnWRC23KjiMIVZE9Kz1teN26paYurnv5ob0zdXztKDzJ8rimVWXCiOhnkEOXIdC/2BEtSOBnyxLqiDh7WrBbkHI03EzJEOiGmaveWUNz2yHnDSSnqUFJuJrpagtO3HGAIrpbOVQaw3Dmca9A0izZc116P5Ema5oTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788130702; c=relaxed/simple;
	bh=uh12N9XVf/slepGbAot7L5YaEXqLPlEttjl49T0gm4Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IQOlGfdoiNHa4sVHOsLOpzVdNAT23B9c6ttd7fl9vBKVij5dL8Z6EwTt9X+AdEN4JDa+IaHLOorcT8v5jtQdobFAvr+UDrjjeu6e9DidZmBp2iDXQzGlcwgwIH7IDY1CSeQeiZThaRgNA+aeYsJ6x5Aejsewwq+eyCxEOA0Si6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fGxliteJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HbvL8QgK; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fGxliteJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HbvL8QgK"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 7FBD5EC0125;
	Sun, 30 Aug 2026 18:58:20 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Sun, 30 Aug 2026 18:58:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1788130700; x=1788217100; bh=SStq5occ/v
	kDHb4yrBRquQzB1R8eGUvos0aNt16Esgw=; b=fGxliteJdWJ8ck8Oe9ZEqKthhy
	oTo1Rjic9nwcRpiDPiPfivzl4UrMJExX5x3DwFOuGwtqOa/JJCeJdtbwo/xqXlfM
	p5hft7PzmTsPiucgNSwu4usCV+7K+uxGMPKPibOT/aX7m0CJ9HVIv2tAICqjW5gN
	iLTQsR9VnPjeldn2GWpafjrg3jKxW65Og/rHLtma0iahVeoufq/X3C4c9qi/fRn/
	V/XtQYXEOV1UqXn0SrrFz2w3QuHZ9chZUSjdg0GdaVKtFP5c9GF4FvBGMRmCeH9a
	0yaKgKkBZpAYb8BZEq/xMcQULf/UD5KsOcF5hyfGL0REpRmlWOXjQfhA+NkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1788130700; x=1788217100; bh=SStq5occ/vkDHb4yrBRquQzB1R8eGUvos0a
	Nt16Esgw=; b=HbvL8QgKHrax4F+jqlQOH2IrCHcQ24cSXhKldj0zvmH+KXd3xT9
	iDrq9wyjK2rEmUrZBBorDg0mUAfwjmOs5qoCajGgh0GMJrwgzCsMRboTpzPJQhrp
	jWdfL3mrTBgrjtyD0pqle0kFrcl9ijDez7rsKfRp56y2A4bimLB1Qg57zeOXr7MG
	LXAq01L5U8p1qvoT0dSK7e/DYLRNXxW3IT9IAkA3lRA/p2Gp4M1wOv+ZviM40Lma
	hhjMP+lUYowtGgxBTU7h7ZfWJswQaQ4L8xfvazr6S+tfCqkksffJjPOrwRFsZnKy
	XQB02F8CAjoXYtsPA1N+enlSVlsu7QNn54A==
X-ME-Sender: <xms:jLWUaquDq2S19xAXuWr7itv7UJJcbOUgR2uxB4no04Sp1qMLJVTZWA>
    <xme:jLWUajLzZ5h_BSWmqtRtSyz2YcciJwUU74sHsKOF9UPVJD8aBdYmrWerD-NbraHyS
    K3iKB47W4kVM0Qxg_RdpX1ALrngYYM0O5xpDwHKVfeV4qTtcZIX>
X-ME-Received: <xmr:jLWUavnSnB-dZ1L-pfLLaOBrxsUeu2_wC1714_gJz_KGKY-r2yu8byHr1vrGKKCsVdJcyzIsOf8LlA7F7qSC6xZGImctoyalTg>
X-ME-Proxy-Cause: dmFkZTGT0xCS1SbGyK+VCQOJU1doz2VvSVGeM5gXAzLUj0l1zWMbCVRJN+VzW6IFflCaI3
    Q7N761pyGbvAhOqsLEZQ2B0opGAtapSGr5WAmqGD4dnzw7A3XR9mikcO3TpC/bNjvMa+PK
    SolprxUKrke9CJBNeQ3ixROVJ38oIJ69BkrNPZsNYWpTlp2ciLa/i6KR96LaytuLXOm51m
    Baq0L0UCJYN1JuHsTgiuJDUX63wJkhtN/s4u37NxwXP1R+E0fnOgFJ+7WEaobxe2cPcFit
    hN9NMti7wDEDNiiU0p61AoxLcS2ztOH8HIofY1QK3IG2yL4H66ibsZnOEyi6jK056Hg7j6
    aFPguoPngg3p6VuMMcBAHE2z6ve0aFauXyzX88vc9f1q26+Xpsbb2ZDfWM4qGXlbZf30Xv
    Y/8hVYDvbbQAZmTEJWaZFjCK7pIUgnz1/ZAmDvfWX7WHlChaNzjVv5MuOYE4sbYZVR3sWr
    17yaRKBsDYkjQeqjoDaGbj1cYlQrXYh/s7gR35McpAQ5Bs/gx3awYzi4oJbXG8o9AFxFRu
    L4WhDAi9JFRzdB6/2HDUotAIGalvzsBuXt/zUOSy6zmnmW6NJX3xyG83LPY2bHfpZh7kcw
    +z5wyfvjMLOb3RXSgegauIDO7k3D8Ap9qbB9YqskFA4WCHsGJZ6AwtoNNknw
X-ME-Proxy: <xmx:jLWUasL5yqozbSs8-AlkEn359bmgFJ12NxIDBfO8vxsWpXcRnxAAEw>
    <xmx:jLWUas5yHvYn1y1fl0M9O47pyPrTs7ZNXSU5TK3DTLUKlSkH3Xr-Hw>
    <xmx:jLWUao0UNC_DZjJB3oiwWBrswpWirtAwiav7VhZF1F-6h0k1O7eIeg>
    <xmx:jLWUaqfkpykG14uqk5CRy3yp-kPK13leyjRJtNJwrx1PR8hL8ikNRQ>
    <xmx:jLWUauR2FdVScgmA2-D0SueLXC6TIQYA2f33mfSEg3j8pvDtrRRaKQDP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 30 Aug 2026 18:58:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Diogo Castro <dc@diogocastro.com>
Cc: Diogo Castro via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Thomas Haller <thaller@redhat.com>,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH] dir: fix negative pathspecs in 'git ls-files' and 'git
 add'
In-Reply-To: <CAJw8QBPbxangB90DceDXxaDmyz8fn5jbEUihhe2faJrZ3o7BeQ@mail.gmail.com>
	(Diogo Castro's message of "Sun, 30 Aug 2026 15:57:27 +0100")
References: <pull.2391.git.git.1787949348110.gitgitgadget@gmail.com>
	<xmqqwlta2agt.fsf@gitster.g>
	<CAJw8QBPbxangB90DceDXxaDmyz8fn5jbEUihhe2faJrZ3o7BeQ@mail.gmail.com>
Date: Sun, 30 Aug 2026 15:58:18 -0700
Message-ID: <xmqqmru3z051.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Diogo Castro <dc@diogocastro.com> writes:

> I don't think so.
>
> As far as I can tell, the "strip the common prefix" feature is a
> performance optimization aimed at avoiding walking the working
> directory needlessly.
> So for `git add -- a/b/c a/b/d`, there's no need to look anywhere
> other than in `a/b/`.
>
> But extending the "strip the common prefix" to negative pathspecs
> could end up negating the benefits we get from this perf optimization.
> E.g. in `git add -- a/b/c a/b/d ':!*.md'`, there is no prefix common
> to *all* pathspecs, so we'd revert to walking the entire working
> directory, even though `a/b/` would still suffice.

I was wondering more about case like this:

    $ git add -- a/b/c a/b/d ':!a/b/x

I agree that it is nonsense to compute the common prefix over only
positive ones, and then to strip the common prefix from both
positive and negative ones, and it needs to be corrected.

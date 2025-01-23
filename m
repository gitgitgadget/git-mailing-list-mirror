Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A983413D882
	for <git@vger.kernel.org>; Thu, 23 Jan 2025 17:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737654954; cv=none; b=ZomT8yiejCBcFTZG2FExDnMg9hQxt8xmrKFRi77v3T2WEI5LeIgJGTi65FAoF7e2rN804aO0cxNE51WZS9wYxQBO4+RU7LWg3f+gXsVHeBkdlJreSSZaqF1SiNGJeFLfxo1V1/xLOYa5PmyG5H+xZdHE5y64EJUy01MYXdwsljM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737654954; c=relaxed/simple;
	bh=gKnZPDQfRuCKlL6xLsB8aBnNheyvsOLGJZqEzfVQJ/8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u3PxKsMfRIvRnFSK061vAUpzyVpFDCDkTRxFbSLpNDWqst3o58KCXLmQuC8hxlRyfVzzhikKjFEpV/wLVhlBg3AADd4eDhPZ1E/h/7xS1DAg7cS681HLGEmLEPV26XheN5Tjsl6Hp+kSmyByH6VODdNeP+R1jleiC3RhKN7D9sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CDGmUZWM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vqCqVD7n; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CDGmUZWM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vqCqVD7n"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9A92D11401C3;
	Thu, 23 Jan 2025 12:55:51 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 23 Jan 2025 12:55:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737654951; x=1737741351; bh=KHC0NLuBCV
	ngOciSoPTKsBC2qOIWFalLMqmezo35wJc=; b=CDGmUZWMZVy+l0jLsIdZXn0Yvv
	+HcU1NVffflSGF3ODk0CrLqoJz3jbf12SOC/s4GLXLNJh2Bz8qzkhgrbnDvYwD4/
	CuI4OZFK1lJQKh9CX6IMmx23/3uEy1MT8iQfADquNEDgVieV2tm/M5pa3HFkrYp0
	KGeUGhWiXpryGd7VAg0gn5i9j6c0a3ZEcNrB7hwbc3FhzsDJ2MYWgdBbRry9hQcM
	VOE+Wy2HyCi5/jZ5LOz9qTpS6fWL2y6EpBtt6dRTPpwFLhrTVcsgfzv5mxsSxRIQ
	6URBSCQSRB3TfluWG5ur3cKBZwpeayF8AI+vB/ACQhG64t95lm81BgC4Hn4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737654951; x=1737741351; bh=KHC0NLuBCVngOciSoPTKsBC2qOIWFalLMqm
	ezo35wJc=; b=vqCqVD7nT9+F5ZeplCyZZz13SYAkXNre5wAsrb5gxNEUM15HfRX
	NzQVJMLlg2RXeZ770ghobx59O8cnjO0Usla1MPqjRcn7dEkdh0d+7QkBsKdqZfDS
	WeItZ/GOrHxvKSB8c6ZMilZYN9k/OA2tJM/FUl78OZSmKUKI23P7aa9XfnU3z2KO
	PGOSkZjJwo1RssYEFpGclcvEW1xISH0e8/58U+DRrKfZJ1eAnSZFAD/MbsmGFr3Y
	Kip7jnaX+S2wyxiEiER/17la4ZovWDmCNj/3T0EqOn2aq9QI+BS9ZZCs2yTpbcn7
	/BfmDpPM/hSzNTW6DP7U2ZOUNvIJMInzDWQ==
X-ME-Sender: <xms:p4KSZ1FW-x0bzw9PKWh8nkXUoACY29cvSKwuaELEbzNjPf7Zy5nMcg>
    <xme:p4KSZ6WiMqx0NOLTpeOj2vJnCikp0A_E6drwUdkpCtdHfZ8tktAKRmpbR9env6sGs
    TGDU2WapFfXR9unjA>
X-ME-Received: <xmr:p4KSZ3LWK81-iVOyuh45fw2vcds6n0ormN6DtwdRwwLTUe8Jm_rWRFhSFjdj1M7XApyk_8d4xyjjNzsx25TJ38kNLwnOKUt0qMXf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgvdefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrd
    dukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehnihhkrgesthhhvghlrgihiigvlhhlshdrtghomhdprh
    gtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepphhssehpkhhsrdhi
    mhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:p4KSZ7EmUJDtP1AWkxVc8QzFHJiePwDTmsoDTYam_uI677qzYJvr-g>
    <xmx:p4KSZ7VDU9pOy5sTK3ZGVHMLaAbHMsXH7PrgvWXSHL__EboBfIeJQw>
    <xmx:p4KSZ2MOC6aufsCE9LtROgHQqOhbqdUYIx6SfGOg_sGAHAqsULxtAw>
    <xmx:p4KSZ62jgzGJBjERcdcQdzYCvcWu1e2MuL5IpdR779d_TtduJL-eyA>
    <xmx:p4KSZ9LxnrvNSz3h2YPpift4YPa-AtqOT0BE9evT_NTETJf6jhGEf2ph>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Jan 2025 12:55:50 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  nika@thelayzells.com,  peff@peff.net,  ps@pks.im
Subject: Re: [PATCH v2] refs: fix creation of corrupted reflogs for symrefs
In-Reply-To: <20250123112944.3922712-1-karthik.188@gmail.com> (Karthik Nayak's
	message of "Thu, 23 Jan 2025 12:29:44 +0100")
References: <20250122100319.2280647-1-karthik.188@gmail.com>
	<20250123112944.3922712-1-karthik.188@gmail.com>
Date: Thu, 23 Jan 2025 09:55:49 -0800
Message-ID: <xmqqv7u5s9cq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> Subject: Re: [PATCH v2] refs: fix creation of corrupted reflogs for symrefs

This may be just me, but every time I see the above title, it read
to me as if we are on purpose doing "creation of corrupted reflogs
for symrefs", but we are failing to do so for some reason, and this
commit is about improving the situation so that we can correctly
create corrupted reflog entries for symbolic ref updates.

And because the only sensible reason why we may on purpose do
"creation of corrupted reflogs" I can think of is perhaps we prepare
such corrupted thing to test how robust the production code is when
seeing such corrupted data, I would expect to see a change to t/
hierarchy.

But the patch touches the code, not just tests, which makes me
doubly puzzled.

It happens every time I see this title and the change.  Perhaps drop
"corrupted" from the title?

> The commit 297c09eabb (refs: allow multiple reflog entries for the same
> refname, 2024-12-16) added logic for reflogs to exit early in
> `lock_ref_for_update()` after obtaining the required lock. This was

I do not think the actor, who "exits early", is not "reflogs".
Should we have "for reflogs" in the above, or perhaps move it to the
end of the sentence (i.e. the required lock gets obtained because we
want to do some operation "for reflogs")?

> added as a performance optimization as it was assumed that no further
> processing was required for reflog-only updates. However this was
> incorrect since for a symref's reflog entry, the update needs to be
> populated with the old_oid value. This is done right after the early
> exit.

"The early exit skipped this required work"?

> This caused a bug in Git 2.48 in the files backend where target
> references of symrefs being updated would create a corrupted reflog
> entry for the symref since the old_oid is not populated. Undo the skip
> in logic to fix this issue and also add a test to ensure that such an
> issue doesn't arise in the future.

OK.

> The early exit was added as a performance optimization for reflog-only
> updates, and it wasn't essential to the original changes. As such,
> reverting it shouldn't cause any further issues.

I am not sure if this is even worth saying, as you already said that
the early return was done incorrectly assuming that the remainder of
the function can be skipped as an optimization.  What may help
readers is to state that all the rest of the code path that was
skipped by a mistaken optimization is necessary and would not do
anything unwanted.

> Reported-by: Nika Layzell <nika@thelayzells.com>
> Co-authored-by: Jeff King <peff@peff.net>
> Signed-off-by: Jeff King <peff@peff.net>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>

> diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
> index e2316f1dd4..29045aad43 100755
> --- a/t/t1400-update-ref.sh
> +++ b/t/t1400-update-ref.sh
> @@ -2068,4 +2068,13 @@ do
>  
>  done
>  
> +test_expect_success 'update-ref should also create reflog for HEAD' '
> +	test_commit to-rewind &&
> +	git rev-parse HEAD >expect &&
> +	head=$(git symbolic-ref HEAD) &&
> +	git update-ref --create-reflog "$head" HEAD~ &&
> +	git rev-parse HEAD@{1} >actual &&
> +	test_cmp expect actual
> +'

Nice.  We could rename "head" to something more meaningful (like
"current branch") but I can live with the above version.  It is much
nicer than assuming on what branch we would be, which was what the
previous iteration did.

Thanks.

Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDEE245025
	for <git@vger.kernel.org>; Thu, 13 Feb 2025 18:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739469982; cv=none; b=acpsJp00gG6Asx51WOoqzDRr2DVgkkn/7+pdEIBLGVimjhzKNMj0UY40gfQX4hGIwUTnXRh863S5KxkmLCXMOQwlbP/b+nM6ysSOPeSqBaDecYPJF0iRK2Per5HQx1FlHnNMMKWykzrrLQdvFD/fNXFTXH7R/K2r7AMeeqGsgSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739469982; c=relaxed/simple;
	bh=Xxj5lvSbmIlXiEgPMfs/rzCvkEE9LNpLh9H6Yp5qdpQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=svbu3VfYxxkqlug99Oc6FXixngbkwjo6ulJexHXdQMoNFGvOYHiTANA39n7Gs4HfSDkp/8o5QrroG9roQEhhKIAD20mbpzf2a6/8geXk6Bs4IMoH7TF0C7/1u6bix2uXhdU09rw7Zm/ARcMYFVcZRGL0boXl4A7JQG7yAaKxODE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CejZ27XF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Jfk+Fml4; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CejZ27XF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jfk+Fml4"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 34AF8114017B;
	Thu, 13 Feb 2025 13:06:19 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 13 Feb 2025 13:06:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739469979; x=1739556379; bh=DPcnHNCxYB
	1QZ+UtJGhNlhOVXdO2r31TjUX2HEB0cjM=; b=CejZ27XFAhQgkiVSm0zDKFxJLZ
	07Xc62OFoDgLdqVzCNUJXPPUwBUZ7gTWiFb/RzDsKaeKlHV6jK4sHSZOhjSrCqio
	cCioSHKUCamOBbMYfk6T452eHIf6nwflF3SM/lm9pVt9K50jM4SXTMtfRQxwhacl
	sx6jtMs4h48OpFpQA3JyKUnQ2xJo5XEtZEp/1z0j+syDfE1tZEEI5zgP+4br2uw/
	bgnT9PQz0uTfkgirPfPuNdJ7gWJdPFaejTTqW7GoNWyyXf7EheQfZIwbX12OabAE
	cY2eV1ttbREV6af8pnfEILPJV0ZIYtLnzybc1vfgWRXVhK4DmYHSAX+s3F8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739469979; x=1739556379; bh=DPcnHNCxYB1QZ+UtJGhNlhOVXdO2r31TjUX
	2HEB0cjM=; b=Jfk+Fml4VbwkMG23aactaixrZ1518iEipbOz+jXekqUkmjQ55u4
	84gbpRBSrBY1EiVraWZCKEp8ohZg8UlXW3D8JgLPnFnXp5nY6ga5Sgm473GkkYNb
	fZWMyq3kgnIT1w/a9I2FqgtyQabNfB8hk/asxapkEbUrajyx3nIlM0lc/Id/tQrz
	TMPrbS1ywW33HXPW3jDqIxU5JfrQq2pq+z35oFu+VsA8LYsXC0C3Apft+X9WmID7
	orVcDaq1Dpe5pwz8At0V17cx9nElaJQMU/v8jVfl01fBrFiCWB3XpitDOxfieykY
	XBzKBHXDxQs7zHWrLJlZIWWAiSBqEM352Iw==
X-ME-Sender: <xms:mjSuZ_C25XbizgakkrVjnbs-zYERH5O_ymu60bEIcjKS8lzYD8HA1w>
    <xme:mjSuZ1igYA8VbwbtGvvj8rTXShLLxk3DzdhAHaA7nlKTRo0fCiB4flXpAvsTNT7ar
    rJCgsGpZ2ubwktBbA>
X-ME-Received: <xmr:mjSuZ6mts3TxtzkhDj0cF6iHdU218Ig-rP64fP2ByVhqqhw2_3IVG601patM-Hx4LbEov5jCvVD791C3U1y3xFeWHHUg6QXReRJyAAo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegjeeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrd
    dukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepjhhlthhosg
    hlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:mjSuZxwzNgkQgDcKvYbfx9mcmKa_ibRFvou-FnQQh9webGmS7Uiy0Q>
    <xmx:mjSuZ0SvEkDia9BVRG1TX_CV62VIVKsQHSq3nFwk0LmCtv2yizbfkg>
    <xmx:mjSuZ0ZUAh2jX84X0xfGWqdALWPAPocWTwX96INMpXgp__CkffqRTw>
    <xmx:mjSuZ1RX2kiaGaCvlc3YK3Pb-Xvet8hsIJsEzweLtWk95zgS1hcOEA>
    <xmx:mzSuZ5L5nRRrr1A2no1hYFa4Zjm217aH1MPEHl9hZcO1RyE3loWtSTRP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Feb 2025 13:06:18 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  jltobler@gmail.com
Subject: Re: [PATCH v3] builtin/refs: add '--skip-reflog' flag to bypass
 reflog migration
In-Reply-To: <CAOLa=ZSDLNLYQ=zsoOqJW6KhcUqeDahNfhG-n9k1t0O6B40OnA@mail.gmail.com>
	(Karthik Nayak's message of "Thu, 13 Feb 2025 09:22:40 +0000")
References: <20250211-477-refs-migrate-add-a-flag-to-ignore-reflogs-during-migration-v2-1-991a2ec9a796@gmail.com>
	<20250212-477-refs-migrate-add-a-flag-to-ignore-reflogs-during-migration-v3-1-98b2c4d2bb0c@gmail.com>
	<xmqqa5aqu7g9.fsf@gitster.g>
	<CAOLa=ZSDLNLYQ=zsoOqJW6KhcUqeDahNfhG-n9k1t0O6B40OnA@mail.gmail.com>
Date: Thu, 13 Feb 2025 10:06:17 -0800
Message-ID: <xmqq4j0xpvmu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> To just get rid of reflogs from a repository, I think 'git reflog drop'
> or something similar would indeed be a better way to go about it. As you
> stated, with this patch, we could still face the issue wherein the
> administartor could re-enable reflog and we're back to square one.

Exactly.

> Why I think this patch is important, is because while there could be
> existing reflogs in a repository, if one doesn't care about _reflogs_
> there could be significant performance gains while migrating repos from
> one backend to the other, while also leaving the reflogs behind.

Sure.  It could be done with a combination of "git reflog drop &&
git refs migrate" (or "git refs migrate && git reflog drop", if the
migrated-to backend performs better when it drops reflogs).

With "git refs migrate --skip-reflog" alone, we are very limited.
We can lose reflogs _only_ when we are migrating.

Doing it _during_ migration may very well be more efficient than
dropping first and then migrate (or the other way around), so I do
not have much against the "migrate --skip-reflog" existing.  But I
find it backwards to add it first _before_ we have a tool that is
more generally applicable to wider situations, i.e., "reflog drop".

IOW, it feels as if we are worried about icing on the cake long
before we actually bake the cake.

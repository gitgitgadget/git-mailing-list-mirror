Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3343B6ADD
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 01:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758850069; cv=none; b=NmhD4IWNGU4RRc77yePH//1d/pYI9z6SAqu0DfvSRSgVEYl3UOxkrg5dVvL3YGc1uCQFEr7clkUPzHwnPNX0C9LIfT35yOof++yFVBKvssjDPuqMnE9RHNyi+zFfw3USUVU+ZgbEcW4p8rxkiQOsvBkv1HbS7Y/nzXmqOX7r88M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758850069; c=relaxed/simple;
	bh=U9H8KdKHLaNcx6a/kexmwxZ+/i69tDWnf67qLQuzcWs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pSfsZJcp2D/IPjGZZW83wiJno/62o+Khj3NnhOnOoXul5ELJbHw/NfIGMPkZHknMByii1Do6N5G2kXGfjR0ptrWLpxrr3F5lacR/AwKkXOdCE65Szb69eV28/sabScjC42KghD62BIpt6JExRr4Z2HqrUCsd2z+tbxM9CZmaOmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=tpl/kERV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bkOdoLyJ; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="tpl/kERV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bkOdoLyJ"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 248197A00B0;
	Thu, 25 Sep 2025 21:27:46 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Thu, 25 Sep 2025 21:27:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758850065; x=1758936465; bh=aIIIXUN6K7
	5So2wAzJqkPgo81ONt49LFsn/fK2EYAqA=; b=tpl/kERVedTBXsW7vNnqNnDWg2
	N/opzeMmyylYHSKQoUclFdSANbdhq/AtA97Dh9IDdyeB9tWiGopu5/vCdzOkMHbC
	87fZGCJMjHhmA0wA+J99Ve1h6AQz0MIPzlIKJ8mhUjN/8Rp+vIsCjEU07JS5GSoK
	6LS5b/HxyHAlG+iUHui2ZUSzat3Bo/V45DQ60o4UOAni4M/ognrkUKl3TRmBCgfG
	qVmgiG2tIFFj5cplRjxf5steF+dDAaS6KsX6ViSxad4b0QNg8tCCXsh62N7MP8UT
	tlk76m+Y0PAOmGF4HA1dspQFmojKonvPEpDnQjPLFA2hb95hmJu2lqrzb3AQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758850065; x=1758936465; bh=aIIIXUN6K75So2wAzJqkPgo81ONt49LFsn/
	fK2EYAqA=; b=bkOdoLyJXvPhWJZWzLWX/8I6yhwHC5S3KE1y767AUsMvNZgop6a
	LlStzqZYr7MCqhb848cosGvFhhCEFu+W6g3ENCowBZAsfEBWZF6nQ0NvbyTzkvdB
	/a44vvQEscE+84eC1rRWfpKbHXUrwLioEJYLfmiNzAxrN1of7FKEjJOQ62374Hw3
	Elxfe14GFTMFypTPnDZKk0ulnydpdwWikUzD59TtYoiIPRP3JU5PWxg6J3/6hHSZ
	Kzd5ZNH0BE1K0kSsybR/sSmrxObiJBdBgkeS9cX1b1TlsFssGOkmPNTdCisJsTT1
	rCEZ+gTiG6wLhjYr6JwvOKJRcELfyTd2HzA==
X-ME-Sender: <xms:EezVaGWRp108hG6WD-utawYVUf6TMon3y652VA0ZoL-fHw8W6BYyAg>
    <xme:EezVaGTnhgNYCqhVp_TZIXHvKUCTHDeh4SXEsSfjwRK7T9Ux7s3KzuPocmNpp3rcr
    Ob9g5gVUGoAy9f0ITUrJ7rWdWQb2ylV_0oMTE8AWK0eie0tixKE>
X-ME-Received: <xmr:EezVaEO4RwW25BzprJFVs3RjrW2fvyRJVjL36nvci-PQFspED30KxaXjwAXIGmhce5HmbE8IVVqBKie41CebGmxC7B42UqKDnYY->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeikedtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjuhhlihgrsehjvhhnshdrtggrpdhrtghpthhtohepgh
    hithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrg
    hilhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehf
    rghsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:EezVaEQWx4oqykg0xdidbRoYFNkduTExnfZYhpyIlVYMyOQxo65D_A>
    <xmx:EezVaChi69nwtJUs0kWiqGCZjm2s20ffQV2Kf06NXWI6U1sI1kRF5A>
    <xmx:EezVaN_ZeP_KTNldTvU3SkFzFf9raV4FPkOL1MiXPu-Wb4FiCg423A>
    <xmx:EezVaJGUz6N6XlIi4ybZQ2-qMx4JLxHpic9_jF9YbqOW5uuTFcJV9w>
    <xmx:EezVaE5IztZIc5TM2ZsOSHsmiNTwPs2ZbhRYpZLOe2UafNw0MiqcKn0F>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Sep 2025 21:27:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans" <julia@jvns.ca>
Cc: "Julia Evans" <gitgitgadget@gmail.com>,  git@vger.kernel.org,  "D. Ben
 Knoble" <ben.knoble@gmail.com>,  "Kristoffer Haugsbakk"
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v3 4/4] doc: git-push: clarify "what to push"
In-Reply-To: <1422594f-b0a8-4a7a-bf78-940693757224@app.fastmail.com> (Julia
	Evans's message of "Thu, 25 Sep 2025 18:34:07 -0400")
References: <pull.1964.v2.git.1757703309.gitgitgadget@gmail.com>
	<pull.1964.v3.git.1758649472.gitgitgadget@gmail.com>
	<be6453d010bdc9d2b49988d6841dd7e7f9bdf1f8.1758649472.git.gitgitgadget@gmail.com>
	<xmqqqzvvk4bj.fsf@gitster.g>
	<2365a7b9-3d22-4406-876d-65822822655f@app.fastmail.com>
	<xmqqzfaidyil.fsf@gitster.g>
	<1422594f-b0a8-4a7a-bf78-940693757224@app.fastmail.com>
Date: Thu, 25 Sep 2025 18:27:43 -0700
Message-ID: <xmqq348admuo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans" <julia@jvns.ca> writes:

> As I understand it, with push.default=simple, the reason you need to set
> the upstream is not to tell Git what branch to update (since Git will not
> even let you set the upstream to a branch with a different name), but
> instead it's more of a safety check to prevent you from accidentally
> pushing a branch that you didn't mean to. Is that wrong?

Your understanding is correct, but when push.default=simple
castrates "git push", and you are on branch 'foo', it is dubious to
argue that "git push" _knows_ it will be pushed to 'foo' at origin.

It is very much conditional---what Git is being told is that the
push would be made there only if branch.foo.{remote,merge} were set
up to push these.  If the setting is not there, then Git does not
know where to push to.

I agree with you that setting these configurations is *not* about
letting Git know.  It is about lifting that conditional that
prevents Git from knowing where to push to.

> But I'm not sure it's true in this case: we just said above that
> "The default is `push.default=simple`, which will push to a branch with
> the same name as the current branch."

So I think this simplified statement is what causes confusion.  It
says push.default=simple will push to such and such place, but that
is not true.  push.default=simple only means that no settings that
points a branch with different name as your upstream is accepted.
And configured upstream is what determines what branch at what
remote is updated with a push.

You can tell the same story about push.default=upstream; configured
upstream is what determines what branch at what remote is updated in
this case, too, and it won't push out if you do not have your
upstream configured.


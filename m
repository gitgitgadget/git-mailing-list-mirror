Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C535534BA20
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 19:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759777429; cv=none; b=lxeBRGe2R+UCqwXuFvp4vc9CZ85swodPvJ+GYCd9qzA1+vAc7nMKcQgFPZq2sdW0D27ObJIqVTubkdBEmtlRAJontMURk6AP2EWTpChiYcKQkGSzC4e69vbmUCMFuRh1ZN+RvRsL+BG7OfU7pNuivR+gk+wFch82ELWVh67kNnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759777429; c=relaxed/simple;
	bh=jPvKu7OPGi3YQXZytQnxXeFA6mo+O/m8LrEJ+keTYz0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=jI+9ZgFtiI6YSO93bKXc2Qw8DkaugK7xlAbrckgODyJ7aNarp/bRFzwJnuAlUY09btMBWGEAcPywp1dr+UcOpJZLaKRfQ4Gx9qn6YHX99dX9ncrDXkOf/dzWCY3bj/INtvec1gX0OaUSnTXhqAMPL1Z6H5LmsxdFynm6Ru/c3dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=bcSmPTBW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TiZsKKFf; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="bcSmPTBW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TiZsKKFf"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id D2A4C1D0016E;
	Mon,  6 Oct 2025 15:03:46 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-04.internal (MEProxy); Mon, 06 Oct 2025 15:03:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759777426;
	 x=1759863826; bh=aACbar4A5/q3LWb6QakAL2L7o+zIm0NDpb5+NLV9WF4=; b=
	bcSmPTBWPh71gIUGTVAajnw8Jf7Qc1Y79sFnlpcrifQVX+9CP5hIkb6vcJUAzCMU
	BjNftjwoRhkChwpz27QGDuqQGAKuM868U44ag4qxBTGSYlK22lAhzL9+WxTOv0vP
	1YXJpGMUba0WzHHcQxtDVJ0UdcF5zRuKAIEI1Vu8Qd+73LiedVky1g2x/UtIhV2Y
	RPy4IaPCRej2HE2H9N0lEWJ0VTTqfvCWnv+aBUSwrxLQEObKWE8p+yDNcLBBGD3v
	0kUOoA3xndDDBiX1LQTv3q5r9idMLNwb1GgNzD1H/XukVsX4AXXQwSv8Yt5ZNvB+
	BV0bKMca3pjff4BZdmutBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759777426; x=
	1759863826; bh=aACbar4A5/q3LWb6QakAL2L7o+zIm0NDpb5+NLV9WF4=; b=T
	iZsKKFffROixikjsl8MULRyJ05yviL7xdVk31x4h5/DSw/chKnGm3Tg+4gWOx/ak
	xgyJmfHb735Vc7EA0F6LdVFGj36Stipf6f9z6ZnLfnU46L/Byj7ZDcFwk3NrBMJy
	9h323l2N5nAHPWCWAqhentke+wZ0a0PBiNJfyBJEDQJAKsDwBbLa/qhU5/zoKjuA
	EUTtMEv/2vh588OO4ndJq/jtEee9ud5l++51jSAYN8Rh5IMTZPTop3So6zgJq4oS
	sUAT4s+6LWGuOFZ/1V0hwkh/9CdQJ2DWGYaS+71fmDH2vXFeLJt7Z7c5BciLHbbe
	LEm9DismT27K3+InotiMw==
X-ME-Sender: <xms:khLkaCsN2YgEduFNXAR0LxeBgy8bbB_pRAQDkEZuA89SqupkYBpvJQ>
    <xme:khLkaCQRco8WgRWgVmS_lSpk0bSn2euewYSiIUAJcy1Jt5ii63ocY02liCTPsnqga
    roqQ2Du5IAchO1fI4TxNdFNeruNa0gV6mwrmJ3qBxtkMmGJMVwdrSk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdelkeeffecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertd
    ertddtnecuhfhrohhmpedflfhulhhirgcugfhvrghnshdfuceojhhulhhirgesjhhvnhhs
    rdgtrgeqnecuggftrfgrthhtvghrnhepledtudehveeftdduuedtledviedutdeiteettd
    ffieefueekkeffffelgfekfedunecuffhomhgrihhnpehgihhthhhusgdrtghomhdpgeel
    kedrsghuihhlugenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehjuhhlihgrsehjvhhnshdrtggrpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:khLkaOrjpqMXVUvYiL32vMfVSUqemumzVFPibr8-qb8AJB4uk1yPRQ>
    <xmx:khLkaEbKVY-2l6HGL5xT1vTm2U0La1SXvc9HProISb-cr4pzDv9O6Q>
    <xmx:khLkaGR_K7LwW6otJqsR22nNruU6bJp5GL9t7TaWdNBVp5w3wZ4w3w>
    <xmx:khLkaL6WuiMLlI-6-valY4IefvXBLUWzxLcuQMMF4raMrFO8a9NdrA>
    <xmx:khLkaJnQ801saEupA9akYC-XhiWv3V83i4KCKSWZsOq9egfU-RREcQR0>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 64490780054; Mon,  6 Oct 2025 15:03:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AfAzQvnzmZPw
Date: Mon, 06 Oct 2025 15:03:26 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Julia Evans" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
Message-Id: <9d02c334-b5dc-4faa-8bd4-75c344bf5576@app.fastmail.com>
In-Reply-To: <xmqqy0por9g7.fsf@gitster.g>
References: <pull.1981.git.1759512876284.gitgitgadget@gmail.com>
 <xmqqy0por9g7.fsf@gitster.g>
Subject: Re: [PATCH] doc: add a explanation of Git's data model
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> The above causes doc-lint to barf.
>
> https://github.com/git/git/actions/runs/18265502271/job/51999236907#step:4:655
>
> gitdatamodel.adoc:226: has no required 'SYNOPSIS' section!
>     LINT MAN SEC giteveryday.adoc
> make[1]: *** [Makefile:498: 
> .build/lint-docs/man-section-order/gitdatamodel.ok] Error 1
>
>
> You can check locally with "make check-docs" without waiting for my
> integration cycle to push to GitHub CI.


Thanks, will fix.

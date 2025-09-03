Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D8832ED5F
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 17:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756922054; cv=none; b=mxTuwOxW4R/Kz+nLBUxoKebDwrBUmptoPX12jp5pAq0X+/BlZKvJeYnqGt8AuFzjClGtUydOLhwuxr0OQlf2dTImuxmRoR1P4CB/e5zQStl3sa353yrnHL2CrLTvwNkFDC+2VbmxqtlTpDTx9pQRFgq1xAYfGYatn5Yk8A9NL20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756922054; c=relaxed/simple;
	bh=6r9L4xrled7LSxLNkfNziHRGAps5PdZmISk8oLETtHs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=dqPGyI9XQxnsQRAQxY2DlbGawnwOISPDoBGgo1682dYVkqm0lHOONogF8ksblAgbFwXkt3PRQRy5Cn4nJyUAwNe/qGIAk18HsusTJt02CBWqwKYFVZjcThDJUUXhQ6hC7tH5IUvkcmJkpgD6qJ4XApCrE34NLe+Wt/aG3gIPwwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=gGYLBsBC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ml3Mub+Y; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="gGYLBsBC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ml3Mub+Y"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8FC8B140039F;
	Wed,  3 Sep 2025 13:54:11 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Wed, 03 Sep 2025 13:54:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756922051;
	 x=1757008451; bh=UDLk0W1z3Ph5AuqUkCsH6n1c9C2YDc48UTENXKhNao4=; b=
	gGYLBsBC6NobufsaKj6rdpeFi0CovtZOSBXSFoxH+94+7d4syoMRuJbhDWQwojuh
	qke77XJ/RTA1h2i7wTKOAUpu64YsNWivvaQ8RTBQBRbNrpsvZJcPKndzbu8VX8tC
	PXBdxnxA+NpqNUZYNU3ZPyiVa9lBUxFxUw1KsjBNogng2eexOOiArTnLUkUGEz/P
	UYE2ZO805OVc6derPI4cd4STqPo2yLAMcnN0ewoniegklPXuemAgssQyId9WhvVR
	qNJ6mA073I15gvNUSL0IaW4B4XkP69etAbifKsKqp+zzlwDp8+3teq3VBh67N9Fj
	axeS29AtfKEtLW0pOXKL5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756922051; x=
	1757008451; bh=UDLk0W1z3Ph5AuqUkCsH6n1c9C2YDc48UTENXKhNao4=; b=m
	l3Mub+Y1r+owyXr8CluiK+GahIn3GL6pcYUgWR9zSBxtaQU7+LZOiKsuhN3DAEhy
	jrDWluw98BWEWpmAy39Dh434krpYnI9GEohYVg/FYixFTriNJz/gT7OWr/x7fSWt
	m3LI1eUcoSKbz6yqnjNOs/3cBxZYS9LOWZdILc81Ah8coOTqw9R2qdhl7RXdzkPL
	ZehU+25g8An1tBUKNcOEfS8k+nGvQF3zUImxaSVNDII55IAm8gqZ0pS+dhvLDP5a
	N96p6u6ed+y4eL9TcRUNTWPcWH3i09oknWPZ9203vIFr8TRuuy+XW3X9qBelQ/+B
	O1i7GBiw6gau5rmhDppKg==
X-ME-Sender: <xms:w4C4aCT3P7nbztOJC6VOhMB-uQgT-sBh-JoqviRo4omNbjWEvc0mEVI>
    <xme:w4C4aHyubK1xG8Fh66cXnHoeA8gjvA2nKpiFvZRXVZR_6yK1N6NutZExQ6biu8nEc
    WW5YDAMYHNCtwZlsg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfhrihhsthho
    fhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssggrkh
    hksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepgedtjeeiteeghfeu
    tdeutddtiefgvdegteektdeutddugfekleeugfelteffjeffnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhg
    shgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghm
    vgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepsh
    hunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:w4C4aEZ7Pa3U1QH8cUPR0MsPtv8pDMtbC36gzcQsCyLRe0LNFf94KA>
    <xmx:w4C4aI2WtwWCv_lFwdr9SDPONqyTgAgxLHERBbqnlF0POtvB_FOi2g>
    <xmx:w4C4aOgVAL_0Aayuqlvw7i2Vhx66RxxPglqt-tZLgUZmUfKJU7Vbzg>
    <xmx:w4C4aEbXglAbEqsIPS4UxkUbS4RpZgV7rCsOOjUN6OsJJa8VL0b6wA>
    <xmx:w4C4aGSlDHD412ErPDmxSxfXvLJnOpkSMaOVdkpWC0rkYyp0oYIDsKoc>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 381931EA0068; Wed,  3 Sep 2025 13:54:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AMHZM2JIZMZV
Date: Wed, 03 Sep 2025 19:53:32 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Eric Sunshine" <sunshine@sunshineco.com>,
 "Junio C Hamano" <gitster@pobox.com>
Cc: "Kristoffer Haugsbakk" <code@khaugsbakk.name>, git@vger.kernel.org
Message-Id: <15bb8d07-675b-4ccd-8345-ab5861319faf@app.fastmail.com>
In-Reply-To: 
 <CAPig+cSL=-gD5+WomF7-hYjVJ_PH0m+0i8g3F=E_U3k=QNHr8Q@mail.gmail.com>
References: <cover.1756311355.git.code@khaugsbakk.name>
 <e81023edb2d78d2be0ecffc071f2c5316b0c7a32.1756311355.git.code@khaugsbakk.name>
 <9611573e-fb0b-49d5-933a-50d8e0603701@app.fastmail.com>
 <CAPig+cRgBXX+b=P31VjQ6Dd4mciFvaUJ4T1oeOGjk7mwV-9KMw@mail.gmail.com>
 <xmqq349czcl8.fsf@gitster.g>
 <CAPig+cQkVP57n_FE6dJ0uxvai-J7usxKFp8gzfEbPY=Ytsd6=Q@mail.gmail.com>
 <CAPig+cSL=-gD5+WomF7-hYjVJ_PH0m+0i8g3F=E_U3k=QNHr8Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] usage: help the user help themselves
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

(Sent from mobile, might have mistakes)

On Wed, Sep 3, 2025, at 18:50, Eric Sunshine wrote:
> I realize that the changes made by this series are not in any released
> version yet, but from reading the emails still arriving which argue
> for retaining the command for reasons of muscle memory or because of
> its (strong) mnemonic value, I suspect that the hint(s) this series
> adds may not be complete enough. In particular, the advice this series
> adds (use `git log --raw --no-merges`) seems to be primarily aimed at
> scripted use of the command. But the muscle memory and mnemonic
> arguments suggest that advice should be given for interactive use, as
> well, such as proposing that the user can create an alias.

Good point. I would suggest discussing it in the 
breaking changes doc under a new "For Users"
section. I would like to avoid expanding the error
message too much due to the already mentioned
fear of overwhelming folks.

I've seen  "troubleshooting" questions from git users
who got one of those long and well-described Hints
like e.g. detached head and default git init branch
when either the msg already spelled eveything out
or the msg was purely informational.

Cheers

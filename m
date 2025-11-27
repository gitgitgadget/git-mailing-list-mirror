Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F38286A7
	for <git@vger.kernel.org>; Thu, 27 Nov 2025 06:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764225038; cv=none; b=Q4YpYUTE0+70DPG5oXptmaFCNGX+Nv9X3RYT9UNP+r0iVnzBaX6rTNdQIEv52CMwk3F8v7jo3m7m8MgVavu9j9OV5zGNSqfErA82EOr4R+3Ebph3b6ksE641+CvKGeyTgM1uMMVZgq32R/wEXiB18WcjpxqtdK/jesEsplRyhKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764225038; c=relaxed/simple;
	bh=0gdpK7mqoGHrPtdrgYr4lzmWCgTEpXCDTBtcNBZlDcQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=MMMVXAMzrcxJcksD/wyIg++Sv6A4Ki88zUHvtdl2N6EWlE5H7EZ7se7+9ONPtLWGzAqY8utjSxLwlBIi2Nf3ezd4+NE7LWQg4hJ1tyI9tSc5mdnk2BV1R1KlSN9G5CLQNZYEu6srxxdovv+fzZUcuvqBMAwy1MDOGPLhQrMrBmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=dh/DBgpv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IZN49m+3; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="dh/DBgpv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IZN49m+3"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id EFD17EC01CD;
	Thu, 27 Nov 2025 01:30:33 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Thu, 27 Nov 2025 01:30:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1764225033;
	 x=1764311433; bh=0gdpK7mqoGHrPtdrgYr4lzmWCgTEpXCDTBtcNBZlDcQ=; b=
	dh/DBgpvWHCKKOuB+UoMDd4sl23wmrEz7rOpwXAsClVCS7Zu+5VRGCKYaJYjqx9v
	WkRd4pyDM7phmgj5R4+RDItw90ceNIZIAWca7cnDKzk1SGk3DSCfejEbUV1jTXrz
	Cm38+J3sWXMxhPsSwDZ2SUzvojdUPSHM5BooQo0tH+eqgQnOT8U0KTuF7+4Rvbc3
	ofHx8d1hmQohL7I0JBet8Y1gu7HGxuMN+DjsUoWAJe7gh9PveYbtdPqccldHWF2u
	vuJMkIs2+WoGcD8aTaBnrrLGeSwnK55SRsIzVeGT7YtoaQFD98wsNUenIcvMfLQH
	1ahIomfGRzLYt0T/NEdQwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764225033; x=
	1764311433; bh=0gdpK7mqoGHrPtdrgYr4lzmWCgTEpXCDTBtcNBZlDcQ=; b=I
	ZN49m+3aP8grwH7IjqwIdJgxoqRnTsH/M+O51KnOWHH+W4KH7XctMgReScAVUf3l
	Eh//c7dey/ETQvJVkBzeI22P3fKaH5qE+UvmRpl0bZsDPPl8Fkx3M8ogyibvQO43
	dKWo+oLCSpCWgoyZPyjMHnGJlPpYFvCQUz3xjSC3S1kl0RLlb5VKKCtvy/JS79cu
	vOwd1v+y+45Ptozxd9jLJElvyR3WNjvGdJKnaqNgDRko+6B5fYDmkJ7IhDFgLq/q
	95dwLVxbVdrXYSVxTZym5UPXca9CWalp++QF/9Qj34VpmjDMGN4Wlm1gHZU24GcM
	GIvWpHmByd7tpHtB8KsIg==
X-ME-Sender: <xms:CfAnaToXmmzr42v9xeEpBiyQOSFVbj-2XayeOIn08EeG76U5du4d2WE>
    <xme:CfAnaYfTgD_cltmWzo_0pOB4ub12mS8oJeo_FZdb4JmTBpj5WjDTlbbU5cYaqmNJS
    8JkV5Y0Q7tt-wX8nn5x7afyo2A3JdqRKpeFMRZcRKxp1zrQwtJTLw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgeeiheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepgedtjeeiteeg
    hfeutdeutddtiefgvdegteektdeutddugfekleeugfelteffjeffnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeehpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgv
    lhhmrdhorhhgrdhukhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkh
    hksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehjiehtsehkuggsghdrohhrghdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:CfAnaU3ndf8Sd7hngroMmpdoyWdsSfgSjsvpYolWgJ-Htxcyh7XICA>
    <xmx:CfAnaYAD-7eBN6qPnv4rF-nFs6c87RTt9X1eXkmVw53RpqpGTyuv5w>
    <xmx:CfAnaYfFPmvGjo4jbLafT1Jz33uPp1qWdH5XsXdbOvFBu1RaUGoiGA>
    <xmx:CfAnad6lFjFLgfZOoDQeqRE0ZBdrDQFKAjeDgMWSNKMW7mRQA028wg>
    <xmx:CfAnaa5Ou0tQ0T3XkBaRwHasKVlAD3zlJ6C-l0CjelPoF9SWPVgJsvkz>
Feedback-ID: i83a1424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1EA921EA006B; Thu, 27 Nov 2025 01:30:33 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: And9clSpnOi7
Date: Thu, 27 Nov 2025 07:30:03 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Phillip Wood" <phillip.wood@dunelm.org.uk>,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
 git@vger.kernel.org
Cc: "Johannes Sixt" <j6t@kdbg.org>, "Junio C Hamano" <gitster@pobox.com>
Message-Id: <5dfbd78a-6ee9-4949-91b6-905cdbad833f@app.fastmail.com>
In-Reply-To: <061c627f-46a4-4da7-af5e-17fda552e29a@gmail.com>
References: <d17060d9b72.1759952528.git.code@khaugsbakk.name>
 <V2_committer-date-is-author-date.1@msgid.xyz>
 <061c627f-46a4-4da7-af5e-17fda552e29a@gmail.com>
Subject: Re: [PATCH v2] doc: warn against --committer-date-is-author-date
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Nov 26, 2025, at 17:02, Phillip Wood wrote:
> Hi Kristoffer
>
> This looks good, I appreciate the detail in the commit message. Sorry
> I've only just got round to looking at it.

Thanks Johannes, Phillip.

Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDC41A256B
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 19:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737143292; cv=none; b=T8/Ln00HStmVr219Zs7LfzEAPRq7kvCvMTyVcL36k0CwNUNJMrruOA3d0jNnhqeRdWnwFKq5SVojUG9imCGmOSQj7WaK6pVf1dy2to6oRczSsr8MFrVDBuPrGUcFzeDGaJk4m5XW51ctOGCTVWgYbXAIK8uEUaY/zgW8XB+SyQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737143292; c=relaxed/simple;
	bh=JQr4Aujg8kDe9kBwU7k2WzSXpmaqyEKbNRtXPbEidEk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QBwBp76E3s9Ptba0qXnyTIqJkmkIAO3Yp4OMf4AcZ2rWNjfSs2/ePE4TBEbSDDN3TKshRw9IvpOd4R0he8aTAPMoS8ubhXNIsFQMQgQakXzc156qPmLmTaEt2BklwFNzf9tE5IKWhVoaVEo2EqXYOF92+Kfi5MomvXlskJ1sQVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ay2VjsT4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fb4+owc1; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ay2VjsT4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fb4+owc1"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id E3B5B138018B;
	Fri, 17 Jan 2025 14:48:09 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Fri, 17 Jan 2025 14:48:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1737143289; x=1737229689; bh=rpqqeVsYYx
	mjvTKwpY9tpKPc5wNYn4U+U/W/D1p8YWQ=; b=Ay2VjsT4h7LoGoual4qWszQ9AQ
	43kDLVrBtm7TTwDNxVw3n89DTtSvZW9bnPnDV8vDxZffMfrjgMasA/6Z1PUqn0gO
	lx6oeDz90sq7ER40Zf/BZg8eU0jk4FoNT8aeim5z/K54oF6OT/N6nBI0570EHzuo
	/tWLlet5DTxwVNK+N8clV5UieIM587eSDI87upVejd01108LWDvI7bPGr6lHyFA3
	LW1wytdSaz/cb3Nor50hPza59/oXPnzikYemYiZVEOYGVvx3v9slrKsz3zu88zKR
	+mMy8VU2nNTfevgptB58qetLVZ0GMNMlUSPli50rLFU3UsiJ1xhEzi8Phn2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737143289; x=1737229689; bh=rpqqeVsYYxmjvTKwpY9tpKPc5wNYn4U+U/W
	/D1p8YWQ=; b=fb4+owc1UC9JGFHxS0D8cp2NWUf7ChtA6slCmGvF+1VPhwvx/x1
	cQGrV/np3lGWet9yfcQA/BHfZPUjufvzq5S1sdhBvgp57IkPP0ntpx6dgAlu7Zry
	4PrBzsTIGhJj8QsoKBWF84X3ykENulHMobBLDnOCPa3r/6vXDvJGUOcoWQ0pMtle
	DYgBIh2D4KABuIHY2JEsrTNW6mg5+as1Hn5qeoNeg9kGy6vNqXDOvU0GUV/SYzdE
	LGLX8b8sanhJRzvs3sVA0HFm1XMTLjeVy85+IIfJEN8ynLKZCKLzSHH/mXFH6ccX
	BIwcUk2HfNraz2of/cCSul5JiyqKetiVA1g==
X-ME-Sender: <xms:-bOKZ3rRgQY1yixyaq_1LxsGB3HdOJCdwxEvc3wJBp1Q_IgrTfJe5g>
    <xme:-bOKZxrp55fRNDA_b4eQaD4ES9OZ8UimJ5kEq6de9MwEHCF5ntAIpUDZX-LA2ida4
    KlnyZ-ASwWs7fXNbQ>
X-ME-Received: <xmr:-bOKZ0P0g3Ahkjw-29y_Ix3MjTQe2gp2RVk0s6ofAwQ0qfCB8VssTdTAY_Vve7rggREZp1RWHzFk1FAeHiDBHrVFvJhPLH6FTONg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeifedguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuhhsmhgrnhgrkh
    hinhihvghmihdvtddvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrh
    esghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohep
    jhhohhhntggrihekieesghhmrghilhdrtghomhdprhgtphhtthhopehjohhhrghnnhgvsh
    drshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehmvgesthhtrgihlhho
    rhhrrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdroh
    hrghdruhhkpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtgho
    mh
X-ME-Proxy: <xmx:-bOKZ66eSgITcZxwVjDGcsbSHuExbD4cOddNtOxsn_SCAWrjCpfJkQ>
    <xmx:-bOKZ26oAW0R9rkXarPbe2OeS2kPXdrFPWNnQu_aqPaa6Nq7Q_WLqg>
    <xmx:-bOKZygnVhFRK2By2pvkb3CSEXBnH3wRQ3pqr4NSddueVj828xLDvQ>
    <xmx:-bOKZ44tWgT6b9D-iOPIeZzqWQN6cSUzwLNyoQ7hzOiMJ8tqr4ykyQ>
    <xmx:-bOKZ2ytRFq_HT9CpbmqjdFjL91L2DuBeD3FGrceygBAN4QSzGYOgw3q>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jan 2025 14:48:08 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,  ps@pks.im,
  johncai86@gmail.com,  Johannes.Schindelin@gmx.de,  me@ttaylorr.com,
  phillip.wood@dunelm.org.uk,  sunshine@sunshineco.com,
  rsbecker@nexbridge.com,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 1/6] version: refactor redact_non_printables()
In-Reply-To: <xmqqfrlhl2jv.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	17 Jan 2025 10:26:28 -0800")
References: <20250106103713.1452035-1-usmanakinyemi202@gmail.com>
	<20250117104639.65608-1-usmanakinyemi202@gmail.com>
	<20250117104639.65608-2-usmanakinyemi202@gmail.com>
	<xmqqfrlhl2jv.fsf@gitster.g>
Date: Fri, 17 Jan 2025 11:48:07 -0800
Message-ID: <xmqqplkljk7c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> /*
>  * Trim and replace each byte outside ASCII printable
>  * (33 to 127, inclusive) with a dot '.'.
>  */
>
> perhaps?

"127" -> "126"; that is what an inclusive range should say.

Sorry for a noise.

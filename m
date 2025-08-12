Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C2A2F0661
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 22:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755038756; cv=none; b=SrgQ+vzvJKXLD5KMSRp+0170tqamZjkExJFxRiWh/K2SOXkaMrkh1Nfxzp5B1H7/AznBf8w/JFuVF6D0gyXucLw0xTztjDCTcT78t/ZSvCwGIKPIYw/ItWFv0k3gwl5WqqG5tT2NHIfheVA3CGeLGPBMK0sWI8O7+lVXmkrDohc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755038756; c=relaxed/simple;
	bh=hfX5Kg/08JvhEutS2dHiYY/5jjjot026sov3ydYhNLs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=QvL3WFdjVwINJZMiL+MQmy7y/ZNSDUGqu5mYH/y+Al5JzLpcSNaZgf5Gq9O3KQlvbx+I8T6wBHr0M4U41/6O4GsCROVhMubJGwcHjLP+25Q6grTQsqBBCRpJQVL7Li3TYkg8Qm0eb9YDSBMc3LsaaMG6GCkmVcF5A82Ql8v73aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=WyIQquPj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qdw0qHvU; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="WyIQquPj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qdw0qHvU"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 2C706EC00B0;
	Tue, 12 Aug 2025 18:45:53 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-04.internal (MEProxy); Tue, 12 Aug 2025 18:45:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755038753;
	 x=1755125153; bh=PDNG5lngMucWv/jK+VnO+/Kj7usFl2EEqiYTtCydEHU=; b=
	WyIQquPj2GZeimySwLKKmFnLegkV7UxSAI6JbI8d2oyj3aP9sH1deYVsT3zjaFPn
	9JWvJvRFVA+8UyytVzXlB/EtuA7+bvwe15WlxWJz1TsG39DYN/HRyGec/Na/FIZ/
	rWY2CC7wWuR7A4mCvxuJ45UR3+YzMAoLBpKbrPv2DIxcE2WcDS5q8ZJt6UIPlYwN
	vmT3RbouUisMFNtwKIyAt3INY52htXsXoc0WhXyGBOOyWy5ImBxpfldR5KqouZvP
	rerrwKWl53bkEdRNW4bO9oeNSE5vZvrbADXB9LKxHiMJR2ppMIJBE7y2Y3wWVu0M
	YUwFpXZU196WVW6IndVDUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755038753; x=
	1755125153; bh=PDNG5lngMucWv/jK+VnO+/Kj7usFl2EEqiYTtCydEHU=; b=Q
	dw0qHvU89de+zMgrk7Xrcs4PsL8474ZGCnit9NNrmSgqD7WSDaEBK8QJ2/HITKyO
	TTSuwRz/GtCSndyC4h1htMxWRqqxdORarEZdaK4FYET8KCWJcx2FiPLUwKRUEPV+
	vwFkDg7UsSAOQmj+eN3PnLYfnf0TB0D2Ls/0d4WsDGuiVHNYtLU/GjKu9864vaa5
	OxPOQn9QVAk9cmNezAlCOCNmzj0Ub+PuHHjroTA1mouVCu5sS7cAzfaBNRMnSNOI
	jk92OB3lHTGbq686R1hndngEBPH8rzuFj9Vhbs9vqwhTKpA2J9Sd9u00x1RKvA27
	MQrVJeitbSj+NpREhux8Q==
X-ME-Sender: <xms:IMSbaLgKA4Eemc1F1Pv30cslbCXjrlwA1PifNSNe0QWNEDJeMx3mWw>
    <xme:IMSbaID8gmPjIDjadwA0UnJ_RQvcI9mFsesFM4Peg4aMqhR-Eevko6iZWjsiutTxb
    h2vPJy-dh_3vqpOeeg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeeiheejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvvefkjghfufgtgfesthejre
    dtredttdenucfhrhhomhepfdfluhhlihgrucfgvhgrnhhsfdcuoehjuhhlihgrsehjvhhn
    shdrtggrqeenucggtffrrghtthgvrhhnpeelgfevveevtddvheefjeehhfejkeeijedvie
    ekudegveduveevgeeltdehtdfgleenucffohhmrghinhepjhhvnhhsrdgtrgenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjuhhlihgrsehjvh
    hnshdrtggrpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrgh
X-ME-Proxy: <xmx:IMSbaDo8GXx-pzpY_d3v2vLQyRDgUJcipPzVDXXO-17AwMVlqu53QQ>
    <xmx:IMSbaEg8tL7i2faqDUOzJ75g-3UFr5PEOFNCi1qGU3TcGr2_4aCvCw>
    <xmx:IMSbaNLb1y1hu4kj-D4SCzh1ozu8ktCqW71ISyjBlD7tVAYqx4WO1w>
    <xmx:IMSbaEBO0qNnQkVCtdknUv4qIaWCLm6wyO01ODaqAwWnsubLtv9y7g>
    <xmx:IcSbaJqD2Ael3SsziwCyon_W3WgQB9XabqPQducJtxDA9Q1xUC2MBboQ>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CB88F7840B2; Tue, 12 Aug 2025 18:45:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T445d42a894a29bdd
Date: Tue, 12 Aug 2025 18:45:32 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "Julia Evans" <gitgitgadget@gmail.com>, git@vger.kernel.org
Message-Id: <4d922dbf-ad97-42da-be19-905de5bd18de@app.fastmail.com>
In-Reply-To: <xmqqwm78p4uh.fsf@gitster.g>
References: <pull.1952.git.1755029249.gitgitgadget@gmail.com>
 <310d2c1d8f7f68ae52ddd29f0ccb0a0364aba1a2.1755029249.git.gitgitgadget@gmail.com>
 <xmqqbjoks19f.fsf@gitster.g>
 <152d47a3-7744-476a-8ab8-43b7b52b67ea@app.fastmail.com>
 <xmqqwm78p4uh.fsf@gitster.g>
Subject: Re: [PATCH 2/5] doc: git-add: start man page with an example
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> Yes, I have heard that for recent crop of developers especially
> newgrads, Git is the only SCM they've ever touched.  If we can
> assume that the data and mental model of Git is natural for our
> intended audiences, that is great (we can also forget about the
> diff/patch based world view, which comes from how CVS/RCS stored
> their revision data, and assume that the snapshot based world view
> is natural to our readers).

Git is certainly the only version control system I've ever used: I started using
it when I was a new grad 15 years ago. Everything I know about Subversion or CVS
(almost nothing) I know from reading explanations of Git aimed at their users
or from trying to understand the origin of some of Git's terminology choices :)

re whether the snapshot based world view is "natural" or not to Git users: 
I did some very unscientific polls about people's mental models of Git
a while back at https://jvns.ca/blog/2024/03/28/git-poll-results/#commits

That one says that 42% of folks who responded think of commits as "snapshots"
and 50% as "diffs", which feels encouraging to me: after all, the poll doesn't
ask how Git represents commits internally, and many people replied in the
comments to say that they think of commits in both ways depending on the
situation.

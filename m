Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7275827B32C
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 18:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761159304; cv=none; b=EXuNShyTXPccTHzrF/3h7+khXZ0Qgk5X7QcYZVgmjxbiTCj17jBSdbvcliWTMDGIgYelnCTncZRt6Wu/u/rmtzC1jputH8Sn3xEfOIbbKBo74RVr+I5zy8Q+gWU2EjmuvTnsnaXBRFx4cdb+gdSvvBY8cRFvtRqhbEjF2aOtzg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761159304; c=relaxed/simple;
	bh=N+GdwSZOYMsxcGofbjyipcPEzqg8Ad27iKvw7F7w75I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kvTXuU7xI52kqwbSqMHMkKjfLEhAzjjNDRFQs0PVzQniDph5IFzEBcBbACs20QB5e5Lk8e+1RG6aZ6HrAIIhzxrq2gXuDkdo1IiwwRbzV/dKum5z6iFtKNkEa+oXTXwASeRJNNZbSRZnsDyiNBCIVZRDKNLyENJ7ugAzz7rXKU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bCRAo+bP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KHdFxafZ; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bCRAo+bP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KHdFxafZ"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 8AE60EC0201;
	Wed, 22 Oct 2025 14:55:01 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Wed, 22 Oct 2025 14:55:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1761159301;
	 x=1761245701; bh=lcedHc0fquAtPaxCbY5lCgCGb1ws3rYJqRt8T0tp/E8=; b=
	bCRAo+bPbrrgSwUCIfGN1RF4cFCNBXxcGudPe7awLsgmeNvU7EmDfPGib/OS59Jx
	NzmqU5NrKh4qjoPs0GwcVAPJUosCUCfywAFA2KPeIMrkD/JRRi9REUCQBTAgxKtW
	Kjvyx1MVfhEgTPzr7vldU3WxlOVaBzo8yZoKV/3Diq4bJa8xxIBEwv3RAhx/7K/g
	X/c3itxOtq/QHJHFk1a2vFbL75vTIoOL+V4JBmy0NhKrPJuChLy73ELiHM4ZZyop
	yzgc9RSCLp6Zap02iRUgnQ5mdF4JYWE534OHQPqrPUecDMDUL5wLAI6TijT4m52Z
	cLmeH1RMljjvSkicP51HWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761159301; x=
	1761245701; bh=lcedHc0fquAtPaxCbY5lCgCGb1ws3rYJqRt8T0tp/E8=; b=K
	HdFxafZ8xDWsH9GP2nsTVI9G1BsDdbLIXLltHS18N8BLzz7aSGFKlXSDZFwAu2+P
	380eZlpgEAVZa0bgIFWpUcRs6zNZPaRyvVuJ/FcoNrgmN/Eb9GDmMNU2QFhNciDi
	hgXbOdtNBYLWuVZvzN9DAy6h/Wr4g2GT2BWVd1PzUxIxAtPfuctk3gYrHYGCT/9i
	kbUcbB2HTDc+U62TFK29SIf0E6KRACGxrn6KRwP4RwIBcg/w8d3eupKq7wgknbEA
	gG0UC4H/WsqK6bDmHHgnaZr6S2ImieEUlTBYZr8ps7PS1gtzSGDtfZozM8zxMCo7
	JCf6QA6FZrJarnh/0SHvg==
X-ME-Sender: <xms:hSj5aO-4iWyf2pJbCEd9N2wM0QXzFs4dY8j_QOtfTD928HMvcq4xZw>
    <xme:hSj5aFleS8x6qbEivUnWQ36t5Kj5VDso2nKOOE7rHdecPEfQggU0PVMnKQpbuSkBf
    IuKuxGc9d16YrW-a2zH18BCNA-niY-xD7vApzik7o8khUOKZtVhN_g>
X-ME-Received: <xmr:hSj5aMW0-X1n6ImteBRPeyV5NWbztmMQ7oRdw1yMkTQysajYNByiqWh5EDENt3XbiUPjJJhIF61SDhZRniJJXQrKGxjqphIhNjzF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeegfeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkefotddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpeekgfdtuedvjeffgfehueefueeghfdtjefhgfekhffhteeiffetheelhedt
    gfehtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomh
    dprhgtphhtthhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhopehkrhhishhtohhf
    fhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomh
X-ME-Proxy: <xmx:hSj5aCEg-PyuPvhWDPVzGM98ih-YFZmSrEHkL9CkU652syVZNDblWw>
    <xmx:hSj5aAcRBRTnCyRhS5RFORvGhVlkQg_O3DdhcbNEa-JUdgDDnMstLg>
    <xmx:hSj5aLLj5NsSf_qiZoIR1SRU38CUxobYv1fB48bY6vFYO0PYvat-9g>
    <xmx:hSj5aNEmWN8CXhq1Q6Wn2igyIg6yKWaglW6D4s7p9qReGmMcYetdCA>
    <xmx:hSj5aO3nwVn7pabh5fRAnFwOcWh5SGS-0DiQXgilJRvkQ3HBwvSreh9h>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Oct 2025 14:55:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Johannes Sixt <j6t@kdbg.org>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  git@vger.kernel.org
Subject: Re: [rfc] flip rerere.enabled default to be "on" at Git 3.0 boundary?
In-Reply-To: <80220653-7302-4E4D-99E9-1A8CB5B4F23D@gmail.com> (Ben Knoble's
	message of "Wed, 22 Oct 2025 13:45:01 -0400")
References: <bec27479-c53f-472c-87c7-374321108ad5@kdbg.org>
	<80220653-7302-4E4D-99E9-1A8CB5B4F23D@gmail.com>
Date: Wed, 22 Oct 2025 11:54:59 -0700
Message-ID: <xmqqsefaydfg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Ben Knoble <ben.knoble@gmail.com> writes:

>> I think I'm saying that I am mildly opposed to enable rerere by default
>> as long as it has this sharp edge.
>
> Fair points. Could I ask an enterprising reader to summarize the sharp edges of rerere that need polished? It could make an effective todo list to aim for prior to 3.0. Here’s what I recall seeing:
> - messaging is not clear
> - usage for dealing with incorrect caches needs improvement (should be useable without expert intervention)
>     - as a first step, perhaps having rerere and status display more information about possible steps to take (review results, keep or discard) would help?

- delete/modify conflicts are not recorded and replayed due to
  safety concerns [*], but in practice, most of the time it seems
  that the user wishes to re-resolve such a conflict to 'delete' the
  path.

[Footnote]

 * The modification that is safe to discard when resolving the
   conflict to remove the path today may not apply if the
   modification to the path that is deleted is different and may
   require a different resolution other than discarding it.

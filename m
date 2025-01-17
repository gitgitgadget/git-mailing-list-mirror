Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFABB19B5B1
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 18:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737138446; cv=none; b=tZrQI2J0tkjLkGYIaCjyD3u6b/fJM+2I0VHw7SrUXvGxSgAV74zGDySr2BqjtAserlZp6EWNRhNLdi+QFbeJEGuyhorKqaZIQRNcwJZz9k0ht8dla3dOCIobou3PWrYp4IlYVT/FUpVoqGx37Zf/hBTv9JMvp492fP/OxhtFPSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737138446; c=relaxed/simple;
	bh=lneu4wQWfrxZdkVKecaXvcoYitx+b6FvEQq65z3kNQA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h2pBYpj3dXMLlNmdv4HvbRmq2PgYxdA89/oXSXgZcH9STXTKrSflCTs53l1z8nDyQzM+zbWeJx2nPvxQ0Jk1V79d/QVHT/WBaEdO2bzn55YYSmk+uNyVk9pC7Xke3AwObqAHHCgA0izE7nLIye9wtBcxxaSjqtTpDsR9xsOQ4F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DLEGgulj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VVGYOwXC; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DLEGgulj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VVGYOwXC"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D5A661140145;
	Fri, 17 Jan 2025 13:27:23 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Fri, 17 Jan 2025 13:27:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1737138443; x=1737224843; bh=lneu4wQWfr
	xZdkVKecaXvcoYitx+b6FvEQq65z3kNQA=; b=DLEGguljyXZZwR8rz0NWcrgLz9
	HV8ulPazzBNx0sMgrULt9NSr9B4K2Y+axoRIPKV4zC3uK1skPqqaebLzBnHNbCyY
	NHx9h2VmmEZ6LRzneT7TN9PJAVTkzv3JUoXslOxOLXN47ScZZJJL4ji0oMkxsVmq
	FhLHeVtRSpm7RY8LWnH+oaacM3m+V6hmbjr0dwWQ508jV9T7skexMd7MY/x0It5M
	EBNAwAw1JgwcerClI61Zs/XeAr89LhImxHhrXm6WngM/UwLJGgL6F8jnbswP/HLc
	73MydgjSTAfXP4uo5p5bfY1T1cAocpdxN+1IIK9PGk2tLi3ksEN/iPKVJ9RQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737138443; x=1737224843; bh=lneu4wQWfrxZdkVKecaXvcoYitx+b6FvEQq
	65z3kNQA=; b=VVGYOwXCFcy2xhw6IDZyqC5hJYKBKIUBzQohjVOfi2nhojuL+zw
	qXB7tvrxWqusrmiw7l013fJJFAURRv8QwEvDYuv0xVPuNOR2xWa/Epxo5XBXhkGH
	LTserra90bqUIyeLn4hlmeJz2lE+TFe18/WhRLPBXkouf+sbM2o4PpVqORAx4Ibn
	n26nRRx4mrMdysmywvw+e6hTgLZ4vtSpS+TFzmkw2CxtGRvuzAHqE6lsT5FI1tb1
	s/3ALI7NAzuig4g5AzUdN4K3arexuKdFv8sIsLSh95frEPzHfN7JnBN4vAUh5VGU
	YM2kyRCUOQOoOinrRG5EInqaNAYnbLt9vCg==
X-ME-Sender: <xms:C6GKZwIMTJLR8OyK2CYy1FlBlgV29D2Lmq4tLeyIjOFR9dUoKKglMg>
    <xme:C6GKZwIF-bLTCOwMFZyvx5Kn1UTylYHchk7NBTiT8kaiKmyWOCJm1rHLKRyuPKq1T
    4eTr3xd9bb-jSGEyw>
X-ME-Received: <xmr:C6GKZwtGvz-mYpqE17pJjUmlMuLA8pxxHjO6SLntosDKRldlPgToaV07YTGAgfcG_obDVWeGmJca5w2Ffwa7qu-8ldeHtDexvBm1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeifedgudduudcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:C6GKZ9YgZl4aoEXvjJGnlEBgFIuQib1gfFlw7JAoI8rMHyobdOXaiQ>
    <xmx:C6GKZ3YDiAh2Lt0BBY_k7d9H4TBa27_cj765UmbwP-CYbWTglX2ZRg>
    <xmx:C6GKZ5AZtNrmKoGspm3NxB2vTclW4sUJAiyQWrRyEEcbt4sLHfSZnw>
    <xmx:C6GKZ9bTA9FD5KOwDERm2mKymNVXJemcpQAd5fUoH67-5sy1ODUu2Q>
    <xmx:C6GKZ7R1RP0swDusX9wFcwgHbh7r9QDwwuHGSJrwwtIB-vNP88rS-zJx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jan 2025 13:27:23 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,  ps@pks.im,
  johncai86@gmail.com,  Johannes.Schindelin@gmx.de,  me@ttaylorr.com,
  phillip.wood@dunelm.org.uk,  sunshine@sunshineco.com,
  rsbecker@nexbridge.com,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 3/6] version: extend get_uname_info() to hide system
 details
In-Reply-To: <20250117104639.65608-4-usmanakinyemi202@gmail.com> (Usman
	Akinyemi's message of "Fri, 17 Jan 2025 16:16:15 +0530")
References: <20250106103713.1452035-1-usmanakinyemi202@gmail.com>
	<20250117104639.65608-1-usmanakinyemi202@gmail.com>
	<20250117104639.65608-4-usmanakinyemi202@gmail.com>
Date: Fri, 17 Jan 2025 10:27:21 -0800
Message-ID: <xmqqbjw5l2ie.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Usman Akinyemi <usmanakinyemi202@gmail.com> writes:

> Currently, get_uname_info() function provides the full OS information.
> In a follwing commit, we will need it to provide only the OS name.
>
> Let's extend it to accept a "full" flag that makes it switch between
> providing full OS information and providing only the OS name.
>
> We may need to refactor this function in the future if an
> `osVersion.format` is added.
>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
> ---

Nice that this is made into a separate commit from the previous step.

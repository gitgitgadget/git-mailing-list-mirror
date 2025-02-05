Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BCC4C76
	for <git@vger.kernel.org>; Wed,  5 Feb 2025 17:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738775253; cv=none; b=Vs+jCQmtkMdAqqxU33gdFEBlxcZfvaeOfsymmv3v0dK5hZBMYhAWrug9NtmhA23rXWpcSkoUviZMkHuyijziGXE2/QGFIpNViixO339QHmcO7ssdEPZ3n7Kaea2kLIFOfUCIoeHLFv92kwJm/e56s6pKHLtKf7YixrzesEyRQ3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738775253; c=relaxed/simple;
	bh=xhsQfifxuCUv7LwPWR/xPutviZENFy/brwAg9huaQwU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HG8kc374yVxM2J+K6pWkDKhv2J65qyMFCBPZ8K5OF0RFDKe/0RPC7lyIt6EoPuhlS4qovUp/hNXhr5l2KQChJ+uV03gdURoG1y5OHA4srR+w3f6wBKKhtdUxY5p6VWEi3rqC1sVsCn5y1c1kWLSrrUL9eeLkzi3yOjQDf0KKM00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RdzhC481; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HEfv1kT2; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RdzhC481";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HEfv1kT2"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id C7EC4114010B;
	Wed,  5 Feb 2025 12:07:29 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 05 Feb 2025 12:07:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738775249; x=1738861649; bh=h0rA4LCWUt
	fgKGhBpvmKJyoXP1XCZl7lEzY5889F23Q=; b=RdzhC481nIIBJr7b2Ig1INagyB
	a33INKmUBq8f0DID05Z0Cpbk4EesiBIgcK1v5ak3cCXHFDEVSb167C05qqYt3Z+i
	BT9XVQiLMXC0iVL7x/4rc840XvNYBLFPUdEDiJ+tDPYhcvC6SFFLqwifFJ1fQ74e
	9RvZHo41YxJDMSK/JgcdAElouWiUrA6wBRtnklthuavtHa4n/iYLFhnNqxspJHOw
	qFyVn4iz/H95uDYO3B09mo3ktD+eGfczk6Q6fLgm1PQaYAcKGGmo6qxkXp6ZU+tX
	j/xGg/0jC0jqZa1iUdAHw37WU5emF9pqMBOqXZygL1w6UIWf258sB7rnMaLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738775249; x=1738861649; bh=h0rA4LCWUtfgKGhBpvmKJyoXP1XCZl7lEzY
	5889F23Q=; b=HEfv1kT24kAF7wuAKISVXQH1AEg1fcQi8r8iGW7KcQxvgZMyxcZ
	TSH5Bgb8qqI1Hl+qZg7nxcsvNiH5HwMrvi1aQIL9Iz7Hltw7/uM/AGjv3Ofu85AB
	xlDoomgbeyq7HGuEtN//OtgNqa77T9kbNss2eufEDkr77NArex3XuPIcurRF1W2f
	5p+jfVoBxHJKAweiFsMFGKUff/rluLChqPD+PmQkbbgoyN4PeOqRUZzn0pjcgVQi
	/IN6UyDee3aKE0phcuIi4BknADc5t7d6rPN9ahGie9hTWmTDrEoTmwEKv0wwa6iC
	wxydssEz1sC2nO/HGfLr6+RWxYDkHMs8yOg==
X-ME-Sender: <xms:0ZqjZ6u-ayryFD59FkWZbNOP6j-X9Wayxrj2rVIFb1Xx_I-yu1T0dw>
    <xme:0ZqjZ_fsxzRI3LYaadLp9JTiMkQS99rR6trECs4Si6eiyQYbXFytUSKtXCEQLeYGc
    OuJH_qblPz3oRs8SA>
X-ME-Received: <xmr:0ZqjZ1wnGrW_wnzdUu-c-pM4Pgcsb9jKnz-xNJxzUSV76kZrVxwW4zVob7bW7JkSeep44LLAdJYXlXCZF4-OLZu18Yz_opJQsGjN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgedtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeduhedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohh
    grnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepphgvfhhf
    sehpvghffhdrnhgvthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtg
    hpthhtohepjhhohhhntggrihekieesghhmrghilhdrtghomhdprhgtphhtthhopehnvgif
    rhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuug
    gvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:0ZqjZ1PWMvGCpTAU3Mkt1lIRNlJAV6IPBUh4zGgE2VFte1AdgQHyPw>
    <xmx:0ZqjZ6-X-ynhbloddQsU3ra91faAHp3kWmfXWLHSQ4vb8DmvoG_M7g>
    <xmx:0ZqjZ9VroQJbP73BOkZcs-gAaz-6H3w7k4zbK8ktxsSE7eK0ISUovA>
    <xmx:0ZqjZzfZlbbYrPv3lQY2hnvjufL3tivTjpUZ0_uRKPcCuiSWl_c6JA>
    <xmx:0ZqjZ1f6eDyK9ErFWIECNyefc8q-jw5WN0U-bcc24bKO7DUiZpihGRC->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Feb 2025 12:07:28 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  johannes.schindelin@gmx.de,  peff@peff.net,
  me@ttaylorr.com,  johncai86@gmail.com,  newren@gmail.com,
  christian.couder@gmail.com,  kristofferhaugsbakk@fastmail.com,
  jonathantanmy@google.com,  karthik.188@gmail.com,  =?utf-8?Q?Jean-No?=
 =?utf-8?Q?=C3=ABl?= AVILA
 <jn.avila@free.fr>,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 0/5] PATH WALK III: Add 'git backfill' command
In-Reply-To: <Z6MQK6anxpMhlL9i@pks.im> (Patrick Steinhardt's message of "Wed,
	5 Feb 2025 08:15:55 +0100")
References: <pull.1820.v2.git.1734712193.gitgitgadget@gmail.com>
	<pull.1820.v3.git.1738602667.gitgitgadget@gmail.com>
	<xmqqwme6y32z.fsf@gitster.g> <Z6MQK6anxpMhlL9i@pks.im>
Date: Wed, 05 Feb 2025 09:07:27 -0800
Message-ID: <xmqqpljwpbg0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Feb 03, 2025 at 04:18:44PM -0800, Junio C Hamano wrote:
>> Everything looked great from a quick look.  I'll have a more
>> detailed look later, but this round looks quite promising.
>
> I didn't do another deep dive, but mostly had a look at my last comments
> and the range-diff. As far as I can see my comments have been addressed,
> so this version looks good to me.

Thanks.

Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C58B664
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 00:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744072377; cv=none; b=jgeFzPyohcLSREUQqqXpSuIJj4AkiIQs7F6+K3UO3kajdmMo5xWxzsSJ7oBzV34ngheEZoK53kIiN1WhBx39TRZyZc7sbsDfMtc+5hDlD1OACEzU61FRtxY8y5o9FY0bTBtuF6eWvVhFMqO+shzaWeeRl6Ixs+YLN1p9gA1Ree0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744072377; c=relaxed/simple;
	bh=DnsMeGhe7CrB4fIuZMRqhEu1BwofxRiNf7dTufQ2q5U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sW40i7200oS9xtdTDQ6/M1S5a1S/05ziBLUYw/mBhRcEoi8H8erNJ1Cwqp0W8KacicQvRNyIqaZLQL2alT/J/v//Bi1ZBMoYY+bh8ybNZFGlfPcUBhNvMzCK3HtMn0SMOvXGA7qmL1k0IyuViAApUS4uioCamJAeXsPoShHsZMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CJixuy4j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=REaITqhc; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CJixuy4j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="REaITqhc"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 64A6825401F8;
	Mon,  7 Apr 2025 20:32:54 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Mon, 07 Apr 2025 20:32:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744072374; x=1744158774; bh=TvXNDDhmb1
	87jHCK/w5jfTD5ZRFZRuTKbqcU+igWkXk=; b=CJixuy4jZ075XuEnWh8/3nTy3/
	rf+3miYWKboK4OmfStcgP1McrKAwk7aShyb7S/BWf4JltJVKJyMHhKbqLB/A9nwr
	W80i/jMFnKVOsFHk45MG+4fPeswSkrj7giSkQ2GNbDuzyGDgcXAFwqAJtbL884Q3
	fbH14aORvImgiJi9mRB/n1pAsc3l0BYAkTKGYHLtWfEn4fCIU7XzF1bWCqmTAqJH
	0PKFZ4enivN5WvZEp9N4cJNHuXkOJf6zlNEY/hPpGd796G0ZZuSyKrbw6c2uuSkA
	tj9SFYU7gmYyTzzf5Dk314BM2P46BZeKgG0CnuIjVxghyGvXOXXNYNFeveew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744072374; x=1744158774; bh=TvXNDDhmb187jHCK/w5jfTD5ZRFZRuTKbqc
	U+igWkXk=; b=REaITqhcNvOvHJ55XN9eUx6ut6hF6gFPLuJ5uT1flG3u9oifwT2
	g/VpabDItwg6QSTTXBGFjcde3BhoGQPUolWaYnxealHW7udC6FghFCdhe1GeWjRW
	j+ZJ44lvJnoprRJlIqCNIga4Dk+0kBRb1tuvbZiDEvFdSEtchz+u8EhEkfqkKwN7
	oAJAOB81zHq+4r0Pi31qYLz9pGRHxKfFCE5z8AAyq2H9fEbVzt2W5pPaT6YrK46X
	cKnBaDiWkFcnHVWOInAMS6nqBGjACkAT6eZSI+LGl4BqRlRGA+Pq4yQFy+lUB09j
	vgiFKS9zFxebbQw+LePGyZ+VhgTBzPVNNuQ==
X-ME-Sender: <xms:tW70Z7NMpgPgbeg16fP58TGPk9rMuU8YdGupKADIzARTbyHyGCNIuA>
    <xme:tW70Z1-WsS1BbIdsAMakNzgo6GZcxJOMxeDc05riGGRcGhC4WwYgdXnf9TpwytHml
    6tUZtqPvLHpHbUTGQ>
X-ME-Received: <xmr:tW70Z6S4qvpJzOQKKHZ_ei7Gt0JRUIM035F7-x3Ps6qNdrPXPAk6_b0UuwDkZvA25BoSF26xcGKsQ7hOWtyxeGOwQ_myivOAigDy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdduieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiph
    drfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddu
    keeksehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrg
    hmihhlhidrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepth
    hoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:tW70Z_thp9D69OA2ZTWtKW_60ZIjRZN1_ML9YkBHV5ORhcO4DABfWA>
    <xmx:tW70Zzf-83Jmk6dOt0y0qhJzn7U8_FiIKBjFNAVw4svJ7nUxu1ejiw>
    <xmx:tW70Z71D47VRo6EbRsyquIJPDxx5MR93bTQSzMRJzDzkmqVUldhe8g>
    <xmx:tW70Z_82eWvgvWEyyttNjphMct2yfzb-i5Ir2IyvimjuGCOop7EuGw>
    <xmx:tm70Z1khwhDhZC7NWznkoA0b6qZIQfMiYZ3_k-nufsYQJ0qWDUxqBbHb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Apr 2025 20:32:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Karthik Nayak <karthik.188@gmail.com>,  chriscool@tuxfamily.org,
  git@vger.kernel.org,  jltobler@gmail.com,  toon@iotcl.com,  Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH v5] blame: print unblamable and ignored commits in
 porcelain mode
In-Reply-To: <2fbecc76-c3d9-4a8e-9326-5b83db1ceb26@gmail.com> (Phillip Wood's
	message of "Fri, 4 Apr 2025 16:58:44 +0100")
References: <20250321-514-git-blame-1-s-porcelain-output-does-not-emit-unblamable-and-ignored-markers-v1-1-44b562d9beb8@gmail.com>
	<20250403160326.120124-1-karthik.188@gmail.com>
	<2fbecc76-c3d9-4a8e-9326-5b83db1ceb26@gmail.com>
Date: Mon, 07 Apr 2025 17:32:52 -0700
Message-ID: <xmqqv7rfze4r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Karthik
>
> On 03/04/2025 17:03, Karthik Nayak wrote:
>> The 'git-blame(1)' command allows users to ignore specific revisions via
>> the '--ignore-rev <rev>' and '--ignore-revs-file <file>' flags. These
>> flags are often combined with the 'blame.markIgnoredLines' and
>> 'blame.markUnblamableLines' config options. These config options prefix
>> ignored and unblamable lines with a '?' and '*', respectively.
>> However, this option was never extended to the porcelain mode of
>> 'git-blame(1)'. Since the documentation does not indicate this
>> exclusion, it is a bug.
>> Fix this by printing 'ignored' and 'unblamable' respectively for the
>> options when using the porcelain modes.
>
> This looks good to me

Thanks, both of you.  Will replace and queue.
Let me mark the topic for 'next'.

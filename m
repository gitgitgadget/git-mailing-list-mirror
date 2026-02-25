Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6042530DD22
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 20:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772050121; cv=none; b=EYVgHv/agi8ByO0xm72HuOsKXLLzlI2U3ZZPK1zVewIxsbFSfrl0RO52sIlu1lZt19qFCEY3b5d7ApM3NsojdPaYjjS0BADWNsYT81b0iWA/wCpJnlZCfKwbcPPYhKw7kQvJ2BoJcYNZfTi+P55D92rJ+jLN2chUL6zEUmLh7SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772050121; c=relaxed/simple;
	bh=kJRGtk9Qro018Din3/Itb7I5WUZwachvpuErm33yJCw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p2H+Hc9kPl53/LkIMh6HGddyEVvdiVk+7QhihDhOoerQs6nYjWWk/dbkXu3cJPf/ab2Vwu7Vcwtq1LsNjYjP3z+mnhbIpYWrLLwFb4vLb4JsOV6i0zgXcP2HupR++kK7RzG2gigi3nNYdK7qmHpimAbTwTv0H29OLxyGUhNDgZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=h5nawfb5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ab7cqV1m; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="h5nawfb5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ab7cqV1m"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AAF041400046;
	Wed, 25 Feb 2026 15:08:39 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 25 Feb 2026 15:08:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1772050119; x=1772136519; bh=QnegLkeFyn
	UmqxqYL+kFScWpf8zoaJ7HomUerYzmJk8=; b=h5nawfb5LoUCa3r6nN5et0qJfD
	aUI9WGgU3PYEtopa+KJlMRhfWmJLHHqESlg4HR6zAEcfbd4H53Vm5P03h1mN95UU
	upTICDZagleNkj93UngRtxwbuqfdMZyV4wS72lxAjNWGaqqThUgrZBQd6sUYdHpw
	aQYQQg4yj6fPlcm+TBKYxDXGPtgmSbNN8E0+SSsyA/rvQR23++5kWnI/JEl1bK/x
	PsXAfYvI2EqxgOpzUIN4so9qgctnhtXV/QXjv9QWzQGrnzsqghsmoA1ZSYRkXMwH
	pVvkqFYltKPRL+wmW9yWBvh79hV1iox5aRZC+FNUrKlvxbm03N6+s8fluR5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1772050119; x=1772136519; bh=QnegLkeFynUmqxqYL+kFScWpf8zoaJ7HomU
	erYzmJk8=; b=ab7cqV1muQqSLy56/npUqGzqAGQ6mjFCq+shOyl83odAFQZ5q62
	wxUFUGMcykyfCuhkkCI4U0NJcA35M9xFxhdjFxWqEjm3W200NsXIrmluTTS+OblS
	QYQdwqEcvhR+TFtWoWag/KIe05axIACWLOjh4ZwAGH8k8bQLeFl5V7jD3RL6F2Ye
	Q+omBALnvG9iNekrNDuM7n1kC7/2BjTROzXXus6PsbxdPGqc8vSqvYwjXwpmktl+
	Y5j2Qb68UzkvSh9mRd0mWBvRXdfWmAHhdIkKXI+MuX1aOy6W1r5VMQAzU0HFxDvN
	45Yxkgf87UerlI7P5sByPXhkKHtYj/mZbnw==
X-ME-Sender: <xms:x1afaQ5bznE4YerPcL3L67PTsUR6I7JRNbtMDg8vjQ0ecQbnkLkmSg>
    <xme:x1afaY4ZwlIk5kwUVW10rhrGWt7STPlEDE6VCXud_kPo0s5RH8CzggLBrlvPy4URv
    ksSNyuoZoZCQdXEnn325n5XZ-chqMccqZJm5r32qYJqdXNHMGmM>
X-ME-Received: <xmr:x1afaUeDbMCiOpUw0YFeyKEVD6OWCz3ziJqqzUveYNAfjuRvxTQVSJ8rGA1eQrVf0oHQf8ybxfHJ9UEHvCJWdlQyQsSrFmTB3w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeegtdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrghrtghn
    rghrtgesgihiphhlihhnkhdrtghomhdprhgtphhtthhopegrlhigsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:x1afaUC9udx0K5JfR6s_i2RfDA3Ud7KNLeM30kXiyDfIPDZ15vCRQQ>
    <xmx:x1afaf9JXn8agVSWhoyclm_upYj8Uf-fJ88fVW1eBVh3QowMQEGfIQ>
    <xmx:x1afaXLpSpnl98HPIM8_QXBtkS4tdvzGISPjp2jWpam2jCLR5ITSMQ>
    <xmx:x1afaQjlpCvHuLewgjolMOqPVXLF3PGkCdvWfefu0dMzbupCOSjFpA>
    <xmx:x1afaTz7DkzQgn7y-qjvWx1ggNIbjnpf5L1F2mowdqnZoqWkH7dRL4BN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Feb 2026 15:08:39 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Marc Branchaud <marcnarc@xiplink.com>
Cc: Alejandro Colomar <alx@kernel.org>,  git@vger.kernel.org
Subject: Re: --no-decorate and %d in git-log(1)
In-Reply-To: <8f6441ab-5c9a-4b42-ab2e-a670d462569d@xiplink.com> (Marc
	Branchaud's message of "Wed, 25 Feb 2026 12:46:40 -0700")
References: <aZ81X6ERyx5fcm6L@devuan> <xmqq4in4brt3.fsf@gitster.g>
	<aZ9AuD3dYzCKtI0s@devuan>
	<8f6441ab-5c9a-4b42-ab2e-a670d462569d@xiplink.com>
Date: Wed, 25 Feb 2026 12:08:38 -0800
Message-ID: <xmqqcy1sa8mx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Marc Branchaud <marcnarc@xiplink.com> writes:

> BTW, --decorate=auto is documented as "if the output is going to a 
> terminal, the ref names are shown as if `short` were given, otherwise no 
> ref names are shown."  But in my experiments %d still shows refs even 
> when the output is piped to a file.  Seems like another symptom of the 
> same bug?

Isn't that documentation merely referring to "git log" without
"--format=... %d ..." and not about the case where you explicitly
ask for "%d"?  That is, the description is there to explain the
differences between

	git log --oneline --decorate=auto -1
	git log --oneline --decorate=auto -1 | cat

isn't it?  I think --decorate=auto is the default so the above
without --decorate=auto would behave similarly.

> (Do people who use `--format` (with or without %d) *also* use 
> `--decorate`?  It seems like the two are naturally exclusive, even if 
> the code allows them both.)

That is an interesting question, but I am not sure if it affects how
we decide to resolve this discussion.

Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55830215793
	for <git@vger.kernel.org>; Wed, 22 Jan 2025 17:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737567814; cv=none; b=XNiF9XSWt3yGSc+27BvSnfcEwQ4FDLP6AZJdnqpscX4hnhRaqLfG3AwKcpX9is2zGjQh9UleWRhqZZMZK2ayifhN0CirCzmXSMWMTs2T/cq9VQGf2p2QRFd0v/dJvcUppkJUl8AwXCH5Dhr5BiLy+CTVdKRhrPAAjxGEuS21Oto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737567814; c=relaxed/simple;
	bh=reqefmapvvkpPYWW7yIIDadfBa6UbDwB89muv2UGj18=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=L8wWqpONmcIXQID81gkKaFg2wH/hZa0l5GFV8l+bbtJxFfU41DPLR4UHp80UAs9YEfPcPvd6s6gvqABTLrTeLnC8tCICKcPtpYfTBo8KmLmchYY0opbPpI9pQpQhfpPxAX0GZnbeflVLyxy65sKIh6qnnJEAHoC8T8eLxHOxboE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Q5Nd7yuh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DfmbI4aJ; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Q5Nd7yuh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DfmbI4aJ"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 58CF9254016F;
	Wed, 22 Jan 2025 12:43:31 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 22 Jan 2025 12:43:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737567811; x=1737654211; bh=L8fJhOX/US
	PmuwAqbqI7ZIGNXmKb1mO/TfNNUOeDsHU=; b=Q5Nd7yuhcM4PQ8cNduieiXxyRw
	s2SJzU8RVPfxMB5dPvSmlxtgfaS3QDPQuxw2V0dacs3leATrs7GCwXmHlCmugCUD
	IEJF7t9YeTEkL6N4iqAOhaAux1UxnFh9aVlL9vpkzJx2AFSVW77iCZRvWOSPLZJn
	ulNRPPCWWQ1lJnpC5gr3o7I3/UYFsfCwwT4WrAbGqFmGm6dL1PhfxfeZfybpeiEv
	hg67SaWPTalPr9jUMxXJfbxG0RjZSTLu+/MRcbUI3kGWnsnoa0f6qMKekHuXiMxM
	7OqlkrqbSd3HxZNfuFUp+JbDUO/a1j0amgbKoKMzWdr4N2gW244RtlzoAV6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737567811; x=1737654211; bh=L8fJhOX/USPmuwAqbqI7ZIGNXmKb1mO/TfN
	NUOeDsHU=; b=DfmbI4aJoG7eW/eXu8dpmJMpj7ZZAkoKknf8nWIt4qQC93/UvWD
	RAv2c9ESfPtrb5NSC38wy2QvdW7ZghxAJEjuxxbIWeugG+GYGrPo6OgxvbZk916c
	AFpHmZYWU2qnlhRKpJfcoABkJzbzOrsu+2DebxpObrcARHgSqzm86qIM281XfRP6
	8MUuN3j/2rWxdobuK3c2Cgj5rFN6wgOLylsUPeRTu8YaMJZZCqu0ZF9O1ogQMdVB
	uYsutHKvIvrrtbs1Ui/ZFLZVeGiEIm4kQASP3qTlaMUuU11T+Rdu9Jas1F8OFnzz
	vZkUNgQLpiGOF9W7tDQXf7o0MY02vlbd2iA==
X-ME-Sender: <xms:Qy6RZzY7y4VxwX7YmemA5fBG8gcwTr9iB7OTFsa8PLUHBIfqCe5XIw>
    <xme:Qy6RZybWeECasId4wDwTVPMTLViZ9Sjz3aLX721mhZKy8W3Rpx-o5r-Pga7b3JlgG
    x-8Wr2LqUM1lvHrmg>
X-ME-Received: <xmr:Qy6RZ1-qQVrwZv0DwHr01nVWA0r52V-NvZAcFdYbd8dWeYwpcoDbhky_WdtDvczGaMhR2cENLwv1cCOc-UOFj8cPn02OUv8t4x8t>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejfedgvddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeettddtveffueeiieelffeftdeigfefkeev
    teevveeutdelhfdtudfgledtjeeludenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhs
    thgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepmhgthhgvvghlsegrgiigvghsshdrtghomhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:Qy6RZ5pQfiOSqGe79nPnPnF5aEKECudlgXhAWoQlNVYNHa21LFYJWA>
    <xmx:Qy6RZ-pxbq_OGZgtRHTliknX32-Utc23tLG-cTpyhtBQNMmtzYd3jw>
    <xmx:Qy6RZ_RY_VzJmkW3g4eqWFSKTPzOJ7G7NHL752uuPktm9sLr-JYLdA>
    <xmx:Qy6RZ2qpV0G_8fsfg2NEvbW-cFhbMhKbbKC977cL7ZmbgLt58yx6uw>
    <xmx:Qy6RZxVp1KNhPIXrPtLTJOWawlRlUg422ZtsQnglwZJ44k_FfUvw1P_z>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jan 2025 12:43:30 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Michael Cheel <mcheel@axxess.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Git Version Confusion
In-Reply-To: <SJ0PR10MB4750C74BF6A4A26AF4730BCFBBE12@SJ0PR10MB4750.namprd10.prod.outlook.com>
	(Michael Cheel's message of "Wed, 22 Jan 2025 16:57:25 +0000")
References: <SJ0PR10MB4750C74BF6A4A26AF4730BCFBBE12@SJ0PR10MB4750.namprd10.prod.outlook.com>
Date: Wed, 22 Jan 2025 09:43:29 -0800
Message-ID: <xmqq5xm6ycam.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Michael Cheel <mcheel@axxess.com> writes:

> Can anyone tell me why the git home page says the latest version
> is 2.48.1 (released 2025-01-13) but then the download page (for
> windows) says 2.47.1(2) released 2025-01-14? It is a bit confusing
> to me.

The 2.48.1 is the official source release and the latest.  Depending
on the platform and distribution, some may lag behind releasing the
latest and that is perfectly expected.

Looking at the output from

  https://lore.kernel.org/git/?q=s:Announce+f:Schindelin

I suspect that Windows binary based on 2.48.1 has not been released
yet, even though one based on 2.47.1 has.

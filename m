Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E612313C3CD
	for <git@vger.kernel.org>; Tue, 20 May 2025 19:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747768305; cv=none; b=gBswcJ0QofdGL+G8wwv5clcDdicme0Z6k3wYuL8MV/ZtuquKaCsucosAseKSez/vdsokaxi96/C0XKxj3/VfZNlWmCRexOsjWPTeeJr2w8w0WcMWfya9B1ORioyBA85lPZQhO8dqdiEB/w801NTi6ToAR2PwoOZgkIcA5ip5Hsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747768305; c=relaxed/simple;
	bh=UYD4fFwGtrxtHhvh9ieULiTaqRqnt3Ucr7z4uTP4okc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TRH727Fqz7i74fCizlkfh+rkTobEZUhBO2OMWFI5X3IxkuHBJpxxJWNLl0XxjVBtgGoyxDzYZVd0JxTey9OlanbA2ja6MLwj4zGSReeikLuwxJyd+bLzLcLmIy715oqh/Smv3//x2+21vHPhS81e45wArEk5OISXGareKmMrKj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YjZC29QD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T+eLLc4i; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YjZC29QD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T+eLLc4i"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E6C712540096;
	Tue, 20 May 2025 15:11:40 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Tue, 20 May 2025 15:11:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747768300; x=1747854700; bh=AnikJjGjej
	gvEIRWWG0vshMuS2mkv+g91HypqxzFPiA=; b=YjZC29QDdyTFcvw/BGTHn5nQhI
	qMRM9HRcEpaLVl/Ul51pi/59ktOc+AEbnJEbWfJww9+mwUGCS69pOFhI3KyGMGLw
	1OMJN74fnStj7fG1PvJ04V5PERFjoZvLbHi/E+82o6o6SE3jQQIp+SUoq5axiuIw
	IaUaRLpgc2xmaWixojGbIgUb9JVj34nOkryVHB03wE7l1F9NWVSX1M0eyFgbhdQX
	LuYRgQkT7z2hZyNQkxJ3Ww/W0Wa0R+aS7d5o0jksMcnZvgpOaEn8zz1iIZowIPSQ
	ePBdnqHHtohDDmu3T/zb0ySrBIRRCQLyRLEPzyqE2YllUcsGwLmQab1zN54A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747768300; x=1747854700; bh=AnikJjGjejgvEIRWWG0vshMuS2mkv+g91Hy
	pqxzFPiA=; b=T+eLLc4iaw+6X4+nVntO1NoCbKjKF386zX92fl0/vCu5L1tHKJB
	dPLyE/prYZptWXFDQEwUjMoxr2MbCGDoY4nuvFrVd3DANjtqRGMBNdonkI4ZKvyL
	gzRjbhZmZ73tKRACurPCc+C2w/EO2HkaCP6yEDycb+aS9WFJgIvzPFWZzlgENQ0X
	M6XjgpdfsdR7wFUpypVAkfbCrfH5BAHeR6oh4VMnxkpdA22Ou1ZsUIrLAtFTaUJT
	ttmHbqkuYQNjLUcoOFH1z4OL8ee0UPdRscuFUpqQ91oaWJew57in2V0H3yq+8Dnh
	3lt+A1ldTLu0lyT+LPJSItazVecJdXUx4oA==
X-ME-Sender: <xms:7NMsaEcPojlmu6gk7Kq2slkwVkxQMuPZz9QiKxAVg4WiyGbemlOcag>
    <xme:7NMsaGNnJBOnZaOKyG42C6Pyb785MRSUHvBY8OytcLki-QWm0ei-U6rn_GhTsUkPX
    P3_C8KMMtlOkHrEJA>
X-ME-Received: <xmr:7NMsaFhPB_zd8OVVzyhYp-45Kodp-O_YvMAFWfN4ZG23bumSqmxDKR2GSOxnCJ_QP7KP-GzhtLteDBc0-BVA5CQ8S2aR4Jr-AXs7Ydw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddutddvucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecuhfhrohhmpefl
    uhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfefiedvudegfffgffff
    veevvdeileffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmh
    gvpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopeguhihrohhn
    vghtvghnghesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:7NMsaJ9EaZpwRxJKuBMxIAXs9k664Zah_p-3mqsJDj_-WPusFdRv8w>
    <xmx:7NMsaAvWULNQqvmDykvpSIk5cX6PGMvCxsrwAHzlXyGBAJwhkc6lvA>
    <xmx:7NMsaAGhw1b51WMoLuSX77QlK_iEjt5kugObZLs8yg7thl9TBXZ4xA>
    <xmx:7NMsaPMEfHEIFYBM0OqXENipqQTkKZiv4hP6FrkTXsvGn2HHf-Locg>
    <xmx:7NMsaNQwzHMKH6vS4_PulrCqZk6TU5hbnpI8py6cOowAzJgNSbKoNIJi>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 May 2025 15:11:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>,  Jeff
 King <peff@peff.net>,  Teng Long <dyroneteng@gmail.com>
Subject: Re: [PATCH 3/6] doc: notes: split out options with negations
In-Reply-To: <d2b6864b7072faa2c804c98ce7758b666e11f00b.1747763769.git.code@khaugsbakk.name>
	(kristofferhaugsbakk@fastmail.com's message of "Tue, 20 May 2025
	19:57:21 +0200")
References: <cover.1747763769.git.code@khaugsbakk.name>
	<d2b6864b7072faa2c804c98ce7758b666e11f00b.1747763769.git.code@khaugsbakk.name>
Date: Tue, 20 May 2025 12:11:38 -0700
Message-ID: <xmqqfrgzhzbp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

kristofferhaugsbakk@fastmail.com writes:

> -`--[no-]separator`::
>  `--separator=<paragraph-break>`::
> +`--separator`::
> +`--no-separator`::
>  	Specify a string used as a custom inter-paragraph separator
>  	(a newline is added at the end as needed). If `--no-separator`, no
>  	separators will be added between paragraphs.  Defaults to a blank
>  	line.

OK.

> -`--[no-]stripspace`::
> +`--stripspace`::
> +`--no-stripspace`::
>  	Strip leading and trailing whitespace from the note message.
>  	Also strip out empty lines other than a single line between
>  	paragraphs. Lines starting with `#` will be stripped out

Together with the post context lines, it is unclear what the default
behaviour is for the command.  It is not a new problem, but
hopefully the remaining 3 patches I haven't read would address it?

Let's keep reading.

Thanks.

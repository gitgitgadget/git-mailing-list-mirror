Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B0435FF4D
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 13:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763560165; cv=none; b=UysAoMccXczMibBDU/HSb8lTF7CJscxmr1xJVaXzY8zZx4pmaB68JjrDGqMgC03uK991ATZFYKkckP62O7ydVqV+9fWhSVHZpO6OKdz4QYSXtpfqghUpwXQUPilMmPoifELF/Vj+MngbB1uqJHhvIPY7SymyfiRwf9RYURjS5Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763560165; c=relaxed/simple;
	bh=o2ZJHW7IaH1pysHjr+7zlgFjGfvXzGPZSsn1fnJY96k=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=t+HjFNXc3EBAuX9yv6gOYuNI6K6ze0szKWu0LLgJrDxybdm3kQ+vOHHGKf2v/gHw08UqyeqBtKbmTMU0N5YQxIz9KffbySLWZ3IYafr3UYtqKJj3Lt/ldaUDAmrWRSnco98rx0/uxpLQALMHPzPoV8Rh5E40+t+n7KY+ywWRtt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=kOGp5txv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qCRrKVCs; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="kOGp5txv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qCRrKVCs"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 4D8A7EC0193;
	Wed, 19 Nov 2025 08:49:22 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Wed, 19 Nov 2025 08:49:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763560162;
	 x=1763646562; bh=o2ZJHW7IaH1pysHjr+7zlgFjGfvXzGPZSsn1fnJY96k=; b=
	kOGp5txvlr1AMh0zJ5KCK2HdB6IA4oRCkrkahi9Or4z3TK5zLiYg7dtryiUgJt8S
	+5HIK8+DFuDxwLDhjVvb0HXO2SZ7DzJVTB6pxx33m8nEVUDgCld9jNJEoi8kZK4C
	Nh/ZqfIHvC6kMBH1bFUbZ6xpPWhxXkRNhIqC/giO8/+PIw7DhyUUlxXHb8XSKYEL
	rxqnvbsSktaUAmaRocqN0DygSyge+zgcf4T+ycqSRhCMRuBBlBgE7s8BUxcn5OaN
	VVapiJXcF1Fyx8FS2B2jmAp2vDfzScIRht04NCggf7KQuJ6qOB2Y8Yp3rcID8fCR
	LW2iIkFere35+VqS29pU5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1763560162; x=1763646562; bh=o
	2ZJHW7IaH1pysHjr+7zlgFjGfvXzGPZSsn1fnJY96k=; b=qCRrKVCsaLk/AJ8+G
	/ZqubtSKZRHEz13Dudhlf1KkojY2klB1X/Luou6jaHz1B4hePWioAEIFKvbEitby
	EpvEHu6pD4RWRGTL2WeU5uU91W08EsOy24Z4yUt9vDYnkgzRF+uYSXnY+qhGh7Wg
	Gqbt1I9w9ffWBi2m+ovfS26wGh4VB57+6H/NJ8QhftfLaoiEB6g2ASug4bFVGaAQ
	3oVp8QTeYncLbaF04W8ocxY1Z/lNHuuJJE1SJAAyfB+6rzfWpjkC6LN1vmEwpd0v
	CMAjs3CgXtstLO9R2u/pnWluH6ljWDOZiD+e2oEV5rryp44ialKNIk7UYzdqNRBT
	L1d9g==
X-ME-Sender: <xms:4codaQt2jv3nVDdCYBuak4PXeSAlyL0BdewOgYsa40H2811iKJd1sag>
    <xme:4codaYT4aCv2c7nyBQa-dzcS1iYNEbElLbLtYRo0FKif590GJqgyV6DG3llzy8tVC
    qkYhRzSmf0zaYSSnYHO6S2XX8rwnHHpnORPAkG6oMTPfkc5iuHdBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdegfeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeffieeftefgheek
    geeitedujefgveehvdevieelfeeiiedttedtgfduhfejiefggfenucffohhmrghinhepkh
    gvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrd
    gtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopegrnhguvghrshhksehmihhtrd
    gvughupdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:4sodaco9cEokZSfKJy6wUOxF914SNbTTs0fr7lkBZ9_rEF3wn8G_YQ>
    <xmx:4sodaaZOUJTe0sAXmAA3N4Z8iHGZj5mWuaqP6xovqZK9cMyjrguuyg>
    <xmx:4sodaUQcRCyuLwfjXFt4AtTlKI7L8EOYT761fHUQ2YbxESe0agRrpg>
    <xmx:4sodaR6iphs4P2SaDb2a3UtFmSD7QaB-7L7oSPadCrFYqctsD3VEAA>
    <xmx:4sodacuIEZ28CWiiBqF-BNsvTH6eAU56mA_hks4nkA-HdAs8UirFausK>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E785A1EA0066; Wed, 19 Nov 2025 08:49:21 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ArU5Rl7MVZ7F
Date: Wed, 19 Nov 2025 14:49:00 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Anders Kaseorg" <andersk@mit.edu>, "Toon Claes" <toon@iotcl.com>,
 git@vger.kernel.org
Message-Id: <3b24b6a3-61cc-4b9a-a823-f1e58fd9919b@app.fastmail.com>
In-Reply-To: <4dc4c8cd-c0cc-4784-8fcf-defa3a051087@mit.edu>
References: 
 <20251023-b4-toon-last-modified-faster-v3-1-40a4ddbbadec@iotcl.com>
 <20251103154726.26592-1-toon@iotcl.com>
 <4dc4c8cd-c0cc-4784-8fcf-defa3a051087@mit.edu>
Subject: Re: t8020-last-modified.sh failure on s390x (Re: [PATCH v4] last-modified:
 implement faster algorithm)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025, at 12:34, Anders Kaseorg wrote:
> t8020-last-modified.sh is broken on the s390x platform in v2.52.0.
> Bisection implicates commit 2a04e8c293766a4976ceceb4c663dd2963e0339e
> =E2=80=9Clast-modified: implement faster algorithm=E2=80=9D [1].
>

Does `./t8020-last-modified.sh --verbose` give any interesting output?

>[snip]
>
> [1] https://lore.kernel.org/git/20251103154726.26592-1-toon@iotcl.com/

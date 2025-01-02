Received: from flow-a7-smtp.messagingengine.com (flow-a7-smtp.messagingengine.com [103.168.172.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C011B3958
	for <git@vger.kernel.org>; Thu,  2 Jan 2025 13:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735822830; cv=none; b=Fcqp2VWn3Bbkm0StiVFwH/wTBjK79+S9W8NAHkwA0MbhcKouJkuAZyaSTkz/7tw+NJ/ImIRaWGCU2YeKFzo2T499A21qNUAgUFBwju/jeXPCry5yWRZaCSL8PjycE8otUCmjdUi+zo8IfwQrVOMPW0vERVOrY417YRx+MYWyNcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735822830; c=relaxed/simple;
	bh=LNuaUgR1m/FjAYIB/6TkG5lzUudkJkOcl/CHIQ2pRz0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=ZlYmiKp37cnVHNLAsMkKwgTyUpwMJSXrniE5X1wBqqLEM1lwtZY+YVbIIcUpavuUH0B17Pqx1fCEDnoQzIgYE/1itiLO25Bn8XL3AzyaZMP49Hbf1a4jXyC6nJGwRtFv5A4Y3r9Vh3WWp56A+PQ34VM5y6F8Rvs23VlUhOY2IbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cepl.eu; spf=pass smtp.mailfrom=cepl.eu; dkim=pass (2048-bit key) header.d=cepl.eu header.i=@cepl.eu header.b=IL5Na9T5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yW6oTl8r; arc=none smtp.client-ip=103.168.172.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cepl.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cepl.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cepl.eu header.i=@cepl.eu header.b="IL5Na9T5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yW6oTl8r"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailflow.phl.internal (Postfix) with ESMTP id A08B3200943;
	Thu,  2 Jan 2025 08:00:24 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Thu, 02 Jan 2025 08:00:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cepl.eu; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1735822824;
	 x=1735826424; bh=MDpA4ox8lY5Phy2Hx/gs0/rKfnNMVqmMPHDuOPGLv3k=; b=
	IL5Na9T5FYPjIvp5LokykVbhqiFgvYYOn432WhZDywNM+foQHQX1/HUUIcRxH+8a
	8fWPF7VmXlH9xl2k4PoP3WGok5o2VBaUKKeqF0RdibYgp1E+a4G6TcT7KQYt22Rl
	308dD1VT8Evk+jDJ5/V0glIEYv5ltdi3Jt3nnZ5hK1KBSPUV2Yspnwz4oOZHe1jY
	IiA9TvzozaodpizusnHY88ooL43WFWZHi3eHl7thGy7aCcmNFmxaxZQ3UoFhW1vk
	ZdSo7G+pCi1vBRgZxjOBp+/btx7QsOsYZ4xMAIzEhCDHu1CUxtdAhTwjkal9OB1R
	D+9BZLdNn5Ug7n/gqMjLsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1735822824; x=1735826424; bh=M
	DpA4ox8lY5Phy2Hx/gs0/rKfnNMVqmMPHDuOPGLv3k=; b=yW6oTl8r3kwnXA4AG
	fmJf3j4w/ZRzK6Pzcgh5ynwTKF1mgMibK3/bvTV6DCvku2qY2qphBTtXdFji8kgt
	RlQogJwYjpVIoE3MEkmOlNu2gs3juHzGXB8ZAwNF9isjk47RBEfoWJs1k1aAGXcB
	qu9yknVPYKpnJDQlss3N5RcSiA3CWdDuZRHyXR/pop0DWs3esIOKED3Q8hxc+KRN
	NO4B7QqsWenIiQWCWXFDmXlS3WJJV1mNCAoW+6f4jkO7Kpb98xqiA70D0GDl8/sV
	C51Yir7MpXRx6lqtYaknBssvC6DeR3HJPS8Qi63fchwVYpRuYfZ5gke9RBIBcVae
	MnyZQ==
X-ME-Sender: <xms:6I12Z8-65pACsqD4ZvPgLYuqFOqB16gbdO6dhFiWjyw3M3Luiloh4A>
    <xme:6I12Z0ug3f60NymKMPagenhrsSXAyBkA2H12LqB4A-yLXyxGEwPAZZ4ohgqe92xzy
    MUUXM91XHf8LkFIAQ8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefvddggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofgggfgtfffkuffhvffofhgjsehtqhertdertdej
    necuhfhrohhmpeforghtvmhjucevvghplhcuoehmtggvphhlsegtvghplhdrvghuqeenuc
    ggtffrrghtthgvrhhnpeehjeffffetleefhfelgfefiedtvefggfeiudejleeugeekheeu
    vdetfeduffevhfenucffohhmrghinheptggvphhlohhvihdrtgiinecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgtvghplhestggvphhlrdgv
    uhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohephh
    honhhghihirdiihhgrohesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:6I12ZyD65GjDlJru_BkyBWT1oGtT_zuV6P3lRVDLOktx6f5_3bcYsw>
    <xmx:6I12Z8ermvwjnmqksIUmsXKEl7NxUXms2zRF94dKKDXhaxGKgxu1iQ>
    <xmx:6I12ZxOy560UQSEwkH_UvOlG4fIESTNm6KGa0cklAs-nfVFXcmfVTQ>
    <xmx:6I12Z2mADloObTyQR5e6DsgQGtnfsTLgMxJb5-RT6I9iSA3SD2lNOA>
    <xmx:6I12Z3YQABlv0vtfBquIIOczDtqMVhdX5xM-0G9ayIUa_E-rfCHMSO76>
Feedback-ID: i8c5e488c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 265E7B0006A; Thu,  2 Jan 2025 08:00:24 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 02 Jan 2025 14:00:23 +0100
Message-Id: <D6RLU4BY374I.GQY9MLMV1AZJ@cepl.eu>
Subject: Re: Change the grep command called by git with alternative tools,
 such as ug.
From: =?utf-8?q?Mat=C4=9Bj_Cepl?= <mcepl@cepl.eu>
To: "Hongyi Zhao" <hongyi.zhao@gmail.com>, "Git List" <git@vger.kernel.org>
X-Mailer: aerc 0.18.2
References: <CAGP6POJX9GFsNkgGd7o9Pr-tFoz0sgRk51vVG4P0Kn1DPZe+3Q@mail.gmail.com>
In-Reply-To: <CAGP6POJX9GFsNkgGd7o9Pr-tFoz0sgRk51vVG4P0Kn1DPZe+3Q@mail.gmail.com>

On Thu Jan 2, 2025 at 12:49 PM CET, Hongyi Zhao wrote:
> $ git grep -i jobflow
>
> I tried to replace grep with ug, but failed as follows:

AFAIK, git grep doesn=E2=80=99t use external grep(1) binary on its
own, but rather it uses its own (and slightly different)
algorithm. Certainly, calling git-ug (or git-rg) will do
absolutely nothing as long as you have no git-ug binary in your
$PATH.

Best,

Mat=C4=9Bj

--=20
http://matej.ceplovi.cz/blog/, @mcepl@en.osm.town
GPG Finger: 3C76 A027 CA45 AD70 98B5  BC1D 7920 5802 880B C9D8
=20
When God put a calling on your life, He already factored in your
stupidity.
  -- Unknown, mentioned in a sermon


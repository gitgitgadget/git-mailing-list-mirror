Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AE6374FF
	for <git@vger.kernel.org>; Sun, 15 Dec 2024 12:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734265640; cv=none; b=Yv21kLsW1W8TtOuZzbWkn1ib/TcCsdc/r/dlMZwyy3rdXcI+yUizp0CC7Jeo6jRoZOdxpFR1/i5gQPqGYMV2nqJflAdwrwG1S0/IZMdGbJ3KpfG5NOflp68NqtFONE4ReaIhGgZbHIxNQ2H49BBdBRiU2dDFKubvnPWgWn0VR60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734265640; c=relaxed/simple;
	bh=38P819n7VQotW2XuwqCwPXWLZoAwePTu0UhSWHpCxYU=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=h15RcoS5jqI4l++VTkYeVojbP3OHuTYr5lnaRppReqVGMSJrkv7t7YA6HyxhT2vVjAdA43CvAydEAzwWLOxGSj02yRyrZBL8IlGuRlgt4E2VrQTP/e0AqnggVyweFuinBkzXWWZRZR05Tf6+u+lBaRiizIKEh5JcjoTxSofdmPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=hvyZHTj7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IKOj32rU; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="hvyZHTj7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IKOj32rU"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DF28811400F3;
	Sun, 15 Dec 2024 07:27:16 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Sun, 15 Dec 2024 07:27:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1734265636;
	 x=1734352036; bh=38P819n7VQotW2XuwqCwPXWLZoAwePTu0UhSWHpCxYU=; b=
	hvyZHTj7SxS/b1vL0CGaZGbBCCi0J4tPrsMe6GIVM58oXbIKecwnDllfsQ9Z1517
	dpoxYQaaidq59snl7VLfJPvfXuZV8dsRFMOA8YVlBY6cpULbhsGB6Sr8zVFmFQt/
	LafLtFsv0AQkIwohZqwLp3g/CkZEYDocqs4QFTlJR7GRw1LnD5RC7u4T9Li92/a0
	TQmfYp0IV7u9dK7cNc75kvDrmuN0paPwrDQNB04yH00dtF72Rfw+8G6Xpoh5iPrX
	W1R9e1kz74wTahWrCC2c1KouhA4wDgyrD0vvPAZcAZOKLOhJqhBXuKnf8zqIOZDq
	8zIAsuaXN1wSdjKU/+JPZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1734265636; x=1734352036; bh=3
	8P819n7VQotW2XuwqCwPXWLZoAwePTu0UhSWHpCxYU=; b=IKOj32rUi5sIzw4bD
	8F2BYQGOzm2y+pvK5HKV7ypAy9cSSho+rWWhIt9dacI1u3fvJPVV8UMhdn62gXw3
	PrX3OBmxTY/0xh4KgHAeMMYcz9dlwDf0W6J8QX8RwbA+af4uj2cbOcmfKH3j4dPY
	ea3/eGQ9AAKANPbXjUpSshf+dQlyNJbN8SHzO7BuhMiN4rwGDRjiUdkTIhg5QZ2J
	7tCyRxtkpI0tzN4nU06DSzYfE3cE8nrwUZD9SCDRzwnc+fpzevhS60k9YDYTV/9E
	YMheQe6KU0KUW+SDyP19Bl7d8dtU8Olpvx0Qrir6fm9zK+xl5x2tce1wqamILV0W
	GQ3qQ==
X-ME-Sender: <xms:JMteZ8OOnHPlyxAUTYZTv2t5elREbQoBXY7ZXf9CB-q0_wqTUp5gfZY>
    <xme:JMteZy8Xpt8ZL18yj_C2A9DANqs6xKLxs8uz_ZhS_83yIoqPtUihuKzS2zKMP2Or2
    8dUy3ICYY0OIY75sw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrledugdeflecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepofggfffhvf
    fkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgr
    uhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmh
    grihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtgfffteetudelhfefkeehtefggeef
    jeevieekfeefieekkefhveeiledtkefgueenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehf
    rghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtoheptggvmheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:JMteZzRxQItxO3pgaH2O6vni5_A2rY1ObL-VIYBiVjajkwUNkAlucQ>
    <xmx:JMteZ0tX-Oi_eDwuub7WuuE161mhSkGPolfFWcOq6ZnxfvHZn1m0XA>
    <xmx:JMteZ0dRkg-X6UARTPt_S0Qk1XLRnjkT5pJ5hJlL5iKFu890HnH2uA>
    <xmx:JMteZ40BrRar7c9uzVPK9HpPG-28CmhCARuwEbmqg98cSbD9Gk6YlA>
    <xmx:JMteZwHhaJROxnyW52uQ-VFlnlS-8FH3NFFQJNHWxJVk0_o0oaO8KzPC>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B14BE780068; Sun, 15 Dec 2024 07:27:16 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 15 Dec 2024 13:26:56 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Carlos Maiolino" <cem@kernel.org>, git@vger.kernel.org
Message-Id: <b1cf4f03-1716-49fe-89ed-333c12ba4efe@app.fastmail.com>
In-Reply-To: 
 <hx6q4liyd7udyezlqy2fzanxlicu24imtdqielig622sdqz2wc@lxa4ybnzyjs5>
References: <hx6q4liyd7udyezlqy2fzanxlicu24imtdqielig622sdqz2wc@lxa4ybnzyjs5>
Subject: Re: [Bug report] signingKey beying bypassed
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024, at 21:23, Carlos Maiolino wrote:
> P.S. I'm not subscribed to the list, so, please Cc me on any reply.

That=E2=80=99s the list policy.

--=20
Kristoffer Haugsbakk


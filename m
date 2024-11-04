Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3911D5CE7
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 22:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730758728; cv=none; b=kcmUK8nqXZ1XftgtTuEozEuDjJWb4qB29dCX4Q39qo1tVLcszNv4WRb6Ca3Y7djBKWU9ZQPAT+UphVK/DlgcBSEoPbcR2SI1Tkg0qlyaPk2+jYYAuJhlC7B/qxIk40Sf4BQCblm8DCBmAgtwvuzFq8G0sodJNmuOrvPqCX7Dr5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730758728; c=relaxed/simple;
	bh=3l+R/qDdz932oOWZfdhctdGZBspQCoW0DpedAyv/UB8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=SkDkbPhlrokWTBgZjlX4uJxasbQfqLCKvinWGLr7rPWYJeIZHHGzbxrkWXi2BEf2Kr7Ad9PuHaUapB+rN2n4LIW71AxaHq6Ot3gyB5s1tuGibR7/KCj7Yl7LECZKTbDUfBz/GFSur4atOckW1THsWV2J2WjlMCU6FJk6NkSOBqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=KPWLcnyA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KPuJZw3Q; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="KPWLcnyA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KPuJZw3Q"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 03C0113801DC;
	Mon,  4 Nov 2024 17:18:46 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Mon, 04 Nov 2024 17:18:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1730758725;
	 x=1730845125; bh=mrpPnkPxPzW9D6jJUAwEzuT1JG5Hgnj0vIYWf40wAgw=; b=
	KPWLcnyA1/29e1vFlViQJq1TZuxRqx/WU8N0iH32G2+EQk5SYt6ZC+qiae+nWRWs
	QnNJaqvbpiQ9f5XwT3KPhtvYhSrqJyH3W4c/+pMqPalhoKP0DIQdvxc/Na/amly0
	5DT1GAoQJihcsGJaXJ0p8vP0ttH/Wm+mtW16NQldN/pJYW5zuzU1dVbY02Ck2fE9
	JWQ56VNqVY5qI0XVS+IQXlbEbK07uiJjGviOABnAKBdftWO0Q2x779JDxVrYk8a2
	MpLKnZlYRTDLc8gDUOh6OUtYkmF9BL7JR8+dOMVpZqPVwbZkEnCkEW+y/6RbeGj1
	MZ2c8NR65rFQpbu+2SjJ6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730758725; x=
	1730845125; bh=mrpPnkPxPzW9D6jJUAwEzuT1JG5Hgnj0vIYWf40wAgw=; b=K
	PuJZw3Q9jw4+oS3ZgZX0v1BXqC60sI2KZT4+tbRqNOXD7h2fxfMwTDSo3MaKuedb
	lrjTMw1RPa1781Z58XcZte9n0oTC/Dx2pO/e0sodaWJZAP55molCM/dm03cwxxVK
	C0ttqQJpP6ik2sPnXGzLn5YlERGLkAKy8gWQUQJmKz5ZKDOgmGaSqpw07Px2wFUc
	BM5NJggofkUhrlA0WKE4LF+OdHQE0wN7HCQYs0I2vYxgfGoVUxuP/5FpbLtgH7rx
	H+mYgD9MAhtP65xPSdUxsMiiAMvoIc1+wPMQLEZuhMHkYBt7kJyjdSckvU/8QvSB
	ASnYBr/xIb+mHGoizU8wA==
X-ME-Sender: <xms:REgpZ9ddATpPV5ZSkvpABF2vetU9RadVxBEwicPjfEG6A_IA4tRaLaQ>
    <xme:REgpZ7M6DinQqn6KA6uL2mStKahx2uaU0_mgkhenlcWPdUV1jmGcnV_a1uyKSncCT
    UQOg4tH2xGJtVHZYw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeliedgudehkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrih
    hsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffr
    rghtthgvrhhnpedtiefggeejgeejhfehuedvgeejkeelgeduudekleejkedtveejgfeigf
    efkedugfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnh
    gspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhlthho
    sghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtoh
    hmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehmvgesthhtrgihlhho
    rhhrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:REgpZ2goMJJ0VSt25UMcvgCwRubwoht04iSgEgIqH9DN8zaLmw8Czw>
    <xmx:REgpZ28QkjfWt5n5DnQJ2-kBshF04mi_BmZ6KMW4HRtzKEqrXyEhKw>
    <xmx:REgpZ5t9jIjAwFLwpuQF7a7J7pHGn2Y5BA0h4eyErpgUE75xN3dX4w>
    <xmx:REgpZ1FZdRJwiHTtpPdZQc2-bV4szdHPhW0GyOEwd66qDvLkZF9o2w>
    <xmx:RUgpZzKrzoqnCikjQoGgup9SCZQBEnsMzIGngqkhMtTtZWlOOdK9neWc>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C1004780068; Mon,  4 Nov 2024 17:18:44 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 04 Nov 2024 23:18:23 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Justin Tobler" <jltobler@gmail.com>, "Patrick Steinhardt" <ps@pks.im>
Cc: git@vger.kernel.org, "Taylor Blau" <me@ttaylorr.com>,
 "Toon Claes" <toon@iotcl.com>
Message-Id: <e007decf-0156-44b2-bf76-66a91593d233@app.fastmail.com>
In-Reply-To: 
 <qxtstkkch5toz6t7jdknwkdzrlkfu3b7gtw3wpg2iuqsmliqlq@w2qz65ujwj4r>
References: <cover.1728624670.git.ps@pks.im> <cover.1729502823.git.ps@pks.im>
 <89b66411354437a1e3a97751f185889dffb84126.1729502824.git.ps@pks.im>
 <qxtstkkch5toz6t7jdknwkdzrlkfu3b7gtw3wpg2iuqsmliqlq@w2qz65ujwj4r>
Subject: Re: [PATCH v2 01/22] builtin/ls-remote: plug leaking server options
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024, at 23:10, Justin Tobler wrote:
> On 24/10/21 11:28AM, Patrick Steinhardt wrote:
>> The server options populated via `OPT_STRING_LIST()` is never cleared,
>
> s/is/are/

I guess =E2=80=9Cis=E2=80=9D was chosen because =E2=80=9Cthe list is=E2=80=
=9D.

   The [list] populated via `OPT_STRING_LIST()` is never cleared,

--=20
Kristoffer Haugsbakk

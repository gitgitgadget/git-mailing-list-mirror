Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27590225A3B
	for <git@vger.kernel.org>; Sun, 28 Sep 2025 15:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759074382; cv=none; b=kpJw9IBj/AhZicmgU5Aswb4H1hYOaY/C4HSzkAtw/rTx2iQbr3S3G93QNiMvLBmjLgSNPZQvmsBsnWHTxsNKRBrz1EKrKZ9otOpn4ehlsIiEREuzL7Nk8PvQVVsHCHFiWTBVK5xGuhqsLzpz4a6ue5KppS2jlefZIM27kcbDLvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759074382; c=relaxed/simple;
	bh=oJ+fT3cXRbnBcQQG+W+lSohDq7Fs+vje5jOCVVKb5Io=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=PZfGGVInWYvdf/di3vxqRD27lytGOQ77yRymgcZUh/G/JX6OqsDsuQgvxKZdYJcRzWA5EHz3Y/CBbOJq1C3uxvahU5q+yDMgnNIhN6ASuVRt2o5OfQc3BwhaBLmN8jMXql/ANzXvFxJ9mwQpw7QPRHjUpD2T28ciEPXMry4Dbw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=fQPYHTJ4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NoYB29n1; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="fQPYHTJ4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NoYB29n1"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 45D5A1D00039;
	Sun, 28 Sep 2025 11:46:19 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Sun, 28 Sep 2025 11:46:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759074379;
	 x=1759160779; bh=oJ+fT3cXRbnBcQQG+W+lSohDq7Fs+vje5jOCVVKb5Io=; b=
	fQPYHTJ4OPuy5/erGys2MrNF9XnHK49IAI/9AUyRDg52MxtQxHYn1xWrnwwX6sLh
	u15XUsgDcB0Q10T2NEel0y+0U0jHa6ptfkSUlRhuc13GLyL7TYCfvGwV7kUq47CL
	RcbgVRebPWtze8JlgcQhtx1j/b+kSDpRY1eHzxKVm3yr77GJ281dFQVQ8P5moFuw
	V2w3oj0QwTKAg3xbo6zOtD02NmF3Smc7QpmKhu0NwDoBlkJMaYHCoBiXypGJj5+g
	VyCL8Uum8xeEHGmsHncsefWloF+ytaOnXG2mRuyBLId3SBA9EStBvrdSjYYeRZPS
	3Z9aYjYBcAuIKKpO41ThVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1759074379; x=1759160779; bh=o
	J+fT3cXRbnBcQQG+W+lSohDq7Fs+vje5jOCVVKb5Io=; b=NoYB29n1sfNXJsXsJ
	2CyqAquH8ywrpa2K2Rqz4XK7wkzsyclbFdOV6/3NiDkpz8sTcqR/1iUFdxtv6q23
	jqXslmwx5h6NkgphV7SgI3yVGfGhbHp3I2XYTE8HB+vmxyeeKRWndRa5fhzbxvzQ
	eRCuWdNJiaxCYoUkjD2IQdJOUO9yglw0QTeECKPBg53RgimM349epIMWJInrdE08
	KvwDXQ1ia6vIiASzwCVhmFuaBUpRCQUa2OLOq0QNcHpzVTY2AFmOt97Me08U00Wf
	btCbwcw1iTEK/Kd8ekpQk89/3GLtY0+Pne01Z/vUoYJkos0GI5jmwwya/QKLxnwq
	9VD3g==
X-ME-Sender: <xms:SljZaF4TFQj55kBfYTSVqlYWY7uP3RVrLAa_AYiwJcfdbgE_S9t6FRo>
    <xme:SljZaNuGlpqY4wDJ_08RY1c6ULppf4gRsHS0AUWJHIoMm111rFfhcgPdIqZN2QYlU
    kP_h6cU2KNSFGIRYbSUQ5S6Y0kZK9ZT3-lWSVnxy1nvVGIM3W_WxOA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejheehvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepofggfffhvffkjghfufgtgfesthejredtre
    dttdenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhr
    ihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtf
    frrghtthgvrhhnpedvieegtdfgteeghfffteetleduveehteefkeffheehfeeihedukeev
    leevfffhjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdp
    nhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhrih
    hsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:SljZaAkOYzlVDcqqhkBDkjHOkIGnKGQRQGNSZR3l2C8M_l1T7jRBUw>
    <xmx:SljZaNxY71Nv9lESKltwwPD9E_zwFn-CjCJmZbvBNCDpNJQ3Xvw1WQ>
    <xmx:SljZaGP7VGPKBgEvAZy8LpADtaAZZWbEJn87uxHZJRo6k1UWw7Mp7w>
    <xmx:SljZaJTm5dvGHV41Cj5zL7iC0oNDVYiO2z3qqK7rMmeWCdQLlePozA>
    <xmx:S1jZaMcTOXBiXoUrdJQxjBrFStddxBaE7rIn_qOoHYkVB1EDG6eONku9>
Feedback-ID: i83a1424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C67561EA0068; Sun, 28 Sep 2025 11:46:18 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AahvWzfxGFoF
Date: Sun, 28 Sep 2025 17:45:54 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
 git@vger.kernel.org
Message-Id: <a87b3e69-20a1-46bd-8d22-ed78145cc59c@app.fastmail.com>
In-Reply-To: <0520e8f9caf.1759067095.git.code@khaugsbakk.name>
References: <0520e8f9caf.1759067095.git.code@khaugsbakk.name>
Subject: Re: [PATCH] doc: patch-id: fix accidental literal blocks
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, Sep 28, 2025:
> continuation (+) for the elements following the first paragraph if you
> want to be guaranteed a predictable output

Missing period.

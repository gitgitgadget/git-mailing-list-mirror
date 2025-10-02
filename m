Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE9D30F956
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 11:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759403477; cv=none; b=JffjFY3njS6OF4lXyXbG4ChGpywNeqgRc95O3dL8N9+RLgVqoDQawl6JQiSE/FrWSnzyNpUgLMq6ketcti+C2rrHyYUgAXRZSQTQ5FwjVFpmuAu8foauynEI0/1vfjEa1S9+hiBmx5ott/jmlLZyxLEsVxNVteCOsih9fKInksw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759403477; c=relaxed/simple;
	bh=D9SXgmO/k+0N/v0toDGb2LNlqcSbIh3koJXH/4hOFs0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=dtXyQ/TQ2JvwDpC29jiDiWnwe0Rv4cYGOxGCHHwRpoygWwUVNFs6rtuL4QO7wA/DqFLwoCgjdcqliUdVHHxkPAaEHM7ic/RXMl9OUsJgV8XNPmy2YsT/s+O3zAoe/7MQQrEMHCVJSMwjR3Z93vuaNr0fRnEZhJuYtIlqqiWnEr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=RV/84ngl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aO0rJRt+; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="RV/84ngl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aO0rJRt+"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 68DE51D00101;
	Thu,  2 Oct 2025 07:11:14 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Thu, 02 Oct 2025 07:11:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759403474;
	 x=1759489874; bh=D9SXgmO/k+0N/v0toDGb2LNlqcSbIh3koJXH/4hOFs0=; b=
	RV/84nglUx2nQSdaadkBNpvceOP6vo86kN6ZSjFrOA7BYyd+9e8wcsnXt30n65+A
	RpDwHm5XOxYClPpNVBo59t97NdshcLMaTEdmkPj2XhrG986zkEXSWKLLONXDTqA1
	adkeyQod/7uRjnPBxchuc8+kMGVJvgRs4srzY7NL0EZIA1iF1JNS/lZxiji91mw7
	LC5DwW8accx/Iahcs9+eob+4RDfU+ZRT8KJWhAcQVangUPHm5tBYwK1hWNWElCrR
	8cdako9I/ebvy9HgbtjIiJh6LW/Q0LVhe+fJ6NgqYkz5dmun2ADZoFtSo6kRyb3H
	VoZ076QyrTASnJ/0VDTJUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759403474; x=
	1759489874; bh=D9SXgmO/k+0N/v0toDGb2LNlqcSbIh3koJXH/4hOFs0=; b=a
	O0rJRt++XKKk+2EIhuWUHRcWO0Jtg6O/fFQ5CAPaueQC0FqArJdTn4PW3CYXbY9E
	6huMXP3Hxo6SdDo1OsKXaQh5b1f+D5h+K7c157D/MgSjrSbILwjsoULW2ElbGkaV
	CU0v5pu8MB4xMVbMY+9mXrSvPN0aryfow6UtD1BrPFYg78ASaKZHRhPJTn1kPZxO
	nuNEr9NEDWS0O53fPiwWp1F8cVABndqOvgV/6VIwB1uZs9vzlFBQIS4etR94uDmv
	L2QVps1NYfZ6ml5getpNufVSGEhmzjMrGbFo/SlVgwUQl25ERHSf66AtqJ25qn1+
	xYGgCm5+kWLm4rQS0Amew==
X-ME-Sender: <xms:0l3eaP0jcVc-uxxcZPJT5NZ0RcAEMnVWJz9NFYJdDkEO9jpkg0LpwAM>
    <xme:0l3eaI50TFDBd6j7Z8e1tFmdkVith9mlMODXa32VBUdRWFA6BquuUAEWEfRQaFkC8
    _uuwnLEnX7DqI5CO1gDwiUjVhK9ihj0LMBQpThuuNrM3ibmLOUg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekheekiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtiefggeejgeej
    hfehuedvgeejkeelgeduudekleejkedtveejgfeigfefkedugfenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepfedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghp
    thhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:0l3eaKyobp1ylymR1mEl7TgbBAy5g-Oyt8UauKPq5qmk-MtdxSLxsQ>
    <xmx:0l3eaODcAgONMMmQbidO9GU6VOeZuAjSZHDNpHMV7-XyJE273FedBg>
    <xmx:0l3eaPbGiiPJuU-P0wmyIgSPev-WGkuTolQ7YIN46aAa8gzsf4j4cw>
    <xmx:0l3eaOg7MZrjn3R03mUAm-gtpe6JWw5fM8cE4FPpSFsdbesOwr5eDA>
    <xmx:0l3eaLUMIPcZbzN3wpzlicvZGdQVdkR31OHQ0xgSey8Va0VJYxx1wC5e>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E772F1EA0068; Thu,  2 Oct 2025 07:11:13 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AzPR5cvH7hnZ
Date: Thu, 02 Oct 2025 13:10:53 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>, git@vger.kernel.org
Cc: "Toon Claes" <toon@iotcl.com>
Message-Id: <50aa008e-1cbf-4e77-8e51-6f2c32b6c12a@app.fastmail.com>
In-Reply-To: 
 <20251002-pks-gitlab-ci-windows-improvements-v1-5-6a8b6b45d728@pks.im>
References: 
 <20251002-pks-gitlab-ci-windows-improvements-v1-0-6a8b6b45d728@pks.im>
 <20251002-pks-gitlab-ci-windows-improvements-v1-5-6a8b6b45d728@pks.im>
Subject: Re: [PATCH 5/5] t8020: fix test failure due to indeterministic tag sorting
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025, at 13:04, Patrick Steinhardt wrote:
> [snip]
>
> But why do both of these tags point to the same commit? "km2" really is
> supposed to be a merge, but due to the way the test is constructed the
> merge turns into a fast-forward merge. Which means that the resulting
> does not even contain a criss-cross merge in the first place! A quick

=E2=80=9Cthe resulting <noun>=E2=80=9D

By the way these intro (paragraph) sentences like =E2=80=9CBut why do=E2=
=80=9D and=20
=E2=80=9CAnd it is=E2=80=9D really help connect the whole narrative in t=
he message. =20
I=E2=80=99ve noticed the same thing on some other recent commits/patches.

> test though shows that the test indeed triggers the bug, so the initial
> analysis that the behaviour is triggered by such merges must be wrong.
>
>[snip]

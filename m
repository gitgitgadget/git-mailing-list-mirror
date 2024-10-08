Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53038215023
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 20:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728420303; cv=none; b=uFqEcHgEMvOOc5aX8+x2M1EPXUdbaGpWA9BhCFu2dZ7XBrEHoosiNUYPRxHIjvvBbvqgSIHYlhp54oOs5Mu/eZFG3mf51fcD4ZRId74JmI8zOsB0ETN/10apbADoeQWHGSR00GWE0UjvbBypXvne0FEV3Rkxi0LiZceLNvznKtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728420303; c=relaxed/simple;
	bh=+lII8a/3dwGcZl5mgLPkQKD0payid77pw7clMogRmOQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=j5J/z/7jL6ed7jv7t2bxBEoVbanCu06iiaLYm1dPOgeUwlMZzG0mOjZK6hg9Tu7SEM3aVqCxqhcRD2zMhl7AdCkJNAiu09TV2z4hQCXYrsTRsRuYhArV3o4ObRkaitQu8lVV7odmSulKto+2CbQB4Y9+qIfFWyIi0biWiEg8RMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=lvY9FxdA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KOffI2lG; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="lvY9FxdA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KOffI2lG"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5EDC411401CF;
	Tue,  8 Oct 2024 16:45:00 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Tue, 08 Oct 2024 16:45:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1728420300;
	 x=1728506700; bh=SQ5WQI/KgU/oXqkAzbScZR42Wsxh/XjaE0MSaviZ83M=; b=
	lvY9FxdAvAyg5xJ8jpCzH4Cd3BnfOiLkfFlqiXVEgw7Ut/eGvWRRYVjArhNIirJT
	NSC1ZRSIfDDI8Zet5G3zB9AMS/OngybtMxt9ro9OgVfGpUXLblzQ27N/EigSwarA
	ej0ylSjao2ZI/R73x7fmlBeBmVS6NcCGdQTKqyrNHnA3gfopnjqWK7+yMFGYlhD1
	44xdgVDqJhH9DQSfGoWhfziu7LpfDcQ//5wDTerbKU5HvDthTNhXay+1BZ9WmAlY
	+HUOK3vcTbVE+pRNBCew8ayEil77umdl/FNStzxoulArLm5c2UksR/pbd35VPOtG
	A+GKCJOtgIyblOIOmxoneg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728420300; x=
	1728506700; bh=SQ5WQI/KgU/oXqkAzbScZR42Wsxh/XjaE0MSaviZ83M=; b=K
	OffI2lGfAFzqFJ2aEQPrP0j0Ei8X6Bqw8CzAyLaQQdMQj64glxuRXLqoE0BJze2A
	ZMxgTtT437ZEBqE3d2b7eQlHJHbr8ziTREErTQYEl1RN76G1W2iCy54JBG/71WBm
	4s9+TbmQMO8VCC+E0nlyoWBk9zei0h03eMrsMFWmMX3NAaUmBOubcK3KKSigzu3w
	iQrE5zEPT4Batb6b4SCWMS0K+UNFFExzAWcKknZisIIiHzMyIXWl9eucNXmibsOc
	N3v6b+FAqmUoYmvH2glN6BQFCbEQrFk6bT08IDVS2zh3D9/RT4ohFE1NuwLzR5xM
	OdR+s1acLZxw1X8HXk5ew==
X-ME-Sender: <xms:zJkFZ2lnCWsRi8PWyjCvInJqTVIbTA42G2-q7pZpSwFcbCwKCkk7akI>
    <xme:zJkFZ915q7ALtNLkGH9eHtzu5eHQlSUDYpVOVAsW2lwiVfXLLa0Wjggj6K8EMk8Qt
    0-hHt4iwg8rKfrwlQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefuddgudehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrih
    hsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffr
    rghtthgvrhhnpedtiefggeejgeejhfehuedvgeejkeelgeduudekleejkedtveejgfeigf
    efkedugfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnh
    gspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgvfihr
    vghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:zJkFZ0rJmz1k6O3WsFeYB3uh244R2AJynbMs75ihkkSg0VhQk14SBw>
    <xmx:zJkFZ6mcSDMOMTgESjKP9PCSIuTPhkLdP7vjMMKy0PxBIbFI8NGd_A>
    <xmx:zJkFZ01OukhUkvOSpg6C2f20J63ZxNEROMBU_lbUTXpM08ibNxgllg>
    <xmx:zJkFZxshj8-zvUYVLviREd9cgqnIUQImiXuSdlmrMdQeHSZs7_2Rzg>
    <xmx:zJkFZxxvkhrZ4nqWSx268f3pT7c1Jo54vbgC7qzf_EuFww3BLFtORkVA>
Feedback-ID: i83a1424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0E80E780068; Tue,  8 Oct 2024 16:44:59 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 08 Oct 2024 22:44:39 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org, "Eric Sunshine" <sunshine@sunshineco.com>,
 "Elijah Newren" <newren@gmail.com>
Message-Id: <eb4ced86-03af-41c0-85c6-0f7df2819190@app.fastmail.com>
In-Reply-To: <xmqqo73uz5qg.fsf@gitster.g>
References: <cover.1728298931.git.code@khaugsbakk.name>
 <cover.1728413450.git.code@khaugsbakk.name>
 <b1ca5cae76845f84147d385cc5ff47f219cd471e.1728413450.git.code@khaugsbakk.name>
 <xmqqo73uz5qg.fsf@gitster.g>
Subject: Re: [PATCH v2 1/2] doc: merge-tree: provide a commit message
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024, at 22:42, Junio C Hamano wrote:
> The shell should know, after seeing $FILE_WITH_COMMIT_MESSAGE and
> encountering the end of line, that you haven't completed telling
> what you started telling it.  Do you need " \" at the end of the
> line?

Heh, I=E2=80=99m not sure.  I=E2=80=99ll delete it if I don=E2=80=99t.

> I know that it was suggested to use a file with message, and I agree
> with the suggestion, but then I wonder if we want to be more
> complete and show that a file gets prepared in the example to avoid
> making readers wonder where $FILE_WITH_COMMIT_MESSAGE comes from?

Sure thing

Thanks :)

--=20
  Kristoffer Haugsbakk
  kristofferhaugsbakk@fastmail.com

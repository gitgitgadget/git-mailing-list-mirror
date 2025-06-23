Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809B725E82E
	for <git@vger.kernel.org>; Mon, 23 Jun 2025 16:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750696000; cv=none; b=Z3PuCzI+h9fZFpPeqRK0IfEryLFA8QyYLV/lN1TWXzUqtrl5k1njRuRifStlP3zU6pMQRvFVNdFVYkMraQ7XFdpAO5LoLY60owh3mJu6l6bw1AWSV9ndw2km4diDBnixWGwlQWmqqKjpWmnAXUG3fSzc1gvwPYik4nT59v0bSxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750696000; c=relaxed/simple;
	bh=DAkbTbAiPjBYDSIUW8+lAYGjoZpBuKGeTbMW53QQQ4M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gC8m4Sn9gNIt294cv7aromULTanxqt/Jg+8AQUnlw+4rElTYl3KFnU0aykl/nWJGtd4TwCdHZ0JK1E2FZKC+PcUVp0lEivFBj1CKfj0AOwUg09FOKCIrWR3hXwNByswu0Bgo/e2VwrZPi9aZk0QwjECJiEr00IX4loA852XXijk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=eQraDMJR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QHke8A2f; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="eQraDMJR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QHke8A2f"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 8B1FD1380440;
	Mon, 23 Jun 2025 12:26:37 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Mon, 23 Jun 2025 12:26:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1750695997; x=1750782397; bh=4OtRFH197a
	V/hZsX9DZDEA1AvNzuIjK3KF9GFMkc+so=; b=eQraDMJRJbSw6OTYL2l30E3i0E
	WgutoC9cycDUOqq94A04Keu+sSlh93L6bwiG3ja8hjxD8JntgvQttsAWd9592o/e
	DML7c6y3m5gpu6UOzmqkXdG8xfGAJ7K6efAEa32ncI2UC4UCLSuXXLjLC6eNt9Nj
	BL0/tKh0WrAJMcH+1XSry3DToF6Oo7f9CwHWElD61cvcHvZF03SZyOCpCbTuZNvJ
	8psf7p+1pduuGjmfd3dqaJQU+rzdx7FFOaUvemaDl5rp66RWMh2IvCP7zFoyNxq0
	qVMII6XOedFwAHAhhfst1UYdepS3HMDYNJTdVH4SAppcTiJnSgjXdGLkYiiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750695997; x=1750782397; bh=4OtRFH197aV/hZsX9DZDEA1AvNzuIjK3KF9
	GFMkc+so=; b=QHke8A2f40Nxf5fPc3dtJoVEzHwLsQPfESfq+HxRu7WRvIlnkSZ
	TtWtm68sp6bRXSAsUk48g63wm2X/r6G/hRiNChI/uFhNPvahg4w8iU9U2rzqJgee
	lmK6fcmZ/3+MvnRLS66iuMujpOgiFh3X6A6kEe1zfzZuryC4iWlGzqYqXQn9wwc3
	5XL+HDZY3NqgAmnAd261ThvSJBmidUkULjTd2PGV6ehiwWVkUUGhdW946gfzI3WO
	ox6IeJlQyvNgOc6W/PmdqAIly9iFWa0KrEjA8yCpTQfk6eiiy9UO69QFsyBsiAIU
	joZP11VawsIjEBpILNgEZm9AWdtc+vNFivw==
X-ME-Sender: <xms:PYBZaASz1XmiNeZFuoRXPRCV6kyKxnnk6WUwcULpxXnPLwr-AL1rfQ>
    <xme:PYBZaNzseKbgVJazdIeo8qP7s-DFXRSczcni-K2nFXxub_9VBmOQwQ1kL_aAq8ywy
    S0oWcmKlC6hiKhVNQ>
X-ME-Received: <xmr:PYBZaN3ZeqDAqw1RjMxtmbWJAow4CR0nvjwoAdp28VnjLrVhK0W3ayvi489B2OCPdO3KZdyMltb_3B1VTC70z7U0qAho8ij6j6ReNjA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddujeehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehp
    shesphhkshdrihhmpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:PYBZaEC9qnaHp7Ri0YO3AhfAjpgD-86TiEqtsBj8poCHzqD_iEoflw>
    <xmx:PYBZaJjY_R9apCp7ISbKq4QUMCZdiyWyEzGmx6ztFQLpmuAeaxggcQ>
    <xmx:PYBZaApltKzOw0cS_3W4HvsJjXsDMHxKEZEwO8UTc0_Ztm9H-GZ8Ug>
    <xmx:PYBZaMiSa9-6gOYAg-itx6u7dgBEd7SaKfaTZgVRi-NHFyCKPEAv7g>
    <xmx:PYBZaMrJxJDLkSvH6KdsXPc_Ms993QujKpF_tc_oOlw9iUmaMC_NLN2c>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Jun 2025 12:26:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  =?utf-8?Q?Ren?=
 =?utf-8?Q?=C3=A9?= Scharfe
 <l.s.r@web.de>
Subject: Re: .clang-format: how useful, how often used, and how well
 maintained?
In-Reply-To: <CAOLa=ZSuEAwj==9+B-nYikyQtOxREf8ZEfJ9L_YxU8yU0ro-zA@mail.gmail.com>
	(Karthik Nayak's message of "Mon, 23 Jun 2025 03:46:18 -0500")
References: <xmqqmsa3adpw.fsf@gitster.g>
	<CAOLa=ZSuEAwj==9+B-nYikyQtOxREf8ZEfJ9L_YxU8yU0ro-zA@mail.gmail.com>
Date: Mon, 23 Jun 2025 09:26:35 -0700
Message-ID: <xmqq34bq77b8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

>> For that, there are a few things we'd probably need to do:
>>
>>  - Improve our tooling so that the develper can check a range of
>>    commits they made before running format-patch, and other
>>    situations.
>>
>>  - Improve .clang-format rules to reduce false positives.
>>
>
> I think the biggest issue for this is around line wrapping, I'm
> considering just removing it from the '.clang-format'. Perhaps we could
> add it to our '.editorconfig'?

I would not stop others from trying to improve the rules in such a
way that only an overly long lines (like >120 columns) are folded to
reasonable length (line ~72 columns) without doing anything else
(like not concatenating adjacent lines only because the result would
be shorter than 80 columns), but if it is more involved than we can
manage, removing it from .clang-format so that "make style" would
not use would be the best (or "the least bad") approach.

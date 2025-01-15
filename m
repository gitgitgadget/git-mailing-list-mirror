Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0851419CC2A
	for <git@vger.kernel.org>; Wed, 15 Jan 2025 22:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736980297; cv=none; b=aosAlYrpqD7MCxif6wHeWe8EWSavgd3FA2ZiMNo+G8+dYhy6MPT/2U30dB3LFi/qzT18kpF75Ev4nFj0ise/pON+g3UudCeguVcZkzeiHok0MFRZlwn3RnEi11bxzsNsBB8b8ACWr0ylrfEfDSoVUKE+TFpFK3v9YHCNWprnS94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736980297; c=relaxed/simple;
	bh=naN7rbobDVB1lh875+neKLRU+UHf4C+yiZXP3qxFsAw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XMtokIHRV9r/3ln+CDn1wvNYsPStL8mvMGMVLFH0HUfSV2wzX3pRmEbTAmeIxcvSUOzZodIwUNSUbo7UbGrFwQVMI/4cdjGAnArZjIU0blIDailImdbXUN/fBiwqw0u9ynhxDftKwf2dmFxD9FZlu9uvDKwjCaSY6KaQLKmGkII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LPUwFXOr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fnagQzlP; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LPUwFXOr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fnagQzlP"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D5DE82540189;
	Wed, 15 Jan 2025 17:31:32 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 15 Jan 2025 17:31:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736980292; x=1737066692; bh=Vy7elfW7fn
	vTGTzU9yz53In0JbfRMTWwsfdP37lXPd0=; b=LPUwFXOrCpdg1CPpJpc4OWoF8u
	K2mD3eUC7dmyA5opwwWh4On6Bg9dF645PzqPbspAUWrCqXg8TsgQmwsFrLWYSDrn
	IJrN9xiYvG2ba9zeLVwtPO5U5r++N3yA06DwhWyfE1v6dtRjmxfF7V5XUEg3Dm6s
	sXfNoQtlqtDALoOMAQ+gAK7iyLRz/qjdsoGQUPei/g8eJHQMaGoPhron5MtihlSn
	ef3L+dRu2mNvawyoEnOCzLhhrr6oYy1r+uA1T0RsW5Y2ewHuOoq7tVMCLieK90WE
	8sY1eDTYdgiXiZAFdCDxTVoR4834nIpjLgqF1boruwJEKIE/r6x/tAHcUWuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736980292; x=1737066692; bh=Vy7elfW7fnvTGTzU9yz53In0JbfRMTWwsfd
	P37lXPd0=; b=fnagQzlPloBJS4NrYyraOb/4Ys/rIloCbuhpQYye573FHZbW5Al
	RZN8pw5vGGiXGY2wzHtR7kmo5Ikpmoxk7G6qyYwDV4u7B5FyC/NZNwpRSqVNwoDN
	TbJPNyW0F4k9MtzQ2k6mKLVKAbddn1Cu3HQIv2nXq02WW3ZynZ5s9ktVhwZ698al
	i6oHZwZOq1wghbRYLTT/CH2ieOncYdsKubUqf2el/xoGcVnnuCN4NkwCrj3U8Vr1
	uPemoo/jwtMiuHwLeUiNvNAT6nWuLT90K7620+eOLzBsqO+P228q0T0/GYPCsssL
	wV8LEqwEGXEu72m0S11yu7GaJkogb0OfKTw==
X-ME-Sender: <xms:RDeIZ99lzgz5s4U1EP6pfnQMJ-aT9LKcz7nJZtvFS-biZ7MlToHM8A>
    <xme:RDeIZxvW8Xay9l0qqtnurpDh6gWswdR0jUjZS-si1chXHMCOHEb0qAaUTYH1rXbOj
    UpHfSpafrwxS9X04A>
X-ME-Received: <xmr:RDeIZ7DDmK3l04P-OWG1zqGGza_oq5m4sKxjQ59mjlK7kzjta-tlUcoqM3hon79nhmqGQNyIZJpU48ceoBaJDQsBnrMnNxhgYCB7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehledgudefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtvggrughmoh
    hnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheptggrlhhvihhnfigrnhesghhoohhglhgvrdgtohhmpdhrtg
    hpthhtohepnhgrshgrmhhufhhfihhnsehgohhoghhlvgdrtghomhdprhgtphhtthhopegv
    mhhrrghsshesghhoohhglhgvrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestghruh
    hsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepmhhhsehglhgrnhguihhu
    mhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepshhunhhshh
    hinhgvsehsuhhnshhhihhnvggtohdrtghomh
X-ME-Proxy: <xmx:RDeIZxfe_nTb9QfnFUQ9oKz9crRIx_hFSqBW1vTwOXyWqyuH9fdsyw>
    <xmx:RDeIZyP-hLfhTiSts5fBQUlIMjgRcAwBDU1AnEzEaQhlYmkR9YAMtQ>
    <xmx:RDeIZzlDHsPxlbKPm8RUbage4I9H9BwwEZicbUqaI2A7730AE7NtYw>
    <xmx:RDeIZ8tmcR1rRcrKwiXMNETRiKTHqYvYwpL2Ak_seXpVm7hm6xJvwg>
    <xmx:RDeIZ-mvQLcFxG8VhzNtoTewBFDdspStBKL_R1kw0DzdFK0cpUOxyIa_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jan 2025 17:31:31 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org,  calvinwan@google.com,  nasamuffin@google.com,
  emrass@google.com,  sandals@crustytoothpaste.net,  mh@glandium.org,
  ps@pks.im,  sunshine@sunshineco.com,  phillip.wood123@gmail.com,
  allred.sean@gmail.com
Subject: Re: [PATCH v6 0/5] Introduce libgit-rs, a Rust wrapper around libgit.a
In-Reply-To: <cover.1736971328.git.steadmon@google.com> (Josh Steadmon's
	message of "Wed, 15 Jan 2025 12:05:39 -0800")
References: <cover.1723054623.git.steadmon@google.com>
	<cover.1736971328.git.steadmon@google.com>
Date: Wed, 15 Jan 2025 14:31:30 -0800
Message-ID: <xmqqwmevwvy5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Josh Steadmon <steadmon@google.com> writes:

> Apologies for the long delay on V6; I am finally back after several
> months of $DAYJOB firefighting, holidays, and sick leave. I should have
> time to devote to this series again, but given the lack of feedback on
> V5 I am hopeful that this will be the final iteration of this series.

Thanks and welcome back ;-)

Given the lack of feedback on the previous round, I hope we will see
enthused support on the topic.  Otherwise it is hard to tell if the
previous lack of feedback was merely lack of interest, or lack of
anything lacking in the series.

> There is known NEEDSWORK, but I feel that they can be addressed in
> follow-up changes, rather than in this series. If you feel otherwise,
> please let me know:
>
> * Investigate alternative methods of managing symbol visibility &
>   renaming.
>
> * Figure out symbol versioning

OK.  Let's see what people find out.


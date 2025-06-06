Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F3C193077
	for <git@vger.kernel.org>; Fri,  6 Jun 2025 17:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749229443; cv=none; b=fT/mql6G2jVWXMeSNWNl8udW/6aMYHoT7elUrzDSyYtQlMWB/FSKJ9kE9qWimu9RdgHXxMpVB4UAtebF0lIwGExoOi/j3N+LH3Ijc3+vfO1ttNLH8SKQW9QNRshSVvFBbOvPGvtZoXHwzcdxzNdBA3YLPYj11027+DKtT/E8vAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749229443; c=relaxed/simple;
	bh=bCNFwfKpRIiAE2bJ3SS3/te9xiw0xW9LFTjKuLHH+KE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BO6QziPJf2STwpcW8egHNw2+MRBLxhfGRkG0uEd1148OLlxKuMw+8pc77asySi/lQQX7aXZNjVuyE/JHXXuHXe/uAnd/JmoFEvs3mz2WCnBey4R5ugH7JXmbqwAjMqzSMumREI7mi517Iu9tzL91mCmn2ceIyfKGEalgM5bQRYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=M8QRXWHy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PYWRgU9Z; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="M8QRXWHy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PYWRgU9Z"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 47864114009A;
	Fri,  6 Jun 2025 13:04:00 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 06 Jun 2025 13:04:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749229440; x=1749315840; bh=SpNmJnl/0o
	nOyE/5r3//0kswnj/bEaz0CkB4Hgyschw=; b=M8QRXWHyQojP8yqLzNH+lVUyim
	0uxm107r/KHKXfG0HAo7yGkySnVONr4tThvhh0++PweL+foOjhlrPkXs53A+Db5V
	uk6K6ETYAm/1ENldOjD0+XfpAk5vkKfRqXoPBSs4CrPSl+kHwm3TQV8O4PKt8may
	WRTLe0FIKczcDE1/01UY1G6RmiyXzAIpIyMivCzONzdPFSoNUVGOIM1U5ODPXfwz
	Rr/1NpngD0WA2BBe21VQYIpNjfWtHGELb49ddEQEX44hDO57mHd3VfjHso/3LsCM
	diUYrjtvoDHjF1a2rio+fucb+KsU14i9aWIvZn8Fyl11rtvXcyNgINDTg8Vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749229440; x=1749315840; bh=SpNmJnl/0onOyE/5r3//0kswnj/bEaz0CkB
	4Hgyschw=; b=PYWRgU9ZuT4S4qEIfzE74C1+tlqme3dwSqk/QVL8vPG+NTFBL28
	baGQYiBI/BS2JlDKmjm/+oqjf45eIBdarJ04pSg8KD38hN5SCArhcR1fpMuOcA3n
	ozsJSEh7fJAnSSobWsJvTGjzH1Z4+9vbDhG7lN4XR8tMIkVMY+t/sNBuuRd5ga6T
	Kzavgx3xT77xeo46j2AWnivGDECcv53ERxZnCtba6Qo3LInqPBlIekItbr72GuyH
	TJCLXDVgUIfnmqCIt9/MC4rM9zCkrxj3aEqx2M6JIOfPo2tMveYfdPiT+qsEm/ze
	xMYPOFv7rHjClkzahtDog2zaqznpgbjso8A==
X-ME-Sender: <xms:fx9DaLF7zVxf7xLdGVAa3V1iC7xq5zwkIcrMmXbXkIfKrNZ6XIFTnw>
    <xme:fx9DaIXMwO2hSfkpfUgKDzZJW-cAOBX7BjS4fbM2S_Oioaq2VCN0M6UYOjRu3JhPO
    qkilQAs-uBV3icowg>
X-ME-Received: <xmr:fx9DaNLq0krRZjfZP9CzmgMAdzegxWZa9YGAm0YhzONC25paQcUKUpNL52qa5apG044Y6A04EBgNz7T0U4YHM75Y3hCewy7WMEHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdehfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghgrrhhgrgguihhthi
    grtdeksehlihhvvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomh
    dprhgtphhtthhopeiiihihrghoseguihhsrhhoohhtrdhorhhgpdhrtghpthhtohepshgr
    nhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepph
    gvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghi
    lhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:fx9DaJETQjXvwa3DA8WNQY9hn8tZyq3SMxYAP_eQTGJ6S5Kw_7ywiA>
    <xmx:fx9DaBVfpg4AC2D8W-ShTLZ-cUYEj7U3NXuN6uxIh2Q0rqPZEuB3YA>
    <xmx:fx9DaEP2hRRpTjdh_xRONCoH0TF6xcznsmWkm8aCq3ZRnKS9KClfGQ>
    <xmx:fx9DaA2eq6ocs5m3mIzT4SywEixVKdBz8TguLAUTCYUf7pXCac1cOQ>
    <xmx:gB9DaOS45KDHeFO37VylAe1HUspECUQeSOFDp1g3KqR-lMk8F8jxUIJr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Jun 2025 13:03:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Zi Yao <ziyao@disroot.org>,  brian m carlson
 <sandals@crustytoothpaste.net>,  Jeff King <peff@peff.net>,  Ben Knoble
 <ben.knoble@gmail.com>,  Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v13 02/10] imap-send: add support for OAuth2.0
 authentication
In-Reply-To: <PN3PR01MB959762A91208AEF089D3302BB86EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	(Aditya Garg's message of "Fri, 6 Jun 2025 16:50:49 +0000")
References: <PN3PR01MB95974F9ED808F60A915D054CB86EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<xmqqmsak3jwp.fsf@gitster.g>
	<PN3PR01MB959762A91208AEF089D3302BB86EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Fri, 06 Jun 2025 10:03:57 -0700
Message-ID: <xmqqbjr03ipu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Garg <gargaditya08@live.com> writes:

> I was thinking the same but though the code would be more readable
> in case if repeats.

Sorry but I do not understand this comment at all.  Not repeating so
that you do not have to fix or update all the repetitions later when
the code needs to do something different is one of the basics in the
software engineering, and less repetitious code is also easier to
understnad in the art of software field.

If you start from a 20-line block and repeat it 5 times to grow it
100 lines of code, the eyes of readers will start coasting over
after a few repetitions, and you may be able to smuggle unwanted
lines unnoticed.  Unless you are aiming for such technique to do
something malicious, don't go there.

Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF597264A92
	for <git@vger.kernel.org>; Wed, 30 Apr 2025 16:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746031838; cv=none; b=uMBuvqsF8hsIqY+dvgCc+mpBJlQtsrOgfG/g2mJ/KSvVx+ba0xpaFdjENtfEjtS+j2MN8dUdoCF0tZJDKanZCfRGHICnTgLft1+qcu/Aas/Sbnlb8KWOqQ65R2xh5ot5xZXvkSOd1TZ64wcBwWx5icPGaQIDWwkZ14MXZggq39M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746031838; c=relaxed/simple;
	bh=Y8st7NW4knQgtrgwXH65J+WPo66ktXH2WTFSxmkXyzE=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=H6I14JMwHrAvmo1ZM43qxp0TXb9g4RfCv3on5V0UrxwBnu1v1r/0cQpd3liBtIX0XMB5A+F8pO826yUzHr2yHz4c8HKcsal97bddTtcFlnV/hbkRv9ksWAsetX7vCm0oPJqIYWV2iIPHlBtpIQbeMlkm77VxUB9qkK9XMZv4kVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=DVstR06n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O2s+ElBU; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="DVstR06n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O2s+ElBU"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EBEC225401E2;
	Wed, 30 Apr 2025 12:50:34 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-09.internal (MEProxy); Wed, 30 Apr 2025 12:50:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746031834;
	 x=1746118234; bh=12WiqvKIg6KYVnT8P/L1Jwh0D/Q+SFRNKa2FdbWZe6s=; b=
	DVstR06niJUd+8LR5NHJ3S57eiwLx3uO69WWhSCjF3xdW1kLbKBcnKo4rPUC+9su
	ue+cUJixvMbFO3flnCdvhACTMuEXtf6+5eUHTa4RGpKWpxmhTgl2ef0ROjW8JbZx
	+YCQxATjrQfQ2DXHy6xBxTutvQG04fq9ryT0pLbzvdoBty/6Dl3uWJeRJxpCTBOV
	j7He20lKe6/t8Fcd2UBw0zOHrNWB3oomNlhzsia7tYq4YsBC/ScM0seE/hm/AQ+I
	FxWmsvjQt2G3BVU9TqmQZS05QpL505v/7x6LNtvlcCkOXpWPiHyP4cpAkaBqRy55
	2R4x/RKuSp84MEIDPgZiOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1746031834; x=1746118234; bh=1
	2WiqvKIg6KYVnT8P/L1Jwh0D/Q+SFRNKa2FdbWZe6s=; b=O2s+ElBUcz63Kd+/V
	TF/9mptvyxtnlZfYC27VfukR3eA0XRbS9d/O4fWX2DmZ9cuR8GYZv4UDf00y9mOt
	wXXXMpW7E8ldfW76bn1meoaN92YRvWQEK5EIjlEceqEBFL5RDnUkP53A996AW2FV
	bONG9pXdqlsQi33n4wgspGWezsDiMuqZ01ej30Yru/rvs7NyqHGCV9BpnTAMV92U
	gKOQxwpiIZssQTwEPuEfcqeCoa99g2me5MVo6kkuTvu6uKL/rzREhJJ8qcTX8Y1W
	adMopi21dijcgTgy89j4yeoB+YmPltcTYGbuTJKLOe20w/9vRiZLDDZtslyxP6CI
	H2Bmw==
X-ME-Sender: <xms:2lQSaBsiGOVF9tNlzf5AL6aKtA7HqMGipLEXPyGC0t6lqcnsIkFz4qI>
    <xme:2lQSaKfjxFzAHT6S7t9BxS-LkoMeNxoLMDHCggiXfvcDBGAHqkeJ9l8mo11Zmkkd5
    LLUPxbmsw7smD7BWw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieejvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvffkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrih
    hsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffr
    rghtthgvrhhnpeejvdfhjedvgfevhfdvjeefleelteffgfeuhfeihfeuuedvfeevteekte
    eugfehtdenucffohhmrghinhepghhithdqshgtmhdrtghomhenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghugh
    hssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhojhhoshhsfhhiuggvlhdrhhgruhhpth
    esuhhnihdqjhgvnhgrrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhg
X-ME-Proxy: <xmx:2lQSaExQsQv66QTXNAm_2Y5oTGpic3ZCzbxdfkFHz8PA4uf0_DD6UA>
    <xmx:2lQSaIPklnuZDxktmslDctYlC_fNtM6QvkJe6a0Q0KyMh-iUPYLxFQ>
    <xmx:2lQSaB_ClK96iO9M5w8u5PT6WsZNT8c_wiS51C9EGq2jgI9_4In2RQ>
    <xmx:2lQSaIUdOcDqkuVk9TSIhHk4RthY7OtI2UBZrjp0hGA2T-CxMDn9PA>
    <xmx:2lQSaG97G-siPyqQWC_kmRqBfyi5z1UiUCJMBF33MO8denfPLW-caiRK>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1ED10780069; Wed, 30 Apr 2025 12:50:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tdf38e1f1d540d8fd
Date: Wed, 30 Apr 2025 18:49:46 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Lino Haupt" <linojossfidel.haupt@uni-jena.de>, git@vger.kernel.org
Message-Id: <057e8f72-ea67-432b-a687-2b5af08fba05@app.fastmail.com>
In-Reply-To: <fb842b0e-3666-4b78-bf00-c7d11a42dd25@uni-jena.de>
References: <fb842b0e-3666-4b78-bf00-c7d11a42dd25@uni-jena.de>
Subject: Re: doc: git-clone: Improve discoverability of --no-single-branch flag
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025, at 18:09, Lino Haupt wrote:
> Dear Git developers,
>
> this is a minor usability suggestion
>
> git version: 2.47.2 (NixOS)
> and https://git-scm.com/docs/git-clone
>
> Short Explanation:
> `git clone --help` shows `--no-single-branch` only inside the
> `--depth` paragraph.=C2=A0 The canonical option paragraph
> `--[no]-single-branch` is hard to find when searching for the
> exact forms `--single-branch` or `--no-single-branch`.
>
> Extended Explanation:
> This reduces discoverability for users who quickly try to search
> or grep those options. I myself was confused by this.
> The search term '--[no]-single-branch' is not intuitive.
> Of course, searching 'single-branch' finds the option paragraph,
> but maybe only a secondary / tertiary choice.
> A second issue is that one has to deduce what exactly the 'no'
> shall negate. This is not complicated but may leave inexperience
> users unsure of the expected behavior.
>
> Suggestion:
> Below is a drop-in replacement that (a) places both variants in their
> own paragraph and (b) spells out the negated form explicitly,
> removing the need to deduce what the =E2=80=9Cno-=E2=80=9D prefix nega=
tes.
>
> --single-branch
> Clone only the history leading to the tip of a single branch, either
> specified by the --branch option or the primary branch remote=E2=80=99s
> HEAD points at. Further fetches into the resulting repository will
> only update the remote-tracking branch for the branch this option
> was used for the initial cloning. If the HEAD at the remote did not
> point at any branch when --single-branch clone was made, no
> remote-tracking branch is created.
>
> --no-single branch
> Opposite of --single-branch: clone histories leading to the the tips of
> all branches.

Many options are documented as `--[no-]`.

    git grep --fixed-string -- '--[no-]' Documentation/ ':(exclude)Docum=
entation/RelNotes/'

This is explained in gitcli(7), =E2=80=9CEnhanced Option Parser=E2=80=9D=
 (for some
commands), =E2=80=9CNegating options=E2=80=9D:

       Options with long option names can be negated by prefixing
       --no-. For example, git branch has the option --track which is on
       by default. You can use --no-track to override that
       behaviour. The same goes for --color and --no-color.

A concern might be that changing `--single-branch` in this way would be
inconsistent with the overall style.

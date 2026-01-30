Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED869274FEB
	for <git@vger.kernel.org>; Fri, 30 Jan 2026 21:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769810175; cv=none; b=rCR+Z6hqIk7Czv4eRAAD8qLBkDIUCdpA4aQR+j7zz0LIVBZtOHrnCfkcJF9q0gBoMy2IODrymygbeS6yFA6s/A5EX80MnYL4Cgy6jCV/VDAhpPcCCC6t2QHpvT1/fGfGTXywu5UhvX5uamRDvkWrnJ7qDQzfli4HuthDFpEBzAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769810175; c=relaxed/simple;
	bh=DftbmCbFmJ8w7O6sjrDySW2H1Iox71lue+l2wzWj2gQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=okth1d+8ldrMYUkNufgiI4i6nXtF8U/gnOzSY45m9iFMzjSsXqSIDCJSkdOW2fU2BPk13Js6WRtzS1waYai+c4+WGp8PC0h/RHW+F41FRxP/GrFFiDihZUF+kmon0O0XoDlS5EteME5JVwNu9AOY26UCgt3uM/a/TD65j+CZ35A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=p++qXwcL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kkP+APr6; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="p++qXwcL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kkP+APr6"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 46A241D00082;
	Fri, 30 Jan 2026 16:56:13 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Fri, 30 Jan 2026 16:56:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1769810173; x=1769896573; bh=hJSXI3Ig66
	aobEXVkUfwSpRS0HwQZghwhK2rVaQD3mA=; b=p++qXwcLYhHZK4pmItDgYVFvrN
	InLZcSonLr9lwBqobt8pLjILftyMCyav4zVe2c70Eskuz8I0xySqjyh6hOYnVg6E
	3fPb5c9v7ah2vXbpeNzVdruGEb8g3JZU4tpUNE1kFyud2JI8DxMKurXEyuTeaP7N
	9+Pwq7rjBQzxXgj7RGJyO7dy7e3H2xsykf2C/lD1f/hWwukKX0v3tS+nkn1QzO3k
	fmEFrz2LHy/odWDRCaTO40QZV7aSCeD9xcNrYKO8zLj7SX4OUXukxwvPjlUfZZEG
	3qwQGj7vWJ7wEBOusbMBA+tMWfCCV9QHP/WutUQD3ddPbYg41bp2xjnCZk/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1769810173; x=1769896573; bh=hJSXI3Ig66aobEXVkUfwSpRS0HwQZghwhK2
	rVaQD3mA=; b=kkP+APr6axz4md3D+UaDqEcM1T6IwXmnAk7nqQ1OEMwp7EC2lVE
	x4so3cogQ7jzZU9imgNFHP3QYllbT7FQ02j+gsMSP9r9mBYBglhLxyIQA1bL0HAE
	UgUfoHkmpCJVgh61va9xaCarykEU4ZvL231LWX9q9FJSuCsDLIK4wD88moF0Jo48
	vuLc8JagYoxPzTxIB2yDTEHCBVU8yUmAtKImkZ21kkurSxiCeDGr5tf/G05R8dgm
	M+2s0hFsPv/uaiiUP/rirtNTOcRiCA+8xcrWD0fgjvOedESybUGIHb22I7Q5Mss8
	GJZwZd/NqEYvWZVevQB2T58fWNTp+wbybIg==
X-ME-Sender: <xms:_Sh9aSyeu6xjasAuPnpzLTkCSY68012S0jg0F3erzz7HEL62WVk4rQ>
    <xme:_Sh9aVShvHfGCByeg1P_Y3X21RzBfq32RN-yUo8RNRTd7Sl0Rpo1gsxw3PBbDzSSP
    8s4wc-1-Eq0vfssCbw_wEgrFt3cE6ZVITePdnZGNh54mR6yG3Ed-w>
X-ME-Received: <xmr:_Sh9aZU2nHP4HkVGGV4jJOlExOfIqV3uoDzZzRJSumrlvI3-raqbyYUk6y_TEPbQ92D542XYSVzmiscdQFHUHmoJVqPZRv0icV5cGCk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujedtudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohephhgrrhgrlhgunhhorhgughhrvghnsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:_Sh9aXYpCfMR-5g7yBHeum53yavdrj-xr7sRTLRCWDohlo3eeNCMig>
    <xmx:_Sh9af3gL_D7YBDO-rKQPvIY0me05liyE5H4vDs_SFwqNqxwDSp8cQ>
    <xmx:_Sh9aZhnWGbqeYOuMu9h859-ag7fmk7BmKKQTf04sVDJf6e2hMkX3g>
    <xmx:_Sh9aTa_wdjyfWCXDb9oTyButNBDPrrvuWJCAINC8Fw12JgTk5ryOg>
    <xmx:_Sh9aQ2JeHlNIExe_LtEc7O-JPryl2wovE1BSmE2jGvlaqlHUPh8HIj5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Jan 2026 16:56:12 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: git@vger.kernel.org,  gitgitgadget@gmail.com
Subject: Re: [PATCH] revisions: add @{default} shorthand for default branch
In-Reply-To: <20260130205830.45806-1-haraldnordgren@gmail.com> (Harald
	Nordgren's message of "Fri, 30 Jan 2026 21:58:30 +0100")
References: <xmqq4io3831o.fsf@gitster.g>
	<20260130205830.45806-1-haraldnordgren@gmail.com>
Date: Fri, 30 Jan 2026 13:56:11 -0800
Message-ID: <xmqqpl6q69z8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Harald Nordgren <haraldnordgren@gmail.com> writes:

> I pushed a WIP with some of these ideas now, not intended as the final
> thing.
>
>
> Harald

Meaning we should feel free to ignore v3 and possibly a few later
versions, until we hear from you?

I was writing the following as v3 review, but I guess these are
comments on a version not for public consumption, so ...

--- >8 ---

I'd rather not see you use "primary" for what init.defaultBranch
specifies, which already has a good name, "default".  If you are
using a different concept, like:

 * learn the remote @{upstream} for the current branch (for
   "@{primary}") or the named branch (for "$name@{primary}"), and
   then

 * look at refs/remotes/$remote/HEAD

then I would appreciate a good name to call that (which is a concept
that has no good name yet, as far as I can see) and "primary" might
be a good name for that new concept.

And from what I read as _your_ use case in an earlier message,
init.defaultBranch aka @{default} is not what you want 999/1, yet I
think what the patch implements is still that one.  Puzzled...



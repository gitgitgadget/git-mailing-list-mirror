Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D576131E49
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 06:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772433766; cv=none; b=tsjRilzkmIHAH3k17Kal6Q76vQwwWOCS5zFqeI+M80zIrMUj9+Ucw5+wj9RgkWVQ1fLulDbF4U2+PHQxdL3M1w1JhYKf063gyVXGqxl5/vN0CRFZ2H/7r4qxB4ew61TUiajhYDWAubI0p2XWrRySD6mnDH2CvbUzfWWOQbngZmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772433766; c=relaxed/simple;
	bh=P3GoO4uUfn2/4ld1zu8nX4eJD5wVi/lNUarl7DyLPZ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rXDyIjV/9KIdEbBnIrbkPDMhtVHHCuPdpFBPqd+Jjv/Ar8mH33OcbTEu0hgEmMlKYQA0baLmmQTc6dz5U76YpR3hSI9FE9GQDgoN1fEW8lxlXIQS9QiIzYbKr1qQWBL6bgiYSk5lLHxwiBhr9OifRE4wmkuVC05cnHZB8W5rN8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FPTLO40o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yefl1z6n; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FPTLO40o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yefl1z6n"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5DF487A00BC;
	Mon,  2 Mar 2026 01:42:44 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Mon, 02 Mar 2026 01:42:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772433764; x=1772520164; bh=o1/xM7TiT6
	WGu54JWzE7o2/CAI3o+ieWzN6I79FnkII=; b=FPTLO40owo+kWJMpExPuPUN+4z
	fyOELHFvgEFelMfo6W9Kr0wFDMGcubf43V6qpAp4NNhs3SWyAYfYgcp/qM0YWKuw
	9qYUA3fRjd/fBSuzjOcuXiCbcXBrHvluVz2OuAF/96x/IcUo9HzzxTJxG6WN1rsv
	Xpizf8pMPx3vmmvFNqW3Jitqp5G2kx7XLeoXxtO8dfRGaR4iEtfoR1OeL9fZUQzd
	Li8eMrDmaLOIubAPo8754zgV/hYSMr0yWMF5OrHofeqglZ0FhS/gz8H/Yb3BG8df
	9izbOWXgvezW2pWYK5o6uy/lt+Dqnd7AlCXJmF7tDRXtYAB6wy8E52LhX6sQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772433764; x=1772520164; bh=o1/xM7TiT6WGu54JWzE7o2/CAI3o+ieWzN6
	I79FnkII=; b=yefl1z6nhS8wcCBJnZBdUqi382XkHaGRiXX/GoLlk4dec9LwwUx
	E0JED8zvoUFVtFZE6Xf0fGszjXlIapy1/HI9wgnNdXQvh9HIiC3R2RdUFPRmWo9t
	IfhJ5Vdvs3Rk+VdBLTvBQe9nAWiz3R7We4jZ3k5bx1pQl70ksBOWTKTvbqWUbWwu
	I7HHpDE68PGR89WhG2u508rrOmmytBO8aXOh8zsTqHf+Hq/1P5ajvHi1+KfnrgWW
	uvjdADo2T9cZCod0Td2cqBAh0yDmdl3hvNE99iJFm2/TsAg8cDUx1G9WDwy7FnBn
	VuLG2E82evEcDUwyVsDp01OgfXntmXovuSA==
X-ME-Sender: <xms:ZDGlabRld5jk1okhtE7az3KagekoS-Rg40stMvB2lpDC5THxUoLMeg>
    <xme:ZDGlaTrsUiU5_roVQgSeYTgcu5vwxEUFFNGIGgqvyQp3o9FRc-TXrmapxsLkehsdJ
    d_kE3pVp_QBKui3gdRHrneDG7D5qX_xZarKap4bl1NUd0aXLMzEAA>
X-ME-Received: <xmr:ZDGlaZJDFRlfhIad6RNIPfMV5F9vvduttHLN34CMuMp8bAK88upGpzxalXIDz22cJqgDZkWEG9qEkz8gOWzGO1PEoheHUKiFFw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheeileekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvg
    hslhgrmhdrrhgvuggrrdguihhvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ZDGlaWob_DQ7b_hLG3L2fWxpZ6daeAJSHh8evlYRq7_o6r222CBqjw>
    <xmx:ZDGlaRylxnY5MfcUEJYq0ffKFWGWiuhxu7mZLKxmJ4N4FRig64l0ZQ>
    <xmx:ZDGlaaPOt4wtjA9WMrRPl2USL7NSjgqH1SYe02VZXsgJQW9H9oSUvg>
    <xmx:ZDGlaW61ZjzWSNLdOOVantA5pSPxYFzYcDndJyedVntKnTEoxF9luw>
    <xmx:ZDGlaR4mXai_ifFV5CY0opjFsZwitUuTI2rlFwmNeJBAXftLatSvzMhs>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 01:42:43 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Eslam reda ragheb via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  eslam reda <eslam.reda.div@gmail.com>
Subject: Re: [PATCH v4 02/10] repo: add path keys to repo info
In-Reply-To: <58d46ec7-99cd-4878-b05d-a378ca119a68@gmail.com> (Phillip Wood's
	message of "Sun, 1 Mar 2026 10:36:52 +0000")
References: <pull.2208.v3.git.git.1771875812.gitgitgadget@gmail.com>
	<pull.2208.v4.git.git.1772140487.gitgitgadget@gmail.com>
	<6d5b9ff07566e1cc28a672cf1f47988e9c8c45da.1772140487.git.gitgitgadget@gmail.com>
	<3c4d4909-4eb1-47f4-b601-8f877a07ddd5@gmail.com>
	<xmqqldgeotgi.fsf@gitster.g>
	<58d46ec7-99cd-4878-b05d-a378ca119a68@gmail.com>
Date: Sun, 01 Mar 2026 22:42:42 -0800
Message-ID: <xmqq8qca68bh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

>> FWIW "git rev-parse --show-toplevel" dies with "must be run in a
>> work tree".  Better or worse,
>> 
>> 	rm -fr new
>> 	git init new
>> 	cd new/.git && git rev-parse --show-toplevel
>> 
>> also dies the same way, which I am not sure we want to inherit when
>> we are making a new interrogator command.
>
> Yes, I think printing an empty value after the key would be better - I 
> don't think there are any paths where we care about the distinction 
> between NULL and ""

If the new and safer variant of the command should signal "error" by
giving an empty string, it would work with its "--show-toplevel"
equivalent run in a bare repository.  In a working tree, it would
give a full/absolute path, and never be an empty string.  I am still
unsure what that new and safer one should do from inside the .git
directory.  "rev-parse --show-toplevel" dies.  $(cd .. && pwd) may
be another plausible and arguably more useful answer.

Your idea of equiating NULL and "", I do not think it would work
well with "git rev-parse --show-cdup" equivalent.  The command will
give us an empty string from the top-level of the working tree.

Curiously, in this sequence

	rm -fr new
	git init new
	cd new/.git && git rev-parse --show-cdup
	cd objects && git rev-parse --show-cdup

two "rev-parse" do not die with "must be run in a work tree", and
worse yet, they do not give you ".." or "../../", either.

It seems that one rule of "rev-parse --show-<some-path>" is that
"when you are inside .git directory of a non-bare repository, we'd
behave as if you are in a bare repository as if its working tree
does not exist", and the above is consistent with that rule.
"--show-cdup" does not fail but gives an empty string when run
anywhere in a bare repository.

But among "rev-parse --show-<anything>" that are about working tree
paths, there seems no unifying rule on what to do when in a bare
repsitory.  As we already saw, "--show-toplevel" dies without a
working tree.  This reflects the history of rev-parse that grew
organizally without a grand design.

If we are adding new and safer interface to these pieces of
information to "repo info", we may want to straighten these rules.


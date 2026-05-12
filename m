Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A72D3C3BF3
	for <git@vger.kernel.org>; Tue, 12 May 2026 05:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778564879; cv=none; b=XiCNJ2hgObPj4L82P+PDpakJ6P3uLh+zKPqUhMGk7ipjZh4su8aL6xu2Y0t7V+HGwFwD3+SupMD9Jf54MM6+VcCrqErRrA+cj7IFRl8uGvmxl9dFckZHc8CitTJegrsRygPkaFCic0jXlS8KBTN/dXw5eZFiMSfYT955ondch0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778564879; c=relaxed/simple;
	bh=zoUkaRuj9Eal4KMrk7SiylafhqxQKF/4LozDrcm0Lwo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WpecGl117rjblUaH/7PWtErUlTPwAPOD4KAjfU37DnpPvcyra/4Mr0Ul8nstCPI/nfyhq/t/7+a8fSu4OQ0weV6832qLQu78Zbd4/09t2zcrIuBw0jGERJZsXinaiZb6qL7VSKASVxS0EbDqELMaBEDrtn7vgN3eSHjlSd0N5h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZgbxmTg1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WUAt1Ivg; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZgbxmTg1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WUAt1Ivg"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 1E7251D0003D;
	Tue, 12 May 2026 01:47:43 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 12 May 2026 01:47:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1778564862; x=1778651262; bh=FYwqt32KKk
	KvCW1NEm4aJxEkTRlCnL1Lc1VP/TEhwQA=; b=ZgbxmTg1+xM+yFy5IkACMh6daa
	iGwXaWWfuWyELzONCYdcXoe6S/DRjlmxR7qZN2/C0TGtvij4sRqshvMXZrLo48Yz
	rsONVGR5ub4P7d8I48wA2u3UQbSQi0gI9uinVmcWMvKJSWN3ab/OIJ5uw5EHi+Gj
	/SXHXrWNrpvfWv3hKf7VZ55ZW0nrV2YNJ5kI+E966yCCa0u+kJOEL6sQ9/dVK+nY
	UpIJuqUmBQb2hjkgVBLQ5IBcF8V5tH/JWWYIVLxntxUtFOVsL/OCDM6ONKp05+Ed
	GMEQCPRvsuZS3BvarXvGFx8168ErER0boyfQvWq4rAqu5fZhX4xy8Cbr9DpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778564862; x=1778651262; bh=FYwqt32KKkKvCW1NEm4aJxEkTRlCnL1Lc1V
	P/TEhwQA=; b=WUAt1IvgkM9VVBdkTGOVv9obJGE3gl7YHQdrRIj/Q9KFravGkmQ
	l2QidUC5wj1/67mKSEOhlmfBS55GvEWXaVpWHQGcGZ01fmhvBf/Jwt/Bl2c3WY/T
	bMRJOF/36zPP6m19fshfnJ9Fqq9+4eoff4/Snel3rPgBLBr83fPC4SVSGJ2NpBni
	xeHjeGVoLffNw2dmlhRTnxAYDptaI2rgO28p4C0i0gZaOI6NVni0So0EhuY2hC1E
	M0wMqdPC+fDQPwKil/oIq57IX801ZnnK5g42Xg7qpygbc6IIU4v85tgm0+BF4iJm
	t+Si9LP6xN2aqmkFdTNAkAkSXKOy84NpBFQ==
X-ME-Sender: <xms:_r4CavGpCcmThRn5zh_DPufjw60NRfBkLnEQXTRwBey0Ge4dZdqG1g>
    <xme:_r4CagAjaeeUDxSKii0SHLDSuHdxtMWYXbh4auOsGj2C9GzKANaZz7By6bux40rn5
    2tbkx77UjjwPZ_QT_WwhagwjAHwc7_jF52ROXVEM6C-sxn-Y6ng>
X-ME-Received: <xmr:_r4Caq9B-Yldi6R02L8gRB8F4OUVBseKBZjGYdFhwqKnxOhGUcqjIu0zXqtO6tWD6UZOEHeooGsnkDKCzWWT4zxQpRBRVIwU9g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvddutdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdevleejtdduueeljeeugfeitefhteeltdefgeelheelleelhefgfeetkeeu
    ueejnecuffhomhgrihhnpehmshhgihgurdhlihhnkhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnvg
    ifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhm
    rghilhdrtghomhdprhgtphhtthhopegtrghtsehmrghlohhnrdguvghvpdhrtghpthhtoh
    epphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:_r4CakChZeN35OOWGIq1n9zwSP9TV8m9EVX5Yxnz4gkVCVXOADswxg>
    <xmx:_r4CanT3mq6prJhz0URTg7vmW5dbgftx2__eZ3OH4-Jn-oYL-nsKww>
    <xmx:_r4Cajuzbdhs9hyKvtK27jJKWGwR9rUFBXi3rdTCc4swfCcZILwK_Q>
    <xmx:_r4Car3IKCiWkFhXsVUCg4Yc_5OjLHvGo2aFgfaO0Adlydmauw0_4A>
    <xmx:_r4Cal1_yBNbs-YNOwiibZFLZZGyoKbBOV9XNoYRvjXBNNJBO8EJ9knH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 May 2026 01:47:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  Tian Yuchen <cat@malon.dev>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH v3 0/3] builtin/history: introduce "fixup" subcommand
In-Reply-To: <20260427-b4-pks-history-fixup-v3-0-cb908f06264b@pks.im> (Patrick
	Steinhardt's message of "Mon, 27 Apr 2026 07:53:50 +0200")
References: <20260422-b4-pks-history-fixup-v1-0-48d4484243de@pks.im>
	<20260427-b4-pks-history-fixup-v3-0-cb908f06264b@pks.im>
Date: Tue, 12 May 2026 14:47:41 +0900
Message-ID: <xmqq33zxp4aq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> this short patch series introduces a new "fixup" subcommand. This
> command is the first one that I felt is missing in my day to day work,
> as I end up doing fixup commits quite often.
>
> The flow is rather simple: the user stages some changes, and then they
> execute `git history fixup <commit>` to amend those changes to the given
> commit. As with the other subcommands, dependent branches will then be
> rebased automatically.
>
> This is the first command that may result in merge conflicts. For now we
> simply abort in such cases, but there are plans to introduce first-class
> conflicts into Git. So once we have them, we'll also be able to handle
> such cases more gracefully. I still think that the command is useful
> even without that conflict handling.
>
> Changes in v3:
>   - Some more polishing of the command's description.
>   - Link to v2: https://patch.msgid.link/20260423-b4-pks-history-fixup-v2-0-d7571c6d36eb@pks.im
>
> Changes in v2:
>   - Introduce "--empty=(keep|drop|abort)" to specify what happens with
>     empty commits.
>   - Adapt documentation a bit to hopefully clarify how changes are
>     backported.
>   - Link to v1: https://patch.msgid.link/20260422-b4-pks-history-fixup-v1-0-48d4484243de@pks.im

The iterations v2 and v3 saw no comments, unfortunately.  I just
gave three patches in v3 a cursory look and nothing stood out as
curious or fishy.  Shall we mark the topic for 'next' now?


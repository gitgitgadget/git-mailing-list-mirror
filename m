Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973EB19CCEA
	for <git@vger.kernel.org>; Thu, 15 May 2025 21:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747346225; cv=none; b=UB64MNvOb4KEmvpUDRMLx49ir/qcuEbNXGuobs9RP1RtlF7/jL6V8TPdylahf6xxzK/myMOvS1gBtOxmpSuf2tcR7XmSAloCtwrWNppNAxQS2Q2Ro6IAyvLLYI6uVC2GtJs20o6QCNmUc2tCRIVwWn9lIr4HbJrmOj6qh1sGP4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747346225; c=relaxed/simple;
	bh=vebvctRupKv8nHE6vKAYQ9mq3pqZcLY/E0M0R3vsP9Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PSY7olX0h4LFzgjlyfqrKzcEaip/SoKUSrYZtTVtZMRBJPx3LDVYRMqlvEvQWiII9vHOsAMoSmMAL7NGD8ZobmygOvFsYR3X4S4UcSIGSlh6rf7fNUbLR2mHJGYiIkF8UkBqPwji01E0JXMLlG2mPbS5h6DwFXe1v82zf8zQwRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cRkOXeZq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qj8hceF1; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cRkOXeZq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qj8hceF1"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 945E0114012B;
	Thu, 15 May 2025 17:57:02 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Thu, 15 May 2025 17:57:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747346222; x=1747432622; bh=1GVsrQ0IKq
	fdWCCUWGijyZ/ssuVSDXuvHYlf0p1CuIY=; b=cRkOXeZqzvMSNpLzZlJtSPCbr/
	KZ16luKziYhoUw/ZcR4QZSBbqYNj2iPg2UE4gGUD3Ac9GTQUadvfqfYzOgVnnhND
	nlEXFwMlR0EN/xeU0494TYrTN2bHA49+OEE8cmeSR6ecRt/0Wen0IM6sGv8ndwC5
	4T2STZ/OCrUm4uuYfUNQTOK6+vImUyt2F3FeVIryE1lOiEfOHeW7NKBqAEvfykn8
	olbeS09iFz1iHYfgsF7Ue3K0FBFrorM1dLam9YtV3L+s4JvprlVr6f91sULQegMA
	xE+xd4yUWp5mf0A8T6hRicc0TAnau7ZTOFZCjOlI/b74NRb9z75JeLlVDiqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747346222; x=1747432622; bh=1GVsrQ0IKqfdWCCUWGijyZ/ssuVSDXuvHYl
	f0p1CuIY=; b=qj8hceF167HJDFXmuYvKsYVCZ0DxAnSFGiP8Rzj4CYU9MKrKT+W
	eI3rreccD3v6yWp/Xl2gMsb6FTfdPXZSJszInD+xS/0e+NhoA7MzUYWq4PcVt6qW
	Lab21u1Y6++OjhL39Hcm794yL98QR1e6MppSvSuzoNQbpocW5rUfDuTZJC4WJq6e
	sjwaHpeXYmD977t6XPg5enMNmY8jEBlKqkM+GyCn/bvj3S5mQHscx5s58NMju8HP
	6KKN6/bPvRV2h05PIy1a5RbLno9l7XqO71DqK4sREcwVN7/FbB/imtKe3saCkrRv
	KcDjbPdjSeRiXON+fv0aRX53STHcO9dyVLg==
X-ME-Sender: <xms:KWMmaE1SDSvPdq5NFWcMqNZXQaUjhQ0H4npEoC5CSh3GnVZaopNw4g>
    <xme:KWMmaPFUjzm2djetRfw5GPj8sUUoz3S9UNyjyBDYEYgpwrR2UlEeoUyH0HoHLqhf8
    8ORQeuvbzWAJQuVMg>
X-ME-Received: <xmr:KWMmaM4I5Iu9KUhg3m6K6GmQVV-5VuSJD5A8ekl0hkiRG4tFUNs0kQDXdELbuz2KcBrwBlVtO9113U0opsz_0PZ4Jwpf2G1wi7Vlf58>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefuddutddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtgh
    grughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohephedtvd
    dtvdegfeeftddtheeisehsmhgrihhlrdhnjhhurdgvughurdgtnhdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:KWMmaN0_zHb-9bkic3NqKlS8bv52D0iIHTcFe-MQcpq1Nj02MIG3nA>
    <xmx:KWMmaHGDV9jG5vixKnyvnBrU68eLgKH_pNRIAD_pME4JMvNZ-EwFEg>
    <xmx:KWMmaG8ZbWiwgensyhVUBkgtAaDz8jlIcHkON5zTDtpk4ntccoEQeQ>
    <xmx:KWMmaMkfP6J9JWJzHUC2vlWw9V6h3Y_Ey_Z8fiXb0KoNWCem-4K6Kg>
    <xmx:LmMmaBcMCf2kINgjX-J1smOi0ex_KZGAvUQCxubqMyFJJxwUT-gr4S6S>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 May 2025 17:56:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Lidong Yan
 <502024330056@smail.nju.edu.cn>
Subject: Re: [PATCH v3] commit-grap: fix memory leak when
 `fill_oids_from_packs()` fails
In-Reply-To: <pull.1957.v3.git.git.1746779435536.gitgitgadget@gmail.com>
	(Lidong Yan via GitGitGadget's message of "Fri, 09 May 2025 08:30:35
	+0000")
References: <pull.1957.v2.git.git.1746774869081.gitgitgadget@gmail.com>
	<pull.1957.v3.git.git.1746779435536.gitgitgadget@gmail.com>
Date: Thu, 15 May 2025 14:56:55 -0700
Message-ID: <xmqqr00py1ug.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com> writes:

>        ## Commit message ##
>      -    fill_oids_from_packs: fix memory leak when fill_oids_from_packs failed
>      +    commit-grap: fix memory leak when `fill_oids_from_packs()` fails

I'll amend the title to add missing "h" after "grap" while queuing.

Thanks.

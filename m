Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FC93016E6
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 16:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758041358; cv=none; b=L3BxSlgyCxjKuZRZCh3vXpYWTDv90uDx2CcZNuTZvqGD+ukOk+GsrkElTqXR9zVyYwtogqc09fwhlVJfZA5lVFB7mqQWPf+FC6J6ncHszS4PvVczBLYB3Mf5n6EIoL+JBUc5+IhyxYy3ZlbaApRn8ALp1vFNftzcL6Ai2f4XzqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758041358; c=relaxed/simple;
	bh=2m46dIVIgbbrN8fjb+ww1F031l7NzlGTl2cTRAwhhig=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IsdwiQnjE0Z5NHVW7A5bcHBtNwiyAmcc+nGLmGqTLfDGs/P/abG4lVsjgjoRYAgL63JdbnqX1Bjqnlg2XWFNNUMkdq4A2hTxtOivYTw2z9bbA+mR2YoNrdYEygEyyg1cH3refKKu86VlvT1+tLKgsph6CEayDmT1WOAncPKREH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XGhluWTi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CFB8yHKA; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XGhluWTi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CFB8yHKA"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5347014001B5;
	Tue, 16 Sep 2025 12:49:13 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 16 Sep 2025 12:49:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758041353; x=1758127753; bh=6vlc+U1iea
	IUuae/4yzV+3UXLyehAFa0MdDM7pYES+g=; b=XGhluWTiflm/Ufyhtp56IqsgwV
	bYnJUtrbbLtJhaypuDCazxxN/4Gb97ygVokzEvxyuZGX4VioEVByrdQ+bDouwSxY
	F2fbI6mVwu6hkZf6fg7ZsoTb2OCYeL+VEYMDvlwmbjHx/XR0MwYaxAvLKRWRQ8e9
	yfY6O1mU4ALKZUIEQoQ+QaOTJ7xt+ZytMv6Vi4eqP0vhpUrcEdws568BZ8VvSn/w
	sJ5C2wqV7xdBV1K4ujzE4bbZvMFSNTGFoTCgUr7NpziUVWjq3PyOGLT2fUHEmMq0
	10E6hY+/6THfkNMNurVf0siDT/7byL7OY7g1PO2aIqYVj5iCgjHZxuXCow4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758041353; x=1758127753; bh=6vlc+U1ieaIUuae/4yzV+3UXLyehAFa0MdD
	M7pYES+g=; b=CFB8yHKAx/3jhoPe36bGUfi79wqE+ujq7lzjlvptCWXDhydxPCp
	qpavfR1esnjsg3G2lprMrpcejhRQQmtpJ7eY+UiqlSgoiaKBADgW3kcBGI1wzg5d
	Z2KFI7pDYs2Rg3MtdUK48p66udpaw4JI2WpLbS6KKCNvoKKQa/GBqWirIuepZ/wV
	tgnzUXmyX3aQ24bsAMdp8dWyO/wGIrupsenftMXxYJ7yecM4bGhiFV1eduyIKQsd
	ttNlTSaN6smK96cAYgbgjJviOtijdFLGONl1GLq8OA6Me4aC4hCyA+cLQreUCBjF
	XljQumHO/KSi25hynBcrFJzek4pNmHoGWrA==
X-ME-Sender: <xms:CZXJaD87aeSpcRcsmUVVVcklvlV8QMFuvW3d4CX5T5WnsmUs_Khyfw>
    <xme:CZXJaC_cmkCgdfQHTS3GauVk2WwF9ZHTRDfV8GDs0bHkUOZQKymET5BqniWDZNtRG
    Z0iwx42fhw3I8EaRQ>
X-ME-Received: <xmr:CZXJaKd94ElVMS8a1eYW-OgPlU8bFYqth2n-rZ52guvWMgyI0catyyodqPDS3gIBxhrFcu0Cf3eP9n3vcWl7SdIvcCsB6a3sYxZ1vAw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgesthdtredttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevff
    eufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsggvnhdrkhhn
    ohgslhgvodhgihhthhhusgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:CZXJaLEFzzdpwNnwhrbSJBFXrjjTzHWGW-e-f6pYxDUytgrdTNRGUw>
    <xmx:CZXJaIfz_4lGtNLXgZmtKijrA6pKpKPfZXgTZkyZEF_XhxN56JrPtQ>
    <xmx:CZXJaFEEDbf6a_cJnIoKQfilzFAAy-opBffyvUCibzT3zI-SkAm-7Q>
    <xmx:CZXJaBVdRj65ULYIHAs14gCs6JgXp5lzWezCgLcK7O31GUztHLsgMQ>
    <xmx:CZXJaAZ2IwURMigmg07NiIIrf1LX7aq1DyGSDepAY6rJo27bE53Msjia>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Sep 2025 12:49:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Teach git-stash to use --index from config
In-Reply-To: <cover.1757982870.git.ben.knoble+github@gmail.com> (D. Ben
	Knoble's message of "Mon, 15 Sep 2025 20:37:33 -0400")
References: <20250510183358.36806-1-ben.knoble+github@gmail.com>
	<cover.1757982870.git.ben.knoble+github@gmail.com>
Date: Tue, 16 Sep 2025 09:49:11 -0700
Message-ID: <xmqq8qieny0o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"D. Ben Knoble" <ben.knoble+github@gmail.com> writes:

> With stash.index=true, git-stash(1) command now tries to reinstate the
> index by default in the "apply" and "pop" modes. Not doing so creates a
> common trap: "git stash apply" is not the reverse of "git stash push"
> because carefully staged indices are lost and have to be manually
> recreated. OTOH, this mode is not always desirable and may create more
> conflicts when applying stashes. Use "--no-index" to disable this behavior.

I've read the patches and I think I can agree with all the changes
proposed.  We might eventually flip the default, but we do not truly
know until we unleash the version with choices to end users.

I agree with Phillip's comment on minimum tests to ensure that the
interaction between configuration variables and the command option
is sane.

Thanks.

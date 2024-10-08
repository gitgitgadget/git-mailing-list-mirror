Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E6E212EE0
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 19:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728414017; cv=none; b=fDGguc8V5ekZxnJYvOuSlJL8XgDl9+Qqa2Jz4WFv/TP533oJcglXw7WUBxdPNebQqstavKdA49zTTvi8nJKUJaOmT8UnrZWCovSrdik+D3Ex0A/3O6uz1hXNvsfwJwAtfNtuDQgEcgkEPjxXupYVjpRa1L8JOP0flJmDZxX86d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728414017; c=relaxed/simple;
	bh=jwSXkHqn3r4gepXwr5ZXoaDD1OfuEwY+KAfic4vTDQM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=as3mP7vKyzjnx2vfzDK5b3I47o82jumiNa+hA42juBX/YH39yPC70ho04jzSek3Vng+ZzTEXuRKuw+MeRLYitRTPA4dZH11JdzzjF9HYfGwYYzaJz/eFKbBjJTYcET3DOX/vU5P3Zsjlr4UlGoFTEYuyYj56wUK4zTx9S6OVGKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=wPEnCjzV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jvS+vba5; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="wPEnCjzV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jvS+vba5"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 480D611401FB;
	Tue,  8 Oct 2024 15:00:14 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Tue, 08 Oct 2024 15:00:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728414014; x=1728500414; bh=njk0POJ3vF
	hMElEUsS1FzaEh8xQthRwACMtd6ipajsI=; b=wPEnCjzV3Qm7aG6TUe2De9OGbf
	IoBx5JVpFaXGv2+/d8NlQzRR7Vi5P6BD6Zsj1OC39F2Lv5+5yjm/Otg8mLjwCdtj
	M3VXrzoMan0L1m/+5JUwQBPFWcH/WB5t9B5xf9iLifrdY5jgBsq/ZMCa4Kf40VDx
	bjx9kiHtfqDPs6Gu8D3vvI50Bdlfwbx979P9WaquA0gKgCJOiSGNrqUQPLMOh3ku
	oDlrvxYYoy9tFkGFDI/V+KHvvm7PPqQWBEhYjLVlTRMUsJ4O42TkCQtpH+r53qeJ
	JRRHattF5miFvIRzs3Vu+SYkzcPpDI+9PBnbUuqawWXBNWO4nYyah9XRi5BQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728414014; x=1728500414; bh=njk0POJ3vFhMElEUsS1FzaEh8xQt
	hRwACMtd6ipajsI=; b=jvS+vba5EeER1PNDgiuJIiflFMc90EZXtahgurRynSLi
	ONBo7PEBmBCKDpfzERVDVT2Eat+apFKelWAHrj1SJau0X86h6Uhtd7Ma9xw3HCIt
	v7eZ9sBDub9hNbWToKg1MQ/kStfKb014+EswNtlIphY2Xg2J2G3xDHIEcoNW9/AE
	XdFAut5hRPCCRpmRSG5m+IDAvzBqXLC4cJeOu64YtFxdoUrHTptpmjNc5newp/WI
	jwe6G9+VLcJSLXnoEaLtkEk+tX+Eze98P/U/e+dvABME/taQWuvd3ymrxw2ytI4k
	+yw+S8ZhtZzQ1Qnqziq0rd7CbC/PuZAya+awL8v8Rg==
X-ME-Sender: <xms:PoEFZ4VKWRg3RBbsJtllIH3FWff-hGrSoy0-X2bz2x5bzQ1v_6XLCw>
    <xme:PoEFZ8lUiudsfACrGwTjltUkGG-z-2EFBlDzkjd-SN59N3LKX5S0KJPxoLJE3-fYQ
    ahM4PpF6c3DwikyWA>
X-ME-Received: <xmr:PoEFZ8YHv0yKeY1ytl2YCHNYb5LUN9KewFCenO0aK1YrVTFhXFYBqVShvTmxXNyg7Xn4vh-XXQyqHWejdTHqLdmbh_PezdYJ2Kybcjs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefuddgudefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghvnhhulhhlod
    gtugifhhhithgvfedrphhmrdhmvgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtugifhhhithgvfeesph
    hmrdhmvgdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhm
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:PoEFZ3WfvXET9qgaSZSs6LpHJro9c7hVOGq5duiqVx1P1ivA5a7zvw>
    <xmx:PoEFZynHH30_fSwl3koRGE0obNFWQweVMyyfFxTAmWzXJTg1LgL2qQ>
    <xmx:PoEFZ8c-KXzpRiyOCRqvZjABtYx-EpQJELWxg1dZ7mb88IQHjfukEA>
    <xmx:PoEFZ0EWCNDCp67PaGX3MvwM09MERdy1NP6F78RSnNXoFQLcj2H6iQ>
    <xmx:PoEFZ5sGCkoJ4YHffkF8NB3FTnPdKL3TYJyEyuBLwSig-KOOY22mdP1s>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Oct 2024 15:00:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Caleb White via B4 Relay <devnull+cdwhite3.pm.me@kernel.org>
Cc: git@vger.kernel.org,  Caleb White <cdwhite3@pm.me>,  Eric Sunshine
 <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 0/3] Link worktrees with relative paths
In-Reply-To: <20241007-wt_relative_paths-v3-0-622cf18c45eb@pm.me> (Caleb White
	via's message of "Mon, 07 Oct 2024 22:12:29 -0500")
References: <20241007-wt_relative_paths-v3-0-622cf18c45eb@pm.me>
Date: Tue, 08 Oct 2024 12:00:12 -0700
Message-ID: <xmqq5xq21kub.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Caleb White via B4 Relay <devnull+cdwhite3.pm.me@kernel.org> writes:

> - Rebased onto 20240923075416.54289-1-ericsunshine@charter.net
> ...
> base-commit: 4ec4435df758668055cc904ef64c275bc8d1089b
> change-id: 20241007-wt_relative_paths-88f9cf5a070c
> prerequisite-message-id: <20240923075416.54289-1-ericsunshine@charter.net>
> prerequisite-patch-id: 78371f4dbb635e6edab8c51ee7857b903e60df8f

It is more common on this list to explain how the base was prepared
in the cover letter, something like:

    The patch was built on the result of merging the
    es/worktree-repair-copied topic, i.e. 992f7a4f (worktree: repair
    copied repository and linked worktrees, 2024-09-23), to v2.47.0.

To help those who are reading from sidelines, the above may need
some deciphering, as the patches as posted do not cleanly apply to
the base-commit 4ec4435df, which is 777489f9 (Git 2.47, 2024-10-06).

    $ git grep '<2024092307...charter.net>' notes/amlog

finds that the message resulted in 992f7a4f (worktree: repair copied
repository and linked worktrees, 2024-09-23).  So the right base to
apply them is obtained by checking out the v2.47.0 and then merging
the es/worktree-repair-copied topic (which is a single commit topic
with the 992f7a4f on it).

    $ git checkout --detach 4ec4435df758^0
    $ git merge --into cw/worktree-relative es/worktree-repair-copied
    $ git am -s ./+cw-worktree-relative-3-patch-series

And of course the series applied cleanly ;-)  I haven't read them
yet, though.

Thanks.


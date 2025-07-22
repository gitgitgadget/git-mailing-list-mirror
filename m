Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759F517C224
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 15:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753199235; cv=none; b=jPlWZwT2vR5n435EmFgt7qAYgS2ynTZCB3kWA+JfcZht2crDR53+ya0ihvS6Wc/Br0USUoeM5h7D1McqQOJO304fLiVXcdwgUV3aoVBigRMkzab6l4dZsbav2xNeiylp7Y0Do2/ypjSu33SSDGiuDMEiuy2YwyN8QdO8ZwQLthQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753199235; c=relaxed/simple;
	bh=/fNDBiR3y4VtpBs+6Fck62rgFCFDV7Qwy7sH0PP/Js0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bi+2gacBWt+83xNxVkkM+WhKWbampbKM4uhG8giJKwdlnkid0eC4OeWkVsOFRWW9rgO9T424+iEpxmAICWXe9iWVhIkQq7d34QtenLujKG8Q47QIt3OUDjbWneLTCSDtvFQoroVweQQvHV1GGTSdXPSQNQ7dkP251Lv1AKZlH5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jrCdRYBv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M4Ach6WI; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jrCdRYBv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M4Ach6WI"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 6FAF6EC01CB;
	Tue, 22 Jul 2025 11:47:12 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Tue, 22 Jul 2025 11:47:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1753199232; x=1753285632; bh=6yeQN+bFdL
	nSmCcU/PJjLrPAsMPdhifswkJCOx7Kadc=; b=jrCdRYBvGSWnpsLiTjPxwkw/zP
	OoT60911CNSVRiSqZ7R8o7w+cfAtxn1th5TmEtJmG1+rB3mB0Jes3C9D1LZgp2mY
	cihT0GNep+nLN53Vvfeoj10YRq7K9EaCpmKATLmmkflveXo6mLFYU2kqeKl+8uyg
	i6zo3r6o8yeiTas6n+CVKPQnSv2KzMVHDQuGqtflXB/IxhMK5n4IIjZQZ8Q7NOay
	owYKGYRg6cdN4lylujioZw0gqYioh08N7KVj5+bHNcwwgqzVp77XHuEOLlGUP7CK
	WdNjsFhVSy7eH42Kh4Nnt+HSijVtG/ZLB74SfqVzgyhtt4FkY4OMPE4kZWNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753199232; x=1753285632; bh=6yeQN+bFdLnSmCcU/PJjLrPAsMPdhifswkJ
	COx7Kadc=; b=M4Ach6WIQ5v+QmNEgZdx9WsGAiKnQ0wVfAFFgAeinZDmCohb4bO
	mjjwZdxll/aennpucQSPsBg3Xl6vhsQ2ug2aoNr+BV2gygO0jB8hYf+bn7xWP7iA
	VLwtzuowdwdh61ouLcBXWCUEnnvVIyZPY9kjJK0WA8gESVPkA1k3BcECwMzi8Q1h
	WCyPcqRpuP8kehimAAif1teF6Jf47WpxzYNxdhRBoTh9AQHlYT7RE12pnq2AYOjR
	gOmmew2PONYkOt4q3MkHQg9NcAjy8fFQmml/6Y5WKvsmpbncvWtO9ArOhrsXeZoJ
	r5rfzeoVtTpLtrUatACTRElaEVk7/Z8IZeA==
X-ME-Sender: <xms:gLJ_aDonEcyKUDNpxEnmFgcyWRWo0R70SoJPevFDMULNUdG_xakIpw>
    <xme:gLJ_aLOrR60YVGwg32ngtDN3IrZzfK__WTxTxC434EdZKe30Gq7PJoUj1wcIRnzod
    7LTq9ObzU5iJz4YsA>
X-ME-Received: <xmr:gLJ_aGpbej0_flF4t6irGZsbCCrBY1wJVKLRHbVL7IAgRUQkDeLpDXJDMVDcNRbHbS8xixws9RAZTVDu9La3s6dBG4za0aZuttDSJ8I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejheeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfefiedvudegfffgffffveevvdeileff
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgrghrghgrughithihrgdtkeeslhhivhgvrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehs
    uhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepkhhrihhsth
    hofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohep
    sggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrnhgurghlsh
    estghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:gLJ_aIf8ppQ6OFnjQr6iqUyiDJKaoltCN0Lict0c-RdznM_I65fOmQ>
    <xmx:gLJ_aEQvvIISFwi27ZWpgTk1lcSgQEGORy5umzUUb8qoS-V_ISiKOA>
    <xmx:gLJ_aJaTIbu18FiT47nRxzX-pr3L6OBjJuwqBxGtEpaHt5-pl0tIGA>
    <xmx:gLJ_aPeVlYh0HVSd8IS-NJZPPmdHawf0oiwdiZIrpzfcH5WpaTyg8w>
    <xmx:gLJ_aKsFThDC6ALOTqaQelw8ZCWxDasZ90x1rkxL2KadXA0_edpndGgT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Jul 2025 11:47:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Ben Knoble <ben.knoble@gmail.com>,
  "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] docs: explain how to use `git imap-send --list` command
 to get a list of available folders
In-Reply-To: <20250722114246.20422-1-gargaditya08@live.com> (Aditya Garg's
	message of "Tue, 22 Jul 2025 11:43:27 +0000")
References: <20250722114246.20422-1-gargaditya08@live.com>
Date: Tue, 22 Jul 2025 08:47:10 -0700
Message-ID: <xmqqfreotegx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Garg <gargaditya08@live.com> writes:

> The output `git imap-send --list` command can be a bit confusing for new
> users since the IMAP LIST command output is very verbose. Help such users
> to analyse the same by using an example output.

The documentation added by 067a91b0 (imap-send: add ability to list
the available folders, 2025-06-20) is overly insufficient, so let's
queue this update on top of it.

But I am not sure if "very verbose" is a cause for worry.  I would
agree if the argument were that it is not very friendly to end-users
to throw raw IMAP protocol messages at them.  But it is what needs
to be fixed in the implementation, not papered over with
documentation.

Thanks.

> +GETTING A LIST OF AVAILABLE FOLDERS
> +-----------------------------------
> +
> +In order to send an email to a specific folder, you need to know the correct name of
> +intended folder in your mailbox. The names like "Junk", "Trash" etc. displayed by
> +various email clients need to be the actual names of the folders stored in the mail
> +server of your email provider.
> +
> +In order to get the correct folder name to be used with `git imap-send`, you can run
> +`git imap-send --list`. This will display a list of valid folder names. An example
> +of such an output when run on a Gmail account is:
> +
> +.........................
> +* LIST (\HasNoChildren) "/" "INBOX"
> +* LIST (\HasChildren \Noselect) "/" "[Gmail]"
> +* LIST (\All \HasNoChildren) "/" "[Gmail]/All Mail"
> +* LIST (\Drafts \HasNoChildren) "/" "[Gmail]/Drafts"
> +* LIST (\HasNoChildren \Important) "/" "[Gmail]/Important"
> +* LIST (\HasNoChildren \Sent) "/" "[Gmail]/Sent Mail"
> +* LIST (\HasNoChildren \Junk) "/" "[Gmail]/Spam"
> +* LIST (\Flagged \HasNoChildren) "/" "[Gmail]/Starred"
> +* LIST (\HasNoChildren \Trash) "/" "[Gmail]/Trash"
> +.........................
> +
> +Here, you can observe that the correct name for the "Junk" folder is `[Gmail]/Spam`
> +and for the "Trash" folder is `[Gmail]/Trash`. Similar logic can be used to determine
> +other folders as well.
> +
>  EXAMPLES
>  --------
>  Using tunnel mode:

Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689B421C9EE
	for <git@vger.kernel.org>; Tue, 29 Apr 2025 15:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745942257; cv=none; b=V/9gk1lhDGyIJKcNpY0Qvg9ejJsSXEjQ8HWyO+2FYYPAHDx+QEx165COx2P1IdyaZO9l04p230aSYI87MnJRYPj28xfeKdlzt06GGttdxLzaNla3uq0Af4pmRaj6NBSLy6hr/rp3eUa2YB4zGs6oLTjB0EnempS2dZfG5flj5Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745942257; c=relaxed/simple;
	bh=psQdVli4kUg1ENCtKOvk7fvnwd5Rg9S1o9EtBSYkDGw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AchKIjYougKZxVTelkvfK5NHHML3maMfv9PrnklYdp0+8azo9Dt3vmlREab3jIR2KRJch7bN6LeluUs+HLHdp04hzE0Me7Tp/PjFa/Jcf0/45l8cx5R3dE8LRSQ7rjZjIVqNL8cVtRBctV2VmTzs+7SGYaXzdoL1eEMqcIKc88s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XWX6r2Lu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GmqAnCjg; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XWX6r2Lu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GmqAnCjg"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 6C69713801F1;
	Tue, 29 Apr 2025 11:57:34 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Tue, 29 Apr 2025 11:57:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1745942254; x=1746028654; bh=Zwqy4UtHDz
	X2uPu1zi9V7NYgBjMbb7ozlgXLILNYnuI=; b=XWX6r2Lud+HuSV2b/8X+QxoRPM
	MpJVbReoGKJFGeIiOCskzrdqJddY2SLQyQf+reVgGk2Y9Ubagf4PiRbZIPLMuuCw
	yIP4RHVgBrciY2wrLKWuWKUXc6WC5/WOma0IDXpWENZJmT9/Sv4mYnMWg2BrzXyQ
	mErpiEB4qLNmXv5ykLVO3HoSwTLeaRpzGvnnHglUboifHVvNqUzRwtlXMTRE7dJD
	wmSUl0vxRPY2PjyzTZ+7/UTjP0oUaOgcxRNufYSe5RCpWyZmppDzh8iK5Q6IW+9M
	DYmmGpPp4AWUaBpbMAwvx986p1WWMbCOZgYAUjhBJIsw7PYOrpQgtiDOqJRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745942254; x=1746028654; bh=Zwqy4UtHDzX2uPu1zi9V7NYgBjMbb7ozlgX
	LILNYnuI=; b=GmqAnCjgZc54S9Xd1yXUj+AkpHCT7irJivjCM8kdmmT6pO9GX62
	jB1J6ZKJWfcdgKjDB2B5+5yqbD/PJ1Lxx1B5ZFXOAhFrg2swM4D/zv2jJ3ubhF33
	L9Su1SjlEQq05ECM+9CUgRLvf0nsNJtrNjF9lkf+akYF8QC85cCC4biBkcV4SOkF
	A5EJF5uxmfOLgGBt6iODpNAikbuSzIdndQBki5XqQTYktqSDYfGhYNucb5FlRE0L
	xg7JLzwMa9RJ4zYH1/4p7YFej4v9pWZnI1EWH2oKuYfDA5P9E4JBIliuGNUUwR4q
	OHlmx4M+nkHjeSpyNxzSmUbJ7eEEC+E9xzQ==
X-ME-Sender: <xms:7fYQaITuIjwE1KA-vX6p9WUHIffj_SrzH0v0yitzc6b0VAYVf-w__A>
    <xme:7fYQaFxC0J5DC2VB2P3-0g2Q83gvKvbFSaVewuB4uVvfaFl-pj-fpgLoMAojBN9n0
    BRyaLV3WidKvsLvNQ>
X-ME-Received: <xmr:7fYQaF1Be6b9FdFcx2ROWzIID-JYOitsvArzvTFWonuzrw467R7VGFNFeDB3g4sxy1lynfnP_mrWXKz8UFY8G5UW_GP-HskSB18a>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieegvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepueffveeifffhuddufeehvdelgfdtgeff
    teevueefieekffetfeefuefgueeufeefnecuffhomhgrihhnpehofhhfihgtvgefieehrd
    gtohhmpdhouhhtlhhoohhkrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtg
    hpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgrghrghgrughi
    thihrgdtkeeslhhivhgvrdgtohhmpdhrtghpthhtohepjhhulhhirghnsehsfigrghgvmh
    grkhgvrhhsrdhorhhgpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehmihhrthhhrdhhihgtkhhfohhrugesghhmrghilhdrtghomhdprh
    gtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdp
    rhgtphhtthhopeifihgrghhnvdeffeesohhuthhlohhokhdrtghomhdprhgtphhtthhope
    hgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopegv
    hhhuvghlshesghhmrghilhdrtghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunh
    hshhhinhgvtghordgtohhm
X-ME-Proxy: <xmx:7fYQaMDO08vgDybAieRwvGjcw5htQYrgcS2LaHnKoluR1FvOAn9-mg>
    <xmx:7fYQaBhMM2oNFvvlPZqEnmJC33-WKQtY4hlW2M4pjdj9F-xPjBGj3A>
    <xmx:7fYQaIqSO8X_l0Z7bfsSnYT5ldlyB4dZh3bGHbr_pHsqjbtQj6jqSg>
    <xmx:7fYQaEjy2rV2q2Oentj_nVsRrL-bTwOY_BYv1Qo63qcNHffLwrO84w>
    <xmx:7vYQaG4GPIC48cru13SJWr1X9hOJRvhf82FR4q2KaI9ANiWHAERXfgBu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Apr 2025 11:57:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: Julian Swagemakers <julian@swagemakers.org>,  git@vger.kernel.org,  M
 Hickford <mirth.hickford@gmail.com>,  sandals@crustytoothpaste.net,
  Shengyu Qu <wiagn233@outlook.com>,  Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  Erik Huelsmann <ehuels@gmail.com>,  Eric
 Sunshine <sunshine@sunshineco.com>,  Yao Zi <ziyao@disroot.org>
Subject: Re: [PATCH v3] send-email: add --[no-]outlook-id-fix option
In-Reply-To: <PN3PR01MB9597274E541169BDB8DC4297B8802@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	(Aditya Garg's message of "Tue, 29 Apr 2025 10:52:47 +0000")
References: <PN3PR01MB9597DA8661D1AFDF4C927A11B8812@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597274E541169BDB8DC4297B8802@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Tue, 29 Apr 2025 08:57:31 -0700
Message-ID: <xmqqikmn7yfo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Garg <gargaditya08@live.com> writes:

> +    --[no-]outlook-id-fix          * This server munges Message-ID. Retrieve it from
> +                                     the server.

We know how to retrieve the new message-id only from Outlook server,
but I fear that the above does not convey it (unless we count the
substring "outlook" in the option name).  I came up with

    --[no-]outlook-id-fix          * The smtp host is an Outlook server that
                                     munges the Message-ID.

as a replacement, but I am not sure if it is much better.

> -    --no-smtp-auth                   Disable SMTP authentication. Shorthand for
> +    --no-smtp-auth                 * Disable SMTP authentication. Shorthand for
>                                       `--smtp-auth=none`

Good eyes.

As long as it is mentioned in the proposed log message, it is OK to
make such a small and unrelated correction "while at it".

    $ git log -p --grep=While.at.it

will find many existing examples.

>  sub is_outlook {
>  	my ($host) = @_;
> -	return ($host eq 'smtp.office365.com' || $host eq 'smtp-mail.outlook.com');
> +	if ($outlook_id_fix eq 'auto') {
> +		$outlook_id_fix =
> +			($host eq 'smtp.office365.com' ||
> +			 $host eq 'smtp-mail.outlook.com') ? 1 : 0;
> +	}	return $outlook_id_fix;

No syntax error here, but let's have the final "return $outlook_id_fix;"
on its own line after "if (...) { ... }" statement.

Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54B421D581
	for <git@vger.kernel.org>; Mon,  9 Jun 2025 18:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749494541; cv=none; b=VedQY12TV/wVe4ARmkdZQXoeebJv/6CQInsqbfApqMNuUObH4AAhzSXs7OLBSDYEIyXhC2BtBXo7aH2EYUlYBXo+2Q/s71sh6D8bey6Nh4ShGSf1+ooxoxBNGG7wZKsIifWOKd38AFlPLZ9tgvuEIv+NsQYs/Bcul8R69dC2wFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749494541; c=relaxed/simple;
	bh=YzTwG7+0TsmfldoOm1PsCADHNx9oir/g8RiCmRKN5Cg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AGxVcbUWj6U3P3GWOaCskiZZjuF2hfTLk0P/b/X0VNtvBlfL5DIph29+4p+pT7Kczkwt/RX2M7ONm6UaCzm9fJ50Bt2muWAicOELb5PhlMjLG7ZYsBC0fViAyw/CcBMN3VNJMUEHHVgw53kbTtUGBIH1XrCzxcPtWV35LKZl8+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rn14ztMM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MuHa42d3; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rn14ztMM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MuHa42d3"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id CD9061140366;
	Mon,  9 Jun 2025 14:42:18 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 09 Jun 2025 14:42:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749494538; x=1749580938; bh=v0XfNRjoNF
	wNFBkKPHzWrSJEslNCAooMH2BwS04rMKg=; b=rn14ztMMzzyUMulRYDabnQ11r9
	273vFk1qFWteQyzZ8bACS+3wLmETp2JtZj7BCsd+j7aw/63e5Uc0I9y+vtThtE4k
	8dfCXILJZXeWQQ3TqHIbJL91KyhBSy1QcVnom8dpO/aoiS12kzElHa3Q2IRpUV/E
	v1YU59i1lH7Y5WumUKpBTiABfpZvSUKj9wxjkHmkZ4y2o+PTzH9LYlBiB6BZzcAv
	qCTavZmdh/PmLXrYDD2EOd7Efkg3KpRFbEFs+Zw4HGZiLAX3BOQiO1ozgGuOj63p
	kxRHfMdoJ6aBIclnU26InWb5zXtr5jQJ3Gp/lFlDH6+DZlF+yzUbHi/kc0ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749494538; x=1749580938; bh=v0XfNRjoNFwNFBkKPHzWrSJEslNCAooMH2B
	wS04rMKg=; b=MuHa42d3dUaH2KFuHAidhi6txCZgczMkekMcG7hDc1+9emQ9fAt
	t9X5flqvq1g1Luy7xgyRNjC+PU2axaT1phkEdvc+CxxVyD9g1V3br3AsXtUbnnPG
	qjU9Jv9lUjJX9VpBr8F/z++UJxLy+uarf+NtQ9r2l5co3P/HnqiPCDKR9DziqHyN
	2FFiMikA4dTHz+8/usPrLBu9VeR3lTbMnXPIuIwpuuhlvy6KXV6WTq9m6UEPQ03q
	XXTC67hexSQBc+JwE+Gb5I9JTc4tQ4DnkVNHp5n1voN1I4X6jk72OLl+b8wGZQ2Y
	k5RBN3cBWwByHlAX/4Tr3ByCyd3+mLnlc6Q==
X-ME-Sender: <xms:CitHaOQ7_AqUlbti1k0fPXV2sK3HVI9-qw8Y9UF9WtPf3uU7Bho5GA>
    <xme:CitHaDx0WoHa1dW45Kt9XT4gwT-duRyYDmzHHXjjJ1FKyrCDSA_uyZ9doe5lkp3i9
    cmLdDU9_TCFglL92A>
X-ME-Received: <xmr:CitHaL29oX5_D-TxAA4Ud7bu92TZMKmPnps1sESrmMG8cOIxLv5A9OBGnluL_TXPOc5w9uCC8EhXzB4ITTV434Ze8bnI1hPBusVQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdelieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghgrrhhgrgguihhthi
    grtdeksehlihhvvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:CitHaKADdVCRQIvPMXDR4fK9DbKH8t2tdt-IDbqd9tyFNcoFbY2g-Q>
    <xmx:CitHaHgP2LZHGQB_7xSE0qKSGXekjrRC-O7cuekB6D1OKyZRrulLtg>
    <xmx:CitHaGoCa8tIl3ghioasqWxrA1PbNZ1ddWzae9Bg6F8LzWVPcD2MpQ>
    <xmx:CitHaKjUEFlA8dI7rjet7oUiMcjQT-g-mHibYlxsKJ3FL5kmHVJhEQ>
    <xmx:CitHaAQR2P1TBxkUGMaSootMhB_90adXLy1ToYpaVJccH6ArDFoFiMcl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Jun 2025 14:42:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: git@vger.kernel.org
Subject: Re: Question: is there a possibility of getting a warning before a
 git push -f
In-Reply-To: <PN0PR01MB95880EAA98466C9AB049BA44B86BA@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
	(Aditya Garg's message of "Mon, 09 Jun 2025 22:16:52 +0530")
References: <PN0PR01MB95880EAA98466C9AB049BA44B86BA@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
Date: Mon, 09 Jun 2025 11:42:16 -0700
Message-ID: <xmqqldq0rc3b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Garg <gargaditya08@live.com> writes:

> One thing I sometimes encounter is that I sometimes git push -f and
> moments later I realise I did it at the wrong time, result being a
> disaster. I was wondering if a little [y/N] warning could be possible
> before the risky command gets executed. I saw the code for push
> superficially and I don't think it's implemented. I think it would be
> a nice feature though.

I suspect that an even nicer feature that is more generally
applicable is a patch to your shell to make any command you give it
is not run for a few seconds to give you a chance to kill it with
^C.  You do not want to run around castrating a bunch of commands
and features like "git push", "rm", ">overwrite-with-redirect", and
all the other "destructive" things you may regret doing.  There are
literally too many.

Quite honestly, "-f" or "--force" should be a hint enough that the
user wants the command to do what the command usually does not allow
them to do to avoid potentially dangerous operations.

I would expect that many people will truly get annoyed when "git
anycommand --force" starts asking "That's very dangerous---are you
sure?" for confirmations, and would complain "Yes, otherwise I
wouldn't be giving you '--force'---just do it as I told you".

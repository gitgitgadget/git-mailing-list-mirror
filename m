Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C432EC0AC
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 22:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760480980; cv=none; b=TpEyQe4R1LW1ptZJEW9VSlxmEBDOXReJbwYLutt577bKlqRjyMqjJrWjgWMtXz/Elcfe9peEPwlwXRYLheGO6DeHe0Nx9EOh4cbR6Jev1s4qFT7MRxUe8XV1SECIJH2WZeYxgBhyLwGTH+vPc0e7n8zBdzECNTmgBQpARzWeaA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760480980; c=relaxed/simple;
	bh=Qkm3yeGLQ++VbwiwcOu98pv7IO7Gfb3EW/QVK8iHwY4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=saPlDE8U6xjf84eLSwLQ7zqlKGUcSgOUdlMieXpy7iRw3g8feaq1qzVNfDGs8CjFAEHmRbaP9BwomX7MonNXkmhfziardYdzZ79OdsW+ous1TTOiBEXgr3MOnz9qa6k9DUErPR6+wXB2jaDtwiN02UsDbhUZyTmKHxSvv7eFCEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LdO9uE2x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Yh5+9MNn; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LdO9uE2x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Yh5+9MNn"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id DD0E01D00077;
	Tue, 14 Oct 2025 18:29:36 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 14 Oct 2025 18:29:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760480976; x=1760567376; bh=otjp1/94z5
	mTr/5M5XN4nROiTc3Uwjr3l9/UMx5xyEk=; b=LdO9uE2xPV4ZH0zu6txqFDah7V
	dokT8pkV7/884w8eInQP2HxUDmDVIdK/WjcgaEfUH/FgtkeEWZLUImf691cIhcJo
	soTZJdIfOB3Ki+3d7yuOfrdBW/VAcAB31pptCVWMicS7pg2xhFhdk9Wr7e09Rm1w
	E/H+3nNn1/VgpZLG9FTrrU98UYke42ZejJriCdh2AR8ciAs4sNeIF31kf6HmhU1u
	frBuDpUROCw+7hqw1eH49gfYzHi1/O7Fo03NifZnel4QBnc104jkChyNAjV0D9sE
	2F38d1Z5z2fxkl0mgXLM7MDLtDB5ZTutbkk/EJ6BumFZnqdBrXlRiXMTzyVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760480976; x=1760567376; bh=otjp1/94z5mTr/5M5XN4nROiTc3Uwjr3l9/
	UMx5xyEk=; b=Yh5+9MNnqBO2805EhUoWk4Cd+DayA/NUvG4CVcsCaAvToQ4lLxe
	KO2F8eqG5sC6H2ryb8bUTWcpOxzmSsDOrtpq+PEBzpHbixarTQSZm7bAFvTViPEX
	eiNu/j9fnuMXwLj4XRM7iq6rQE80XCChiAKPuBqXnZY/HmH2D0wYFn7MAdPpmcKa
	Hz+cWkhYrDzXzP1Xjw8TmtCTBp3z87TrfLL68BR67gCHoo3h2OtAFMXcw1oY7V0y
	OENaC5BNN4XIb15G12OsvwW6fh9O/hmK7uoCHHbVOoZ/G96WpBEPjD4fhCc9rTM7
	bTujRyrtzKjECT7rkaBqPZMmj3UfRvuR5yg==
X-ME-Sender: <xms:0M7uaOJ7nFN9Np71nefD31I74S21HtU8Jso0F1KpeESR4MjgipBYGA>
    <xme:0M7uaNKLdMQXm0SIn2iY7BuGPfMUOcLa6T6KXmif9gao_V5O33_JzXNOpmfOumo0F
    XR69Jk2Q20R6wXxSXmlUFa5heOzrNXqFCQyJl3UquZLwqDM8-iSx2g>
X-ME-Received: <xmr:0M7uaDtCwMrrU0X0XqH82eKBbsUkn3FrC14HFipmfpZAMogSBPovBBeQDdewP4sr5zKp7nTa2oZJvzHUFthIVhtKqB9X735NuGsE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvddujeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprg
    hsthgvrdhnvghtpdhrtghpthhtohepohhkhhhuohhmohhnrghjrgihihehgeesghhmrghi
    lhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:0M7uaCRD4SC1f8x32lC8RgynTkbAzbwRUsaYa7gsHaLSL0VVF6SrsA>
    <xmx:0M7uaBMkrSwbO3JbKLiXPI6z_d51wJmWwH_mge1yombcXUwpTxwmww>
    <xmx:0M7uaPa7O56_VbI8dpYZyDAujjbOEbRxzpd3F1P7E4U_rCkQldBLNA>
    <xmx:0M7uaDwfAS0TvPqSJAWG60bxLntax_R4jVt4sf41A2kQx7qjnTJYFQ>
    <xmx:0M7uaF9Cy_rD5JXUUV9pbHATqdddDV6UEqsgoLeVW9zvYivspYrvHKv5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Oct 2025 18:29:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Okhuomon Ajayi <okhuomonajayi54@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] [PATCH] [Outreachy] builtin/patch-id.c: clarify SHA1
 usage for patch IDs
In-Reply-To: <aO6-LBqhW87GWD-5@fruit.crustytoothpaste.net> (brian m. carlson's
	message of "Tue, 14 Oct 2025 21:18:36 +0000")
References: <20251013174658.236940-1-okhuomonajayi54@gmail.com>
	<aO6-LBqhW87GWD-5@fruit.crustytoothpaste.net>
Date: Tue, 14 Oct 2025 15:29:34 -0700
Message-ID: <xmqqjz0xw20h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

>>  	if (!the_hash_algo)
>> -		repo_set_hash_algo(the_repository, GIT_HASH_DEFAULT);
>> +		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
>
> Hmmm.  If I run git patch-id in a SHA-256 repository, then I get a
> SHA-256 output here and it's worked this way since Git 2.29.
>
> I know the comment says what it says, but I personally disagree with
> this approach.  There will be a point in time where SHA-1 is so weak as
> to be useless and people will want to build a Git version without it.
> For instance, many government agencies around the world have a 2030
> deadline for completely stopping all use of SHA-1.  If we continue to
> use SHA-1 here, then this will have to change anyway in a few years, so
> we'd be better off keeping the default algorithm for now and adding an
> option to control which hash is used.

I do not quite agree with that, as SHA-1 in patch-id is merely used
as "a hash function with good distribution that we happened to have
handy access to" without any security requirement.  Being able to
compare patch IDs computed long ago stored somewhere with patch ID
on a patch that claims to be freshly written and find them the same
to say "you know, somebody wrote exactly the same patch 7 years ago"
would be valuable, and we do not want to lose it even when you
happen to store your payload in a SHA-256 repository.

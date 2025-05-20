Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDBB22DA0D
	for <git@vger.kernel.org>; Tue, 20 May 2025 19:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747768753; cv=none; b=UzBEt9yvTFLpUz0VIf95CI4Y7poeA8p2zMZaiRoony0PriwYM7IPZiVR7jgIg8qSAwSgE+HMWLJmRvpPgKqEbgnJ3nkSugrW5UJ4GdPAjmzfVSO/CBGRecGEs4MI774VKsSFxSoOncTWw/RHCp4XDcBIrLbVJR9dVPASU5pjIuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747768753; c=relaxed/simple;
	bh=kaREy/yJ740ONa78eIOJ9G8K2Y0l2qzBoupjSMOohhM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UF1rUuj2pxjgpjU1tfZNSyldUM/pcrp7LOFyF/FYxrgtkeZM/BsU57AvpPuHl6uSivtxmt0PigeLc1uXnikQoN9RyI7Gz3/E4Sj2mHj+Of5648B/FDunbJpyEAWOI/KnwAkz64IT/lKNsA5iyMQYOHMURdcDtaocmG5y1xSd/Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jp9BZQAc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CsuWLVPP; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jp9BZQAc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CsuWLVPP"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 3674E11400C3;
	Tue, 20 May 2025 15:19:10 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 20 May 2025 15:19:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1747768750;
	 x=1747855150; bh=wFIPSPQy16xly2hgqk11EP9PpcZ8Hj44qVhnAvLinXQ=; b=
	jp9BZQAcp0t1XecyXkanQ5XT5shZFe4GXa4eAwDMwurG6fwdsRK2fUrEMWoc2ZK/
	ZoUgfqfDG9vBoQC+ygJz1vbweU0a2jW3yQx2gBjATflI1dzNT9nMzbkn9mFFTUni
	3EQ5/n1xiohpt3VplyJbACcaJ9vO/fiKTmz/r6bPTqQKXm9Pqqg0by1D39HQLjh3
	qMPrl+mE+V1BIhCjZWyfLPCBJmp+Asu1vxpmSCcniVEJ3Zl/GehbZA8bBLw5KmKO
	4pwHGLsPNW6ivwdqqPedKXSCzNvjmzdkZMN9HzE3bmHDyWGE5QzwhYkxj6MqXPOP
	1pm//IJDUDieUtWUCyJvyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747768750; x=
	1747855150; bh=wFIPSPQy16xly2hgqk11EP9PpcZ8Hj44qVhnAvLinXQ=; b=C
	suWLVPPa/yaiuG0Xc9SsE1+cbJvv8243j5NyHXfh11wTRsZvhs8tIsrqkBj4o1yj
	I/G2lhqanB9RV38NshFNNCSTFZMPa+Qmf9th9C+KGR3B8nlotaJQ1CCIlIgxHqk+
	i0nEB4PVP4osF56LoyX2MvhkWQ2VisUlmmSCNovj9NjFcsfyRrcC8NpfvffcuL+3
	V1jetQk7xg9/Vbb0wgSYcUGauKm+SzFrvepzVa7cbcClgRBQ9rfK8DOWqZEOyiFE
	q9UP0XCywsKQL7OTxsLdqRvj3ZPOjXnnVS1JIfxtzJuSt30k9tQkiTqGNOEYWGR0
	gj3JEaWFtOcK3OCgdDaSg==
X-ME-Sender: <xms:rdUsaA3lX_kgjSnSNm_GEoFkpmf79sS_4Boo2e2A5I9acHTv-cPkFg>
    <xme:rdUsaLFQkAuGATqcj3TbBJENjztNaV4Ws3jEf17SpsmRKlqVvG5voe-Qk2Uls1qg4
    66HWvaUMlj_1cq-Jg>
X-ME-Received: <xmr:rdUsaI65fW2Ac0MS4IUdyb_tG5HshpSZyUrLtV3Dj7QlO61xdMbRJMmDzKnjemH5vyiAP4MsviDxOVOyqQMVZ1DbTp608uG1FaQT468>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddutdefucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomhep
    lfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqne
    cuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedv
    keehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgsh
    gsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrg
    hmvgdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepugihrhho
    nhgvthgvnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomh
X-ME-Proxy: <xmx:rdUsaJ0BCQsd9t6iv--qVNcEa1C4i_mtD736nT432OY8-6zUDbzbFg>
    <xmx:rdUsaDGCSKkHMoOaXwk-iSbGpisln0u6I-6izdjNAN8FD_xVpleSqQ>
    <xmx:rdUsaC8R6jzMFdAfXrQkdIxA_oovLR20Wi4G1Z2vfbNL4H63-2p94w>
    <xmx:rdUsaIkcC0e3bbLs7l_2_Ebu5HinHMUxkFTNVDjFRjFXdAbUePNBPg>
    <xmx:rtUsaDpX0RUe30nS6BbWbSdxt0vIecRxkdelukh0MzWo6r4TfSouaGsK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 May 2025 15:19:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>,  Jeff
 King <peff@peff.net>,  Teng Long <dyroneteng@gmail.com>
Subject: Re: [PATCH 6/6] doc: notes: treat --stdin equally between copy/remove
In-Reply-To: <68e5eb78040419ba64e256910501c7e37194b222.1747763769.git.code@khaugsbakk.name>
	(kristofferhaugsbakk@fastmail.com's message of "Tue, 20 May 2025
	19:57:24 +0200")
References: <cover.1747763769.git.code@khaugsbakk.name>
	<68e5eb78040419ba64e256910501c7e37194b222.1747763769.git.code@khaugsbakk.name>
Date: Tue, 20 May 2025 12:19:07 -0700
Message-ID: <xmqq34czhyz8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

kristofferhaugsbakk@fastmail.com writes:

> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> 46538012d94 (notes remove: --stdin reads from the standard input,
> 2011-05-18) added `--stdin` for the `remove` subcommand, documenting it
> in the “Options” section.  But `copy --stdin` was added before that, in
> 160baa0d9cb (notes: implement 'git notes copy --stdin', 2010-03-12).
>
> Treat this option equally between the two subcommands:
>
> • remove: mention `--stdin` on the subcommand as well, like for `copy`
> • copy: mention it as well under the option documentation
>
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---
>  Documentation/git-notes.adoc | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-notes.adoc b/Documentation/git-notes.adoc
> index d2d7dac8d41..1542850eaaa 100644
> --- a/Documentation/git-notes.adoc
> +++ b/Documentation/git-notes.adoc
> @@ -127,6 +127,10 @@ When done, the user can either finalize the merge with
>  	giving zero or one object from the command line, this is
>  	equivalent to specifying an empty note message to
>  	the `edit` subcommand.
> ++
> +In `--stdin` mode, also remove the object names given on standard
> +input. In other words, `--stdin` can be combined with object names from
> +the command line.
>  
>  `prune`::
>  	Remove all notes for non-existing/unreachable objects.
> @@ -208,9 +212,9 @@ See `core.commentChar` in linkgit:git-config[1].
>  	object that does not have notes attached to it.
>  
>  `--stdin`::
> -	Also read the object names to remove notes from the standard
> -	input (there is no reason you cannot combine this with object
> -	names from the command line).

The original was really bad, especially if it ignored the fact that
the 'copy' action also took the option.

> +	For `remove` and `copy`. See the respective subcommands. This
> +	option can be combined with object names given via the command
> +	line for `remove`. However, this is not the case for `copy`.

During my first read of this paragraph, I somehow read the first two
sentences as "if you want to learn how this option behaves with the
remove and copy subcommands, go read the documentation for these
subcommands", making me anticipate that the remainder of the
paragraph would talks about what happens when --stdin is given to
other subcommands.  Apparently that is not what is going on.

It may be simpler to just say

	Only valid for `remove` and `copy`.  See the respective
	subcommands.

and stop there.


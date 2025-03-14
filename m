Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5ECD17BA1
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 23:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741994628; cv=none; b=piamSzgIVxJdtxel3puWB5vhKKkgUZQdIUUuufRT6J114JEwgdXgb2wRP4+iEjghwKihcXhkLomFsc1OId2CG6G38B01wNTHs1I89LfM6k3L+5joeJkBtKuVzWDMNxWWWt0dZJuC2Nm3erYHafrFw9yHDdbVtd9bTp88GJDoZYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741994628; c=relaxed/simple;
	bh=3MZ4diqYpDsBuji//o+IpIq3hHUjHplv1yTt5QAnnqs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Uq3GmIp6hvIDiopmG40mjrZqiZTKVnmlQU5JX1KmIivz3lGkrX3IhHHzUwTA4l8V9M+5/+mT4/yvE3qj/3NyXEjHwYx5rtF5EHRz7tY5yZwm1W6vq3AU27LLWUnd6RuGClO662tVTIlgDu0dWRbQOQN1xgH9yh6/GQEfQKO6DK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=e83hs7ns; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gYquuH72; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="e83hs7ns";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gYquuH72"
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E87D51140227;
	Fri, 14 Mar 2025 19:23:30 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-13.internal (MEProxy); Fri, 14 Mar 2025 19:23:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741994610; x=1742081010; bh=EuQbK8m+ST
	PjH/iT3GEBNrFqwYliiuHxj1vJofFp1+M=; b=e83hs7nsP9TCLkDr6NsslCe4Vn
	e/2BdEidVgx/RQMjClFQ8UF5o0hmTMAvDA3n/dPw6xLXIjhUiMJsHv+VT+VwKGXt
	wtl4/Y8sQe+E0j+vXt2BNijn7EOSG3/S3pbU9gYvdaT84+gNdd99tkiqYQ9kq3Rp
	cIdIEjutBzd/dGFDN48wyJQRVkoCYoM2cEsx5iJUmaKRgKb2SK6UiZxbHDUt6ol1
	iaw4N2gBl3JT6DuxYwYRXD6A6ct3LjsvYKo38UAf9sKyrMN/ilroLZpw8eBHXrhF
	zMTEQPwwDcp4b0qkfcCgO28Mxbir5TP+t6XFZ8QAWPz1jEdpaFMswqZwGdbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741994610; x=1742081010; bh=EuQbK8m+STPjH/iT3GEBNrFqwYliiuHxj1v
	JofFp1+M=; b=gYquuH72X+F+/aweYi8ixXih/IPnbH8UVOYE01GpAzwxq03Qv9J
	AW4hTFqFq90LoYo7W4e6BsKjgt+CxmWc7DcwaKwdygP/3cn6qvnlBjyQXPeeLVhl
	fXb+KlKAFtNsVHYV7boaZFTahUwbCR6gdoKGHlrQtmp/GuQwfw6OVtFiqns5G41/
	5GVdYsQ9RRRwfMiicoCb9UM0PNGR/NrDd1KxVCj3Q/2MMjRjj472Tv36RQjLWTgD
	t5eYWwca37vqx49dY41k4XRtBNfLk1KDQ2CIXrc5tWDjKfKze/Go1JM/nOecRq4k
	Ty2bmFfP06OSOcuL2RYr0+ImMXjPEdCcMsw==
X-ME-Sender: <xms:cbrUZyUnZm6rrH7A6vtwRRJgm_QZIn_Z0tI-oOuU5_DkpohzMWTqEQ>
    <xme:cbrUZ-kEvDwqlfA5AAZEWgX1ooUU1fpZqPNqqdEAkPYuZszHjLdnsS_0_9aswcOtc
    lWbVOUZNuunwuSl8g>
X-ME-Received: <xmr:cbrUZ2bFo1QiLbv6fXiIfNSyWZ7rtpmdjJs7Oo6Yhn_JH9PnkCqtueQffcxVsNd8LgxoaChTjks62QSejZmrdmpB8QdQqkDE96NkTWU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufedvudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrvhhiugesmh
    grnhguvghlsggvrhhgrdhorhhgpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehjrggtohgsrdhkvghllhgvrhesghhmrghilhdrtghomhdprhgtphht
    thhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:cbrUZ5UcAOAhzWWy5Z0_xdGxa-V_pANDGhtOarIb4ls592olXcQVwQ>
    <xmx:cbrUZ8nNWUVU0ZflRrMLGtAwxTQ1SXfz4-VUhxcQOkIFrOdmE9q5zg>
    <xmx:cbrUZ-fQUbo3MEx5L8TFpCN1VB6eTM6daqtD3lkwfifMNUkc0TFmQQ>
    <xmx:cbrUZ-ENFzDw4wmwFHLYdsuXbW0NlUDndCum_jFx2JuOl0EyCg5ybw>
    <xmx:crrUZ6afbxyKGJpTBVVKOioPg5lDxRq9WZvYaQg62d_GxlITswcqIemE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Mar 2025 19:23:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: David Mandelberg <david@mandelberg.org>
Cc: David Mandelberg via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Jacob Keller <jacob.keller@gmail.com>,  Phillip
 Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 2/2] completion: fix bugs with slashes in remote names
In-Reply-To: <015b89f8-63eb-4203-8d43-47c9a6d65cda@mandelberg.org> (David
	Mandelberg's message of "Fri, 14 Mar 2025 18:37:53 -0400")
References: <pull.1901.git.git.1740901525.gitgitgadget@gmail.com>
	<1587533591c81d38977e62165784f8eb@mandelberg.org>
	<c80d20d93c92422437150084f402ac36@mandelberg.org>
	<xmqqo6y3dzno.fsf@gitster.g>
	<015b89f8-63eb-4203-8d43-47c9a6d65cda@mandelberg.org>
Date: Fri, 14 Mar 2025 16:23:26 -0700
Message-ID: <xmqq34ffdwnl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

David Mandelberg <david@mandelberg.org> writes:

> Op 2025-03-14 om 18:18 schreef Junio C Hamano:
>> David Mandelberg <david@mandelberg.org> writes:
>> 
>>> +	__git for-each-ref --format='%(refname)' 'refs/remotes/**' |
>> Just a bit of curiosity, but how would this be different from using
>> 	__git for-each-ref --format='%(refname)' refs/remotes/
>> i.e. the prefix match, here?  Does the wildmatcher clever enough to
>> optimize "**" away and make it just to iterate over refs/remotes/
>> hierarchy without filtering anything?
>
> Oh right, I lost track of that bit. When I wrote that, I didn't know
> that for-each-ref did prefix matching. Phillip Wood pointed it out:
>
>> If there are no glob characters then "git for-each-ref" does a prefix match so strictly speaking you don't need the '**' but I don't think it matters in practice.
>
> But I forgot about it when I sent v3.
>
> Do you want me to change it? Should I send a v4 now, or just make a
> fixup commit locally so I don't forget it when I send a v4 in the
> future?

Entirely up to you.  I do not plan to perform an in-detail review on
the topic (I do not consider myself quite qualified), but others who
saw earlier rounds of the patch may want to say "now this is perfect"
or "now this is perfect with this and that changes", and if you do not
think the differenes between v3 and your upcoming v4 are small enough,
it may be more efficient to wait for a bit to collect more comments.

Thanks.

Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31357D07D
	for <git@vger.kernel.org>; Wed, 17 Dec 2025 23:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766015361; cv=none; b=CikB6ax4sxzTLLtltFWuZNdJUR/RNqmoLKkQPjVj0ZUrfeiVRPynKS5D5PJr5Gc1LORcriK7R9AKnrvCir1j1pIppJKiSX1m4eudNLTdJpJAaGwqtbKhaEZXcqfKirY6v1kzD+xadt85Rf7m/TgQOqaKsSSbESOIXPrkMwHjl2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766015361; c=relaxed/simple;
	bh=WsMRsENp0U8zMU8nth+0tncP2HXqwMAQzqr+emWTLgE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d+PIwY/MCYN6T2fTYMWU14HQf88lBA7WQ0XLidjIS8A5x/FRh3rwnAneYf0K+FDoG8GmMiZBuMvt7X38UtnLF4Rrp2WwUNDflMf0279xRt46hoZFTlqNytk7WtiOLZrU7zOUR3WfPqt9DCzf1V/nrAwyqVKyLup+9aGUrUsSkyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TExQcb53; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ELVYar5a; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TExQcb53";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ELVYar5a"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 257FB1400138;
	Wed, 17 Dec 2025 18:49:19 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Wed, 17 Dec 2025 18:49:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1766015359; x=1766101759; bh=jBTWF8TpL5
	Pf4erNEsb2zM45Q/tI1xLY+zJvHRkw618=; b=TExQcb53A2O07+8zHQlqCD2x+u
	B519aDrDzdo3sngmKYYVF+vt9DkVaIVlr4iaZrovmVnsDVlbIApHmVIy1tJ8Ey9U
	fpHCPgY25tzSwAZ9EapPk4GbIdTSNqme68bwj3keCT5NFJevZfJHn+4GwRidRNQk
	iXy/L5Payf3gqOuGydL5YECy/OEIgjBrXSYvDx03icXVL7RX5MK27Asn5NL3ssg0
	MlShGrM+cIqAk/7TM76RwxTTZp8ajCm1fXNSaXKDtUG9SSuuPP1uoq1lK+LAlfT0
	9PPQC59XFNjFoa9uFNPs8OnBGX0Tf+/cFkKme8Rf7cAAMAl3RdNkmTiYwFzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1766015359; x=1766101759; bh=jBTWF8TpL5Pf4erNEsb2zM45Q/tI1xLY+zJ
	vHRkw618=; b=ELVYar5aM/WrWGX20JNDyOLgbX6MsDwHrMF1L9Mn+k4gahF2XUO
	h4nPBDVn6JoYRlDHZ4WZh31E/MHP9fc2Ht2i9KVQl+mWuljPuMlJ2amMtv/QoaTG
	NVjg9w3o7rZ7cVHRzTOSwen8e5F0E8vGLV/II1pnBVdLd8AgBhffvrKBDJEjszz4
	3ds0BgztvCIl+a6lFt3K0a3Ob33saANP2r30Y5ekmzue9FW9h+OsxmwxXEg21pnf
	vVk+eYTIEi4MkeiLLyY+k9gapqvY7f0ELCH4T7afHYOK16HsX9iWyCIuAOMTYpJ5
	/vjik29d/M6CpQmOPT2Kb/85qbcGGJj1bgg==
X-ME-Sender: <xms:f0FDaeNYvnV9A1uCXp-Ma2v0WItZgbgFd9TaSfku6-agBH8Z_pXoHQ>
    <xme:f0FDaT-LWlTK47vg596E8K3XLBYTDKs_nlgKIdcm7D-QuQucTxw6zuSLdXoKpPyGs
    fC0w6P2yqoAWHpIYWaGSpSZjZifU5j9lIbUURvgr-Ju7Otz1SCx9w>
X-ME-Received: <xmr:f0FDaaTxpbGDdaSqcklEMBtebfCzmrYWLn-WhUZNbe7SWWmjqEgF7urY-Jo3sr51cIVBB8lGqESImsUvpOQVcTRHcRmzuX5yCQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegfeelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:f0FDadlIEY_eeVaGNLXZ141AXD-An76SfhhnEFrDWEXzIsP4n9IHsg>
    <xmx:f0FDaSQwHHWBGclsvrm83C1eCRc663UobL_hd2zydfzXn25O1Zgy5A>
    <xmx:f0FDaTMlBxgmQfJSa7pXuVh3NBvy_L_LphEXtTGH9zN1lheLJQQt6A>
    <xmx:f0FDaTW8ZbN_ZZWlF8bcux3gGpGtuGJDkV7qFX60FKtztzoF1sKMjg>
    <xmx:f0FDadwMZpwC4Hn-DrnfG65uuncOOZTsgTuAzsiPwxoAKNAvKIMMm--v>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Dec 2025 18:49:18 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2] replay: drop commits that become empty
In-Reply-To: <d54c50ef-9d6c-498c-aca3-ed4461733190@gmail.com> (Phillip Wood's
	message of "Wed, 17 Dec 2025 14:45:54 +0000")
References: <8a2a1215306452147cc7b803530ab2429bf57f15.1764260150.git.phillip.wood@dunelm.org.uk>
	<9a81644a0ec670261a85c155fa32e5a1f4576ef4.1765793254.git.phillip.wood@dunelm.org.uk>
	<xmqqpl8f719x.fsf@gitster.g>
	<d54c50ef-9d6c-498c-aca3-ed4461733190@gmail.com>
Date: Thu, 18 Dec 2025 08:49:17 +0900
Message-ID: <xmqqtsxozn2a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

>> 	git commit --allow-empty --only -m empty
>> 
>> because without --only, the changes to blah will be taken.
>
> I've got into the habit of always adding "--only" when I want to create 
> an empty commit in case there are staged changes. I don't really like 
> "--allow-empty" as I've never wanted to create commit that might or 
> might not be empty - either I want to create an empty commit in which 
> case I don't want to commit any staged changes, or I want the commit to 
> fail if there are no staged changes). I can remove it if you want.

Being explicit when you are unsure is good, but in this script I
think we should be very sure that the index matches HEAD, so I would
consider that the only effect of the use of the "--only" here is to
puzzle readers.

A comment "# force an empty commit by including no paths" before the
command would work to help unpuzzle readers, though ;-)

Thanks.


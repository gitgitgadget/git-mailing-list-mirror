Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2606253F12
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 21:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760046112; cv=none; b=FhTiFoiYHoliE/FE+FNnu3fuvY1c/5O6uU6kxAu6flk9KAmnCvg7FPaD2G/qBMNGK74AZQZZk0Rdk+iJPy9zprJsSKAx6QFz/vYIC5X+qH3QJQ3pVKm7Q/z7Ckl+nFH/NBIDLazgWAF0nub31E10JQpOSlWuTy3yFB/Uk7i1ZN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760046112; c=relaxed/simple;
	bh=Ll1u5qwTkK77d0tWHGVt6qvEYAlYtFdx/5Ka5gPR4oY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TGPfASvLo0zBi1HSb/+gDMBcT2yHkHtVn0GlEQ1LZnMbUuD87feP6aveMF4AKBTFK56gUF88mo4Iw3VH5W0vZJAS80BULgzYe83pwWFCk5MaY08h4K3G34WWcDV2cHJ5SR1H7BJcEmtctE+YWPOJCiYY8r9esYBi7DqRKrnEDHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JYhWlCGq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cWC1L3Ns; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JYhWlCGq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cWC1L3Ns"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id AA6EDEC0231;
	Thu,  9 Oct 2025 17:41:49 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 09 Oct 2025 17:41:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760046109; x=1760132509; bh=bD6xT3k5ME
	/wKuVV8dkHxmyn4e7KFSHlMVw+6qOYGg0=; b=JYhWlCGq0XvqiK8a+xsnAUTlEm
	n2Rfb3zsi877sd1nOp543EB3m+cCbMLiWpMoamp2AZnvymqx/nHSnGhPYaNa6SJO
	rx4Dhv0tGKncs6nOGe0U1I1OyPtVBaKf+oQmDQpB2ghsBppiSarCFZRxEKqyygid
	5EK9OUQAb/mhkrD5hTtptpeNRzBcTI9nvzhMg1X9WmCVAbUah9uMgIARN9c8wBjN
	yJSH7sKyRkLfAsQqqGLnbLsj4us1iMtPyCIK4O5P2984SK192y9WjXNkXaJy4eUg
	5sco3x7n6WAORO58YjVgLQ3GXNuG5NSrMdfoCPY5KlLC7cfGpzbbhjz8Soaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760046109; x=1760132509; bh=bD6xT3k5ME/wKuVV8dkHxmyn4e7KFSHlMVw
	+6qOYGg0=; b=cWC1L3NsOKny1qhByWMXLLh9r2NN3yYLfStGnJAanRm+7o9inf6
	N7bb2VhpmuSsfXDPy+jCHggVpvWGR47JI5c4Y4zvTClgz74jhuMaaJ78EjsOpmUL
	5mp3sQhbo3C2waKIyWNjJJ0IuZcnfLP3kDX8LIIu5r2G8iX6YKu7HMhHxGYce0QS
	tS04SobOft4C0M+L8aUHi8AZtfHILgYX1XlPkJmxVfd+Hw9jiiPKd8ULxUpeAh26
	DWp/UeX+eSv/b0pny1DbD856DRatXhxCEImrbBvNfD3nywPhUIE7BvI0fvMFRiIL
	27men9HznmvXdCSLFq2rf/Li99+rsichvzw==
X-ME-Sender: <xms:HSzoaDji9Xnux-tWA8S4arT60g0C4JbpFCOukJo8oQH7fHt3lE-yOg>
    <xme:HSzoaAsQP4HWDsrJpQgxRSHkCxOMldIda8oCpt4ma4xRBLyvFi9WvvLjC5i86MUsk
    wiD9YQC2T-akKcIz-oNww3uN07oGDD5pfqGQitmnqIxMgrxtbtODw>
X-ME-Received: <xmr:HSzoaBSLHExt1GWpn_yZ-nzpscm_J987Rvwt02mfGgnW8Tdb4dHuNh4seuntl0tR4QjIG1R5D0QiGIzDBsKDTiT6MIEiq_E_j0Uc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdejvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghs
    thhmrghilhdrtghomhdprhgtphhtthhopehjiehtsehkuggsghdrohhrghdprhgtphhtth
    hopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguse
    guuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:HSzoaE2P2O30WMLKdCsShDaLjfdaKgzsd5bhnDH438G_5t95A5XKgw>
    <xmx:HSzoaGuNyioZ2dzxKZhoRTOl-Iqxv483PwS6Wrren1OpfU8SZ9reLw>
    <xmx:HSzoaKhTWeoGVuirUcYJ9Sv15fwVsWU2N6E3ZcGc-uYRQqcAYNAnhg>
    <xmx:HSzoaH9MnmvCxhXyKStnjJx5w2LuDVEejKY218s5hWmClis2GVg_kw>
    <xmx:HSzoaFucXZNX0HXFmzTIMzdQ2-SFMGZuO7u-FV818weoKAuAofoT6OyI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Oct 2025 17:41:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: kristofferhaugsbakk@fastmail.com,  j6t@kdbg.org,  Kristoffer Haugsbakk
 <code@khaugsbakk.name>,  git@vger.kernel.org,  phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] doc: warn against --committer-date-is-author-date
In-Reply-To: <3a8dfd13-982d-4c83-b675-1e9a63bb6ab0@gmail.com> (Phillip Wood's
	message of "Thu, 9 Oct 2025 14:46:41 +0100")
References: <6af09726-e3bf-4903-87ae-9524ad334678@kdbg.org>
	<d17060d9b72.1759952528.git.code@khaugsbakk.name>
	<3a8dfd13-982d-4c83-b675-1e9a63bb6ab0@gmail.com>
Date: Thu, 09 Oct 2025 14:41:47 -0700
Message-ID: <xmqqo6qfda78.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

>>  You should only use
>> +	this option to lie about the committer date when applying
>
> s/lie/override/ ?

It cannot be "fixing an earlier mistake by overriding the correct
data".  It is deliberately using a data that does not match the
reality to replace what was recorded, so in this case, "lie" would
be the proper characterization, I would think.

>>   --committer-date-is-author-date::
>> -	Instead of using the current time as the committer date, use
>> -	the author date of the commit being rebased as the committer
>> -	date. This option implies `--force-rebase`.
>> +	NOTE: The history walking machinery assumes that commits have
>> +	strictly increasing commit timestamps, with some tolerance for
>> +	clock skew (see linkgit:git-rev-list[1]). You should only use
>> +	this option to lie about the committer date when applying
>> +	commits on top of a base which commit is older (in terms of the
>
> The comments above apply here as well. In addition s/applying 
> commits/rebasing commits/ for this command I think.
>
>> +	commit date) than the oldest commit you are applying (in
>> +	terms of the author date).
>
> We should also warn against using this option when rearranging commits 
> with "git rebase -i" as well.

True.

> Thanks for working on this, it is a very good idea to add a warning to 
> the documentation for this option. I'm going to be off the list for the 
> next 10 days or so, I'll look at any re-roll when I return.


Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2EA2942A
	for <git@vger.kernel.org>; Wed,  1 Jan 2025 16:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735750443; cv=none; b=Ao4kt8B51DL+5VLsbqOl2uUT9lseVHr+/+SuURlu4fN0XTEexQlqGqSj8zLFn/BUrJar+fxjAA8srjNSWM0PGeNNHsenuW6dx1PZVJtS9iioKNGMiUtHVbFs1K3j92VfyltnH1BW4yDGI9PcMBPsoWMjHlU1vLopPB3XOU4JNnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735750443; c=relaxed/simple;
	bh=pSE/P9kOOJ1sv1+Pw8CIj181tI1RT+0n8ZQ4aCwqXa8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oJuXi15Hvazx13zO1uO96JbHZQDdXEWaYRzRwZ+gTUMM3t8HaQZaal2k/4CinM/e6d/+QuEFLHA5rdldj5VFpdPCUhNzMpIMrdqgZkQYaX7LRoMnvkag/LOFyzhBZmV+83V51N8m+i3FLph/S+YLz951KbC/vfq3JiJrPcqDoqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=qpUaKjaS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H6QxNCye; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="qpUaKjaS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H6QxNCye"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 32372138021D;
	Wed,  1 Jan 2025 11:54:01 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Wed, 01 Jan 2025 11:54:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1735750441; x=1735836841; bh=P5nhRHjGO+
	d+RiNfj0UBgqPPAeiN8VpukUdlwDMkHOM=; b=qpUaKjaSoUKLAZoBU9qCLrn36l
	8ehFMMb5Z6Xh8kpwab51HZ5+lvqTtaivR0AO1rOxJCvmeQ6+dVt20iEC8neHk56u
	2Tu7+4QaH5DqEVN+nZuTXWkNWo3IzFCFQk2NCsgREYPnHyY07l0FDxUFCLlb4gjA
	F+9MUhyOCzDsJdAEVjLhwqYYGHobG606ysoL/UKzLdw63yJRDqKc3Y3hDqsfbO3/
	a/x5x0i/kBWnlpEn8TeBy63UnFFhnmsIIjKunGKKdQI36Qc1UAQA5wxlOXG7Tbzc
	sG1TKFs0nWaw3tmCnxou5EhB+mwzb92yDFfh4OiENRqO7vw4fM2U0zjhrGSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735750441; x=1735836841; bh=P5nhRHjGO+d+RiNfj0UBgqPPAeiN8VpukUd
	lwDMkHOM=; b=H6QxNCyeLnmLe0AndTTSZKDPgSnny3CImw4oK49aB4vH6Odi4o6
	G0iPz5dprafsh1Mr9p36z6WrhcNBy7atTjS/HgmLJ+Y5U2MF/s5QKB+eLXh5oYh4
	QvVvlRJDSn8DKrxOw71HjpkFMSY0i42zgwIQrwYJv7pfOvx+vP7m5O7DxC2aLmld
	/3UJ8eT1GMfUPAetpwNAFsPqYUFcZfwnWBrMN0s9vw1xHP3vQcOycPHAIRQQwTBq
	ICa2Vh375SBgf+a1YOeRgYP9L6R0TmOMyMhU4qhIxs2GgyP7OAXqOkHu03Lt2QVP
	Fbq83JWxUbwEvQvZU6jlliSYYT6OBxHsKQg==
X-ME-Sender: <xms:KHN1Z9YFdLSu6ByJDWqFZITDnmeBrOPjI7mnxlRORncU076NCJeCAA>
    <xme:KHN1Z0bc4k_PpHCK8CWWWqMAbzCxu-eKdfFXg9sA5xfdw1xU__t8eu9MNnrxu9_xj
    9n2XhJjmGbfRFNUZg>
X-ME-Received: <xmr:KHN1Z_8FZ5ELKHmBZZ-e0rP07VAhFb5dEFCenLSo_f4ZGpb73yB4RL9M7hBKOH_lzaVlei0woqWGJ5Q67bR-4lQx6F9mvmjWiQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeftddgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    gjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghn
    ohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefve
    etteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehpjhhpsehfvgguohhrrghprhhojhgvtghtrdhorhhgpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:KHN1Z7oTOGZchFXY3B0vHOH1tYNAJFaW55JuPXf_6qErXmVQjEN_Dw>
    <xmx:KHN1Z4pGVZ_uqauduJ5Xng8Fwb79VKGMXk1nNvEB3hkXhrSmVrawlg>
    <xmx:KHN1ZxShzahLF5qz4Js5ljjLBzyGJw2atLmveNIJkHRv5RSYUrvW7w>
    <xmx:KHN1ZwofU-cD1RnR8wV_nrLI1YXpgNCrJPddc1fOP_EzksUvJSTgHQ>
    <xmx:KXN1ZzWVGRPkhnMVCZWqVT1jHfuTav8ZTiGcP_s386VIxmnSW0CM0Yrf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jan 2025 11:54:00 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Prasad Pandit <pjp@fedoraproject.org>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: File missing from git branch
In-Reply-To: <1964163554.5326830.1735643984559@mail.yahoo.com> (Prasad
	Pandit's message of "Tue, 31 Dec 2024 11:19:44 +0000 (UTC)")
References: <1964163554.5326830.1735643984559.ref@mail.yahoo.com>
	<1964163554.5326830.1735643984559@mail.yahoo.com>
Date: Wed, 01 Jan 2025 08:53:59 -0800
Message-ID: <xmqq1pxmxyoo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Prasad Pandit <pjp@fedoraproject.org> writes:

> * Generally committed local changes are visible across local
> branches, right? Is there a way to see/access those locally added
> files across local branches?

Not at all.

In fact, the contents on branch A is unmolested by the act of
committing changes on branch B.  They are independent lines of
development.  Otherwise your version control system is broken.

Until you decide to consolidate the change you made on branch A
into branch B, that is.  People call that operation "merging branch
A to branch B".


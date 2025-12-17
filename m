Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CE81F4174
	for <git@vger.kernel.org>; Wed, 17 Dec 2025 04:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765946869; cv=none; b=Dh7Vw/oIsIhbiMU3vQYf9BoM//om1H7/nPPvFWJO1KxT8hf8rk/e0Uh/GTXAPKslFGt60fKkgW6AdyAkAs6BET9cTcnlSlhofOz4I/VZbSkYYnm9znZit5BfvXqFSPDIKSX67uUHAuutp5RQ5YGfTZ1fOtoHTFDGgLFsCYFs4Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765946869; c=relaxed/simple;
	bh=xhw4VisYpRUvEt8lFsm4MeSgehCsMiHj9jlNN58Otpg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GWBIRd1j1eV+a5N5ui58vA6mxzyKjnbbzDOylLDYZmqOylRtqlF+FlIXEfIgUFfpN8VSAPR1HO45G22ngUC01EiJ+Vj7kJiDlldMn7nDkWk60LGTvBhvw/4iKFoFjfZ1nOJUk+Uu+Lze08T/7QK6aQl0gd7h37l062+oKWDFwI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fRDmTKvQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=snTwnAqo; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fRDmTKvQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="snTwnAqo"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2BE391400150;
	Tue, 16 Dec 2025 23:47:46 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 16 Dec 2025 23:47:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1765946866; x=1766033266; bh=xhw4VisYpR
	UvEt8lFsm4MeSgehCsMiHj9jlNN58Otpg=; b=fRDmTKvQFvpg1kQf49mwXJv2Iz
	7lqBr+YkbLWBNHpk97T6xhX8O0ZIK+XPMz8ogXERgmQb0HuCtfAbblG0co3C9fcG
	e9f9xTXK6Y0PzGGTv/UEvhJb4faALBjnoMuj15CghjkN4f3j5p/hp1O2Y5+4YDli
	vzFN8amPSiY7zijM3zSl/AZWx6r49m7JonJF4uXDuI3jpC/nsbRS97/Bb0DaCogm
	oAyXE2ia6SXc+q/xEkmOKaCysr9ShacZ4kRp4LX5Oh/ogNUDB/407qbRTy054YhU
	MpOrBqN87B9FR6OlNwy8dVgAH6ogcmwPbJOaQlOsKK7wCkqKESHegG6Y65sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765946866; x=1766033266; bh=xhw4VisYpRUvEt8lFsm4MeSgehCsMiHj9jl
	NN58Otpg=; b=snTwnAqoOxVcKDLYF0u21zzPyktDkHAT+PuoGfHxhwuKVpkHJin
	+Ns1mOB5JfNAboNY7Foo6Ouy+nMOXkbsYcpN3tOyBCBqEpY/lpwq0dIlMNalZkJI
	rp3WjhR2MnDRBPXac/jbDT8EwSp1JfZv1UHlaxAmyNVDnsQ9gZgehcdXpdLbTcVO
	kv5il7ePRnhhViNQsoIcssJ3d2m1yWekIpkbZhY34OF110DDjM+/HqPCpTqEPkuS
	iYXpq2tAzMvhW4iGqPD9TXoNkhPQGcYF93aiyyRFSeCML3kxRy5S5dgg05q3piHQ
	zCmYNh8hzr4QHxqF7pYwLz+eG52EpGhFZIA==
X-ME-Sender: <xms:8TVCaY6ry13nGk-6_w9CtrmJKnqWTv1XxznfXiKDpbgRnez3LxCMGw>
    <xme:8TVCaQyG7lHaJxmquvqU1_r4szxABL_OahBxlQXZbYbIYP17oug0IWhW4NDdOX-Fj
    DMM_W_ISdp-V-O66KU8SlzaW9PuHPki4YekzHIF58FJld0_HIs8wPc>
X-ME-Received: <xmr:8TVCafxtIM2e9ftM36hfXtCbrLTb1XrvLUGKUaiRXB_d_gfvFcMmt0a7QcNrJUBnH5pxgPbVYELpeVd2Cp2CwvcZewVZPbQYnw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegudeifecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjheitheskhgu
    sghgrdhorhhgpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprg
    hsthgvrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:8TVCaYxmkOvdy0s7dlSAXeGWNU9OS0o1HDlMkvKfQHqINWLvSaAbVw>
    <xmx:8TVCaZYuwy6f2H9nBi14iTO_sya4ZMuWCZR3F8RoNy1NaoAUB4iGEA>
    <xmx:8TVCaZXzOU8aMU4rOEyapF5oSCswpg8bnu9kW3hlFhXzM00XzYnZ9g>
    <xmx:8TVCaXjcGeZI5EvJCbmF8yH7HGMAL4k6Pjqeq7M9tMBmdNHLRh9wSw>
    <xmx:8jVCacOzoVpgxIStStaeWVqSO8NsiIwV1W-kp5gK9iZzK-YlYNwJX-AL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Dec 2025 23:47:45 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org,  Johannes Sixt <j6t@kdbg.org>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2] commit: document that $command.signoff will not be
 added
In-Reply-To: <CABPp-BFgRLo66P49dzgaS0TCbTKtA9J_Fw17QWQUhsLoFXeLnw@mail.gmail.com>
	(Elijah Newren's message of "Tue, 16 Dec 2025 11:48:41 -0800")
References: <xmqqldj48pyl.fsf@gitster.g> <xmqqv7i62r6w.fsf@gitster.g>
	<CABPp-BFgRLo66P49dzgaS0TCbTKtA9J_Fw17QWQUhsLoFXeLnw@mail.gmail.com>
Date: Wed, 17 Dec 2025 13:47:44 +0900
Message-ID: <xmqqike53ea7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Elijah Newren <newren@gmail.com> writes:

> I like Johannes' edits to the text I had; this commit looks good to me.

If you liked the final result, it probably should not matter much,
but I cannot tell if you are (obliquely) pointing out that I failed
to grab and apply Johannes's edit or if you are doubly agreeing with
the resulting text in the message you are responding to.


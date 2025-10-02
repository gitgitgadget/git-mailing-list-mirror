Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40A12AEE4
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 17:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759426498; cv=none; b=t8P1qiNLKbv54hYA1yBUhEQAV5C5/X/OVYAAXSkOkTiHvw2sCgc5ZiX38CGv4+nsuXaak1pZOb6uJdbzwShT0/tsjt4Hven1DcLll6brnxSpqcAvLntVZhbAbxEkMRzJVFC4UNsovXt+3V7f2iTalgYKLpv5FDCsvsDSTKI2eNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759426498; c=relaxed/simple;
	bh=0PxYExJRjN8YH5xCyMjLtmyIV/qhvG8FklLMGZI8SPk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BVrJ1e1vh2j63kUiPhasjKaKPSFL66WVEUVFqiaPffld3UYAWCE+TbAIswvbwMdl4pKen3yiEsQ9lEO006U/3mqJUazvNgdFGz2dSm92kqlvDlsy9ZFdbbCle9GAg9u6sapM1tsfzdx6zwCzyped8Mt4084Olg77BxRqDdfHH4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=aKouMbc5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QYDEPMF+; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="aKouMbc5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QYDEPMF+"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id A9CC21D00065;
	Thu,  2 Oct 2025 13:34:55 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 02 Oct 2025 13:34:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759426495; x=1759512895; bh=V2tgnNhVbk
	+8C/XOnMST/m1V+opwjgqnSoiz3tVDBJY=; b=aKouMbc58/mkjS5reOKgejH0hv
	Khhp2X5GqUGN0bSKOX9GOtjGv/N1uIUmhkSHG6u8QWuZupa8DlyGPI+coJgvE5i2
	CwExQqmQToe/DXjSncPEA1yNOacsoUY+G5RA2L0/e/GTBE2NryEfRhTDiPGjzi6y
	U2u8FxRqLS7LTLzwg18TL0J00j61rglF0GVdp1bQnByVkffwR4cnmdDyRZltwHUO
	8duZqR6bNNx0+p9+Lc052Kq0KXFU5WnVqGniKIHj0LF0xZYIqnN4LANkfq5HPMcJ
	vMLajz72FOfT7q5KmBdTSP1v9IP9P3T5mb+4xhFNtCmQ4gfsjvY8iw55HEQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759426495; x=1759512895; bh=V2tgnNhVbk+8C/XOnMST/m1V+opwjgqnSoi
	z3tVDBJY=; b=QYDEPMF+EnTju9toHOtwsVaOtjWEYYtBUl+eq+3wlHPqhfsT3kJ
	NDI7p/7BV8tG7CJffdeMugzGTET6VZ7zFfwZ+HGBKE1KPJ6Nty5PjHeSwE2nAblS
	pfANiI37VpTNgIkz+etxCC/e8/22olGGukkShSEKYgbejRB3IpUA02FJLkDlD1dC
	xnnDPwZEKMhSjjTdzqnqhjT5OHR8fCZ5Gztops5Mg244RpcFkp0vhC5pZLVUK96i
	qt3MEVdR8nWKdf/SRVQsukzl8hkjNY009biAxO/rsM+QNnRwlza1U9aqqv+Yrd6Z
	tA65OOI9mnYTleUvcLerea5DBYYV0dJfZ5w==
X-ME-Sender: <xms:vrfeaBx4tdigJNfywonJJR9p2FKjxuhP3i7DPQpuw1DE8eZYe2DYbA>
    <xme:vrfeaDhQy08zyrGW7Z5mF1-qfwn1Y4uAdIN-h_2Z5e-8vIpP94F05MaQmeBHmIReV
    ukDAmYY9N6bXSPUPoFSb65CbtfH9cAWC3KI_iD65721qEfe3G49>
X-ME-Received: <xmr:vrfeaNlThxKzcD4DlOBj0vPjUZRGMhASXpC7zPdUkkDKAelvO4EeGbB_SkOGNWJVR7plopsvO2e8Gk2SWWorxwDS1ozfL4-Qll03>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekieeifecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepkhgrrhhthh
    hikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehhrghnhigrnhhgrdhtohhn
    hiessgihthgvuggrnhgtvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohephhgrnhihohhunhhgsehprhhothhonhhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtsehsihhgmhgrqdhsthgrrhdrihhopdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:vrfeaJgXr4FPNmVGzB5d6o0cwJ2YPfXZuIR5Jxqel-SAoM9L2ytIag>
    <xmx:vrfeaB1wlF6W2eVIAcATRmOW3Qiiw2Lfy45_VZxLExSyQ2Bf-pxTbg>
    <xmx:vrfeaCIq93R_dNlH6JCgGBrYMngI1nerQYisOsSRCx6EJers58jWNw>
    <xmx:vrfeaBzYSaS5x2lYGbmPdW6CwEgZdGUtUcqyCOCJRBEvYPw8z9QHRg>
    <xmx:v7feaAhd5Yaam_BR8MyYTttz9e_R_mq8wWxr5Mj00hzD8unld8e7l-PO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Oct 2025 13:34:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Karthik Nayak <karthik.188@gmail.com>,  Han Young
 <hanyang.tony@bytedance.com>,  git@vger.kernel.org,  Han Young
 <hanyoung@protonmail.com>,  Sigma <git@sigma-star.io>
Subject: Re: [PATCH 1/1] files-backend: check symref name before update
In-Reply-To: <aN6amIG2Sp3W500K@pks.im> (Patrick Steinhardt's message of "Thu,
	2 Oct 2025 17:30:32 +0200")
References: <20251001150805.9652-1-hanyang.tony@bytedance.com>
	<20251001150805.9652-2-hanyang.tony@bytedance.com>
	<xmqqv7ky1l70.fsf@gitster.g>
	<CAOLa=ZTnHQbg9ocdA1omqER6CJH-w30G14-F2JAQMtueXENWew@mail.gmail.com>
	<aN5mOTbGBcr355E6@pks.im> <xmqqo6qpxw6w.fsf@gitster.g>
	<aN6amIG2Sp3W500K@pks.im>
Date: Thu, 02 Oct 2025 10:34:53 -0700
Message-ID: <xmqqseg1w6ki.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> ...  As "git refs verify" is a way to do the sanity check of
>> the ref part (presumably without incurring cost to sanity check
>> other aspect, like fsck does?  why is it a separate command in the
>> first place?), ...
>
> We have the same pattern in other command:
>
>     - git commit-graph verify
>     - git multi-pack-index verify
>     - git bundle verify
>
> So `git refs verify` is following the same direction.

Well, bundle falls into a searate category, though.

A bundle file is a thing on its own and wants to be independently
verifiable.  A packfile (.pack alone without .idx) is also a thing
that may want to be independently verifiable.  For that they need
to be accessible by end-users in a form of some command.

But everything else, ...

> I think it's a nice pattern to have this encapsulated functionality so
> that it's easy to exercise certain subsystems in isolation. git-fsck(1)
> then becomes a thin wrapper around these commands and is the one that
> ties it all together, if desired.

... including refs, commit-graphs, multi-pack-index do not have life
on their own outside the repository they originate in, so there is
no reason to expose them as separate commands to end-users.

I do agree that having a separate entry point for exercising them
and them alone would help debugging and development, but such an
entry point does not have to be a separate binary.  It could have
been "git fsck --refs-only" instead, for example.


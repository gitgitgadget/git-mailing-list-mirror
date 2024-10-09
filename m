Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBC1EDE
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 18:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728499924; cv=none; b=V4jCYawoCSyhF4FqDJXSeTY9zQMbVqdPzGbKuULaADzIsns9Ifos5t2izch42AKErD5MXRf5GLSET0QQwwKo2/68sm4dVr5rIpkFrOeIHbC/JkNws5xrP9NuhX+YGFFgBkgVIN5/Th1Q1peIk07URpBlNYbcTf94ij9ba4mBbes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728499924; c=relaxed/simple;
	bh=33wkvAOubRSZtH21jjYYbAmNwULS9TV6g0MbA1Cl2Gw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MSeypcgDNRLDfu/he7YC5mDHl1EaNn7VZpO8BvPjTDMtyLOdUMIfOLSEVagoyaL8nEl3jY7/wO89F9wIyye4Jsg5QmHwNC7XyY9oVF0Afmguo0WHhzEbDQJWDkbJMjjO0gTtUte9kO09wo3bJTBjXgg9MdkKnqNSTc5EUALkG8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ujP88EWE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NbEkAzeJ; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ujP88EWE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NbEkAzeJ"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D650A11401E8;
	Wed,  9 Oct 2024 14:52:01 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 09 Oct 2024 14:52:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728499921; x=1728586321; bh=1PhV4XfSKM
	fqnBKV58f7jIUTpyHiY9F6KfxpfVBaIv4=; b=ujP88EWEZtsAWeVM4qqYhR9UvG
	QqcNXYUf06RU8WNMAA0MEy+gaOrwozsMJ40Y1YYUWMMKRNmbt2hfYlYNcxzyReYQ
	mOEuwj/K1jWuPDsrrrlvpyKz0tPYDBqW6irT1IRCVMJEyTo4n4DyjCn1YKjWcvYN
	PGaI/B9TpOK3Cvbp4j3v+iwYaKjfT3YZYOJ5IKVFVWgg9VuxiPlnFgoUXDv4zO0v
	cpGEWNwhz/xOikw1t/a2/LlO9HjxLRDCw2l5OojNKi1pXhbavCP81cruNH6BSKQc
	VWnmw+8mjSTnbIaovijgDM+IgOpAumWi6JQFTS+L3JkMAUbb9FwDA745JORA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728499921; x=1728586321; bh=1PhV4XfSKMfqnBKV58f7jIUTpyHi
	Y9F6KfxpfVBaIv4=; b=NbEkAzeJWXA2R5d309m4vn31RGt8FBY8q7mVFdc6MD6u
	kHCUyJv89LT93rNidl5hzgBUQu73qSWYBt4ZhITd7AepdoWmaE1OqJfXm4Rtki3M
	DSfIcMZHyfwY3/rLke3TuQIkWEZIArpB3zAJZjoWEkUvp+9AOmGiuWAqQVWV6lOF
	6vSoffW8IEnycxwbSdSyJgNq9qIOqbGWQSjZaiyg1RAZaIJaenZbD2DJ8EDFVcRl
	bTgiccYpznm5R2ht4Ede4lpEREkP0vYJ2niZjRez6mw/kaOqex36kni65drZzMaa
	AIKBLTJ0nyAphZplRMaTUwfHKrfEnmiMO5seDm/OZQ==
X-ME-Sender: <xms:0dAGZ9TE9XMhAR0UGy1inJz9KaVzznm-eTw79WBXMi3MaHl5HgVCkA>
    <xme:0dAGZ2xi4cFC5SNLGplpfqsGP1RAXK7MedW-LehYa9dLI1vPrKrGvycbRvSw4nQkU
    G_hdQqTMokJuId06A>
X-ME-Received: <xmr:0dAGZy1IVGYUqeM4sfz6MJFBa3N-9AonN7lSO8L3DUxDUhPtX5l-qxTpSEBvNrlSv7AI4yvflyJ1DLF18W7XMMfaNQLa_OPUpmCl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeffedgudefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrd
    dukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:0dAGZ1CVGh9LJ8Smsi7POXSCYBCSlNdYhGOBp-4_OHTs8N-52-so8g>
    <xmx:0dAGZ2g3e2LVdVrj0TG8NVni6h2xTjnwbgs9wuAAZd3sUu5M8Zlnug>
    <xmx:0dAGZ5qjBGfMBXaxAbs0MyAxgr7gU-DRnpmso9WXI2GvnDUG5OZgJQ>
    <xmx:0dAGZxiWi9ixy65G3w9l3y20fYA499-WPo1Cl8QlFAl43SH_IvuivA>
    <xmx:0dAGZ3siIFq9ioaOFkTKcaA9s622MwU9--A0XVc7sCorDhXNLwIAkOT2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Oct 2024 14:52:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] loose: don't rely on repository global state
In-Reply-To: <CAOLa=ZRMaw-PAsZ9s0zJ2zp_suMppi=ZrT67B__LU1tWZSvuUQ@mail.gmail.com>
	(Karthik Nayak's message of "Wed, 9 Oct 2024 02:58:59 -0700")
References: <CAOLa=ZRMaw-PAsZ9s0zJ2zp_suMppi=ZrT67B__LU1tWZSvuUQ@mail.gmail.com>
Date: Wed, 09 Oct 2024 11:52:00 -0700
Message-ID: <xmqqcyk9rtwv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

>  			strbuf_addf(&buf, "%s %s\n", oid_to_hex(&kh_key(map, iter)),
> oid_to_hex(kh_value(map, iter)));

The line seems corrupt.  Joining them with one SP in between makes
the patch cleanly apply.


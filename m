Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D6813C9D4
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 21:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737148895; cv=none; b=L6FA+xGYlx+1VRMdmL1DuNHVESKo0NYZf9gynd1U2qxYJlRVjQiNbGe4156gex3dC33s2jBhgBN0ENLGuOANtUQxuy7Gu8NmDcj3r5QDvbcbo36/lv7qsoO+pUnrLLuCl9ndUpJ1i6srqy/j0faaR3gDRbbJK4cIdUgyFko6HAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737148895; c=relaxed/simple;
	bh=HjzIs+GON9/bBl1siAvHcN1t2B7f4MPFspm3SLTwt5I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uAfumPxv9JP6v97vTzQQDbNtLXEDwPRUo4eAc1TQNZ0JP/4/c+v4TLSLnRR+RsDtqIcx3wyVq01QviZLrhxzvz29p2uF5A01XQ/bmG335yFSx9n665bLWtSQ7hyh+dhBdQjhxA3YlxySkAxycUxBt6sLNHKle4Y+iXCPRpsUaTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=3+RJlSCf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YnIA9PiM; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="3+RJlSCf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YnIA9PiM"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 8CE4D13801B9;
	Fri, 17 Jan 2025 16:21:32 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 17 Jan 2025 16:21:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1737148892; x=1737235292; bh=O14mIZhLyE
	rBH7iXkPkSEJHNUAIexezbTar67wYvc6k=; b=3+RJlSCfJ8zgN87ltByGxnHcNf
	Wz0TIttJc+59Rf+qawmZ5oye6bIsQ/AHZTsQli7IBxOrOyq86QRrgQaj98cPiLUb
	K+DLdoRI8WqXyICgKfZiwC6wfl2XKLIv8kZpk4llnc40qJnA9s0KA+5+UgyBABMF
	ioysCRK3991opiwQ/ZOvSaHKxOQrxk+4srv/3SjHG2urD9vPGLu0nKJKwSNxt0h9
	cZMcum7C5knYlwbEP65TSVfi+GhgX1dnx8GGREzfUFHpzFOH9G/0TQUCzDI+Mz86
	POAL8t78noKv+i66x15YT/hdRhUZ2+upEtND1MSSWWBbHfCshxcyMegS84Mg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737148892; x=1737235292; bh=O14mIZhLyErBH7iXkPkSEJHNUAIexezbTar
	67wYvc6k=; b=YnIA9PiM1+ux0Q0oElxc7KRG5us3ZFzmVrORG2z7UIksQ/OAK/d
	AZpBHfHV9h/ke1/oB5zuOBhL2Na8vaMDrVo99yzOrlt7rfkMndFz7xP3sxAK7CKB
	0OaunQtqtBP7ycu7GaG+h+HYs+oqI8tA4sjE7NAkEEc3+MCqPj2RNooCxYq1wG2Q
	TsokWV4P4AkC3oX2pdQiC4semWkZKfexXKx0eOT4ytH0jEoisKHO7TWO9mGbmYjO
	hXSjqVwpeIYNuIYIMmk5zbFbSRNmD2K/c/x1yjMsLRb8JWQ0lKMCasssfBYzsSqu
	9/gNcrXpLYFFJHFWJCASvhb8qU5AfRQyzzg==
X-ME-Sender: <xms:3MmKZ03jGUsdN8ElFKM8gcRrGmg5qqLa6mZXn3BCf1wqeGfhZHRhZw>
    <xme:3MmKZ_ERL9UFVXpxzDTr0eoOHmUE-lmc5f-kyyriFpntXBElka6pMgjG5S-hhn-9F
    ecdVthK6pOubOFuLA>
X-ME-Received: <xmr:3MmKZ86BtY7mFUf9Di127CJcrjGug1BhwIgSFQUGaXJP451qph96QVmhyejLcsweb-6vIpWqYLI5ETXTuV7JE7gpOsRUNBk10GVV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeifedgudeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmhhesghhlrghnug
    hiuhhmrdhorhhgpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:3MmKZ93Esmg8b8sGkT48-INCPrpfR3UTATFPx-UFX-ZP6rZ989Q7fA>
    <xmx:3MmKZ3Ek_I4Q-m3Rdc9hzTAPankehfsxBYwd5DVG-08D9Wtv-Wj4tA>
    <xmx:3MmKZ2-mK4E7C1xwA9U9RtpLy8vUkVbjHxOCPMvi_N4IVUbcJWIqww>
    <xmx:3MmKZ8koD1p5W3B2nsthZ01yo5_1RBJULm6pOngOH_cCe5Uq1Kw0BA>
    <xmx:3MmKZ_DKsqcIwoyDsGTBU0kmFj9P_0DK4vJoe7TUOFcj2y8m_eAgC9sC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jan 2025 16:21:31 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Mike Hommey <mh@glandium.org>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] connect: address -Wsign-compare warnings
In-Reply-To: <20250117211830.75prk6e2u3qlatwt@glandium.org> (Mike Hommey's
	message of "Sat, 18 Jan 2025 06:18:30 +0900")
References: <20250117074909.1430067-1-mh@glandium.org>
	<xmqqo705mjw7.fsf@gitster.g>
	<20250117211830.75prk6e2u3qlatwt@glandium.org>
Date: Fri, 17 Jan 2025 13:21:30 -0800
Message-ID: <xmqqldv9jfvp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mike Hommey <mh@glandium.org> writes:

> On Fri, Jan 17, 2025 at 09:26:32AM -0800, Junio C Hamano wrote:
> ...
> Do you want me to address Patrick's comments?

I'll leave it up to Patrick, who is the primary developer who is
driving this effort from my point of view.  My "Will queue" is
merely to queue it in 'seen' so that it won't be forgotten, and
means nothing more than that.

Thanks.

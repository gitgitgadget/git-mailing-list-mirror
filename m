Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D447E13BADF
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 15:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738854833; cv=none; b=h++mMlB3hqer7coxJgptpnUcV5Pq19aXzlZLISjGHbewAH3RMV3O0ZRTdd235xUU4AO2ZzqJQTY+v6i5jiBNqpVLiaKQeRsvkUMTnQgH5O77X06LifMcBojwJyZILIGv23Fc3+di2emHSgGzE1OZleYtq8V7/ZyNCvl1GjwjSSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738854833; c=relaxed/simple;
	bh=6q6fGeYfO/DssvQhnillsO4MqgY5YMkRAVlx4GR3NmA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VVNtBGQNmEat15QHEkDbQhz3WbKWsxM1D2c4ks/v6+Eyad7J9Em2esW1gahd4hPWstrGs5hyRcAFVijAuMFnQk/ByznciMdRvXS9BfIu2ChbPhsRL7gIArHdJek1uKu4lcrxXV34yboQO3dPHzFUF7H/DLTfwxeBXehTkb9oVUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=uK4bwXKk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WBs4BC0W; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="uK4bwXKk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WBs4BC0W"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 7A6AA1140115;
	Thu,  6 Feb 2025 10:13:49 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Thu, 06 Feb 2025 10:13:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738854829; x=1738941229; bh=uK9QCCiun8
	zvZyrjNe2YuYPSc6p4ovBGP4GDL27CKF0=; b=uK4bwXKkcPizcnZu+ofczplZpL
	Ka5xS7rE06fDjdBN1b4zmxruRLUc65Oi8gdT1Xm9DOxDBenX2f3MM2/7spp+0eAg
	m+2/SpmQF9U0/bwFqBDCHfEmGmJG4IqY7NAz8yNDuI00dITnQNUVvORdl7qynJvm
	XOxJy27CEiAyPFCP5LD156C10b8TO9DLpQN2H9O0n7gebQvIQgB7WhsPQYoxIjoV
	0HybdKuCvCwvWZ7FNmHY5sM0F5fqIeA1eHnKffR9yaJeYz/bQre/kJ+6K1NIQf37
	JN9LzG5yBm/CROmna00VU5YYVWFuE051sG92OcqauLfk8P4D+nvOf8nGNHww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738854829; x=1738941229; bh=uK9QCCiun8zvZyrjNe2YuYPSc6p4ovBGP4G
	DL27CKF0=; b=WBs4BC0WOjZtnpjWWFAL+Tym4s9w2AMlLCdsFzWLRYiMLPUm81v
	xq8ceXk/2Ljh/TBgu8bHHxeU3LPlO9nO/RcPTFLmlzlRY8AmVWXWKC1uTTGTSX5i
	nTLn2W7Lp8EjWka+pM3YpArFjsMtzjnWaTmFILlN4QWqnDpiOPGAtC33Ush/xqHw
	2xF6B+olBXhFGL984Ri9dbA9htICwNssppqLOt/8LrHv/Hv20mF6K0vPw9YfcHtb
	fnErtYY1fDG2oA4jVO14OVvH4tkKrMMlhUqnNc4nP38DcBp7PCBXucRI8FHKk2HP
	mpctLOWlqHyRMtCzfantOyP2gr5oQr+7Wmw==
X-ME-Sender: <xms:rNGkZ6XSM8iTkO_oHt5HGZSXZfg15NcMnHxA5M3rIl1iKadShU2wwQ>
    <xme:rNGkZ2kKY1vY458JVEtaLGdU9N_G9-tl1H4B7UOs39uQ4VcJxuJuKSXre7rLHOObT
    Akbb9Qk-IQ9ExjjTw>
X-ME-Received: <xmr:rNGkZ-YcsoL8giOB5375tHWA4sq6Vp7EAP9sTDDNqzhTaRGuenRKqmmtnP5TcomZATzYLzxpjMVeVVr6kqzOJ97N0_WYoEIYQVoH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieejfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuhhsmhgrnhgrkh
    hinhihvghmihdvtddvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrh
    esghhmrghilhdrtghomhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghl
    ihhnsehgmhigrdguvgdprhgtphhtthhopehjohhhnhgtrghikeeisehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehphhhi
    lhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehpshesph
    hkshdrihhmpdhrtghpthhtoheprhhssggvtghkvghrsehnvgigsghrihgughgvrdgtohhm
X-ME-Proxy: <xmx:rNGkZxVeuAh0LvK24nWkJGpw13kDmRhKYJKek2yvY6gzfCosUZUO2g>
    <xmx:rNGkZ0mxpohJNj-P9t8pVxN6AkiI-VXoMefWhjwk0Azby-DJvRVPMw>
    <xmx:rNGkZ2euczDeRrcK7LtOE82OmwM1Zo_jukZFor5blq5CNnSB6HaESQ>
    <xmx:rNGkZ2Fdgxvu97ZHWxxdu9z4Kg47htSoiaG4Of7UtWXNgUJvWxOs8w>
    <xmx:rdGkZ_93tVk3z_Itx9m8YoOh6p_LxXVlAcj3i92v9euodnPtciCxUlNX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Feb 2025 10:13:47 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,
  Johannes.Schindelin@gmx.de,  johncai86@gmail.com,  me@ttaylorr.com,
  phillip.wood@dunelm.org.uk,  ps@pks.im,  rsbecker@nexbridge.com,
  sunshine@sunshineco.com,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v4 6/6] agent: advertise OS name via agent capability
In-Reply-To: <CAPSxiM9Yejt+Cgu_ekuQwhduf=JEmS1s+T+nc--SvNQqkQE82g@mail.gmail.com>
	(Usman Akinyemi's message of "Thu, 6 Feb 2025 12:07:20 +0530")
References: <20250124122217.250925-7-usmanakinyemi202@gmail.com>
	<20250205185246.111447-1-usmanakinyemi202@gmail.com>
	<20250205185246.111447-7-usmanakinyemi202@gmail.com>
	<xmqqy0ykkqqc.fsf@gitster.g>
	<CAPSxiM9Yejt+Cgu_ekuQwhduf=JEmS1s+T+nc--SvNQqkQE82g@mail.gmail.com>
Date: Thu, 06 Feb 2025 07:13:46 -0800
Message-ID: <xmqqo6zfjec5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Usman Akinyemi <usmanakinyemi202@gmail.com> writes:

>> I obviously agree with the benefits enumerated in the above
>> paragraph.  The simpler, the better.
>>
>> I however wonder ...
>>
>> > Add the `transfer.advertiseOSInfo` config option to address privacy
>> > concerns. It defaults to `true` and can be changed to `false`.
>>
>> ... if this configuration knob is at the right granularity.
>
> The conclusion now is that we should not add any config option since
> the GIT_USER_AGENT could actually allow the user to hide whatever
> info they do not want to share ?

I wouldn't call that a conclusion (as you and I are the only people
who expressed their opinion on this so far), but that is my take on
it---tweaking only the (os) part in the agent string with a config
smells like the tweakability is at a wrong level.


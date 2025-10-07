Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCA82D9EF0
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 17:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759858025; cv=none; b=l4CdT+PLabB9z7hzXsGvRs/sFVD5Bf3ws6F5V0OqUhk4eOMHscsYCnNqCGqXIDw70W3tLx5nixNW6WXW+ayeM6BM3GRHTt46XvHt82m4c/8n4DVDw8Yi9juu0R4rVyQVhTg4wBJZjRHsghpDMFJEeCwF6Yac1/IOhDAAvFBwmHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759858025; c=relaxed/simple;
	bh=h3wbiox5FvafG5L0lxv+CapKKc/Ckm9H/dG5tnkJPwI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KCC2FKTxMTIz0SMZvBKMAO2mC5MLU659IHCCo9VDSfGB7jQEO3+FRrvRzVw4Y1/Ub8MBRahDkTC6yZsMNZPfcehTmrYSimtAiYRXlqiggvh3lpKfBpARYwMSsSwt77d6Rt7N688vWJxPnLWdRwcvThxZSpi5cKEjdBe3E1H3iv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gGcMc7Y9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Fk7se3gE; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gGcMc7Y9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Fk7se3gE"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AA85C7A01FE;
	Tue,  7 Oct 2025 13:27:02 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 07 Oct 2025 13:27:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759858022; x=1759944422; bh=QqWDzoPAPL
	98nd80+HKaK5FfseKZz8KdhDBymPGBNmU=; b=gGcMc7Y9vekp9Mc/du4BgpN7ey
	QU8Y90DAbWcpnN4VwAZRQpHWhpj+9SWEwAfm59AwQbQ/D6weVA3N07jf6OCDDSV9
	/d6eKhkf6OoGuxUqBJlPPhZEXouVrqFwKMJcvI0YYNgD1WisCR2c2CIQCrHkKN8w
	1CyvqKUXyAF24dXolNqgbmYWanhFuFHMquKQW9NqXP1/dnP4G95ycDBaiurewn8v
	kWaInXtlmbmjbnQXCqMIRNz5ILagDBK9EIgu/e9/CwjfxrMMuKpiwjeOqX/NLaJO
	gCLPy/JIxKdfCUD27lmjZE2HulFcJnU9sAGZ4YcZs/IfdiMms4FynsFbDgVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759858022; x=1759944422; bh=QqWDzoPAPL98nd80+HKaK5FfseKZz8KdhDB
	ymPGBNmU=; b=Fk7se3gEDj/ZBwVQRl0BoF0o7CVMdTD0NqfxKsUGuIwMigC0z0S
	Vm/ozJ16Oi6MUsYnJtN1s5YhbMmWOzN10ZP4Kdjzl2sjbLVLwRiK4RmXZ5BQNVGt
	41lOQpIZxaNltxWePO1nidBSR+8AcwJOjB5wHJ6JkPFsGDMTLnGflbM2sE8VuBUy
	ouWQv4wlYugzE1VWsvnZh+LgCdHMkZ+aC+bSjAmkbhmQ4z30vukNs7xZHmD8uaNj
	xugMWbBiy335advrslYqVDaRd/OHoe0vIMihuqTeAL3tdkBUkebEAv2z8NgTgUQ4
	lYFo8hV1MDR5fktYIOp1v12VPZgNghvUf0g==
X-ME-Sender: <xms:Zk3laA65RbW3Z0K8cYE0ZCNnUrdrnL038b6uLVPBfKm9B0b21wXvJw>
    <xme:Zk3laNvJC01qtO8U_e8CzuWzXAho7STafQVJSO2TI-Ad-JsZBIOTglIFFtmdVlLpf
    yhCNf4cZg9U100UfaZlu1dQ8kuMJwO41KjtW-8-A4xIOaRO23e7>
X-ME-Received: <xmr:Zk3laK3tlC1VE2ShPTPkmTE0stge3xy6EB0RAyYvF7RJDEMW4Dq8J8JsS_4p5nrokRO0fsFLSXwK8sXCpM62pOvlfDugngfYVJTX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddutddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegrughrihgrnhdrrhgrthhiuhestgholhhlrggsoh
    hrrgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepvghmihhlhihshhgrfhhfvghrsehgohhoghhlvgdrtghomhdprhgtphhtth
    hopehruggrmhgriihiohesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgvfhhfsehp
    vghffhdrnhgvthdprhgtphhtthhopegrrghrohhnsehstghhrhgrsgdrtghomhdprhgtph
    htthhopehjrhhnihgvuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhk
    shdrihhmpdhrtghpthhtohepshhtvggrughmohhnsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:Zk3laOrdHIoIcdyQl1mGROyJ0P1VC1Z7M_85G8eD8NkUFhmr2xBqAw>
    <xmx:Zk3laCJP7YOXa_98Y8Nxh73bkXRHhExX3TDs8B8N9q-VOps75Jr3hA>
    <xmx:Zk3laCQPevuR_J4ZmUPTw_ybXxao74uuzHi9yKMAwSEdlgRmW8Ba5Q>
    <xmx:Zk3laCPYW7O3gxmZUlUTNOshdHQNQt3zkU8JmxLt8rDDt1THBsUErA>
    <xmx:Zk3laP0c38mS8FIA3Mx3BsqbYpsNqKlJbyVtMGnSa8kMlYxvlpr04i_z>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Oct 2025 13:27:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org,  Emily Shaffer <emilyshaffer@google.com>,  Rodrigo
 Damazio Bovendorp <rdamazio@google.com>,  Jeff King <peff@peff.net>,
  Aaron Schrab <aaron@schrab.com>,  Jonathan Nieder <jrnieder@gmail.com>,
  Patrick Steinhardt <ps@pks.im>,  Josh Steadmon <steadmon@google.com>,
  Ben Knoble <ben.knoble@gmail.com>,  Phillip Wood
 <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 0/5] Encode submodule gitdir names to avoid conflicts
In-Reply-To: <xmqq5xcqn2pe.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	07 Oct 2025 08:36:45 -0700")
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
	<20251006112518.3764240-1-adrian.ratiu@collabora.com>
	<xmqqo6qkq9vm.fsf@gitster.g> <87frbv3qyr.fsf@collabora.com>
	<xmqq5xcqn2pe.fsf@gitster.g>
Date: Tue, 07 Oct 2025 10:27:00 -0700
Message-ID: <xmqqjz16k4gr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Adrian Ratiu <adrian.ratiu@collabora.com> writes:
>
>> Currently any existing submodule gitdir names are left untouched 
>> and are used as-is (unencoded) after the extension is enabled.
>
> And in order to make sure that a funny names and paths in existing
> submodules that can be misinterpreted as encoded would be registered
> with the new submodule.<name>.gitdirpath variable?

Sorry but this is -ECANNOTPARSE; let me try again.

    An existing submodule's gitdir may look like an encoded one (it may
    be littered with %xx if urlencode is what you chose), but we do not
    want it to be misinterpreted as such.  One way to ensure that the
    gitdir of the submodule <name> is literally that path is to use
    submodule.<name>.gitdirpath to point at the directory, right?

> That would be a robust way to transition.

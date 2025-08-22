Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514D529993A
	for <git@vger.kernel.org>; Fri, 22 Aug 2025 17:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755885544; cv=none; b=gNhGkhQ63tjEWwkLDzNDuzB4D0cDSODsI+F0/YJC5Is3GGj7Z0O9vaoVMI6eqKY8nqhNGLzOut0ZCYn0T//y+VcZDkxq2p0Z7zg6mcZmnqc2XbUHLRh6wLHHON8gg3FfQG9iF2vEWSgMdtiTMk87ZX6GvSsb39u7ggPICyugdiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755885544; c=relaxed/simple;
	bh=a7eYWBoWS+XakSGfLfEKg+rfL4GcGqxYOMnU4CAz7Bw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z+scetEJd+ZghnGUQkui7Uo9x0BUIz54Yr9Eci3nK/Q8zC5RmQmBKZds1Es7U58iaXh+5YjZgpMirdqvc/Vd51cCIw9rNf7vugZ4sac9N4O6+W3o+/szEMbIWtxFNOv+UilOcvk8G3ZTLKTfwe7AxTJOFHhyMeCuoOmAs/aUEq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RoKqXVFO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PFHmUrgq; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RoKqXVFO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PFHmUrgq"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 8FA52EC00D3;
	Fri, 22 Aug 2025 13:59:01 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 22 Aug 2025 13:59:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755885541; x=1755971941; bh=n4WJBKPeSj
	kNY07edsiVyS2H4XEoQxSDZ0bQdKiS1fE=; b=RoKqXVFO0RaH7zcyWEmfQoMza8
	TEMLKm578OUSFYWXkhUCEr5pmfpOTLRtKrz+jc9D/73FdQ+HAd/dn7rxCoaw8fSk
	QlBOznf4g/Nv+/S/BTUCFIjBggXcsA6o90RfDoy1EzL1d2CAEPXT/2UO4AdJLYBY
	HW0t1A6AMTJJz4y/WFOySJcOj61QFNngWWTokA0JDqN56ISWB1z3Q/uHryLG+H7v
	R8Pd2vhTNQHCbXmbfGfhUDhLlM9vgi3tjxFWaIC0cQ6mw1S1I7ujw6yAysK2pCkS
	Wtv7V/lKXU1hhpNFOnA2MSsdKKqmKsvsszvdUeo1ekK9KVUcz5QGss3/JKxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755885541; x=1755971941; bh=n4WJBKPeSjkNY07edsiVyS2H4XEoQxSDZ0b
	QdKiS1fE=; b=PFHmUrgqUAUH/IRhzihU9UeHT2RSFTyjC4h0CR260Id2OELmmwx
	W6boO3++jpe7MM5PwCsogzRHy+oE/LP4OXm1OLmtEy2uhvI6XHqDCeyMdFBbHL3B
	/SP/tORptksT2v0B0bbWEomvs2Pz7lCZBhvwe7um2tjc218GWCrWysFeGDjdnFRA
	XT4MGIqDAAy48OLcamAlRLTB2HIIwXJnp9OV5KCvjvnRcDjxKVU9HFX6BrEaVBLT
	fGT0JMBYT58fkIgZP0//T9J5isHGOZOPxjR2Yj3GfR+JDUSY9kAkiAdCmdd8wvPf
	i5IaLKwFi7DXEPBIsvX2YDYDVO720QAotmQ==
X-ME-Sender: <xms:5a-oaOGQeGdKt8scO5oSdfxyBNjIrS-PoE9y9WP_DsVeC4v5-l2EKg>
    <xme:5a-oaJ7j1XuI3GTs5QP69ZnKRSfLUdv3Dn7JjcyJNI-4AAYlQGPwhPGVKIOq-yFL1
    tnpxXLJsvFsHTDs6g>
X-ME-Received: <xmr:5a-oaEvsWZfhHmMhfCOs-UDE4JWpZZWU8JFdyqnhoqE172yH475oeBoGLgST9NTvvylLTGqhihCyCjmAbAlgC7xxRg76hauTH8rhg9I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieeggedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopegsvghnrd
    hknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:5a-oaK4z-sfix5EmC5M2SpyeVWQ3xM9U1CpYMiQv02gV_TsCB7sflg>
    <xmx:5a-oaPWi9Mbk8Y0LdvullfLkqQzWXn7mM6NVvSabbpAH936LRfAzPA>
    <xmx:5a-oaM-TWLjrf0sYz6Bv_nbVPvQiQwDsFhpcmBgp3WeltzmhTOAg9w>
    <xmx:5a-oaLnPg_Lol2YuoEsj-KUyQD-L0WYunT8FIH5vhAviz4NgPZvSCQ>
    <xmx:5a-oaNVFhLMNca_UWMwgSlIrJzmmpR3ICeDwIcg1MALOK13jbkl4cq4O>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Aug 2025 13:59:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Ben Knoble <ben.knoble@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH RFC 00/11] Introduce git-history(1) command for easy
 history editing
In-Reply-To: <aKhg0NBb1usxw-dq@pks.im> (Patrick Steinhardt's message of "Fri,
	22 Aug 2025 14:21:36 +0200")
References: <xmqqms7tao9o.fsf@gitster.g>
	<3600D877-4999-4EE3-8C1C-893E12D35B6A@gmail.com>
	<aKhg0NBb1usxw-dq@pks.im>
Date: Fri, 22 Aug 2025 10:58:59 -0700
Message-ID: <xmqqy0rbw84c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> At least initially I want to keep it simple, just to get this in at
> first. So I'm trying to be quite defensive overall and die in all kinds
> of situations that require more thought. That way it becomes way easier
> to eventually extend the different subcommands to maybe lift some of the
> current restrictions.

I like that approach very much.  Thanks.

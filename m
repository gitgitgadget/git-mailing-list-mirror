Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6363B24CEEA
	for <git@vger.kernel.org>; Sun, 14 Dec 2025 23:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765755892; cv=none; b=Nf03KulGY27TjmYdtesLRACjoEENhh41RVKm7Dt+dC9KSFd5d/Nb+jHAxKBjPba+O8JAEIZStyRhgEtR0sul3wT/Y6stsQjc7jOpvvQWIHYwbhtNtSevhu9iJAEFqTo1VHGL2aV5pZ/MYLSrQ4uID6/QdTlZ94EnNMzZU20m/2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765755892; c=relaxed/simple;
	bh=HxsX7DH30aka8BVmksBFN7zGAuD0SVEA8rCvSJUUVLc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NR1JQ0h4ye+Du5otRbSHSyVXTLXuJputHcg67vPujFAR7m6eFgVVwWhEzTLC188eRmke1H2xW+DMt3xGdYEMmFM+QkRrvJM9sMB42CQqTUVWZKPnBQFPLxEhpXeS/O+d/dNG76yPJ7M+/+C6aX5u5LEQvl+9t1gs8jRklLw4YxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LJBe+G7W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NURgg1TH; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LJBe+G7W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NURgg1TH"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7C4847A006C;
	Sun, 14 Dec 2025 18:44:49 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Sun, 14 Dec 2025 18:44:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1765755889;
	 x=1765842289; bh=JFrJ5bOAIUbn+iiHsXz39GO4NBqPhsO1fdhbAmIQgx0=; b=
	LJBe+G7Whi57fFO8fOJABJOYRaLP6R38jQ2reOkvHBnaXi/GI/azpW901V4qGGLn
	rAy1+EgKJZhkeSfD6B1Di2HVkml7TLJwOKJJ7+SnDG9JKLzvfAr72/tpmHSwUkiu
	dStyE/6aWzmC5I7kzjjmXQbc1dQfn0z+C/cFGyhHFrIrh3MgQ2Fk0Z9wH12ZqrkL
	W6qKhnLnqUh7ol4IPfCUd7c6UK6IVvGR4hJeHJj8WQOYcRUUDLtytDGx6SK9AJPD
	tapR7q8YK7Yfjb+Q7PVv2MxQ0zkwfuEPUEi0bRhIuHKXuj1UhcsxvC8MvXOULyLy
	rc8uFUYuqLabl0mxc7yJzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765755889; x=
	1765842289; bh=JFrJ5bOAIUbn+iiHsXz39GO4NBqPhsO1fdhbAmIQgx0=; b=N
	URgg1THST8Fz2ZuNHW86ae3YK7Qt4UrdvPTZNdLnRcz0a9rYxBWUNRQlFyhZKCWo
	bUVp4WkOdJyNGqrMR9QlZECg/A6d+9juBuv1CUh8DaC6JishwUj3wosx75/WecT4
	Qb1KgvgHWDYBrLeQMFilk0g7oc8dCisHuyE+f1QERcrQ4sm4QLNlG3wc5rzue5iP
	SFn0K29pMadMyF0k2XDEjv7g8V7mF5uD17IjMk1/Gb8802P58Aw+hUt3kVnNsocw
	Shgy3smPEb7x677zYulZHDiKVLKMxX9RHQVXmdh5l2UbygCOAssMpRW/OwOnhwgX
	GvpTbJL1kN8QhF44oANtQ==
X-ME-Sender: <xms:8Us_actB79Lj8oT7cAFZJV_Jcn9zVWzouufb1RwCqgLOEg8J_ttZjQ>
    <xme:8Us_aQcmTtkeGZ4_wqbJWU0VYa49dY-FKqUalOktZtZDMPoDNAXhZnXjLZ_iW5GRV
    5XxMf1T-9pPUcMIOeYGAXaAVPGv9ce9PetPQ6qSR5JyhJfgoSX37w>
X-ME-Received: <xmr:8Us_acyIzkqMMyYxQsoBnEwD1cekqNSPvJYRKlwh10V6bnmi4Z1BpVYfJxjagugQIch-UyTi_NafxtoNgyarOhniTFSlmWnd-g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefhedvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieegleefffffleeutddtheetfeeigfeulefhgeehhfefteduleeffedvleet
    ieehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpuggvvhgvlhhophgvrhgtvghrth
    hifhhitggrthgvrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtoh
    epgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptggrrhgvnhgrshesghhmrghi
    lhdrtghomhdprhgtphhtthhopehlihhsthhssehhrghllhgvrhdqsggvrhhlihhnrdguvg
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:8Us_aeGUB0Z1xJy-2nSbNIfzf5CXg1PCIKFuRID2ScgT1288eHZnqQ>
    <xmx:8Us_aYy_qavqoiwgp3bgTMic8Gy-eq6FKOTNsp-x8mkGlbOdX2-CzA>
    <xmx:8Us_aXukBOWU_3j7eNXVF2y8tAd8Y7FGWiVgk6hG09J1EimuFZYEqg>
    <xmx:8Us_ad2dD4K5Ec6W6SRpcZpKK7Na9BF3dkOEjTrf-YHm45a6hslgpQ>
    <xmx:8Us_aagBMJcpjiYAQj_S4XOjAkImAgqrFJyPlVwpBnd9eXaSYeVfpN0b>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 Dec 2025 18:44:48 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc: Stefan Haller <lists@haller-berlin.de>,  Git <git@vger.kernel.org>
Subject: Re: Would it make sense to add a commit.signOff config?
In-Reply-To: <aT7lkXl65-TBIsRS@Carlos-MacBook-Air.local> ("Carlo Marcelo
	Arenas =?utf-8?Q?Bel=C3=B3n=22's?= message of "Sun, 14 Dec 2025 08:44:24
 -0800")
References: <86c5d40d-5a06-4a69-90d8-a737685b0536@haller-berlin.de>
	<aT7lkXl65-TBIsRS@Carlos-MacBook-Air.local>
Date: Mon, 15 Dec 2025 08:44:47 +0900
Message-ID: <xmqqsedc8w7k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Carlo Marcelo Arenas Belón <carenas@gmail.com> writes:

> this was discussed recently[0] and the point that was made is that SOA are
> meant to be relevant mainly in open source contexts and should be explicitly
> given.
>
> Carlo
>
> [0] https://lore.kernel.org/git/xmqq4iwvfx8s.fsf@gitster.g/

Thanks for a spelunking starter.

Perhaps we should resurrect a proposed patch from 2020 (which no
longer apply cleanly, but quoted to show what the additinoal text
said).

https://lore.kernel.org/git/xmqqpnfw8gyn.fsf@gitster-ct.c.googlers.com/

to save time from potential contributors?  I do not want to see new
contributors feeling they wasted their time after putting their
effort.



diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index ced5a9beab..1909551087 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -171,6 +171,13 @@ The `-m` option is mutually exclusive with `-c`, `-C`, and `-F`.
 	the rights to submit this work under the same license and
 	agrees to a Developer Certificate of Origin
 	(see http://developercertificate.org/ for more information).
++
+As it makes it harder to argue against one who tells the court "that
+log message ends with a SoB by person X but it is very plausible
+that it was done by inertia without person X really intending to
+certify what DCO says, and the SoB is meaningless." to more
+publicized ways to add SoB automatically, Git does not (and will not)
+have a configuration variable to enable it by default.
 
 -n::
 --no-verify::



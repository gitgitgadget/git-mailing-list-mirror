Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC83C3B27D5
	for <git@vger.kernel.org>; Tue,  7 Apr 2026 16:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775579232; cv=none; b=TvTpOk78AGRPlNvBB0hjy4XkvneBE+uZTMoTFdZHtR70oHAWfpJE99y6ovn4nZQos27YpwqOvI4MbCeYbfJox2S4uvKGJ0JTuUC44mHwnhS+uEDX32Sj3hIRsZJBp5OrAj31R02RdxkH4sXQAqcssngbVfFQIi4+830HOuIDFeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775579232; c=relaxed/simple;
	bh=WQ0sJ1olfkZc2/gUZB/Nsyviy7uSTnM87QqfQLYCBXY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GWAqZySWtUVXSBWtaRLiDz13+jLrFK+NAap1gystzIBzLLH/0vJ1c881YsepylwdNnsoaQgytZNt7vh+QnVyLhxf320RI+yUeYSDkwJX1lmz2VZg3rAz9BJyVExUqyA/2Nkmpv1fjsRRa64n+fN8uDh17tJb6s4Dv8i91Wsr0TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OaqRRg5a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DDHE99pt; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OaqRRg5a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DDHE99pt"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id E58C4EC0092;
	Tue,  7 Apr 2026 12:27:09 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 07 Apr 2026 12:27:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1775579229;
	 x=1775665629; bh=aWSziigtLaD6EkG3gClZPw6Ww/jf4TrxfS2iavwiN7w=; b=
	OaqRRg5a9sCRb8ov8RuTdVkZEtkphyGRMViDFkVVRGMk987l8thErCncfpkwd/gx
	0hlU4M1zQiAKpEjgjHi7dFZOY8JzRBWQaKJx5WthA/Ysh/GRqOncKdKx4mz8Pybc
	GEHQGv7sq4vufDg3Yq0Z5VBxIDAUxmaIIqcbzUZVQFQR21WcV3KpA7C4W5xPDBcH
	1G/LsS04ztW74ZtF0VnOJaVyBBsgxMDIfAseDqwK11QNMIiIQ52416QbKq/AXkVr
	xyy+P3jGxczWif9Y0yDyQj2gKS8QglmQ+ssWcF311JeDxMdHr+ZXgJANf1YlpBcd
	vnwE5Cd+eFQQGwghpoQUow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775579229; x=
	1775665629; bh=aWSziigtLaD6EkG3gClZPw6Ww/jf4TrxfS2iavwiN7w=; b=D
	DHE99ptxkP2fwf//AknZA2ADpdyuaBgiiNqYnGFvGqAm8IL1eURAc4zVZ1Xl+iSg
	+s5n/872QBKf5qlUF84TzAvbU6H1OwjJLaVHvRaBt2EI2FEpGcNxZu6cdNLBLFyt
	fD+2yV00v+ytQ+C/McNtAI+jwtXdfQfgVHdCc0Ri0syZKPIr8Qj8L1MA/FHb+nYr
	idIkFtdjGAYxskLFm7z8aDVhdl95wwI4+/bG2uhBlcxStIcqBwBxi5vTSsN9bLpl
	fR9UTfPtej2Wpx4H+5fse1r5xoeFl1cDq6FRbRKDwxSZcQVFF/wjrk56l1Mgrygh
	ucCk0hF1L5DKMhUNA0BBQ==
X-ME-Sender: <xms:XTDVaSMwsG34LrroyZtU02Kx3XlUWK0j27AMrWEGygfOrtipMiwm8g>
    <xme:XTDVaX3XtNS37OPLXvhzxGpscGzGSlXOEfUoaco9zTmJGY3PDWQeHhlOfPiAh1W4r
    lllmd2yvs-xzND0iUUVXktJvUt3QN1rsZcYygaE7HaWLI8HnT77>
X-ME-Received: <xmr:XTDVaRmh6LrsAmjdhNsIVmYzi5UR9rxD6kj-qPAm-SGkhhcMTeYJdao5Sa3xcTeWEcjpNvFEeM6dOjuePvHU0agkqzLgvEJerQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvuddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhephfetvdejheduheegleehfeeivedtgeelfedvffdtvedtudffieekieeijedv
    lefhnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsvg
    hnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehjvghskhhosehstghh
    figrrhiivghrshdruggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehgihhtrdhvghgvrhdrkhgvrhhnvghlrdhorhhgsehstghhfigr
    rhiivghrshdruggvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:XTDVaeU3dkwQoPgBRmwmQNTlfpu4wxfJNUqVU8oG0psJgimCNQPgRA>
    <xmx:XTDVaXtHvxYbwiUK_Zw12ct4ZP0XZl2b8l0l8QQpIsUbwz1isuYcjg>
    <xmx:XTDVaRZLCh3uYhffbj35-wPUBZujtXhwgqGOgFjLhDY6Yq_VQU_ubA>
    <xmx:XTDVaWUEWT9mZ_tH00hgBZPqst_x0bojQx9XdD_BeOYx7q0qLHHC4Q>
    <xmx:XTDVaaAUaIoS6LAmcM78_vIGgaV_5PtdJ8_EVMj6FReiBe_zZgti3nfq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Apr 2026 12:27:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Jesko Schwarzer <jesko@schwarzers.de>,  git@vger.kernel.org,
  git.vger.kernel.org@schwarzers.de
Subject: Re: checkout: clarify "up to date with origin/" uses local
 remote-tracking ref
In-Reply-To: <xmqqpl4a68o0.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	07 Apr 2026 09:23:59 -0700")
References: <xmqq4ilm7q1n.fsf@gitster.g>
	<5DFBE9D6-0EC8-4702-99C5-827AEF8C6265@gmail.com>
	<xmqqpl4a68o0.fsf@gitster.g>
Date: Tue, 07 Apr 2026 09:27:08 -0700
Message-ID: <xmqqldey68ir.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Junio C Hamano <gitster@pobox.com> writes:

> Ben Knoble <ben.knoble@gmail.com> writes:
>
>> I seem to recall a recent (last ~6 months) thread about “last
>> fetch time” and there being some question of how to record
>> it. Alas I haven’t searched the archives to find it.
>
> Is it a bit older thread?
>
>     https://lore.kernel.org/git/xmqqh65b2ci3.fsf@gitster.g/

Wrong link.  This one is better.

  https://lore.kernel.org/git/CALnO6CB2TjwRWr0=c2nWY5DnwLeqXiaA5fCiEeF85zivmLggjA@mail.gmail.com/

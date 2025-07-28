Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFAA8BE8
	for <git@vger.kernel.org>; Mon, 28 Jul 2025 18:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753728563; cv=none; b=YcOIzTdxFWrJm67Rug1mYXXeT4iR9Xd9LCVLEjLSiYX1r92jzyI04g+9de8IK/gu0YDpzxtvVNTSu61xpGZXj5u/lRI5dmP+gcwe1GPIWzbOhxOqV7ZMM+mCZDJJ56AZrZmbz7tUne/M0MK3fA4C3DW1W1dtlBw6zxW12UnCMts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753728563; c=relaxed/simple;
	bh=kcODeQGbtYjOZCFY1RgZEHWf7zM4LSbmkyv4B3/bXl8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BpM6wvl4wnHkI2sJYgTRWLCkHJCq0DFS5bsgyFE9IvDZF/K1eWgw/n+/BT2jl4ctPno/78tQbNu1/yscDHWscivykjYH3RQawTtBgWdVWTBvxVrBviaK4MLy5hSclnp+s6UIrAzme/D+6a53kyI9NGhS1Nds0Rg/9GorMa3L/eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OUxXMoFn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HNxzo3HC; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OUxXMoFn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HNxzo3HC"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id EA8B01D002A4;
	Mon, 28 Jul 2025 14:49:18 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 28 Jul 2025 14:49:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1753728558;
	 x=1753814958; bh=XBVnPYyLWCnY3ZIsYpqmQUa2RPxPWRqWPCIfqQZAWJk=; b=
	OUxXMoFnzyVACp9xlz/ETAIoN/sgxpgh4Ttm6jZwkhQpEtV5wYVKsz9I2BCKSoPs
	reQ+7vy71lOyxK4PlRL5kPfk1V1fMi6hNu5Z2+pxjoW7slrGeZoe6Dov1hL4ERt4
	kmXLPkMjB2kgO0oRXkjp+RNh414RegkQ7k0+auovGO/keADkpQgXquGYgw/gAjnB
	FJDNC+UaScJaRLpxBhzHZKjmyUBgvr+cE6pusRsQm4Quc01ymzdz2Prrh+dyG8QR
	PPb8seX+G6iA/VSS1bSb6CfhzS9submXg2Rn4Fa4ZdTg+fkkollrC4695i4j8S9N
	x8vzxHdjtKXkOMBZAkdf+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1753728558; x=
	1753814958; bh=XBVnPYyLWCnY3ZIsYpqmQUa2RPxPWRqWPCIfqQZAWJk=; b=H
	Nxzo3HCwWNytMjrokKe2nh8zgxWiuHlGFfPFSoD5s/ZupExqD3bQGmx6zySaUR63
	AgtvPJMe+mQGbJ5dOPip64I2dx0Z5sBjJxzaQ1Wijcx9hqofWqPymDB+CGoEPY6i
	D9R94OJTax6PwM5PTAXox+ZMv5zCi8zvulBeS/Jl9n6zGvn4Wxagxv9PTbSpP+hh
	Nae6F0zYABLeaFxsDNO7Dq9Y/u0YNDrieZunWDq1B0av3QKkcemJ93KQTU3eeMF3
	17E7nuElJglkSCblTxYwXD4T2ujA2hBNaa2RRV3obvw2/+aTtyyFUsC3AjLIrEWJ
	HNWJEr5ZRD9Ml2imJe3aw==
X-ME-Sender: <xms:LcaHaEoU4JrPPUwsM6C9zWm5Rod08IZC-UDAYAvQinqjgr5TBdQPYQ>
    <xme:LcaHaHndZ7czn7ET75JioJ2UjDDa_EQyDD7laK-oXISnxUpr2njSnFsxIL3GDq6NC
    7gMIdqjMvcZGvdgag>
X-ME-Received: <xmr:LcaHaE0gqfYV7JLuooGt5ZGI5SlortJd4RiIF6FOQ7fawF3wY95odVzD5mSGl5M_JHY2et0GJ8rfYYsuL3wz6aITWKcwTfc0kE9buBA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelvdelgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfh
    grshhtmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghi
    lhdrtghomhdprhgtphhtthhopehsiigvuggvrhdruggvvhesghhmrghilhdrtghomhdprh
    gtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:LcaHaER9Qq4FHBS5fayVmCTTbUJGjFq_MwbirdyEPmF6q23kJpR4xQ>
    <xmx:LcaHaNxrQkICJH-FgCqc2eA94D44ZCkB29ZEXVKb_hPTHALffxnOBg>
    <xmx:LcaHaEDlwpxK_E40fGC2zlat_kEHvJ48D_cdfOuABh-Yjzu_vesFLA>
    <xmx:LcaHaJH8puJxbfWKhsUWHUVAuZfirhad28VUYizyVsklRLRQ39noTA>
    <xmx:LsaHaJogJxfRkfZGLMIsKDQkYhfJMtdKsv2Q1rIZnwPSghkxwV-u4RGn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Jul 2025 14:49:17 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Patrick Steinhardt" <ps@pks.im>,  git@vger.kernel.org,  "Karthik Nayak"
 <karthik.188@gmail.com>,  "Justin Tobler" <jltobler@gmail.com>,  SZEDER
 =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,  "Toon Claes"
 <toon@iotcl.com>
Subject: Re: [PATCH v2 4/8] builtin/reflog: implement subcommand to write
 new entries
In-Reply-To: <6414dbfd-6f34-48d1-aa3f-3fe7998f80af@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Mon, 28 Jul 2025 17:33:32 +0200")
References: <20250725-pks-reflog-append-v2-0-e4e7cbe3f578@pks.im>
	<20250725-pks-reflog-append-v2-4-e4e7cbe3f578@pks.im>
	<6414dbfd-6f34-48d1-aa3f-3fe7998f80af@app.fastmail.com>
Date: Mon, 28 Jul 2025 11:49:16 -0700
Message-ID: <xmqqo6t4up5f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> I tried `git reflog drop`[1] and it can deal with a branch like
> `branch`.  It doesn’t need to be told `refs/heads/branch`.

That sounds like a bug to me.

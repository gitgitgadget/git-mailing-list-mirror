Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05DD1C4A20
	for <git@vger.kernel.org>; Sat,  6 Sep 2025 12:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757163057; cv=none; b=A/N2a2PIgaIHxa0VxymLVZLpKiQaVY8NQq/A9DXYIK099Zk8fQ6Tifaux+dnxH48HUP30SRXH7kmBRPuMWnIplIJVDR6nP2Qe3kF2BO6wqFgp7PHYSfWuLDE/tmdwS6Zr4XwqeeSCWE53f1nDnSJQsXBP++d3oK6iheds9zmXEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757163057; c=relaxed/simple;
	bh=q/bTr8GOwwEUIcVjVrwCYoHRPr9ma6gDzUjgeLvGGJU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Y6Be9zNI4/JcEZva6Y8hsXZ7dKZHCwMEWceN6lVh4rJNS/GscwNlHZ0LhJnbTcFW7TI5FmWPtkdasY0aEHX8PVhwMj7y6QKHsRd11nVX9bsOz7nWNhsCILDlWNFm3Qkw3jLPOqornTr02sf2OXywVbr2nchCFGKbdG8+xEJtIdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alchemists.io; spf=pass smtp.mailfrom=alchemists.io; dkim=pass (2048-bit key) header.d=alchemists.io header.i=@alchemists.io header.b=R6TJUzSp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q0IfCAFH; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alchemists.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alchemists.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alchemists.io header.i=@alchemists.io header.b="R6TJUzSp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q0IfCAFH"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id CA5831D00049;
	Sat,  6 Sep 2025 08:50:52 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Sat, 06 Sep 2025 08:50:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alchemists.io;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1757163052; x=1757249452; bh=HqTiK4lPkXXmXu56nPczmmFf0ZhxlYXR
	MEGghP/ky6A=; b=R6TJUzSp+/4eBCQaKKzGRT9WS40mk0dBWqIeAPmfX4Pyx3iL
	oxcBhchPQ2hMYXTp4OkAcgkD/huzdDeuSfZyb674ME1iM/verx2nH332rcQFmH9v
	CeCjG4jUd4BIMgxnrkqqf2cE6eAlOtjn6viCEXxcZ5vngc4hav65mzY0uId4IZoU
	swTw6TcU6RN4xzfW5qclgm7Xt/82/YSvV/T+OQGBuBhv6FL4xb/cg46Qu5uDpVx9
	6HObsoaoN9ljfH7N0kWImBx1vXchklJx5jicJ93IHSFS/IsZYcxA0bccOhMEvE07
	Ib7cb+tWCc1GlCXyvpPWy/3NhKCkSNlnh27PUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757163052; x=
	1757249452; bh=HqTiK4lPkXXmXu56nPczmmFf0ZhxlYXRMEGghP/ky6A=; b=Q
	0IfCAFHbbWTk5URnnN80kUIoupU2+N3/hoMOQnlrXCX6wReSL+IH4KDwW1PhY7Uj
	ikRbZ+atMakNKQBplaI7oRQOIu1gy235O28sFgJ4Z7My6v5FJnWhdFLXWJbJdlyC
	m0J1UUAo3RIhK4bWxfR8qEjeu7FJGYpSrw8319DlyE+phxAv8IgiyNcyKhVBB1eM
	HOqzjAsu1K6T+0z86KnlFMA8seqx5gXGZE3Q4RhL+d+0iIjLB+uC60KwYgSuZ+1N
	llSRIAS6Z/Cs4Fp9nolvJnA2+zKF7+52humJD3NA71mFN5aNnGR7PTk1fiAFIjgy
	1IdKYX7Cxqk3KDCTxw9eA==
X-ME-Sender: <xms:Ky68aJogtMO_oyqhxJx3JnR1B13Gn3W6vyA7rSx322UxqcX32ummpw>
    <xme:Ky68aCi5VS1WyqwfKbltKcNdJ6jzeZLCBuLgYj2kWIwlD677IddoogmyuWuET3PHM
    4W9aJCy4kJKHlxQ>
X-ME-Received: <xmr:Ky68aDJHS72Viaf2Mha51Q-O08IuRqLdHXZaTpAdHWAjdLm3EzH3gMmI3KhiSIMmt24Y0Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudekudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurheptggguffhjgffvefgkfhfvffosehtqhhmtd
    hhtddvnecuhfhrohhmpeeurhhoohhkvgcumfhuhhhlmhgrnhhnuceosghrohhokhgvsegr
    lhgthhgvmhhishhtshdrihhoqeenucggtffrrghtthgvrhhnpefhudejiefhgfdvtdevle
    efiedvuefhjeffgfduffevhffggfekueeiffetudffudenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsrhhoohhkvgesrghltghhvghmihhsth
    hsrdhiohdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrghnuggrlhhs
    segtrhhushhthihtohhothhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:Ky68aCBG76b25q_YETmmr0lRm2-TeK3M9g4_vY2tIK2tUFvwsF6JOA>
    <xmx:Ky68aDhckNVDENgnOjGb4DN3kwW0FrToOVajxu1ht8oPC34eWcFf7w>
    <xmx:Ky68aKmh26KE1njh-fxxdnH45HmV6yTXriP20V44dMbGLSHrYx8OXA>
    <xmx:Ky68aPq4rRnLJlQFKHokXdmI_Qgm9BR4iBvSOwmA64ZjoDJ0TK7gAQ>
    <xmx:LC68aEozRL-xcWNCJbyfeZxPv6adssXyMAoVFFJwy9VEcIoGkhHCE4Sx>
Feedback-ID: i78e840cc:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 Sep 2025 08:50:51 -0400 (EDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: Git Stash Synchronization - Best Workflow?
From: Brooke Kuhlmann <brooke@alchemists.io>
In-Reply-To: <7a206ee3-d68b-40fd-8133-79e4c2be7174@gmail.com>
Date: Sat, 6 Sep 2025 06:50:40 -0600
Cc: git@vger.kernel.org,
 "brian m . carlson" <sandals@crustytoothpaste.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FEB150D4-2B5E-41CF-ADCE-93DD0B48D364@alchemists.io>
References: <7B1CCA36-23F1-410D-84ED-6E965989EA8B@alchemists.io>
 <5dee5f49-eeb6-49e2-8bca-6ae6a1d6be5d@gmail.com>
 <CE34C4BA-1ED4-458C-A31F-3DDB61ECCAAF@alchemists.io>
 <7a206ee3-d68b-40fd-8133-79e4c2be7174@gmail.com>
To: phillip.wood@dunelm.org.uk
X-Mailer: Apple Mail (2.3826.700.81)

>  That sounds like a bug if you're getting the rejected message above =
but the ref on the remote is still being updated. I'll try and take a =
look at that next week.

OK, sounds good.

> You need to pass the name of the ref whose reflog you want to look at, =
otherwise it defaults to showing the reflog for HEAD. You should be able =
to see the reflog for you exported stashes.

I gave this a try and every time I use `git reflog refs/stashes/$USER`, =
I always get a blank response. No errors and no output.

> Let's try and find why the remote update say's it rejected when it =
isn't and then we can think about the best way to document pushing and =
pulling exported stashes.

Sounds good. Happy to test more of this when you're ready.=

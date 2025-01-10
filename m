Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49DC20A5D5
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 23:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736552652; cv=none; b=kUgpfgqIGuy9BQXm0VhZDg4gVNZN/8pKQ8PANAHhWxRdGliP834HyaY6FulJXVkdnGjtQM1V8l1NB2ekWN81CSwG8NFj3s1wVTbglcnFHU293/KJ4lqS2BqJPf3K0x9j5Uu8MOLsQhIrYCq77rO5S80VevwAG8lPT3mpbfXJLFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736552652; c=relaxed/simple;
	bh=yJPrWz6E1kbNgmHvcAm8a/K1iJOqW7BKIGziXRnzanc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ftOR5UWKzF3FUq5RCVWHK71TDkRpVOAPW5BoQJXWmaw3Y7g7///F2rTFdSqUnwSJuF8318rd8ID8a9NvYgrShdfhZaG1V55KPJ0C8CksMoRWACDI2WeD+MsIyaIyVlCu4EJqNmvEzvjoG70jP2jUt28prg1J2JdtUpMYtkg1H7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rBlG3DAs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tQxSbc1O; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rBlG3DAs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tQxSbc1O"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id A28C1114015D;
	Fri, 10 Jan 2025 18:44:09 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Fri, 10 Jan 2025 18:44:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1736552649;
	 x=1736639049; bh=ZKCE+oUYf5cSqy4UQXdyaYg4t4pNeXGLRtLwVRhhKQE=; b=
	rBlG3DAsATxgzFZV14Em5qSkNtn+c7p2rmIPhP2j5gt3oEHzQ4AM/IbVesW1e1dt
	gbqaM3w6cshLVeImeBBKXV06JBIw0quUzpZ1oL5GqHLlCdyGlcnGQgtY21CKZtp6
	0arYotA3Z874+LSoMRAcGp59QnKarDr0k44grUwfFH6OYBUvSSQpHYFMzVTTiLCT
	yYUFuohr0x2YWgb3m6bF+ris/eECY32D3zvOrcPw9B9wgyoJHgXoKOzxW+UHKv4K
	f/AGEGHOv3/MRbuKL84WNjHW7GYTDLLlw74SKa8t/zjqQofXk2udxegE+J5iORmU
	DKi2WpjV6fu2hJWuMpqN+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736552649; x=
	1736639049; bh=ZKCE+oUYf5cSqy4UQXdyaYg4t4pNeXGLRtLwVRhhKQE=; b=t
	QxSbc1O84RCA2LIJ7lJOn30NyaCAhtGlRmpta8xXT1TzzRv1zXeIAR6IY6z9VA1K
	QqCrKz6eTuCtGs8Rqv4r0IcitpCzMAwY//tO/5MQuRH5knROkE+EYqx7Uv9kuLBE
	Oj3Z1GzTvoZrs6GQsE0rR9BfG6J/K6aIq/dsBWnQQw1jP2iPdVSueEzjpErypv48
	e6GXaSc+EPfHyL+e6uNzV8OBVL31qOm1YNl/PS5fhwUN13s6sFZ+n3lz6z+cTEwY
	3sWEntfN/z090s6n7MtLfnfchxwdyWkSQRrjJbCg17ZguksydBvStHI8Simsv+lS
	bWkmif1HJqIjxM1wW6RVw==
X-ME-Sender: <xms:ybCBZ_sJRZ8jlY0nfLhcE27ZmYtWmQHZr801lR_79vIVHMGjbrgmrw>
    <xme:ybCBZwfetvzFiqxqtXS_a6D39Wjyu78gzeCq2VEheJM7dIMR6oXv9fZA1s1YTZROF
    ovFcoEnvnZ9-XD0lg>
X-ME-Received: <xmr:ybCBZywrK51WtAEoLsuBFF5wGKp2WakYNnpfhXGy0Dhx33qa7CKF8LSHm9JEdf9nMb8RLRHY4Oh4cFTyhb-q9oD6N_Yig81KJnX4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegledgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnegfrhhlucfvnfffucdliedmnecujfgurhephffvvefujghffffk
    fgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoe
    hgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteeg
    vddtkeetfeevueevlefgkeefheeigfehveehvdekheelveevfedtheenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehrrghnuggrlhhlrdgsvggtkhgvrhesnhgvgigsrhhiughgvgdrtggrpdhrtghp
    thhtohepmhhirhhthhdrhhhitghkfhhorhgusehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthholhgvvges
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ybCBZ-NVnu227U42Rh6NUwrXTtw80aREn2Na9L6jQOAC5Xa-Yt7JWg>
    <xmx:ybCBZ_9HHLHrNxtJteDPNRk7xzHG1HWUwH9-4mOMmxzhVG7hnr-HBA>
    <xmx:ybCBZ-VdtNPvEpkpaBGae41RbLDKFyroDZ_XaqcavwTQkl8DN-33RA>
    <xmx:ybCBZwdK4ce-e2_S9t8tS0QANCOMbn4EPcxImfz77EgeQPtZSFmfzA>
    <xmx:ybCBZ6lRVoylK14uJ2wxrkTWPrUwV_kT_3CuBoI37BUXaXAuG3CROiN_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jan 2025 18:44:08 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Randall Becker <randall.becker@nexbridge.ca>
Cc: M Hickford <mirth.hickford@gmail.com>,  "git@vger.kernel.org"
 <git@vger.kernel.org>,
  "stolee@gmail.com" <stolee@gmail.com>
Subject: Re: transfer.credentialsInUrl should warn about personal access
 tokens in user field #leftoverbits
In-Reply-To: <BL3PR17MB60207281A26259F5D577B2B9F41C2@BL3PR17MB6020.namprd17.prod.outlook.com>
	(Randall Becker's message of "Fri, 10 Jan 2025 23:36:37 +0000")
References: <20250110210500.675629-1-mirth.hickford@gmail.com>
	<xmqqh6665p8j.fsf@gitster.g>
	<BL3PR17MB60207281A26259F5D577B2B9F41C2@BL3PR17MB6020.namprd17.prod.outlook.com>
Date: Fri, 10 Jan 2025 15:44:07 -0800
Message-ID: <xmqq1pxa5j5k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Randall Becker <randall.becker@nexbridge.ca> writes:

> My email rsbecker@nexbridge.com is being blocked by gmail, so I cannot get to Derek.
> Anyone know why? Have I been a bad boy somehow? Resending via another account.

It is not you, but him.

commit 6e5457d8c7332c279e1482c442922f954af5f8f2
Author: Derrick Stolee <stolee@gmail.com>
Date:   Thu Oct 12 17:30:33 2023 +0000

    mailmap: change primary address for Derrick Stolee
    
    The previous primary address is no longer valid.
    
    Signed-off-by: Derrick Stolee <stolee@gmail.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

diff --git a/.mailmap b/.mailmap
index dc31d70b8c..82129be449 100644
--- a/.mailmap
+++ b/.mailmap
@@ -59,9 +59,9 @@ David Reiss <dreiss@facebook.com> <dreiss@dreiss-vmware.(none)>
 David S. Miller <davem@davemloft.net>
 David Turner <novalis@novalis.org> <dturner@twopensource.com>
 David Turner <novalis@novalis.org> <dturner@twosigma.com>
-Derrick Stolee <derrickstolee@github.com> <stolee@gmail.com>
-Derrick Stolee <derrickstolee@github.com> Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
-Derrick Stolee <derrickstolee@github.com> <dstolee@microsoft.com>
+Derrick Stolee <stolee@gmail.com> <derrickstolee@github.com>
+Derrick Stolee <stolee@gmail.com> Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
+Derrick Stolee <stolee@gmail.com> <dstolee@microsoft.com>
 Deskin Miller <deskinm@umich.edu>
 Đoàn Trần Công Danh <congdanhqx@gmail.com> Doan Tran Cong Danh
 Dirk Süsserott <newsletter@dirk.my1.cc>



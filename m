Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4302FE053
	for <git@vger.kernel.org>; Wed, 10 Dec 2025 11:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765367781; cv=none; b=Thy6hHIMmOg/26Ghkcx3RxO/TGKCxt9rcHWtSg1nB6HtS+g93B9jNWO1Lz/ZA4X5SL+GCz4WdQUFroMfg3OiTbxT3X1bl9zXeQwo9dFhnEYYdkaoWP1ukiss+mLnEOZhOrc9nOuFu2wLcfQMP2leBFmIjdedHG66uMRe/9s+Juw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765367781; c=relaxed/simple;
	bh=rSCuk1IltqF7R3MKHGNva1ZIaBtDJZqORtFSTGBDILs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TNGT5ULAiOZ1AUTZysR37HG/tNnLwbZxAzoTwk8PsrlbbRfGm3saXxe7/hB6WCykrKqYCANN7Uj0ds3LLFBMVjai5QqUx7uF6acW9ulm9/ZbsQNIAHU2tosUXOlRCrHfxYlVvtjknrrFeZR3NIcuvdhyQuMlR8QHKxrEHQulPO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Akv963Ng; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yZXyAfCP; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Akv963Ng";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yZXyAfCP"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 9A0BFEC009D;
	Wed, 10 Dec 2025 06:56:17 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Wed, 10 Dec 2025 06:56:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1765367777; x=1765454177; bh=465I58nKCf
	13eH0NsBm6cWHlmEzjR5zNBc9ok/Xz1sM=; b=Akv963NgYcp287h3tMkuKsU4Hb
	MBcwbqE5Xnv/+lT+ycIJh8MmYkKGNyDvCBfs1m0gnSqFN4qc0vQVKBXtLYe6O0Xp
	WbYwaMD4frJoehWD0w54rnHsU3SmgtMjqukCH5W9pKuJmnO8kgl6kQfyAzaB7Ddn
	LXmtgWQTUNUz7aIIqExCkBoSSyhu78YSbP8hGxFMC15uM85TxELuPirqD4PD435/
	nxcURp+R1aqOyDArh3av+XveAy3wjQ/+HBrbkMtOwXFmNlujLFNzdc4CBMOhLlEo
	vKoC9lwBxxx4d0mCmgdLyvvq/DPqHkQw6c64q4FXkBY4vk7aDk1L5UUn5d3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765367777; x=1765454177; bh=465I58nKCf13eH0NsBm6cWHlmEzjR5zNBc9
	ok/Xz1sM=; b=yZXyAfCPZx1XzkS7cSXwY2jS4xb5cwPlEcD8lSVvZwhVjsY+jON
	ElDo+woNcBCFVu4VneTvtkIRWEiUWW4gUldnvx/ZwFQFDMSO96+gjKIkorS6sv3d
	DR5CXtPDbegOKoZncsRJJeuvsHMGa+f752BSFqfrHlNHy75oLgrs/m4hMtLi2hlM
	ib+VjXqJMbagkVVd/4+kAGbT5M+wONG1oJbQHBk1kNzJiOgaBlM8XJ8x81muo/oG
	70yHSqMdAdPykjIvfXJJFuU1EkLF/5h5ddMIfozfRRk24Gb++H9NW5Dm2Tzi+Tu8
	uPuNkyPExmy2tgw5oWqa+jnd7+mz+FdLhcg==
X-ME-Sender: <xms:4F85aRMKBhE3n6b6DRnIhpzzLtf4j-877cvDULiKi764CrSD0-fHCQ>
    <xme:4F85aXBdmKCwFwA_EyCg-ToV57cziV5Mwqm3eA_-VJMBuw46q0fs8VmQd0q0ZRccr
    7U-qoSfPn3Sfuc7VmV2fL_lygOOjTC_kDznl9DETzRwfk8KYXnohQ>
X-ME-Received: <xmr:4F85aa5AMOT_rzocVCc-aloDWIOTbaUp00QoAIr8VC4rM1dt8fk3ySEVHpamdYKGG_v8F7a0GM9Q3dPWu1F5apRdhv2vziG7xA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopedutddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgt
    phhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtph
    htthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    nhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhiugguhhgrrhhthhgrsh
    hthhgrnhgrfedusehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhoohhnsehiohhttghl
    rdgtohhm
X-ME-Proxy: <xmx:4F85aZ5VEuAQfvoBCElu7-wc8QKGaYYa779WxfYJ4yM-Xp6vLc1tYw>
    <xmx:4F85aUTRImZ7XJOazBswJEn3QpeTaS7DTGY501zedsm_lQyRJ6AB7g>
    <xmx:4F85aZ9C-Gmo_VgODbxkBeqNNHHNUhWG2neYCHe4at94bAmoBtVfAw>
    <xmx:4F85adb5nQAGrjMHkmeVy1CSi6NP8s2Id6Y_HRPBwPnb9jx950ZoSw>
    <xmx:4V85aeV4t1E1M6hLmBMzAlyAZtR7hZ3Cha9cQjrOGex4ksBfSNtyyFGi>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Dec 2025 06:56:16 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  git@vger.kernel.org,  Christian
 Couder <christian.couder@gmail.com>,  Elijah Newren <newren@gmail.com>,
  Siddharth Asthana <siddharthasthana31@gmail.com>,  Toon Claes
 <toon@iotcl.com>
Subject: Re: [PATCH 0/3] doc: replay: improvements like "mention no output
 on conflicts"
In-Reply-To: <74a705b5-bafe-4304-86ea-fd3873ae4fb4@gmail.com> (Phillip Wood's
	message of "Wed, 10 Dec 2025 09:51:21 +0000")
References: <CV_replay_conflict.101@msgid.xyz> <xmqq1pl6lzt6.fsf@gitster.g>
	<d2a72ba5-ac7c-490f-9f2c-6cf849e65180@app.fastmail.com>
	<7d0201aa-905c-4da2-932d-47666c923875@gmail.com>
	<202f7015-1e7f-493e-bd82-474e5cefdf01@app.fastmail.com>
	<xmqqzf7ri7q7.fsf@gitster.g>
	<74a705b5-bafe-4304-86ea-fd3873ae4fb4@gmail.com>
Date: Wed, 10 Dec 2025 20:56:14 +0900
Message-ID: <xmqq1pl2im8x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> We do talk about "branch heads" in our documentation and they point 
> commits. We also use "tip" when talking about the commit the branch 
> points to so maybe something like
>
>      Update all branches whose tip is replayed
>
> though I think it would be clearer if we could say "commit" somewhere as 
> that's what we're replaying. I find the concept of "contained branches" 
> rather obscure.

Thanks, I do agree that "branch head", "tip of the branch", etc. can
be used pretty much interchangeably, and using "commit" somwhere
would make it clear.

	Update all branches that point at commits in the replayed
	<revision-range>.

perhaps?  I dunno.


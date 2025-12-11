Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DD42AD3D
	for <git@vger.kernel.org>; Thu, 11 Dec 2025 03:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765423304; cv=none; b=kUs5soOMJKGkQr+qCpHWBFvfWIWpbha5Wja7bHyzxeQ1vNYuugwPEgCx+Mu3sOqU58fy2YcIkarKIpJwSVlISNioviISu2HUiFIXRkLhbxx81AUA/mY3doMsCc9H0L52rgwl7mug6431GDa4MKxYjObfwxG3ovcdkDMI8WvgDoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765423304; c=relaxed/simple;
	bh=SrT83IHhImXn0mJX7rPj2YiISOMXeJaEhFQA0f2den4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uuld9ZEkNzHFEEbiDb9C6wfPLUkQ1WagqRykKz4wJ8AwUVtzjxUHTQBh3SxncwMG7AwMhTryGGx1QDS+cr/Feg+7SoAv5VpXRg+horEftkyC44x5T9VZoEaqkcJqPJEAlmh0mQ3OZLDhvfq2nUyEtMJ0lE4m58xmpjTUK4mX+y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=aSmVlcMG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oVcKeBLj; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="aSmVlcMG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oVcKeBLj"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 19A827A0165;
	Wed, 10 Dec 2025 22:21:42 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 10 Dec 2025 22:21:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1765423301; x=1765509701; bh=s2b1Hxq/fw
	UraSYbiD8s5fX2TGxVt/9pvg9kD6WVaMc=; b=aSmVlcMGAj32kYXgkqPSiRGvr6
	+a1EMydRLueFxqy65bT4RbbALbkMFreK3CDfAaUoJIwrwSUYKCjqaHP0Tam0DHbA
	n3OtxLvf3nGhwrXj0Bcyo6g0l4HLjBRsHRvQg28spFUS72iOqgJ6jQxYJdSnOYJR
	JTVFW+LvVjucW+wFMfaYKpUjCpj64NDhg/fovL0TgGiLf+ZUE54YA2TbtOoeXN/1
	7uhIoXxN8m1/zqg2IR0dR1iuovENYMkn0x7ErGFkzyi7U0AFGbG6rP+Eo5uhGENo
	jiJkWmcCmL8SbxsOZenm6kci+ZQOwJD2ndbD/masisSQ8EQvzVNh9m+xKCKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765423301; x=1765509701; bh=s2b1Hxq/fwUraSYbiD8s5fX2TGxVt/9pvg9
	kD6WVaMc=; b=oVcKeBLjgTvz6+g3yrDyJ62kGgL++zOhmww89hQjfSbqzveUDUh
	cppczmjhVF/p1zTVomKf8VOZWI1DeG6zGcZn5kYwbNgMEOyGHtFD14PuCGxh4I2z
	JGPE7o93P+CQzoBCQgWUbYPALEObed3amIUlo9TFYMJlTjB/KF9QFkCZ6YOFpIJI
	RBTjdug07wQJOxO+pazJIJ6un2aPN+hA961DHYJ0sV9exMuGL7jl93bLkOdcTZ48
	LmtyBCVwb4QV6F72yUZj1Hbjhwzh642HulPqTQejelGfPgh74z0RL9FLER7p8w6Q
	ltQ52uIn7cqGtHBPj20UvmLSKTrAh1i2X7A==
X-ME-Sender: <xms:xTg6aWIJxTch7kW4XHyZ27obT2SLN8D_CIyph0UA8SlHy52vll8QZw>
    <xme:xTg6aVLL2cpGwz1uJvrqX77K7a2YPHPXsxxTAdQkaB_-dl_Tv72Jz7kof6r1-4wLU
    3ts0_mMI7_7jFMhm40dIhD03Khd5_Aiycj9iwpEsPHjc-ebBNwpnw>
X-ME-Received: <xmr:xTg6abtL6QTHWsuCJoAVWT1vURfgiCzjeAosF4K932dXR7saamVMVcC-qvckhLk9_1z2ii1CkHV0Fxfagbx3ZFM4c8GDjbO-0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgedvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtoheprghksegrkhhkrghrthhikhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:xTg6aaRO44Q0Mu69ACgkzg2juvHWHBdJTXUGGa9UKabh-4XYrKEl3g>
    <xmx:xTg6aZMJ4THrFXyUYUV6LcRVUY0qgFsSkeKCiTQlgLFHYIsso5udUQ>
    <xmx:xTg6aXZzhQePHWlISS4PpILEcBnk-8YU1kIacTGX6q_LKoORrKWy7g>
    <xmx:xTg6abxAQWbBncsqKxvVj_RK3K2eCDsFdLclSFBUCaD4CxbpP3hzAw>
    <xmx:xTg6abNJH-3HEmB5ff2EXwKfVSyAlBWs_3exYPtHVUbgrbaKGO5T1kCh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Dec 2025 22:21:41 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Kartik Agaram <ak@akkartik.com>,  git@vger.kernel.org
Subject: Re: bug: `git pull --rebase` breaks in the presence of pushurls
In-Reply-To: <61f61218-1945-4efe-961a-e6cb4ac8c6a9@gmail.com> (Phillip Wood's
	message of "Wed, 10 Dec 2025 14:25:32 +0000")
References: <896e4e13-5d2f-4c5c-ac32-2927dbff91a0@app.fastmail.com>
	<04cc0cc0-155e-422e-b723-b1115c918087@gmail.com>
	<xmqqa4zsliim.fsf@gitster.g>
	<61f61218-1945-4efe-961a-e6cb4ac8c6a9@gmail.com>
Date: Thu, 11 Dec 2025 12:21:40 +0900
Message-ID: <xmqqpl8lg0u3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> "git pull" already runs "git merge-base --fork-point" before it runs 
> "git fetch". The problematic reflog entry comes from a previous push 
> which pushes to a different server due to remote.<remote>.pushurl. 

Ah, of course.  fork-point heuristics with a repository you yourself
push into would not make all that sense, since you are in control
when and what to push there in the first place :/.

> Because we've just successfully pushed the local branch the fork point 
> calculation thinks the remote tracking branch matches the local branch 
> and so excludes all the local commits when we rebase but we didn't push 
> it to the same server that we're fetching from. I wonder if we should 
> disable the fork point calculation when there is a pushurl set.

Tempting thought.  Or educate users with diagnoses and advise()?


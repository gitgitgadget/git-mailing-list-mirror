Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A0A32573F
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 22:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774478267; cv=none; b=Brld+uPHYxCSaH+9nw9PKlOMLHeL3W/m2nb/SJvQBlCbYZHNxlbhdN7jwY2O4q0YLem+VzL+MXZepiseniveQOdX4Nryml03JTX3UbMfwL/DSXDKJcQZG682WFACy0kRsJJsugKLEP58J/hyQHh6eJjkoe69t0ob5b+W38VFNK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774478267; c=relaxed/simple;
	bh=WRiK74ZD8pQcGet8DGSChz4ji98ASoCXLnZkbdXKEMk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ihn6fbbeFxyimhu+TSUqiPujrIWjBt9ke5LljS1sfJAOe3FPAlNWrRMTKMMAakSLHDFTlWU+iezlzB/mX9ni378oUuNXg4wGefzs46PI1flfT7jAnat1XliTNO+vJHMxo8oVolFtnRDQnlx93NG3o12Jc1RqcnBgv0VSpR8Bmr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=M4b9opg6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xHSsSBF/; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="M4b9opg6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xHSsSBF/"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B59171400015;
	Wed, 25 Mar 2026 18:37:45 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 25 Mar 2026 18:37:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1774478265; x=1774564665; bh=ldAAsMHlqEB50jh+idF603zxa/xWFjH+
	XueYvxNoXvo=; b=M4b9opg6Rhh/bkiuEnDWyqiO/l93hR+hiKAoxvmCeEf3UpIY
	xn0W+Gvh+Kx8+E8cJ+iRMdLLW+sxsqh16CTDya5YTcm2UKUNen97f2OuJ4kdTBy5
	bP2bIjN6hI5VRRzeirdBgd5hese6GDp2vFqtNb5jGRUuHBIvoILw1V7XB5TRYWeX
	dzeTWRercL31i+ODHAjPN+U+9i/Wa5alYLr2pWViCw8IG4AzTg4rFv436N0y9kqI
	5QAv8GydtOBTK97FIowiClp0739kRuxXcWu9yE2eNHpI4zDyMcnjN+ZwwIxKNdDE
	O0twK0T6o5TSH7/ysEGP1UVNJGyV1VZOHplAAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774478265; x=
	1774564665; bh=ldAAsMHlqEB50jh+idF603zxa/xWFjH+XueYvxNoXvo=; b=x
	HSsSBF/SQVqDfKmk++bi+Q8V/DSIwd6cKA12cJz54YB6v2fdpvKrQGhwQVZrAscC
	lYwrNnwc+n0SzUVVzLnQY0LzxeKdCXc9dEw0Ut5qXSP+Ige5nFhTrX7h7CTdzUzj
	okPbjvaaq93KKMeKDanWMDsQyxAaAIY7JJPwsz9D1mYbeI+TMTp6XHpFVYn3kbkc
	+7rOudulXMW5vHe15iJ6vf8rESb5p+FHlv8VkseuGk+jEK5QefRxumtXQt7mlt5z
	u/ozQvDKLk/8rMNRx6PngD3RPVl6Lz4ypHcCX3SsbJNht2YBDP1A+blkL+e52nnb
	sNqjMsE5GDoe23A9Ce6mA==
X-ME-Sender: <xms:uWPEaQZ6qchpnNuhSafSlHFuhMq2Q2urq2TzTM5fwgBD-14THcAxHQ>
    <xme:uWPEaRb45T3eEdpLSQC3YYYpB1Rulo0SylP6xrbvNOKFZdwYZil3X8fY5t59Y2Cc_
    hwR7MIJ5tmNDLAj_XODDchAtqPcjmdMC4YbhRCzAcXblVCD3qZLK04>
X-ME-Received: <xmr:uWPEaYlbX_QGRwExRnk0SQzoEYTaitFGZqTL2DVgL8lflkY7W1tPHUC02ghZSX3pWoAacq5kBJ5uCeYP9VZcNfE9jSc2LNSFtg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdehieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkfgggtgesthdtredttdertd
    enucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosgho
    gidrtghomheqnecuggftrfgrthhtvghrnhepledvfedtfedtkeefueevlefgleetieeuff
    ffkefhgfekveehkefhgfetjefhffegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtg
    hpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:uWPEaVxY_RA4YwM3s7QlrcRmi6oSl4WRsOPOsjkEwJOyFlKGUr6-qw>
    <xmx:uWPEaePE1_-4pAD2B4boknFAA1MBMgrSfKV12qLCw_RbX5ioIdO0Pw>
    <xmx:uWPEaRSynsLS5McU4PGChVEYainDyZzTRiXc9j8m7Aum38yX0WQcFA>
    <xmx:uWPEaUZ9lM8yGIlMR5kASlMtg_6yE-HddUd8KNln53AF0Q44fXifIw>
    <xmx:uWPEaTwD0rQxWQSOqhF1YncWw59tszlfmEPbYkrm5Eve4fhh23tbD3y4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Mar 2026 18:37:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: Tonight's pushout has 'seen' broken with "hook" and "replay"
Date: Wed, 25 Mar 2026 15:37:43 -0700
Message-ID: <xmqqcy0rsfgo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

I didn't have time to figure out which topic is broken, but here is
the test summary in my local environment of 'seen' I just pushed out.

Of course, help is always welcome ;-)


Test Summary Report
-------------------
t1800-hook.sh                                    (Wstat: 256 (exited 1) Tests: 83 Failed: 24)
  Failed tests:  57-66, 70-83
  Non-zero exit status: 1
t3650-replay-basics.sh                           (Wstat: 256 (exited 1) Tests: 48 Failed: 3)
  Failed tests:  46-48
  Non-zero exit status: 1


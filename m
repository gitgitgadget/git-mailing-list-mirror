Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E627C31C560
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 18:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757357009; cv=none; b=dekJjjy4hv0xfmdQ6GZFfJbu2MwTciT+ziAVA064iHPcVCpjwkBD5AwhZ4E2zwmmHWyqCBIa3f1xaKOhZ3ifVFSIAEZJijbSqGdV93SAamMKP/vmxpF/q4vcSr/IZqlc1w+YSsJ+fFhg3EzXKfINAipsxzF+xMi++FxwSZL7l9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757357009; c=relaxed/simple;
	bh=Id0Z1vuho+uQHFJSLokftx1dittAii7b0CllMsToZsc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ShfuXsMOmw2LYghfI04WB7bNh15LcYUQ6U7W1/Zdcv0nrwbsbtwdjOKYosjw80a+e8204gulWZHgZUl12kB8S8STFrZwhWnFiN315QGtBIqXwQQpuyghzvLZu/NWZH7La1qyhhnYNMTmAwa7nAkdi2dV04XyUh9iYjYZk5rcc60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=yzqPnuN9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BiYg7YQc; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="yzqPnuN9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BiYg7YQc"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CC1837A007D;
	Mon,  8 Sep 2025 14:43:25 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Mon, 08 Sep 2025 14:43:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1757357005;
	 x=1757443405; bh=vh9URa7yI//Bg1NBL8r6HnzW/swObvBX2I5Xbv7parU=; b=
	yzqPnuN9NBger3zh7lDUZr0Vla4Ov7OU94qXIXR8gYgJT2DuL97xKpMFD6Ka6kqG
	/jiGY/pqlIwgrSVbKtvK4UlqstGkzIVC63+kgshCl+CcFe0yLrW4MW2rbmzfkGLe
	v0j959/8a0j5PFxg+RN8pMhu4wQuhS+p9oLvNPk9Ht2O1w/XycJsahDX3axqDaFG
	6kzVp4Rfy+Qqzbhc/YImXiR8qH8U8Dv24ixfYxFtbHdRW/z6Ep1HY0BMO/lVej4Z
	LZvYdfho8bVjRgo1aEWLlW8Uilvwtax3phemdeRlofzY5kAIPO4Dav91i/sDjWo0
	CWrYWj5uHvA1fslGe0dRjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757357005; x=
	1757443405; bh=vh9URa7yI//Bg1NBL8r6HnzW/swObvBX2I5Xbv7parU=; b=B
	iYg7YQcPynE8xalIdVDvh1mFmiuBkzJrKTX8ZdaGlw5QjhWzdZXYduUqaTcZy2+L
	WZd5IV7tVbAy33UK6sfkOL4tf4+tn6Q2rZyBCV5OvRn++AMFPxKmkFv7JkiZsWwE
	22ShDk5ITsoXQFAc0eKfJmNrehrs+L0k0ybIruVV99ySj1/9dCvWV4jEoDA7138i
	f/I/t7WgDdr098MP6rC5RHgdQmqHBOFMURWNqGmYYLzGYCHcJ1wUC2v2K+L2Hm8e
	f59B+CT82OjoBrvfV506PwGmeoXVlheBrvtfdTEWYUOFNRFLlImusFo0mFwnBKVn
	EscTWUiY9A1oSabjVKW9w==
X-ME-Sender: <xms:zSO_aHFSJKDBODrG5E-dU0DI0lsCmGqOBURj3Q-i8-P8i89fGRihTg>
    <xme:zSO_aJRVQd16jcbTIRSEgJdbKMVw8AO75ylEOB7OouRllGfjaQ5AcEIs5t5QVVBWu
    FPH1fXOOu3cicLdrg>
X-ME-Received: <xmr:zSO_aNaXpKU8oKWLBJX2EwTdHAduYpXgQK7f3soHQ6GobY-Zez3TASeAyYKA58_5AVs6GCMr9jNbb_8eWMLYBT-KZrUb0vXOrmvOmew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukedvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfh
    grshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghgrsghrihgvlhdrshgthhgvrhgvrhes
    ghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepgh
    hithesmhgrthhthhhivghuqdhmohihrdhfrhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphht
    thhopehtmhiisehpohgsohigrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomh
X-ME-Proxy: <xmx:zSO_aE2gaAaFPEa7LkjlFfFFiQeeObamvj7MuvqJl8y2xXs9VuX0dA>
    <xmx:zSO_aAprlBA1kOU4Tz7WrmA9kbpJC-fJ58rH0aAmjgCHIh6iqOkfkg>
    <xmx:zSO_aDN2YDis-8Dpd9m-h3QmlCpv8GuHUwayeEFUzNM8bbz9zvPvNw>
    <xmx:zSO_aJpe7k8L_1Pnj4ujSpdl1fDWbaA9qbOWOgs4jLTOSo6dQC3KVA>
    <xmx:zSO_aPEqvyZhI_6d563oJdfS6WbeW43VGKIgz7-o_psAPErS-H02F_dW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 14:43:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Gabriel Scherer" <gabriel.scherer@gmail.com>,  "Patrick Steinhardt"
 <ps@pks.im>,  "Matthieu Moy" <git@matthieu-moy.fr>,  git@vger.kernel.org,
  "Elijah Newren" <newren@gmail.com>,  "Eric Sunshine"
 <sunshine@sunshineco.com>,  "Todd Zullinger" <tmz@pobox.com>
Subject: Re: [PATCH v3 10/11] contrib: remove "git-new-workdir"
In-Reply-To: <2b3c951b-0400-4cc5-b790-17ff77154ec2@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Mon, 08 Sep 2025 11:58:48 +0200")
References: <20250512-pks-contrib-spring-cleanup-v3-10-32e151b0bfb0@pks.im>
	<5580aa89-09f1-426e-8483-c99481c998ab@gmail.com>
	<2b3c951b-0400-4cc5-b790-17ff77154ec2@app.fastmail.com>
Date: Mon, 08 Sep 2025 11:43:23 -0700
Message-ID: <xmqqms74wzsk.fsf@gitster.g>
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

>> I understand
>> why its designers felt that this would provide better guarantees (it
>> is not a good idea to mutate branch names that are checked out
>> somewhere else), but checking out various branches to test them and
>> inspect their code (before returning to the feature branch I am
>> actively working on) is a common part of my workflow.
>
> I agree, that’s a great use of worktrees.  But I never feel like I have
> to checkout the branch itself.  I detach on top of the branch.

Yes.  For sightseeing, not building on top of various random points
in history, detached HEAD is a reasonable way to use multiple
worktrees.

Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3433F2F3C19
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 17:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786554205; cv=none; b=Batr1TFGfn+rJikalJkiBD7dqQcAIH16EMdlhLDE7ZzuL9hWBaPxXdBeX2MWqsQxUeYwtkTPJjydhBUva2HR5ZnKr7rXfqdMdqdc6CD+EPe2LQ0XTJkSNXrHekaOmAr/NeohW2R/uobuBPLR0I15cWSf4+oAmumE5TBqGlvtpZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786554205; c=relaxed/simple;
	bh=pJABEjlNa9ITwFhHVDrC4x7rIAVlduV8fnf6veDY4BI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rVd33SjP5UXZAavbVfHogs7pM/fgkoNdYzZhf/rocMnN8ySBHJ32FyG+h4lGybKLYlpOk1/OK0I6fzem1QXu8USE5cdoqehBxJxMEYOUmsmeCPhyXCmpvaA5dm3PA6O7YRqVaefRuQkM3BcWbT9Yjie9F3txXAFqkXn0VxfUogM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Bu4YwvdZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K27huyap; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Bu4YwvdZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K27huyap"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 293DB1400082;
	Wed, 12 Aug 2026 13:03:23 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 12 Aug 2026 13:03:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1786554203;
	 x=1786640603; bh=6XBFrvA4xdvYNlkknAhJmUSZe8wdSH/Y8opmkLvhZyk=; b=
	Bu4YwvdZi/hljYgXYM4FXHIlIqc1nY8pYLW3Q64udxwTZ00jswbqNJqjkfvETPJV
	QM4PdyobkXzbhEd9GVuI1JGIxegLN2zQkF16tu/lLADQmDiFWwfHYh4pF3I42/rK
	KZxAu3E9c8uXRc2/gYTIQuhrtK9BPM4ijvewbsjRn44a4lflyvPiK1xyHnkrNQG4
	VdPycEFUJESWip0jGSoIZWFxx4Yxl91g7MwutcHKa8M2mj7SaHHbmVEfCTejxEA3
	LQFfxC4GewwTq+RGLipAj6xFWKXA2IL5DA4S+4n0ZJ6Sj5bGTpQLcue8Vx0qD06x
	nKzB7/dEOkI6s/2afGGMmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786554203; x=
	1786640603; bh=6XBFrvA4xdvYNlkknAhJmUSZe8wdSH/Y8opmkLvhZyk=; b=K
	27huyapk7muwMUCkncsPXMz+SegLZZpl7qvoGQA7WAEQUH4A6WVgERsW1rDFcBwC
	XhY8OVS7xYcxPNeIhVm4uAFY0QB0MNBAGn12nuCFBcpfHjFcVLSCKUXA8Mg0sC8n
	ii0+Gwrpu9mPvie6I27TeCK2HGYcTz+vy/K08ghbHJSkmUNmCvqwP2XuQsFQsm0s
	w+QxIpIWrWkxmSv4Cmki/6gdXQQz9YLamsm1OL+5NmdmPBH875cAdjDwi5KJcOtZ
	B/3QGb6XbsEkg48FO+Uvaf+L9YWsRflX1kAX9iuSoIQzdueDiyYXdeYOuhv2c4wA
	XqcvIEYp2jGhY/74vtpAA==
X-ME-Sender: <xms:W6d8aqFBudGuf2CP8wPUwhS0ctIQ4RU1wEvWDfGJR7EuBaC5ky7kjA>
    <xme:W6d8aiVYcj4ZHuBkoweo8rRGtGGPKQIfhJqOEDaOmsjOZ4APWt6dGIAQA8KAzVg1Q
    4TwXd3AWiYgXd_k3p-JKCkwx6KyWwyzgaVYlwhnO_26207Hg-Jb1I4>
X-ME-Received: <xmr:W6d8apLT5hdiYvxv4gZNADNtmquOQV0RYrg3A860t-taLI36mUX7CDtLDGrfGsSMCn3iTpxbIXWWt_d-RMv7hpx-LuaDE7hL4g>
X-ME-Proxy-Cause: dmFkZTGZF4i1ZGgrToXW9pp+IbUC6b8BtPBHRv7gxRV7YNPk8Fbv6tb9Jhycd8/cQPf7vC
    ikOX8QXo03XAmCfuW3Q33g9h/QZt3KtEN/LmheHfcSVKtYH04KZKEI6o6vQ7o+QSCliitA
    pj1AalqLaoQjap0bc2FTPE1V8mQmGCyqF7pQr7NjTU2jtFiVvNeljev3kBz+sMFUdlOb01
    QFHeixXyg+k2HdjbL0nQBSmqm7m6nSieTC/gjUX6/FGESB0IRWD7q1TxkUhQlFnSrVbk+E
    fEiXyvTY6O2sLB6J+hVNT1jFX1t05tWiR3CAVP/YsEFMc7qPHt8Nang9W9CSAxuZCc5+fr
    1vJIpi2PC8oe74jydMLFjuQwpkdQWB9hfJv8qUqEkVYaeyR18Bp68AWJ7NV/Zhj+FrbFj7
    CRoij/mx7a+0DiOMtuXpb9BZgtH8VQf1WKQm/14dzOB87hhOOTGzcOS8dHdbQPsscghBXv
    pCtkqs5MVJw6PT7kLwqsOW+7ZdgqxsLlTKtnZnpbQCqiSx72urieJ1sAyDtQuUXqG01NlF
    cWaxSow+jBZ2HCKca5IIDacErcV6gwC8nOIowPxilq7OPNs1Ph8ZpV1n0IBFdNHksleV6p
    Jh2fU/2RcPQHFJxoeKp9lfEbv+Sfi6L1Zsg1E6m8QSyY3KtQIqxYwgpDxNDw
X-ME-Proxy: <xmx:W6d8ai9PFQ9fg2MgP4KPNpC7BNaAZZRLzBksWphLL6MhrhZiqf89hg>
    <xmx:W6d8asImzP-s6TnKW1UkxZoplzl6l3rf-JW1ppI7VZhWS75uz_Pixg>
    <xmx:W6d8ankaLZrS5qZLxMnu3e2RJb65bgAftivgdncPjkRmeicycuzBSw>
    <xmx:W6d8agMPdAi0P92bh0lGcHoNiaDLYIXGKNFVNOxNpnfPTKLUVQ-aJQ>
    <xmx:W6d8akpkLdWvPsjWQAlvA3zd7o2u_6N3gLeZLffe53AGlzpGIoXcJDT9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 13:03:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: Marcel =?utf-8?Q?Svitalsk=C3=BD?= <marcel.svitalsky@gmail.com>,
  git@vger.kernel.org
Subject: Re: Bugreport
In-Reply-To: <8fe70f89-89a8-426f-bab9-21284722c58d@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Wed, 12 Aug 2026 14:54:29 +0200")
References: <a7899757-9c3d-4735-b7ab-469808707e61@gmail.com>
	<8fe70f89-89a8-426f-bab9-21284722c58d@app.fastmail.com>
Date: Wed, 12 Aug 2026 10:03:21 -0700
Message-ID: <xmqqmrurxodi.fsf@gitster.g>
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

>> They are not graphically connected with the actual commits, they just
>> sit there over them. No other graphical
>> tool (Sublime Merge, IntelliJ Idea) displays them.
>
> They are Git notes. They form their own connected graph. That’s why they
> are not connected with the “actual commits” like from some branch.
>
> The `--all` will include all refs, including Git notes like
> `refs/notes/commits`.
>
> This doesn’t look like a bug.

Wow, I 100% agree with your conclusions, but it was unexpected even
to me that "git log --all" crawled anything outside branches,
remote-tracking branches, and tags.  I can sort-of understand why
the "rev-list" command at the plumbing layer may want to include
everything under refs/ hierarchy, but it is unexpected for the
end-user facing "git log".

Not that we want to or we can change it this late in the game,
though.  I wonder if "git log --all -p" also goes through the stash
refs as well as notes.


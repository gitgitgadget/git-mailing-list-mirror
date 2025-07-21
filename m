Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBB8223322
	for <git@vger.kernel.org>; Mon, 21 Jul 2025 17:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753117437; cv=none; b=c40pEgpYgKDeOTOLuM/RaIpeABbE8paK3G//aGhWwmdIItc4yHVxkotn4Zhyt+4OsZHh/RZdwCiM0px0GOq+lDcMskymLpOxr27pC416LYXBJGqwDPejZeGJNFfN8m28LW5w1Cw9ZKzBX8R6kIsbLztYfWCknppShBEr0WzNTrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753117437; c=relaxed/simple;
	bh=LnG9D+2UJurv0trEOfo6aZb4+yrIdaiV7ROfvfgBhfI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lipSxTPX3Lz1PNzmRZmBNoK59QiAdWM42ETjgsUga+0A8WHBkUaJxtt2wYzZHUQWza8rHCo85Iw2z4667gxTxcRQdXPdMDlwQfxG1X0jlNn+TroWf0RPVS+RHQE2qcmm+I1ZzMG6ejkOv0tAafUDh7kCpYiVHPwxJ47TG6ic5hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mcFkfoYA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Uqtn6mmV; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mcFkfoYA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Uqtn6mmV"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4AD437A0111;
	Mon, 21 Jul 2025 13:03:54 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 21 Jul 2025 13:03:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1753117434;
	 x=1753203834; bh=ChXFbKQnBW+QWwy5adIIgrS+yx+7+kbdvk41rCtKHQo=; b=
	mcFkfoYAg7APPaecShLS74+OS5Pb9elWDkAyOEHJegY/U/SyuBzlVWSZ64geHZ2H
	Y9OxMMrIXb35Bn63i7lmVJTBmBGmNe8YbUjN0q59q1PvNAS77IbXzeWhCiU8XvmB
	+mBbYveTVaPu4P9N8J5pPTk63VQ1pQZ/O9uEhyP+sMQLj8H7xxLMgjw8bZnT62ZE
	4PVeLAYlbjqm6thijEIC2gCvG5Jzgu9L9xnXiCp6ZzIB5cT62Qrogj/9DjnEMxXJ
	PlxDRr64z2mqFe7FpLXtlZnPTTwOYRP3RdIxkAMQatWTwgj3UqqQnhxwp5uLz/n9
	Tg71QPhl8/svyh/yzl/5Xg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753117434; x=
	1753203834; bh=ChXFbKQnBW+QWwy5adIIgrS+yx+7+kbdvk41rCtKHQo=; b=U
	qtn6mmVlPXpkWLjK5pvami9ZpF1jDBvEGQkaj2Xf0e+2UMDHcuNSulSnVcKhXrst
	T6NDzCfzcVD3GHSYIC/1reVtucNQjn6uvic0VLmP0jLJRUlqlkktcLJQ6LYCIDEy
	4xtUIgddkPrpzlI1ztBKJHxNj4lwBjQrW30emgulsPHYBiVSCtZUKN57xaMvsOCH
	IJU3+5KrXs4cQprVpHkzCx8s6VBya23mrq7u91rNPIYUVF2Yq4cmle6pV5dYtmaB
	vbecMS1lfmt59DI6E8SRgFy72dF9ov5iipK0OTN+ypuUJh9bvEd3O3LtqVzdkqoX
	KFH3Gzh4Gc62lKW0oZSsQ==
X-ME-Sender: <xms:-XJ-aKngNC8K2vKpqo1KVkdAGdZAFl-AJAh-urkMdqlOY0lLQcmCjA>
    <xme:-XJ-aMaLEbMiWHO8-nQd8tdwII1QYIdSeUiL8jFuMbp4w56fycmvt8Chrvfj7rNx9
    x_xC8i3MrbUkubQIA>
X-ME-Received: <xmr:-XJ-aFN1tGm6b_UEOmra4Fcs8UTEr81g39n_Zfe8yw5ubQblngb3c-5MAPoT443DIDfph9q-ZnB7UBHwZwqQIvpWWJ0rN_K7eZC_JOs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejvdeivdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepsggvghgrughhrggsihgsleekleesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:-XJ-aBa8A_NwySC6T4fxpvKLOtU3EnNrcys-Fz6B2yUpUDnfF59rBg>
    <xmx:-XJ-aD0ncZo6p_HvHVKb2jmPhf4UZY9SCZu6i33sOPaOKeg9345dBA>
    <xmx:-XJ-aHeWlQXeoqJoIdiYttdgSHOJwKCfXfnvTWiWVKMQzwtew1jyAA>
    <xmx:-XJ-aEHhwMiewsPBElwGMwualU6qnoY2LpIsKKFtR13M6kxVKmp6Yg>
    <xmx:-nJ-aN1o-c5GbcMGK4xhPE1WEB5ByTAsyzBjMWeIlJlBjXPMQefkgT8J>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Jul 2025 13:03:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Begad Habib <begadhabib989@gmail.com>,  git@vger.kernel.org
Subject: Re: Possible git bisect behavior issue when skipping commits
In-Reply-To: <CAP8UFD1bwe92zbXHWe-LiMSJZtcTJQwi9mtgNCm-_kTeyFk08w@mail.gmail.com>
	(Christian Couder's message of "Sun, 20 Jul 2025 10:34:12 +0200")
References: <CACy3CeRjyGb-T=hJURJbXXcR+_KtCsRsMzyw0EvusCZOpWb4Xw@mail.gmail.com>
	<CAP8UFD1bwe92zbXHWe-LiMSJZtcTJQwi9mtgNCm-_kTeyFk08w@mail.gmail.com>
Date: Mon, 21 Jul 2025 10:03:52 -0700
Message-ID: <xmqqa54xzdaf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Christian Couder <christian.couder@gmail.com> writes:

>> # Commit 1 – good
>> echo "good" > file.txt
>> git add file.txt
>> git commit -m "Commit 1 - good"
>>
>> # Commit 2 – skipped
>> echo "middle" > file.txt
>> git add file.txt
>> git commit -m "Commit 2 - middle"
>>
>> # Commit 3 – bad
>> echo "bad" > file.txt
>> git add file.txt
>> git commit -m "Commit 3 - bad"
>>
>> # Start bisect
>> git bisect start
>> git bisect bad
>> git bisect good HEAD~2
>
> When both one "good" and one "bad" commits have been specified, then
> Git starts bisecting, which means that you should then see something
> like:
>
> Bisecting: 0 revisions left to test after this (roughly 0 steps)
> [df357f37981b7f1e804684cc09842d02fd012146] Commit 2 - middle
>
> and Git should have checked out "Commit 2 - middle", so HEAD should
> point to that commit.
>
> By the way it could help if you could show git's output when giving
> steps to reproduce like this.
>
>> git bisect skip HEAD~1
>
> This will "skip" the commit before the current one, so "Commit 1 -
> good", which is already marked as "good".

Good eyes.  I missed that "HEAD~1 no longer means the second one at
that point because you gave both bad and good already", which you
correctly identified as the root cause of the confusion.  The user
thought #2 is marked to be skipped, but in reality #1 that is good
is marked for skipping, which would result in nonsensical output, as
the final output phase assumes that all skipped ones haven't been
even tested.

Avoid this (I am not saying we should implement such a safety
measure, at least not yet) would involve "Are you sure?  You've
already said X is A but now you are saying it is B" confirmation
when "git bisect {good,bad,skip}" is used on a commit that the user
already said something about.  Allowing them to change their mind is
a good feature.  We'd need to make consistent changes.  For example,
when we create refs/bisect/bad, we should check if we already have
refs/bisect/good-* that points at the same commit (and vice versa)
to make sure we do not mark the same commit as both good and bad.
The same thing can be said about "refs/bisect/skip-*".

This is a tangent, but do we forbid using the word "skip" as a
customized term for "good"?  If we are not, we probably should.

Thanks.




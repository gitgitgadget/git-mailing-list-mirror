Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B0A3D090E
	for <git@vger.kernel.org>; Sun, 26 Jul 2026 16:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785083348; cv=none; b=ko75xqyMeB1unm0i/UGJI7SVuoTr0RpT88JH+sdd3bWhCOx+ubuKjZPwyl9A8Pk5efNBjCh8joLKWEEJgO+dMoQIfQJNZLHWY1KTgN1kmYGkGZt5Q0RSMphOJbjqZ3MSLkzbJnW0StXfQcHQyxv01XzkTXnawAGq+gxxkSi4GMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785083348; c=relaxed/simple;
	bh=0ECpcVUyhnBDge9FL4a2Abs88Xt+Eyr79fcG/eRBNmE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Cdf668z1oKYklg6jdYwz3nDK1ZFschnyrpvfSkFsJXvRHfCOYIw8csPbqhF3bsL9bHO+vkSBy5FWR8KJC4tgCnuNJx8QmFOKRxhT63+vhIwL7H6v80Lvrj5UuGY0t3w88oJzAlrZAvBOnh8ErqiAv1yvHE91DO/5sVFJamtL9vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QdjYmQuG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mxgBl/6M; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QdjYmQuG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mxgBl/6M"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 63FB01400429;
	Sun, 26 Jul 2026 12:29:06 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Sun, 26 Jul 2026 12:29:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785083346; x=1785169746; bh=0ECpcVUyhn
	BDge9FL4a2Abs88Xt+Eyr79fcG/eRBNmE=; b=QdjYmQuGhUdsiXTC4iC/DG+2ap
	5O6hZ5x2ic0g7TL9zWgOfK4BPugH/HB8DNQMr+BBMyZZ5TABCvEvqV4uk+pXQwvL
	hMBrpj4LV5QbHQgN3SmwhyZZ0s2qkg0V20d7JzUqKvhV8bxn0IFMadYtCF3aSIaJ
	/kPgMJ8i2Z7kGpomv9V2lq603OhS5ndcmEaYMadkshq2VOoFJ69Y7HvKe2PvUIj1
	/CLfRvdvZ1FtJTRkjhlV4faMHK8nL1a66UF8bISb9BIr/E0xm+EpPQMjvsVLTO4o
	/HPONZDmulO1WHQi5RrrjXWc/lBz2pHs7cZ2iXX/npJIdNtPt57IdX6GUFow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785083346; x=1785169746; bh=0ECpcVUyhnBDge9FL4a2Abs88Xt+Eyr79fc
	G/eRBNmE=; b=mxgBl/6MO3DnX2sJL97SKluLDvfuSk0gclKyRU3MBQ5EXJ0/pp1
	02SU1tVf+NcHBmrVWmbeGBUSI+O8TCZZUf1ZUWeSM1xULe4SWcj0FWfLVji8ODjb
	x9enTHFSmlM7ydda80Fj8ZhsNUjFd2fx5zzQxvKmxdm+8weKu7S6O/Payfm2Z/+d
	KxP1NCd5pZ38mEoHznO06q/KmFtuyIFGK5557iVYGUGdBZmqd0XX9bxVkb9pYSv4
	fto03jRJCpwq0uKYV5M8ZDsWgJmjupEuOLxPR7q86K432kgtTMMSWNcW02F5GaCI
	H/SD2djTnd6oBvBUrDPDzfSzCZ9q1j8VENg==
X-ME-Sender: <xms:0jVmasbXxgCJ1zMgnUMaDV1m9aPXKm_edPlrBICHJQWMKJh5ouz-Hg>
    <xme:0jVmauSpOrQdr4XOGpZ72v6Xjs_mt2hxbtmH4Q2RV7XSNn4oD8Y7MEZsSEVucGIPE
    2pEHWHgUNS5ijh4ytgROKt0YJRsOfwK4IPzT06Qyb28ChYd4dbFHA>
X-ME-Received: <xmr:0jVmavTA32qO0j0WMt6divaKbMqzJZzMeLwO6BcT3K6AnjJqoGW2HVTUigHWUQX5yxIrASrVI2Mk7ijZeCpIcsvBjWxnABxKqQ>
X-ME-Proxy-Cause: dmFkZTEb+3wceVt+4abZYQ4chSWN/2xdnX65mjef7L0dLTllLyHRwNwaoLfVtbTZbPl0qZ
    F3/9DO6zUKxMSutrcChXRaoKJS2nCFUlpwVrFYi1aDpi96KujPWxP+0SeMkyEpRbc5Tcw/
    wT7Mo9u9jIe1kwa/DSrAH/+7uDTTvNYcnnXITKyraB4uilStMnVvx3RxR66vQ+ILMLw2ep
    bfNEez1c1i2bgDrHBiE8pMRhvEBdb8JCznVk1NkoemWyTfk7izDzET6rOCc31aZ9zQGxKv
    IlIoHHJLqif9U1oRO2ZoYF3cVaAqkIChD3dVPKr1ZCuw6gIw6KAtxJXpRpaCx2tOjN96OW
    Ojh7bL5zETcizvPuuUgryN90Aeu7WeKI8IJgxDjPmwlnvbSfHepW0cNMZoGvpYvAGyV9tt
    MEvTyTCwVgz9AnSMPkZ5mJxA1bBU0iy8LwoHT8Ag16Oi/nfE1nRQ5T9AiLA5mCgQsYkpsn
    1KxvBhKNooTA8uEy/nj+l1hT4pdJUYJK1mWhS2rrzqihuGwObMY6vglgBhKmRMI75eFlT9
    DVS24vKucJSLc9Yam0NIMg862G6zX4p6CO7N9I900b09ytSR8PXRvNmCNb1KFNYXK76HGr
    tTgs2GaEJpBy4adGDGUnBj7bqj1fwzGjGfB8i+PDGIBgZ5xC9A8UxkqPRopg
X-ME-Proxy: <xmx:0jVmaiSKMYcW-AswBeZeWDzGh1sMcPwSzUjwQLkxzrExiPAR4ka6Dw>
    <xmx:0jVmak7mediW8irNz2JJAUCo2mrQItr9LHIvclwayBY0iQ3QBoqaXg>
    <xmx:0jVmau18taj-1zNmhVDT8tazn_s6igiKj-MlTrT3rTF2ssUze4uUvA>
    <xmx:0jVmavBmOOo-gj7Ys4Vmxj2si9M5mMXUHTKuak7YZslWKZoe0FHYEQ>
    <xmx:0jVmaliBMPO10pR_xkgsjEV8OLOUuMI4pc6SNC8PIaHPnWujETgKjJ9y>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 Jul 2026 12:29:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org,  jltobler@gmail.com,  lucasseikioshiro@gmail.com
Subject: Re: [GSoC Patch v3 0/7] repo: add more path keys to git repo info
In-Reply-To: <20260726104343.16933-1-jayatheerthkulkarni2005@gmail.com>
	(K. Jayatheerth's message of "Sun, 26 Jul 2026 16:13:36 +0530")
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
	<20260726104343.16933-1-jayatheerthkulkarni2005@gmail.com>
Date: Sun, 26 Jul 2026 09:29:04 -0700
Message-ID: <xmqqse55vhnz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:

> Series adds keys to git repo info.
> Keys output paths of repository components:
> * path.toplevel: repository tree.
> * path.superproject-working-tree: superproject tree from submodules.
> * path.objects: repository objects.
> * path.hooks: repository hooks.
> * path.index: repository index.
> * path.grafts: repository grafts.
> * path.git-prefix: prefix offset.

I guess the issues I had at the design level in the previous
iteration is gone ;-)

I'd love to hear real reviews from others on these patches, but
at least I didn't spot anything glaringly wrong anymore.

Thanks.

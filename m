Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8D31917C0
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 23:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728515683; cv=none; b=bk7g2bGpzAXRM1cyrIWDMq38dw8kdOd0iDsic6j/BkTmJhsY1zdwXKfxPWYZVrCuuvEeTv44aKzTIDjZJorx6vHdTP17eFqDGGiSo9wJb+3Wog9/+thTdxv/2ZFIUcqWYqFx9gSFz5J5DsVe1IkFm+iOS7C50ORj93i4sWAVNFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728515683; c=relaxed/simple;
	bh=U3s2MU2ZIyXf3A55w2KcWLq8ub6NV9tKe1g5iVsDB0c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dPThqlZGVQQHXfO/fDJuc+iyAm6AjjKI+L+n88Y3zjDxahqla71DVUJ0PMp/hIK/fS6Kbx/MppRx+SPn3eeVJ7fIsoTiLrdqA3e/Wo6Mpv6MehqD3jGnuZmoCvLhbG7Z6/Pf78TG6Tjpr+GSwMq219zl2BPTAkASU5/qXtv6gww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FqGxA1EU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K/JMod2i; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FqGxA1EU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K/JMod2i"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 5BD97138020B;
	Wed,  9 Oct 2024 19:14:40 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Wed, 09 Oct 2024 19:14:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728515680; x=1728602080; bh=8+kgx+qtzR
	SUj/401v1rM2At1MN2p9d8QyapF5G33jQ=; b=FqGxA1EU88PuqHOzlya6ZgHQE+
	0kD/ooqlaPXYeI91oM+19xpNzCdwLPy22X1MJru8mdyxSxe5BW6jC/PgYpgefgKI
	QoQ4URM4t8hEpIoaCJsUMhU1dUJ6zbvRkC98PaKV0eY7TZKEZRs74+mQb80pn0+6
	nqoaAAjJj+DV8WfLSmQfnSJivzQxu4U62NVcGa0FRgc0Eqd3iLrod3/comSREjg1
	LfthgDepL9azvcR71bLYGkd5iBEBxCk9iPeiTUVr8vWnLkJDiCxAl6L+yiN7nvrK
	RNi+20o3mJTCNbU2mapmKcx9nztRMWd3nWg8XjQhp3yLgE+tN9tgSLfjbTYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728515680; x=1728602080; bh=8+kgx+qtzRSUj/401v1rM2At1MN2
	p9d8QyapF5G33jQ=; b=K/JMod2iWBAtnWL2EfXI38SMvGBcsi2ir9OfkLyY74qY
	YfEc2CewDUESPeBT7EVF/GJt1FqYUlqDY85N7xT6TDrRTRr1HIu9vJ87OrNlNN+K
	2aa+aqsHbB+/7ENFqMZo4/efWd2YbjB+rxVrCJr9bd0DroyduCogVfxs7521YGgZ
	o6xW7aQw/sVv/BN7lOlZmLdxpP2m6gLiFnSzhv+K/Dj1iKAFQvBBRIJuEwn7E+PF
	3BD2VtUMnwin8Pm0V4kTUBC1lEe3B6k+j+5jctXQxdGSAz50G54UVqWO+mBXH+j/
	7ftxj/lKi5OKWyzqq1XdMMyTvvNV0eX8cAdnS9/bPw==
X-ME-Sender: <xms:YA4HZ2yCXH9zEqGtBuDFnyFdzNDaIWU0HegFAxTt7mEHtUxRlzoPVA>
    <xme:YA4HZySsFoM33LTjX0TuKRAkTw-bdS0HNhwLfHg43Vp49L7dlKCyJrYGNdthF1MV9
    ah2jjtHoaFBfa0LDg>
X-ME-Received: <xmr:YA4HZ4X73w_nqwDOqzaOcnLxuZDfUyXENct1-lX2l9lauOR8Ovv9R3R-JhmPJKrIy2_0NftQw7WtIWk-Es3GW6Jvm7VGYk2K_tvi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefgedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepffeiteeujeevfeehuddvjeduffeijeegfefh
    tddvkeefjeejhedtgeefgfeijedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehshhhusghhrghmrdhkrghnohguihgrud
    dtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:YA4HZ8gB13fdrr_XAsM6B0u1x6cKzPM5bS_OE8TdoB4DPpJ3Uq-fXA>
    <xmx:YA4HZ4A2yYL5GTIAY-OHcazi716a23vY3VpHiee6Hdrigi1TSUcU3A>
    <xmx:YA4HZ9LQiTV8HJdvlDa-5k5b7YYR0MbTFBie9a39udyjgxqDB8awFQ>
    <xmx:YA4HZ_AmgK3gHWrjnC46t9kV5HFeyOrSI8EAB2YXpkVQXH8d-d_s0A>
    <xmx:YA4HZ7-jVftRZRDT647GeUF3b2QwDPpyEVNaYRZFAcbsMWSQFlqgZkxZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Oct 2024 19:14:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Shubham Kanodia <shubham.kanodia10@gmail.com>
Subject: Re: [PATCH] builtin/gc: fix crash when running `git maintenance start`
In-Reply-To: <xmqqbjzu1m2j.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	08 Oct 2024 11:33:40 -0700")
References: <CAG=Um+0mJW-oAH+YLC3dWEU64JwS-zMkkTiFWYBe4g6HMbe-iA@mail.gmail.com>
	<976c97081af7c62960bd71d1b70039657e7cb711.1728389731.git.ps@pks.im>
	<xmqqbjzu1m2j.fsf@gitster.g>
Date: Wed, 09 Oct 2024 16:14:38 -0700
Message-ID: <xmqqmsjcoom9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>> Fix the regression by again unconditionally allocating the value in the
>> `out` parameter, if provided. Add a test that unsets the environment
>> variable to catch future regressions in this area.
>>
>> Reported-by: Shubham Kanodia <shubham.kanodia10@gmail.com>
>> Signed-off-by: Patrick Steinhardt <ps@pks.im>
>> ---
>
> Thanks for quickly reporting and addressing this one, both of you.
>
> Will queue.

We seem to be getting:

  git maintenance start --scheduler=systemd
  D:/a/git/git/git.exe: error while loading shared libraries: ?: cannot open shared object file: No such file or directory

https://github.com/git/git/actions/runs/11264159690/job/31323795058#step:5:327


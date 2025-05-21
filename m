Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B531E1624CE
	for <git@vger.kernel.org>; Wed, 21 May 2025 16:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747843369; cv=none; b=GD65Gv+PQAC5kcMdvBEXt7LcmBx/HIGdPtbrlvOCBx5q/2APnWYiKkmI6lwQBfd1oiNfHAR8fkCB7HR9VqtQ3uEcsq53UmhBBFLBwvYOiSxwohcqH6/9INADNxadlOYdx681uR4yiYGuaZ1w8VwAQFGza4Y6Bdb9OG8h3M0EPzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747843369; c=relaxed/simple;
	bh=B/eE14NgaR14sNOtn++ABcokCXp0Tq0+bZ6bv6Tqxtc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YzOSYSA/QKB1HFRb+2ImkmDlskGc/4smRrBpRpgdvNuRMFYUmHtJUIf57F97ZOfEgAW2oTFi3MwTjNVIJKhZWOk/BrgXSJQCHDhX9rlBI4Pi4Hi95elltq4jAcBjT1JY+xyBwRcOuVi6YUV0bx4TWZEi6oeOSfknt6gF4FHAkiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LMzuWQrr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p3exSHvz; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LMzuWQrr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p3exSHvz"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 8B86C114009F;
	Wed, 21 May 2025 12:02:45 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 21 May 2025 12:02:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1747843365;
	 x=1747929765; bh=iLUCnrpgvlj97DsA32ALTL9ckSL17FcnXkx3cZqWo0U=; b=
	LMzuWQrrS8mamSP7ys3mw4fLq/LWQVxaSiXaHs2qIsnBdyya8hZG50ff3+M7EiW3
	/Ej0O0gvVHBgi0zOJ8+mPZRWnQo0QS3sWBxcMLL+DzbhAa9OuotdZF3y7BbkFEwi
	OY/jpYJKmG7o9dM0UZ4So0FKtZ9zCSTH/hiNiGANkVKstZLIxoTW2Vl/6PBO6tI+
	DF/X3NBLYC1TjavAK2LUaSqPoojF/wzZ1R95znbkBhUJqt6IH/S2RxiWY+NwIDg6
	JYw2J9EahFldoD86rL/2V5BsoP3HW5mEcwl3RecbSX6Pdre/vFATiFIjgbIJkUfx
	0ydXI+E7UdRbqN36m7Zo0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747843365; x=
	1747929765; bh=iLUCnrpgvlj97DsA32ALTL9ckSL17FcnXkx3cZqWo0U=; b=p
	3exSHvz4CpS8ZQba3rJEJqf9l1Zpv/JTxPPs7zyfPp8/xt3OcxrTskbYKxo1/L9I
	2tl2GRlCcjqtCiRdeapdLaHvxWG/Dv0cyLUuTwVgyakRlT/AaKFMfovPo2QIsdtt
	7SxHPAXcvFjXCZ0mXs2GzIzyyP87sG2HL14lWgBtUsJtnyHEUosI/llxP/WNIMvE
	Dkuv6pAmHbYxefQvu37u1+Us71yfKFAYQrFDnq1bSmDC91dhJg46WNURSfN1HY8s
	RUafva9Uepc8soL35WCF2hqX/Vfe2FfRPeGrgx9PeMEeNhr6RWClEljBfpCOzLvp
	yN22H69NEK26iAMWFvwcA==
X-ME-Sender: <xms:JfktaNdpihJBk4vPukpfMbChMooo7dVQ2xo4r3mSXYl3Y90Ri5Amig>
    <xme:JfktaLNWMIzR78cflPxqJD-hc4J534HYJTsUUPYC2gHnCQipmKDi7N-K8-HXn0YzD
    y9683YMOcwEzZqkhQ>
X-ME-Received: <xmr:JfktaGgU3jzht6QYss1aHaQiPMjpPqH4l3dL1GICV_oNdcrv7HFIVrmO_pOcINjOZKCLB4itYWkH2Z13irEZQwTPSDKem79Awo2UdPo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefheduucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffffk
    fgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoe
    hgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteeg
    vddtkeetfeevueevlefgkeefheeigfehveehvdekheelveevfedtheenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhpohhhohhrvghlse
    hrvgguhhgrthdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:JfktaG-Mp7XOTC5coRZvCqIuyGkSfTGL44zpAOCrPSU4Y1IzP_McDw>
    <xmx:JfktaJtJGtULatHA21E_iSV2ZgXKzBY5YYYkBzF1wQKtKI8naETkIQ>
    <xmx:JfktaFE1HSBMv79qoXOrLIyGlPJFPssTaeRKEF6D5gBlM7C8hUPFFA>
    <xmx:JfktaAMLoMEtWixF29hrvf9PYQHqE1hURN0o-tut8Y7YLoMqPBJUGw>
    <xmx:JfktaLRaFwjUW0mzCDQN44x7ITqSkBoyq15YEUfiWK8JXLHFk-EZbQMs>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 May 2025 12:02:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ond=C5=99ej_Poho=C5=99elsk=C3=BD_via_GitGitGadget?=
 <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?B?T25kxZllaiBQb2hvxZllbHNrw70=?=
 <opohorel@redhat.com>
Subject: Re: [PATCH v2] cvsserver: avoid precedence problem between ! and %s
In-Reply-To: <pull.1925.v2.git.1747822992457.gitgitgadget@gmail.com>
 (=?utf-8?Q?=22Ond=C5=99ej=09Poho=C5=99elsk=C3=BD?= via GitGitGadget"'s
 message of "Wed, 21 May 2025 10:23:12
	+0000")
References: <pull.1925.git.1747813502225.gitgitgadget@gmail.com>
	<pull.1925.v2.git.1747822992457.gitgitgadget@gmail.com>
Date: Wed, 21 May 2025 09:02:43 -0700
Message-ID: <xmqqh61ear4s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Ondřej Pohořelský via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: =?UTF-8?q?Ond=C5=99ej=20Poho=C5=99elsk=C3=BD?= <opohorel@redhat.com>
>
> With perl-5.41.4 and newer, git-cvsserver fails to build because of
> possible precedence problem[0]

What is the exact symptom?  As Perl is not a language to compile and
run separately, "fails to build" does not look like what exactly is
going on.  "gives a warning and then refuses to run"?  "gives a warning
before running"?  Something else?

> Added parentheses avoid this issue.

We phrase such "this is how the patch addresses the issue" statement
in imperative, as if we are telling the codebase to become-like-so,
e.g., "Enclose the pattern matching =~ in parentheses to force the
right order of binding", or something like that.


Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C02282866
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 00:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765846393; cv=none; b=C4lhJ8P8WtkPz0ZiEGJjXq+UMj+0ORjVOWNWXqPOmkiFhl36ZRtYnW2ahvBV2MEHKBlRcpdU148AwvpDIiRsllKzAYFk1oxJ+4V1FXc59tXLbI+FZbO9xR/XrpPXCeqgtP7leThKPdWNPIP4qiDCOBW2oKm6Rwt7uk+AVdBP5zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765846393; c=relaxed/simple;
	bh=BNdR9CVJhI65PRnQv8VwA2oVjGQ303LV6095iejd9/M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZU7LElljAuUl7uu2za2tWWGBWtdK+LofVSaOVRHnZMHnZFbeUp4n36iy3GPTKmwrMwe1EoQoM6PRXtnHaxCmO81Ds8b0ys61UW5vIXkpAVHTvLmSu4UU4dU5zG+o7VSqsP9eP3j98rhwhPN87l9bFdae0uy7y/yfaUrfs7Sus5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QqPwMgP4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rlKfUX40; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QqPwMgP4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rlKfUX40"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 26A561D000B0;
	Mon, 15 Dec 2025 19:53:10 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 15 Dec 2025 19:53:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1765846390; x=1765932790; bh=/T1kIA7v7Z
	dtlKABO/Y8rQseLIaKRlnPyfAhP3ufYHs=; b=QqPwMgP4kKEqUsXbNie2cUccTJ
	MtZ3DDY/mk6BEVm+VsqLjj46qNgOpXGDCqzOXlF/Gcr6yIqY2cyOZBoovBs/5D8E
	G2oHunC2U/E21QwlRiBE0nwSGUjfQXhi8B0OrM51L2DThC0WrrY4hC/Fn91J6YRn
	vi0phSZaqLxgh2XetEfuSEzwngutvqF5zAvrvHbm5XBthPpPz3Xz7BeEM18agkJW
	ccy0Cpd8L9GQUpDvD+iP18vkiqikxaBvdOkgbPZ9FAGKN7/NE8olnApYqMOP5jrS
	HD4KCG5lqd7VfFWFrGy7Bk6ShygXVDbzB+JoqbkTSUQC0vi2WKg4GJm0f33A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765846390; x=1765932790; bh=/T1kIA7v7ZdtlKABO/Y8rQseLIaKRlnPyfA
	hP3ufYHs=; b=rlKfUX40v39d9zhkdW5+yVaOEqY0r/fXsydZFv91qF9TwM4KgZO
	1vWM7dxNhHcZm7o4HWneg5cv+u9p5wZgqVli/NfJ71lMnaNiBhCIVfpx6RSJenJ3
	e9mHYm6WdHZknurl/i7qO+Cz3EgYJdwzpWhzlQwc/d18fwRcxDHOcQourm1RNDHu
	/4h8BltBHqYr2YCKkRhjwNtF5J6oR4Ubb4ZSxsK8pitlQ2rZWJv/MkpOawWOicgC
	Sl3rqLf4FaVASAHWohIQOKFu/Xy1nqk95AaL2JFGk4Qn2ZfHUrRIezQKSZuX6SZs
	PMB8dRjKeRIfnG9vFAg0iUC7eWiCkzWPc9A==
X-ME-Sender: <xms:da1AaSGvAaUDrisZUBOryLlZwESliIlVtutwibzC-OkVUI9jpCDRcw>
    <xme:da1AafKhrJI_pkg_uv8cMxHUmkiP-MGlPSebm97YKTo5RmfujCDkk68-ya8BocjdO
    C_Aw24SM-onihZLfpGdFUcWvK4uofwAqxGQAfxQR7MERZEghvlu>
X-ME-Received: <xmr:da1AaXiZaXwoIdpnFzmcwZ8BT9efHPA43gyLBSLcROVS6xpPuB-aERzY0xesd25YS_DEMNObk5pAs86v6EMkuro2JUZqDwrZmg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefkeeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeduvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprggurhhirghnrdhrrghtihhusegtohhllhgrsghorh
    grrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvmh
    hilhihshhhrghffhgvrhesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprhgurghmrgii
    ihhosehgohhoghhlvgdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpd
    hrtghpthhtoheprggrrhhonhesshgthhhrrggsrdgtohhmpdhrtghpthhtohepjhhrnhhi
    vgguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:da1AaVllJpZdmJcyGoqMazJt5pUbc_OI_0Aqpr6b0gA1XASDspKW3g>
    <xmx:da1AaWWz_U8KLtHR-6kUrsFe9p8D45DG96o4BQ_Gn6Tr3VouYuJ5Pg>
    <xmx:da1AaavxTCBAw6Fa_zYNxsO89_i24tw1CMpQYViRBclH7_egUU1NTQ>
    <xmx:da1AaZ6VH78zKO4M721hhTk9-zVe2kZ_B0gHij-xFk1zwZAVfrKLjg>
    <xmx:dq1AaWjsKtgO3Th0K7GjzVlHh-KTNGjjQYuRnoG2PQJ5sYD33-FRGXKR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Dec 2025 19:53:09 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: Ben Knoble <ben.knoble@gmail.com>,  git@vger.kernel.org,  Emily Shaffer
 <emilyshaffer@google.com>,  Rodrigo Damazio Bovendorp
 <rdamazio@google.com>,  Jeff King <peff@peff.net>,  Aaron Schrab
 <aaron@schrab.com>,  Jonathan Nieder <jrnieder@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,  Josh Steadmon <steadmon@google.com>,  Phillip
 Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v6 00/10] Add submodulePathConfig extension and gitdir
 encoding
In-Reply-To: <87pl8flnef.fsf@gentoo.mail-host-address-is-not-set> (Adrian
	Ratiu's message of "Mon, 15 Dec 2025 18:28:56 +0200")
References: <20251213080817.347922-1-adrian.ratiu@collabora.com>
	<34DD8798-5C69-4092-B6C9-6609E688FBE8@gmail.com>
	<87pl8flnef.fsf@gentoo.mail-host-address-is-not-set>
Date: Tue, 16 Dec 2025 09:53:08 +0900
Message-ID: <xmqq1pkv6ydn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

> 1. Encounter errors like the following in submodule.c:
>    die(_("refusing to create/use '%s' in another submodule's "...)
>
>    These errors can happen due to a number of factors, like
>    case-insensitive filesystems or submodule layouts.
>
> 2. Need to specify non-standard gitdir repository paths, different from
>    the currently hardcoded .git/modules/<plain-name> location.

Unlike 1. that hints where the need might come from (e.g., the
mention of case insensitivity), 2. has no hint on why one may want
to use "non-standard gitdir", which is better than nothing but
probably still not helpful enough.

Perhaps giving a concrete example or two in the documentation may
help?  "Imagine you have submodule X at path P on the master branch,
and then you want to add another submodule Y at path Q on a separate
branch that does not have the submodule X yet.  If path P and path Q
overlaps THIS WAY, then THIS AND THAT BAD THINGS HAPPEN.  This feature
lets users work this around by DOING THIS AND THAT".

> If you are not in one of the two above cases, then there is no reason to
> enable this and it won't affect you.
>
> Hope this is clear, maybe we could spell it out better in the
> documentation (suggestions welcome btw) or even tell users in the error
> messages to enable this extension.

Absolutlely.  Developers answering questions only here will waste
the brain cycles spent while coming up with the answer, so please do
document what audiences the feature is meant to help.

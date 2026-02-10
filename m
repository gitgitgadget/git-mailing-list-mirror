Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B14E32ED22
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 20:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770755972; cv=none; b=NhHuqabKk3giKxPRkcgKu2qF/+8Gl4ZsMXZ9U2mjfUXkeSHo+ii61F3tsJmUsPoUM9RDSL7d1rPGip0Uh9Kr7foQQtAYoNyJR5antKzjOtvHIpjxNne2O2gOP0OBbPK5nXWjyjgb2O5t/AAfJaraNMpJC/KBDpU5JZ35S+Ak9FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770755972; c=relaxed/simple;
	bh=L8UfF+PG1vCUyqWGvOzIjv8Ru7mDMJEvr5bO8vvd/A4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F2XAzWnb3a1aidALdHUpLEeKtKLSJtyR4LBulBrS/5dbOnOw98Wj0nG7jKVFaLqlBtTDVb1zIRTwoQHugc7y1IGaavalxs3/0IQc4UF3AOKgiaw6aiwRojkeXT5b/yX/i4JcaAq0FKDfhkXvNRxK56Gdc5hAHlxIJ/cYsNc8GeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Yg8i97xs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Am2ieXGh; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Yg8i97xs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Am2ieXGh"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 493D91D00195;
	Tue, 10 Feb 2026 15:39:30 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 10 Feb 2026 15:39:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770755969; x=1770842369; bh=nf7SkFh5na
	ps1S31RKye62Z2S0ghsR7QHyL8KLDw0U4=; b=Yg8i97xsfLdyNeAhRk21cYP1Gb
	AzS4cOIDaj+VqAR8Kr/8OzI8GOVcviaRjoLcY0ehXflJQe2X6aJmN9DfK4VvFvZU
	DOl75P6efBgzNZMasYXKd7WOAyvbQ3DVMum4p7faIH7rpLtEYHeWpZ4puIh/Aw1H
	KRFvCdxmvVGV/UNqrN+ILHaACbdo7HFURfUiahP1jIW6jqvQrN7yz6Y5Y3kEUnYc
	qkH2a92jV1fB130mOg5MfIPziriC3N0P1je8/iOVE+sIpFi542JhMrQY9O2+AGVe
	PXZEocYqfsaFQ5cT/dbKGdGJAYCcysGePMzxhmet5esEkkeaucAy9LfQULjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770755969; x=1770842369; bh=nf7SkFh5naps1S31RKye62Z2S0ghsR7QHyL
	8KLDw0U4=; b=Am2ieXGhAtrFZvgywnEoPqqpWdL7IQPr9pCUkJhuVwJ7nJZVT13
	nQd42BonpYZ/gp/WUIuf38bqZyCtsTE1hSlO93AOjsaOqYLV4IAv/4md8aSQyoxB
	r9SR/Er8gCuuPrP5dICd1lFaLeq3INk9okJLQ7p8ki+jw+cWvsEApin8bS+xFnO4
	mwx9qbOQQrdgLH0FsQuli0Skrs57Hn7+age/DejDtmcWJaUR80F8u1q2aolY5uKZ
	6bCFHK+Fd4qWesfOT6oA2NIAPML7NL8y12VZXuUgQNO+gHABJd6pfI4HZHOJm+B9
	fv4FFXfL5wqjm+l8SGTd+TzfxmcKEH8EnoQ==
X-ME-Sender: <xms:gZeLaSRJjN1yRNTnbTJIlWcI5qposRAHmpiA-UUlQjc3xp8aMBR71Q>
    <xme:gZeLaew80GaCl7scErri0V6292XDGX4m3YD2vTWWOW0U2Gjar_dI4oJXzmuUk0vDx
    _nm_my5C0iiX5Fy_eh7L_OQSL6mjFL3YLz7-unH2dr_m95ASc3Zyg>
X-ME-Received: <xmr:gZeLaU0G4ByJjW9IX1Rte8CeK5UyLZfq1-cGNTszATIYgfEu7eC7cTNbhcZaNBT04vEOOUKKwaIKFyXTiIcNO4vRa7ojAw8TNQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtddtieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopegviigvkhhivghlnhgvfihrvghnsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:gZeLac7qJ_9ypuIh9GvuMj3LIT1mM5q_GyBs1U398xvAWEri8jPzyQ>
    <xmx:gZeLaXVDHUh915RNfKR6GIlToPhqWVTOXdrU9k7kxmYo9Z7CqQ6XoA>
    <xmx:gZeLabAkg_MpxqtT3DcgO-MLSDV6VHfEiJhHpWfzUZv1TOeJiouhcw>
    <xmx:gZeLaW7S93vYWKqndICmWzkfAXjR-2Y9RENEBOq9GXcRhKhNhD5szQ>
    <xmx:gZeLaRhm7XLsDWfNjLmjlV5pF7QJr60HN6u-5-1MbTA5Px06IsZxBbZ9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Feb 2026 15:39:29 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>,  Ezekiel Newren
 <ezekielnewren@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/2] xdiff: Remove unneeded members from xrecord_t and
 xdlclass_t
In-Reply-To: <xmqqtsw8i8fa.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	26 Jan 2026 09:35:21 -0800")
References: <cover.1769424529.git.phillip.wood@dunelm.org.uk>
	<xmqqtsw8i8fa.fsf@gitster.g>
Date: Tue, 10 Feb 2026 12:39:28 -0800
Message-ID: <xmqqikc4xri7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Phillip Wood <phillip.wood123@gmail.com> writes:
>
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> This series has a couple of cleanups on top of 'en/xdiff-cleanup-2'
>> that reduce the sizes of the xrecord_t and xdlclass_t. Unfortunately
>> they conflict with 'en/xdiff-cleanup-3' in seen, in particular with
>> db8a50ca6b9 (xdiff: don't waste time guessing the number of lines,
>> 2026-01-02). I'm not particularly convinced that moving the call to
>> xdl_classify_record() out of xdl_prepare_ctx() in that commit is
>> a good idea, but if we decide that we do want to stop classifying
>> lines in xdl_prepare_ctx() we can start passing the hashes out in a
>> separate array rather than wasting space in xrecord_t.
>
> Both patches look well reasoned and sensible.

I was hoping that these two patches will get reviewed by somebody
else in adddition to mine, but unfortunately nothing happened.  I am
inclined to merge it down so that the other topic can have a stable
base to be rebased.

Opinions?



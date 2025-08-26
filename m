Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CDA242D9A
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 16:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756224368; cv=none; b=cLggy/2haZFO1HdtXzTyJmvsdIfB6/vHesf9bk5DFmB2YM/hMCUqwtMXx28Z1ENVxGLhSCbIkDdIchYAmd3AsNIQD3QZ9mt0l2wfZiQg3XpF+voLj0AR5u+xWzlbScCHErwLoQBxkiDmrmob11I3pHcfkabYgniHsZHFIqTKXcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756224368; c=relaxed/simple;
	bh=art+KzPWxdpXavWIn7d9darCI5oS9ZJOfcdZCNv2Kls=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tlQOPBL3BuvTy3nO7NLJlv4Vt70A4b3hdw8rNjWtV+xCl0pg5wDO+yQX+1LFQO1lN35A+9PW4NNQIDoQqe+TTudSCWVRQxSx0TH1RZhHWekEYU6A3WsSTJ4sNPKDOk3w2oj/0uFiT1jVPSgivM0ffNE9eTSOSK4Cp9i8ewFJj5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LnZS3Xr4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A9yGJsNk; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LnZS3Xr4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A9yGJsNk"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id D5151EC0399;
	Tue, 26 Aug 2025 12:06:04 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 26 Aug 2025 12:06:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756224364; x=1756310764; bh=jv4B+o5ccY
	hx8SKpb3mtKAqHHaRdumudbItQTSInctM=; b=LnZS3Xr4522oXJ1R9TDZWiRm5o
	dTf5W51F4FiyvILXzvf7bsx9PY82+JiVfIU2KLjFC3JC7DiqZjPGXbi+zEicvWwC
	0kGP3UhQyf1oQlbCai1+dyyK2nGYkcqJ4039ttabB9Hw2zTgb8DEnpaQVuXe0J9R
	krGSsQRuyM0Q8jtlJSEiI6/G02vh7eMnu4uGvrfqnhEBscZUTjlDkaKR7RzKxPYa
	KJtz3rM5x68KczkWGdbQghZX+gvKv7PuFOSIT8BCSc+3ZTdnZjBV2foNJzLo7h//
	pd5B9TwRYaN5SZj+R+40j1hoG/pO66plKexSgq0qDI9EHZLhS+PmJG2+vTXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756224364; x=1756310764; bh=jv4B+o5ccYhx8SKpb3mtKAqHHaRdumudbIt
	QTSInctM=; b=A9yGJsNkEwaSANvjp9r2NRH7h13ydtWdN2I4knGPZm3wB2CQ2N+
	FVhU5LoCGTCM4rXRktlu4zP2ms+uDPqDPZmxedIebaIenB2arP6nqtQEDBbvJ9DF
	7PbIfSG4/NUrhB/vXu+mq0gfubO9Yy6Q6YBSEbOnDrBYYq7FvXaUkeR3Pb3ivsJB
	7wO0+R5jgG0WAUdWiKIYcOOIBboMYB/Zj79XvILL07PJIWLO8UAUjEtl5sQNI+sS
	QYsIH3Ok9c75UjHxIXGi16O5bhEoRezCTXAGqT/fIIkG7Pis9nGm0wiU3+Sh5jM4
	JhklnEMY4XXOpqhwFK15iJNrXDjOtasRkzw==
X-ME-Sender: <xms:bNutaG2khtatDjFmuDedxbXTpgJT3RSLQSkh5827YjeW6M1-W1CE7Q>
    <xme:bNutaDr-c9eFVq69yMOpg7Hxu7rIdpqiyz5GtsbzWh-gUoPeyz0dNVSxhPXHoUHWI
    lU5Sb0NWG3t3ob7-w>
X-ME-Received: <xmr:bNutaLdoY3VPsxjOznwBY9H40FP1CIYnRX-B1GtcsmV4yu2jGM12JI_T7HTUzRazG3NH7VZ23id6DI__0d9HjhRBOp312_FV_1yakMo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeehjeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:bNutaKo1XTMW_Y-8kEbtaD5t_ZZtxBa2Mdu7l7MxcosNajZ5xn4Qtw>
    <xmx:bNutaEHjNNCeGLuTPplPdqM6CU1GImsvlItt7cYaae274m_SU1KaHA>
    <xmx:bNutaCs8iJBnQb9VQslZf0rtGUyCiJUmJtyplHKf-i9WT-_eq-fhgA>
    <xmx:bNutaOUm4cy7K_8Nf3qon9FMWq5QDNZtsGlRgERnHeN-gi9fVRb-gg>
    <xmx:bNutaEEBsVWmxFATd1dO2Tib0qQbllozNZSuoiAkOLXayfvFJTDeDGVE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Aug 2025 12:06:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Derrick Stolee <stolee@gmail.com>,  git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2025, #10; Fri, 22)
In-Reply-To: <CABPp-BFuKUH0NKR_9Qb7Q8Cb++o2EVzqYK8WyvQ_PG5_JFyZ0w@mail.gmail.com>
	(Elijah Newren's message of "Tue, 26 Aug 2025 08:04:39 -0700")
References: <xmqqsehivqxi.fsf@gitster.g>
	<CABPp-BFuKUH0NKR_9Qb7Q8Cb++o2EVzqYK8WyvQ_PG5_JFyZ0w@mail.gmail.com>
Date: Tue, 26 Aug 2025 09:06:03 -0700
Message-ID: <xmqqbjo2kqz8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Elijah Newren <newren@gmail.com> writes:

>>  Needs to wait for the base topic to solidify.
>>  source: <pull.1941.v2.git.1752716054.gitgitgadget@gmail.com>
>
> Maybe also mark as expecting a reroll?  (cf.
> CABPp-BFzMLGJwz4QqYtvw3zRYgmC=Mb8T8GCOsrLZqT2z+8H7A@mail.gmail.com and
> CABPp-BHLcy-A4yLR8gP1Sjt_EKQ4K08kPyb7G6yifdZj+0MJNg@mail.gmail.com)

Good idea.

As these are primarily to remind me, I'd prefer to point at articles
from the topic author that said "in the next reroll I'll do this"
rather than articles from reviewers when leaving a note to explain
why I do *not* want to merge it yet.  But this second round does
look like it needs responses to reviews.

Thanks.




Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B772B399010
	for <git@vger.kernel.org>; Mon, 13 Apr 2026 21:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776116802; cv=none; b=A7MK2HudWj+SoQIXpOI02i0IbM0BY13bYWXBJdxPc43UP9jRpY08Wow+eWk4tQyl1FQ2aj8bVFKdK8M7hyysmDp7u7xYocGQYYcYvaJf50tSB8yVMwHhCBSvRRf2zHuIb9aAr7wW0mWPJZcmEDIidyWvNwYLMN9c1GlsfXeJ2gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776116802; c=relaxed/simple;
	bh=4QR2jHdYPJCI+yHQ6A0TzfDJm0/MnSW1JFpyQggHgtE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ua+ukBrMkzTbfiYvUDTE0bCYw+0iyjGBBfGBcTfjEhvqQYswPpCcQC7ihmMlAFFyH8SACtAuQruZH8uWJjDcmcT1fL5cFalbq1Z0kqtfOMpzJrNiNtNdb/1JpAkBXa3Jt0sACQfrRqLc4mTaYN0ZyNarxPlm0/oWaJwGLxuQGzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DOu1aAjD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NDMPem/f; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DOu1aAjD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NDMPem/f"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id A3436EC050B;
	Mon, 13 Apr 2026 17:46:38 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Mon, 13 Apr 2026 17:46:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776116798; x=1776203198; bh=CU1AEaX3Vz
	Bh98iN0kSLfqBakSaSEg/voHYT3qtirB0=; b=DOu1aAjDfbycfmWo1nj8Bs7KLF
	QkPwNhB7Dy7ww/OONMgpGHf5P58MO+HB2uFWd2bnVyYzt1XA+i0peXneJ0oMw32P
	T4qdXri594EbGDVCZqUvgvZ3pZVmnehZqv3rRUH26gPf05Zl+kBdJyfpvU+ESMFv
	XB4LHB+ItJVh2Ng8Qt6tjrghFGRAqIDL52AN0LvrqYfC5c2Wo4Wicq2D1mzP6IL6
	3rcrvhIoAVt9gN223eTOgP8JSJIrfhKdvHVYSKOLn9w16XXZCv80vjT0stlQRTtl
	BH2/Gw3QJ7hlZ25oJaz1EvtT83nnDW3RERCXKe+XRyV1nhnVJq1lyH8kKLEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776116798; x=1776203198; bh=CU1AEaX3VzBh98iN0kSLfqBakSaSEg/voHY
	T3qtirB0=; b=NDMPem/fNGE1di5bcluAa1rEbEsrkLD+RCWZU/tdCoBYBQtmTR9
	NrEvtBHfk4GJJWNF8ssV1rdaqyRm9AGNOhLI2zV9XoLXq7pt5RBidsElCTS7dj3y
	9TdyqQp4WX5ANVL3AdOFSnynu40gEwJWG0yMI8pnDs4PMZ69vo2zJhtjKnAXhI+R
	D5bC0aaZVGa1gljPeYqEj+53k2e4fV97l2iNq4yGrFxBqQPsAeCz5EyZ6nRlf202
	9uLfwXNg1MHss3sp1606m9y7/E80/91L3HIaBCJXzxnST28pSt8gXSQoXgLN0yj5
	YSK3xzWz5F96pqUlNVJwhB5tP0E0+IK9kYw==
X-ME-Sender: <xms:PmTdaSdwNuD_m75Se7v8c9PArN4ZRrnJwaWzD7iuyqiMeDdOgddadA>
    <xme:PmTdaTrCtkd3oekqyNjDNW6E6bORbvTRmi7KeWOlHGjkMnkDNPAB4NUDt_7kyt70q
    XkHK5SYqO1BVeJykr5F5Uqq0E200QFs0p4Daewwc0T0IlC6xLfT6Pg>
X-ME-Received: <xmr:PmTdaQ7XRkmYDOYBDS9xNQt_vWmlaIjtU3WhfW0D_JIwvio4BIZKW8z7ti2xw_uV9evSWp7mKGWKwy3zYSAvpbO2XVlWTQl7cA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefleefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:PmTdaZqoEiYd3k0WCciKBp1pw-gpvbShw5eAcaDNyKD9hTufoBSfxA>
    <xmx:PmTdaSihxV2EFj6pJQG6llcfCgphuGU1okpmhsSBVT9-nLaJr60dZg>
    <xmx:PmTdaTIPYcfUgp4hC21y5K4zEJ0Q2YPiBAy7yP37B9cVgJLXy80t6Q>
    <xmx:PmTdaSBu5eOCQ8_MEmVDDhJ6JznV8Nq484KZQZiRUvOT6dXSuPtyWg>
    <xmx:PmTdaTzVMaIDpRG1kAUsMsY5HaQAtMHFLsAgHDrJ4eYiccLiT63XkKNM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Apr 2026 17:46:38 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/12] t: detect errors outside of test cases
In-Reply-To: <xmqqy0iqfsuu.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	13 Apr 2026 14:33:29 -0700")
References: <20260413-b4-pks-tests-with-set-e-v1-0-5b83763a0e84@pks.im>
	<xmqqy0iqfsuu.fsf@gitster.g>
Date: Mon, 13 Apr 2026 14:46:37 -0700
Message-ID: <xmqqqzoifs8y.fsf@gitster.g>
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
>> this is a follow-up to the recent discussion we had around `set -e` to
>> make our tests more robust and basically supersedes Junio's [1].
>>
>> I've tested the patches with both Bash and Dash, and all tests are
>> passing on my machine with both of them. CI seems to be happy, as
>> well. But I would expect that this change probably has some fallout,
>> even though I hope that it's generally going to be small and contained.
>>
>> This series is based on 8c9303b1ff (Merge branch
>> 'jc/no-writev-does-not-work', 2026-04-10).
>
> This unfortunately breaks svn related tests big time for me, as I
> deliberately do not install Perl modules that are needed for git-svn.
>
>
>     $ cd t && sh t9152-svn-empty-dirs-after-gc.sh -i -v
>     Initialized empty Git repository in /home/gitster/git/t/trash directory.t9152-svn-empty-dirs-after-gc/.git/
>     Can't locate SVN/Core.pm in @INC (you may need to install the SVN::Core module) (@INC entries checked: /etc/perl /usr/local/lib/x86_64-linux-gnu/perl/5.40.1 /usr/local/share/perl/5.40.1 /usr/lib/x86_64-linux-gnu/perl5/5.40 /usr/share/perl5 /usr/lib/x86_64-linux-gnu/perl-base /usr/lib/x86_64-linux-gnu/perl/5.40 /usr/share/perl/5.40 /usr/local/lib/site_perl) at -e line 2.
>     BEGIN failed--compilation aborted at -e line 2.
>     FATAL: Unexpected exit with code 2

With the merge of this topic reverted out of 'seen', here is how it
used to end:

    $ cd t && sh t9152-svn-empty-dirs-after-gc.sh -i -v; echo $?
    Initialized empty Git repository in /home/gitster/git/t/trash directory.t9152-svn-empty-dirs-after-gc/.git/
    Can't locate SVN/Core.pm in @INC (you may need to install the SVN::Core module) (@INC entries checked: /etc/perl /usr/local/lib/x86_64-linux-gnu/perl/5.40.1 /usr/local/share/perl/5.40.1 /usr/lib/x86_64-linux-gnu/perl5/5.40 /usr/share/perl5 /usr/lib/x86_64-linux-gnu/perl-base /usr/lib/x86_64-linux-gnu/perl/5.40 /usr/share/perl/5.40 /usr/local/lib/site_perl) at -e line 2.
    BEGIN failed--compilation aborted at -e line 2.
    1..0 # SKIP Perl SVN libraries not found or unusable
    0

The largest difference being that we used to exit with 0 so the
overall "make test" passed, but it no longer is the case.

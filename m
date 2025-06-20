Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27DD1FFC7E
	for <git@vger.kernel.org>; Fri, 20 Jun 2025 20:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750452179; cv=none; b=kABEtnIGJ5V0uGTV7ACq1VMwnPdUXypVOVNK5hjczvjDGCWLsSqJy2mX7rmtZlzbnnw1+4Ct7xP/AmnMPr1kvFeq3FwcnqYNcbcp9WzjYXj74EHHazDLJIz2/ABgQigBaWKIA+NVRVE5/ZLTIFa5PmQ5RMoXAwaGebTUQUYtddg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750452179; c=relaxed/simple;
	bh=aUwxr/N6hF0WFxRRLbHYX31YnI/3FIi6mGxP6Aw2r6s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EAj31W2Njl5OZZqwyzH4kmZU+KGBjm5LO2j6/whH9I2HerIbKEwaW9oeYXpax63YG5B0X6e4hwIZgH5mmSRJFNaDhzRSLuZnY4rmythR7//v6RJmo5njfJC2K+CAZQRxkmOINvOs6ge0x6KazAp2nXakmwQozfL6itN8Wxt0KOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=03iRmEbH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DhrqzYwZ; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="03iRmEbH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DhrqzYwZ"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B6F8E25400E8;
	Fri, 20 Jun 2025 16:42:54 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 20 Jun 2025 16:42:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1750452174; x=1750538574; bh=8RarGg6/nS
	j0VAnMfVQqnwRAORZCYkuQNeDlFro6+p0=; b=03iRmEbHlrg3YVfRFGKHFCNbG7
	M08XO+SOTfxr3jf2Qlu8Fco5pFcWKOzsUeuNnkJAi7ShC5P1TUTHCLROdn/zihS8
	1JdIHNhBi9W75bOc/e5HU/w32rv/9IbCS1bbVd1epe3GPbgsM5k6fNXM1OPm0sfv
	7VPeja9eCql/cDKFRoP/+K9NjIXu1vnM/dJTuKdL+04lSgZOhqh/aC4cUjCZx+lb
	u/je2NmC9X0+AYSBnyskCgiNl9ePvwKDGu4g96bR7Pu1Qm/gJu3UXUazeKp6Vp9X
	oxZC1Kd+hVDkmMjLco6W6rzJhJYCpjIC9ZQTSKrOOMqzTPiiemUq6XM7s4ig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750452174; x=1750538574; bh=8RarGg6/nSj0VAnMfVQqnwRAORZCYkuQNeD
	lFro6+p0=; b=DhrqzYwZ79SzdI9Gyo1WGvC8cXXFYtA0xch8b/+csWwBJH7/YF4
	OkwbyKeYWffGzp4wrI41UMHv0CzPON8GbNhOR8HD9kcpAS+hMIqneiAIR3qnR1s/
	+qEbfmpKmGHFU3QZgfC7LUV9wV8KM9QLrfCxXeoLC/hPCeDUP9jw4YjA0oEmlXW3
	vty/74YYnLYhjkoHnU66Xsk3KLSKyb7w5JQ8TKuDxDBBfBJdJvbkZAPQeye6JlOV
	li5j8423HDBWzapg/jnbMSWnkpuvg5Av1kih+QnCJaXaYIw3mysmXkJEUSPzXwSH
	W1Uoqy1sq4ocCxeNdK3cVBIEdfAS+c5VqKw==
X-ME-Sender: <xms:zsdVaLE-ZZ2wAdQCPdQxhu3uPlqi9ZWLkJLBep0oCmOWCfl4ty0uYQ>
    <xme:zsdVaIXTkIsXsy_3Zj7Buc-5OkuCfF8MM9tQml6XgVnpkVpHNaV_gEPuiQPckEb2h
    UAMJMMMagc6CwyjuA>
X-ME-Received: <xmr:zsdVaNLlr9bf2ZUXu_uR1STUsrWua4QZ0HWuGriERGyZIPCIa1w98fp0dACX17wOJKX2023QnyV1sWFqx_GCYHesWSssKroqFLaa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdelfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsth
    gvrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:zsdVaJHy2q_AAH-Gso0aR6iM2vEcuBMvZUARr0EDDqAglvraZVXrLw>
    <xmx:zsdVaBVSFy6L7qYjlYQB4o4NHNMsvgOBGuwsSmqeW7ADh7RvUPhRHQ>
    <xmx:zsdVaENt7_VFu5emVsbHa9A2va8-m2eWNVbV0eyoK9AtHTQhC0rZsA>
    <xmx:zsdVaA1JfRleASXMw7-UdXXZUQHDjv0Vh0rAcxn0mTSok0ziWotG1w>
    <xmx:zsdVaIwG4gqOI_wnvwDuNrLs3pX47IxgmaQBFEjwFn5tODzUugekV5PH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Jun 2025 16:42:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 10/10] Enable SHA-256 by default in breaking changes mode
In-Reply-To: <aFWzTv5-AjUvXWsg@fruit.crustytoothpaste.net> (brian m. carlson's
	message of "Fri, 20 Jun 2025 19:15:26 +0000")
References: <20250620011943.586596-1-sandals@crustytoothpaste.net>
	<20250620011943.586596-11-sandals@crustytoothpaste.net>
	<xmqqfrfu5ubo.fsf@gitster.g>
	<aFWzTv5-AjUvXWsg@fruit.crustytoothpaste.net>
Date: Fri, 20 Jun 2025 13:42:52 -0700
Message-ID: <xmqqa5622lgz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2025-06-20 at 15:03:23, Junio C Hamano wrote:
>> Another thing that I suspect nobody wrote tests for, but we must be
>> absolutely certain, is that the post-3.0 Git can still interoperate
>> well with historical SHA-1 repositories (I am not talking about
>> "fetch from SHA-1 into SHA-256", but "the binary does not lose
>> ability to work in SHA-1 repositories or fetch/push between SHA-1
>> repositories, only because the default is set to SHA-256"), even in
>> old repositories people have been using for ages without the
>> core.repositoryformatversion defined.
>
> Yes, I have definitely tested that here before sending it out.

Is there a single t/tXXXX-*.sh test that is dedicated to that
interoperability, or is it spread across commands (like,
t????-clone-*.sh has a test that explicitly prepares an SHA-1 and an
SHA-256 repositories and then tries to clone them with the current
binary to make sure the result look reasonable, and t????-push-*.sh
has a test to push between a pair of SHA-1 repositories, and a pair
of SHA-256 repositories, with the current binary)?

> When Git
> 3.0 comes out, we can switch our GIT_TEST_DEFAULT_HASH test from sha256
> to sha1 to continue to verify that those work.  As I learned when
> writing the SHA-256 functionality and as I'm experiencing today writing
> the interop code, if clones, fetches, and pushes do not work properly,
> the testsuite is completely broken with at the very least fifty-some-odd
> tests failing, so I feel confident that functionality will continue to
> work for SHA-1 as long as we do run an appropriate test job.

OK.

> Also, when we initialize a SHA-1 repository with the files ref backend,
> we still use repository format version 0 without any extensions, so the
> cases that cover older-style configs will still be adequately tested. We
> also have some tests that even test that things work properly without a
> config file, which caught a bug in this series (that I fixed before
> sending it out).

Very nice.

Thanks.

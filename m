Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D600392C50
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 15:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774366734; cv=none; b=aaJSvfDKsdXrQE4DqEl1p9Ar16Hkequq0RPD6r/pX6deva3kYZmFtU0SXqMJCEttji9kWXHyoUm1ua4rrOIXa5vqUOIm6gP3HbyWExxtC7d1aLBUCd+YzFQfSFCH3UEpmf4+GoZK5DfyxutiXd6zZpO6jdvGovSDFpoBc3seJek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774366734; c=relaxed/simple;
	bh=XB1FOXl+BKkWlFd6l5Beqgw5o8SwKg9nbd1y6lF/75k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ClhHwWB2fTBICJAcZLgXwHGBM7QpklgcCHTQMws7y7jXpDOASJ8XbtmY+uwkuO4DMFMR5K/Hg5XZhYtHY061DWRSRD16A12EqI60Yymnk7vuYaW5w+pSB5mmDOGkZK0FvaT58KA7EDhbBtGCcoksXx4th4ADrdHz5BHX7Lrx+EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CtSrh0UN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UfQJ0FOd; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CtSrh0UN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UfQJ0FOd"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 8254EEC0110;
	Tue, 24 Mar 2026 11:38:51 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 24 Mar 2026 11:38:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774366731; x=1774453131; bh=QhkX8DGkyM
	aDbtWNUYDTGB9A0rRD+2rID+RKaqEdH/k=; b=CtSrh0UNK81qsNJFEPQo+mKNGQ
	E7t7TFz/5w+vMlMgQ6wXNrDqIZJFhFcw91IOc6MS2mlsdu7VDMYJ0XRtJ4GHBqQd
	I6DxFRPeSIJhdCD9EcJ/rt9UpZHZL6HTxb7uVZaiV6USiqvRF0wYSqszPjdFHczB
	n52gp8VtpyOBOcc1cihF/YdugKBNAUNliUBoxtarlBYi/OnHsOF7I0ilmN30vtKT
	4pQ7NzSeSnYHUdqoCCrozKVHZnyYIV2aYAgPtJFFtsU00rZ8ZeU/zhgtEm3dl29i
	TkHLyf1Dxhj1Gtetle2IjF1IgBjn/z9jELz0kTvkyQg2x5ak2wjq4FXQLbyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774366731; x=1774453131; bh=QhkX8DGkyMaDbtWNUYDTGB9A0rRD+2rID+R
	KaqEdH/k=; b=UfQJ0FOd+ednmM5FdkNvNTWoWbflnwpVaA+jMBKz8exxcLbOSF7
	M7y9vVtxwNhxgqV6jtBwnNoY8hhkQsTLnfTmspNg/EmOWcTvDgpWBu5kwcbCwdG8
	84oyHfznAgjBMNKkNPEiNxm7+7bsmWz6B1gRkphooqrhb6RIqmVo4osm6h5TEm4j
	/E9uBvqRDa56i403037lzEuZijjpwuiXOQ2z4ZMuVjBi2Ed2i2EaocFFcLPILKNJ
	9dtYNuZsCL5X94haI85ssxOYfh7CpGLQBEhXweLeuvi8SFyjDHAKUzJp7rcGkdIG
	QknGlHB6tdPQNQbK7ewh8Jc0hICa+BOojWQ==
X-ME-Sender: <xms:C7DCafjIi1t4D4qzlVPukibp6TokP-mio04jc0H1kXXhUv076KbXug>
    <xme:C7DCaTAi4kiWIOQb4acISDp0t5U6wdSl386OAAObQHiV4v2x1ZZ4wLzexIGCx4oRE
    E43FGmBXZVDWcOWjFZNIBlAz7Asv6OG5mGv43XD4tkUChjB6CMiGw>
X-ME-Received: <xmr:C7DCaUG8KcV6CtkwtUMcXuL-_4IK37A95oAHTvZpX3hnL8EndEKuK5MVshcGczSRdlyF68_OAnt809JIqJ9JZ5HpHMyFuhrNbQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdduleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdej
    ledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrh
    hoihhkseguvghlrgihvggurdhsphgrtggvpdhrtghpthhtohepphhssehpkhhsrdhimhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:C7DCabKb8zQGBYS30xTRxlnhnMvyzf77jekQu03CsMYExMbzwIxePg>
    <xmx:C7DCaYls9Pq_YF6aTT9K2_4ksGmdHCpT5b9UyjArrAn8M5DYvQZr7A>
    <xmx:C7DCaTSad55ime1KVB9-ETRCtcNRoK5dgToeGjxJYEQYw7jU8SxyrQ>
    <xmx:C7DCaaJzUrX8AdVRNpIwsVNDYxWlf983Ci7x93eLwmMP9S4m26ofBw>
    <xmx:C7DCabpccfhDJ5we-oAmxZd0WK7v7I_n-25H1Z5QAwBrh4eujV9PVxsK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Mar 2026 11:38:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Mirko Faina <mroik@delayed.space>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH] t4014: fix call to `test_expect_success ()`
In-Reply-To: <acKqvI0EhaORjoD7@exploit> (Mirko Faina's message of "Tue, 24 Mar
	2026 16:18:35 +0100")
References: <20260324-b4-pks-t4014-fix-test-execution-v1-1-ac83c1bcc828@pks.im>
	<acKqvI0EhaORjoD7@exploit>
Date: Tue, 24 Mar 2026 08:38:49 -0700
Message-ID: <xmqq5x6l2q5y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mirko Faina <mroik@delayed.space> writes:

> On Tue, Mar 24, 2026 at 03:52:30PM +0100, Patrick Steinhardt wrote:
>> We have added a couple of new tests to t4014 in 6005932d95
>> (format-patch: add ability to use alt cover format, 2026-03-07). One of
>> the tests has typoed the call to `test_expect_success ()` and instead
>> invokes `test_expected_success ()`. Fix this.
>> 
>> Signed-off-by: Patrick Steinhardt <ps@pks.im>
>> ---
>> Hi,
>> 
>> this fixes a test bug in one of the new tests introduced via
>> "mf/format-patch-cover-letter-format". Thanks!
>> 
>> Patrick
>
> This has already been fixed in a follow-up series under
> mf/format-patch-cover-letter-format [1].
>
> Thank you
>
> [1] https://lore.kernel.org/git/5d061d6398bae368a7cc95700b5df44854d1d8e8.1774284699.git.mroik@delayed.space

Could either of you remind us why "make test" did not catch this?

Thanks.

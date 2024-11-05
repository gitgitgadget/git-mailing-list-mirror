Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603172905
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 01:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730769551; cv=none; b=EZVt8yQ2yVlEo2maj06K4eDI5wCr1E5eQ3XHsJgPRZzfE54bOPO1ZWC2VMQtFL79+27Uj2a7N1Tia8hsROl0X+PekerZ6w8NpMAO0GmXz/aSTHoTRVf0ROeNT2a3CKQ7hVP+3T4wdxncFsJqHFQum8iMCSdHli/OBwhhjVK692Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730769551; c=relaxed/simple;
	bh=N+pvnS2gLCtLxyvAZGgYNxroo/fR/UG/vmNzFf/EIJY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OqqT6lepYgl99yY/HrK2hbaGA3cq7Qo8HqHj7HrlGdDy8tbJvpqtYxRJY0MB/Behz/9T5wxzp4311LDK1UQ6NpiWvx1+6ULIRVHxP84/F4bLdRAlEUcw048koIYKdtLDjOKpKkblh8wm4wLZzOhUptuV7z4k8GNEPlHX9DdAYSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=A8Yl9OFp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gYRd04sc; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="A8Yl9OFp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gYRd04sc"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 4FED51380061;
	Mon,  4 Nov 2024 20:19:07 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 04 Nov 2024 20:19:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1730769547; x=1730855947; bh=G47Jy7evGd
	ENmj+iL3ssoSjoS8irDMLU7yN6BHgkpx0=; b=A8Yl9OFpWn612WRiI07AoUCh+T
	p4oDHvVYVx7OxtOI6uzHTrqMNVUqHNXu1mZ1dRClglGzvj2AVdHancn0xJYEEjw3
	YfhK4lhfxPZbqo2rrg5rKyPF1Qn7OXgLpkECzS4o7MY3bf7ALwDir3OkOtmdpVwg
	WUIZ6wq9uEMsGUYegBWSHaNqkJ5AE7TXOaB0VdVX3XuqaYDgge+2zjDg9KJfOGZ3
	wloys+AAOqn4CtWkYLOCkedD2kWTgjCDRHhMPCpP0HFvG6qTxy1Q79X1FkkQrcH1
	bBe7koZCdmB9aDQ/YXrhIIbuZCnezoOM630qzSo6EOy3yEHv1JF/94Natncg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730769547; x=1730855947; bh=G47Jy7evGdENmj+iL3ssoSjoS8irDMLU7yN
	6BHgkpx0=; b=gYRd04sc+9zS/aX/6PgdG12ONFshXVjR8fPyQKfQD6NgAgZEgSA
	47X+4SVDEz2IBfr+ZtZ5ojPCmqud6azVRweisesL8a4lfCGtPcD7o778e+/RZ+Ju
	MbOpwSj6pdEV3a4/HPAq3TAZxSxCD4zOK/ZP9JgIcC+HkVshoahCZAx7Zc9W8oUp
	0k6cj/jgzIS62e5Zj8a6sy38csEI/lDL4UT1BAK7WhjsbBkWLO0RIDXqZTq8RWZC
	xYKgSBpb6YUNS+ErRat/hzeGyfYBsgWx2qPpUGLMCV6wKweG/S1v2fq22xzNWph2
	JM2WxHW+CeoB72AsYJTc039zheo5DzvSAJA==
X-ME-Sender: <xms:i3IpZ2enYkPgpsBdfcKD_crqg0g5mmrP8h-FmwB0SeD4wmIdSHsHJw>
    <xme:i3IpZwPtUUBFRoz_Eq1LBVWgvVm5_jmymXh7S1SEduDabe79bOWm_bnQBQ4U02Ksn
    PmH5NKxWHwUDSVEOw>
X-ME-Received: <xmr:i3IpZ3j09g24oS8EBmvjaxs-E8DpfG_LsYZ1lkY5W31642Dkyi-_8lT5cMPx10CFvfmmpkA8mBmXm5MiCYazycMB9qBztqxB_wXB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeljedgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    gjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghn
    ohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefve
    etteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopegrsghhihhjvggvthdrnhhkthesghhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvsehtthgr
    hihlohhrrhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepsh
    grnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:i3IpZz9TTYX2sFzO-ZKMV3AMAA5p6474S67rBZPTv-gB_DwiF7GXeQ>
    <xmx:i3IpZyvQDtcybaxFKMmHw66SFFGjgwPxb_wVNy7QVVLdJ1cqEo-MtA>
    <xmx:i3IpZ6Hg35KiJQNmtjme-eDy8OfEKQ8IwFvbfL05GEdIeys0fFDlHw>
    <xmx:i3IpZxPcLNL73mo5-7agtObyZrw5qf8cVsTapjoJeR74lF93fe07zw>
    <xmx:i3IpZ2i0dAc6nSEF9tkN5lsw8q938ZiciFi9nrUyrLtFhVzxziQZvRK0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Nov 2024 20:19:06 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Abhijeet Sonar <abhijeet.nkt@gmail.com>
Cc: git@vger.kernel.org,  me@ttaylorr.com,  ps@pks.im,
  sandals@crustytoothpaste.net
Subject: Re: [PATCH v5 2/2] t5300: add test for 'show-index --object-format'
In-Reply-To: <20241104192958.64310-3-abhijeet.nkt@gmail.com> (Abhijeet Sonar's
	message of "Tue, 5 Nov 2024 00:59:58 +0530")
References: <xmqq1pzuylm6.fsf@gitster.g>
	<20241104192958.64310-1-abhijeet.nkt@gmail.com>
	<20241104192958.64310-3-abhijeet.nkt@gmail.com>
Date: Mon, 04 Nov 2024 17:19:05 -0800
Message-ID: <xmqq4j4mv5o6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Abhijeet Sonar <abhijeet.nkt@gmail.com> writes:

> In 88a09a557c (builtin/show-index: provide options to determine hash
> algo), the flag --object-format was added to show-index builtin as a way
> to provide a hash algorithm explicitly. However, we do not have tests in
> place for that functionality. Add them.
>
> Signed-off-by: Abhijeet Sonar <abhijeet.nkt@gmail.com>
> ---
>  t/t5300-pack-object.sh | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)

Nicely described.


> diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
> index 51fed26cc4..301d5f1b61 100755
> --- a/t/t5300-pack-object.sh
> +++ b/t/t5300-pack-object.sh
> @@ -527,6 +527,28 @@ test_expect_success SHA1 'show-index works OK outside a repository' '
>  	nongit git show-index <foo.idx
>  '
>  
> +for hash in sha1 sha256
> +do
> +	test_expect_success 'setup: show-index works OK outside a repository with hash algo passed in via --object-format' '
> +		git init explicit-hash-$hash --object-format=$hash &&

"git help cli"; dashed options first and then other arguments.

> +		test_commit -C explicit-hash-$hash one &&
> +
> +		cat >in <<-EOF &&
> +		$(git -C explicit-hash-$hash rev-parse one)
> +		EOF

Hmph, is the above a roundabout way to say

		git -C explicit-hash-$hash rev-parse one >in &&

or am I missing some subtlety?

> +		git -C explicit-hash-$hash pack-objects explicit-hash-$hash <in

> +	'
> +
> +	test_expect_success 'show-index works OK outside a repository with hash algo passed in via --object-format' '
> +		idx=$(echo explicit-hash-$hash/explicit-hash-$hash*.idx) &&
> +		nongit git show-index --object-format=$hash <"$idx" >actual &&
> +		test_line_count = 1 actual &&
> +
> +		rm -rf explicit-hash-$hash

When this test fails (e.g., the number of lines in the show-index
output is not 1), explicit-hash-$hash is not removed, because &&-
chain short-circuits.

Perhaps join thw two into one and use test_when_finished, like this?

	test_expect_success 'show-index with explicit --object-format=$hash outside repo' '
		test_when_finished "rm -fr explicit-hash-$hash" &&
		git init --object-format=$hash explicit-hash-$hash &&
		...
                nongit git show-index --object-format=$hash <"$idx" >actual &&
		test_line_count 1 actual
	'

Other than that, very nicely done.

Thanks.

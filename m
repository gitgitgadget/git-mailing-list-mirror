Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2059634D4E2
	for <git@vger.kernel.org>; Thu, 23 Jul 2026 23:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784849305; cv=none; b=bJl4ERr+rLnzqnh5z82vQQOR1RGjydz9urlKG6cqiNvURVvqL8r9BoIX42X61pxfi2CwrRj/90J/AVmPXb279MNFqs6eI5Uq84HORcgYjsr6sgmDY9LtNMovWVHT57f+wKEVBC0Op1ESiX9sBEruTsL6PlxGhmTfVNDcNQDTMKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784849305; c=relaxed/simple;
	bh=y/eS9RqQn/pn1el7Zv+b/DpDC1aXBBzQr3U6DTal0SY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=P1MVSFfPPYuzWhkaNcATshmHzvWTbhw9NUp6/qHDfxz/d2dJYzI7w5dszWa6Ve7m41IuFt3yn4u83ed2TzUOGzSxRmf6oh7Ll5bTad8QduqVBguRkpcmyqq1jUI8CZIgwPurYrtsbb42BOjoE9OmXuBv603kqoOkrgyxzIKuA10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=J72434Tj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GBgxqDOf; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="J72434Tj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GBgxqDOf"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2FFAC7A00F4;
	Thu, 23 Jul 2026 19:28:23 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Thu, 23 Jul 2026 19:28:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784849303; x=1784935703; bh=Mpl8xWWh4a
	cgF3NEkiQtIpRjDKj7DkThM5fekETVdJo=; b=J72434Tjc78jwT51Euu/TI4W2s
	vx+ZeOWYJebNMmGfqEHnUVrTc2MnbzfXMvPxEstsgd7hZCl50DD2StFMPAjNr+RT
	9MVH9rPU0u7kfylak73ys8jwV5MifPw/eMhdxvodpyMocRGZL14Q4u725+ejLIep
	eFu/It9VUZfH2l+9WaQnW1XNtRPtz9AJtiX1mCANylOhwMpxNCOMnCUewDFe/OEN
	MFLH/Y0PhoKBVki8HmD8B6k7YM8yd1R50Z+GBQ2BPFU3eUDhcBJFtDYVpIGxVe1M
	SoKpZpOdt+jI11gaM3GCG7yTHqtoV6Nf4mh7dSzxxxKuM5n2No1+pcfSr0IQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784849303; x=1784935703; bh=Mpl8xWWh4acgF3NEkiQtIpRjDKj7DkThM5f
	ekETVdJo=; b=GBgxqDOfCpvsImKa6c8IvoiJ580WV+zyb+yHzrbREA/DNkHyOq2
	1RLc51tg3HkjmBk90UYRc1CY/c/JgZ1TDkyYk3Ad2VYLGMf7tCdAZx2aAxACFnpX
	NhHhXhGR+WarQ9cGqNOItHYwSFp+jQx+reuvBPUmCj8bF74qR5JOHGgHds8EAfTX
	zKlyMzuTPNLyT0P3lK/Hoy/eu0t/+PCLA5X/+H6qu29VTsO4vqtx5/pLc07Sbvrp
	Zoc5rcOhj+h7CsLSsxRQyR1zg6ndzXyg3xBhpllN0m0RrU3VrkcIc+VYz/CPSLiI
	dsxBivU3CQGWl28Ax4mmI1+QuKsrQvvHvlg==
X-ME-Sender: <xms:lqNianiy7f2g3DWTI09v9jvPd4mq8VD0MFm9F36rIMQ0cVVgwWRoqA>
    <xme:lqNiaq6zWV492Mu0RiQ7m1t1EBM7reUXgpdIFNAw_UrIRSsg-MBUuATM_xijBN4sI
    fkBBC0Y1KJwFhkJXhJY8fJ4pg3MOvHhySjmpOsQHe5dQIfb4tKU>
X-ME-Received: <xmr:lqNiavZnGu_XOB9BygiJbx2L5gH0wZYnNHDarFNA84kZFnP8SdrvEjzyE04CnzZq4LdDMmSlkUZDV4_E360CfEm21xcr9fehTw>
X-ME-Proxy-Cause: dmFkZTEpQrzed4yiXOw/ZgGJ8bhrOJ57hLRjAxA5XLdomgefTyniErgOvYRLwwTmvme8SM
    JwqXADOnVvgOlzyzKPou+gpnfi8zDKGfJHvSvB2aLzkM1dUxNXlQ6r5tQpWjOCHPLfWXYb
    m+0lt+PonLw2qYuAEFJE7baAKm6N7zPRAg8bHn0SDim/A+xUHAeTMcQGJJ5u8jpeDW75va
    VWHJ+WMUSo0wwJx1y5d0nLlVEZk6kxfHiC2u7uSsp6blP32VXVsRP2zoce4ocLMtv6/5vb
    ML6MFaF+rkXMozko0CYgso3FLjL1Vc40ZJcFQOMEbVxfMHx7Hhv8iW/3GLgsnuJDlZ5EgJ
    l88t7U0c76mNftygSNL4H9uJ7/XjAy69uTDRu0p6GF5T0giep9DWIVveWhXCsxSUZYJrji
    eMPU1IfGtyNWUqWe4ZxnTsCQUZ822xgM2SH+MCKg6qFJx/eYxRM1ojjWbCGk0dk/zeRhxV
    hKTxsKe56mvilVm36kUEq3gSO4FogCIE8+mMm5RB9RXKYBOFseBVtbQ1gM/SXkG9a3a6OL
    Wg0mAImpP2W2Y8DtBFYALFGxKnZMjROrFDgqYCHqGB97qW+JyAPqljuyM9ICoiwse2ke7V
    ko4rHNHWTUVom6tOMPNEAqhZ21anBN5+QUQDOFVRyOJs4pi34CTiGgLjfFag
X-ME-Proxy: <xmx:lqNiav5xDjieS4yQYBw4YM1XrF6yOuaotvlS_eVa_lVQsSALTdY6Xw>
    <xmx:lqNiaiB6zmeGZimRSy09OVHBg1R1Kree2jiKDvQXg-aOTG4Rr4Lf6Q>
    <xmx:lqNialcZHw6EH9iPyUtnfgZhU0CsyBAeHSBbXkYajY7SOgc4D4gayg>
    <xmx:lqNiahI8bxhn8Fvvtn7xHJrKw-k-k978VCTLZBeppaSNvR_Zxi4pow>
    <xmx:l6NiarL9MT5q4R4Lll1EmWmum2taJJxYSK5RdsNzzJACLquIeAEpAy95>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Jul 2026 19:28:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Lucas Zamboni Orioli <lucaszam0@gmail.com>
Cc: Lucas Zamboni Orioli via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Ben Knoble <ben.knoble@gmail.com>
Subject: Re: [PATCH v2 2/2] mv: check for missing destination directory
 before renaming
In-Reply-To: <CAH01Q-_2APONq2fXmjF=Wo08rTzScMEjyXL-G=_GH6TbjJmTBw@mail.gmail.com>
	(Lucas Zamboni Orioli's message of "Thu, 23 Jul 2026 18:38:18 -0300")
References: <pull.2356.git.git.1784125963694.gitgitgadget@gmail.com>
	<pull.2356.v2.git.git.1784812390.gitgitgadget@gmail.com>
	<1a790e001610d3324ec45d86ac67ca5720678cb8.1784812390.git.gitgitgadget@gmail.com>
	<xmqqo6fximn2.fsf@gitster.g>
	<CAH01Q-_2APONq2fXmjF=Wo08rTzScMEjyXL-G=_GH6TbjJmTBw@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Thu, 23 Jul 2026 16:28:20 -0700
Message-ID: <xmqqcxwdcmln.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lucas Zamboni Orioli <lucaszam0@gmail.com> writes:

>> lstat() can succeed and 'dir_st' may indicate something other than a
>> directory (for example, a symbolic link or a regular file).
>> Alternatively, it can fail with ENOTDIR when, for example, 'dst_dir'
>> is 'a/b/c' and 'a/b' is a file rather than a directory.
>>
>> Both cases will cause 'git mv' into a path assumed to be a directory
>> to fail.  Shouldn't we handle these conditions as well?
>
> Yes, agreed, both should be handled. For v3 I switched from lstat()
> to stat() so that the check follows symlinks the same way rename()
> does, and I handle the non-directory cases:

Generally, a symbolic link in a Git-managed working tree should not
be followed.  Following a symbolic link would mean that 'git mv x y'
could move 'x' outside the working tree if 'y' is a tracked symbolic
link pointing to a directory outside the working tree.  'git apply',
for example, avoids being fooled by a symbolic link for the same
reason.

I doubt that using stat() instead of lstat() is the right approach.
Doing so essentially amounts to ignoring the presence of symbolic
links.

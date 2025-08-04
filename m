Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F54810E4
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 04:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754283207; cv=none; b=AukJKs/ZZwCMiltjzM7Zas4F5ByF/0GczmKeiFFzJrCNet5rIqSln3WlXAJh4kjqeZoZwLg+MAGQsVyWY9CF0iesnHLQBG0dF59sDhOVDbBQZO6rMwdLPO7i+W4RKQEjYK71XNIkMMDbyIuMQAEJd36/AH08hrM/8GljGv8EDoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754283207; c=relaxed/simple;
	bh=26fgZVSn3wK2GylMvF4xtNg4PnwKgrbwPFUdiDGQBA4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g8Vfg59W4dENIOJnobh1B8x8u9d2TzzI1QWjtJoaUMdxEBpUrX4PJHuJ60kIoWzUDx7RHYV3Pyfzgd6CPJZucKU7k3OLvJCM2kKDqMnOPOW1ZwiJrJWY4su3pXa3w/ztl6bpNsZgqWPbnN07hHfnVLhLJI3krJ4FyuIcYRXapbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VtHXGRoh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C3ngXxOd; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VtHXGRoh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C3ngXxOd"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 68A941D000DD;
	Mon,  4 Aug 2025 00:53:24 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 04 Aug 2025 00:53:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754283204; x=1754369604; bh=7DO9KK8EgJ
	eDixQaIE9uvkYwlc3mk2pbHf1TjK+J+UI=; b=VtHXGRohnefeIN71QafbOOv9ZB
	cfbVrBrIM18DhyHFbBinJE9oJMwRe0hhIOpRiwi3YglfJsZvBYGtA5O4sR9wCMQH
	TSDNtkbjfYWaa3xc0pjHIl+3ijYvBeFlnO8/psXsXpRWM8Lq4keqeS7okZIn/srJ
	DxiXOnYycVLnfbDgReyytKtqactEg3rz4Yknbvl6RpY9K8X/qS/1xMZ7r8eizd0w
	o1J2uEKgcQSjkNVtofaejexZfEEjSwBTbXBdYhWrM4lBjdA5bgLv9gUKRhWjJLOB
	yFZQEhz4BTJ2g5KLfysa7OGNFDo7MKQBVzFreqE/t2TdF/tRZ0GzJ0+EN79w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754283204; x=1754369604; bh=7DO9KK8EgJeDixQaIE9uvkYwlc3mk2pbHf1
	TjK+J+UI=; b=C3ngXxOdAWyGQWgGyMe8VdriwVhPwapZr8xiSh2LhkbEbslr7cH
	VmQ974YvaBh8KY/tfhX3YEy8sYVNzjSG3FhPhzIZTaU+RZSPyG3hKPndNLps5EYp
	/CzSw6KLRRzxAlwNY1KK2Degh0wZ4qwEClFbxI8Qe2sen41F+DWwkj4zpzMJpSVa
	7Byb/xwvlZxC3r/7xlHsCJgf3mXj3EFHHevGMIyAmd/jB5pOtnz7dnO4xBsFuTAG
	3rHlrmHWxaXEeOYup8JHqYxGn33PAKZ4IgoBhtWPmEosMvrigRAXLCnm0LUuwOYA
	klf8gJVcCUan/Dd67yppcy+q4owHD8IIDZw==
X-ME-Sender: <xms:xDyQaLI5b7DXhx5eji5Jq7osK-haZOvODdHMbtKJxN6spMVFph3wXg>
    <xme:xDyQaKoPXDyxi5rGlqXkRV1b_x17MyrNC409kC5Y_1WhOlO8qf_suH59iY4a7lps3
    lIXo9osWeyWAzFk5g>
X-ME-Received: <xmr:xDyQaKKRnstDS1mwcSE-7-WGk_ya7Ytq7r1AQ5Bnj8tQgUCzblLKYaQMsHJLJ9BNht-0FFALvpU6JBZemcMcbMJKSpChUU-VycVvahI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduuddugedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepsggvnhdrkhhnohgslhgvodhgihhthhhusgesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepuhhsmhgrnhgrkhhinhihvghmihdvtddvsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:xDyQaPRKyRtlb85IK_b8Bua8INfxZHVatrw0Xsbxo8PWGcd3_WezaA>
    <xmx:xDyQaJt7-GLABS-yko46C_vvggoqyznlnA0gv9RB5OAKPboVe9LXgg>
    <xmx:xDyQaAYr9xXyG3l3sngaVlE1vZgh5AM4d1gUlI_P2-yRbr9FNj0P3Q>
    <xmx:xDyQaPH23T-i_afjPgI7rraR9Ba-b82H7QRjWwIrR5nazJSsljB7Ew>
    <xmx:xDyQaGFXsRLEii_Jl7DGds2NRhtuLBwA-Tjzg6BI0idIAHC_MGTM1nFG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Aug 2025 00:53:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Cc: git@vger.kernel.org,  Usman Akinyemi <usmanakinyemi202@gmail.com>,  Jeff
 King <peff@peff.net>
Subject: Re: [PATCH v3 0/3] permit -h/--help-all in more scenarios
In-Reply-To: <20250803161033.77696-1-ben.knoble+github@gmail.com> (D. Ben
	Knoble's message of "Sun, 3 Aug 2025 12:10:24 -0400")
References: <20250803012613.54086-1-ben.knoble+github@gmail.com>
	<20250803161033.77696-1-ben.knoble+github@gmail.com>
Date: Sun, 03 Aug 2025 21:53:22 -0700
Message-ID: <xmqqo6svd6wt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"D. Ben Knoble" <ben.knoble+github@gmail.com> writes:

> This series enables --help-all outside of repository contexts,

I've been familiar with "git commit -h" (and commands other than
"commit") outside a repository, but did not even know that "git
commit --help-all" didn't work outside.  For commands that use
parse-options, these come from the same source of informatino, so it
does not make any sense for one to work and the other to refuse to
work.  Good.

> and
> allows -h with other arguments (without breaking existing ls-remote/grep
> usage).

I somehow thought we already talked you out of this.

Do you mean something like "git add -h foo" and "git add -h -N foo"
would say "'git add foo' would add the current contents in foo to
the index" and "'git add -N foo' would make the index aware of the
path foo without actually adding its contents (yet)"?  I do not think
it makes much sense to behave exactly the same as "git add -h" when
the user says "git add -h foo" or "git add -h -N foo", as if we
didn't even see the extra things on the command line.

Thanks.



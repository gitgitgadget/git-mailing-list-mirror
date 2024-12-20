Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8B4215F78
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 14:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734704195; cv=none; b=qm+fpuw5W1NBensoU54NYHHwFUVlg+liXZuNWq6W0kAslSZqYCdVeSrWIgi8D/r1bwAe+sFiQcRVqeJ8tmOykhKPMkLVM+5IYo2ITcWUxUJllVX0FWePsM/xQTyJy+gnjAWnYDiB9fyp5ynoZ8eB96OsiDS2ZbrWNlXnHLH/rok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734704195; c=relaxed/simple;
	bh=7IdmghsR/+DrjWzNBiIAgbVBuHaWKtilrVcuC3JqgN0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OD/AYx/5XkusDQiUChbXlfJEQ9zW/H9mGbbXcMfH6ajlExBWsgs+xRPcouz6GENzEL48C2BCIgd6sqpf6qMax9LcJZA4I54Cex8JhoH5zSxvioRRjjO+ZAO4ukdAkRK5iroCa3EozMe6wDZwvXDHjqAUasvzjttPMuH/HvUXrB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=G+yciJZL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V6ZTtEHb; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="G+yciJZL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V6ZTtEHb"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 7FC791140141;
	Fri, 20 Dec 2024 09:16:31 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Fri, 20 Dec 2024 09:16:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1734704191; x=1734790591; bh=iC5vMBMVD/
	kXRaig8OsHSANpXdrGBu6ryssi0G71KNQ=; b=G+yciJZL05eT8KsDqhaev9QCLu
	ifEvfkPghpUc5YB9mFVmDwh5GAKU7mSBbZJZ0p0s3WViqjkciYwg1YUpOKgU2NqM
	9T2ycT1wDgN3Fy2EZCPjrgjw5ebxjYlOl7RcW8XS4r8hEzq6aY/DvObWQshUdBFY
	67mYIgDbdkFl945Nn+cvQI+hUcaqo/yayB90VPakqVoqjRaM6QzZkNtuKclTDjto
	r4TVjL+TAWlhZNzGBYaAmC0KBH1DHK7Bon41ji5lZPtNLOUp7wQT+pxbAYAUpdOf
	49tkSkoAhb4INKTY6AX+NzZ0RNcysGhZs2nOowODaPbLmyiUzQjftuZr/wKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734704191; x=1734790591; bh=iC5vMBMVD/kXRaig8OsHSANpXdrGBu6ryss
	i0G71KNQ=; b=V6ZTtEHbzU3SCcZmFmiEg5EDr/BJRDM/t9/Cu78fPoyQ8Ocks3R
	HGmR5QeKoJGLg87ANGd7AH5T2HyG1d/Yy79UCEeWbddZuy1D/eN70rOstyv/vfge
	6Zweq7ukSKcTJ/G58W+7Prx6FdV6QgGeCbSnfUd7v9UPlS6x7DOvUxpOP7oh+m1v
	+RROTsHikM/mFVBFD1a2Qz5JtjL3qBi8yDI+3taZ5kKhTZH+0GxbY4UbWABd3QIv
	CsvIcVWTsPLo8dOollhcdADvaETeYaH0ADdiRDapIamJhZHBuRE+9mpiR3rMBNos
	osWpBeePBDuuBFXfm/WgmdgW8dSHh2jwd2w==
X-ME-Sender: <xms:P3xlZ_qxGJRUXjYW0eSRc1Xr9BmCRle74_FqN2m2goQeUKTO2xSFJQ>
    <xme:P3xlZ5p_2GStFeawpRHPCz1Sw9VhKqy1WEU1ekWfZ-6rYH4ThzbH_qa4eXMzpyc4P
    ko95yi_6cL9Y5MyCw>
X-ME-Received: <xmr:P3xlZ8MIK5hYsRXCQkBBwJNtCKAFucWFLcFBlD110jYBuIAnHgJiFmibYyCNQA5UjMkJoDrEEdl9mpAYpz3HgvNA6ynFPCdVdg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtvddgheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmvggvthhsohhnih
    eftddujeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdp
    rhgtphhtthhopehkrggrrhhtihgtrdhsihhvrghrrggrmhesghhmrghilhdrtghomhdprh
    gtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepshhhhigrmhhthhgrkhhkrghr
    tddtudesghhmrghilhdrtghomhdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrih
    hlrdgtohhmpdhrtghpthhtoheptghhrghnughrrghprhgrthgrphefheduleesghhmrghi
    lhdrtghomh
X-ME-Proxy: <xmx:P3xlZy5Z2eaEX7olFHCFan8oeiWnb_d5IFJh_mj1JJWM9ky0Zv_p6w>
    <xmx:P3xlZ-4QVufITWzLROrPsbu2WlXzDYw0MFA4MaScRx_0vNKK9aVEQw>
    <xmx:P3xlZ6ilKVPjnqCuxZUcUM9OO4aZQ3epdhHVkzPsUH_XEV2e0_O7Ww>
    <xmx:P3xlZw4KDq3f6l0rqqHqMQtOg8S2W34k36W-_9VNWDj847-sfLyZbA>
    <xmx:P3xlZ7y6OuXOViEIw3eNP-P2Az0c48GwFS9IE8byTfh84epCQPvezTO8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Dec 2024 09:16:30 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Meet Soni <meetsoni3017@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,
  karthik.188@gmail.com,  kaartic.sivaraam@gmail.com,  ps@pks.im,
  shyamthakkar001@gmail.com,  shejialuo@gmail.com,
  chandrapratap3519@gmail.com
Subject: Re: [PATCH v2] t7611: replace test -f with test_path_is* helpers
In-Reply-To: <20241220130632.11826-1-meetsoni3017@gmail.com> (Meet Soni's
	message of "Fri, 20 Dec 2024 18:36:32 +0530")
References: <20241218111715.1030357-1-meetsoni3017@gmail.com>
	<20241220130632.11826-1-meetsoni3017@gmail.com>
Date: Fri, 20 Dec 2024 06:16:29 -0800
Message-ID: <xmqqcyhmh22q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Meet Soni <meetsoni3017@gmail.com> writes:

> Replace `test -f` and `test ! -f` with `test_path_is_file` and
> `test_path_is_missing` for better verbosity.

OK.  "verbosity" -> "debuggability" perhaps, but that is minor.

> While `test -f` ensures that the file exists and is a regular file,
> `test_path_is_file` provides clearer error messages on failure.

Correct.

> Similarly,
> `test ! -f`, used to check either the absence of a regular file or the
> presence of a directory, has been replaced with `test_path_is_missing` for
> better readability and consistent handling of such cases.

This is misleading.  If you rewrite "test ! -f" that intends to be
happy when it sees a directory, you would be changing the meaning of
the program if you replace it with test_path_is_missing.  Rather,
when you see "test ! -f foo", you should first think if the intent
of the test script there is to allow presence of "foo" that is not a
file, and if that is not the case, in other words, the "test ! -f"
you see should have been written "test ! -e" (i.e. "I do not want to
see 'foo' there on the filesystem, no matter what kind of filesystem
entity it is!"), it would give us the same meaning with better
debuggability to rewrite such "test ! -f" with test_path_is_missing.

IOW, unlike "test -f foo" that can pretty much blindly replaceable
with "test_path_is_file foo" without thinking at all, you must be a
bit more careful.  And _if_ you did such a more careful analysis
before replacing "test ! -f", then you should restate the above,
perhaps something along the lines of ...

    On the other hand, `test ! -f` literally means there should not
    be a file (implication is that we are OK if there is a directory
    or device nodes or other things at the given path).  But by
    looking at each of these in the test individually, many of them
    should rather have said "test ! -e", i.e. "there shouldn't be
    anything at the given path on the filesystem".  Rewrite these
    cases to test_path_is_missing for better debuggability.

I didn't check myself if all of the "test ! -f" you touched are
indeed the original should have said "test ! -e".  Hopefully you
have done it yourself?

Thanks.

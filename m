Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAFE2745E
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 17:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740505459; cv=none; b=VhwoPq3qUrpbWua+7TXy9/9uFd815PTixTF/2m/8pr+gbjyf6AHNsSJkyWiPfcSgpbWaIQH58f+EelBxJPgJHEj6eD9EBmRLmGTF3ekh3RhfsQsA8Q1xeU/WlsQ8BOhVFUy7F5EIas6HNuRRp8sJKhE6Jev7w1a5nvf8gQme8gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740505459; c=relaxed/simple;
	bh=JyAAYPobQLtepZKnib7JBDdrXlhWRIhALQlDvEMIKWQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W3Z9GVHVgj1Vv+GX+mwIoA+/DaMsZ1yfIdVE9vDttlXJ043tEgpynweCh5a4I0JKaQ3uY3jCSMMbptPK5XnWtPfPep9gKrrGuU4V36gBS2b9FPXlOo4KpBdt3HSESwHi+mRL9hgL+wZu/+5kKLTqOnPEatj7YTHLmBmpahxh3kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jJ44WVXE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ln1HD9kX; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jJ44WVXE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ln1HD9kX"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id E808711400CC;
	Tue, 25 Feb 2025 12:44:14 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 25 Feb 2025 12:44:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740505454; x=1740591854; bh=DgVQSqlzld
	EzQE6qhWyz4FiMbg22XowM/i4xPkAxF4o=; b=jJ44WVXEZRNILCa2MRFnh7Kntk
	wBZPjRkgiC8jWzycjzqKPYZz9SF92DepyU2N+atnHgYy03LWK3qRRp0t8BH63y2s
	/F2yFMxuMKuDm83PMGXQ+0q52pvDr8K1fMZQtdW6w42xEfKbk5Rba6rHEmmwolqs
	NoRhh4oZG0PGsYqEIxtTWXM6kFEiMGVNE4XDMFVVsamjxb1hbMI8saihg4lG3LJw
	vyBI9j/pCSj/q+ysnM2DnZ1OjOoua8QabZc4cjaDUfB1+tLJvM2ocRfjYFZbhrFL
	/BTD5pFfBUpM0EDVhdkyetLdjQZdrXmY/BKi1S5DS4Tlb5I0N0r8L1NPMwDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740505454; x=1740591854; bh=DgVQSqlzldEzQE6qhWyz4FiMbg22XowM/i4
	xPkAxF4o=; b=ln1HD9kXzYqnFeq9uOmIVVmWSeaHyhp8meW/Nd6EkJ9kABnm2G3
	RE8vOCIXLowJJFcQwnsi5pUf2grHFSdflq56RQCrzcBsn96GLDRiiEKyqIawRKgU
	udjjT+DL00uyrt4DbepTVUBs4hsCCDoiVZz5cfABZh8CYhlgx+FGcy6xsI89YsxB
	v+K+zFdBz040giPAvYWUJhWyuLHw41sD0F5kwvK1dbZR+ieYgfw5TnRjdm35qH8I
	Qj60fcXuD0XXZ1CfHcosYPM6+X/DCKRj1fUn5LLAPm1+2+mgtgOL1fSa27GSL57k
	uQZvorASu+qO/GxJDJZ8386dWEHGQjCmN6A==
X-ME-Sender: <xms:bgG-Zx1-WWFHvcxuVeCfu5WKlUmF9IZfQ9lGz8sT6SzqPqwSmpfsNA>
    <xme:bgG-Z4HcGotvk7k63jEWUdmrxAQZ3i-5F7X1D11nz2XLS2K4nkqCfhGCDiIUekx2C
    Ucn-qKAB3bs4ob6VA>
X-ME-Received: <xmr:bgG-Zx4h2HhbGLscbBKEt4flG7WRqWX3lZpV3eAehnQPIqgMFeL-lZCsFGequBQ4iR1Wi0XWvEPWRnV0nX6tWCbgu5rZH3K6lffH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekvdeffecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehshhgvjhhirghluh
    hosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehmhhgrghhgvghrsegrlhhumhdr
    mhhithdrvgguuhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:bgG-Z-15UnJedg1IruTszdN2ZQR5vXTSprDsBum5mWHcEY_Wf4lBXA>
    <xmx:bgG-Z0GcaO_QigIdrfmcdQgxfF-JY_ZzrPqyMfWXyGL5czceqBglxg>
    <xmx:bgG-Z_-Jv9aZZJxsiCpBlE4D5MmJlfdh0CK2TEhVQGjkwZH0y8KT8w>
    <xmx:bgG-ZxltOlFPwsr7qCgx4bHHvFMP8T46pOvRB9z7C4Gu4ocvmSaSxQ>
    <xmx:bgG-Z56kRhuXuYuIcYna07ObC-Z6oHn9qAPUH__7TINyY5UipyzrC6YT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Feb 2025 12:44:14 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Karthik Nayak
 <karthik.188@gmail.com>,  Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v6 3/9] packed-backend: check whether the "packed-refs"
 is regular file
In-Reply-To: <Z73D3PdEFk_nciH7@ArchLinux> (shejialuo@gmail.com's message of
	"Tue, 25 Feb 2025 21:21:32 +0800")
References: <Z73DTwr9RicKMINe@ArchLinux> <Z73D3PdEFk_nciH7@ArchLinux>
Date: Tue, 25 Feb 2025 09:44:12 -0800
Message-ID: <xmqq1pvlly1f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

shejialuo <shejialuo@gmail.com> writes:

> Although "git-fsck(1)" and "packed-backend.c" will check some
> consistency and correctness of "packed-refs" file, they never check the
> filetype of the "packed-refs". Let's verify that the "packed-refs" has
> the expected filetype, confirming it is created by "git pack-refs"
> command.
>
> Use "lstat" to check the file mode. If we cannot check the file status
> due to there is no such file this is OK because there is a possibility
> that there is no "packed-refs" in the repo.

Can this be done _after_ the open_nofollow() check you had in the
previous round noticed a problem?  Even though we are trying to
notice and find problems in the given repository, it is generally
a good idea to optimize for the more common case (i.e. the file is a
regular one and not a symbolic link or directory or anything funny).
Something along the lines of

	fd = open_nofollow(...);
	if (fd < 0) {
		lstat() to inspect the details
	} else if (fstat(fd, &st) < 0) {
		... cannot tell what we opened ...
	} else if (!S_ISREG(st.st_mode)) {
		... we opened something funny ...
	} else {
		... the thing is a regular file as expected ...
	}

perhaps?


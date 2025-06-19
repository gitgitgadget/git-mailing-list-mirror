Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E91C29186F
	for <git@vger.kernel.org>; Thu, 19 Jun 2025 14:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750344938; cv=none; b=CVLTZWTbGch1/XaNjLnLJ1BmOAhL77HPIsAfKzVfsiGQOdYvRpxIprvPSmzz8XxjPS3ewqtLE+uxJzkL2JKvcTBfKoO78Jm+ThTY8YJlL+y1rLuTaRUHDLmgYXKl0bVHcS1tnQzoj472EB0WYhnUTxvWllQJrdEP4yKUo22s+28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750344938; c=relaxed/simple;
	bh=pIPG/fhuNp4ZnqZ3+qvj077P2qzVPsj1hGzUTJqcNpg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HFD5KzVXgLMdMUXmdM1JeeFTpE9nKm3armvmLv2YhDJ7FM/HMZ7V+9tAuN//UklkbjET8mnxm+FlaYquQQ+zysl1pc65CvE75PQknZVsTSt0EBfzcY8ENmOSYln2Nomrtuy2sfxa4RHOxIPSJ2cOsWu/jlvcNtQRcgcPQLp0oCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cL9JW1Wl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gAWtFNhE; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cL9JW1Wl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gAWtFNhE"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id C57191140129;
	Thu, 19 Jun 2025 10:55:34 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 19 Jun 2025 10:55:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1750344934; x=1750431334; bh=9mU/Dq7Wre
	UH0bCPwnz3LsmXen4zYhRMOB9oJV7pjOY=; b=cL9JW1WlBJ5qIHI+xxzVoqO21R
	R2MCEVJyHSET1dZHl7dzIUgIMt3fAAYQeHwgnBlpVQdgo7n/oGMS6ZzAGEeGOzPy
	YPD5izNryAznqTynp1zDEjxRjWA1Cl4tk8QDXfZ1JgRXTXMJ052fTtXlo4TzP5GY
	aUOG18gRQypkJh5hWLSpq6kClmrfL1bI2PQUsaKPi+QSZpObLQNsmjm27iwiI4+D
	Qn2ho9oK34gFDUr1ILOmjV9erjwASv1bhkyVmX9S5vthbFsSkcNxJeataag0GHa2
	y6CfOz/UdowCbZIWVCBFa+eBqK8/Vr2ePXB6tYT/z5VczlGstC3Sa001mjbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750344934; x=1750431334; bh=9mU/Dq7WreUH0bCPwnz3LsmXen4zYhRMOB9
	oJV7pjOY=; b=gAWtFNhEJspimlLKoLkoT0khjL+vJw8B1F5lpsDs5mpw6gL2g+Y
	QjKExe6hdlakLxJrACLbVRfbXU5SCQ9i1GLxzShSQXsxfn+PH+c5gbz2fbQYNNbw
	UBGib5OF08xxYfI57P5HuoVszKOFpHtzp0Cb3mbQSorPUpVrUpT5O9bzaWlymSfm
	i7Dg/dJzgL4+62YwKQQ6518jCzPhp0boZ6L0z/t4lj1kmGlOsRhtc8Yj9pqdQLqZ
	kHIOxTtBpiaVdw8ARbhGrmP+SW7mVty/Mi3edBQScJcgWih6zAvfMEU7fkoaSk4K
	PxJvQRm3DOQvuGdG43GdCvf2PPjrATfMGcA==
X-ME-Sender: <xms:5SRUaHXQsTlr1LpOjkSFxB80vZlFssla3YVBB4O3uYDXmciPJNh1Pg>
    <xme:5SRUaPn70Dt14nqG_RYBbhhdQwV3NuPTioWutNFdh3lJtoddepdVwPsFfz09LrSUv
    dc0MD87b2P4PfsQyQ>
X-ME-Received: <xmr:5SRUaDZXSWlVSQ2AJ40qT0Lhsnn7dPjl69GOmHQ6CJwTua71ec3igQFd38PFqTK7nFe95xh89-DnCec5me3L_ZKHtbcamUEhTRGm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdehkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieelffdu
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehpshesphhkshdrihhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehsrghnuggr
    lhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehjohhhrg
    hnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopegthhhrihhs
    tghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:5SRUaCUSQDcDhDHWnsc4Sb-3HFyXlLPUUwwvoZphx5TLZZO1PkXOWA>
    <xmx:5SRUaBm89CIyece5YpYrPrgpUTfDkurT5nRjEa4JBm_BrzVsXuDFaQ>
    <xmx:5SRUaPcoJVlC3KYx4FaH_l9m8lxfW1vtKLIV6D-URDPAop24b66bgQ>
    <xmx:5SRUaLHs8b__LLzaoCYLuIMkjqxuOeLsNxFsVZlCk9yAoIfGBeWubw>
    <xmx:5iRUaOk30e9-HSeTyJKjTpjxcRS7xrBYBsBHFcvT4MfxP4PFmHYWU36u>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Jun 2025 10:55:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Elijah Newren
 <newren@gmail.com>,  Jeff King <peff@peff.net>,  "brian m . carlson"
 <sandals@crustytoothpaste.net>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v4] fast-(import|export): improve on commit signature
 output format
In-Reply-To: <20250619133630.727274-1-christian.couder@gmail.com> (Christian
	Couder's message of "Thu, 19 Jun 2025 15:36:30 +0200")
References: <20250618151821.528627-1-christian.couder@gmail.com>
	<20250619133630.727274-1-christian.couder@gmail.com>
Date: Thu, 19 Jun 2025 07:55:32 -0700
Message-ID: <xmqqbjqjdbmj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> This v4 is just about fixing a few bugs in the tests using the SHA-256
> object format compared to the v3. (I had issues with CI tests on v3,
> so I sent it without waiting for the results.)

Thanks.

I am not sure if "I am happy is either 1 or 256" is what you really
want, though.  The test presumably knows what algorithm is being
used during its run, so wouldn't you want to say more like "I know I
used sha256, and I expect seeing sha256, ah, I see sha256 and even
better I see no sha1, so I am very happy"?

> There are no tests in this v4 and in v3 with both a SHA-1 and a
> SHA-256 signature on the same commit though, as I am not sure yet how
> to best generate a commit with such signatures. Suggestions welcome!

Good point to fill potential gaps.  If we had such a commit, then
would these tests say "I know I want both 1 and 256, and I do see
one instance each of 1 and 256, so I am happy"?


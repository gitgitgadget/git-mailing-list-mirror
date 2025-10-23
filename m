Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893A526E716
	for <git@vger.kernel.org>; Thu, 23 Oct 2025 20:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761252862; cv=none; b=I5YDhxsgpKxw9nvVXxhVDXq5RUmZ7S5TtDxmSNaJ7hLwH8BZjHXXbBsDhEtIPOd7J7El92d/uXGc9nMNPT5osU3R4MKlScupAWOMYBWjjOPOr0vQvrwEL6QE9tT/WHR3LI5dwS3J0YvQvzoi8G4JADt/gdeB9cov1kwlefUTa3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761252862; c=relaxed/simple;
	bh=FryzU5/4hzAHYy4DG31mpXnjOBMheL+nEfD4umfvzhM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ErEFIk/g6srMuJ9xO/MzzEsdDXGUi8rRjvaHlFoDN8CWYoS+Oerz3P5TujXKZ7Zk+/YN9nbOvpFaHohxwrEtpgMDX7tN+TqwbMOPNcoCuBBVBbjMDcexr2qyI2/i3xDBvLaxAKS9z0T2QSuCLchm3A7wFAjrAXypcApeuHngUvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RIY1OANi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KKDbg0+k; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RIY1OANi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KKDbg0+k"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9C9627A0126;
	Thu, 23 Oct 2025 16:54:19 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 23 Oct 2025 16:54:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1761252859; x=1761339259; bh=1/qZ/FDoQg
	dedlKbLy+moMwYFze1OyY8pH/m/BuOBEY=; b=RIY1OANiS4YkmlRugp5XWq1G3Y
	y9/ATLIg9ys3KXbuglb9WDxZB2rZG7vxeEs/RqSv7qWuPrkrX39iNs/an1NHENm4
	VW8wG4WgABSj1mASJWAlncWSo/ZKM3Hkc9uktl6gPQBm8FyxPOdw7lPibpmUwPdh
	HomFR+WImvRimoBEhFpRGMHvHKnXy2oO4XfjC4zD0hv5y9Zq4/iomML08UDos/Y4
	B7K8BGhB1iJ9E5ZUT8poUUv88AHEjoSi3QWHMChZmcHf9Gb4J6PoXz+8niBCvWiN
	8E2E1iQ7R37zxLXYjSq6Da0ZXqVt9p0zxPPHbm2DdGnmtHVK6GYqsshC0Ztw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761252859; x=1761339259; bh=1/qZ/FDoQgdedlKbLy+moMwYFze1OyY8pH/
	m/BuOBEY=; b=KKDbg0+kTaQzn+ank/GmhSpAuSCE2oCdWORDqnkuQquaWJFyuXw
	zJCgyf+rp2vmsn3ym9NRXuRJxlWxUmAG1BF+VWEsFdptA8TMTFiKeVh90ydyyvqw
	eBv7TC4tT4BtIFglC1LLhwNA/CANb8HYisR2QC6tOT/qIvuLhgTVfT4blVvc8s3v
	Xx3oGaDiCa5eiNUpKTGAfmIqseBVPj7WzaZGawzY3jZgzcLH/7hNdLUJ2u4q7bPO
	IZosarpdi6LwvQ90dT0BzF8e0ZEKgPhj94YxExvoxM3nEG87/FgMsEhjDTkfN4vf
	4+rs4OQ45ccg3tdTkFntcINOxBQ/1ltylsw==
X-ME-Sender: <xms:-5X6aArD29dbntFnxpYm89As11sBcLdWl9X7QyboY68IW1tLoBG5uA>
    <xme:-5X6aKVIdso_l7h6wg7i5oxjrBpZRHg168eXcjdb8LzE5qxSlLlVy3yyn1dTAzZEY
    A4J4-0eNh6fYLOM0pjuUuljyT6q5cNbzLeAoNu0mq94hHryek79>
X-ME-Received: <xmr:-5X6aPCGgNDGmqpn5YJ5UeJLiINs5m3_svpXeFWZ9TOAL0G8e3LQPWwuZVAMmQrbGXbq189_CGcj5HmUGsaNKvYfeddu306iwanY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeejgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshes
    phhkshdrihhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:-5X6aO2DIqkcZIccQ9K-RE9tC3F2jgrkm-cfmQNFROfrCL-I41eC6Q>
    <xmx:-5X6aB3pKpH8HybSxde6kCabnu7VncCbex0t1Q8u9z7r64pYTDKrxA>
    <xmx:-5X6aDBuofiqGpc8C23ElJzpDa1MiO6vA1XUUey7pozgk9cGJuy1iQ>
    <xmx:-5X6aA6BAyi40nblhAOHtHfbldrcMmlDdi4LO7C-EDbYzX6kBkzmcA>
    <xmx:-5X6aJs9gdjWYNcPyZ7LwHTtrOpjAdqIWq0rkinJXBSmrdpatp_M2SvS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Oct 2025 16:54:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  karthik.188@gmail.com,
  sunshine@sunshineco.com
Subject: Re: [PATCH v6 0/7] builtin/repo: introduce structure subcommand
In-Reply-To: <20251021182601.2687284-1-jltobler@gmail.com> (Justin Tobler's
	message of "Tue, 21 Oct 2025 13:25:54 -0500")
References: <20251015211213.361797-1-jltobler@gmail.com>
	<20251021182601.2687284-1-jltobler@gmail.com>
Date: Thu, 23 Oct 2025 13:54:17 -0700
Message-ID: <xmqqtszps5ja.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> In this initial version, the "structure" subcommand only surfaces counts
> of the various reference and object types in a repository. In a
> follow-up series, I would like to introduce additional data points that
> are present in git-sizer(1) such as largest objects, combined object
> sizes by type, and other general repository shape information.
>
> Some other general features that would be nice to introduce eventually:
>
> - A "level of concern" meter for reported stats. This could indicate to
>   users which stats may be worth looking into further.
> - Links to OIDs of interesting objects that correspond to certain stats.
> - Options to limit which references to use when evaluating the
>   repository.
>
> Changes since V5:
> - Instead of using `filter_refs()` to get an array of all references, we
>   now use `refs_for_each_ref()` to count references, and setup OIDs for
>   the path walk, in place. Doing this not only allows us to avoid
>   wasting memory storing all the reference info, but also to display
>   progress info to the user while iterating across the references
>   initially.
> - Add a prepatory patch to export `ref_kind_from_refname()` via
>   "ref_filter.h" so we can reuse logic to categorize references while
>   counting.

This round looked pretty well done to me.  Shall we declare victory
and mark it for 'next' real soon now?

Thanks.

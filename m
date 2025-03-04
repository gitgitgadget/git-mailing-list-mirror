Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425E624EAAB
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 15:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741102246; cv=none; b=O1lrBABYX542Ck9xz3FRRZgc5xzSrBxcvyXs+WbXoaplXwHHmZYEAXmOl4kMQRSeQ8n5cnyJRHL5vOV7pmaD07g0QkeBIAhnlQ7HZ0h+SePwOU/OfQNVZE9sUYRd9c5uafg10NO3SwK+cO4OiEKfItjtR63vEgXZv2ELF/BXrp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741102246; c=relaxed/simple;
	bh=VniPtGh6+CFgYdzwWHPaVuY7z24s5NhY/1UJ9F9Qfpk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uLK9C5QFsrUvFilSp0/CNwz1gXRxCjHWPISBigT7Ne4m9USrbRCxLqwPCrRFFJeZ8YtUpKf0W9kLMh3WzXRVSJq+Yt2/arf5V/GEH79lnj2RGseMMBhV4NUrANwJjNpflZW/oR/As3qrfobKWR5QnE12wAnAE6J8nsGiWTWWbLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RewcS06Z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NM3ewkWz; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RewcS06Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NM3ewkWz"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 38A0B1140235;
	Tue,  4 Mar 2025 10:30:43 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 04 Mar 2025 10:30:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741102243; x=1741188643; bh=BeTOgLrYGe
	ojt2hlgz/QZA5LYiePtQ2H/9dTi0T4x6Y=; b=RewcS06Zx6mvgoRXkmHfnJRAgV
	9xIzacP19YFims3q0hMgK0QUf2Ao8TDbQxElkmQhgl6JtO6ZzAn0tG97Jd1+lhhJ
	ij2REp3H4+cSFOyyBbQ3V1vb4i/0q/4EY/X2KlshevFQ4Xi78KDClT0BLfbazH/i
	meJJT6JBpQ0ynVjtxojAU6jptgucKw164197XpgzdFKN6FPogPGQG6/P4Z/Tdosx
	dhBfpM70GM+66EMxthGxrDEW3NRB0oZyEez6/GuwwtddS0up6kQWC+eA1lc0Xvgv
	cZgZAEYXzTAuzvKa2lK4ko6AkGSEkHxs7GgUA8/Jk0dImgNpImu0JKzG2K9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741102243; x=1741188643; bh=BeTOgLrYGeojt2hlgz/QZA5LYiePtQ2H/9d
	Ti0T4x6Y=; b=NM3ewkWzfumyZ7w8VpZF8DnDLp2CE+dm3/3DUKj6wwv5XyHfKTI
	TRM9YNRAeVbeGzSWGlZYnmcnGWFZbyBSpmpb+/ERic9Ceb4AJjziEcckOn32FstU
	bJZjgwaWt/OhTROUZQMZhzmmQ+28yzX5J5BqyFSvjf2T4LaWiksvAwuKDg2+rjUz
	NakG7+guVlf9oGr2xOq7bxgYnwx5QI9Dylyh4lS+nvsQCJd/pmJ40XSD2H7ihUA1
	SDQQRa9D5Wlkgqax69hBi8283dERvhFGpNuJ4u0g/QlBjeDj3fqw2qnOZu12TNPj
	2vPrc11hQbihsqwQOegwekDVA1R+IG2cFTQ==
X-ME-Sender: <xms:ohzHZ5yYCbdOQZLAtkmyv2wy8sbfSKv8hkerKF7RRb7eoXiWeki1ug>
    <xme:ohzHZ5Q--M3S5Jq3QZx5v7Zk7ktaLGU-SYdfGF3rklpnU03e-2KPodPn8us5hx9LI
    Cm8XfM6RCjdBsQa7Q>
X-ME-Received: <xmr:ohzHZzX1u7ogw6XWASAmHrSQik8jL9EPtHdEJWks57vgPMBw4XRlLvAcvGqO9z4HO7EDePNjlK7lvhs7AS9qP7I7veuj6rdzbGY3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddvgedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhih
    hkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:ohzHZ7hxFKgOfROgW-ziVcTIL1Veky4sXFMKzfzN2W-wrRu5Pnsb8g>
    <xmx:ohzHZ7B_w5BWQM_EN_e9tc0FBpf4OUcnRfY9OFfd88EdSoEGYkDIMQ>
    <xmx:ohzHZ0IaHB9wnv9VnAWPLhS7xw8TbxqS936j4z35DK4CIB1vJxWajQ>
    <xmx:ohzHZ6ALBGJ4R73RC4NyuEEje-1694O2AwoSA0ySxczOMusdkow7YQ>
    <xmx:oxzHZ261JuK5gBPcMjaPEGU_oBzzL-eMicr-grngBy4mYcFWpsFc6xsr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Mar 2025 10:30:42 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: shejialuo <shejialuo@gmail.com>,  git@vger.kernel.org,  Karthik Nayak
 <karthik.188@gmail.com>
Subject: Re: What's cooking in git.git (Feb 2025, #09; Fri, 28)
In-Reply-To: <Z8adWTssWtaNTfx4@pks.im> (Patrick Steinhardt's message of "Tue,
	4 Mar 2025 07:27:37 +0100")
References: <xmqq7c591sus.fsf@gitster.g> <Z8XJnJEHZd1dFE96@ArchLinux>
	<xmqqldtmvyfa.fsf@gitster.g> <Z8adWTssWtaNTfx4@pks.im>
Date: Tue, 04 Mar 2025 07:30:40 -0800
Message-ID: <xmqqbjugu82n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> So while I think that executing the command in git-fsck(1) is a good
> thing overall, I would feel a bit more comfortable if that last commit
> of the series landed in the next release cycle. But maybe I'm just being
> overly cautious?

Anything not in 'next' by -rc1 needs strong justification to further
advance during the cycle, so by default it would stay and cook in
'next' before the release.  I have a handful of topics in mind that
I do want to see merged before -rc2 but this was not one of them.

Thanks.

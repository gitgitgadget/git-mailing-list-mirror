Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FEA33E34E
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 01:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776649849; cv=none; b=mvy3Lq4s+azoj2JfUAXsGMDjgVluC3YnycCv4F8vKWojN57NmdDMFrR1r2m7vjKeHeQw+4lWEoEEORwXgv58nwc/Vkvr1xZwHcLvHzEJdiDAa2EGoG+RIq+lvhf3kgdBZIMo/yiOVRpIe7z6Ywhih1E+X+tJehUCY7zqQdSksTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776649849; c=relaxed/simple;
	bh=xkHpdydmfvBbLJp4YTsf2v/jgSft8VE3oxjkT5ZlAl0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PNJAZx7nxkBQfSK4zE3RPTAQx0w88lI+zyiiCJTULpS1UalMbdnVKbS+Ppfo3Z/Pq/pJdAhA41Jw7cPCHDqAQfGYaaSC1LTREIOPZlFlLLKvpc7TX9xq0bsWZWqTKN4JhdwsKYbjAQkBfSXL3QVcTQ+JNYevRlEr98iHqXq20ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UR+p+zUb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Em3yDG2m; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UR+p+zUb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Em3yDG2m"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id DC2E61D00016;
	Sun, 19 Apr 2026 21:50:45 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Sun, 19 Apr 2026 21:50:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776649845; x=1776736245; bh=ADfq8UhqMS
	eGC4bh9ZEURvESQGm10BoJAidUwO7jQoU=; b=UR+p+zUbYcqmEra5FNbGZVtIl7
	s9j4Bm2XEEVtM1dbBPihgZoj8qVDUwSFz2ivGtiruuwrbBgpxSQnER9bzzBYjG2m
	yNufrKZrcdCh1/KK3OBOEfS9RqtWCyRvOLnJdEz6aylYxxv1kEeVJpB3irIe4/dJ
	4VH/o08/5mXqmVS0tk0DuWQX7TWVfifobb93PTv+hfSB9v7iqvyvhXvuf6tzkcgF
	pBwE7anPI+xt7T8XjiqtU/hfzKl4utgO6tYvr4V19N53fOX+hjtjaAejA1ORohYn
	zqZVC7xVrIWw5+/rTlWi+uEuoWuOx9EpGtRaj1lCmsoYDHJ0Az5rkxf8efAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776649845; x=1776736245; bh=ADfq8UhqMSeGC4bh9ZEURvESQGm10BoJAid
	UwO7jQoU=; b=Em3yDG2mJpV24ceCKf3CAp2+9AEVBt51XVHFRaTWdOxkNiK5Nb3
	vhlzQNABCNxTv6xsjRZioSFbep2NL+Kj9+/lJIJoQT1/SjGY1lXR2ydfAWQjEjxL
	aC4+hmpDwNk844DHstrCmBNgZ3aXqLtkZ2F7CyNxZkBqccksAp8MfcyqUr38OQmE
	/pMHHfwxixtyXGIqMITJdGylu9LNkZGyCeXqZjYxpPRIlEMVg02x88Zzptkk4mKj
	PYGX1S2JVc8tvVi605gulUnwlHygIFFEPiFtdwbz1oiU7uP6TPPhudrC0ty4W0E2
	GUcmYsaL+8JbBJIE/YuI7tQNh8BLXoTq4Qg==
X-ME-Sender: <xms:dIblabBRrf1HUJzFY91tQspf1RYxBfMJHXkuGHZb4QbYQ4k8sbJmCw>
    <xme:dIblaWed_LX8pYJcOe_4M26RQpByW4yWpFKTzMBEdu4zqDqglVic5ZjSz4_T0ygf6
    J_HAYpgSDIkpUQnSN6wB3SsHdP5wxl85zT1IfDnPP_g0dgboT8L>
X-ME-Received: <xmr:dIblaa2-bWAEVes9ZAxXe3gPSJh3OPT738wXUdU9Ys6lyQJBe0_8_L3wzcQSa3Qf8LrSeQv888eZJbJYkzpv-ENKqkzu8HhyGg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehjedvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehijhgrtghkshhonhestghhihgrrhhkrdhgrhgvvghnvg
    hnugdrohhrghdruhhkpdhrtghpthhtoheprghskhdoghhitheshhhofiguohhirdhlrghn
    ugdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eptghhrhhishhtihgrnheshhgvuhhsvghlrdgvuhdprhgtphhtthhopehgvghorhhgvges
    mhgrihhlrdguihgvthhrihgthhdrphhusgdprhgtphhtthhopehlihhsthesvgifohhrmh
    druggvpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdr
    uhhkpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:dIbladhTJ4dnUgNXl_jIU12i8w2b7nMNxlI71JkC2l5Dy6m8-XHIAA>
    <xmx:dIblaTm_OUWnrMdnWKwFB2UJv5CXzmIsx-V_k_qZCVpORhwOnQxNuw>
    <xmx:dIblaTaIu4m60Ly28uUYDmvOrmPmIT32u9IibdSWZ7Y5ljd7y5HZ5A>
    <xmx:dIblaeG7p_q1xIEHIYBPHWCLrR8a7sajrYI5pmxX6uHRFexSny-B-g>
    <xmx:dYblac3UyTyiRlINOBo5y4KIMPEQGnWRxJnY6v2UcPcSlUh-iJsxMksK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 Apr 2026 21:50:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ian Jackson <ijackson@chiark.greenend.org.uk>
Cc: Colin Stagner <ask+git@howdoi.land>,  git@vger.kernel.org,  Christian
 Heusel <christian@heusel.eu>,  george@mail.dietrich.pub,  Christian Hesse
 <list@eworm.de>,  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 0/3] contrib/subtree: reduce recursion during split
In-Reply-To: <27109.13129.424068.382997@chiark.greenend.org.uk> (Ian Jackson's
	message of "Sun, 19 Apr 2026 20:55:53 +0100")
References: <20260215201748.889866-1-ask+git@howdoi.land>
	<20260305-cs-subtree-split-recursion-v2-0-7266be870ba9@howdoi.land>
	<27104.58166.993109.63505@chiark.greenend.org.uk>
	<a1a07433-224e-4477-ae8a-3875fa98faf8@howdoi.land>
	<27109.13129.424068.382997@chiark.greenend.org.uk>
Date: Sun, 19 Apr 2026 18:50:42 -0700
Message-ID: <xmqqa4uyv1ql.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ian Jackson <ijackson@chiark.greenend.org.uk> writes:

> Colin Stagner writes ("Re: [PATCH v2 0/3] contrib/subtree: reduce recursion during split"):
>> That said, a native Rust version of 
>> git-subtree-split would be much faster and easier to read.
>
> I prototyped something along the lines of the algorithm I described
> earlier.  It is very fast, as expected.
>
> The output looks plausible when I look at it by eye, but there are
> some things that I need to look at more closely.  I should think some
> more about invariants and tests.
>
> Overall, I think this is worth pursuing.

;-).

> Before I go much further, how do we think this would best be packaged?

My preference is (as it has always been)

 (1) host it somewhere outside of my tree,

 (2) replace contrib/subtree/* with a single file
     contrib/subtree/README that lead people to the new location.

The preference is not limited to subtree but generally applies to
things in contrib/.  I prefer to see them graduate this project and
stand on their own, when they do not have storng dependency on the
git-core project.  From technical point of view, this is especially
true if your plan is to depend on libgit2, as it is not our
dependency.  Back when Git was very young, it did make sense to have
related-but-not-quite-Git things (like gitk and git-gui) shipped to
give them visibility, but we have passed that stage 15 years ago.

Thanks.

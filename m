Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26CF61FCE
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 22:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758149288; cv=none; b=iqIRcc20D51zhzNFkrX2X0/Pbh8RJkFBN95BXZIirL4eCpyG9FzLkzt82/Al6etsiAge13qReJdjsVXPEFmpx8J1eNff5KlsEShU4c/B4t9D3axZih/zSlhXcp1ML8Vi1/BskfUiBziToY6eBTvfhkY0CbmoA4i+zMFTKftutxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758149288; c=relaxed/simple;
	bh=1bnvT56WC7PSVYZC27yk3XG5rNBKrZ+00r23mL9wwcU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O5ol++ould7eAQOT/QZ7NFjI3l+mAhcql5pFdI4XlFbsBUjBP4eGelZxT388TErGhk5MyuHuPNPtIZ9NXw3QAH/z6MMCJo4J3kG1LdFh2Q0QQ1IHT36lEcfy8mF72Nib3fGzswNsLsFRBX9sWJ2UjsUEs304N3yEQrCTrMAUrVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kU+OOks1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BvV80pj+; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kU+OOks1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BvV80pj+"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0B8B9140023E;
	Wed, 17 Sep 2025 18:48:06 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 17 Sep 2025 18:48:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758149286; x=1758235686; bh=DNRrGOITtO
	ahYIf5AoojrneRw8cBiLWGbpvDPuQgfVg=; b=kU+OOks13NvnChX08OVTh+uqiX
	F0Hduy1iCqgo+BhKF72U7PdSSz5tEYwAHs2bdyHk0TOt+Af9y12M26aK5Z5IgFP7
	V0oBXUNOAzFfp4+Mqu8YstRe2q8cKxXavzzt35RA+ZbsEjJHMMCd3bsvlJsmlP26
	ZpdauRnGv2/sm3EgGW8h6lv0rA5hy/33I1HW89mePbvPUZszXpA4+qHHTNe4MiDd
	Wr5+OlyeZvO0d2VR+VIuw5HCAbIGbgqtl1BMXaYyn22yaQZFrKsiy4yiPgkC+rM4
	IyFxqcmBVhNVD0WEQqGEpkxzjs+s5MywwXpW9J7tUTvHAP1oGCv8/QfCBvmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758149286; x=1758235686; bh=DNRrGOITtOahYIf5AoojrneRw8cBiLWGbpv
	DPuQgfVg=; b=BvV80pj+uLkGcwdCZ15SFVMHl9x6Yoj4TvTYBGAAz6m/NbIfE++
	4tCgEShWOXEj35kMVDignbFyesG48PZmCUzzOalGxiOZuZm9m3E6zg4t+5qBpZyk
	Dt2KBrCGO8a62tuRn8n4oh3Zey6PAWKwVXL6qUGlsDQPeH07EeF9Inah6zNQwD+h
	9FxIq7c4njqjGDjdfH26JZOwoUvzlq32N0k6875McWtCrqEvkq73Iypntg9jLFBL
	zdFxCJYeOJsLwuL9jhbUWSXsU+swO3ZUANXtXky1o12+2tcOmCsNPPtdeLwyaeTK
	LimEeW5/uu18K1Rmpc/+fYJJXwlT1DRHcUQ==
X-ME-Sender: <xms:pTrLaEQilXxP4BmcoOUhv4c7kgAmnj1RArrFOxac7Gj-ie-rAUvHUg>
    <xme:pTrLaKMJvN8uefqC_wue3tjYV0Woi_Put8BqdrwzT2Q09duC9rrO2hgfSFkdWs6iT
    ZG3HFRaohhmnD5gjA>
X-ME-Received: <xmr:pTrLaCT86VPF8yxYIS9uTSCciMKg3hbcNLcgnTyGF_oOYB8tDGmtP5eB22_3j932C580POEm-yH47V3IqXklW1-aDXEQACKSkvwuX60>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeggeeilecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgiivghkihgvlhhnvgifrh
    gvnhesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:pTrLaIiCzgIXpXQ64ac3YfA422qX2ad-cXw96-vYzUaO6qeYXrYtAw>
    <xmx:pTrLaL_iw4-L-mMPYYklB-7zehTxcS8jFfYecvI5ge5J98_HX_bRBQ>
    <xmx:pTrLaPGbO-yBW9V2AEXZEWLy__rPmfp8rr_3W5T2U-b4h9k1ydDnsw>
    <xmx:pTrLaOnvdeLIKhbGwPK3Z_zdNnRqxHUQmBB8JfueHHBChNWKH7WRpQ>
    <xmx:pjrLaK0b0Y9bFTtRMshMhQJ6qC4UcugK7hCOHdsShLqtWx0nV0OvsIKw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Sep 2025 18:48:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Ezekiel Newren <ezekielnewren@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 00/18] Introduce rust: In xdiff
In-Reply-To: <CABPp-BHJUkSERQon6xx=sHrhN7i=6ekv+Hz1+P+2mh0=Xw15Mg@mail.gmail.com>
	(Elijah Newren's message of "Wed, 17 Sep 2025 14:34:55 -0700")
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
	<pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com>
	<xmqqcy7pc8ix.fsf@gitster.g>
	<CABPp-BHJUkSERQon6xx=sHrhN7i=6ekv+Hz1+P+2mh0=Xw15Mg@mail.gmail.com>
Date: Wed, 17 Sep 2025 15:48:04 -0700
Message-ID: <xmqqy0qcae6z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Elijah Newren <newren@gmail.com> writes:

> So, how to move forward?
>
> A) Modify Patrick's series to just take patch 7 of his v5.  Patrick
> did say that the roadmap was  "the more important discussion compared
> to the technical discussion", and merging that patch would achieve his
> goal of getting an initial roadmap.  Then Ezekiel could grab other
> pieces from Patrick's series (e.g. the help and varint stuff) and
> incorporate it into an "introduce rust" series.[*]
>
> B) Merge Patrick's series and tell Ezekiel to rebase, while noting to
> Ezekiel that the roadmap is the important bit from Patrick's series[*]
> and he can suggest changes to any of the other bits.
>
> C) Create a consolidated "introduce Rust" series with bits of both --
> what I think Ezekiel was trying to do with this series.

Ah, I didn't even realize C was what this series was trying to do.

I do not have particular preference between A and B, but I thought A
was closer to what was being done with this series, and as long as
Ezekiel and Patrick can join forces that way, it would be perfect.

Thanks.

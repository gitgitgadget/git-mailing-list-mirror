Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8EE26ED35
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 16:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772470379; cv=none; b=Ls4zZ9Lx9JY6S3zj3FBQbAXSXCJSKB+WRatAoWIN4TbLOT2FXtf3S3jtI78QA5RPzMBtw8+MAYazUBZaBfUfLHl+fFVS07tbz/183E177oQJxcsbVhQTj3poR8lLaipKpUFlP/x/BhxpRpNtVUtpSCbtS/mHW786go6kZGcU60w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772470379; c=relaxed/simple;
	bh=h8EFbybpZ2ko8GwcnrqgOwOwgvyjRF9hJa+xEHJssrA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HZ1iE+ZGCbNebP0y3uK8mUSMNciaK+VTPeN73wvjjm4bZzxeocmbd5FfDrWNkuUYoxWcQI/jS61A98H5kBqFa8sWd0j9eoBirEXjQlqckesHl7BMy1/MumEJDIbdhPlsHTn0tyn2uC/IsZ/Ywcgj9iP4m1saD6yfLdYowgVXXd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jfFvORzs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uOOi5Q8H; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jfFvORzs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uOOi5Q8H"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id DADAA1D00228;
	Mon,  2 Mar 2026 11:52:56 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Mon, 02 Mar 2026 11:52:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772470376; x=1772556776; bh=aJBtuvd71F
	fxGUrsvTKA8kGgc1IipyVqmvzEs99pds8=; b=jfFvORzsF6hoOwi9IYUovXBUUW
	/k5eZQrWHUPVbOcDA1HEJK61QPYZA77HGxxT+K3HUwJJ+s40cxz+nE+XGV+ACMES
	Xmfu4rIuZJa3abRE9meY8DHr2I03NdjTSKA40BvczkV+v5CEzAl7c3if+EAB0xAd
	c0y+avrRGsq8xDsNnhJI9x+6VQKxXDoEvDefuRkI2Luj46w9Ki5ruINSQYPTWdRj
	GBWplN7e1YbBm1lRRRB4Y5K7PHAn85xejehSdVuadUJJO6K1tRFM8k2APzvHVa97
	cLi0DpAWGN0+gDWLR7fJnzIBkCeS5CRW3EnRddrXCy1wNBjSHYtvgzCDBjiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772470376; x=1772556776; bh=aJBtuvd71FfxGUrsvTKA8kGgc1IipyVqmvz
	Es99pds8=; b=uOOi5Q8H0WS57PjPjl53blbfwRCc12fIoI4ZFpRMP654lPe+fw7
	XhAa9p3L+OIulHP15vNULPxttPi6xV8NFkDc34EsP70r/51nVerAAha1I0ycaMi2
	9E4g2Ge0yxYjlMjpePfHn3NyCjKi4+HC2nF/KDgx2tUO0IXPRyja4fH2leSU0b0W
	sRaSpRihJ1m7/bRKjF5jaJwudiLb2cWFb3iz/CiXBhKQVpri0A47+SLYaF7ScmrG
	ba2RNrex5bIyDP5NgwitNvSJkk/35tVTTyXcxZREYV8Ki4A42ubRLQdUVZEkR3VR
	hj4Sr1YaOlY9HXYzbnEO7If8YFHraxpzQTw==
X-ME-Sender: <xms:aMClaa4XI0Hf06rn6l4xJQ6cJZj50M78gUBA_cnh9iOnjFYul9-6yQ>
    <xme:aMClaa4pzl4P4gaHFzvejFPHVbaze4LyESOkM3UspTDlCd6eayfknQI0hgIPEnjMP
    ncN3IJ4mbCSG74t7OLA4gi2nrIWLt9ZsfGn-5k6YfLZppIsHmx9Vfw>
X-ME-Received: <xmr:aMClaecgjFVgawahAYne6N2lRvqLoDnYmuPmopVQWViYbyPqAS2pLsooTaLQ5hF7uh8ClmkvqCQm9nDa00tc3-HOdIIxTM4COg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheekvdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohephhgrrhgrlhgunhhorhgughhrvghnsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:aMClaWCaTdL_mM0Hg_eS_km_DxtCpRRztSksoL1ulvzMzccnDvXqUQ>
    <xmx:aMClaZ8wfoFJIVQjw1kdqksoSUaz8TtmeMZ9ECQyUI_eCaPzCcRDYQ>
    <xmx:aMClaZLbk4WXNUbtFIXOJ-SBlb-hCxpdu6Np938u-nBW6iKwfCk1ww>
    <xmx:aMClaai8vEVPnuI-4VHoQcOoQxQob4R42ja0ZtyxHQRhNAm36WydIA>
    <xmx:aMClad_NA20gDPUw_QnVCd5zX6KQWxvf6cF5gtirPikB4NmZJCOCsWoA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 11:52:56 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: git@vger.kernel.org,  gitgitgadget@gmail.com
Subject: Re: [PATCH v30 0/2] status: add status.compareBranches config for
 multiple branch comparisons
In-Reply-To: <20260301190647.41248-1-haraldnordgren@gmail.com> (Harald
	Nordgren's message of "Sun, 1 Mar 2026 20:06:47 +0100")
References: <xmqqa4wv5xsb.fsf@gitster.g>
	<20260301190647.41248-1-haraldnordgren@gmail.com>
Date: Mon, 02 Mar 2026 08:52:55 -0800
Message-ID: <xmqqpl5m2mxk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Harald Nordgren <haraldnordgren@gmail.com> writes:

>> Let's wait to see if we hear further comments on the
>> topic for a day or two and then mark the topic for 'next'.  I didn't
>> spot anything unexpected in this round, but haven't had enough time
>> to spend on the test part, which I want to read a bit more carefully
>> before merging.
>
> Did you have a chance to look at the tests?

Not me, it was a bit too messy for reading in a single sitting.

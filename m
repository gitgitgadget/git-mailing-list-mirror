Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D2BBA3D
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 00:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728261434; cv=none; b=fixjBb4MeJbDumex56rNYo9IzdfKxmdMNyqGmdWG6gE0YIb1YggjmUS4Gb/hrDMfpk134POSHJ51ke293c9FSg2W4nlyaCY2IVr8G8FQYK9FCaq8DCe7hfktEnN9XB9g/CcS1wpttmTIwo3zogn0mfxM7IaiT+fppcLFhOIROQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728261434; c=relaxed/simple;
	bh=uT6rgJQ+CkoVdBGV/ZKE5ixNJCeks6naptrta0wsCnY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=adj2q/WftF8pS0JdSDKyQJETHca8R+6HSFr/Rd5zSbod4s60BXBYCebSGXQNMdB4fC1qKWcPn5GPkqWlY/aQww6ZsDxx/AjV55Qb+zJvw996pSxmRmlBSNwcS6Q0kL/ry+qqHKnSRkJvEZy4cRu3GN4q3W6HlfuoACuVg0e8nQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CIon0VDx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ppIMuh9p; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CIon0VDx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ppIMuh9p"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2BA711140124;
	Sun,  6 Oct 2024 20:37:11 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Sun, 06 Oct 2024 20:37:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728261431; x=1728347831; bh=EatwJgKkkY
	gBF3DeAnj1x/SbQEBoEXOypQ8VyIlwGPQ=; b=CIon0VDxwvtIYUTfMrj25TJeM0
	35osYrosVnqemUFTsGJF880ZrIXkZ7CB+MtxDPz5WdJxq5H/rZ7nQxALol+sQAgQ
	c4DNaKqI2fDcOpngErFC5bxjODwLchmCbPHDLUalal/Gp3sjN4vS0+vNKQN0Jq/Q
	NbJFR8b7zAx7YrBudRC2tSotT9l6AbXtPRj3I39c9MIdVkC9pb0aXsW+0ir6JiuH
	MmdTlU677gatTTJlj3WG/a0NAhCXq3wlO7ciulMQsob4CaCltUwqFKIE5qikuAa5
	1cg39DKm7NjSV64JrhqBH06vhNTvLEkUWVdHHwYjES8ddzcTUrDGAIBQI1bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728261431; x=1728347831; bh=EatwJgKkkYgBF3DeAnj1x/SbQEBo
	EXOypQ8VyIlwGPQ=; b=ppIMuh9pLLoe/vkL70kEFKJzuIxxzMxOspU4EldHLQkp
	eW7rQfwcqJO0shmQ7PeCX5zOAXkZOp49LBx+09kD28h5vFG9sHoUVV2gBU8xllqs
	QEqceG+CwWO+NxMrLk978kDoL2uAJgHImygLDmaVRYI4yxkU8FW5qegf5wBaoRAc
	38TNYYkVj9fefBZcmQFGAZk9vbuXIZsUw9UG6cDhiWTUSUBBBdg4ZlKLKV/TExPB
	5tg2GjmYEL21+6yfrxuLf7XKpZxAQ62dkXbVJuGDqWTy+E8f1Nm2wObIvsi92yFa
	7jgm0IYpMx2zcE6mIy5kBP/k2CJmwKhWBvUw/ZsDZw==
X-ME-Sender: <xms:Ni0DZzfLBfmbf-vXLjVDxZOyQjhl8f7PB48XzAzQh3PJwLrOTmnHGA>
    <xme:Ni0DZ5MMtYw4QyJHe3yy1GdhvIxC9tAqBjkE3AXhxMxhAt00j-T3NjilElRMW6-FH
    KjxphLsDlH693_wdQ>
X-ME-Received: <xmr:Ni0DZ8jERptn5VCVVNrVXdOs7rG8RiwiYpPz1Vy4S3dXWqcX8zMwT7KTjeD41j6ijPdvg0w2XsZIOf8W87PRR0DsWhHzWbV5bsbNsdM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvkedgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtofdttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepgfetjeegudevueetieduhffhgedutdejhfej
    vdffleetlefhtdevjeeuheduffeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehrohgsvghrthdrtghouhhpsehkohhorhguihhnrghtvghsrdgt
    ohhmpdhrtghpthhtohepvghmihhlhihshhgrfhhfvghrsehgohhoghhlvgdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptggr
    lhhvihhnfigrnhesghhoohhglhgvrdgtohhmpdhrtghpthhtohephhgrnhihrghnghdrth
    honhihsegshihtvggurghntggvrdgtohhmpdhrtghpthhtohepjhhonhgrthhhrghnthgr
    nhhmhiesghhoohhglhgvrdgtohhmpdhrtghpthhtohepshhokhgtvghvihgtsehgohhogh
    hlvgdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Ni0DZ0_lMM-YNPhPQVXu9c84gNAq0k6mo_Cgiocs78JHL6bPsCDXUw>
    <xmx:Ni0DZ_tg7khJinAP7ZESNUkvRc11lXQqIWICElX7XqwJQOURyZXUJA>
    <xmx:Ni0DZzFp68qG0H4Jrj9MYZOK7R-rbs3xlePiOYqmVDp2ZPa7PQMQFA>
    <xmx:Ni0DZ2Nhh9Dq91NZ7xyYJtPCiGtJISm1cAp4UA3SK0bUzhiiAxLjww>
    <xmx:Ny0DZ1Bv0Fysvpndxu8A8uid5LwOx4lxhxj3wU776tlo3DIghhC9_PWO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 6 Oct 2024 20:37:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Robert Coup <robert.coup@koordinates.com>
Cc: Emily Shaffer <emilyshaffer@google.com>,  git@vger.kernel.org,  Calvin
 Wan <calvinwan@google.com>,  Han Young <hanyang.tony@bytedance.com>,
  Jonathan Tan <jonathantanmy@google.com>,  sokcevic@google.com
Subject: Re: [RFC PATCH] promisor-remote: always JIT fetch with --refetch
In-Reply-To: <CAFLLRp+Y1hO6r7mfdghS0q3EyfJhU_e43Hzi9PXgF_EuF9Fuog@mail.gmail.com>
	(Robert Coup's message of "Mon, 7 Oct 2024 01:21:16 +0100")
References: <20241003223546.1935471-1-emilyshaffer@google.com>
	<xmqqset8c0o7.fsf@gitster.g>
	<CAFLLRp+Y1hO6r7mfdghS0q3EyfJhU_e43Hzi9PXgF_EuF9Fuog@mail.gmail.com>
Date: Sun, 06 Oct 2024 17:37:08 -0700
Message-ID: <xmqqbjzwbvez.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Robert Coup <robert.coup@koordinates.com> writes:

> Basically --refetch was originally designed to send no 'have's during a fetch,
> the original motivation being changing a partial clone filter and fetching
> all the newly-applicable trees & blobs in a single transfer.
> ...
> If a commit is missing that's one way to fix
> it, but it's a pretty nuclear option: feels like your option iv (terminate with
> an error) leading to fsck invoking/suggesting --refetch might avoid
> unintentionally recloning the entire repo.
> ...
> In my original RFC [3], Jonathan Tan suggested that --refetch could be useful
> to repair missing objects like this, but it was out of scope for me at the time.
> But maybe there's a way to improve it for this sort of case?
>
> [3] https://lore.kernel.org/git/20220202185957.1928631-1-jonathantanmy@google.com/

Thanks for your comments on the original story behind that option.

> I presume there wasn't an obvious/related cause for commit 6aaaca to go missing
> in the first place?

Emily had this after the three-dash line


a: That commit object went missing as a byproduct of this partial clone
   gc issue that Calvin, Jonathan, Han Young, and others have been
   investigating:
   https://lore.kernel.org/git/20241001191811.1934900-1-calvinwan@google.com/

IOW, I think how the lossage was caused is well understood by now.

Thanks.

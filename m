Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3889A95C
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 18:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737137186; cv=none; b=rylO3bJrwbGFmpNu0OaZFXF1Ecw1m9p0c1ScV5uzaEV9NoIU7ccaNYyH0q2zvaYFqxR+aT8+aX43lpuxXYsqv+RNXjuyBjryJteAqlnmCNwVQ3BB5ZqK8b19TatLvn+UhlHCS+6JpQpVWkg06rjZs8clXKCTk2iypGRn8w7+1bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737137186; c=relaxed/simple;
	bh=WaPmo3I73QiWQKGMAAIJWAAWB4FcgtTyA8PCpIEGyFQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dKOebd/9jXBWWxOzlTyVRIVzAPQitzaWotRd6F/YyWYq8xz8cd4KRMy3GNqYzF0Qlyphvg4qZRC0YxQmPz3Alr3eYckIftF7I7gemK/MV3dHxknpPLeusS36c70nalX42nAAfzBKUBLzbMJsDC+hcr8ONQZbZZBJGXsb9HGuIwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bWkkHbAb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i45dpj35; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bWkkHbAb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i45dpj35"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 9244713801F0;
	Fri, 17 Jan 2025 13:06:22 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Fri, 17 Jan 2025 13:06:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1737137182; x=1737223582; bh=WaPmo3I73Q
	iWQKGMAAIJWAAWB4FcgtTyA8PCpIEGyFQ=; b=bWkkHbAbN0KHz9ZGBgFXio7eQE
	kNpZWl44w4xQbpXA596e2Mf5PBGj9ik/t2zdv7Gg7ws/g0oT5XgfxCCPD0l8GnUw
	txOzdl8IU46Huyk/GA8IZDc5k/1X3AT4aPoPRzgBdXMrqeRS1Owlv25FVVF2HxeH
	osfVIhFY59Q5+806D21yNOW0oXZlvt7l4v/pZxaaj/JXXXDgx8kZgXaGoBylN27o
	gGLpdbYPrr0/kdVrWt1OLhmDpIzxtpofF09l+K6mGAbxahJQ3dR25fM0g4DQTzJ0
	Nx2gcwQsyUwknypgUv/DUdbYYNMtsbnRKcoIuplyJOZqja2jMJKY8lcrsQlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737137182; x=1737223582; bh=WaPmo3I73QiWQKGMAAIJWAAWB4FcgtTyA8P
	CpIEGyFQ=; b=i45dpj35tXiqwguJlx68oMv8K2RDz2ku0I7uPoaftH8HpD2gUCl
	pwK/gXgVe92kDh6MGi8zPsZlP59AFU3dAJH4n1CcDN7CuJyXNFIFskQL/j2OVOmS
	NNdYOGFS1PBKc2QUmI9Jxd6IusA1zQKRudwziUVZMS1ZhPCFMrFhjYTue+PUaiit
	IXs5TAPRq2iBvhapMVit+ZcM5atZIKI0wwtc06C3eHwnxDC4liihx8f1oMLShS8M
	Z8W+J6CB0ZwjMCt7Td+uPSCvkmn6/Om1XMQC8ZSgOT08PnfHHDMWb5mGZZRj0Ie7
	fr6LPvhrqLip384WZRxtue5e1BepyeaqKRA==
X-ME-Sender: <xms:HZyKZxJHHL1C5M5EkAJCU_nKrdhN5MvLhH9LVkKv-OUwTgqZupcPNg>
    <xme:HZyKZ9KKclWv2SS-JYOm4H2p7W9n9hh2P4e8Xcbx9s_umMUm4PvYKtpKHXO1lwh_m
    NxHi1ZJhUe_Pqhw7A>
X-ME-Received: <xmr:HZyKZ5sfdle_de64qqOsCtYU16Rj-OGxNAfkLYz6fA1G2M1ulXmJSqz2zBBO72QTXNhpynmNU4XEw46s3DGMlc-vZSVazFs5t1-4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeifedguddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtohhonhesihhoth
    gtlhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:HZyKZyYjeC-W9s4oBqDg90GrnknnEDYU7SBMmZa2Et_ULv3MTU723w>
    <xmx:HZyKZ4bfBr0GQEdwerc3dTANKL_SW8yJJ3u5J8y2bCqc3-SCcwFRGg>
    <xmx:HZyKZ2AsLm1NXZYUiJx_B5uTbUrmsyAm9-Co12Lzf8c-36ruHa5Vww>
    <xmx:HZyKZ2a2pJOHb9v9tguTOyYiwP-fCDQvqqySs_SBicV4NKd8CDfgcw>
    <xmx:HpyKZ3wLdaySwQZYsLOzJZY-LaWj4snIOabpluTekkz3Xf-oOEk1zNY9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jan 2025 13:06:21 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v2 1/5] pack-write: pass hash_algo to
 `fixup_pack_header_footer()`
In-Reply-To: <87zfjpiefc.fsf@iotcl.com> (Toon Claes's message of "Fri, 17 Jan
	2025 17:38:15 +0100")
References: <20250117-kn-the-repo-cleanup-v2-0-a7fdc19688f5@gmail.com>
	<20250117-kn-the-repo-cleanup-v2-1-a7fdc19688f5@gmail.com>
	<87zfjpiefc.fsf@iotcl.com>
Date: Fri, 17 Jan 2025 10:06:19 -0800
Message-ID: <xmqqy0z9l3hg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> The `fixup_pack_header_footer()` function uses the global
>> `the_hash_algo` variable to access the repository's hash function. To
>> avoid global variable usage, pass the hash function from the layers
>> above.
>
> I'm probably being overly pedantic here, so feel free to ignore me. But
> you say "pass the hash function", technically that's not correct, you're
> passing down the struct that defines several properties of the hashing
> algorithm. This includes the hash function, but also other properties
> like the hex size. By using "pass the hash function" in the commit
> messages (and not only this commit message) it sounds to me like you're
> changing the type of the object that desribes the "hash algo". But
> again, feel free to ignore this comment.

I think the phrasing in the title that uses hash_algo (instead of
"hash function") is fine, so we can use "pass a hash_algo from the
layers above" in the body, perhaps?

Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFE11C84D0
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 22:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753309596; cv=none; b=s2YPzPvPMh3FGZ5BsOf8jBh9ptIVdHl4OAN0l458sqVYSjerlOIrsEMr+RWp3wKFDmt8EKo3jjtpHCgfFopgenzWsVZRiiWAl+gycQDo+oI6EmAsLzOf82T9aTVTFSRILehY4jy5+qk1FqmWCYcziJXhtxbJNLH7elTkPxNdNwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753309596; c=relaxed/simple;
	bh=ECAToI4Kc9Mz6amtyuvEdA8+q4X8IUTF/hcPM6sfb/g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WyGX44cDzKsn8L7HNDdQZc3aFJR+OotMYVGO2qeaEs+XlLLy0lQ5q1/A7jqP96me1dBTlxa6zwFgLXCvJi7G1T+1jAZHZyrw+Uc56bGTS86LswHmCq3wnwAOtVNNyt2DmIC6aBB0MtlQgFKWg8olN3GsAOwMLzAII7TQd7tWffM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=H8LhVwXa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=joN+97Et; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="H8LhVwXa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="joN+97Et"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1572C140061A;
	Wed, 23 Jul 2025 18:26:34 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 23 Jul 2025 18:26:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1753309594; x=1753395994; bh=WwZ4g9V+Ff
	53Whqt2ZL8QdoL4ikQTz9DNlXDt6jJBZ4=; b=H8LhVwXaMEamC8IxPHXTA5GzvP
	B25jEPmyH+kGN91jFWOqjUwtIhHAm4xiDNjSb+CCRYpQxl23wjHbZhbNbBSMr9e8
	fhhIvsC7xYnji75uKFGULkEXq3n6HiAnl8OqF80Hj08VAfh+3Th4y9SpvkAQP5kF
	pClM+WLRFFYUFfY3GeuvOUl6ZlL8VMIdj4b/a59IHQlKcPa2YVgmWqAoAL0CtHuB
	F7GmD4pUuq8P9V4gTFjvPNYUgLwInozTzgpyelfvEqUvITmrG4fsRkpUntU02VXW
	rrrPCcjbqCAPxgyrKQDbFDUbrR5mbjUWz1u0nKpE1mGdhB6MFh/H3Y3KoRdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753309594; x=1753395994; bh=WwZ4g9V+Ff53Whqt2ZL8QdoL4ikQTz9DNlX
	Dt6jJBZ4=; b=joN+97Etju4xNQ+KFpexqteH7jOQXz2p1xYGj2HiYFbzMbJT0VI
	LazSRNAo/ZHKAxoA48vSv15ZOforKzkmMk3skQLKmxrNEH2B6pEFhlQ5skWwxIjY
	Z0Hm4a63KKs9Zci1ofHargcwoSkd1zg6sRDaellxyqMO5fEuF9xEotcD8kjJeBHT
	avuhfIpXlCTiZe4Wt2G3Dg/laYo1UmmaC2mzBPWLvRyyVJXK8zFGqmBpJMc/2yPF
	DV0P96k9DIwj6hqdvlOx17uizIfyy/V5mSM5WMbzDUCeMBIUqPTPYJsy/KScTnXk
	Ok99oqd2b/Den6S/d30lsyxRPfnPUVPmpnw==
X-ME-Sender: <xms:mWGBaLgr_JfKcPZFa6R3d7ifk_6WbZ8YXB1kYJxyVONYu-bNnCidVw>
    <xme:mWGBaAdICWyhNId7yiGR4j0fyNJlJDyybCAE5pYnafL_P-UXiSTFsUVw_b0xkZ4j8
    yir2i315cYWzRfkyg>
X-ME-Received: <xmr:mWGBaLhkC7MLoUzTvtoYSZuD-cNomWAdsuYB1gTwTYxli6mI9AuPBycnw1l3KCDqjumztcMP5MekddrTl8tERzufedc6jmJnWTmW55w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejkeeljecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrsh
    htvgdrnhgvthdprhgtphhtthhopegviigvkhhivghlnhgvfihrvghnsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvgif
    rhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:mWGBaIwBbUhqXj0zgF35qFOcAyxVkqLijXre4bmllsZCVec_nEOFcQ>
    <xmx:mWGBaHOPDSr96kp-6ZwiliHMEA9zLc-DuY70rO3cx0Oh8Rp2Lm7dZA>
    <xmx:mWGBaJXcsxw2v-wmfAKMLYSL2pEKomrKVZ6J5eNCWH1WXWVuq5Lghg>
    <xmx:mWGBaL3N7F4_uugT1FHLun7PLXOug-55Ij5R_m1aiiKF0QWQEt6-Bw>
    <xmx:mmGBaHUC7XcnNlCBdjyPG7vz-6_cJcZMXcCjax7PsIt-31SLqbQTEYiE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Jul 2025 18:26:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Ezekiel Newren <ezekielnewren@gmail.com>,  Ezekiel Newren via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Elijah
 Newren <newren@gmail.com>
Subject: Re: [PATCH 1/7] xdiff: introduce rust
In-Reply-To: <aIFauT8M0wRfaZV8@fruit.crustytoothpaste.net> (brian m. carlson's
	message of "Wed, 23 Jul 2025 21:57:13 +0000")
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
	<2a1f4be13dfbdee21811b7a4907f99042c791c2d.1752784344.git.gitgitgadget@gmail.com>
	<aHlrg7pbFqi2qNWH@fruit.crustytoothpaste.net>
	<CAH=ZcbBebM6CememqOUFY2YPOXpk_mC=zE0OnLOKDqcJQTdMuA@mail.gmail.com>
	<aIFauT8M0wRfaZV8@fruit.crustytoothpaste.net>
Date: Wed, 23 Jul 2025 15:26:32 -0700
Message-ID: <xmqq4iv2lf1j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I was one of the maintainers for Git LFS for several years.  We
> routinely had people come to us and say, "This dependency you're using
> has a portion that you're not using, which has a CVE.  I demand you
> update it and do a new release immediately because our security scanner
> is going off and our company policy is that there be no exceptions."
> This happens literally all the time and I absolutely in no case want to
> see those people on this list or the security list.

Ahh, the kind we love not to have.

> So the options as I see them are (a) we don't check in Cargo.lock, (b)
> we convince the Rust project and the ecosystem to provide LTS releases
> with security fixes, or (c) we only accept dependencies that have our
> same lifetime policy (which are very few and far between).  I know this
> makes builds unreproducible (although not under the Reproducible Builds
> project's definitions), but we really don't have many alternatives.

Thanks for a well reasoned argument.

Hopefully as Rust matures more, some of these issues (starting with
"6 weeks and it is too old to bother") would resolve themselves, but
until then we'd need to be careful.


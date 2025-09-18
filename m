Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581572D3756
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 20:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758227313; cv=none; b=EviNmEWkWL8+aH8Mbagdx6fDg8pwJlj9Ar8auaMJAhkD+Zb/b3tBe/fd64L7ZKa4dhPVY2fVWjj8L6VI3ty+ERaiCSyOG9uTlG6Cw12sd5oIhhVYYTtIFXVR76byfsqgFq+0m6NLiJ1uRPa3RNvy/iRo/Pjt0axT4j69FER734U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758227313; c=relaxed/simple;
	bh=rnDX72zTZx6VD1vItFiDmm0+fO8/gvclIUoefYsi/pw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fSE5cYDRG6YGJAiBv7Xovv6FfiNqsehPtSASvskvMybmmcOirUNnFMm0gl4uyOREzLaFTU88XJvoyfjNPuIHUO6Ldmcol++uQ/gFZux3U8hd4sHYr7rmrOMZAQyzBUEHit4oOufafK8cvPToSeg9T9Ql9eM3e6PerTaRrl9eeQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UUuhfO1V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L7TF38dH; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UUuhfO1V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L7TF38dH"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 5380AEC019E;
	Thu, 18 Sep 2025 16:28:30 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Thu, 18 Sep 2025 16:28:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758227310; x=1758313710; bh=QzQHByY4mH
	A5gqR3ELkQEI5sTdBDOcKxZDLQcRYzccI=; b=UUuhfO1Vi8IHaDVP1OpmHiqo3C
	0QhexXwqFSyurUAgAYd8rn6JBmBOKqH+u65oIY8kRC1JYeruvgVzQB6FSfhkt71o
	wSXeOGi+fumZkQrgVNvjdIwKSMt3bI0gC1RgQfndAJypXgo+hdVjIMltIvtfC1eG
	Ia3M3FgUsv+4NfRJIRe21VHdwUEDinvSFPyE4vRKhpXBtHGAeIswj2fJ8nHIXqIX
	ZzWFbXLIUhPlBd+AWMN4gNBaEObtIwucrdeEPjW0YQTvGOQ62n1uRJDcH9hC8wb/
	23Hnb+/xoSOB4+vxyZn6KdPNWsX/Fz62+pBOVAr6qpB/hi0suY8plqdwy9xQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758227310; x=1758313710; bh=QzQHByY4mHA5gqR3ELkQEI5sTdBDOcKxZDL
	QcRYzccI=; b=L7TF38dHDVllGZVC5hMcmPGAW6Hu7m/f55pmEP/1HZptgwj6QXS
	6s6ApI20ZMOIJ56KCuSlnBbc6BJpqgRXeKxbi9ozo96y1povNupPVKmlpxbqEZRR
	JXoitv2NCE2Rptl8mKJlFbqh+9SYaszOt+VZ8ybJot9PI8CC1dbMlxr3E5WUGBKa
	oS1h3imZaby1dxK0buSFCLRE4tI60B+/566AeBWbWUDK0GlP4MTTGuTnE8W1r9IG
	HNQnT3hWgbA3NMKox/rbCP2q/La8pgjy1vmV84ZqIP5uM/vOUVnsdzNQ86Lq4cWI
	bV8JH7Mgd2gaNake7VKkIvWwdL3sRNJJEaQ==
X-ME-Sender: <xms:bmvMaAUHZA1qaifLxbCcjXmWaOt4xDasQX8A-zltzbmdR_jvkg3seA>
    <xme:bmvMaAEOlANQXptZ_E_ZN6Z7QqwmX9c5oqun4i8a_cgSJRVgkaOlHk1zOrkXzbcGD
    8dmPJdu9uOBRmv3gQ>
X-ME-Received: <xmr:bmvMaK0GLNcI2VvMjtEbPKoeJkrHKTmwASCsvdK_LLqpoS0FZGJtGNe143Kc2dAVR_MsvezqcEY5vXAPR6ESefZexBZAqS2Y1ynE7Q4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegjedvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepph
    huvghtiihkvghvihhnrgesjhhohhhnuggvvghrvgdrtghomhdprhgtphhtthhopehsrghn
    uggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomh
X-ME-Proxy: <xmx:bmvMaKMCUI6BAupE5cNY-oka6KTdVwE5ijXqOpmPnsYoOzO7BhxpnQ>
    <xmx:bmvMaB7rr0Y4KT3V8PEW6PfdBzqClSZw2piSI4EPRCxKDS6pz0F1aw>
    <xmx:bmvMaM1XBUBwciaCUuC28wepjKVE92EhtipThtNffT75InINhppM1g>
    <xmx:bmvMaKzRlb3yByG5-xmh-Nv9R3G0p_BC8MGBoChpHgjZQ-ME8k7NZw>
    <xmx:bmvMaFHwq_DvTJmKUwMUyUUUlvT-W0XagHqgnFK9UfWQNb-07Zji65NK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Sep 2025 16:28:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Kevin Puetz <PuetzKevinA@johndeere.com>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  "git@vger.kernel.org"
 <git@vger.kernel.org>
Subject: Re: [Bug] git fetch --dry-run --filter makes changes to .git/config
In-Reply-To: <20250918192045.GA1187769@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 18 Sep 2025 15:20:45 -0400")
References: <CY8PR05MB100119985C7C25A72E530556DB517A@CY8PR05MB10011.namprd05.prod.outlook.com>
	<aMsmbU_Cg0L6kOlm@fruit.crustytoothpaste.net>
	<DS0PR05MB100132C058A3D9D5AA735D905B517A@DS0PR05MB10013.namprd05.prod.outlook.com>
	<20250918192045.GA1187769@coredump.intra.peff.net>
Date: Thu, 18 Sep 2025 13:28:28 -0700
Message-ID: <xmqqms6r7bf7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> It would probably be better if it established a separate tmp-objdir area
> (like we do for pushes before we commit to storing them), fetched the
> objects into that, and then threw away the result. That technique did
> not exist back when "fetch --dry-run" was added, but it probably
> wouldn't be too hard to do now.

It is true that the quarantine mechanism did not exist.  But I am
not sure if a true dryness is actually better.  We do verify that
the incoming objects thrown at us by the other side are healthy, so
the only difference is that our object database will have extra
unreachable objects that are known to be healthy between the time
you run a dry fetch and the time you then run a real one.  And these
extra objects that are healthy will help your real fetch go faster
if the dry fetch and real fetch are run back to back thanks to "do
we have all the necessary objects already, just that they may not be
connected to the refs yet?" check.

So it may not be hard with the building blocks, but I am not sure if
it is a good idea to do so in the first place.

Thanks.

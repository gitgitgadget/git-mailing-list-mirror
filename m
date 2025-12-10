Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23061397
	for <git@vger.kernel.org>; Wed, 10 Dec 2025 12:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765368055; cv=none; b=L+ClC4FfuLwdvkPvsyJ7w4sv9iIS1M+YF+tQhWHbRKAhyLk8yj0KlqAEGZ/yfy3p9sibFXhVGcqrzvcX+AoraoCzrKK2Uo3NiUZXwl88JKp5gtVSxyLMti2L+Bw6Hzs9JDHhyiemvawaHKG5V77mktgaEOu3CXjiBpN/GoMaxGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765368055; c=relaxed/simple;
	bh=1sX/Asp6SqJeO5DF29+h27ZCvRXgPHEuA+C79cYD6/g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K8mS8DNCYoEtL1fbCwf9Mr8zyOSNpg19qWQx6CKMoGoGtkjg8isNm+cottffhdLxXl7gNsSgyI6NmTi61mhxbHLQi1CHMOuWz7clzOwEfjAhse9RXx5MkMeMOSIxNMk/uvi7/y8I7tRJ2Us5wyZVCZWtQJ2zmPCw4ohN+h2MGIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=O6/zUK15; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=y3jZhMWV; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="O6/zUK15";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="y3jZhMWV"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id DB09FEC05BA;
	Wed, 10 Dec 2025 07:00:52 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 10 Dec 2025 07:00:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1765368052; x=1765454452; bh=6k4yd9pd8m
	626U0F/mZgs1x/GdYPhQA4IvF6KlG1cm0=; b=O6/zUK15jeXmnjGQmGdtMsKQYx
	FTRJmbNSAvRpm4ySoZK0HDSGDf9nPaBtcrdMvmRNmg4Kx9OctqZxL3Tg3wOk5o1T
	cuV5Htb5KEDslWowwX45pZwSn4DP0xR5KM4ZKCTUt1LFgP7horJT/AyaotgJLO0g
	6hy2RA3mi4oQxB3ORD0L97ehQTmB7kM4+NS8Uvw7ounTqZTevKZ++IMQmH8vOeKD
	yv8eWm+4MJzBIGEoy2TOfhnFk+FHd6deohTj74gcYGGAEz6CH0+4I3zKWdz3dnuJ
	YUN07uMPU7CI0bwo+c68/tplOOq9eRumMRK+d6G1KZCwTaXfE+ylWAp4mxtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765368052; x=1765454452; bh=6k4yd9pd8m626U0F/mZgs1x/GdYPhQA4IvF
	6KlG1cm0=; b=y3jZhMWVzQ819ngbBNLh3x34mAJAZo0vY2S7gRO9+xB31yl7oX5
	WvUd2S/R5TCEGNdhVGS45vJZIrsKaOEOEJJKQggICzlFjwSJjq4DM4ZZ8ui9JrZQ
	9/R7IeiZQKF0u+/be6Tg5I7GwhRZHPMRAf3k8EGfYJqXISH0VROPU/5gqoRME7eJ
	XC9ra4JYywoUe1eOZxeHx9GLZa1d24bnrPK5ltr7iqK86zYC1ogLKLoYom/AJ1UO
	WppzDHoHYmuknzfh0mghqqzu2/WHp06vc0RzAet4wJJvmos2kp2BfkPAhCtah43u
	sk5Ua7dkQ10ap+x6Zw3R/DJu0rkLOWJiUSQ==
X-ME-Sender: <xms:9GA5aaJae_gVq2b_30uZ5qd3YO_Qo64ffGVCFAlgCakU2VotxQmUCQ>
    <xme:9GA5aZkaHVsOA0ojs98PIF528gpfdZia-HbS-Pqet7LCf1q6F0bkDUQG6YHT6Wjhl
    2wdD1NYIH2V9BjhqRtPhPf3hQSLnaXSzuhMul4VBENqCRFQVhRuNwM>
X-ME-Received: <xmr:9GA5aYHR01i_Adbrkp1K-o42VHzvqaMKzRE8XSgqqxD8MpPEKkFNlcvnZDqd8jIm9dtVHCr6UdjVuWib3nKOsRJzQwhJo3wkEA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:9GA5aZGdIArX-b8cwOXxojcH_I1S_P4zBFDt1G26HSXNZuKdZ4b8eA>
    <xmx:9GA5aVPYgAdMDFRIGQbxlHTA5UZT0xiJp81M-lNZLjHBUo54ClWfkA>
    <xmx:9GA5aYEuTGVxzn7Q73Ece0k7GgyH5eSJjOMVeZYd08JsFD0iFkUbkQ>
    <xmx:9GA5acO89r35w0tvB7IF8KwXZVknRggoTRekXONJlo97pM7HOMp31w>
    <xmx:9GA5aRmeg_4WcSLqxgqXgw9K3S5uoqgUqrb7nknkz--Jv-01r3MBEiag>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Dec 2025 07:00:52 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2025, #02)
In-Reply-To: <CAOLa=ZTAdpRurHGiBj2rQhtBJxuWPz4__2Q1LgJ4rC2qAdL=0g@mail.gmail.com>
	(Karthik Nayak's message of "Wed, 10 Dec 2025 02:04:48 -0800")
References: <xmqqfr9jjrci.fsf@gitster.g>
	<CAOLa=ZTeEEntiQdCnDd6B8a_ppJrrZqdURhQJV=bNktnp0JqMw@mail.gmail.com>
	<xmqqjyyvi743.fsf@gitster.g>
	<CAOLa=ZTAdpRurHGiBj2rQhtBJxuWPz4__2Q1LgJ4rC2qAdL=0g@mail.gmail.com>
Date: Wed, 10 Dec 2025 21:00:51 +0900
Message-ID: <xmqqwm2uh7gs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

>>>>  Expecting a (hopefully small and final) reroll.
>>>>  cf. <CAOLa=ZQ-O7V9qHbgeuQ78R1bHGDmGEM6fP5Kr9aC0AfvSF8MZA@mail.gmail.com>
>>>>  source: <20251121-fix-tags-not-fetching-v8-0-23b53a8a8334@gmail.com>
>>>
>>> The only change needed from the last review was a typo. I think we should be
>>> good as is.
>>
>> Meaning that we prefer to leave the typo in, or just we won't die
>> with a known typo?
>
> The typo was in a comment in the tests, so I thought it wasn't worth
> re-rolling, but happy to do so.

I went back to the discussion to find that single typo and tweaked
it myself in my tree, so no need to resend.

Thanks.


diff --git c/t/t5510-fetch.sh w/t/t5510-fetch.sh
index a1ca4e1ac7..ce1c23684e 100755
--- c/t/t5510-fetch.sh
+++ w/t/t5510-fetch.sh
@@ -1628,7 +1628,7 @@ test_expect_success "backfill tags when providing a refspec" '
 	    test_commit fetch-me
 	) &&
 
-	# The "history" tag is backfilled eventhough we requested
+	# The "history" tag is backfilled even though we requested
 	# to only fetch HEAD
 	git -C target fetch origin HEAD:branch &&
 	git -C target tag -l >actual &&

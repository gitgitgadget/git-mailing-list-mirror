Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C00B28C868
	for <git@vger.kernel.org>; Wed, 25 Jun 2025 17:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750871116; cv=none; b=hqD0oTyKkC/TKxuMZ5LyC58TRNd+lugKc2eeQ2yHEzfdk5ksgGRGj+ReqAxA4WLL3xPbl//5dEeqZWbdsrmOh5R1Xw9qFmVYrE6Ek09Y0C+46YZAq1V5PsyfksInSnIA2Sbv9JuLHICrqgWWrXzuZmuZ8Ehe5jr1nF6dY+Mr66k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750871116; c=relaxed/simple;
	bh=ZGw/7aD4IF28ck9xhQzb3lqNujsANifopyRq7HtryDA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Jhk8WYP/c7j7RqJQG8zpqJpTqYkB8eMpQA/exv1Tu2fcpRi6xI99nCsKW1YF7O2Q/gDXSQgJeOO31LCBuygp/eKc95UPUwhH8u2pAeZ4h+QChgCqsvoIbRv9fHU6pUElfrvAMlSRkV7w4y9pDxsdrJT+99qhAHy9e16zv1CyuhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=qaTYHDpE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RQRsp3Os; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="qaTYHDpE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RQRsp3Os"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 72C21EC016E;
	Wed, 25 Jun 2025 13:05:13 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Wed, 25 Jun 2025 13:05:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1750871113; x=1750957513; bh=qpf8r8QejN
	2IXovqgjcP0fI3M087K9wsL4de11l3GvQ=; b=qaTYHDpEC6F9sri65p1u45VzCk
	zwtP8vE/gWWDOst722CsxykDRM0bfeJnT1g98lFc5xnTsmTXjvxidw6o6Eod8Ouo
	jVwErcIaTQmrNr93pljWTtX8E3NGMfGzsEtrVh93EuOjeWD6uPxwXbtl5xlQqlhS
	Ueb3Zg+B+RNCqKRZ51nwaGFRlWCuuIyBgy9c7isvbdGNVqEzpTPNmjQkCvaSEhNZ
	m7EAG1w7sB8Sq/fVNcI1jXXyfVeg4od5LmuPoFaoXqEBegGoSWo58mZDUDbOdrdB
	VTDB87c0hjHwDeI6ZQs2dwuaYzkrUqGOBP7bGFYfqI+M+eAqh+r8L+bsRgnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1750871113; x=1750957513; bh=qpf8r8QejN2IXovqgjcP0fI3M087K9wsL4d
	e11l3GvQ=; b=RQRsp3OsFKRhEQ7MViIJgqi2wAdEMq2c5eYTzrRt0eSYyFg37BN
	PDnlp3qDxrzqK67NDlMJAHdJouD9y+TyIInFacE/tCHhoiYaNAD6nRLfRIll6NR8
	2wBkufo2kpK+HvGHhLMLurW95ZmfZSkSPiMSplj6tmG3W8mK7vZp8LU0OrslNaYT
	oAQLibk7Av54UNAec+WvtcGFDLK6z0mPlhPvHfrIIk/FhYR4+ga/l7HZyFlb7rjd
	AhGrPHKjY/Shyzp/F7M229f97l4NyBtNI6mXyXgT8UP9wvvaNiWg3Dfyaz0Mxr23
	d+E8iPGaSnrGPMq4CcjOgAK5+vnLqU7tZlw==
X-ME-Sender: <xms:SCxcaHyM8KETZKMzWaqVxpMKq91g-jYVAZfI02w1yH_tpa6ilqkLlw>
    <xme:SCxcaPRU6WOICb0xzI4FfhqlEV8HUpsEBvljZr8Ws0pfxCdI63JdWu-9f-eW0iZol
    TyaJ4oT8gbgQzZURw>
X-ME-Received: <xmr:SCxcaBW8_Az9MKoG8kScsAx4cM_kXPrUx6fvkxubCGRmooOLCbsOPVVH4hMHTjUGwcK_2UvOxr4UasXeFLlpoUJGkH9aWvPByM00coo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvfeefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtoh
    hmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphht
    thhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhstg
    hoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomh
X-ME-Proxy: <xmx:SCxcaBhf1naXGaF5TAUv-24ZtZKb2hbYwHIPgU46GLKeN23HmIWr3w>
    <xmx:SCxcaJDRGelISmutmAIpUdqJSHnEhpu1PBOnZuA1zBHfWBWlq3h8rA>
    <xmx:SCxcaKI27APT_alPkI7O9Hm_ivGTwH7gZUeChHqG7iQ8Qeb2UElMsA>
    <xmx:SCxcaIBgnjDI_fyVRzOkGonPEKPGVW1wU1DBySw75Gcox7I1Jge0Lg>
    <xmx:SSxcaO8svHFKm2RBIjhtq_U4MrwTbYiuyWl43ah30k0z-8w_HMp4xdSO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Jun 2025 13:05:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Taylor Blau
 <me@ttaylorr.com>,  Karthik Nayak <karthik.188@gmail.com>,  Justin Tobler
 <jltobler@gmail.com>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v5 1/5] promisor-remote: refactor to get rid of 'struct
 strvec'
In-Reply-To: <20250625125055.1375596-2-christian.couder@gmail.com> (Christian
	Couder's message of "Wed, 25 Jun 2025 14:50:51 +0200")
References: <20250611134506.2975856-1-christian.couder@gmail.com>
	<20250625125055.1375596-1-christian.couder@gmail.com>
	<20250625125055.1375596-2-christian.couder@gmail.com>
Date: Wed, 25 Jun 2025 10:05:11 -0700
Message-ID: <xmqqv7ojvjjs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> @@ -414,11 +439,15 @@ static int should_accept_remote(enum accept_promisor accept,
>  		return 0;
>  	}
>  
> -	if (!strcmp(urls->v[i], remote_url))
> +	if (!p->url)
> +		BUG("bad config_info (URL is NULL) for remote '%s'",
> +		    remote_name);
> +
> +	if (!strcmp(p->url, remote_url))
>  		return 1;

The code seems to trust string_list enough that once an earlier call
to string_list_lookup() in this code path finds the entry for the
remote_name, item->util is assumed to be non-NULL and points at a
valid promisor_info instance.  But it does not seem to be defensive
against p being NULL, but it does so for p->url being NULL, which
smells fishy.  Once promisor_config_info_list() reads the data from
the configuration, do we ever update the contents and the risk of us
corrupting p->url while we are running is great enough to warrant
being defensive?

My inclination is to suggest removing the check and BUG() here, but
I may be missing something obvious (like "p->url gets NULL'ed out in
this function, but then such a remote is never checked with this
function because such and such logic in that function").

Thanks.

Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351A2221FAE
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 19:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759780764; cv=none; b=DD11bh2vyCx7SQgaqxSnKjRLVe0nhezopxiDrNja5CnRiI6hVutpgaYnZb82WDJiCq5zJVgP3ESzoziOMRNAi1wjF+lbbqJ2SyGPZg3BGBcCj4NgbIg2oXJeeoxAs6FF6UMubwMrNayAS2Nn+BOBnGXna2cM6Do3YAvfU9AGrnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759780764; c=relaxed/simple;
	bh=a4VqL+UAODOVqmiV79TxFRTQ6bSK2WxrP048HuuSbD4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZqEX/X8hEoIMhhmXU0/9t3XwFsLd2K1l1WI2KWy8iV8XSTTMA7cnGN+E1qg7pCORWx5EEILy/WjWUOa1qnCqbH+HgQnjWKof2S4epZI1zjk0pBJrE/EN44ELZ6J+PqS8scbL/RVvHacnHPW3gOdcWmXaJpEcUwzh6+afAEkWy1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YoC70l/4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GnHCcxte; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YoC70l/4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GnHCcxte"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 70035140010C;
	Mon,  6 Oct 2025 15:59:21 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 06 Oct 2025 15:59:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759780761; x=1759867161; bh=uwFi7N4vC9
	ERdtIvd9sOTmfQMFfffCBQZBFO6hjxRnM=; b=YoC70l/4bMYxn8hUxhNDKlB1HM
	PAIahWSJjrwKePO0VwoFncKlxKKPfOckFRPub78lvJBBDUNuXi4nliyOWAoatIDa
	VL5cI5NlCgtJOKAWvQ/0HpXpMAMlJiwX6o1/D9Xnr1kqU+u7eC2uT0c1DDYCiqkU
	+pC85gBlIcNWSYX0lUDnSuxUTVG4PufPrguC5hqZ3xaQoHNL6zcNnzbM5itP2cyw
	eQTeoMBCDSNCQbOdgBWWcNM6fmHTmUMQrQbkUJdP2odC2MZ+/4CJasz58YN07X9U
	Zukxyy22oboTctjF/+KSvGdj1fFTMDtVMKUGJ9IQyhTVPvcllSFp10XbEtzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759780761; x=1759867161; bh=uwFi7N4vC9ERdtIvd9sOTmfQMFfffCBQZBF
	O6hjxRnM=; b=GnHCcxteXzcNcr7dw5YLJTezhSeI3XIAT8LlWc2VNU0AlokYmXb
	KUbuOZ7QQKvsjajjZlTDLR9BJWXJ9ma5d5o/t8+TvfnPu809rVGzeLdVI8iI9vZd
	ujkbvzXiWnoLgMawaOoh24WmknoSsBK6d38S/nJCZirvcPAlcw0o7TzJV5ypyfI0
	lexhWnk9YXNnM0YTWAp0EI7/oPxdYZ0FhbJlIz6DuR3R4YKMlwGLRqquOZby9ej8
	kL9Cq//5JjIZ8pKlLqwGtjcMeBtVUR1AyN9twGC9zRofNpc4ZoZkYP9bA3vw5n7D
	CBTsuI9yrIbUlMZpeQhsXDNF1PEBpxvFMOA==
X-ME-Sender: <xms:mR_kaKOBeGCxn89yg6XikIzom3O5bu_olve6cgzxpuF2237MzZzhFw>
    <xme:mR_kaFUk7HRh1qGqlA21w3YJdn1jjMOLkWKMW_tbjkzMKsM7iHcybifcQYRwGFvjP
    iWju_HV96TVUJslmq4PurN4gw5t43Ww1jAt0bFBpxa3MDcyaDdj>
X-ME-Received: <xmr:mR_kaFtnR2irMZfctT0DUBwFbsD9Pf-6ep-gE8jJ4usrsoWke7LFo2etV6LWKrlha7cBeFhF2xmzi4oQuRPFb9oEopgRg6GFceR->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdelkeeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeduhedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgdoghhithhhuhgssehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehnohgrhhdrphgvnhgulhgvthhonhesghhmrghilhdrtghomhdprhgtphhtthho
    pehpshesphhkshdrihhmpdhrtghpthhtohepthhhrhgrnhhurhesghhmrghilhdrtghomh
    dprhgtphhtthhopehgrhhoshhsvghrrdhmihgthhgrvghlsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtth
    hopehmvgesthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:mR_kaI3YW0bDC-x5tYt6Xzj5bFKZAnLaKuxAnLawUpaXQ0KZNPfNDQ>
    <xmx:mR_kaO6BbA7SGzjjmUz0wJfg_3smXBgjPVfyPQ6MJBhaBHXLBe7wSg>
    <xmx:mR_kaHVKvufuIyCVt4PTSRf0MpuJPgCrYuam6z8yqsaMvfadpOciGQ>
    <xmx:mR_kaOjW8VC04_emGYPQNO8rObNmi7avK2KqraqZ7LTZ2ffUoCuCLA>
    <xmx:mR_kaMh847fSRF2lx29Kc_tZBACO3z0fmbrlxi60rvJkFIG8N-5J1m6D>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Oct 2025 15:59:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,  git@vger.kernel.org,
  Noah Pendleton <noah.pendleton@gmail.com>,  Patrick Steinhardt
 <ps@pks.im>,  Thranur Andul <thranur@gmail.com>,  Michael Grosser
 <grosser.michael@gmail.com>,  Eric Sunshine <sunshine@sunshineco.com>,
  Taylor Blau <me@ttaylorr.com>,  Matheus Tavares <matheus.tavb@gmail.com>,
  Johannes Schindelin <Johannes.Schindelin@gmx.de>,  Calvin Wan
 <calvinwan@google.com>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  Martin =?utf-8?Q?=C3=85gren?=
 <martin.agren@gmail.com>
Subject: Re: [PATCH v2 2/3] config: values of pathname type can be prefixed
 with :(optional)
In-Reply-To: <xmqqzfa3onxx.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	06 Oct 2025 12:00:26 -0700")
References: <20250501214057.371711-1-gitster@pobox.com>
	<cover.1759094936.git.ben.knoble+github@gmail.com>
	<5c97f580a9e77c464bc6bf4ed9ea8546711c6637.1759094936.git.ben.knoble+github@gmail.com>
	<a687ec17-8ee4-428e-bae5-063716d59a08@gmail.com>
	<xmqqzfa3onxx.fsf@gitster.g>
Date: Mon, 06 Oct 2025 12:59:19 -0700
Message-ID: <xmqqsefvol7s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Phillip Wood <phillip.wood123@gmail.com> writes:
>
>>> +	test_config commit.template ":(optional)$PWD"/notexist &&
>>> +	(
>>> +		GIT_EDITOR="echo hello >\"\$1\"" &&
>>
>> when git runs the editor this will be expanded to
>>
>>     sh -c 'echo hello >"$1" "$@"' 'echo hello >"$1"' path/to/file
>>
>> I think it should be
>>
>>     GIT_EDITOR="echo hello >"
>>
>> instead

It seems that this was a copy-paste from a few of tests before this
new piece.  They all _expect_ to fail, so probably nobody bothered
to inspect the outcome ;-)

I just looked at what actually goes to COMMIT_EDITMSG with this test
that expects to succeed.

$ cat .git/COMMIT_EDITMSG
hello /home/gitster/w/git.git/t/trash directory.t7500-commit-template-squash-signoff/.git/COMMIT_EDITMSG

So, you're right to say "$@" will be given in addition to "hello" as
arguments to "echo".  That extra argument is to tell the editor the
path to the edited file.

We'd probably need a preliminary clean-up patch to fix all of these
in the vicinity.

Thanks.

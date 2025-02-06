Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C722188CB1
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 20:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738873580; cv=none; b=l9N8katSyg+YSR2Vacg6SPaw3ufAOhQEgqSGa6PelIs0a43JXGtgWS9Wae+eXyHLDleo6oneXfamkS2Oq3Gn6q4te1AqLXM8/MUirC69ivbHcBmt/2n96wU39RGkRiOH41BtXK6SdBqORpqSWpnYcacb/2WL3qlQkF9tgzuQEAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738873580; c=relaxed/simple;
	bh=e6T2olfJmJDlEiLl1f89S6RLD098bqcn/AdkugNZDDA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ib+36ajUCANX0GEtQA9j6vfP/265ygCQfsBIMyLAizyyP0ilCUJrD/vrOxbfWJq83BZg4rMKeOPk21JuJdVQHuNCu7YUW/G4JmUbscqDABiZFP+kk0ZCTt0PVUAevgkoAquI/vMFkfJ78KOx/0aRVI12GIuCsTnO2TOQSNzeo5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=B9b199Ny; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IQJbwV5D; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="B9b199Ny";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IQJbwV5D"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 5E2A71140130;
	Thu,  6 Feb 2025 15:26:16 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 06 Feb 2025 15:26:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738873576; x=1738959976; bh=e6T2olfJmJ
	DlEiLl1f89S6RLD098bqcn/AdkugNZDDA=; b=B9b199NyQSpA5/D8zsz4tts+GF
	kD/WG0ObZlK4tAyNLsjabLDa97oUu6FkMfIGfn2Aolf7xs/ZGhVgr/iFSbwMGrvp
	91GfAavyvdaqMw9ZCTnxIRr/rwAA4bub33iAX8F9PO9EAxZLFBI3gwlxQx0RJ9YQ
	tuwBeO8ydsHWh4wrnKlsETM3xC+57ztaei7/33iN3ZgDg8yj16JxfNyMlREhQxtl
	3n+kUiSSrPPgmYdeYB7IevhiSaG6KtgsvFuxI4ZKyJLrMkhrDGmqqPYg7sYJbtbo
	6KRH5l96ey4KbceNTfvrhGIx6all1vVyFoYyCUUfpJ3wHfAxYXL6CRFjfFTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738873576; x=1738959976; bh=e6T2olfJmJDlEiLl1f89S6RLD098bqcn/Ad
	kugNZDDA=; b=IQJbwV5DopRN9qUuuFAu3AvCQLtSjOEVhNQ0DfG1Gel9ewZnv/J
	QPnC2roZhjZyzC3aCs0RV8/8pf7siKXzNKABq3PyFVJDHYhNeJsNnCh8MNj/kmB8
	QV/m/77Fkgmc8ZgIBZjL4/8w1iLCT4OvZLE/4dDcUbGnK1hSvjADB0FiTHFUp481
	Vb5rBU6ob8IO+yHTr87II+mKHtND7ccDwbRq9it/VwsaB0JUlScZDrV0gqQIbiBF
	d8xNyIyqwY3LSCLIhhcf9qq0mTyXwuZ65lC2dOopPkyOvEbXhbP+yZYp+q8pxBnJ
	URoRBtTChHQCKN3KvwflKpaE5dVYS6/kEfQ==
X-ME-Sender: <xms:5hqlZz5PBw4PEsIN4dD_rMYaxH2Icnrm9ufGWdPDOLhO9OEsdHF5Iw>
    <xme:5hqlZ46NbKOgwltgB6iyj2QheeV2AulvjAkQefThWgdak7HBd-_io7wx5ANap1kPA
    WF1BZRU5b1g4-9q0A>
X-ME-Received: <xmr:5hqlZ6cxrrZKGyfOIficEbOtwBvSJqI4FRTtUkHtD7WevvqG5YHuKJQAYO1TvNwcCGAGrsQWzmJcNxm81BgGa57WGRJgUG3TafdS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjeefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrg
    hughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehmshhutghhrghn
    vghksehsuhhsvgdruggvpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:5hqlZ0KaniVOa0BNjwjiNQd52uRY1FzCzgWUDGoNlAHvOG_JgAbf_g>
    <xmx:5hqlZ3K-OjDnc9NLjPH_Kk06rDB_Y95yV3y-C6NuLBLw_NU1XoIA9Q>
    <xmx:5hqlZ9weHD6RgWwbeOvtWyUg6s0-C3GmWnJCNv8hLb05k6M_0Bo17g>
    <xmx:5hqlZzJdIGPY2-GjSUqg4mqMPPlLK-MG9DfJ9m38tE3Mfa15SEFAAg>
    <xmx:6BqlZ0qXbK6oCdASJm-2TZWnVAX8_SQRfQG3g4WTtZctUN3iwfSJ805x>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Feb 2025 15:26:14 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Toon Claes <toon@iotcl.com>,  git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Michal =?utf-8?Q?Such=C3=A1nek?=
 <msuchanek@suse.de>,
  Jeff King <peff@peff.net>
Subject: Re: [PATCH v7 7/7] builtin/clone: teach git-clone(1) the
 --revision= option
In-Reply-To: <Z6RvD4FtfXIk4Pa3@pks.im> (Patrick Steinhardt's message of "Thu,
	6 Feb 2025 09:13:03 +0100")
References: <20250206-toon-clone-refs-v7-0-4622b7392202@iotcl.com>
	<20250206-toon-clone-refs-v7-7-4622b7392202@iotcl.com>
	<Z6RvD4FtfXIk4Pa3@pks.im>
Date: Thu, 06 Feb 2025 12:26:13 -0800
Message-ID: <xmqq4j16kefu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, Feb 06, 2025 at 07:33:35AM +0100, Toon Claes wrote:
>> diff --git a/t/t5621-clone-revision.sh b/t/t5621-clone-revision.sh
>> new file mode 100755
>> index 0000000000000000000000000000000000000000..d4889a954e6300e0e327ebe7dfcf73569d966829
>> --- /dev/null
>> +++ b/t/t5621-clone-revision.sh
>> @@ -0,0 +1,123 @@
>> +#!/bin/sh
>> +
>> +test_description='tests for git clone --revision'
>> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
>> +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>> +
>> +TEST_PASSES_SANITIZE_LEAK=true
>
> One last nit: this line is not needed anymore, as tests are required to
> pass with the leak sanitizer by default now. Other than that this series
> looks good to me, and this change alone does not warrant a reroll from
> my point of view.
>
> Thanks!

I'll touch it up while queuing, and mark the topic for 'next', then.

Thanks.

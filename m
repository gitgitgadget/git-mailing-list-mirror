Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DF953E23
	for <git@vger.kernel.org>; Mon, 16 Dec 2024 15:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734364237; cv=none; b=agR8tXJvk0s2af3HLzpGu1dDTREXwbLPIhd9bhIY7hnIzqDiDHNqFvfnw8m/E67dYZcOXDFwVZZ1XSec4ukD6WgcieBXsrLIG4SEessn1RygxdoREe7gZkDkdTiz3hshSZ3+19jnBAXfQeumMECs4wbCHHqt1LrCotpec7NECes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734364237; c=relaxed/simple;
	bh=G4oAGiPJ5FS8nTouT0vNaBmU9v1JBMeZhrMbUPuSg24=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OvaZaBsL6MNgi8ximSOugCxqhwH/rhSITm/DAMskmWJyOHJ8NAr+iDYYE8FTcxCs9kAHKz149NaPhszaKEBcpnYnfBxjWZpCjGH0VeMimE2o6TBCs2CRNoRmaosB93l8K9M9Zde4tbRYryOsCKN4SoQX+RE2HL3tqJBR5pxbB/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FwmUqaV7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ya3WCQvu; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FwmUqaV7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ya3WCQvu"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 27F2111401BA;
	Mon, 16 Dec 2024 10:50:34 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 16 Dec 2024 10:50:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1734364234; x=1734450634; bh=1vwqhvgrxN
	y1c4ofFcK0zXKvuEXdnzBU8kbXkA2bt8E=; b=FwmUqaV7+GwFRamwo84wzH/DYn
	XyspoFbD1uFi+iBqDsZYrR8eu+e1DVfFa1HzGGkeZeMV6De1wAFEakzDjo1itzgi
	3cykotAb2v8zIxd2iAriw9AME3nW30/k0xOdSC3Y8W/2k6RrkPTsY3zCxqisW5N4
	7FjgDVI1YUcczBxnI7aNXk8cvFIww60Sw8PbMjOKShSdSNLHCfNNzLJ++cTkXOmF
	PeYAs50GGgbzdkFZ6pBYYW6m220N5JDAa+MTnwf1BXrNTu+bOm9/DY6oWN2yJrgp
	/9pTirQg6dtjC4iqKZs55QB5yAh5IU6g1GpSW8Es/L/BdN3rdTLZ4oR+j59A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734364234; x=1734450634; bh=1vwqhvgrxNy1c4ofFcK0zXKvuEXdnzBU8kb
	XkA2bt8E=; b=Ya3WCQvuCDQSg8XfGoRpkKYnuBmUjbglesxrY1Du1kVZMVQdUw+
	xQGnQL/EzVDtIwSk0GR8QN6fKNWFLZM3BI3Kt2QMSmhMjd2kFBTjsCDMd5sWqqav
	xaOojrVTQK2t18AebwbdqLD5Dnn7+BBzCyJFJ51NaTSbxm6wy/ECY4B2yS4diS6V
	DZ8rQF/Kufm7ZXfAAETaY9BwVT34L2HYKfdUFtUcSpQ2TofCNnr2QHDcTRb5EdJK
	L2P+r6LJkPLidue0/5jnh/PfDcd6XumCBpnLBTv8WfAzOsGe5Xl7bYw1Tvr8kQWz
	SNPOyj6SdBO/maqftRzr9upwURojTgIVqcw==
X-ME-Sender: <xms:SUxgZwSOXb-8mr4vykjVpJci-GPsu7FrRKRip0qLmPq2385np7vutA>
    <xme:SUxgZ9wrEzS4hFHh_rZD5fyS3KGsWEG0YkGNKUZH9T25UHTmtJiptRHuWmvtcoQJJ
    DmW81t0NrqvUQr_1A>
X-ME-Received: <xmr:SUxgZ92swZN4hMiS4Qr8UoQrOuSVdymkGRLJ5HKOOCoFgESG_Yfgqj7qCvlTqrKOp1Tjyb0HIbzd8mOTBtm4Jd30sMGq7JgZOlHxpVY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleefgdektdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpd
    hrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrhhishgtoh
    holhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:SUxgZ0CUZDEpDRV1Zt--FWRhNgpHbM_JOP2q9JW66KQxabY5ZosotQ>
    <xmx:SUxgZ5hjSMz-Jof9tF9cighZnlRCMBExJJThsa3-dAyYybh21W66sQ>
    <xmx:SUxgZwqUUyXoE71_fFQYh-R7_wfJDog6yaQzq71I-qFzt7tR9u-gMA>
    <xmx:SUxgZ8iVbJMfqKvkwfgNlcio85jMc7lseRPxF5dhnfW3VQfE7kPU0Q>
    <xmx:SkxgZ3bRS5SpUL-jiBw09gdMxJVjx5XoqsixwMSWRntTx74geXtkl74R>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Dec 2024 10:50:33 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org,  Christian
 Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 8/8] refs: add support for migrating reflogs
In-Reply-To: <Z1_KzlKc7RBfas4L@pks.im> (Patrick Steinhardt's message of "Mon,
	16 Dec 2024 08:25:19 +0100")
References: <20241215-320-git-refs-migrate-reflogs-v3-0-4127fe707b98@gmail.com>
	<20241215-320-git-refs-migrate-reflogs-v3-8-4127fe707b98@gmail.com>
	<Z1_KzlKc7RBfas4L@pks.im>
Date: Mon, 16 Dec 2024 07:50:32 -0800
Message-ID: <xmqqo71b7hkn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> +static int migrate_one_reflog(const char *refname, void *cb_data)
>> +{
>> +	struct migration_data *migration_data = cb_data;
>> +	struct reflog_migration_data data;
>> +
>> +	data.refname = refname;
>> +	data.old_refs = migration_data->old_refs;
>> +	data.transaction = migration_data->transaction;
>> +	data.errbuf = migration_data->errbuf;
>> +	data.sb = &migration_data->sb;
>
> The `index` variable isn't getting initialized here anymore, so its
> value is essenitally random. I'd propose to use designated initializers
> for `data` to fix this:
>
>     struct reflog_migration_data data = {
>         .refname = refname,
>         .old_refs = migration_data->old_refs,
>         .transaction = migration_data->transaction,
>         .errbuf = migration_data->errbuf,
>         .sb = &migration_data->sb,
>     };

GOod.  As long as it is sensible to null-initialize the relevant
field and all the other fields not mentioned above, that certainly
would give us more predicitable behaviour ;-).  I do not offhand
know if 0 is the right value to initialize the .index member with,
though; didn't you two recently had an exchange about starting with
0 or 1 or something?

Thanks.

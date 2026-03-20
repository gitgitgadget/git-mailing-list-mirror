Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B39358388
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 20:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774037545; cv=none; b=dn9UWSlWzxIEWcDlZNhRpf0voQ5+0G6rawQxLPjo0gZE79KCYQWUvb70KKFU8/Neu+Bwww61H9yiKzT9cGgXv/h3td8ozEHzO9zknH73jMfioc6zITRJDKxD4aNyQt/zbrhBvX7zswCjah0oncwdCZ1TZWW3Sn6L7gh7ICYdgMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774037545; c=relaxed/simple;
	bh=hJEupRCh4z/dLBQB5/PI1iVH4VCv4f5808AlDDYKUpw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S7F8ffIEMQtVLCF+0i9fqLQdOmhu47aAdQmxqbXEkHwE+CF/X06U/YbmsCNuf+2huHr34fXUHZbZ58a/BZA3dIIOhwh2ywpBhyYhJtPrbw2d6F94GccZO0dkXe9ETwBYI5K/NNh1/gYiGBnIc0nA7UUGYcCC/bm852ljAg4nJvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=d3LXtEL/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pEFy7Ntv; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="d3LXtEL/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pEFy7Ntv"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 957B7EC00B9;
	Fri, 20 Mar 2026 16:12:23 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Fri, 20 Mar 2026 16:12:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774037543; x=1774123943; bh=r1LIgwJzEA
	0Ch3C37s4ns9J6qOj10GrBWggyVI8UMQw=; b=d3LXtEL/AQJ5/y5loNFmCzDfmK
	F8QlrRiNre1r6hjXzFfMlxYeYgmZf46E3kMHD/2X4DABoIk2xnbA7Rnkg/cgniIO
	rQdoqHBe76RBhj4R2631fpX35p3FK6RV4L0XLeA7gsn3W8e8gelkx/JcUheeWbVZ
	1Kx7yTKR4xKBOCphR5dmMq8xYd7S8+AehFzzOAhab/JD+rWYNnbuPHVyXQlPPyab
	1i2CCy8+Cx1WY44NAJUKKCCsw0LIjmbjMJABHKe5hCIkSbU5Itb/YJvUd7g7+k23
	dLN98oIWxGhcsS1YK5vR7npA3QeSq6QkUWTj/kxlPCmH/nTn+sY/EoLnTSDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774037543; x=1774123943; bh=r1LIgwJzEA0Ch3C37s4ns9J6qOj10GrBWgg
	yVI8UMQw=; b=pEFy7Ntvt1wBoqAA1/u099piphWJkNZIVkdSNyIHEvhoLsSc2yA
	4xceHEltm2025YILiRFEu7LlgNh++rZlK0unRHaj1kgSBrs1lrq8AYvFd2e7IwrK
	NUbmBZtSEPWOwX+UILoXOPDvkRWG7ci2TF0b2Am3fEMDeUDC6aPaAGJ/Bhjg0L38
	t/F7lNUwZurvaXCMV1qqc1mWCXWdvhc1JnEKCY9nV1F4cHz8BULhrxxY05o/HpOr
	UMCgXfuAvTDJM5eou4UVU7NqTLJaI1td4cDeHR5r+FbhThJ2vq1yrlgjnbxKp4Eh
	Qzc1/D22PXVM2LVrJ0TsE45I1uCpn4yabwQ==
X-ME-Sender: <xms:J6q9abM04yuFQWgyoOgAwcC2qF6UdIkdp0oP-5dsC0I-yb4Ltnpe5Q>
    <xme:J6q9ac8CSQMlX9wPEAaJ52CH88SaSGr-FGiD8FZ9suGHRyszJLTfLq1nr8Rzn6FXq
    RHR9P0LFiMl-dIBKiYefQpSa8mWTaO-iVCjYNoX2syQIIHYi9OXUA>
X-ME-Received: <xmr:J6q9afQ5WoX3ZUPwxdEQtqX1qvRSDoSSmoPoWTNpsHon2x0ktAcrHHFaHA774BJ3227xo-Z_ziALwW5jWdMk7BfM969kmng9Bw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefuddtkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehjvghrrhihfigrnhhgudekfeeshigrhhhoohdrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:J6q9aenyi7XH0UsFkwZ65-re85Xs-EUhYPbU1iZhqtJpdlYebHu6nw>
    <xmx:J6q9afT44LIqqcepV0qvtMd2AzR3VnGMx3k4dTZamGx_kTduqyvhGQ>
    <xmx:J6q9acOF-7DwymEEhBwp--Pcn-aITVre2mCBz-vv12k2yiTDF2qNOw>
    <xmx:J6q9aYU59EbD9S9DFXAamqaTnLr-h3Zw6CCM1pX9nQsAKb3UaVmVDQ>
    <xmx:J6q9afSqKx9uwaJuR2BsMEw2bldDkR4xtS648biiPfPP4SAGMiLN5bwZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Mar 2026 16:12:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Jialong Wang <jerrywang183@yahoo.com>,  git@vger.kernel.org
Subject: Re: [GSoC PATCH v2] object-name: turn INTERPRET_BRANCH_* constants
 into enum values
In-Reply-To: <CAOLa=ZTfL+1wqLYLNES-o1bCMJnms7rp1hG=DN+=YStgc38+vA@mail.gmail.com>
	(Karthik Nayak's message of "Fri, 20 Mar 2026 03:25:43 -0700")
References: <20260318003917.84792-1-jerrywang183@yahoo.com>
	<20260318190942.22595-1-jerrywang183@yahoo.com>
	<CAOLa=ZTfL+1wqLYLNES-o1bCMJnms7rp1hG=DN+=YStgc38+vA@mail.gmail.com>
Date: Fri, 20 Mar 2026 13:12:21 -0700
Message-ID: <xmqqh5qadzve.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

>> diff --git a/object-name.h b/object-name.h
>> index cda4934cd5..167a9154ea 100644
>> --- a/object-name.h
>> +++ b/object-name.h
>> @@ -101,9 +101,12 @@ int set_disambiguate_hint_config(const char *var, const char *value);
>>   * If the input was ok but there are not N branch switches in the
>>   * reflog, it returns 0.
>>   */
>> -#define INTERPRET_BRANCH_LOCAL (1<<0)
>> -#define INTERPRET_BRANCH_REMOTE (1<<1)
>> -#define INTERPRET_BRANCH_HEAD (1<<2)
>> +enum interpret_branch_kind {
>> +	INTERPRET_BRANCH_LOCAL = (1 << 0),
>> +	INTERPRET_BRANCH_REMOTE = (1 << 1),
>> +	INTERPRET_BRANCH_HEAD = (1 << 2),
>> +};
>
> Generally when we use preprocessor constants with bit setting like
> `1 << 0`, we want to use them as flags which aren't mutually exclusive,
> allowing us to do 'INTERPRET_BRANCH_LOCAL | INTERPRET_BRANCH_HEAD' and
> so on.
>
> Is this the case here? If not, maybe we want to mention that explicitly
> and simply use '1, 2....N'?

Taking a brief look at the way these constants are used, e.g.,

        static int branch_interpret_allowed(const char *refname, unsigned allowed)
        {
                if (!allowed)
                        return 1;

                if ((allowed & INTERPRET_BRANCH_LOCAL) &&
                    starts_with(refname, "refs/heads/"))
                        return 1;
                if ((allowed & INTERPRET_BRANCH_REMOTE) &&
                    starts_with(refname, "refs/remotes/"))
                        return 1;

                return 0;
        }

it should be obvious that these are not mutually exclusive choices,
rather they are independent flags that you can flip ON to express
dwimming a short name to what types of branches are allowed.

Besides, the original assignes one-bit-per-value to these constants;
it is not a place for this "CPP macro turned into enum to help those
who inspect a running program with gdb" patch to change assignments
of values.  That would be a separate topic.



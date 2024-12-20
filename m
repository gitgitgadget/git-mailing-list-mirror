Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37FA3B791
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 15:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734707093; cv=none; b=EzcSmzdvniPO7HFS3Y3Rg1GkLFLAH9EpUu6dcXz0Pdaa00Frty42vVO4ZZcJQ0lD1ko1Y1tSQb4CYGzzF5g91giFlPd4SdPg2EpW8zGeanGf5ADsLePCVToxhm1PLKyrQi6vq1/2lM9fodIPmwHh8RX9dJK5B5shGMUS7I8tkvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734707093; c=relaxed/simple;
	bh=i2kyDSfQxEU/azLapK+9YMaMzZ8Ybak8BRlzSvw2RJw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SAHVf9brgrAbY5oJ/wkIYADKV8Ar41eicIhE1lcomZXjXizY/vbS7Lq3NPVj4x6icFZGPobIRlNeNq5R195/Fcfni0ElDfz7PGXTgl7GAGiRlvgGqZ8sphtlCmKe7FkMKCXCpor+JII0ODVI5OoH6dyn3NlWyG680/7UfUeckrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=oxQEwpSB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gc3vVelb; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="oxQEwpSB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gc3vVelb"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id B91C611401D5;
	Fri, 20 Dec 2024 10:04:50 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Fri, 20 Dec 2024 10:04:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1734707090; x=1734793490; bh=Qet37ncMnS
	aoZ3nHEURr1jlUGcb6Yk+QRYSUUcBQoig=; b=oxQEwpSBqEoetW3pc9erzzhffZ
	RYSWNJEwU95vPsW0rDDRAu4OT2keSdfPMEG/rJ91LdBWUpudzPJMZ6Y2J8vmkuph
	1vNOxxv8tuy4Rl5ubJyPppxTjtHo8uB/KmkmeFrDvS0cyHP3HRwD0Y1zzllKooF7
	TvOHD5B+Rjo/xsevzFn0Ylfz4TlT0YxHo0LhILJ7EdEXK9lkx6p9sUj8URlQoxX8
	PfQmwSNjQHC5Z7mk0w82e9mcvG3QW1lQbc2xlWxOt4S+etsF8G2NVrZL21ngbOR6
	pvI0LMeBt5cqvqj+6oOaKmxtzEPVV6ay5cJr+jHU+ZYe3FFrPufiaun03kQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734707090; x=1734793490; bh=Qet37ncMnSaoZ3nHEURr1jlUGcb6Yk+QRYS
	UUcBQoig=; b=gc3vVelbSLOXsWTGo9YnRKbwQpIkD+Oj6Sx6A5MKHoj5viwFE7i
	sDDd9cJ2M4uEwk5yoiJnWq03NSPPrv5IW+KqQMFHaWsFetlVwjdct9oLTbKxMJRM
	t0gd0ZYPVehGgDVjlqX1rviJsd+q+FRSnAKtjaMJglXzJxr6LjMI0LEklXJCYGS2
	pEDDjb077UeEUyG09lseFavembhjzMm9MDSZm5wZEr1rzVR4cfZJcZ7Ky3fNXZA4
	1LoEIU4uaQ6cfOls5rtw7ShZUKzkYv7ByRe52JtooyRxt1LFyCRAqWLDIvImhtEZ
	ETAaS6yyHSo65+1a8yoWHl34NlNzYTxquvg==
X-ME-Sender: <xms:kIdlZ_T-KcW5T63uWp9vGqzxjvM4cdSXOV9VKtHoHAWZCXbpXa1QAQ>
    <xme:kIdlZwzi1pZe5Ez34TE5Uw2B2lvJYe2Ua_kDl5eeFqUDJY1Ef0P5Xmp0wS_32-c29
    XvDrknBJ6DAgk2nXQ>
X-ME-Received: <xmr:kIdlZ01fBQuReshxVcjk4xHutkZu29KGd4jWu8iCM_WquQKuHwGkJn0hSoSgxx9jCHjldMBUhu-5lAylp9ZItVdiCSi4XAbwig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtvddgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffh
    drnhgvthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsphgvtghtrhgrlhesghhoohhglh
    gvrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:kIdlZ_AtyGo81ceyxEytzkz6p7gA7uj_gOXDLhsRbORW-NVevWf62w>
    <xmx:kYdlZ4jzBAbFvqStwS-rdUpJ2APy3MXCewYJwXVgtfhcF6WHsJcKMA>
    <xmx:kYdlZzp9LvVcLxOQT4QOXiczqbGW83WNIQvie7RNe8io26H7fyd7Ig>
    <xmx:kYdlZzj_YlkzVeQHfLM63k0GTDS19Ot8LH3m27Lg9VJllyEzV9m3mA>
    <xmx:kodlZyY8u5ufmX8GvxCZDKpgltrqxeCxxZcmVh2LGWHjZhKKzJ0jvd7p>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Dec 2024 10:04:48 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Kyle Lippincott
 <spectral@google.com>
Subject: Re: [PATCH 2/2] GIT-VERSION-GEN: fix overriding
 GIT_BUILT_FROM_COMMIT and GIT_DATE
In-Reply-To: <20241220073720.GB2389154@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 20 Dec 2024 02:37:20 -0500")
References: <20241219-b4-pks-git-version-via-environment-v1-0-9393af058240@pks.im>
	<20241219-b4-pks-git-version-via-environment-v1-2-9393af058240@pks.im>
	<20241220073720.GB2389154@coredump.intra.peff.net>
Date: Fri, 20 Dec 2024 07:04:47 -0800
Message-ID: <xmqqwmfufl9s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Thu, Dec 19, 2024 at 04:53:37PM +0100, Patrick Steinhardt wrote:
>
>>  GIT_VERSION=$(expr "$VN" : v*'\(.*\)')
>> -GIT_BUILT_FROM_COMMIT=$(git -C "$SOURCE_DIR" rev-parse -q --verify HEAD 2>/dev/null)
>> -GIT_DATE=$(git -C "$SOURCE_DIR" show --quiet --format='%as' 2>/dev/null)
>> +
>> +if test -z "$GIT_BUILT_FROM_COMMIT"
>> +then
>> +    GIT_BUILT_FROM_COMMIT=$(git -C "$SOURCE_DIR" rev-parse -q --verify HEAD 2>/dev/null)
>> +fi
>> +
>> +if test -z "$GIT_DATE"
>> +then
>> +    GIT_DATE=$(git -C "$SOURCE_DIR" show --quiet --format='%as' 2>/dev/null)
>> +fi
>
> Looks good. I doubt anybody would want to override BUILT_FROM_COMMIT
> (and it was never possible to do so, even before your recent patches),
> but it's reasonable to include it as well.

Thanks, both.

Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AAA21B9C7
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 19:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739907337; cv=none; b=PcPUyPnf9TJY3IqDTGc3u0XDs2iInYn9I4hxDHu+yWW7SOJsuF+x1Qf4luQTIIuxE6cGBWa4kCHljNlQZoErKv+eTUM1lSazQ4L9F728mHRBV4rckt3C3qHRwN6uXezbSSMbuP7dAwDWYP4pFUQ3VBN9ZLMuqoG0HvWWh7mxrPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739907337; c=relaxed/simple;
	bh=KhhELM/k5UUYCMsxu5AWDe7mq+cY0dZBWRiRH16tNpw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YcKWIytldnpIBE31EAnk+DfnJtQUx1Fegg5k0PJ1UjbzmlqBVQJpsJXpGWqMDYCrm65D/o8XCXrXWp6PjstZPwzAv6npkW5ge7GDmK3PcGcajAHibF9T0O2Nctm1wnAod5JQnsCR8BkKhnDlOwyf96e5NG4vGigLWzTSyylmWW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZLzcz5xd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WmrbFCaZ; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZLzcz5xd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WmrbFCaZ"
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfout.stl.internal (Postfix) with ESMTP id 5105511401A5;
	Tue, 18 Feb 2025 14:35:34 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-13.internal (MEProxy); Tue, 18 Feb 2025 14:35:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1739907334;
	 x=1739993734; bh=ViPtVWwKmiH8ZZwGXchEkPtyXWqKpM/QVen97qSnUWk=; b=
	ZLzcz5xdsY2AXCFmvdU8lWN3M34P+3cPV2EQYOgTg//sfSxAJlsfqGF0XbkLdFVg
	LwpvU0Qo394x9AWQQejC5tmCmbpmYmlPT9tssgInGOb4lb/JOJFOyfugKdpamolB
	UvmH/hjbRHFPAfT4ECf7Ua/kBxLyPdzUw+rYVoWwJLj7kt6FsKemvGwHBM6YM6TZ
	EccbOg+T5NeQp809PmB4t2IlF7+iAaJ0Pf8VXZYPjOMotYlKj072KVKPnZGCx63N
	ysI7D4xZ0cnZGuMGCaw5ihNmUO3H/9gfULIz0afOrjTHMPNxL8U9ErbH67h0tqzd
	qdBzcXJNrOdBMwTOlxUgqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739907334; x=
	1739993734; bh=ViPtVWwKmiH8ZZwGXchEkPtyXWqKpM/QVen97qSnUWk=; b=W
	mrbFCaZ9F9tE9C/FjXXVsivIDYHymDBDipPP2YLMTVEYztv540a1IJhQ971TsHcZ
	Igfc42nYKAPeT49bNK8dOQk47R/BuClyN00z2jDCA9p45+l6qH+YowxwhmONT1aR
	5HszYEaa7oQJCDCTfM+ahy9BiiOD78FS0qSjf1YNKH0AR9fXh4z/ebCBlvfIe7A1
	RKl+/YReVhZtWNOOgmmo/VawnQYW4AwquBNVxwlLc2In8DxlVb7T/ebv+UYT9+BN
	s96whZ0FP7VaDZsASK+ofHQwTuljGk3RIngBLud9lzRfX6kTMv8rcHHoaDsNkSIo
	wC1O4dbICF8qHQKZhospw==
X-ME-Sender: <xms:BeG0Z9E2-SYmajiN3PUyu3a7zqQmU9kPa_gGBk3xjiC59i0tnYT0aQ>
    <xme:BeG0ZyU5_o2bRDi3J81TGuojZ6Qf8-kgAzlQ-Z2ZWSV9UCPdOAUMTWvejEM-Bn1Qj
    HQ9vGAs_wMTtH6fxw>
X-ME-Received: <xmr:BeG0Z_LqEZjNS8JvDNns4s3eRkMayLJIhmWByiZQM5YbJpYIZ7_PHZHZ6iklr8GNLSd_TzF_sdeyLM-87fs94ETyuu2CpoMTpeGqZis>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeivdduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttder
    jeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuveelgfek
    feehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgvfihrvghnse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:BeG0ZzHhsZADjZnwg-3FX3AMJAlifnRrq4KOWXr2AJEKEH-ALfLjuA>
    <xmx:BeG0ZzWsfr-mceS3sLUbb-MF7J7AqIzlCxtD5u8yIs54y4RwpmcjIw>
    <xmx:BeG0Z-OMaY_TrluCi9Xo99DTxaWhaA0QVJnVoRZRA55ncAmu7NR9gg>
    <xmx:BeG0Zy2AZhKZZo4AkjXU_2mGpSZuMMfoKQAI6hjWBRoAbntL5iE37A>
    <xmx:BuG0Z1Ly1bmj1G6hVcjyEU-iXyXV2u67PRsvtgAaDuc31AdGRHDSCrJB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Feb 2025 14:35:32 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,  Phillip
 Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 0/5] merge-tree --stdin: flush stdout
In-Reply-To: <CABPp-BE3NtP463P4R+stzcQ_MufjobL-CX-rB=0m5gC0DzA9ww@mail.gmail.com>
	(Elijah Newren's message of "Tue, 18 Feb 2025 08:46:50 -0800")
References: <pull.1862.git.1739723829.gitgitgadget@gmail.com>
	<pull.1862.v2.git.1739895879.gitgitgadget@gmail.com>
	<CABPp-BE3NtP463P4R+stzcQ_MufjobL-CX-rB=0m5gC0DzA9ww@mail.gmail.com>
Date: Tue, 18 Feb 2025 11:35:31 -0800
Message-ID: <xmqqtt8rjbb0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Elijah Newren <newren@gmail.com> writes:

> On Tue, Feb 18, 2025 at 8:24 AM Phillip Wood via GitGitGadget
> ...
>>  3:  bf1dc603a15 = 3:  f95a15a4203 merge-tree: only use basic merge config
>>  4:  4c416850634 = 4:  1645b0e747e merge-tree: improve docs for --stdin
>>  5:  89722894c87 = 5:  a0179820092 merge-tree: fix link formatting in html docs
>
> This round looks good to me; thanks.

Thanks, both.  Queued.

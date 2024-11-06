Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5324F8A0
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 00:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730853551; cv=none; b=cl2jrNr88KwOofRJ7aQsl2Qtct/LK9QELjC1/4fZSjHSw5KsV7gogZhvWTLNgVVjX2o2AiYxA8Qb3JKpuJfZis+H4xOSud59ovLSJwjYnvw4QuAzpkj9DAAG3bY27P6WEPvQfTD1p+4xSoN+xr3haJzDAKD5zun1PTIozRO/1Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730853551; c=relaxed/simple;
	bh=AhMkfNUVhZvP5k66BvwlBw6mJq0oyBMbvbriVUu3cUs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HDx7ZtzVsk8pKG9IOJuWbuAWBNzlEcrpMfxACFxRAq1s2DGXrrJCyCvdoqUYwHlCsMDvF+AYSRS3Cz7t3dqpIU0zEHzPkIc82uj/pxuQldhlAWuauuv9ZvzJ+eohMBG3MNw1sUqR0tmtokWKvt9t/WL91e8hxjJcCV3kjz56NlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OSeWudhR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E8RvUGpy; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OSeWudhR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E8RvUGpy"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id ABBB211400FA;
	Tue,  5 Nov 2024 19:39:08 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 05 Nov 2024 19:39:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1730853548;
	 x=1730939948; bh=odqvh5v5XttD+BOGtQjHYSE+TZ5ECnchUSGimmcnZ0A=; b=
	OSeWudhRf1XnOA9qftXdY/UnY1addD1n6trcJFpvCHKI9qwc/QXwnmgDx7c791j1
	wCO96KAVjsr+P8lWzaHYlyTGoYLcB2ozmsOoBp6QCb07r8wqy3OdJCf7Db2Gs0t8
	9t6qdmexYTsU7m3JefS66ibuYm7BQa1znGp7gUN8PLkVGnRyWWFGIeCRRLnd2XPa
	UrLOxyYm+J8B1pEuYjtwpFQ9x6FRZaC2DoPpjoSI+/3lWZZzVs13R1bxuEGNWJQq
	jsjlVN8K2093gjVyIVYYoSeDdbytRc8Rr2EteH0Y6ULQ9GdUhTTB0ZQKPjVPfXqU
	/MEXAVggx5aPSPJIpED0eQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730853548; x=
	1730939948; bh=odqvh5v5XttD+BOGtQjHYSE+TZ5ECnchUSGimmcnZ0A=; b=E
	8RvUGpyz+Oi0eNtKGWyWqra0wiFck+q8KUJBVCg1+jGp1xqQj7A/OcZVDdbpaTzH
	Em+zCom13tIFV4YcORgeFPUDIuxUmFLTPz7/mjpAEQiaAE5WnZD06MEeCodN+ZrU
	3hWSbAfW8OUs8xz/Qh9A58dc4nA/ghr2hd9fqbnCL1Gp+nL0ECf2JM6+vNusIFfg
	nPp71pMs7cPFk66yS++hizrw0exG2MFzqwaplz8e+W2YNI0bHX2HERUStxVRl0ji
	XhngwLzdT7YHPSry/Bqa8xLPgKvRSBFbW49WGiyGE2+tsm7uoUVHYbN9WzVgHNSX
	sQw0PMrFgRgRxQJ/kPKHA==
X-ME-Sender: <xms:rLoqZ6bJHbdEYKiPwwFbjFEfEfBQHEzhILH3HxndTjc0cctNfiM6PA>
    <xme:rLoqZ9Yb2NuqZsDKxCbLsYoUTXVfjQxDduqR87272P7RNUBX0AancQAXulMtz7qNB
    HBdobDygTGd69uGFQ>
X-ME-Received: <xmr:rLoqZ092rvgHXc96uqOVVXBO5Jk7fpeahvDZ1_LzrbfMRSNwCW5mL1AB_zt5Vlr37PTPvoHP_byuh7pSxK9oR4ZWIIbHf0UBE5-r>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtddugddvhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeen
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhephfetvdejheduheegleehfeeivedtgeelfedv
    ffdtvedtudffieekieeijedvlefhnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehshhhusghhrghmrdhkrghnohguihgruddtsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomh
    dprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhgihhtghgrughg
    vghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:rLoqZ8rFSniIiphkcr7rdyd4oQAbOUX3fML93dF7JxYccrYZv0DOGA>
    <xmx:rLoqZ1p3BSTczg2zWvHcM3ReOZX_6vQKtLzTNIrcyQSuXSrILQgBrw>
    <xmx:rLoqZ6RJbdMiHLpuktSFi8_qmNdl0x_NX5S3hYBinNi1wrNJIZM3WQ>
    <xmx:rLoqZ1pEf8OKA2jP-0lKok7tHceYSHqtJFZqoz_j1w-dYWd4sM6DXA>
    <xmx:rLoqZ5JHeFFjDQ0_ORnR_nXmUzALr5CpKHQyN71G-BEcw1LJ79Puu4Hk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Nov 2024 19:39:07 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Shubham Kanodia <shubham.kanodia10@gmail.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>,  Patrick Steinhardt
 <ps@pks.im>,  Shubham Kanodia via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v4] remote: allow specifying refs to prefetch
In-Reply-To: <CAG=Um+3D3iGPRv4t4DcCP=Bh7gbAQ6cSJ79jmg2h-qbSiQRkUA@mail.gmail.com>
	(Shubham Kanodia's message of "Tue, 5 Nov 2024 21:56:52 +0530")
References: <pull.1782.v3.git.1726741439445.gitgitgadget@gmail.com>
	<pull.1782.v4.git.1728073292874.gitgitgadget@gmail.com>
	<Zym--GVNJt_lsQEz@pks.im>
	<b548c532-e54a-4edc-94aa-f3c2925602e6@gmail.com>
	<CAG=Um+3D3iGPRv4t4DcCP=Bh7gbAQ6cSJ79jmg2h-qbSiQRkUA@mail.gmail.com>
Date: Tue, 05 Nov 2024 16:39:06 -0800
Message-ID: <xmqqy11xqjpx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Shubham Kanodia <shubham.kanodia10@gmail.com> writes:

> I don't have a particular preference here, and this was discussed in
> an earlier thread
> where Junio opined (https://lore.kernel.org/git/xmqq5xrcn2k1.fsf@gitster.g/—
>
>> I agree that it is the right place to configure this as attributes
>> to remotes.  It would make it handy if we could give a catch-all
>> configuration, though.  For example:
>>
>> [remote "origin"]
>>       prefetch = true
>>        prefetchref = refs/heads/* refs/tags/*
>> [remote "*"]
>>        prefetch = false
>>
>> may toggle prefetch off for all remotes, except that the tags and
>> the local branches of the remote "origin" are prefetched.  Instead
>> of a multi-value configuration variable (like remote.*.fetch) where
>> we need to worry about clearing convention, we can use a regular
>> "last one wins" variable that is whitespace separated patterns, as
>> such a pattern can never have a whitespace in it.
> which is what my implementation is based on.

I am fine with space separated list or multi-valued variable.  The
only difference is that with multi-valued list, we'd need to worry
about ensuring that we have a way to "clear" the values we have seen
so far.  It has plenty of precedence and is not a rocket science.
The above, if I recall correctly, was solely about the need for
"catch-all default" (aka "*" remote) and not about multi-value vs
space separated last-one-wins value at all.  IOW, the above could
have been

    [remote "origin"]
	prefetch = true
	prefetchref = refs/heads/*
	prefetchref = refs/tags/*
    [remote "*"]
	prefetch = false

and conveyed exactly what I wanted to say in the message you quoted.

In any case, I somehow thought that we discarded the arrangement
with "*" wildcard as unworkable.  If I remember the discussion
before I left correctly, didn't it turn out to be troublesome to
have [remote "*"] section because existing code would need to
enumerate configured remotes, and we do not want to see "*" listed?
If we found a workable solution to that while I was away, that would
be great, but I haven't looked at what this latest round of the
series does to solve it (yet).  Perhaps teaching "git remote" and
"git fetch --all" to skip "*" while enumerating remotes was
sufficient?  I dunno.

Thanks.

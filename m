Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062EF148307
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 16:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723133953; cv=none; b=gs1/rB0AGyshWGW4fNvk/vdZb5h9E1Y1xIQLlH7yRQCx4ZG3p0VwdqMgEyTbK/qc6XVkLDQrcqNmFFWL4GcIv613lMNQeq+Jd0GFJUv8QKn5dZKmeWMjBhp/Wfu6X5aa87/dyllsuu8oKMNz+Us0h5IZpFJGcI5aaayHIFY7zvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723133953; c=relaxed/simple;
	bh=YvDVL5Xsn9iKFRAgfcBNQM2IHu69Yv5R5eS7UYK7E3Q=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=gbFGOsjDwiTumP4fTul1iaM2oD7vB9Ey5GWXArUnhdlXK7wRNx/69pJNfAE2VgAlU5WTzF+Xui5xIjikLyXuWeC6MECh3uv8oOOvS0/SoMhAD4lxplzcRVI8TaMCdnhaXClMai39BuVurYIXj9G6WLmt20glpHF57HOnYOv2sG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mCxWzWpq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R/ssRrEg; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mCxWzWpq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R/ssRrEg"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id CC704138FC13;
	Thu,  8 Aug 2024 12:19:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 08 Aug 2024 12:19:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1723133948;
	 x=1723220348; bh=F/PKljtpQBsuVoukp2/yd4dgMceP+hMbT2TSxK97Hj0=; b=
	mCxWzWpq8CNu+U/dPFjYPqxJagKjo5ky4+tJcoh+/3jwpvu6GrXHkIoL+WFZKxH/
	wsy/73hg5VYm+c7hhwucO9LTZcrPzwtu1pVRRsHR3SYdg++cVsaqv4wncrLcx/n+
	UFLyhxWY4gRlkLPAB1EMwSHKWx+K+JvgHwDtG4/XDCM+1hZdfsVxMNYPflDPvKcn
	JCZbIecYla1xdV54i3TjG/lr2tcAQmT3gfQBU3lTKa+HMeL9jfx7CuFzkCs+t+YU
	Osv2phwFX9KUN/feWgwHd68CZfd36oAiUILB0/fsyjPQdNEDDv8S3syERVqP9hW1
	2t3N7uJQwvQRSAts7q6gRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723133948; x=
	1723220348; bh=F/PKljtpQBsuVoukp2/yd4dgMceP+hMbT2TSxK97Hj0=; b=R
	/ssRrEgttGLgMpMa7RdnnF0O/27l4V5YkTn9YmDDSkrWR41xBP3PFWh/bTKYAHME
	w6h+I3V9RpHRq3zKl7XrL1wVoNYNQoyhbL5NyUEXg5nVLr3jSHDi0/WMrA0cE0qv
	UukszLGfyKUAljJ2mCRZpsg+DiE5YHuqLt41hYdOVbDtDgzhEr3LdDAY/n4DFga6
	GZo8UMrVKB7/ROXm5FdpAQ6eqZQYygTw/PZ141U8FS1V9ktfC4AjGWEw32lK3wXb
	OmO/xKH79aT0B4yN9XhKnj1XuyjlbbYcC/AEZOqxKF+qiSltFCUgT7yW41AwA3Ac
	7vlaGuZrYoCJ92pBmbP8Q==
X-ME-Sender: <xms:_O-0ZlfH2Id5rOWHJxars1Ekqc6LIosh7vO_AdchX1OaLDt8gf43DA>
    <xme:_O-0ZjMmjxgEHXwV5DKLZK11vAsYU5Wg1Uzzl1ld3JRwRjctMLgk3aKo_mEtwGMe0
    inXDSxEeHVucDnDcA>
X-ME-Received: <xmr:_O-0ZuhtqXlMhqSZDptaxX7pUvTFaEiZhOGtxEZcr5CgERv9v1x9R-7_4U9evHkc-zZBXm1YcRtYOUM6XRDED7JtI3M1xnRZHmFebXQZlw8zxd8i>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledvgdellecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefujghfkfggtgfgsehtqhhmtddttdejnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeektdegtdeuhfeuuddtfedtffdtleffffffvdfhvdejhfej
    kefgtdffveetfeevueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtoh
    hmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhholhgrnhgusehgmh
    grihhlrdgtohhm
X-ME-Proxy: <xmx:_O-0Zu-npcwEo9FF8tsQl2mx_p2bYyT7s-7gKJgQAZ3v9TsPI-qFPg>
    <xmx:_O-0Zhv_AEY6p2zPKkCJEItv6cg05dWG2LcGh7P2WblejHeH7an-0w>
    <xmx:_O-0ZtF8acuJfZGVuI7U3xsWEHvxiebXqdAQ-05Q0r5nuRAYZgF-VQ>
    <xmx:_O-0ZoN8VyP6z_NgluF5Nxd_zTOb9VUQs09Hs59V5005I2mSsQgKzg>
    <xmx:_O-0ZrL4fJXJGiVlDKrO8KnmY3D3ueQymi6cIfQKJcaY3SCwIgJ5Xuzg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Aug 2024 12:19:07 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 64df5825 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Aug 2024 16:18:57 +0000 (UTC)
Date: Thu, 08 Aug 2024 18:19:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
CC: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
 =?ISO-8859-1?Q?Jeppe_=D8land?= <joland@gmail.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_1/6=5D_builtin/submodule=3A_allow_?=
 =?US-ASCII?Q?cloning_with_different_ref_storage_format?=
In-Reply-To: <xmqqsevfj8v2.fsf@gitster.g>
References: <CA+osTZVApTAMogBDMaPDEVViJHrFT=BOer=Py4fjTvpsifzfKA@mail.gmail.com> <cover.1723032100.git.ps@pks.im> <a450759bd1e0d84192fd8b278b660fc8527369ca.1723032100.git.ps@pks.im> <xmqqwmkslz7m.fsf@gitster.g> <ZrRtB46vu9rC000y@tanuki> <xmqqsevfj8v2.fsf@gitster.g>
Message-ID: <E664DE72-49F5-4AFC-ACDB-0BB60A6C34C2@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On August 8, 2024 6:08:01 PM GMT+02:00, Junio C Hamano <gitster@pobox=2Ecom=
> wrote:
>Patrick Steinhardt <ps@pks=2Eim> writes:
>
>>> Presumably, if the named submodule has already been initialized, we
>>> are not converting its ref backend with --ref-format=3D<format> option
>>> when "git submodule update --ref-format=3D<format>" is run=2E  Would i=
t
>>> make sense to say it is an error to give it without "--init", I
>>> wonder=2E  If so, we probably would need to see if other existing
>>> options like "--filter" also need a similar sanity check, if not
>>> already done=2E
>>
>> Well, even when "--init" was given it is not sure whether the ref
>> storage format will actually end up being used, because that option onl=
y
>> tells us to initialize uninitialized submodules=2E So if the submodule =
was
>> initialized already, then the ref storage format won't be used=2E
>>
>> We probably could add such a sanity check=2E But as you say, other opti=
ons
>> like "--filter", "--depth", "--reference" and "--recommend-shallow"
>> don't have that check, either, so it would feel a bit like opening a ca=
n
>> of worms=2E So personally, I'd rather defer this to another day where w=
e
>> then implement the check for all of these options=2E
>
>I am perfectly fine if we stopped by clearly documenting that these
>options can be no-op when the submodule repository already exists=2E
>Failing the operation in the name of "sanity check" at this point,
>especially for existing options, does not sound like a sensible
>change=2E
>
>Thanks=2E

The documentation already points this out, as we explicitly say that it
only has an impact on newly cloned submodules:

> If `--ref-format <format>`  is specified, the ref storage format of newl=
y
cloned submodules will be set accordingly=2E

I'm happy to make this more explicit though, in case you don't think
this is sufficient=2E

Patrick 

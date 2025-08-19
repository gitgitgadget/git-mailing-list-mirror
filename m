Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADE5251793
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 17:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755623606; cv=none; b=hv6cAzl9msRdloxja+q2xAr4HUFlf45CIIuFbPJa44y8pbUzFjyc/SPfO1N0VEHAWFlh28Wr+ZN7WTBZfHgtBIIMhAKl0JF6MbgJjPBnQMQykVzpYQXVDvlHmvtr9LX9HT9VT8lXRjKjLQSVaGQ0sUY9NpzpkfuvDB0xNt0H/fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755623606; c=relaxed/simple;
	bh=vu4r3BU6lUgT3pIpS7FMb8Vo86GSQyJ9y5YcZrPVd7s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fNFgViQSeqGDSkkx+UrnueWhZY/IKBQ556hBVUxFX6fQDBmPV+sY2TQhlccxxFVJMrBAPIZXW/DcCC1fBwBos1aFmQuwXC+Lvgn8wFA6Q48yQftB/O8VllFW0gDR8CSao1+cGOqv58HOUQ0lejVnCf1YHK/zukZVdIPPdtjGFjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GnqlUrF1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R+Z8L+jT; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GnqlUrF1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R+Z8L+jT"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3B3927A0259;
	Tue, 19 Aug 2025 13:13:23 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Tue, 19 Aug 2025 13:13:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755623603; x=1755710003; bh=8sUxov41n2
	sJ0ebdukni3ewhpd8ZF5W5coijH8Y6bn0=; b=GnqlUrF1cBDgrLEuIJNX2K7wSg
	byA/WfNvHJYcFV5ZQ/i8RmdTh4u4tkVAUIlue3PvDOnujliR1161RW6F8UhnEHN0
	3ST8+aLaJm+E8V/YffkIcZVKf+MjOqQtyrwUpxK7WbuUwTczNqfQTkVt7lRrD9a7
	ckS3r6kFlbpvIAAQ6KZtuJIvc2U9FTV/gUI1aDZRQTPcniP36QuNN9Ye6u/vZNyT
	xCqRZSvFpBqHoPqN9F7TJZyIefogX50G6yL/N723BSeKtD2oYuFhfdI+TZuYwI/6
	Ctw9rZb7IXEtP5sL19vpUjxxYdrbhk+5m+FNNrB7/KjYI6ELQJ99HusL/2ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755623603; x=1755710003; bh=8sUxov41n2sJ0ebdukni3ewhpd8ZF5W5coi
	jH8Y6bn0=; b=R+Z8L+jTv9tl743WtjrLj1WsnskjjngL4HX7RljbgdBAsiKv2Zf
	3FDp27vC98pceOTI5xhoUFR99UQ/uSHTLfS7C0v+Fi42aORjN3x2rp8CQAw77z2/
	igkpHFSbTNPZ/s8kQGLhzBzw5k1Fqg7BZVtMrBc6VtZJ7lYyi4D3kLPaNn89Toaq
	waMsK7TsBB9S53/2VQWziTDN320z46Pw6vhq50tV5ES2tiCgGGZ7UrBp5JKTu4Re
	gqABe89ObFBWz1ZkX8Tj2uqO1bDn7kQOaC6nN/eCy856WIFVMzXACO6MBVbDsO8a
	y1uiHHcNNHt1Z9V1vOFn4IQEpQdQpwg8EPA==
X-ME-Sender: <xms:srCkaG_b1l_m65_bDAtDGpvpsQYX5YpoBrzRRBTaV0hbtAieF319kQ>
    <xme:srCkaJ8wc5js6y2xRWEpwHMwRgjqAdkWo1dJPy1n_k5qUg8FPCqNNJkBs6elHd8vl
    WM9aZtXvU4RwA26Fg>
X-ME-Received: <xmr:srCkaFcRGQR8MLZi-FKcjf1iVa5cIklUcClJPolcpkJT9w4WIWQvYrzZO7eLaoVLjYz-S7AeHsON_aMctFkzu9LCHCoIPmlO4DXHx2g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheeitdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:srCkaKEH1hwnpppuqkb4SXI3XyJjoodKr0itd_q3KQ2yso3GD_sWbw>
    <xmx:srCkaLdm-UKqlNqWBpKemTVUZIzDDw_qjN6v77Fpkz5IWYHjWvEjfA>
    <xmx:srCkaMEvAGd4ZMNMXVO0O71qv6nokW20OZrbVAEHC_BY_r1p6LsFfg>
    <xmx:srCkaMV7Fs1sJQJyAJNoRSEnW4yZeDZdL-LT2OhG4JqeJStPV1RshA>
    <xmx:s7CkaBi370nW1Mi4vQlgQPcCwpYfddwW1XS98KSByfZwwYwkXdNEGsI2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Aug 2025 13:13:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/16] packfile: carve out a new packfile store
In-Reply-To: <20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im>
	(Patrick Steinhardt's message of "Tue, 19 Aug 2025 10:19:29 +0200")
References: <20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im>
Date: Tue, 19 Aug 2025 10:13:21 -0700
Message-ID: <xmqqldnfdyku.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> So we don't really have a central data structure that tracks our
> packfiles, and consequently responsibilities aren't always clear cut.
> A consequence for the upcoming pluggable object databases is that this
> makes it very hard to move management of packfiles from the object
> database level down into the object database source.
>
> This patch series introduces a new `struct packfile_store`, which is
> about to become the single source of truth for managing packfiles, and
> carves out the packfile store subsystem.

Nice.

> This is the first step to make packfiles work with pluggable object
> databases. Next steps will be to:
>
>   - Move the `struct packed_git::next` and `struct packed::mru_head`
>     pointers into the packfile store so that `struct packed_git` only
>     tracks a single packfile.
>
>   - Push the `struct packfile_store` down one level so that it's not
>     hosted by the object database anymore, but instead by the object
>     database source.

Makes sense.  Each packfile belong to a single $GIT_DIR/objects/ and
together with loose object files in there form a set of objects in a
single object store.  When alternates are in effect, I think we
still out of convenience link these packfiles taken from multiple
places into a single list, which a series like this one may have to
untangle.

Thanks.

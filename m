Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022062D7DF2
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 23:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774048168; cv=none; b=tRxCHkjp/WczThP7sPItHs82KP1TvQXOOjRcqM9aLXI5H6T3WcMdsjl3g3icDbJIUviCfN0gJOy58JXRx5nlvAw/i+ZO+Y4ezN43fJL4OG2Y3d52TbsrTmtcpEbefG06jF6zFmniYZcepOMtj+XEZH0MJ02JpcgzBGcR7fzov9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774048168; c=relaxed/simple;
	bh=Ma0cDz6CLwu+tdLIbvwE3IapTXL0D1BMERFDt540qY0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Hb+ksfnUyRyvScPC2w3TMqsDPMB+ayxkJysNA9lXlun4x7kpw3z1OqAbUUXa48VR6vE4Y/453YmSD1IIrYj5aiRvM0g0JvNlPwgktRRnmO2tiqEkMRxf7KK+T8TTplw0NUTtbB3ltZV+ZFZ2CGFLIrDeDVtieHkcS+wJBZaqwSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QwpgviJq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MrIkD175; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QwpgviJq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MrIkD175"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 276E11400258;
	Fri, 20 Mar 2026 19:09:26 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 20 Mar 2026 19:09:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774048166; x=1774134566; bh=e1Wx8quoRj
	hWsk5eu7lR12axVEr3rGqC6q1csKignCM=; b=QwpgviJqBS6+cUc2CvgUZLGDAI
	HWdLTtktI8TH4E3d6WcbHbQE61gQYv/5J2d8bEH/ns5X4VpxUyoCTVYCsCDybJ0P
	4mVV8BnCoGmdJppjvMyDYwTDB7CpDe65iw6cfZRXv0Jv0dh2a+SFLmDcuJB9oAZO
	l0T+Mu8T+8YO9kp8e01ZlTXFRPjKXTVQtbYiY5498OGAqCaFe4I6PKLzgZif9Y0U
	0IZGv7rGcQ8QlYuRQ/wQvOSaRFHt3s7AkPZpHQHBxZXX6zp9WqgMyH3AnI8ddCZR
	bIK1ZY91xFuV4AmI3LuMEwMQ+tiSFQkg5Ale+gf3LUPsYAN8XVzIHVId08tg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774048166; x=1774134566; bh=e1Wx8quoRjhWsk5eu7lR12axVEr3rGqC6q1
	csKignCM=; b=MrIkD1758u38sR9EhUgbqYynE/88+F00NxMIFG+X5pgMmEUdcIm
	YKFzBKieWimjKJrqztcbQXispd6owNJB6S8M/KPoKVv2W/ML9cp5QGkuedgUgW3h
	8acqRrMVt8ei6GfBl416bGFyXxlWS+TD7VDQMBR4hHRSIhWNdYdEnEME/pArS/cT
	Qg2uHEr4EIzk6XbH2lQUr4hKhMvqkDonP6y84Ao3yo0oi47XrKvMkUjhIqUOnOuy
	NdzZdWWqvaG59ItDmsVsOakjxTTsvR9PRhIy7FEbRWXZ+LqbvNs8xDUr7jeDFYjj
	88OUQrOdVDffG0Qbpgfs4cnZq/kkI/GZ74A==
X-ME-Sender: <xms:pdO9abaprM2kDYl8JTaLI2syvjV8xWLY9irugvzCj57RStlH-UlG8A>
    <xme:pdO9aR2-l6wQC7O3bIIW95hPRMZiEHF-8o3Ab6W1MZ8ZmPKHyzSLKQ1aMmffkk1Wu
    SoZBFbeMDZVmtzMHQXjZ18z_VIcDVslAeedK95MJbMNiVZeMvubKaY>
X-ME-Received: <xmr:pdO9abUIpG46EyygL1I9_OOJQlPU76teLEnwv0J2zje4PtBfz_R300XiKSRZGnqk_IMxN0lf5Xq0iWr9Hs-4Sh_NtPToX8nagw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudduvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:pdO9abXWUGEfrWLHmliCfthROlkaqTWMjwAQotEc_G34EMPVrvV0Gw>
    <xmx:pdO9aaeEj1_TZ_sGZ71_4NslewtD1rmjIDwv0ha_Vv_pQ5R3FuOqLw>
    <xmx:pdO9aUUGz8fSk6FmDbpQHKZTv5l6LgQcer1rhu6x0PPrdfL0-u4RNw>
    <xmx:pdO9aTezNh6u6oguDh45zxPLxQV-65kdzGqPTGtt85-AxH3zJR0IYA>
    <xmx:ptO9aZ9-ZVqDMFCfVYkz-q9OpZJ8Rj2yUMSNGpfpWsBsDPq3Jj7RNE-m>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Mar 2026 19:09:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 01/14] fsck: drop `the_repository` in `fsck_walk()`
In-Reply-To: <20260320-b4-pks-fsck-without-the-repository-v1-1-6594f997926b@pks.im>
	(Patrick Steinhardt's message of "Fri, 20 Mar 2026 12:47:06 +0100")
References: <20260320-b4-pks-fsck-without-the-repository-v1-0-6594f997926b@pks.im>
	<20260320-b4-pks-fsck-without-the-repository-v1-1-6594f997926b@pks.im>
Date: Fri, 20 Mar 2026 16:09:24 -0700
Message-ID: <xmqq341udrob.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> The function `fsck_walk()` and its object type specific functions
> `fsck_walk_tree()` et al implicitly rely on `the_repository`. Remove
> this dependency by injecting the repository as a parameter instead.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/fsck.c           |  6 +++---
>  builtin/index-pack.c     |  2 +-
>  builtin/unpack-objects.c |  2 +-
>  fsck.c                   | 40 ++++++++++++++++++++++++++--------------
>  fsck.h                   | 15 ++++++++++++---
>  5 files changed, 43 insertions(+), 22 deletions(-)

OK.

While the conversion is cleanly done, the resulting code makes me
wonder if fsck_options struct

        struct fsck_options {
                fsck_walk_func walk;
                fsck_error error_func;
                unsigned strict;
                unsigned verbose;
                enum fsck_msg_type *msg_type;
                struct oidset skip_oids;
                struct oidset gitmodules_found;
                struct oidset gitmodules_done;
                struct oidset gitattributes_found;
                struct oidset gitattributes_done;
                kh_oid_map_t *object_names;
        };

should gain a repository pointer.  After all, these oidset and oidmap
are about objects in one particular repository.


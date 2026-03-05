Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3086B2D9492
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 20:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772743342; cv=none; b=LbgRtv780aQYzNkZeH/kMMpn2ia6HPyom5VexqigBcmeGtDeCZ1bt2CROOpCsbXIFc36BlgF8ODhc8eSwehwbvhQrlRSRF6BPLjuF3WiK68YTMazkqWBKKLIs+516blUB2D0pUwJpQkGAcozKGteV7YuV1dJo2EUN+G1M7W1x2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772743342; c=relaxed/simple;
	bh=DzBjGWBcQw5IO/9u5dtyvdfrq8Gy3FfVfl8Ck43mfcQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EDK+UxUNMs9u726+BoazFFpWHfNkqkaG+gCaVUOpbE8UR5/yFtCtBwpKFHRzRa9uT7M/91dhANAb4DpDSL07WHr+EcknJalvAAlnb3SyOyXWzKT+dJNURnIDAJ4sZfgVrimoE4wHKSHc+DqeQsWfJxFWAWKs8uI+ZVRkEEc4/zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GZYRYUx8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i+srxZ7K; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GZYRYUx8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i+srxZ7K"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 69FB8EC0571;
	Thu,  5 Mar 2026 15:42:20 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 05 Mar 2026 15:42:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772743340; x=1772829740; bh=/lztjtFXTO
	V/bBwQvqHpd/QaNS3ZFf+hZWg5/vwLa8Q=; b=GZYRYUx8ctu/ZPpG1KsYvU7Asq
	SN08Q2Gzk79H6+TUys5RSh9/3Wv1GwVfLYAWzmivf4Q9ip6dPrzo1baN4f/kSaqs
	u5mwsDcLqoFT+hvYmvmtaUeoKTCVq26Ny1m7DYIbfqjggoTvD0JEJ52pTm+ndGVH
	PVulONFwyKCQG8e2/g9agzzyk3U9VnCh+vI3B9+7yFuWGs33sdxm6tPRbNqjVpGN
	flfZAYHRk627iwSAMrOsI8wfglVF6oZMWqCEQMnUC3Qc2RdZ3MwxWvrH6v3GeEnB
	cuTpeY+YAvFxQGC8yJy6XR5GKGEuQS8+Y9ZdhepEBmD9fDAEMaDwGmq8Nvbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772743340; x=1772829740; bh=/lztjtFXTOV/bBwQvqHpd/QaNS3ZFf+hZWg
	5/vwLa8Q=; b=i+srxZ7KbDhQwxaFH2hdRjGa9qS/um3av7ywFjsdsYObjdAGz/c
	fj3FJ4e4NEvNIENZ+7nQl0AWr1hvSxX372+1HkP+6goeaK1ZOs33fNldrceN0evV
	ZsMjeSkZKya7t79uXXVvbQhn3u08xHs6H/6fQLzDV12yoPKcgOQUJrpzgIbj+9BU
	F0stIAkvvTz34GUAFv8vaswuivb8P15X57NbpFVqV5PCU0TGQjQGgXQgVaYW2MmQ
	0k4l3CcpFdY6OORcBz7dylmbnPE6taYP2bM6b6RQvXv3lhRJJB6sZLJdI/bTNfH5
	U9/oxi1t1zUEI9O4jyVDDQCPwdMpjcbeTcg==
X-ME-Sender: <xms:rOqpaf7elTvT5q2h2UvllOSQ7YurfYTeiLy7b78cpEzspQQjJtXW9w>
    <xme:rOqpaQa5Yn7dFhgk1K2qDn1BNARIAC66SGj0tskznY-khs-Qkmp8KsiG28HIVOU8m
    J47lmXXPxPJ9MOlCNpsvr3qlb6szssGbITvo0_GyJ6ffEoXnlTa>
X-ME-Received: <xmr:rOqpac5Vbc1h7T-OEpNEVoIzWycKKYSXhps7c20yrAzzuftjXiDWMG7jlh3b66dzbZ0kaYaAZ0VqMEqVYEPhHUQ38Yj4ftPZpg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieejfeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:rOqpabBZoqWgo5tT53Cg-8KZNfevBgrGIWVg3JMElI6xMA3xMuXcyg>
    <xmx:rOqpaaep8LTijaUSXH5Te5p4Z9xSIpCg0f7B50U4sh-icMq1uQNwjg>
    <xmx:rOqpaSKOEdHjbHs2baHDIybeIUut15g_Ws9QTW_hZjfZ54qikfz2bw>
    <xmx:rOqpad1R9USSpO0YY6GldA5e5O4cOZpospFHOLOYlL5TqXbolttWGQ>
    <xmx:rOqpaSaXD04wyCNDzP16q42tu-lf2eXvNaHgd_C8qppWcOqGlm2TWjqY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Mar 2026 15:42:19 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Justin Tobler <jltobler@gmail.com>,  Karthik Nayak
 <karthik.188@gmail.com>
Subject: Re: [PATCH v2 00/17] odb: make object database sources pluggable
In-Reply-To: <20260305-b4-pks-odb-source-pluggable-v2-0-3290bfd1f444@pks.im>
	(Patrick Steinhardt's message of "Thu, 05 Mar 2026 15:19:40 +0100")
References: <20260223-b4-pks-odb-source-pluggable-v1-0-253bac1db598@pks.im>
	<20260305-b4-pks-odb-source-pluggable-v2-0-3290bfd1f444@pks.im>
Date: Thu, 05 Mar 2026 12:42:19 -0800
Message-ID: <xmqq4imu2el0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> To set expectations: this is only a start, there is still functionality
> missing that needs to be made pluggable. Most importantly:
>
>   - Counting of objects.
>
>   - Abbreviating object IDs and finding ambiguous objects.
>
>   - Consistency checks.
>
>   - Optimizing the object database.
>
>   - Generating packfiles.
>
> These will all happen in later patch series. That being said, with this
> patch series one already gets a lot of the basic functionality, and it's
> almost possible to do local workflows. Only "almost" though because we
> rely on abbreviating object IDs in a lot of places, but once that part
> is implemented in a subsequent patch series you can indeed work locally
> with an alternate backend.

I've been looking over this series, and the transition to a pluggable
interface for ODB sources is very clean and follows the patterns we've
established for refs and streams quite well.

One thing I am puzzled on the design, specifically starting with
patch 09 and onward, is the lack of documentation regarding which of
the new callbacks in `struct odb_source` are mandatory and which are
optional.

In `odb/source.h`, the static inline wrapper functions dereference the
backend's function pointers directly. For example:

+static inline int odb_source_read_object_info(struct odb_source *source,
+					      const struct object_id *oid,
+					      struct object_info *oi,
+					      enum object_info_flags flags)
+{
+	return source->read_object_info(source, oid, oi, flags);
+}

If a future backend (say, a read-only network proxy) doesn't implement
some of the write-related functions or the iteration functions, the
current wrappers will cause a segmentation fault.

Do we want to

  - Document in `struct odb_source` which callbacks must be implemented
    by every backend.

  - Have the wrapper functions check for NULL. If a mandatory function
    is missing, a `BUG()` would be appropriate. If it's truly optional,
    the wrapper could return a suitable error code (like -1 or
    `GIT_ENOTSUP`).

Given that the "files" backend implements the full set, it's easy to
miss, but as we add more specialized backends, a clearly defined
interface contract may become important.

What are your thoughts on which of these should be considered the
"minimal viable" set for an ODB source?

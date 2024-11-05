Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701831714A0
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 06:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730789705; cv=none; b=fhS0dy3ao2ovEBERHRP6r1WSzFqVWeWdoW6zKEexq/iKA3/CfJMeOzRekfrh/zam4ueS6AYrSwpmFboXN5DT1/clCyDO2OXsan7RgNZKFWzDkO3A9KoaYu+won/QkXWaeVaMpPVdnrX1bRvHMWmPtNbX1NnWWbqlD8BEt2yuooQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730789705; c=relaxed/simple;
	bh=fTQacaQHQrCokVb/JpffnPqFpnhWzKW3Yz5Yilqk8ko=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bt2ysttPZGthoO0eFiqCxgiZZRA91FLljxYP959hTZJi56C3U7lzXNuYjSa9Obx5Qk9ne3uxiXDdXimt0uUnlMWWskIk+XsT7AgTvZT7A2MEFVrOpQjHrKHvdjhsDsx/Tv/VPIYFu1ZkLSqcY490BP3Oz/OEzuZuxjCqdg/2cP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dexBh+i+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JTQYXS9+; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dexBh+i+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JTQYXS9+"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 6DF1011400E9;
	Tue,  5 Nov 2024 01:55:02 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 05 Nov 2024 01:55:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1730789702; x=1730876102; bh=MSy2LjxvUJ
	juXvMm6COh7e99iD4PvRb99Ixc2KE543M=; b=dexBh+i+2N/J8xErHZc7SG+iPG
	2kDafUi+647tjrwmi5X6ThiwrCz2kEw7YvqgxvRw8yB2sgY1UCGJT38bk4G6KEQb
	axD0Gm301IPgZapazdzRZjPt/Vrl//u6S5CXN66iRyoYVLE8HzOOeX1DQVBwbGYS
	C+rmf0W8OcpU0ioyzt2QLP9QJjAs1lY5U+bnfCj0JA65MW3dh1zvhnZoxlnIjPdR
	ipjkJiNLKFJH6KSmY6yUMbtbF721QEds2pDKj/OWQXaT4tVIaOQGqX4IuBJjPcAt
	P/2G2qLxtd2uK1C9u1zGMbcCqOunAIdi9rAw+QR4Djl2Nf2cJlaCrfopxH3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730789702; x=1730876102; bh=MSy2LjxvUJjuXvMm6COh7e99iD4PvRb99Ix
	c2KE543M=; b=JTQYXS9+paV5Ybr+WSUzv38FyYde7vLGqdTJSP3JGt26uM4tRbA
	gMLyljxDmCeFnanKj5xGqRHHJQlK5WApWqu4AryW94U5fwdBCuSE8l1PoPvfE4Rn
	K1ZQowro5feiTcmpSKBNy/n0OfVmPIbFpVhz5DU+I+eiaSHhI5XXDyv1T3B0E/sC
	xSgrMXMPEScbJWMxqPVAYpKeQAk1fRy9TuRrovrC1BOySCDbCIOmdqz/rg3YO8bC
	VH/6TYZacDtV0SYNzOXOIggYMpMSBW72JNh2QnjxvgrimRfyLId6xjmcuH2g/ulx
	CZu6VxhRhy4PqNC0HwrsGWJPsLE/IzrJECg==
X-ME-Sender: <xms:RsEpZ_J6v82OibDulmlvWrXo7BJxGuvXLSzBueW4PPXNDqJ0FdgSeA>
    <xme:RsEpZzLhCh4F9ZjRljlY18z3mWGB5_htH6bHyet-bPoUAk_ugHLewGmyzSpDaF69K
    u4jCC1Lr5exlPCGfw>
X-ME-Received: <xmr:RsEpZ3smbX7gBlf7lUHZcTMjtQs6joP-dGSQ_Ef7e-CtMo0nnz8ICm6Xh-vInolECX6-yMvbNzW7ke-i6DFzJrJ08fcjmZQDhJ71>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeljedguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvgifrh
    gvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:RsEpZ4ZQU00m286UcslcEM8Lvgn4Xg_OJKSGVlXKq4SQPzUdot9u6g>
    <xmx:RsEpZ2ZxnXKRgTejc9M2CuyeAQqppfmu7SZyKwlvO5OaJEZtUGNDtQ>
    <xmx:RsEpZ8CI2b-TIRhg8nxkPmaxRUwyzYX916VM6_9iRNyFrlaYrEJ34g>
    <xmx:RsEpZ0ZLGSQ98_E8oneshFxU69_5Sr1bDvhVSEVh7xwwLpcn5AqN4A>
    <xmx:RsEpZ9y6RmUh3-oE62G7WxYH5YnyC71JK7O_TYFb6BIfj6VYTlEMTLFE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Nov 2024 01:55:01 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/2] doc: correct misleading descriptions for
 --shallow-exclude
In-Reply-To: <Zym6723csrUdiC5A@pks.im> (Patrick Steinhardt's message of "Tue,
	5 Nov 2024 07:27:59 +0100")
References: <pull.1822.git.1730746964.gitgitgadget@gmail.com>
	<4c7f2dba686266be50cf11420beca633e1691dd4.1730746964.git.gitgitgadget@gmail.com>
	<Zym6723csrUdiC5A@pks.im>
Date: Mon, 04 Nov 2024 22:55:00 -0800
Message-ID: <xmqq34k6tbjv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Nov 04, 2024 at 07:02:44PM +0000, Elijah Newren via GitGitGadget wrote:
>> diff --git a/builtin/clone.c b/builtin/clone.c
>> index 59fcb317a68..93fe6d69659 100644
>> --- a/builtin/clone.c
>> +++ b/builtin/clone.c
>> @@ -147,7 +147,7 @@ static struct option builtin_clone_options[] = {
>>  		    N_("create a shallow clone of that depth")),
>>  	OPT_STRING(0, "shallow-since", &option_since, N_("time"),
>>  		    N_("create a shallow clone since a specific time")),
>> -	OPT_STRING_LIST(0, "shallow-exclude", &option_not, N_("revision"),
>> +	OPT_STRING_LIST(0, "shallow-exclude", &option_not, N_("ref"),
>>  			N_("deepen history of shallow clone, excluding rev")),
>
> We also need to replace "rev" with "ref" here. We already do that in the
> other cases.

Ah, I missed that one.  Let me locally amend, as there does not seem
to be any other issues.

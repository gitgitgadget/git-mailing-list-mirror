Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C263123741
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 04:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772684028; cv=none; b=hL72w6jzK86EhuEOhLSsowH/gZvH8Ole0VLhHQzQfekLe50/1afQZymZ7q5if3Ck9/r6bR93btTE5jhg7NwpR1B3/J5F27uX1n6oSnW+/8xBofuNEqLsPKKyiaNcg3xIZiV9Ch/G11EcTcL+LgB7liR9SGpc4gOgsYOrilOXkzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772684028; c=relaxed/simple;
	bh=hOurzCEZPIV8k7zRvlLhG6f9s7kX5igP5GgYmTBKXn0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l1eu7cH3FQnAmCDuyDIIIuZBS9CV51dwHBxasykvYBqkSbr+qJdMchXCChsA/n6rQPgNiLSajBpfvGgFyVNoTkcS9uWgH4SC0+OPHQbjRKuGfdg2vG2EBp7fiSTW4m2IneiO/QeKCQDR6ujltgKJNhIzDUmMZ9Tl9MKhKw0Wv4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cPOhIfvG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q6bXA/hz; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cPOhIfvG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q6bXA/hz"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E8AE214001CA;
	Wed,  4 Mar 2026 23:13:45 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Wed, 04 Mar 2026 23:13:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772684025; x=1772770425; bh=hOurzCEZPI
	V8k7zRvlLhG6f9s7kX5igP5GgYmTBKXn0=; b=cPOhIfvG1Fgx4QoO1yrmmJQuBU
	sqnTBQ1ZufhHkRlGbIxjUk11SNnyADvNVFZ9Mnk4S3pW0R+0P9InY/2WJYILlaTd
	ToAYIkenoVpRi+JtAeVL/yJObSFX4Kfj9OkmvgQ7n4RGGGP52Bx21Xcu4kBUYq7g
	EsmHs8iHRvs4oq7hy0FR+6merzTM3eceV+NyEzzptn9gZ2PNOe37S1x/2AWMvZh2
	foc9wU31wAqALQy948fYpqfvSwtCBTgsgCEc+pGZtrZpsLtHp4+uUgF72uFIpahz
	YG5Xf7xyB6TDNY82sEOaSRUGdUgvs8wAu6D1VS93B8YHcoXvmFUtedVR8afA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772684025; x=1772770425; bh=hOurzCEZPIV8k7zRvlLhG6f9s7kX5igP5Gg
	YmTBKXn0=; b=q6bXA/hzW/XE3TZjWdHcT83+8lStMyP2uo7oUUy0blWoiJ8HzRu
	wgbOwgKcysj/FibM/PyvSU8AvJyPUqIQYH7L+SR7Fxb9SMWpoY0lqTiW0Mqvthq3
	SM8TvQjHR9tFmLf/aMELe0a1jel4bU4vIOQlnYnN+FqKpuplJjt/MRbEg9xifBfR
	wv7IECYgetW0eR4aPHe7QnXmjsg1oUg4+W3StH/stBCk6FFc7Ja/3OaLtCdM22Yf
	GP9Ki85vSc6UObBCy6/GlSm2VuX5PHW5c42eVfDez/GjQ+BtTaYepPEzsAHCuiTI
	BlfMW82jPxddIU8K5Rw6GTjmX0vrT6QiuVg==
X-ME-Sender: <xms:-QKpaRdRpawI3DjJzJR7EkwGblz0TJ6TgtdrDUDh3NVTFaiTtOosrg>
    <xme:-QKpaWPxoB9Q7yMDUZ4DMlJFP-vgiLL-C1RAXJkbMMcsPE5Jni1dW8Mc-4dZ3MA26
    c1JuzCe4nQrgvgV1TcJz8yPKeCX2oqD3uEhHWeqBjKbu9j0DFeiNKg>
X-ME-Received: <xmr:-QKpafjGk98RBfJVExWA1H33hxtGWNmbg0jU2WBX7xXOBCJzKtqtKtBMtvMa-YygufS4ujItNbHzWlWL3BNJ49KvJQaHBIXINw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieehfeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgruhhlsehprghulhhtrghrjhgrnhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhs
    sehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:-QKpaZ2Vbky7l2LaT5UfqgdbE4AfXeASdZHLPR3e2E6iSy5zC8w6EA>
    <xmx:-QKpaZj3faXrFZbE3-0hWKTLa2Sr2M5NNvrnFvnl_OhodePlKG8K1g>
    <xmx:-QKpaZdJywGAcOX1iqXmVHT7iSsgeEeDyWm7mh-bFHs01SazgFBh9w>
    <xmx:-QKpackSy7idozETkDVMBaspSUwGCC9_LlgZv9ZewOKT7KdoLfVRjQ>
    <xmx:-QKpaZtFHXSOvhtHmf2Y4v7bA6jYTMDIqduOjq7sZGo2L-kam-BtQCdM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Mar 2026 23:13:45 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Paul Tarjan <paul@paultarjan.com>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v8 09/12] run-command: add close_fd_above_stderr option
In-Reply-To: <20260305004959.83647-1-github@paulisageek.com> (Paul Tarjan's
	message of "Wed, 4 Mar 2026 17:49:59 -0700")
References: <xmqq8qc771zf.fsf@gitster.g>
	<20260305004959.83647-1-github@paulisageek.com>
Date: Wed, 04 Mar 2026 20:13:43 -0800
Message-ID: <xmqqv7fa52x4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Paul Tarjan <paul@paultarjan.com> writes:

> On Wed, Mar 4, 2026, Junio C Hamano wrote:
>> I wonder if a generic callback function
>> to call here in the child between fork and exec that the caller can
>> supply would be a good thing to have.
>
> Done in v9. Replaced the close_fd_above_stderr flag with a pre_exec_cb
> function pointer on struct child_process. The fd-closing logic is now
> a standalone close_fd_above_stderr() function that the two fsmonitor
> callers pass as the callback.

I didn't mean to suggest using a generic mechanism to _replace_ what
you added.

A truly generic callback mechanism that will be useful can and
should wait until we see real use cases for one.

And I strongly suspect that the callback would want to take some
callback data argument, not "void cb(void)", but more like "int
cb(void *)" (we may find a return value that lets us tell the
run_command() to abort instead of exec(2)ingg, for example---and we
can make a better design when we do have real use cases.





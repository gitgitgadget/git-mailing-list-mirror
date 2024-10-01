Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CB61B5820
	for <git@vger.kernel.org>; Tue,  1 Oct 2024 19:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727810581; cv=none; b=kjU7CMrj4Eji5cwVtOFnWbb4xiG8LFdB3CLnFhYv+yz+JYbOcQ7CVQCWTnj7L5lbbYifSVMqMJ0B2mb6Tqb2XitkWxNZ3RFB9SqI0nIYWpInfJly3841EqHdjJT9ZDr740EZNkZFeWGM5q5bHfGX+vqPFx6YLG1z/9BZjq8X0Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727810581; c=relaxed/simple;
	bh=XA0JkMwX3HGlKFFVP+nbF0F05r6P6K99eXgxc8NdtTw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rTPgqBss4n+KGV7LXT0MahplsR46K2fsviL+HMddcVhPJBQWIXPcPblxPlNKg8B48tw75udKNYfDPwSvS4k33CkCg55Ym+dJUcZpKMsPskqJ6hg9ndRsI5Tnd5q1FTA1vwo05hYaz/YjATBUGYn/WzLa0SMjSTFcL2cygFwANkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=aLcxaACx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SKroEhmh; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="aLcxaACx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SKroEhmh"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5DE711140D0C;
	Tue,  1 Oct 2024 15:22:59 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Tue, 01 Oct 2024 15:22:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1727810579; x=1727896979; bh=PlnKL3a8Gu
	20Bc3BPKxoGS7M7TJ6tzB2AJqxk2ZdAnc=; b=aLcxaACxRbUprhYCKGsccwO+01
	XRW5LVkvvofUDnNqIZ0lUjmfcEzG8vs11oNDwkmGcbjqr42hjrJ+r3WkhppQE2hE
	B4SMu9Wt1roCoXGSLhaXx2q6iH8wc1lIh/aIwW0sEDNKpzdePjaFEpIF7v1JwyKB
	R5Sy2qiAkxLATsj2RsWn9GsZlFc5tUQMCzh1l7Fr+HBSx0CWq8g5gB6EvFc7KRpo
	OV+n9JGUh5QoIHQVd0/V4dydvvjTw3sqsbpb/kJvAhM3CXVp7jHyiU3X7vr72NX7
	Y8tq+9cED3kkQkJgTvXFz0Ogcr5gNs/P7m8D2ZijZ5TQ6FIw42jO5oJ+iZiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727810579; x=1727896979; bh=PlnKL3a8Gu20Bc3BPKxoGS7M7TJ6
	tzB2AJqxk2ZdAnc=; b=SKroEhmh7TGcyHwryZ/pX4g3zCarigc/vSf71OOtjhEe
	zYOgTRO+4BRibeVx2wfYlKaJgskXFaktUeMhHL+nD6Yi7YAEsL8e+N9709CPpTdU
	BQ0hzp4gWIyAK0Zbo8B+XDwxvbbGVIv/Ljr0xWbTJ0dUoKfGmw4NF5yYbDSDJlfj
	AgW0ez5QukfBHq9M51857zeTc/U07ulOAgkHZ3TtyPj6hnutlwMSSvKaREiORSEl
	aaHL3p9fKwp0WWYap91gsVcd1LW5XTQif8Pm83A45GrXwYzMS47/mMyW2vM+XR/s
	OGmxKkoOds8TeTnXzWUVWa06vKhIkuvawV8uI3jbBA==
X-ME-Sender: <xms:E0z8ZmKiMGLEzGLOp8FS44W3m_KVLI9-YnxOkwRkylEIjjA_Ab2lnw>
    <xme:E0z8ZuJL53ZIl7n71HlfKkH9z-p5e3ytQBk7jw3o-OFTFf4nf9zKnkrH1cbiHyz74
    glD19r4i0Y5jSVHKg>
X-ME-Received: <xmr:E0z8ZmuzYFZqx1TwDTAkht-oWcx0-UvT7TKxb9NR9BT1pew7YbcW8aExptOMRBRjAftHvdPNea9idvknIBuzIYqbETF1955K5i_uaSY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddujedgudefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeehjeeikeelueejuddvhfethedvtdekhfdv
    teegvddvvdeujedvgfeguefhffevhfenucffohhmrghinhepuhhpuggrthgvrdgvmhgrih
    hlnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhi
    thhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmh
    htphhouhhtpdhrtghpthhtoheptghhrghnughrrghprhgrthgrphefheduleesghhmrghi
    lhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:E0z8Zrby5R0nIe21lQ7NCZ2AA-GiS7hnZ_7f_J1uXt8nxPk6Pn6HXw>
    <xmx:E0z8ZtafAyN_0oGjYzWnvYZHF9WATWZRF-qLniW10zNrSzNRabT6Ww>
    <xmx:E0z8ZnDuU5gMRonAWbzmtCphO0X34mGKRyrv7rlye0UmH-qIZWg7VA>
    <xmx:E0z8Zja30qVKQvSMov1oBFHcpTFFNNEaRi_3FSw2EYbB7ZVco2M6VQ>
    <xmx:E0z8ZhGywa8B0cw8VUD8VRHJLcQryZ1Ur0-_RmN9NUpSnuZLsqSqSxCe>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Oct 2024 15:22:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] unit-tests: use xstrfmt() instead of a char buffer in
 t-reftable-stack
In-Reply-To: <20241001170629.7768-1-chandrapratap3519@gmail.com> (Chandra
	Pratap's message of "Tue, 1 Oct 2024 22:35:55 +0530")
References: <20241001170629.7768-1-chandrapratap3519@gmail.com>
Date: Tue, 01 Oct 2024 12:22:57 -0700
Message-ID: <xmqqo743vd9q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Chandra Pratap <chandrapratap3519@gmail.com> writes:

> A char buffer is used to hold refname values as formatted strings
> in the reftable_stack_add() test in t/unit-tests/t-reftable-stack.c.
> This can be replaced with a single call to xstrfmt() making the test
> conciser.

It may make the test more concise, but would we now need to worry
about leaking .refname?

It turns out that we do not have to, as we were already storing the
result of xstrdup() to .refname, so we must have been freeing them
already (or we are not making existing leak worse, if .refname were
leaking).

I've heard some noises about using our helper functions in tests, in
that a buggy helper function of ours would interfere with testing
the thing(s) we truly want to test, but we have been using xstrdup()
and replacing it with xstrfmt(), so it is not like we are making
things worse in that regard.  Not that I entirely buy the "don't use
git to test git" argument.

One thing that this worsens is that we now have two copies of the
literal "branch%02"PRIuMAX string.  If we ever want to change one of
them, we must remember to change the other to match.

Perhaps with another constant, this patch would become perfect, like
this?

> Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
> ---
>  t/unit-tests/t-reftable-stack.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/t/unit-tests/t-reftable-stack.c b/t/unit-tests/t-reftable-stack.c
> index 31d563d992..2d7cfbf8aa 100644
> --- a/t/unit-tests/t-reftable-stack.c
> +++ b/t/unit-tests/t-reftable-stack.c
> @@ -523,14 +523,12 @@ static void t_reftable_stack_add(void)
>  	check(!err);
>  
>  	for (i = 0; i < N; i++) {
> -		char buf[256];

+		static const char fmt[] = "branch%02"PRIuMAX;

> -		snprintf(buf, sizeof(buf), "branch%02"PRIuMAX, (uintmax_t)i);
> -		refs[i].refname = xstrdup(buf);
> +		refs[i].refname = xstrfmt("branch%02"PRIuMAX, (uintmax_t)i);

+		refs[i].refname = xstrfmt(fmt, (uintmax_t)i);

>  		refs[i].update_index = i + 1;
>  		refs[i].value_type = REFTABLE_REF_VAL1;
>  		t_reftable_set_hash(refs[i].value.val1, i, GIT_SHA1_FORMAT_ID);
>  
> -		logs[i].refname = xstrdup(buf);
> +		logs[i].refname = xstrfmt("branch%02"PRIuMAX, (uintmax_t)i);

+		logs[i].refname = xstrfmt(fmt, (uintmax_t)i);

>  		logs[i].update_index = N + i + 1;
>  		logs[i].value_type = REFTABLE_LOG_UPDATE;
>  		logs[i].value.update.email = xstrdup("identity@invalid");

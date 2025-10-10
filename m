Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7674F286D7D
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 11:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760095369; cv=none; b=ZON3zRI1LdTdBynTO0F6UVmXTjoATu47ZNLEGaxE1Jlme+yZJE/jC7JRd/tBCdPzRW1iM/0bHJg72ymZTm9vNuBdvRbejHHmVfZ9dS57+YeIIt3fAvFiNpzUvcNswDzeMqS1vreBzABxk/XiHReUiPG6Xb5vYAZbmpPjNjXMm3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760095369; c=relaxed/simple;
	bh=FP6wJiqVjwDHrxeVOLEx5KO9FIFZm2bIHYZNrbgulRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IUn3jOfUZsl13uXMNTfUydLVT5+5Uk1E9i5ygoc8VBFLfBtDYUMOoWHOqtHoEXWri151lw0RaroWFzPt0tmr8EX4QFZ3d4EFviPSfYkP74DsK0B6BvpnhrqvMXWyxZ/7xOs4VfQRgv4KeEWR4DUvUrujCRVew2tI3eM63kwywHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=P4XGM98p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZLVaHd4o; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="P4XGM98p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZLVaHd4o"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A2AB414000B7;
	Fri, 10 Oct 2025 07:22:46 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 10 Oct 2025 07:22:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1760095366; x=1760181766; bh=W3UQrq9TYj
	EE5Khvi62DMekfaU9DlEg/E0CBQZkybzY=; b=P4XGM98pIBMxSqq22sQ1zcITqo
	ZoGFQYtCMbYE5Efy9uk04tywGbPUmhqKzA8LYEIOB2G6m54bNjUQArHgNmB7S4Qj
	Mack1Du4kavOzsk0IdHhQ3PbgpqcYYfucUYbPaq9oYvUpT8k/PfcOSjYQabdYprS
	w3N3THrfKTvvypAIh1OxTLxVNnAhPde+3aO2PGoSPlEApGaf+A9hX3GfClI8bw9A
	6taFjlDI8fIg7kIuwPMI60p924yTw36zPq1Wc0GimfRquMtqRQUaB/yL4RdbFeWK
	cRPvFaDQTLc40wPxS7J5DOJK/wAel4sK5uKekQegQbMTa1ZWc6sPu1EHS9Rw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760095366; x=1760181766; bh=W3UQrq9TYjEE5Khvi62DMekfaU9DlEg/E0C
	BQZkybzY=; b=ZLVaHd4og65nZBMkg6NnNrjj46f8hyBAfQUsIEXNKvysJSx7hK4
	Ac/ZTX4t+/2eksl1QR7Fa2Je6xbSUqLQX+bkPWv8jZiYQVIwW0kHzKAXWBfED/nf
	r9rRN3ry7XSm3vf8SFepCuLP0W8G/8Oq5lorZvD764f8SDOyVd041lSwMWgU2Ro9
	YuT49f+1y6XlYVCiV8Le4euUh5oRNiBR76EISLjnbJBUcKR2WQP2EZhNNE8YJKcu
	zg0G2FxfjYPukqkDUumZmHDMtNOCs7NmRBRgTtWTZtfVVjKwD1ljdJg8AD5jw3mf
	FGQFukLyiis0hBt15+owi38/8emy80aCZBQ==
X-ME-Sender: <xms:huzoaJEd7IuaSlXgfl5fGCkeyYsXsqRnGllDBFBjC8jll1NDDWBTgg>
    <xme:huzoaEV8WI6fZFRwNUo5ghlWuIkdAoxQAKYJq-NXOi28hTDlKiC8V95A0v5Mhuv8S
    DaJspyzpUU-ieIuwuQijIZwZkaU5A1MDFF5eC1DodaYGP9B1ajPuQ>
X-ME-Received: <xmr:huzoaIzdN7Wqoztk9Y0jnFLdLYxC9dwikfd0qZcP9FVx9bl65qEX0s6XVhCuWV6FStVU_uhL9M2LvTj6g2rox79LkwcEfM1tGov5cAcLOA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdekleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhih
    hkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:huzoaKNlvyY8RxstPzYrYws_WllLwGaPtgT0CqAJmnkgY1P9SOS-3Q>
    <xmx:huzoaB422Wq7mCoGvE9N_yiyg2k52I_0y4dFQoC3SXlKrBcjgEniJQ>
    <xmx:huzoaDPqWiq6U_BGl3fis0xgAoeVggw3Z1AoOltHlOLIFEKcT3a-5A>
    <xmx:huzoaHk8uLOdK8F_Kl5yEW61YbMZmtOuBxpkhBSgSO2dUM0d4RmTpQ>
    <xmx:huzoaJ3J9vRQJD-fKFDiIZ_imrUY0hC3emb-6-bznxkZ38x5jtsGpOfE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Oct 2025 07:22:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fab83f81 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 10 Oct 2025 11:22:45 +0000 (UTC)
Date: Fri, 10 Oct 2025 13:22:41 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 7/9] reftable/stack: add function to check if
 optimization is required
Message-ID: <aOjsgQge8Wqh4odB@pks.im>
References: <20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-0-c7962be584fa@gmail.com>
 <20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-7-c7962be584fa@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-7-c7962be584fa@gmail.com>

On Fri, Oct 10, 2025 at 12:27:11PM +0200, Karthik Nayak wrote:
> The reftable backend for references, performs auto-compaction as part of

s/for references, //

> its regular flow. This allows it to stay optimized.

Maybe: "flow, which is required to keep the number of tables part of a
stack at bay."

> diff --git a/reftable/reftable-stack.h b/reftable/reftable-stack.h
> index d70fcb705d..754e955206 100644
> --- a/reftable/reftable-stack.h
> +++ b/reftable/reftable-stack.h
> @@ -123,6 +123,9 @@ struct reftable_log_expiry_config {
>  int reftable_stack_compact_all(struct reftable_stack *st,
>  			       struct reftable_log_expiry_config *config);
>  
> +/* check if heuristic based compaction is required  */
> +int reftable_stack_compaction_required(struct reftable_stack *st, bool *required);

Let's use a full sentence here, starting with an upper-case letter and
ending with punctuation.

> diff --git a/reftable/stack.c b/reftable/stack.c
> index 9d9326ce0e..732141d46c 100644
> --- a/reftable/stack.c
> +++ b/reftable/stack.c
> @@ -1652,6 +1652,24 @@ static int stack_segments_for_compaction(struct reftable_stack *st,
>  	return 0;
>  }
>  
> +int reftable_stack_compaction_required(struct reftable_stack *st, bool *required)
> +{
> +	struct segment seg;
> +	int err = 0;
> +
> +	if (st->merged->tables_len < 2) {
> +		*required = false;
> +		return 0;
> +	}
> +
> +	err = stack_segments_for_compaction(st, &seg);
> +	if (err)
> +		return err;
> +
> +	*required = segment_size(&seg) > 0;
> +	return 0;
> +}

Okay, makes sense. If we have at least one segment that we'd perform
compaction for we return true, otherwise false.

Patrick

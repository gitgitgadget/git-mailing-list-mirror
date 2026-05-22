Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5D71F12E0
	for <git@vger.kernel.org>; Fri, 22 May 2026 06:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779429794; cv=none; b=SKhuoAz7wBblcEvgbcC21nzIbXVDNGePl7hbgNeoVVbNS7PKIotyAnFdEzA5SIU0R/Xwn6dpufsfH69IQ3l1Xax3J9bJ5Z8uXUoY10Kes6W9pi34gHWbBnGSZcM47WR9nC/2RnFJRrjKcm1MldB4gX7zmSSYhR1cNCgQfhJ1KM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779429794; c=relaxed/simple;
	bh=v51XHQ0BTbTRrvQ2N09klkkaYfWyJa1On2hv49nVxR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qUjuXS+gjKpAwq2GRbZKyEeADoVhQK1WIrFkvNtduY5sUFCpA2kXpj+X/+Hb7k4XE0miRI/B8oqFSgxc3hdJYeFsEimNQcZXqNPt4RUkFIJLEfALslcCqCU5G4lWFAmd41ThYNcEuyfB+NS8S/cHra4ZqwFWsTt3lU7ipRvIL6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=h458Hdw6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f+e7oU9d; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="h458Hdw6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f+e7oU9d"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 49D517A0071;
	Fri, 22 May 2026 02:03:12 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Fri, 22 May 2026 02:03:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1779429792; x=1779516192; bh=SJFaY87f50
	tYrelweMLnvImSrYG7WRwW6dH9ODiZBKg=; b=h458Hdw6KpfaA7HB6WvqccAHLa
	+4NhRumvWxgxgv+Z26udywdbnla7LgHjeiD1lEgd7nuFjLNtBSE7NFTCg3aQH3Y4
	d9CeUy/pHtXXacb7G+tCfo+Tmkbu/B/T+8Zi96aq9eLBmZeqA6+rNdk+AQaSc/K+
	+7eQbR7OZKh6wR16GZI1uvnLk+IA6tRYmEybdljzBAI3V34C7q3P5N+K73RXAjJB
	t29CX5JcnquzLHSh3Qa/ksXrmhpCN3Z5TXSqEodCyYVat3V3Qw3IH/6F1Dv5K31w
	sJ/Gk5FNxYkRTLFA9ZEDP3P84PxeQ+rCT5dti7UbFFj8yO1RnmNVHDk3hbaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779429792; x=1779516192; bh=SJFaY87f50tYrelweMLnvImSrYG7WRwW6dH
	9ODiZBKg=; b=f+e7oU9dI1TX3m5gQ9Q0xq+cbtcf3VVCgLl9uMuWBZjglL/4SjE
	5vgiEX3X0MmjYHHyORa2Zm/1t7fA4CRILufaftobOvnDl+2v4h0BSvByl/iKTp89
	zvIrFFBnBnJn53bI06K/lISxcPqrV1ApgJoIz8EEOSHxcwY+hAiGqSLHCASVlEEy
	lIa98MRJD5+biijjHGvuj4kMNtPdJwN4akEQsg2U8IXvZ/9oZRRAUxtB1SMwIGyG
	XWOJro4v/ef/1u44L3asOVK4HWQ5lS+8NTxAC3HoS8YbbPlcSFfcgVzRGAPOm6dL
	cy9oE/N10acFC1DBsd1mGQTzLzQ0qvWrAZg==
X-ME-Sender: <xms:n_EPaq6kP6RxIq5edVcK5HiO_-whu9gvFtMkNVgvsO5f4dIaSgORCQ>
    <xme:n_EPap4RCapZxjr_txUHmh6fGuwN7VhAMvUcdn9ihffr96xrWBlOxFl8aKS4iDtzB
    6xuBBKTkVFdyPpg3WwSwv9vok3z_ZRycg6yuTqh6ctWB6AmSd1CrA>
X-ME-Received: <xmr:n_EPanFqoQG28u9KKQ3OCt-HdGI1R8FicTzf4Pn1Y39QdV39T3BfgYHs-7le2t1iaGV2JCxcAF-Ehvpvz5LDawrJEE7wipKeZqFe1e85vQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeelheehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:n_EPaiQhYv3clmzJJnlFhkx2nw8MSPoItppFCaoINIPqzoARUY-7xQ>
    <xmx:n_EPagvyhLuF3_VzH0bmaZjRJqdxHlJAeWDVCVXmeRpK8ZQhRXgVUQ>
    <xmx:n_EPahzczJJtkTZah-nBB_7PMmSLjy22PVhziBO4QzhttqPD3fIwJA>
    <xmx:n_EPaq6SX5wUhjqe7DrmQ3dH0RET2g2Ptx5s9SaRMfnyo--7mVcqfw>
    <xmx:oPEPauShWiTn-yAsZXJJ0r4H7Vrk0mJSu1elOIe9b3JnZLXvh4bWmqBL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 May 2026 02:03:11 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0e0a741b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 22 May 2026 06:03:08 +0000 (UTC)
Date: Fri, 22 May 2026 08:03:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/8] setup: centralize object database creation
Message-ID: <ag_xmQO_BSzRsoAv@pks.im>
References: <20260521-b4-pks-setup-centralize-odb-creation-v1-0-f130d2a7e8ae@pks.im>
 <xmqqqzn4xp0c.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqqzn4xp0c.fsf@gitster.g>

On Fri, May 22, 2026 at 09:32:35AM +0900, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > The series is built on top of aec3f58750 (Sync with 'maint', 2026-05-21)
> > with ps/setup-wo-the-repository at df69f40c34 (setup: stop using
> > `the_repository` in `init_db()`, 2026-05-19) merged into it.
> 
> FWIW, this merge needs the following merge-fix squashed into it,
> for the topic to build standalone.
> 
> commit ce350f62ceb26f3276ea3b7ad78b7f8cb4c35cf7
> Author: Junio C Hamano <gitster@pobox.com>
> Date:   Wed May 13 12:20:29 2026 +0900
> 
>     merge-fix/ps/setup-wo-the-repository
>     
>     with  js/objects-larger-than-4gb-on-windows
> 
> diff --git a/t/helper/test-synthesize.c b/t/helper/test-synthesize.c
> index 1f28ecf0f2..3fa534fbdf 100644
> --- a/t/helper/test-synthesize.c
> +++ b/t/helper/test-synthesize.c
> @@ -506,7 +506,7 @@ static int cmd__synthesize__pack(int argc, const char **argv,
>  		OPT_END()
>  	};
>  
> -	setup_git_directory_gently(&non_git);
> +	setup_git_directory_gently(the_repository, &non_git);
>  	repo = the_repository;
>  	algo = unsafe_hash_algo(repo->hash_algo);

Oh, right, I should have mentioned this. I do have the same fixup on top
of the merge, thanks.

Patrick

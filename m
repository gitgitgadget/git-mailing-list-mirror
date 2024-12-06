Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B8722315
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 09:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733476034; cv=none; b=YHM0qpHljPj0N2VrDCBX2rjdKz1f0MUbFNB+pJeuPYTw6yE0lx7LTmMlw/OxHJ4DaKSXf8L6lGKQKCclE0UohnRGX5phbYtkESHjP6Mrix5NMoAyRsJZCJn/IAe88yaTuIl4rgxBBv44KpxGv9uEo/VoG0mi4J2Svt9st/J1RiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733476034; c=relaxed/simple;
	bh=6GXWufwgKd8joYevIXfSOzBoTbJDQrrVgMw5Lj2pm+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qS5u7IR/AzqKm5+dYpH2t4VI6xvXTryb0vebBjXxr+vTUuW51fzgRnvfhh4aMj9qwsJaKfUud6W3jFlJuSq4s19SSow+0Nzkpp46F2GBgpGFi5DNfpxzBgHXxOtGcIKFTnGTrArZwEYJZrdPim2QWUUz4wzWkeD7RHKO8Vd5AAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OAMwGnI5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZmLzx0SC; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OAMwGnI5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZmLzx0SC"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AF738254018D;
	Fri,  6 Dec 2024 04:07:10 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 06 Dec 2024 04:07:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1733476030; x=1733562430; bh=TBO/Ufvm2Z
	Y9CBI2hLSam07ZhvSmwQ+bYDeaKPAS/do=; b=OAMwGnI5q4Ici/XZ7RLhMFE5yU
	SOVOnGB7Jbftj2/93SFbYcN6FfdpM8HjfhMMQdIyJsICE58CALJG8A/v0ss3iOYQ
	8GT6MOM5V5Mt3WD/s4odmFLOze2UXAHMkZjRJHDqc2oWFAjJZ0Oxnt3peokWTZRT
	ZSXCNw5kFCQQiWVpw7R5Z6XPzSHqMTGQauWx0hT/YkReZ1zXBymYcuAd2fdJ/d+2
	7zi5jzEPGJAWDul8IK+TuhOlIRMpoRfmbP3P1mw9llnFqcYNrU4Hu8TZHMyjZOim
	S95rZPiSt8VyMLFAgpqFs0/v87XOvhv6YAjX/cJZkcMYc7U2QC3WlHOtUQKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733476030; x=1733562430; bh=TBO/Ufvm2ZY9CBI2hLSam07ZhvSmwQ+bYDe
	aKPAS/do=; b=ZmLzx0SCEPQ7/f4s9LKwKsYjvwqdA5Q6kMpSV1SZokfatHEJmnX
	zkRCgcLFTC6/d+tcb5OONDMUQTJHvUAB7AMf2U/3YkRh1xs1awIkickdLnzz/pZb
	f3iV+x6oGDrYhdQUyRSpa9ZcQ6L7B/Zb4odtdGuR6C51giTcoSr6kHuCpImH+ovG
	F9dn2s3UKUF6upwikpjaU2PW3Z2/zsWJKQE0+ED63w18XzXeO6UGx2U6o8osElCn
	dhcdJUGWyQYhYJKzxXXxCOBT22SUUfjKV/vW+PEmCPwZv+TWjKqAF2r9o+JEFPD+
	bQgc3+eoE+BV7T9KIA3tSPJnz1Q/4PNvRDw==
X-ME-Sender: <xms:vr5SZzUkEHjLcvsthVLtXJvQ71--HD4ZWqKfBxrhcrnxvgJ1SSH29A>
    <xme:vr5SZ7kkOT65tWQuirYdnw9n1LgA8L0I9vvK2m_U-SqgDnquu6iiEPSnjWyvqjedQ
    mVVxYEn-fnH0m804g>
X-ME-Received: <xmr:vr5SZ_YwPxXxggOWgwabFclwR3xPCnXphVAe-Ie-5ouQArPhAE3hN3wp-c2m2igPbSu5jUtV62-UotWqdBwwyFl2buXGtxtmjSUE9hu_upOjGw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieekgdduvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:vr5SZ-VIkI3S7QO_mlefc1_4ryPv_t_G57nFUVu88CCRvidd4I_CSg>
    <xmx:vr5SZ9mLTO3Izh5ZXlA8J4E9woblQrsc_O4zMBhUngalbwbylY0-lw>
    <xmx:vr5SZ7cdL2rMG5P-Qlex7Mc45R-a44rEaxSGVgzDFDpm0AZPFGK6bA>
    <xmx:vr5SZ3GiExSWxv_APmr5KQtCo3DxgVlccN_ZbG_i7GUFLw0a-CcE1A>
    <xmx:vr5SZyzb4dt3pBm-5YPpeODHtKN3s68oXJIhobLo7dm2-Ava3xVaJt2p>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Dec 2024 04:07:09 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id aaa63cc8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Dec 2024 09:05:45 +0000 (UTC)
Date: Fri, 6 Dec 2024 10:06:53 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] reftable/writer: ensure valid range for log's
 update_index
Message-ID: <Z1K-rXakmMQHN9If@pks.im>
References: <20241205-424-reftable-writer-add-check-for-limits-v1-1-b287b055204e@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205-424-reftable-writer-add-check-for-limits-v1-1-b287b055204e@gmail.com>

On Thu, Dec 05, 2024 at 04:49:57PM +0100, Karthik Nayak wrote:
> Each reftable addition has an associated update_index. While writing
> refs, the update_index is verified to be within the range of the
> reftable writer, i.e. `writer.min_update_index < ref.update_index` and
> `writer.max_update_index > ref.update_index`.

These should probably be `<=` and `>=`, respectively.

> diff --git a/reftable/writer.c b/reftable/writer.c
> index fd136794d5a27b33b5017f36fbd6b095ab8dac5b..f87086777cd20a9890a63f10c5d6932310dd5610 100644
> --- a/reftable/writer.c
> +++ b/reftable/writer.c
> @@ -412,6 +412,18 @@ int reftable_writer_add_log(struct reftable_writer *w,
>  	if (log->value_type == REFTABLE_LOG_DELETION)
>  		return reftable_writer_add_log_verbatim(w, log);
>  
> +	/*
> +	 * Verify only the upper limit of the update_index. Each reflog entry
> +	 * is tied to a specific update_index. Entries in the reflog can be
> +	 * replaced by adding a new entry with the same update_index,
> +	 * effectively canceling the old one.
> +	 *
> +	 * Consequently, reflog updates may include update_index values lower
> +	 * than the writer's min_update_index.
> +	 */
> +	if (log->update_index > w->max_update_index)
> +		return REFTABLE_API_ERROR;

Yup, looks sensible.

>  	if (!log->refname)
>  		return REFTABLE_API_ERROR;
>  
> diff --git a/t/unit-tests/t-reftable-readwrite.c b/t/unit-tests/t-reftable-readwrite.c
> index d279b86df0aeda11b3fb4d2c15803760ae394941..5ad1c72f6901abcfe7fdc6c3e69e26b58d0013a6 100644
> --- a/t/unit-tests/t-reftable-readwrite.c
> +++ b/t/unit-tests/t-reftable-readwrite.c
> @@ -151,6 +151,45 @@ static void t_log_overflow(void)
>  	reftable_buf_release(&buf);
>  }
>  
> +static void t_log_write_limits(void)
> +{
> +	struct reftable_write_options opts = { 0 };
> +	struct reftable_buf buf = REFTABLE_BUF_INIT;
> +	struct reftable_writer *w = t_reftable_strbuf_writer(&buf, &opts);
> +	struct reftable_log_record log = {
> +		.refname = (char *)"refs/head/master",
> +		.update_index = 1,
> +		.value_type = REFTABLE_LOG_UPDATE,
> +		.value = {
> +			.update = {
> +				.old_hash = { 1 },
> +				.new_hash = { 2 },
> +				.name = (char *)"Han-Wen Nienhuys",
> +				.email = (char *)"hanwen@google.com",
> +				.tz_offset = 100,
> +				.time = 0x5e430672,
> +			},
> +		},
> +	};
> +	int err;
> +
> +	reftable_writer_set_limits(w, 1, 2);
> +
> +	err = reftable_writer_add_log(w, &log);
> +	check_int(err, ==, 0);
> +
> +	log.update_index = 2;
> +	err = reftable_writer_add_log(w, &log);
> +	check_int(err, ==, 0);
> +
> +	log.update_index = 3;
> +	err = reftable_writer_add_log(w, &log);
> +	check_int(err, ==, REFTABLE_API_ERROR);
> +
> +	reftable_writer_free(w);
> +	reftable_buf_release(&buf);
> +}

Makes sense, as well. We could trivially extend this test to also assert
that we can successfully write a log record with update index 0, which
would be smaller than the lower bound.

Patrick

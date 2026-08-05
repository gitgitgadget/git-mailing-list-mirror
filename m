Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3E83E0243
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 09:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785921794; cv=none; b=cWb5NLJopF0IuYq0tD0SRijRI1xx+OgyFUudzrWZLLNX/q4o+dI0eAVd1MbfqIT1iPT9pR2FHu4uMbYwxy+yIRyJmVv6JwlIt6LqvIXS1H6H2K/XpqbHFLZtcmWSTFSU1s4Cz557HdrjHLXEgJLRPSoRUtYSzEUKfdQCGYJzVZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785921794; c=relaxed/simple;
	bh=91W4scNRbjF+uGgQ4P4N9iBG/QvXoUJ3r2FphhigMLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nQhqK6DgVbXGrmyC/P7JfDb0ud0Jy9ZeCWcTkFae+YgoRS5qukU6X/gQPcX2cLTSZm8tp3+fKwWNX8oi1NwX+MRw8sGOZml7hcU5e3Xulwm6efHzg/0wKnNK+X4wOFr1eMdRsA0xT+DbFm/1j+Xrjw9pM74x5quDprd3Nsbb2cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=N9I8Fkfk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PAwPwGub; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="N9I8Fkfk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PAwPwGub"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id BBA0DEC0184;
	Wed,  5 Aug 2026 05:23:11 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 05 Aug 2026 05:23:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1785921791; x=1786008191; bh=kAjfX4XhUI
	O6xED1Uy0GnNBy5CR9mOOTqqYG95ERPXU=; b=N9I8Fkfk8uuwYw7p19tdGny4oq
	S3Fj6YVf4wz1rGDtsmLupYdvoQy5LDviWfA5fYj4A96VhvsHZiSczdKWZKHU4uni
	2bdj35LW/Zx9fgGn4cplChSJqjvrno8+zsxx8t7Bxz1IHWA7/42sz+MjlwK9Dkg1
	qqWJbcny7temarTf9tb4JQkNPZZ1F+6C3j2lwifuafqfx6ekxRaDvwTleTzqtGb8
	RicDYGx3mPGLKAakgP1zkfzMIng5EmZRZ9gOBjKmbzHXaGui11Wf/jd7g9BzWzcX
	s68xtSmM/E6CFp25uBPX+4PXKysdZNBfMzw1dmRRjVW62Ix0W8hVjH1+btfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785921791; x=1786008191; bh=kAjfX4XhUIO6xED1Uy0GnNBy5CR9mOOTqqY
	G95ERPXU=; b=PAwPwGubiEenqfVBngV+Ooe/wZtGvtK2/FjzLK9Vw0AdwH/CXR3
	oxolqVhbQt8O4+yL6L24RWIFNMW78JLwK3kKTN10Fb5JbcLsDyV9hXLjJqNjQz6t
	VMhdhmMErfrhqaJ5DjXq3qzuCjGu1FnTf5VGswIhUHSovsjUnIRKqVgCFtKOtocr
	cE8QxAZQ3sJBmgTjK2Ddge0JxDdjUiBPvdAW/yY78GrRRzOnA8UQVQd4wi0Yd4R/
	++YbH3dCULcu6YsINF9XYgGw5XTtCbo43eRFJcmA3bfJSQBBuiXT2uoUc4pp+e3i
	r6K9prires1eh5Ue7cveWbzhhf3J1q2WnXA==
X-ME-Sender: <xms:_wBzaqUBC2Gbpr-Rd13EXYhiWJ5AkeVYyN5l7IHO_Gl4JhOKhPUE1g>
    <xme:_wBzauDoF4EF9JEqxGqwTnW2KXUEdfV-2dnYJF_ufmBvTOA-U015BTkS9EZ8iWk6G
    ylmTFo1Uy-Pf85dkEhNajXn3UF1R26W1huGxpFcXR_8v08yyG53voI>
X-ME-Received: <xmr:_wBzarxvZZUdbQsuf1GiW8KLgdM8gMX4sUeSJjrkjWHxHVbEjlzwbas-53lFHo4S97H1WuH4ZtuI3AOqm_aPFFI9WQsAx3SIlCG8u-UEBQ>
X-ME-Proxy-Cause: dmFkZTFyIzAgb92UmTVzDwCNq439D/cqIDozpQV4mDedqx7VxzQEB9Ko4wtEijOsBFLQOF
    hnQCskqRSDxf2ESyNopWXpGt8rVYkJ80U1kxCvrCp7uVknXGSoQhoAzXJPd2s/YzlQrf3V
    hCQtYf+0iszNeFSCD2NDhhk4tB4GiNMrTwvChNLZ+0JOEf0Q0rxpEglC1vHNBMeglJneFO
    /lYFThYgOq4GoAfN7KYoLDWXVsDhY25IOuZqjaMqlIlA/3AWZvzDKpVPFekn/tsgebeM6F
    4VgMWAJcGZlgoxBY36BfBL06TkRS65PhpDeNZyqPFC8vS+oZr9HU30vJQRVSxTYh9XzLb/
    gdRouKvOjgESXIRPHrBb/4a5OHuk1ma6OaUFyOxRsKGcRdjv7qBgZbQvd5I+ci+nJ6Q9Gi
    tKVJKz7NeBXasxigpPV+anTEuHPh2zQNKdoH0MepVwTTQQitKfkPzOz1kbOH7Iql6cS8Av
    b12ccaIoKlxpIzd9jREcEUgWI5sZKtr+bV0wASpybSyna4PmVrDOfQxvNCevYb3EAv3l+x
    XPJQk7vAdUyAp+UVvg+GZC1KMOZGxXth48qYJLA5KNWtoPFhW5jqMiNnlPj6RjCp5EqIaF
    uX1I+nS5xi/G5uhP2YOnQG3Tn35tQ++qNMvMrE4EIOSwhYIdJUbt4PBRmBww
X-ME-Proxy: <xmx:_wBzarD-rbAMlNgDZS3N8DU1wvwxVJc9N81blEp_iHHgF68jPS6pZQ>
    <xmx:_wBzaoYMiWHG15KzcmQYVz_a7457fZbwHVR6lPZSWiQfVLDcx3vr3A>
    <xmx:_wBzajg6tHLGoHKm4qx11IKAr_KhG2lsh4KiJ-7gdcL0cBs5cQE6fQ>
    <xmx:_wBzaq4jfmytRrhLkf6WNqbwBFMG_vG5sLUo0JUH-4yvDd0tsAYVyg>
    <xmx:_wBzaviq1J6kqp77r2-s9evyQx1LAl_CV4vT2GZGJ7vSPq3ckGAFCslz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 05:23:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fa154e6c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 5 Aug 2026 09:23:10 +0000 (UTC)
Date: Wed, 5 Aug 2026 11:23:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 04/12] pack-objects: widen `free_unpacked()` return to
 `size_t`
Message-ID: <anMA--V_ec-WPBZq@pks.im>
References: <pull.2175.git.1783615780.gitgitgadget@gmail.com>
 <07d01200a48c79ba6b3da594d29d685b2c5865d0.1783615780.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07d01200a48c79ba6b3da594d29d685b2c5865d0.1783615780.git.gitgitgadget@gmail.com>

On Thu, Jul 09, 2026 at 04:49:31PM +0000, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index f89628a760..4737a6a32c 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -2972,9 +2972,9 @@ static unsigned int check_delta_limit(struct object_entry *me, unsigned int n)
>  	return m;
>  }
>  
> -static unsigned long free_unpacked(struct unpacked *n)
> +static size_t free_unpacked(struct unpacked *n)
>  {
> -	unsigned long freed_mem = sizeof_delta_index(n->index);
> +	size_t freed_mem = sizeof_delta_index(n->index);

Okay. As mentioned on a preceding patch, the function itself still
returns `unsigned long`, which should probably also be corrected in this
patch series.

Patrick

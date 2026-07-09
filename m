Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127BB5B1EB
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 03:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783569191; cv=none; b=E/3nrHtKFmETSKx9IV2mxGOUm7Y+054VWrp7FLBXplP1/aLAdfiH2dvQTDzqCDdF8iKY8wgEGOw5TRnxuKmfvX3byv50FGCFORkPt2xuK1DyIFHfLBuOqp8YMTPTMOSbjH6xGsQ8AXOSP0UDttTfzrTh3EhkB+IXx28HubnWsQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783569191; c=relaxed/simple;
	bh=p/hIqefh9cFzTBJ0QbSr7bX2QvvTaTht1RccLbF2XiM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Tx9VCnWjbEWEzJR4UeK2KKXsxlG7Y9TCmvWM0AUvif7c1t8Rcv11PgOjqYxKRv5LBzX+m1CJjtKdVtfbyChSvj3zaRpjlkjK2weQ2bAbGAbjGPuEF3jBdV5qnJhuxrRI7o7okN1xLyNuBIAuobNhqNVB2YssRmkqoskUe07CLZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=tz6udbI4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JNK9ZEkH; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="tz6udbI4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JNK9ZEkH"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 244EC1D00086;
	Wed,  8 Jul 2026 23:53:09 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 08 Jul 2026 23:53:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783569188; x=1783655588; bh=+Q1/1Y2gib
	zUqgbROMfmb4frGL7tYLe/S/NRp8u1uqA=; b=tz6udbI4dF1gWIZv8EOYj57OZM
	MJqmPgZH6UBEVuNB3veL6VF1B0Kpfnc8Soyz/yWR539sMA8wfLJ19zimdYH3/Rmc
	h6lNoYkDkGP8AUzJjgCFzqLQCQ0l7AQD1WVagK3Js9y8xq1n263dyQOkgvucLMwO
	8GNv6Jqo4F6rV7uy+5MZq36MVPCcf9fTgN+MNE+K1GyPf5rnZrT6EtsaZeJpvKa7
	vKsYE8FWtZXC+R+Ksq8K+pnvOeZrQTWRjfYSwYJNP4iqQyPSh4hBHyHpb02+VHnd
	J/LaKDyeDFMZt9iBa1RCdx4dZa6cQ7OT5z0NOpFQgGf0A7ROkdIJwU8pm8Kg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783569188; x=1783655588; bh=+Q1/1Y2gibzUqgbROMfmb4frGL7tYLe/S/N
	Rp8u1uqA=; b=JNK9ZEkH9dHw7Z8ZifXZKsswWm8aGYkMke4HLG6Ogfbgx1EFpuI
	lwsi+RBobF0zYQFzXbUmBFBDHS6DJubGepsH0ArQvBu82ceabnjkO2T9ZNNjBsbU
	n5J5WQfAEB6u+bh82jaqmJ3/G4zwsaEDPYLIubep2zHqlyOwX35aM3K7RXB5htTE
	66EdjyIw+qDhL5ELQopLqlyF4CSXaXzNscxHqLAmxI6Wafele1HgTi4dQBjBU1HT
	AtwQ2YRvv5LXWmn5SNZBjEr0QyUxpqPmgY+g3ZWQkW13bG5FyDam59ncv0v2Pos1
	ckd5Vl4+xvNtRaczZNL/F23dMOb4OfzEIVg==
X-ME-Sender: <xms:JBtPammDHoAAQXKT3KcqxcEP9_nFB5eTzRrnJoM4pWeewHEHoeH7_w>
    <xme:JBtPas5EQ7gl5R7ILNDkFlzUKhv6AvNUsdiD6_GaiKUUUaHuSmg8ovchgvMQ2oYxk
    X5fC2aHX_cUK_Lbvcifsqyx1xv4EBa-EKKI5tOV5CUdNNxrpLYd-Q>
X-ME-Received: <xmr:JBtPaq0d6okVi_UvM-otptXsUZ0b5NBHEc2ciyGvZl4EixsrZti8xzX9NoXpIdGGpd2Tv-ueyihxFhCF9YUO8UR89rYlY-obOdERgc0>
X-ME-Proxy-Cause: dmFkZTEhQ3jTf6uDbZ9r0GYcyEy2BFGAKOSXrQ+jx3Yr2+pSqCdFVW8nVpHj6Im6Rxaquw
    Oanzg39gWWpR8Vl50E8fbYNipFzsHiZsDpApEKhjylmBUesMtwKFmPyf29wAeNCEo1R8bH
    bzGyWsCemMq6nhjLgXtdGsXXdUD4dmqWMhx3HStVwqf1TFOG1zvYx+6fYOd0+fMtspnClt
    I9RpO24lWa/BFRAutoVWCu5Mj1qqkTfMSnE4t977MSPtTm0+8frcztTYX9/LAiP9+VC4OD
    2ii+0pjqQWzrp8x5j74C59eyiWG+kvrLo0rCAmO/ip8pA/xZ5uEQYU3ZOmihHn6TmOssDo
    p1ODXKlCUi3pFTuxMB4POguRGXY9BXWPgwZb+GFSzGHP2GMjHQP6BtDNI3URwytxHvWp1u
    kkHnwx4SYL+bfftJRjUifZdZGoQHftumVypgBC7MjuOiEMVqkFkxwbQqJ9npRa3BszUp9/
    3NmXvcY9J3XnrFxdNmyG+GiANFenEHwE3+FRkKeqC/ePOsJ+Y+WuAkGr9Fa3Hl0o5i7H/f
    Syj1jdi0inkHTKlWSO/+x9d9sILL3PVAbFkBlLZOeP6Dz2iNIBcmQB+TvFuhexyfA1wsnA
    GgT4cu3CWZmfNoztXR3IJfI3akdB/OHB5/tNIsB2NldHJp8eAwdWSwbOcNkA
X-ME-Proxy: <xmx:JBtPanEuveWer19RBMJGjwEVQrRRBiqIreFb_DkM-LuBp-vnlqnonw>
    <xmx:JBtPapjasL8Obd_d-GGnAinijJJkSGiNLcXtcdNeD35tanwGKwkbiA>
    <xmx:JBtPaqCgibf3mB4r8CEUYbixYXSrg9y-0fZ22arjBcaC0MvjD4bKBg>
    <xmx:JBtParR0LCJ-Fq0LHxXnsLzLD7Jd-iFl7NrgPicvW9qX5QHZdS54mg>
    <xmx:JBtPajTCTa1Ymh_suCY6C69IXaEEd1xxMAAJMw1f7gRALDu_YmVt5GPv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jul 2026 23:53:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <cat@malon.dev>
Cc: git@vger.kernel.org,  cirnovskyv@gmail.com,  szeder.dev@gmail.com,
  Christian Couder <christian.couder@gmail.com>,  Ayush Chandekar
 <ayu.chandekar@gmail.com>,  Olamide Caleb Bello <belkid98@gmail.com>
Subject: Re: [PATCH v8 4/9] environment: move pager_program into
 repo_config_values
In-Reply-To: <20260708160300.8852-5-cat@malon.dev> (Tian Yuchen's message of
	"Thu, 9 Jul 2026 00:02:55 +0800")
References: <20260706142530.3681520-1-cat@malon.dev>
	<20260708160300.8852-1-cat@malon.dev>
	<20260708160300.8852-5-cat@malon.dev>
Date: Wed, 08 Jul 2026 20:53:07 -0700
Message-ID: <xmqqy0fkq0nw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tian Yuchen <cat@malon.dev> writes:

> On top of that, fix a memory leak in pager.c while we are at it.

Hmph.

> @@ -75,10 +76,12 @@ static void wait_for_pager_signal(int signo)
>  
>  static int core_pager_config(const char *var, const char *value,
>  			     const struct config_context *ctx UNUSED,
> -			     void *data UNUSED)
> +			     void *data)
>  {
> +	struct repository *r = data;
> +
>  	if (!strcmp(var, "core.pager"))
> -		return git_config_string(&pager_program, var, value);
> +		return git_config_string(&repo_config_values(r)->pager_program, var, value);

Isn't this still overwriting what was in the .pager_program member
of the config values struct?  In check_pager_config() below, there
is a free() to avoid such a leak, but wouldn't this have the same
issue?

> @@ -91,10 +94,10 @@ const char *git_pager(struct repository *r, int stdout_is_tty)
>  
>  	pager = getenv("GIT_PAGER");
>  	if (!pager) {
> -		if (!pager_program)
> +		if (!repo_config_values(r)->pager_program)
>  			read_early_config(r,
> -					  core_pager_config, NULL);
> -		pager = pager_program;
> +					  core_pager_config, r);
> +		pager = repo_config_values(r)->pager_program;
>  	}
>  	if (!pager)
>  		pager = getenv("PAGER");
> @@ -302,7 +305,9 @@ int check_pager_config(struct repository *r, const char *cmd)
>  
>  	read_early_config(r, pager_command_config, &data);
>  
> -	if (data.value)
> -		pager_program = data.value;
> +	if (data.value) {
> +		free(repo_config_values(r)->pager_program);
> +		repo_config_values(r)->pager_program = data.value;
> +	}
>  	return data.want;
>  }

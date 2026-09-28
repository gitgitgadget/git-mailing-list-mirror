Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB4F1397
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 08:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790583505; cv=none; b=i1gYPeOK4P+iWJ7qz2fEkPM5rDx205gFoPYcwsaD0MChaHEmJvIcLci97kJPWA825xrjh1uYuPsXAaicIoxXiZ8MJIF7H6bG7+5AbTxjx27Cc8zNv+zEHWSIdmxhG9BQ8tELiF0EFmKD/r4bd1npsJ7RHr04Z+WPa0cDGwEYD3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790583505; c=relaxed/simple;
	bh=lyMTUSoxOYEhPH1y2UKkl3u68mGh5VcdU7aBRl3pd0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L7Es/d1crcCb3QHW1F0apWkytLzPMDJfj24JJuqaPmO+M3gFe2NUr0eBV9or/PBs3Dc84gbb94ZjFmliN9rp0iYMiTtFi9uMR/R1h7PcFgMTmeH0BioAca11PbErSSXi60n/nbjDCxP6xYL2e5T4n9FO8+Q9dkRDEvy5b/1hgcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fkeWlANY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UQlyDii7; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fkeWlANY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UQlyDii7"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7FE8614000C2;
	Mon, 28 Sep 2026 04:18:23 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 28 Sep 2026 04:18:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790583503; x=1790669903; bh=PTmN6KMa98
	ugubnO9gz41TfRLB0IYlRq+Qe2PlBjTqU=; b=fkeWlANYMzhQ1J1EEmyEmvmth3
	pphsST4gsFCQxas2mpXY7IpcJsArJXx4Is9yeGRk3zYfxm+6c4SRhta6E+EJiugJ
	YnYGcZ2N2gg/tY0ULRizHKXi1FYSnPtcZpNXWtrPfNQ2vPNbZ9A0ryIJR5kYQK1c
	jqgpYRNe1Nbh8nM5CC2xpSmskj6N7c0YDCkL7JanjEJCZtJuJQbUsKHThHV5hqfI
	uhy+HCI5hMhWeXT6OSf1JquuWbjs3lCKHLjAi0zMrbhZ2kOqO7YKCAm4KS0+/Tab
	MQIx/HDG3lvp7dY8JebjHT5T/kEvi47FNUx2ONZxSgPpWMOCRtVQckYocj6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790583503; x=1790669903; bh=PTmN6KMa98ugubnO9gz41TfRLB0IYlRq+Qe
	2PlBjTqU=; b=UQlyDii7Ii8MprH6y4JO05vH8gNFM+7DEzl4nUJf89eBclybJKw
	Fxj2hu6z+5UQD0RM4gyTNnt30teApkZiTo+r5NB4HP0rgQwFfHlCz0fW9Bgg2+NC
	K3r75otkJKhbP2v5US5c08CeQkQpz6kX43lO7BGWmECkp91M58bnt4EigZYeSCQf
	DP3Uvj9atpIQaMcilrTu7hIeCmMqxNNQoORmQOWecjeqjR7Fk8ZkUJLIgR0qRg0f
	OxfEHvur9aJPVlKJ0sR2OuxjIhMWoKgpOoDBut/50NG09E90WM037eugbjgv3SMy
	KepPla5kSaFxUedYqOugwTyON6THm/bfgqg==
X-ME-Sender: <xms:zyK6at6dsYX5g4E5H23M4PBqjnAs4b2G965Vq1O4UjST6zpSacBvpw>
    <xme:zyK6akMbC3FR9NdJtPxaLJwHoCGNqEtcFViscUibqV0kEITKy_WaPCCgpWchEjQCZ
    V7sxPFx9qS0KkGtlO-KVWONcikdkpskv1RWIkGNFoSrUEebQ9BBZhc>
X-ME-Received: <xmr:zyK6aruccr437Wng3fN-Rv-20KgnHBxnZO-2sojYyJgCYmL1jWHcfw>
X-ME-Proxy-Cause: dmFkZTFVP7J2rhtZaps00/o2/Jgj4L/8z4JZRc2rDBDQ/ZmDp7MQk3RzhZgTslH5saVt0R
    v7HG3cYxZpoVpdu2n+lcWeSRLTAqJEOxr9i9cm4BFn3VTtrdb1UNaKfn6ml4Y+wdkU/YxE
    cPo3+3tDl/BHhoL/T4kjdiJQdDjlvDZwR6Y6HoGXXRbIWpSY/uUqksZHi6vNqsRrex1SnT
    s+8xzMtkCAZa1BYqB5ZPRH52tYZH/+MSnMMp7eEAxHGsUZuAujEwx0J5TiXU2U0uLTm5up
    G78/DT9AZL5RuSK4Y9eqcuP6SAUxuQPf5bHW1+TwEHMHgwl/W/FwB6mPUFeOYaFUNz4jpP
    l43LXaQuyD0gOSReat2nFG+RL8l/G0y5TgFCnK0YvSwhdyVUk0ndHCFY/+Q2FI1FtQhQK8
    hqi8MhfEVUAaPhgfiHSqkALqrA06aORTLG9i5bbPWQQAc2y4nKnvCQKbNSK4US1D5ra/c1
    WYxdMajjzw8k4Uhshf0ioltz+phYVlFQ18bbtWEZZRyrbc9/SQM6hKVRLELKvhltm4S9Rx
    wmbL59oq9JR/sbaao2kHcwG0WpWGMQjwYvA3+suyo4BEQrRXD2yS+nE+YQRMZgStGR+wz/
    Dy6wgOk5ER0bxS2ze1MT6Y4hkEFB8KeR82ghxDYqqGTIyZmLGmeDXybCCCaw
X-ME-Proxy: <xmx:zyK6anbcMEUqXTDuL53X9X_qe-G2DR1ahnPS_-cieSvWYJ6ZS2zrXg>
    <xmx:zyK6atxYsPokhPw5idG_b_CM36_kHhtV3-NWYo8RAFHHO8NQu7LPSA>
    <xmx:zyK6aviBid7nzE-lJ1ErHE6pP0M_aZEpxspVKg74J8FrrjWDdU9fng>
    <xmx:zyK6apkCNRfRUJ05Ul1DfLsYT0kEm2QulXjwADuYuf2iS_4XSBP6RA>
    <xmx:zyK6at0VV1dJLlg-owvReXOPFdbLUBct3LAh273J3ne_Ph_TfU2Hu7JJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 04:18:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d062a06c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 28 Sep 2026 08:18:21 +0000 (UTC)
Date: Mon, 28 Sep 2026 10:18:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Thomas Bachem via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Thomas Bachem <mail@thomasbachem.com>
Subject: Re: [PATCH v4 2/2] rerere: go on at a conflict when the lock stays
 busy
Message-ID: <aroiyibdbr7PKqST@pks.im>
References: <pull.2214.git.1788337897490.gitgitgadget@gmail.com>
 <pull.2214.v4.git.1789373061.gitgitgadget@gmail.com>
 <1cce403113833c14a1c4a0da0db0772c5abdeb1c.1789373061.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cce403113833c14a1c4a0da0db0772c5abdeb1c.1789373061.git.gitgitgadget@gmail.com>

On Mon, Sep 14, 2026 at 08:04:21AM +0000, Thomas Bachem via GitGitGadget wrote:
> diff --git a/rerere.c b/rerere.c
> index 7d44f3937c..a996d39159 100644
> --- a/rerere.c
> +++ b/rerere.c
> @@ -900,18 +902,26 @@ int setup_rerere(struct repository *r, struct string_list *merge_rr, int flags)
>  		 * Another process may hold the lock for a while, e.g.
>  		 * "git rerere gc" while it prunes rr-cache, so wait for
>  		 * it instead of dying right away.  The gc itself never
> -		 * waits: skipping one of its runs costs nothing.
> +		 * waits: skipping one of its runs costs nothing.  A
> +		 * command that stops at a conflict must not die here
> +		 * either, so it warns and goes on without rerere.
>  		 */
>  		if (flags & RERERE_NOWAIT) {
>  			lock_flags = 0;
>  			timeout_ms = 0;
>  		}
> +		if (flags & RERERE_SKIP_LOCKED)
> +			lock_flags = 0;
>  		fd = repo_hold_lock_file_for_update_timeout(r, &write_lock,
>  							    path, lock_flags,
>  							    timeout_ms);
>  		if (fd < 0) {
>  			warning_errno(_("skipping rerere, "
>  					"unable to create '%s.lock'"), path);
> +			if (flags & RERERE_SKIP_LOCKED)
> +				advise(_("run \"git rerere\" before resolving "
> +					 "the conflict to record or replay "
> +					 "its resolution"));
>  			return -1;
>  		}
>  	}

Should this use `advise_if_enabled()`?

Patrick

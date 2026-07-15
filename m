Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EBE15665C
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 03:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784086049; cv=none; b=DUH6l3Wa9tHbUoX5/drSdiNKgxnBJEQG7tyQ1MWBS5gcOEsA1TC66xu06wZ22SVbKot2sOBxBN10N9S6KEPa5LA3xcMGV4VRUm5ZUWX/mrUFg7l0040HjQKmt1c2saBjxXsYqa/DVM8+3BzGsB5NJMP8oRvmOrXkP1dsBiSwOxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784086049; c=relaxed/simple;
	bh=Qnn5V90AnVgfHVLW+arqOkWPXUef13iGjcEmyUyRsF8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mMfxe+rgHhpVK9EkZhWh8In3cjwJ0CQnP3risWVq2p7DdSDBAX1fEuYsDAE9DPRGitKkaiVqDvGLsT3gN2oy4nH355TVfQjwvutYymTOnFGjNJzvG+q5VrKq5s0OShsY2FkkMvs+4gKkc9UZ9mprXp0CvYxPc9F7+Xn13jBG2Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jTZIME0C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kP/VYL31; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jTZIME0C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kP/VYL31"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 94ED21D0017D;
	Tue, 14 Jul 2026 23:27:26 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Tue, 14 Jul 2026 23:27:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784086046; x=1784172446; bh=YJ0Fti0kmj
	ualr/6PVpRhnDULXC6gUoITlFtrwHJRog=; b=jTZIME0CtuDvhacADb/zItMgYc
	Y5W49nqmO3pc45Shl/yoKPTUZUL6deU5OfFi2TSfhINVaef5Sb81YBIvg5/a8Why
	gUwwhPL+Mk01jdi7LOrjrC122FuSgbKI16R4kT52bfKOC0ZhGWXFx0VJN05dntLT
	qjQ3TmnX52Ax71YCo3AblQUXIUThSJ7+o8VpwrYE8gE8QkRut4oPeDgbkZSMCGMK
	yLzBSdv4qDZjVezmersFx9O45bCzHEWJF5ZjqfNPpzWz9J9rl2aCsrTD+iGZ2NFo
	Oan/HGEagmD44jh3Cx7L7PivjgCC1vmQx5+tKTnokg9WElygigVw+tGoidIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784086046; x=1784172446; bh=YJ0Fti0kmjualr/6PVpRhnDULXC6gUoITlF
	trwHJRog=; b=kP/VYL31BCwD6roWn1t/MG6EwXXuhmsashVtHG5CtnAk8wgD4Cl
	9sp/Zl3vxpXSzzfn7JOyrKRW3zph4CX8d4V6S1nn+GYCEH6LQXZKB6EcqDz1xR91
	BRniQCcWfU8ZUQNZ9yF08C/UeFw6ZpskyAxJtQVyLJr7phVgUva9ugUKtjtXt92e
	JkzgEeQkx3IHlna/+qkisGvOvkophDC6NDAGcfXiK5bsFpeAzSOL2tm871Lz41Xp
	br7t8Bxwz12d9p69kQxvL2lmHXBA3rG/grpX2vziQ2D6KO33ZVNRfkYLFGZKg562
	3Ny/ih1AKh9w/QUxqiEFvP0d85ubbtWuqeA==
X-ME-Sender: <xms:Hv5Waut1WaXlCTO3Ih4_SZ1bqOQ1F9Pj1b4oFwDmcRj36DT-lcmpnQ>
    <xme:Hv5WamA3YHg2Tz1JCKqS53d74Z1u0E44i8YpYWKEbpQ4lJ2jYC_ymnhPfu6wYtKt_
    BT5V7sZjjWXyBdKLBzqAJYCAR_itB1hmtqUkXZ5b25aOI9aoWKEJ8Q>
X-ME-Received: <xmr:Hv5WataoVYZwat3cxxLWR6nrc_-1QhW1OTVpU80Xow0bIDbAwwyMjJwbsQDUs5lwVbORrOdJ2nZ1BI1hNxkAgQ5vJVXXPEg96cK0R8U>
X-ME-Proxy-Cause: dmFkZTFikkjV+87IjFrInIBm4eBg2jJQGV1/Zdt5Ln+tCOSCR3sxjAxHZOrOhJQHzkiHBs
    YNtV3qxjZQuTjELlCAcuuyOFH9tOdovSqfp8t3GjGGAllQg9dQx4WdMccc/DFGRq+oH1+4
    BtF7aXrTVxdCwywHm1rwssnnXVHCsu+6YWMnyek9riVYH8KVzb6VB2icCZdw8MBuAGKtru
    HhYOiCohPgA1Q98aP8Ci8loB0+nuruR9Uaj/zMe8DF//yQgw9DbZCgFkVzn57XpUiqbd7L
    KvKJvR0VSPhBqGg3W0CfCKaLKZ8vtajGj5FEKEyO+gk6ZyazYJsmooMk87zHQFCxehfgni
    RVddi8KweVaOqqrygVMCTvzc6RIrntByExSqUnXlOItealTwfAfVDlrTCit7zgxzXZ3KWr
    YTH/fz8O+Q/NBGSpWB3EGNA2ec6zXU24n14h4FsxnRN8R/ar7dz49l8aQ7kFVsd9u4SkOO
    QJvuDgPukFyrzSbCqR1JtqtBhcKGTuUxalQsiGhSY2tkKx5HC0WPMPHS9dfc3pyiZxIdfV
    CznuF3x5m895zsGXrCNM/P7SDaO12ZaVrIwCe2WiZItm3dbMHMfJfT+tKJrLJCl997U40k
    tBemX6EkTvpKNNDEAxR/Uqi4hX5jtn6ErOrYYm4l5pJa5A0IxB8Md0MisUzg
X-ME-Proxy: <xmx:Hv5WapXc_W5G_xCA8Ad87cTbdVpsOb7ixOiaJ_qjlaTBawpSL7apCA>
    <xmx:Hv5WakP5IGc0qtWjPWJtgiJwrxzi6QFiTohezkQ9NEW2VVpdg79ABA>
    <xmx:Hv5WarYJYn6yep6lljYW_Q99hsHbD_z7kNYcFaNa6yEHDhgeZdKAqA>
    <xmx:Hv5War-iRnVC6dDoHVoqEc4W84NjjnA9Zcrds2_j7OsAkxN1vf9wjg>
    <xmx:Hv5WavkuD3mPlET_fKzj-x5wSpXofSy8QevePve4hh-4T2XLpX1Chqb1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jul 2026 23:27:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <cat@malon.dev>
Cc: git@vger.kernel.org,  ps@pks.im,  five231003@gmail.com,
  hariom18599@gmail.com,  Christian Couder <christian.couder@gmail.com>,
  Ayush Chandekar <ayu.chandekar@gmail.com>,  Olamide Caleb Bello
 <belkid98@gmail.com>
Subject: Re: [PATCH v1] repository: move fetch_if_missing into struct
 repository
In-Reply-To: <20260715011850.3181131-1-cat@malon.dev> (Tian Yuchen's message
	of "Wed, 15 Jul 2026 09:18:50 +0800")
References: <20260715011850.3181131-1-cat@malon.dev>
Date: Tue, 14 Jul 2026 20:27:24 -0700
Message-ID: <xmqq5x2hq6eb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tian Yuchen <cat@malon.dev> writes:

> The global variable 'fetch_if_missing' controls whether a missing
> object check should prompt a lazy fetch from a promisor remote.
> In order to continue the libification effort, move it into
> 'struct repository' and initialize it to 1 by default to keep the
> previous behavior.
> ...
> diff --git a/setup.c b/setup.c
> index b4652651df..ce2a80ac31 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -1064,7 +1064,7 @@ static void setup_git_env_internal(struct repository *repo,
>  		set_alternate_shallow_file(repo, shallow_file, 0);
>  
>  	if (git_env_bool(NO_LAZY_FETCH_ENVIRONMENT, 0))
> -		fetch_if_missing = 0;
> +		the_repository->fetch_if_missing = 0;
>  }

Could a caller pass a "repo" that is not the_repository?  In other
words, shouldn't this be

		repo->fetch_if_missing = 0;

instead?

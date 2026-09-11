Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9973F39D1
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 06:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789107773; cv=none; b=FBKXbnY4Dqr8eN3Lk9Nw+ki67FIw+CONrWCiqnDWoCFKv6l4VbMzpUr9RuGXZp7y7/hljXGzJOLJ0OSGEDYXaBy/knVr1/Oikvujmn5cyHiwKn938oxBcFSzW0zgURwkvwsd3XrWhK5ToEEqoGPR8C0J+wur1zF09d/QxY6ppWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789107773; c=relaxed/simple;
	bh=ZOLoATMsvB9gFM8V8U0Zfezx5tydbN4nD5wZzMiZ9+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HiP+ae1LFAzW2x5mWEuVjrq8etfU/JY/UB/WiE7ZslMewj0pMxwhALypkKIqbQYZsOyjCrZfLVH244+vCyl4zt1n64KRFldje9EA68Ofjq7iLnmLXrmGwdA1Wble0vzJkbEDt1XoM78Hn1WB9iXrTRtUYyrdGGmLZHrQe0EFTSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EPhASJW1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rr2/MB5X; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EPhASJW1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rr2/MB5X"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 35B641D000F0;
	Fri, 11 Sep 2026 02:22:35 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 11 Sep 2026 02:22:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1789107755; x=1789194155; bh=QvwiIXKn4R
	MXcX8FYJXLjafLYDCel4L7xDEkHIc9mlU=; b=EPhASJW1/AZdPoL6l6H8/iK4N2
	FjCNHqL2fHeAqDNb7OkJsD7LsYn2ynJdGwrX75IxfcWr3qOQBcqSKuHGnOXfM/3h
	3nzk0eu0cRfO95Ahh0zgi23/RQyJjASSmMqI2O3f4Gwk0qczYBYOeqfObrDsQhoz
	cSjQgCZ3p+uI9E+PInWfNXHHu6NsvFSsbigvasu1bdzSk7uHtrb2FcytGbZyVfsT
	du5/KnImHqjIAr00dwto9Q1am9ewG3qq6/w64E17kSBf2BP2BF4eT5+UnbVDYXPR
	U5XArabkJMdDauOMpvF+zh8ZW7Csj72tcnzu1bd2LdkDbNMJrFd4VR3icfkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789107755; x=1789194155; bh=QvwiIXKn4RMXcX8FYJXLjafLYDCel4L7xDE
	kHIc9mlU=; b=rr2/MB5X7VqLGrjwa0Rwq7vbNWQ1LFVOiY1wcs/ty+5Tbda8cdy
	o4HUXN9xse0leOiDUKmbTsyA6gE4slv1/0xSY4d8d4gtX8w5ekNOX68EiFB008nQ
	VWOMfCfEqBMT7SlxPGhMGj0mPF+3WSYvoKG2W1aMpucL2986moOK5my4r7KyrZRN
	zzJlImEx281P/swFrIpZunWQJ/QFXwHfB0FtzEN4uJI2Eej72xvV8LroZVS49Aq8
	mY2Un+eUioCzMasz9s3P8LWI0onTo9ffQjaA4xkNcH1YkWo6ewywPDAce3x70e48
	kNI9cNS8iL5/g9Do4UqbCCvWcfElAs1AZ+A==
X-ME-Sender: <xms:Kp6jagNbPvkiM3gaY-5d3bzUPwNC9hcKQoNve4qVaO0OZEzWSL_8Tg>
    <xme:Kp6jat1YQsFpe2abm1nnf-cA1qA9dekyI-zegSScD3xRbI-LhSyiZ1vbQRPxF41kH
    AIvn5Ag94Rx5DdyiGGdhC8EzTrr3Ffydp4av6EZvgfnId51Khs8m0A>
X-ME-Received: <xmr:Kp6javn25BmKDWIKlPApC4xm90aOeY6cYsoTzMqLi08oio5DPHX9W8PvWZV108AGzKGy7g>
X-ME-Proxy-Cause: dmFkZTGKcTHuoZXYAxCOeW4LCYQgslcP5/oZGNQ/lzqSVkPqKPIQn6lmY1Ksz5QbPne7dM
    qL0zxHP9BNdPgBJZ3cCxc2BXEFoNMxTnxfU19V4XmadDieyIqZDSvyNe2mV7gGMdQm1XEo
    qvuS0UXCUfB05zeC/G2Z5IjL6jhYL0oY3uW071qNm7mD+jKC1eGyWil+WjkOOSpeHUNpAG
    sVzwbr/sNxcKlZOIMhZ5WVSr5lHZbscH8aHWKujw/31tTIDRqKSJHbRRDW43U9u9TsZEf8
    RRSq9IeVQxffg9QpI5SYYWbe0+F5r0+hRCfc/CvJCsEcjz/PyHvIAi6Hwvjnf/Aeoc5OYH
    daSeejbR4wEEUxeRZ+u5Zbv0QgXCIL0nqlwpYgzQlvLV00RBaZIi0k9HgLOaHpX/PcE/h7
    aKa6qk0gN0hjibZT8vRjgnbXZ992i4uIC952DPprp7k5ZXGQoOujIFF4kj2Ms3IL1FzDJ/
    vsCxRcRQXHSV9HHd+LHs+AK/+ppAq310NW+E3B80cZD0e1pclqFU5iA8zN90pi5WfrG6QX
    RxEkvbrw9A7UzxN7JRfqjhmi54oheQikKJFkzZFGWqvPI2uDwI4XQrjMaqZtFDwKn71Q7Y
    1tWck4RFiWdjlglq6lL7h07SLTkc+sXqIZhKbHU1OY20mifY5PPkRuBCzHwQ
X-ME-Proxy: <xmx:Kp6jakUIjt0RLc-VW8FMrYTP8vwQjQz53KtWYDgiD77QGBFmBI6w5g>
    <xmx:Kp6jaltAmZuapn_Bwh2uF_6m9FKU5-cLQNs3whfnye6RvoAC6UKgMg>
    <xmx:Kp6janaC8jFbH5AHacicXtuzwNzdQ-Ttmpyqi8c_x4XthKUEKm8MnQ>
    <xmx:Kp6jakXYeBS2Q2ceAjM54szSfsZ-hy4RbJayJI3-ifeD_s37uorTaA>
    <xmx:K56jarlJ9pgBYr3o270SVVcJBKgOm17oYkG0DVAcS49bxm_HLrj-y74t>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Sep 2026 02:22:33 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b2ba689e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 11 Sep 2026 06:22:32 +0000 (UTC)
Date: Fri, 11 Sep 2026 08:22:22 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Tian Yuchen <cat@malon.dev>
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: Re: [PATCH v3 1/3] environment: drop redundant NULL checks in config
 getters
Message-ID: <aqOeHlPWer60LcoO@pks.im>
References: <20260805115342.3939931-1-cat@malon.dev>
 <20260807085932.3958759-1-cat@malon.dev>
 <20260807085932.3958759-2-cat@malon.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807085932.3958759-2-cat@malon.dev>

On Fri, Aug 07, 2026 at 04:59:30PM +0800, Tian Yuchen wrote:
> These repository config getters require a valid repository pointer.
> While an uninitialized repository is a valid state and is handled by
> returning default values, passing NULL is a programming error.
> 
> Drop the NULL checks so that invalid callers are not silently accepted.

I'm not quite convinced that having these checks in the first place is a
good idea. The single biggest problem is that we silently ignore the
settings in case the repository just happens to be uninitialized, and we
wouldn't ever notice.

On top of that, we even fall back to the wrong value: if we don't have a
repository, we shouldn't fall back to the default values. Instead,
shouldn't we fall back to the global- or system-level configuration?

I'm not convinced that this design is correct. What I think we should be
doing is:

  - Have the functions accept an optional repository.

  - If a repository is passed, then we verify that it is initialized.
    If not, we BUG.

  - If we haven't yet read the configuration for that repository, then
    we automatically do it so that we can also pass a repository other
    than `the_repository`.

  - If no repository is passed, then we populate a global variable that
    contains the system- and global-level configuration and return that
    value instead.

That'd work both in the context where we have a repository and where we
don't have one, and we'd detect the edge case where we have a repository
that is uninitialized.

> diff --git a/environment.c b/environment.c
> index 76ee65e62b..f5628b6758 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -119,23 +119,23 @@ int is_bare_repository(struct repository *repo)
>  
>  int repo_protect_ntfs(struct repository *repo)
>  {
> -	return (repo && repo->initialized) ?
> -		repo_config_values(repo)->protect_ntfs :
> -		PROTECT_NTFS_DEFAULT;
> +	return repo->initialized
> +		? repo_config_values(repo)->protect_ntfs
> +		: PROTECT_NTFS_DEFAULT;
>  }

So I think if we want to lose these checks, we should lose both of them
and require the repository to be initialized. But I feel like this whole
subsystem needs a bit of a redesign before we can continue iterating on
it.

Patrick

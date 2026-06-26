Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D1536B05E
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 19:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782501171; cv=none; b=r/wBeh7g1C/su8zlY5wwS85JN6wiKqRMP33/8r1DafGmqeGSvGASrphvefr20Onflv2/FI0Rzjb5Nu5RSPkElhJVLCRLlKFDMvbMzbvYirk9pn/jqMNkpai0e9SxT0oDeslGFSXSQ7sZhfYPUeSk9t1bVXPAf5xlm5McF+DFL3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782501171; c=relaxed/simple;
	bh=rHSEkYukBd5rrlKYQJCnStzvpMlCjkxwCzTvut9gQ7Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IIowlN60it7OcplS50rzVz0muqv1pJJul7qCA9avebfk3qV5awzpMAbiapccaO5O+8U0YOCJ5cSkiyX2PTWCR5GYLJEeL32tbafm4eeyKlHksPPdgDzx9OZ6aDs05ciqqALNnaMuLxX5VPFmGbz0/by4vfM5SrVMTxixoQfc/iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZoRZ7RHF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c4TpDYTM; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZoRZ7RHF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c4TpDYTM"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 227141D000B0;
	Fri, 26 Jun 2026 15:12:48 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 26 Jun 2026 15:12:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782501167; x=1782587567; bh=JWp5Fu7TNl
	FfDNOsNy/rLT914AKppsnftXdef4VfSe0=; b=ZoRZ7RHF3DIysDkzt0kYqzBleL
	kABeaeJEf4mJ/3VbQq6Gw/6c1PX2HS62vbay5rAZ/TFLBKhWNxdGazWj5jUU5Y2T
	kK6bsoECdJo8zcIgUzNsZXzGeVHEhwWJquYWWYOO8Lkl7msFJEF6iVksBmRPWaxQ
	W1wOrkusKNZj2lWeuwkrlq3vp1DzER0ZvLOm+QKha6IpOiPbTmgzI0NqOVpX94z/
	TfjZW4B5xzs1tnMOAzugqk+a9lv8GlFjWfvmujsnIstps06kWM6XkNVBtDVrC60A
	VuP1EHhN0Zk657MB9TslSSoQIxWfUQb/rdRxrHZhT3Ol88ugNieR4uLoLHcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782501167; x=1782587567; bh=JWp5Fu7TNlFfDNOsNy/rLT914AKppsnftXd
	ef4VfSe0=; b=c4TpDYTMpRA+tHz0M/sbgL9TFAB/QlvwVfsmf0gaeWTuN0e/wlV
	Tbej8Dq4quEHls33PBRgIvGPffoPZpIjWIOot+/Ei6sUffKyUy2V//5KhL4RPs1y
	8mgPs8GWSaNne+bE94b3WhAt4M8ZyBWF3pfBg5AIDUpkgBCHZayGUyQ1ZDD4YDhP
	sLfcuvXopjGtAGp261iNZ1c/GC0OU8mHgN0ZGLhrYOr9YMyfWNFjHxM9GOcf65r0
	rUQHPG9hNr/mfdELFFEff5mvmYungoPREf6c/2yxTtQN0SrHB983P6AE8yVy2Feb
	JhndJO5wraxgozt5kNRRSL6/4zib/xdgorA==
X-ME-Sender: <xms:L88-avg62ts1bu3q8SIWyucCg531plDuSGtMeqsMc1sA_IjjjbzwLQ>
    <xme:L88-auTvUxhcGgB0d7ZgfsblQGc9QqLaglkTpM4z344e2KIQfZPQatoDLNKHoaijI
    bOZXbILittHbgExCKy1gmro2pjkfUc6plrpCcfhBkPE8dO2cyi0GA>
X-ME-Received: <xmr:L88-ahXYt44LRXysCj9bfGpgV_SzDqK_zqjU7B5ulIPHcOIKD7E1tg8D8N3QC-GvoExU5_RSfXitMnmrsEEzNnwnLWyHKSvJZhRs5Vc>
X-ME-Proxy-Cause: dmFkZTEQbMBH/HH5OZ+5kD8Mq9rfql46eisOdm1ozHRAupLoTgBWsxaWrsqTcUVUNyu3Sd
    Cqgg2qyoPF+YVo4tCW7xIoytAkThbpek1a9KmnGSuCsY69U4mBWMFChdizSg7G20A8zNcY
    eP/vpwzb2ATRHPH+uT/LFuJIGhx6KDyGwclZlusPJLH8SydrdnU98F1AoJVckyxDs/4bvH
    7T0SUadox7D8IKsNTVqQCQ4xg28O0E23L5IY/XaAfR8JBidyJEgrmAg8RU8nIzyCeMAi8W
    kBI9/uhMftEuUkmPu/Yoqc9Ct/Ka3nWJf3MP5GdyoKWZZjLB2ZNoam6iHvaq8cthg5wHrj
    us/A72iNRJrXTIyGrrLiP2/ywxggN+Oxh2JqYtola/9MrVby6GHX/Jfz5G3sbqm8whKS8D
    i5XHzxsIwD1+ASGb2CzJlm2AN8AZoST2TSzMbRwWp/EWNocGR6UWVtFX1X6iVW+4qI5ecJ
    D5qSMmShy0k3ML+l+qj6ca/0+XgfExi+lqsRGN7ZOXi/iYloXiFP6OLeEt3ccH6hw2ZaB3
    FGV4ndl7sGJZCkCCQJrltdCg4I3bZyqPtB93+S0ZH0Jgwy1bwPTrZtPoZPFdtHi+5XYK3W
    IILHi5QiotTFZRJXEcJWW3U/LqmmkI60blg19gI2cQuB2H2nH5cD2cWb75YA
X-ME-Proxy: <xmx:L88-aiRNdeilNKCUWnGfdbxmYQjJ1xV55nS7WaTgmlxfUw6c4XJh7Q>
    <xmx:L88-arkEJfon7StWWAzJQYHeIm47kYuNeFUuOkdpXfhMOf_6qyUgcQ>
    <xmx:L88-ao6Y2t7RUs8hecRp9vRaGxyRLqLOj9-a3Ps1co_dMWMo_0zLbw>
    <xmx:L88-ahjk5IJi_5opqjeWx-DYdvQEk5JK--XwPoeGVCHrm1N36OeCvg>
    <xmx:L88-al96rGhSHVYdRR_jbFG6utX__Gj7aG0Xf-gTG6sfslSmQoZAWzOL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Jun 2026 15:12:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <cat@malon.dev>
Cc: git@vger.kernel.org,  cirnovskyv@gmail.com,  Christian Couder
 <christian.couder@gmail.com>,  Ayush Chandekar <ayu.chandekar@gmail.com>,
  Olamide Caleb Bello <belkid98@gmail.com>
Subject: Re: [PATCH v2 2/2] environment: move excludes_file into
 repo_config_values
In-Reply-To: <20260626075037.532164-3-cat@malon.dev> (Tian Yuchen's message of
	"Fri, 26 Jun 2026 15:50:37 +0800")
References: <20260626075037.532164-1-cat@malon.dev>
	<20260626075037.532164-3-cat@malon.dev>
Date: Fri, 26 Jun 2026 12:12:46 -0700
Message-ID: <xmqqjyrl6rpt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tian Yuchen <cat@malon.dev> writes:

> Continue the libification effort by moving the 'excludes_file' global
> variable into 'struct repo_config_values'.
>
> Since 'excludes_file' is a dynamically allocated string (char *), it
> requires proper memory management. Introduce repo_config_values_clear()
> to safely free the heap memory when repository instance is destroyed.
>
> Note:
>
>  - 'if (repo != the_repository)' fallback logic is temporarily added
> in both the getter and the clear function. This prevents calling
> repo_config_values() on uninitialized submodules, which triggers BUG().

Would it be possible for the function to be called on the_repository
before it gets initialized?

> +void repo_config_values_clear(struct repository *repo)
> +{
> +	struct repo_config_values *cfg;

What I am wondering is if this check

> +	if (repo != the_repository)
> +		return;

wants to be more like

	if (!repo->initialized)
		return;

or even

	if (!repo->initialized) {
		BUG("clearing uninitialised repo config");
		return;
	}

Or perhaps not doing anything special there.

For that matter,

> +
> +	cfg = repo_config_values(repo);
> +	if (!cfg)
> +		return;

Wouldn't it be a bug to see NULL returned from the above function?
Why is it healthy to pretend as if nothing bad happened?

> +	FREE_AND_NULL(cfg->attributes_file);
> +	FREE_AND_NULL(cfg->excludes_file);
> +}


What do we want to happen when somebody does want to access (not
_clear(), but repo_config_values() itself) repo_config_values() in
today's code?  Don't we want to catch such a code as buggy?  Isn't
it the reason why repository.c:repo_config_values() check these
conditions and calls BUG() in the first place?  And if that is the
case, I find that a caller that "works around" by pretending nothing
bad happened and not calling repo_config_values(), like the above
code does, highly questionable, as it smells like sweeping problems
that you designed other parts of the code to detect with BUG() under
the rug.

In the longer run, we would want to have separate settings, which
used to be global variables but now are stored in per repository
config, available and usable in the context of each repository that
they are configured within.  If a caller wants to clear per repo
config for a repository instance by calling this function, this
function is in no place to tweak the intention of the caller by
short-circuiting the request and pretending it did what it was asked
to do.  In other words, the rest of the code not quite prepared to
deal with these global variables that turned into per repository
configuration values is *not* a problem this function should
address.  Let it be noticed by repo_config_values() function to
catch offending callers for now, and once the codebase becomes ready
to use one repo_config_values per repository, this function does not
have to change.

Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0562B331A66
	for <git@vger.kernel.org>; Wed, 19 Aug 2026 08:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787127857; cv=none; b=VDn2/dyG3mxPxnimU+4oyfF1jkTTX+ovtBkMN5kx7tMkfv2A4+jniG+CJgb3jpp9qxr5BWXMjR6kXFebwUIJfOvgHX/HyzSYej5kn81IxypXWyXgXmDLtNfyXCmYkIhR6FenJBVC14kgbW3GUV+Xk1qTYL6wZ1SoBo3aKuuiKL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787127857; c=relaxed/simple;
	bh=4+zV3J7zqv7xr/Qp4g+m8VrRCGXQZKiXaLoibIBAwiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mfYxlg/ckY/BuPRQcbXWDlwTY8skU29IH71ZQ8EJcXwZ5r/Q7Qs/tA0ehWOI+UGjcZcx1HMRfKMyKviU8/rtKa7tLAxE1ytUmKEYngk/S1VmbVXMqJp1WDxxoCjO+dtcpqH27wQblg6rBreLoJpyyOgxIQeHA6P3P+iKSfcQhZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eVMuYCd4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Dj75GSyK; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eVMuYCd4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Dj75GSyK"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1F0457A002B;
	Wed, 19 Aug 2026 04:24:15 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 19 Aug 2026 04:24:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1787127854; x=1787214254; bh=RhpeYBImuJ
	tLhtVP/q6B9KJxFKek2CHjKoJIfFMWC9g=; b=eVMuYCd4m9qYF3C0L13MrfU2h2
	2y0DDdOJyEYzNUUckKsMnOaqGEPIJeyov63dFTdn3dfnEJrg50LYOjhBdzmDbJGg
	aRYWAEFMmvd9pqEFDjzLHARciSefq+qBuXUxJMqpJVmY5k09hBGBfJBbxz4zj8as
	VsPsS72wkmNtUEmj34YqOnCuldO2JZKpSxA1zIdJbt07uh0zavAUUhCnKtr/KoCQ
	HisxXnIWJzMY5CeitFWu9Np2XDnGxIiciJmCeAKRU+99opYwfgfj0NZA0x6t12AG
	/HaFOWt1XQYU+8udAaTcU6a9j0ilvKzJzcbUY2GrtDVV6wNUsRZqxuuHtung==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787127854; x=1787214254; bh=RhpeYBImuJtLhtVP/q6B9KJxFKek2CHjKoJ
	IfFMWC9g=; b=Dj75GSyK92TkdFYjCOs+PH35CzxROXY/4nA35ubXIkbUIgZXu+y
	4P5yj0/XMIbNp0A95zMH5LaOVDDfKkPFGzXg/KUMXrMeWPigdV+xJKuHy7/ctPul
	OsqY/M/MudJ6jzhCrJWT1s2bTCyMb3BOE2JsFRQpTQfgS4zzG+Y+5QTexns0Zl5h
	nX4dFxl6DrVcBmv68a5BPacehVjZr4Hm3a4vmsCpV1hy60fZ8JEVlW0U8DrHvjL3
	HhK17XQlyknfpO2mafZ3ZLQm9ltJ6dY88+QgRBc9Dw7/TkXqfiu3su2yc1c5+Cz/
	x3Gi4+oOKH8gGDirq5+4H8iXtHsSAKNWTSw==
X-ME-Sender: <xms:LmiFaqU6c0FA0bXaelGhT7oiLSQOt_SuTd81rg6ys7f_dgdPC04tKQ>
    <xme:LmiFaqR3TYLNYSBH-Y-ktYHGoN3_kxCrOGqh5C-tVpxIR-63yxFXJAsiAaF_tREXJ
    0d-Grhj8TgWlRYHm7bbADEbJOecX6RnWL8EEPZ3r6e2T9TWSCwYJQ>
X-ME-Received: <xmr:LmiFaoOjbOCi6LSIKR4q3TsR92e5IuRgrumP_Ve8rNvBuk88kpLb6puI9LrpvvaFe8r2JHM2q6gygQJ5w3EMUixFJ5nMfIKaeowvO-ia>
X-ME-Proxy-Cause: dmFkZTFyj8BJR40SD/+4ODl7S1ghZQjZx5myUTv8qREH/mfZavx8EylfRbt0WAbcOPF3Tq
    u5tfwU1vKlyF312k6IZKFYcX3DKbdmWyo9RO6SgtrjeuwhwKW3dtGSVhXbzodHhqpeIMmy
    ymnkxK49ytsxt3ehlm6gMP3Hsm2Glf+9tnwOS4maLCXvYfRb1IF16Xn0YaFutVqWmwIFf2
    f2dR2/c20BLxq9is91Z3Z86dM1KX4+6HzemXLFInSqPmccHFzzWyoq9vpYfZGidozSaxNN
    465iIeezzEqmJA+rmF2fgGuo9+Vgv4+2I3OdN9L8dawr5aAlT989GvADoMLanhTQP2CaRM
    0Ki3/QdCdid6Di2CQepPYEdYsD/NoS5tzLLqRUzvEEWfx/mFCSYtagjMEO0zBP0Nqf+FUI
    sZVMGfo6llE61QGk5xIkEYZwgJKI2fyPkz+ZBd2DqPDa0fdpT8a1OYmAkzbVHOyyTbiVgA
    MKSFaFO+s0L5ijdek8n0KxUSj1hcfqlV30e5YFXFpYbpULqvytcuhqCp+9cPPwXCS6C+Xj
    vF/ihUlCpBeJ7H3HPlIiVAzQyZBkl+gqYMIAiN/WB6d3fCNBXIkj6CxITQzSos5iiU4SSx
    NM9/Sgk+BTYVPyiJZFN4VVyDAm7f3eGLNUInXhOqPrSRMtBHXyFHu7gYUdqQ
X-ME-Proxy: <xmx:LmiFaoTA2mPZd8Ee7doGfOTYZfSMAIiEDPDlOmXN730oco0O_zobxw>
    <xmx:LmiFamhfQGWrhfPKDXOhKI6U29IN8oj9dzVdj0E8wzilAoERB02vcQ>
    <xmx:LmiFah8uMKU8Y2EEBQVIUxVHvp8rxPG0-6SRaYgBYX4WbO09LIcW3Q>
    <xmx:LmiFatHzjxP92RZ0qZyTPJAzNEKcZhFehN-Q4dErrysWxq3tJTVVVA>
    <xmx:LmiFauBs68e3A4dDg_v-uPVVnuNQHCAT_yMCVScQHhzaUpo4yCtDdMEv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Aug 2026 04:24:13 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4c2f59cf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 19 Aug 2026 08:24:11 +0000 (UTC)
Date: Wed, 19 Aug 2026 10:24:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org, Todd Zullinger <tmz@pobox.com>,
	Junio C Hamano <gitster@pobox.com>, Tian Yuchen <cat@malon.dev>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: Re: [PATCH v3 3/3] core: convert build-time USE_NSEC into runtime
 core.useNanosec
Message-ID: <aoVoJ3Ijoaj3u64e@pks.im>
References: <cover.1786103607.git.ben.knoble@gmail.com>
 <cover.1787065125.git.ben.knoble@gmail.com>
 <48fceb4b575ca39346cf2f59f621584a19049008.1787065125.git.ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48fceb4b575ca39346cf2f59f621584a19049008.1787065125.git.ben.knoble@gmail.com>

On Tue, Aug 18, 2026 at 10:59:47AM -0400, D. Ben Knoble wrote:
> Racy Git problems persist today, manifesting themselves in the
> performance of commands like "git diff" in new worktrees [1]. We have
> long had a build knob "USE_NSEC" to tell Git to use in-core nanosecond
> precision when available, which mitigates most if not all racy issues,
> but most builds we know about it don't use it. In part, that's because

s/about it/about/

> diff --git a/Documentation/config/core.adoc b/Documentation/config/core.adoc
> index 340329edc3..33104444ab 100644
> --- a/Documentation/config/core.adoc
> +++ b/Documentation/config/core.adoc
> @@ -118,6 +118,12 @@ core.trustctime::
>  	crawlers and some backup systems).
>  	See linkgit:git-update-index[1]. True by default.
>  
> +core.useNanosec::
> +	If true, use nanosecond precision for ctime and mtime
> +	comparisions between the index and the working tree (if Git
> +	was compiled to store it).
> +	See link:technical/racy-git.html[Racy Git]. False by default.

Should we mentino here that this may not be safe on all platforms and/or
filesystems, in addition to linking to racy-hit?

And do we really want to link to the HTML page here? The user may be
reading a manpage, so doing so feels a bit weird to me.

> diff --git a/environment.c b/environment.c
> index 6676e6f5ae..c7f6b801f4 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -571,6 +571,13 @@ int git_default_core_config(const char *var, const char *value,
>  		return 0;
>  	}
>  
> +#ifndef NO_NSEC
> +	if (!strcmp(var, "core.usenanosec")) {
> +		cfg->use_nanosec = git_config_bool(var, value);
> +		return 0;
> +	}
> +#endif

Do we want to omit a warning in case the config is enabled and we have
NO_SEC set? Or would that be too obnoxious?

> @@ -769,6 +776,9 @@ void repo_config_values_init(struct repo_config_values *cfg)
>  	cfg->ignore_case = 0;
>  	cfg->trust_executable_bit = 1;
>  	cfg->has_symlinks = platform_has_symlinks();
> +#ifndef NO_NSEC
> +	cfg->use_nanosec = 0;
> +#endif

Can't we set this unconditionally? The respective field exists
unconditionally, too.

> diff --git a/read-cache.c b/read-cache.c
> index 6c449f393d..31888f77ee 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -353,12 +353,18 @@ static int ce_match_stat_basic(const struct cache_entry *ce, struct stat *st)
>  static int is_racy_stat(const struct index_state *istate,
>  			const struct stat_data *sd)
>  {
> +#ifndef NO_NSEC
> +	int use_nsec = repo_config_values(istate->repo)->use_nanosec;
> +#endif
> +
>  	return (istate->timestamp.sec &&
> -#ifdef USE_NSEC
> -		 /* nanosecond timestamped files can also be racy! */
> -		(istate->timestamp.sec < sd->sd_mtime.sec ||
> -		 (istate->timestamp.sec == sd->sd_mtime.sec &&
> -		  istate->timestamp.nsec <= sd->sd_mtime.nsec))
> +#ifndef NO_NSEC
> +		/* nanosecond timestamped files can also be racy! */
> +		use_nsec
> +		? (istate->timestamp.sec < sd->sd_mtime.sec ||
> +		   (istate->timestamp.sec == sd->sd_mtime.sec &&
> +		    istate->timestamp.nsec <= sd->sd_mtime.nsec))
> +		: istate->timestamp.sec <= sd->sd_mtime.sec
>  #else
>  		istate->timestamp.sec <= sd->sd_mtime.sec
>  #endif

I think this would be a bit more readable if we had a single NO_NSEC
block.

> diff --git a/statinfo.c b/statinfo.c
> index 5e00af127d..2f2cec6282 100644
> --- a/statinfo.c
> +++ b/statinfo.c
> @@ -72,12 +72,14 @@ int match_stat_data(const struct stat_data *sd, struct stat *st)
>  	    sd->sd_ctime.sec != (unsigned int)st->st_ctime)
>  		changed |= CTIME_CHANGED;
>  
> -#ifdef USE_NSEC
> -	if (cfg->check_stat && sd->sd_mtime.nsec != ST_MTIME_NSEC(*st))
> -		changed |= MTIME_CHANGED;
> -	if (cfg->trust_ctime && cfg->check_stat &&
> -	    sd->sd_ctime.nsec != ST_CTIME_NSEC(*st))
> -		changed |= CTIME_CHANGED;
> +#ifndef NO_NSEC
> +	if (cfg->use_nanosec) {
> +		if (cfg->check_stat && sd->sd_mtime.nsec != ST_MTIME_NSEC(*st))
> +			changed |= MTIME_CHANGED;
> +		if (cfg->trust_ctime && cfg->check_stat &&
> +		    sd->sd_ctime.nsec != ST_CTIME_NSEC(*st))
> +			changed |= CTIME_CHANGED;
> +	}
>  #endif

There's one more site in "builtin/update-index.c" where we mention
USE_NSEC that wasn't updated as part of this patch.

Thanks!

Patrick

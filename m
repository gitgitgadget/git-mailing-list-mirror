Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC3B20E70F
	for <git@vger.kernel.org>; Tue,  1 Apr 2025 17:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743529420; cv=none; b=LC2q/EW4GcO77wvLIngY1u8lyf5qd9raZMDjfwc8TWCH1PjcSxWIpiCf2fBnA2xPjTyQcqdR8gODnkx2THVNG/CqtDiffuKsTuRSJeB1wT+dMURuy1RsPJXwu62JekL0MJNgV7qRwgmHh5P6YV+FvOE70JhD39jIHFQANf9VY68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743529420; c=relaxed/simple;
	bh=VqBBwfhMQ5dhjASn3keixk64JEsg6eLTqJnZt3EkKYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NymMrGt3xvqvq5f0UNApUMsTlphv9BAD/efDkVvtbrlh4aMgfLe+3JQSpp6fcuXZoQyjPe+R27Btfm47w4h0QMBQGuOpLrhwEWw1fGJJ2SH/XG9+1PphOHz/Yb55SwpcSDiN85OLQ+m/ck1ZlJvPanmI4N6k8JxU+zt/WUR16Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=akshay.is; spf=pass smtp.mailfrom=akshay.is; dkim=pass (2048-bit key) header.d=akshay.is header.i=@akshay.is header.b=bCmdBg4k; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=akshay.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akshay.is
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akshay.is header.i=@akshay.is header.b="bCmdBg4k"
Date: Tue, 1 Apr 2025 10:43:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akshay.is; s=key1;
	t=1743529413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q/cuhwX7c/9cNVK5Q518UOKK9b6L7A2pfHb7v4I6h9U=;
	b=bCmdBg4kuD0v5zEGN7Vrylv1HOov72pKKg2Ftg8z3/r+d9urJjiXWajgaS8VZvGq01UnRG
	toA5KOAR9hWlURXsW9LUwt2APd5cifmT5g5c+FxuZ3+vi0lNmVRRayW/weeDvep1J/eRB6
	3Kh/D9mBa94PvDtgeX1uOUXOPgXd49tbqM2CyEvcw2cEgCDJ2TDMlDSJPCGmcznJwGpsll
	i9wDxTdcut+TSJIk8UItIxQpi4weobHzCPyL5yBIYoFEUuOhWuQ6c5lT18+MT17yzTEmJO
	rbBkbbXJ8fPL/tKegyYMGHwFQp4dV7XWt6AswvcxeHb3YLywQpmCpLtsjb/2Qw==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Akshay Hegde <lists+git@akshay.is>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: Re: meson: Installing completions
Message-ID: <Z-wltqWraESmb-Lm@akshay.is>
Mail-Followup-To: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
References: <Z-uLqQd7QHZq-tB7@akshay.is>
 <Z-u42Sm613hMj1Ft@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-u42Sm613hMj1Ft@pks.im>
X-Migadu-Flow: FLOW_OUT

On 2025-04-01 11:58 +0200, Patrick Steinhardt wrote:
>> I just wanted to double check if I'm supposed to install them manually,
>> or if I missed enabling some options (I looked through the top-level
>> meson_options.txt and meson.build files and I don't think I did.)
>
>For now the status quo is that you have to install them manually, which
>indeed isn't optimal. It matches our Makefile, which never installed
>those completions, either. But that by itself isn't a good enough
>argument from my perspective that it needs to be the same with Meson.

Yup that seems entirely reasonable to me, and this was my initial
thought. I don't have much of an issue installing them manually.

>
>The biggest question though is whether distros are aligned enough for us
>to provide standard installation paths. That is, do all distros end up
>installing bash completion into "/usr/share/bash-completion"? What are
>the desired directories for tcsh and zsh completion?
>
>If there is enough standardization then yes, I totally think we should
>start installing completion scripts automatically.

Well I can't speak from any sort of authoritativeness here, but for zsh,
they are usually installed underneath the datadir (usually /usr/share),
then under zsh/site-functions. Of course, I don't know if that's true
for all distros.

Could we extend meson_options to allow specification of bash/tcsh/zsh
completion directories? If they are not empty, I think it would be
reasonable to have meson install it automatically.

Either way, I personally don't think it's too big a deal but would be
a good 'quality-of-life' improvement.

Cheers,
-- 
	Akshay


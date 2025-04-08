Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C0D63A9
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 00:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744070460; cv=none; b=WMFuyZVpoyJNd0IwDWl1rEFHyYzm6BrBUG6lLwhCbLFkrzbLEA7BixFHPDtjMZi1z3KUzEPgHo6bPWIH53HAhvzLqfwWtTFhSmcesWXA3zTnO8Fp07zRhQaFIL7or1fUtLcy7D0JzCaHM6ZseKZBP+RkWKjXxqvkhUNBgBZHqrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744070460; c=relaxed/simple;
	bh=APu+5LpA7XhSeTgJuleQ5pQCzNIiccMSgEdHvz0Ya5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=km/j6IRagOJOrD3jOKrv8VH6WEUA/38Z41IiedfeQbeuK5hZU9tStmy65iopGbt9olchTy3c+NGXTsB04khZ1KQv4CgPp9DOtY0jeRBaR44OVAbamNdHOJMFWPKwbVCj3KQeZ5iKaRToLGNKb+al3Sp8VdN7MRb81fOGRnJI9+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=akshay.is; spf=pass smtp.mailfrom=akshay.is; dkim=pass (2048-bit key) header.d=akshay.is header.i=@akshay.is header.b=vyRcHKIa; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=akshay.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akshay.is
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akshay.is header.i=@akshay.is header.b="vyRcHKIa"
Date: Mon, 7 Apr 2025 17:00:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akshay.is; s=key1;
	t=1744070453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m8Xtgtl4nkC3z7nzNPI85B4reU+pdW9cdvjSQZRq+Ko=;
	b=vyRcHKIajkWJ9cQwWnO84Vc2eom354bAkOqOfvyg0uCEHAbXRnW0k57ueuxnvecY4Yvqsa
	aRjL0lDnAbQg1zZTxs/JfQ2JtlLbQ/a74YCHuIlc8l9s2YkdAtDO4J+xhNhIAvyMfhoKEB
	Rg02z6oEYtODta++t2HwIZGCVTUgF8uyZVVKb9mB7/jHgYQLMtbN37HmpaXMr3h8tQ+nfq
	BxiuvUbchCG59CxENpYjOs7fBGt2ClHb7Th2kZN5g/awsqTl9r8G/7mzabt1aSeoRiVCaT
	HgoUDW/HzeITeQ19Qewg/yJ6fCo/rd7uFd5qVrpDs4KIRX5sZDhz7cHAvSraww==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Akshay Hegde <lists+git@akshay.is>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Todd Zullinger <tmz@pobox.com>
Subject: Re: [PATCH] meson: install shell completion scripts
Message-ID: <Z_RnJEyvtGh_0kFo@akshay.is>
Mail-Followup-To: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Todd Zullinger <tmz@pobox.com>
References: <20250407-b4-pks-meson-install-completions-v1-1-8a7eb8b9284b@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407-b4-pks-meson-install-completions-v1-1-8a7eb8b9284b@pks.im>
X-Migadu-Flow: FLOW_OUT

Hi Patrick,

On 2025-04-07 09:42 +0200, Patrick Steinhardt wrote:
> Hi,
>
> this patch is a result from the discussion at [1]. Thanks!
>
> Patrick
>
> [1]: <Z-uLqQd7QHZq-tB7@akshay.is>

Awesome, thanks for the patch! I applied it on top of git 2.49.0 and can
confirm completion scripts get auto-installed at their appropriate
locations under datadir. The datadir can also be customized by passing
in '-Ddatadir' to `meson setup` so it's pretty flexible.

One thing of note is that the git completion script for zsh also depends
on the bash completion script.

So if you use a non-standard install location like I do (I'm pretty
weird, I use macOS with a package manager I've written myself), you'll
get an error with the git completion not being able to find the bash
script. The fix is to tell zsh where the bash completion script is
located. This is also helpfully communicated in the completion script
for zsh:

    # You need git's bash completion script installed. By default bash-completion's
    # location will be used (e.g. pkg-config --variable=completionsdir bash-completion).
    #
    # If your bash completion script is somewhere else, you can specify the
    # location in your ~/.zshrc:
    #
    #  zstyle ':completion:*:*:git:*' script ~/.git-completion.bash

Adding the zstyle line to my ~/.zshrc made the completion script work
without issues.

Most people won't run into this since if you have this installed in the
standard locations, it should just work, and the zsh script does have
logic to look for additional paths it may be under. I just wanted to
mention it for info.

Cheers,
-- 
	Akshay


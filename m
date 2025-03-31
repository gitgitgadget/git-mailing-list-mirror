Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A3422541D
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 14:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743432798; cv=none; b=NzZRVKn+0s16eVvz2FUsEqodRGz1mRzz/CSSjZRinqdGPhatlCCEAxgqcjfT5iurGjGGuEMGX1ysL5MsIi7pMLPpRNNfcT9sLYunSbUaa/rUyDFmszTiFnFO+M+D7m1VwjMJsBbyt9fIpXw1j7Y0mKvESKxjM+O46iT0dKtQlls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743432798; c=relaxed/simple;
	bh=iCLvgtEzjLzrEmubEimejzLoT3rNMZc5eXsoxIasJkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qNVEp0jhIRB00gmX+uzotlNfUe6uxflviduBy45RPcgAU9mPi5qiF54xcqNB2mYwAvhBDbCMYkV/lAUP1MREIG0JexaF7p46vCfq4zmnpZ2mAbvjevYkgBdh2RW2+wVq7LVXRGpQ1jDyLTr8o0hE+mj4nsor5cb9gHFyqLTn0Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MIbyqPVr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MIbyqPVr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0525FC4CEE9;
	Mon, 31 Mar 2025 14:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1743432798;
	bh=iCLvgtEzjLzrEmubEimejzLoT3rNMZc5eXsoxIasJkM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MIbyqPVrdlrdagpYHa8+yPoPPN9RSApiBv0xKMZ5gtfrrwU0OO9i1prALqYSZr3Cc
	 jrscSxeVVTIYAVQcxwaMFDV3CT32SXUTnGCl9mGCIM1wCR9ChYLhTKoORkBTR8YoD4
	 jjFDTDkDApPcHfBgP8NvTDXhL7n/UpPefBxjvVE4=
Date: Mon, 31 Mar 2025 10:53:16 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: MegaBrutal <megabrutal@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: How to get git-daemon to work in a post-CVE world?
Message-ID: <20250331-devious-woodpecker-of-temperance-b18608@lemur>
References: <CAE8gLhmKtV-Kz4jYT6r1NanmGdAyzd0CumVGsVnVpePQPAtnzQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAE8gLhmKtV-Kz4jYT6r1NanmGdAyzd0CumVGsVnVpePQPAtnzQ@mail.gmail.com>

On Sun, Mar 30, 2025 at 10:30:00AM +0200, MegaBrutal wrote:
> Hi Everyone,
> 
> I'm new to the list, just thought it's the best place to talk about
> Git. I'm running a public read-only git server with git-daemon. I've
> recently noticed that my repos can't be cloned and found that
> particular CVE which made git to verify the owners of the git repos.
> 
> fatal: detected dubious ownership in repository at '/srv/git/mgsautils.git'
> 
> The feasible solution is to declare the directory safe in .gitconfig.

You can set global values in /etc/gitconfig, e.g.:

    [safe]
      directory = /srv/git/*

-K

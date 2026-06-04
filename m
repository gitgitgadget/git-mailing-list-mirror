Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA6327732
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 06:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780554168; cv=none; b=P4xPFDc1qD3Y0DoJl18dtTVAJ9h/YWPNkzYcvW+zKXVdkNOZvVqyviSkegG6jkMuA0HDh8As2VglOllqYDmkuz6Ldmywz3sHv/HmMAwykqqO86n2dB/n6vUm3xu5asaBzSH2rzpHMa0cn25c+qyImCuStfjMj8tLcp7m6jPMyqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780554168; c=relaxed/simple;
	bh=tovHBBVwKueQiwHbIz6sB6VpnLMBR3RK/u5rj6US+uU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GAzRZnV+MILZkhv4v09yDctCG7NVtSHiwb60Z6GEqcI+ZR7EozBegLGOggwmYRP1anjPJVPzISA6B3J1G09wxRUSwJj4K6QiRzdCtiqZm4xtDpHxP2NZQKw0Z0dHwQgZwzLzo1xzetmYnMtBoBf8HUNAl1iT/v7luAUhdTKDm5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=XH42eVfm; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="XH42eVfm"
Received: (qmail 43235 invoked by uid 106); 4 Jun 2026 06:16:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=tovHBBVwKueQiwHbIz6sB6VpnLMBR3RK/u5rj6US+uU=; b=XH42eVfmNTi7WBQTIWcY+ynfWZHbmsBmPst3JaxOtZff+hC1OxcR0mv3eSLhItVlKFxxE2HRdCNHdTYrh1QigNcMEk7sCCr+0G3MsyB1DOiCflgn+ztTt7Hs59YKy+kdnYePK1idVwWS5yzWCpa5vJ+nIM5bBATD143vyuF//lfkDY0j7T5UbZqUt4aLdiJZN9qESK0uRxiGCh8EMbmRYcitTrTOXdrXwPrFlUTnmQ8jkOgdNXbC5P1TrATysAL+L1LJVBvHjXu2tP3A1O69CsdaPFtZxsYTsNOyjrey0iv01/vm+CoIm20pn0+8oj3ms3X4te11xnhTTcVxTmMplw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 04 Jun 2026 06:16:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 110370 invoked by uid 111); 4 Jun 2026 06:16:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 04 Jun 2026 02:16:09 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 4 Jun 2026 02:16:05 -0400
From: Jeff King <peff@peff.net>
To: Simon Richter <Simon.Richter@hogyros.de>
Cc: Junio C Hamano <gitster@pobox.com>,
	Benson Muite <benson_muite@emailplus.org>, git@vger.kernel.org
Subject: Re: Mirror repositories for submodules
Message-ID: <20260604061605.GA3194609@coredump.intra.peff.net>
References: <875x42vlgv.fsf@emailplus.org>
 <xmqqcxy7qfgk.fsf@gitster.g>
 <d64e7f31-4e00-478c-ab31-b671242865fb@hogyros.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d64e7f31-4e00-478c-ab31-b671242865fb@hogyros.de>

On Thu, Jun 04, 2026 at 02:11:38PM +0900, Simon Richter wrote:

> Cloning from our server will, depending on what upstream uses, either a
> relative URL (which will go to our server, but we have little control over
> what the name part of the repository base URL is going to be), or an
> absolute URL that instructs clients to pull from another place, which
> conflicts with our goal to have a self-contained archive.
> 
> The idea posited earlier, to have a "repository identity" that remains the
> same across forks and clones, is somewhat appealing, but the best idea I can
> come up with is generating some kind of repository UUID, and adding a
> symlink -- not a great design because it pollutes outside the repo:
> 
>     $ mkdir myproject
>     $ cd myproject
>     $ git init
>     $ ls -l ..
>     lrwxrwxrwx 1 simon simon   9 Jun  4 14:05
> 12345678-9abc-def0-1234-56789abcdef0.git -> myproject
>     drwxrwxr-x 2 simon simon  40 Jun  4 14:04 myproject
> 
> On the other hand, this can be used to construct a stable relative submodule
> URL.

Here's a thought experiment. What if you put the UUID into a URL, like:

  repoid://123456789.git

Then your in-repo .gitconfig would point to that repo id and be
consistent. Of course you need some way to tell Git how to retrieve
repoid:// URLs. You could do so with a custom remote helper
(git-remote-repoid), but presumably that helper is eventually going to
end up going over one of the normal Git protocols.

So we just need to tell Git how to resolve repo id URLs into concrete
URLs. And indeed, we have url.*.insteadOf to do rewriting already. So
for example, you can add a submodule but convert it into a uuid like
this:

  $ git submodule add https://github.com/git/git.git
  $ git config -f .gitmodules submodule.git.url
  https://github.com/git/git.git
  $ git config -f .gitmodules submodule.git.url repoid://123456789.git
  $ git commit -am 'add submodule with magic repoid'

Now if somebody else comes along and clones it naively, the repo uuid is
not useful to git by itself:

  $ git clone --recurse-submodules repo
  Submodule 'git' (repoid://123456789.git) registered for path 'git'
  Cloning into '/home/peff/tmp/repo/git'...
  fatal: transport 'repoid' not allowed
  fatal: clone of 'repoid://123456789.git' into submodule path '/home/peff/tmp/repo/git' failed

But imagine that "somehow" they have learned that 123456789.git can be
found at some URL. You can do this:

  git -c url.https://github.com/git/git.git.insteadOf=repoid://123456789.git \
      clone --recurse-submodules repo.git

which would clone from the original URL. Or you could even imagine that
they have a cache of repositories named by uuid, and then:

  git -c url.https://my/cache/.insteadOf=repoid:// ...

would rewrite all repoid://'s automatically.

The use of "-c" here is mostly for illustration. It is a per-command
config, so when you later try to update the submodule, you'd run into
the same problem. Probably you'd want to stuff your mapping into on-disk
config (either ~/.gitconfig, or if you have a lot of them, perhaps some
file included from there).

It would be nice if you could use "git clone -c" (note "-c" as an option
to "clone", not to "git") to set a permanent per-repo config variable.
But sadly the URL rewriting happens in the submodule repository, not the
parent. So it has to be a per-user setting.


Now, all of that said, do we still need uuids at all? If the canonical
submodule name is https://github.com/git/git.git, then anybody can just
rewrite that locally in the same way using url.*.insteadOf config. And I
think this is a pretty standard way of using submodules. E.g., you might
rewrite https:// into ssh:// if you prefer that protocol. Or point to a
local server if it's faster for you.

Which makes me wonder if I am missing something about the original
request that started this thread. But it sounds to me like it is just
asking for the existing URL-rewriting feature.

-Peff

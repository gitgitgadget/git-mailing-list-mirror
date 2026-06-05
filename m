Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCEF3ACEEB
	for <git@vger.kernel.org>; Fri,  5 Jun 2026 04:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780635297; cv=none; b=WCrT4SpYiSx1RcxqNEanpht4SQLQFqOPh06I59GOV2hPuHHh67sEgdQK7eQmjBdt7oly7nfL1hQ4GnQi1o26sgMQafDaABkYUsxElhshum1COhFanFA0IlQLVsRDrA3QHcGBbrxnOm2jhDmRClm2tX6y1diR8IogjGGlGl7L52E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780635297; c=relaxed/simple;
	bh=vzpHeUWndnH39/o5rcZpC3xCHionS23kNEgIZNsiZnI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=arKqDWBO2n6isHgoSosfCQKuLWkwdufhxna3VQvS7XDm0Kd1XSYLoazEqpokr6mbLpBmm3qCh25LLAC1jjTxowQU6ikhGvyzKwzjFZj04jhzSumVvixoF4EOr4L6N+5pbb3gdckMwGLid10Pdj2OM01uFXJqJtccoshn9g5D8t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=emailplus.org; spf=pass smtp.mailfrom=emailplus.org; dkim=pass (2048-bit key) header.d=emailplus.org header.i=@emailplus.org header.b=QVJc+oPl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cvb9xRWz; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=emailplus.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=emailplus.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=emailplus.org header.i=@emailplus.org header.b="QVJc+oPl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cvb9xRWz"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C281E14000EA;
	Fri,  5 Jun 2026 00:54:54 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 05 Jun 2026 00:54:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emailplus.org;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1780635294; x=
	1780721694; bh=UCkK1m4rujWG9KC6vzNqlJQ+L0aZ05QC5p090QUgK7o=; b=Q
	VJc+oPlZSLvGUYy2oeqHc+fh+zKRyHZgBEsrspD/eify5BSn572LyNK15g26zAry
	jM1HAIuBVEdg1pojpJvwn16NZOrhHqvZTaqAXwIG509RihqjfUSZFI9s69+gIBsk
	KFUXdeHi3BTphhmN2ZCqKCugNzItW33DD1pNVHEbhPvRRRUIlqQbQHQ25UM6KH0B
	hYJ1H4aRaOOACIuPRZD4PFI9IQMqzvG9M1scK9RL4MU2Ca7GtxEIfkJzNv3aS1IY
	TVTCkU1VrXUZmuleIIWlg4iM3+C4DYD0OCY4WkZFMmpZ8uCPdE+Kk3lg692VGbDQ
	KUYAFe/uDKMEulxJ3whGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780635294; x=1780721694; bh=UCkK1m4rujWG9KC6vzNqlJQ+L0aZ05QC5p0
	90QUgK7o=; b=cvb9xRWzoBTXRdpkL76RBrdpMuLuBXURvGFv/+N4hkQpnwXylUd
	Jku2WMHWArnh36bdMoKQhP6JIXhB9kzdhMx9gVEBjgDV0ZEUORoWteJVa2jHIoaE
	PqZgM/gEesJyQr087e0ztkZ/Ws9PXWGw6uxZgFK6OH6nz7e5pZIXc/FC3ds6KDZJ
	IxwFkbW9cCD2W20pZnnJ3021IytOfPCAoG5NXiM5BXNlOygrFrLMpGauwkYBCZSi
	X+XJ5/D5Ksd6HczpdBErfGh/pLK/O5cu7vLNwrxyBtzW0q3xjUCYnR7DwJpwXivi
	NZ2svHOGWcQBCCCMDfezpcw8yfqM5ClKdLQ==
X-ME-Sender: <xms:nlYialTXPFWB5nGCkCb44HXWylUDr7x8YPa_776q9OFJiYKPqOOt7Q>
    <xme:nlYialzn-7Au52DmtJoUwZfN6iDQRAxn0pSCtzTb-Yld_cBjG5LGhnZ19CNZmqmI7
    I98cePD7omU5CJnDAPg-hsHw0LrURe9EnLqLtkO2ye0JSt9EgRJ>
X-ME-Received: <xmr:nlYiav032Cutdrst_GX_PX-NYu81Qyae14M9T5Bjr9aHdq6BQ7ak_ws>
X-ME-Proxy-Cause: dmFkZTFaMTLVE7yJYHEKua2hw3bSO+Jjl5trdoYAyAle3tAzSx7kAeFnZMTcNonHCX4RMy
    Kldt4Vz1s+0J8TxTt1hDykg4ZJPGEXAxzbp/8PNPIZYl0KnClXRn9Rhta6+hlxagrADEF/
    Qk8wJes2AXkgPlduABznI3sRG+eYfkbpfJ4RJNUqF/p3GGjYVEMAkp3d4+HdHNOIMieSKS
    /4xZTrYCCHIVgiRV+I9k7sFDzC1VuPwUG0ZctWlfExTOOFSk/kax35e8w0tgOYS2UMV4wk
    Hqkuil1yeVzEBCdWSRmYfs7b/dv1jjC8EK7ImRnhyYy15+esvQhcZj+6IqyqLagM408tOB
    J635xOapKenLnwh3wAGX0J55uw7c4/uKswShr60w+2uusaKyqeg/r0FvP3yDuQyJKSPE/m
    vouo1mImkoIw0c3hA5A1iAn+8HaX7bQNpGlQX2UTTODeE8/YF4G+iNGUbpuZQOq37rzLH2
    sEalrGYUX9ZC6q3DNWwc9pc+eoj0VMBU/oxkeJjers8GjU+mxfUXlyJkcSkiXntNs3x6BW
    te6iELn1nD+cInvJEIgrYtZjacDLIyIDlBmbBY98V/GaBT/i9VQA7WEJgfU9BCeN7ph50V
    Bt3xQiiPq9HHgL7m1gYIm0gS0oDApTm0rYhylIW73cKJ5EVtQzShHwKcY7rw
X-ME-Proxy: <xmx:nlYiar4yucniryo2KsAmKxkCU5JQRq0xPpoZAcib7XaGOz3N0WozNA>
    <xmx:nlYiaqWE2n-DuS2uB5GpnT9ECA0dj12Jdpw5M7W2XuQAqcc-Zp7Ydw>
    <xmx:nlYiaiAG6W8naJXISe3dhXyVrGtE-yjd8QG3d9uc5EwUds-flw9igg>
    <xmx:nlYiah5vI-_MA7yw_M3ddILL9Ihq3rAWQS3y9tm6-5tb5PROHw6nlQ>
    <xmx:nlYiaqWH-doHO7PLH4rgYSKWfAK3vshslnQWQDmX8RK0ypk0UrNF789p>
Feedback-ID: ic1e8415a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Jun 2026 00:54:52 -0400 (EDT)
From: Benson Muite <benson_muite@emailplus.org>
To: Jeff King <peff@peff.net>, Simon Richter <Simon.Richter@hogyros.de>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org 
Subject: Re: Mirror repositories for submodules
In-Reply-To: <20260604061605.GA3194609@coredump.intra.peff.net>
References: <875x42vlgv.fsf@emailplus.org> <xmqqcxy7qfgk.fsf@gitster.g>
 <d64e7f31-4e00-478c-ab31-b671242865fb@hogyros.de>
 <20260604061605.GA3194609@coredump.intra.peff.net>
Date: Fri, 05 Jun 2026 07:54:50 +0300
Message-ID: <87mrx9r3hh.fsf@emailplus.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Thu, Jun 04, 2026 at 02:11:38PM +0900, Simon Richter wrote:
>
>> Cloning from our server will, depending on what upstream uses, either a
>> relative URL (which will go to our server, but we have little control over
>> what the name part of the repository base URL is going to be), or an
>> absolute URL that instructs clients to pull from another place, which
>> conflicts with our goal to have a self-contained archive.
>> 
>> The idea posited earlier, to have a "repository identity" that remains the
>> same across forks and clones, is somewhat appealing, but the best idea I can
>> come up with is generating some kind of repository UUID, and adding a
>> symlink -- not a great design because it pollutes outside the repo:
>> 
>>     $ mkdir myproject
>>     $ cd myproject
>>     $ git init
>>     $ ls -l ..
>>     lrwxrwxrwx 1 simon simon   9 Jun  4 14:05
>> 12345678-9abc-def0-1234-56789abcdef0.git -> myproject
>>     drwxrwxr-x 2 simon simon  40 Jun  4 14:04 myproject
>> 
>> On the other hand, this can be used to construct a stable relative submodule
>> URL.
>
> Here's a thought experiment. What if you put the UUID into a URL, like:
>
>   repoid://123456789.git
>
> Then your in-repo .gitconfig would point to that repo id and be
> consistent. Of course you need some way to tell Git how to retrieve
> repoid:// URLs. You could do so with a custom remote helper
> (git-remote-repoid), but presumably that helper is eventually going to
> end up going over one of the normal Git protocols.
>
> So we just need to tell Git how to resolve repo id URLs into concrete
> URLs. And indeed, we have url.*.insteadOf to do rewriting already. So
> for example, you can add a submodule but convert it into a uuid like
> this:
>
>   $ git submodule add https://github.com/git/git.git
>   $ git config -f .gitmodules submodule.git.url
>   https://github.com/git/git.git
>   $ git config -f .gitmodules submodule.git.url repoid://123456789.git
>   $ git commit -am 'add submodule with magic repoid'
>
> Now if somebody else comes along and clones it naively, the repo uuid is
> not useful to git by itself:
>
>   $ git clone --recurse-submodules repo
>   Submodule 'git' (repoid://123456789.git) registered for path 'git'
>   Cloning into '/home/peff/tmp/repo/git'...
>   fatal: transport 'repoid' not allowed
>   fatal: clone of 'repoid://123456789.git' into submodule path '/home/peff/tmp/repo/git' failed
>
> But imagine that "somehow" they have learned that 123456789.git can be
> found at some URL. You can do this:
>
>   git -c url.https://github.com/git/git.git.insteadOf=repoid://123456789.git \
>       clone --recurse-submodules repo.git
>
> which would clone from the original URL. Or you could even imagine that
> they have a cache of repositories named by uuid, and then:
>
>   git -c url.https://my/cache/.insteadOf=repoid:// ...
>
> would rewrite all repoid://'s automatically.
>
> The use of "-c" here is mostly for illustration. It is a per-command
> config, so when you later try to update the submodule, you'd run into
> the same problem. Probably you'd want to stuff your mapping into on-disk
> config (either ~/.gitconfig, or if you have a lot of them, perhaps some
> file included from there).
>
> It would be nice if you could use "git clone -c" (note "-c" as an option
> to "clone", not to "git") to set a permanent per-repo config variable.
> But sadly the URL rewriting happens in the submodule repository, not the
> parent. So it has to be a per-user setting.
>
>
> Now, all of that said, do we still need uuids at all? If the canonical
> submodule name is https://github.com/git/git.git, then anybody can just
> rewrite that locally in the same way using url.*.insteadOf config. And I
> think this is a pretty standard way of using submodules. E.g., you might
> rewrite https:// into ssh:// if you prefer that protocol. Or point to a
> local server if it's faster for you.
>
> Which makes me wonder if I am missing something about the original
> request that started this thread. But it sounds to me like it is just
> asking for the existing URL-rewriting feature.
>

The  problem is that one might have multiple repositories, submodules
may themselves have submodules.  Typically a primary development
organization will have its own host, but may also have mirrors on other
services which maybe more convenient for others to use.  A recursive
clone could give upto 20 repositories not all of which are maintained by
the same organization.  URL-rewriting each of them can be inefficient,
especially when the upstream maintains the mirror repositories and can
indicate that in the source repositories.


> -Peff

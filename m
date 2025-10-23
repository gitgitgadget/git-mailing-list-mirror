Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26ED3148BE
	for <git@vger.kernel.org>; Thu, 23 Oct 2025 12:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761223720; cv=none; b=uIK8N94uhyAbc5E9B6b0OdRikIw99Q64p0gGhOZeVWgqGBEn+pIoY5tztFDaNVxGpuh7WE33qgyofXCvgLhkNAkMVhWON2u+ChxcPqffrgMka/FrGmCDxaTbvGVCXS5MCstPAi+sSGwdSWBrmy4jUFuRSn7b4mokBGuu3K778qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761223720; c=relaxed/simple;
	bh=uMR6Wagw58ARpI596ZieMskeF1ZwWA9JXPEC0UMlvnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I5peCDCehpXrH99uj2Z2qWNt5NflgPzoaW+VWfNABeJHmNMBcA5m3R4irCyl7aPUYaKSNCokQtuDl88Iuldi3G8nfChHj+lZSQ0UKg0Aoarzuai8eLzsoBHjTjE0KlZ0fzLvJKmaU0E6bFKA4+YgChqvr/1WCcU5/PV9+3fxYm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=A00a/eAd; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="A00a/eAd"
Received: (qmail 315725 invoked by uid 109); 23 Oct 2025 12:48:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=uMR6Wagw58ARpI596ZieMskeF1ZwWA9JXPEC0UMlvnw=; b=A00a/eAdC9gYt7Cbx1Cx0HJip3nl1FbbHJMX78/9fYEszlTnGnRB7xJr1qD6k3GNXWHIZRHwooXaKA5TXgVcPz5HZYtGek1/3Dps5WwDcKEvk0o93gX8mnoa2h6wttiQpDRAT1+F06BLKdNU4rzYKrKHfGjtgUG0zSDuaza54mDvvYwZrHDnzFeCOmE6FZO73QzPVctmH5e0ioYQ2ojbfU5KtOZhrOZSkuHWdYLoSjvbKJQdug8j37EByQLzY3Dh2byGMxdAtcQG9uCh28kKZ2eRonQUqUWMsbSfMjUy/2QzIyhAU7EoGOXyr6kmVlDr5qI3NMRoHsm6YoKEmpq+jA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 23 Oct 2025 12:48:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 491048 invoked by uid 111); 23 Oct 2025 12:48:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 23 Oct 2025 08:48:37 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 23 Oct 2025 08:48:37 -0400
From: Jeff King <peff@peff.net>
To: rsbecker@nexbridge.com
Cc: "'D. Ben Knoble'" <ben.knoble@gmail.com>, git@vger.kernel.org
Subject: Re: [BUG] Strange git notes completion behaviour
Message-ID: <20251023124837.GB1163932@coredump.intra.peff.net>
References: <012601dc42ce$a1adcb50$e50961f0$@nexbridge.com>
 <CALnO6CD8JU2qMCnC=qQmNOV6Wy1ZnveT3tRxUz1E0LVMj5oU9w@mail.gmail.com>
 <013201dc42d5$07a71550$16f53ff0$@nexbridge.com>
 <20251022092708.GE853931@coredump.intra.peff.net>
 <018701dc435f$f1dc1a00$d5944e00$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <018701dc435f$f1dc1a00$d5944e00$@nexbridge.com>

On Wed, Oct 22, 2025 at 10:27:01AM -0400, rsbecker@nexbridge.com wrote:

> I tried running with --no-pager. No difference. Interesting:
> 
> git show $(git notes list HEAD)
> 
> works correctly with no error report (from inside gdb), while the run of
> 
> git --no-pager notes show HEAD
> 
> still reports:
> Run till exit from #0  main (argc=5, argv=0x811d000)
>     at /home/jenkinsbuild/.jenkins/workspace/Git_Pipeline/common-main.c:8
> Process (0,896) exited with code 037777777764.
> 
> Is there a path where just an implied return is used? I have seen the optimizer
> return whatever is in an x86 register - rsx and rsi are both 12 at git.c:982
> - on occasion.

Not that I know of (and I'd expect the compiler to complain if we ever
had a code path that didn't return).  It is weird that git-show produces
the right exit code, but our execvp() of it does not. In your place I
guess I'd try walking through the debugger all the way down to the exec
system call (and ideally convincing the debugger to keep going in the
exec'd process image).

-Peff

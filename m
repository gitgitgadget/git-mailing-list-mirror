Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5AC190059
	for <git@vger.kernel.org>; Fri, 15 Nov 2024 09:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731663473; cv=none; b=dkXumEh9Zm2aPU0Yx7gnG4Ma1Ggsko6h5GTcX/fnkySs4ypHDiVYBKIkgG6UiLlsBauwb49qkWin4BM5a/w9/KYAuN8prXlB87ro7XYjQ5Rd1i5HL1QQjp3U3J6arydU/VlxMUETpSnAYV87p+nMyz89LDG+3aG/A6HCp2bSkco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731663473; c=relaxed/simple;
	bh=Puppeco/jpwA6axMa5EgCocef4vVJIICecyCuymtkSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aMolQWYy2qMgeV0jeRUwog1iwEmcU/WczlERZzKp37mUx41rhtk+t0vg3Lwd4Vu8JodftLy9YgH7wK8KGGLHDbSEJ8p+ENmQ+9+iS/v3+cT9xmsIQfvevc9KEsxbGQZtRg3BIT1I7L6Z9IyQzjVmnI8P8/pzcYya54FZOBYX5cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=alXRhEdl; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="alXRhEdl"
Received: (qmail 14597 invoked by uid 109); 15 Nov 2024 09:37:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=Puppeco/jpwA6axMa5EgCocef4vVJIICecyCuymtkSM=; b=alXRhEdleRmrpS7EjFScWjQ5wTDBPkdy4FGlbrrFruRxF/lGeBxn0Gha/2JvdY3a4qb7R+oSHQ3hiLsv2MYdhHpou21myqBMJZmJhevPuIXy3BJsQtwNsbE5x/uGTBQyZ3DutSklXn9gVn+6GYDg0zyy+pNgvJS5jCT8GXgduKt6a+NikC0+XjF2lyhXB+tLIr4/JRQy4vriLBW7SiSwcedqQINhBKBTuf/pZHl+Bpqr8NGgTZH3HDNgIrJgUumoHRjrF1alywNFWEBQ5o1upXR/NtvVxb7z/J1T7CdcH1YSOLqnR49TaNUynLC56QGLkQjOO4js9TD1nWfXGAOWkQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 15 Nov 2024 09:37:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6744 invoked by uid 111); 15 Nov 2024 09:37:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 15 Nov 2024 04:37:54 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 15 Nov 2024 04:37:49 -0500
From: Jeff King <peff@peff.net>
To: David Aguilar <davvid@gmail.com>
Cc: Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>,
	Toon Claes <toon@iotcl.com>, git@vger.kernel.org
Subject: Re: Shallow clone of a specific git revision?
Message-ID: <20241115093749.GB1749331@coredump.intra.peff.net>
References: <ZzNJGHMlxGQyFV_c@kitsune.suse.cz>
 <87wmh7ig98.fsf@iotcl.com>
 <ZzR_nOqQxfGNPyYV@kitsune.suse.cz>
 <ZzbVe79p_Zbnb6rs@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZzbVe79p_Zbnb6rs@gmail.com>

On Thu, Nov 14, 2024 at 09:00:43PM -0800, David Aguilar wrote:

> In case it helps, here's a short recipe demonstrating how to do a
> shallow "clone" of a specific commit ID:
> 
>     git init the-repo
>     cd ./the-repo
>     git remote add origin <url>
>     git fetch --depth=1 origin <commit-id>
>     git checkout <commit-id>
> 
> It'd be nice to add this feature to "git clone" for convenience.

Agreed on all parts of this, but wanted to mention one thing here:

> This recipe depends on the server's configuration. You must have one of
> the following configuration variables set "true" server-side in order
> for the server to accept requests for arbitrary commit IDs:
> 
>     uploadpack.allowReachableSHA1InWant
>         Allow upload-pack to accept a fetch request that asks for an
>         object that is reachable from any ref tip. However, note that
>         calculating object reachability is computationally expensive.
>         Defaults to false. Even if this is false, a client may be able
>         to steal objects via the techniques described in the "SECURITY"
>         section of the gitnamespaces(7) man page; it’s best to keep
>         private data in a separate repository.
> 
>     uploadpack.allowAnySHA1InWant
>         Allow upload-pack to accept a fetch request that asks for any
>         object at all. Defaults to false.

In the v2 protocol, the reachability checks are gone (as if allowAny was
set). So if the server speaks v2, your instructions should just work.
Most servers should be new enough to support this (and certainly big
forges like GitHub and GitLab do), though note that for git-over-ssh the
server side might need to configure ssh to allow the correct environment
variables. There's discussion in the GIT_PROTOCOL section of git(1).

-Peff

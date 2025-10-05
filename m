Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD0FC141
	for <git@vger.kernel.org>; Sun,  5 Oct 2025 08:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759652365; cv=none; b=AQGzM208L4ARvnB7I5k13pZhlIoNdFY5GyisUtie7LaxV4llIohUnahHHZ5ROz6xfDLkx/hKISOvbGbVnFi5Px/byqPCFJ/oFH4kftpbTYgINRCcnYx75NVU4Wg6+W4RKMBVwCPeIncB6j5mu0doLx/1+VwWhUbpLKKsgrUNy1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759652365; c=relaxed/simple;
	bh=g6vg3koWWOPiDJk9crSFEx4TchXdcKrlh5dR1Crs0DE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AvrY9Dj5BHG5jdHZs59B6h21lC0bfa0iDCFwO77zSTm8prdQiNRp3/z/xjXoNYY2+T2urB2QBqWFPlOCAF2WT/iszsWsFCXo4pVOqE3gGgLDoKSQXItxpc760rNCXjxAf+pSl8zKw+yTiP98z0zpVwaiXLOES9hYVo2pDnsXxyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nHEoRMUo; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHEoRMUo"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3324fdfd54cso4425647a91.0
        for <git@vger.kernel.org>; Sun, 05 Oct 2025 01:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759652363; x=1760257163; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=II1UjQkxO7ZcIgPVxQpPykhER/4hKM8qdWbsfwNrBFw=;
        b=nHEoRMUoMqPpsvKArk+A2HkYihosttCcg9K1Ks4TilwVgAua3W0XDYA2l3uqFbgJwO
         c3a5zuxxvfxToSlaXc71Cn8iWZcWAdY0XFky0syboCGrlyq810lDyzhiwGoVKYXlQP6Z
         WpPWZ+WD2RvdBMoqegtCnH8mBK6HpKnagJ7EDvPWBFOWRWNtKSS+sWceJPnOSbz78A+6
         8bjn9S1XYbDtoUgEsb9swFwfznsyWGjRgo/3YJbDeKLdDdi/1pwqynAGoZGyf5xg8Jci
         /p24I5ELk+WimN31v1cUBU6RGbdqWdVdjuEayDfwFIWofeJQuMlcbE0fyNKgsRcz7B/s
         hmLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759652363; x=1760257163;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=II1UjQkxO7ZcIgPVxQpPykhER/4hKM8qdWbsfwNrBFw=;
        b=LV6A7d0iO6O04CWLoxaTeW8m972enRhGrX/PB2GsOIaRCp/c+tWxVJSOlJ2L3nAst4
         6tXtsjzy8KJ6iYcgVydT0EQ033fY3DaY0FNBY0nK//UrX33MCU2e37J3oTzRAXJpTukE
         nzeGRghhgvMaPuLZGvoy1uk0P/MMpmxBGzMn3gvLbsIpVfjX+qmRsNLI9UC6RK+Hf0Aq
         EWNfwhQGGHqMDWmkJC1VAn2B1FsxpyzPWLsdzFseJBxoB9ZG6Zb9QLJ8TopTJg42glCd
         AsrXkBcvyh56oDGEMD3nmo5PYIPiREUUyifTrhZoGEe6q2BoBEB66zJCRIXiKyVK6bza
         jKDA==
X-Forwarded-Encrypted: i=1; AJvYcCX88styVSR6V1ZII1KaUkyEQjw4AwsBTytZ9FnYcI66m9C8X0Yq3jmVjopZETHQp6Vtbfo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTVwgt7psFr8bD/+D12TwJmcg6TnrDy056PIRGJoXqugkomY55
	VQJs7FTr44AWbGVaD5dkBSM/KLRNPRPdCTW+aCaO8nf+yerpCwz/um5b
X-Gm-Gg: ASbGncvgn3qhscT9xwrN7+O4+mWBMRwAiWeS5EvQVQGAVduhhuCQ88GP9N9iouvcK3A
	80v7pKlPtR6HNup4QkwVM9TPZuaoUJCj7cwYDwFEXt0siSaVfzyan9RlkIN4NqpCJpjaCoUrtnN
	4kHxLXp0XGAU+/6atsIy2rOz7Wa4ExxeAYJ2K6vvC/lzB8wMoAT1u4TLOXOi/1E0ZBSm+WJc4n8
	sdgGeZrc5e53OUqV6sSqPVIfthMCI9LVJXV0Yft69HOdQXp7gwy+GJkIL/wK4aEdB/p13LFAOBu
	pVFL/fKEfyymx1FDAzF7QfrHw5LqwawVC9UcC6m/6ks16R3qC2+u3Yd7hS/LIF9ZHXgf6fxsjeK
	dNYHy1RCtuOiKOvTG81pkz7XBKkcv8xnKVhS1sqW4SzvW2LA5jLtv
X-Google-Smtp-Source: AGHT+IEAt0j2fLGIAinaMWeApBhovwOnwbd8nK9d4IqsRDou0gNUiV4M0y78d85lgJz0hGjOfOvaZw==
X-Received: by 2002:a17:90b:1a91:b0:332:1edf:a694 with SMTP id 98e67ed59e1d1-339c279e567mr10325695a91.31.1759652362919;
        Sun, 05 Oct 2025 01:19:22 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-339c4a1a19csm6985896a91.7.2025.10.05.01.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Oct 2025 01:19:22 -0700 (PDT)
Date: Sun, 5 Oct 2025 16:19:21 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Han Young <hanyang.tony@bytedance.com>, git@vger.kernel.org,
	Han Young <hanyoung@protonmail.com>, Sigma <git@sigma-star.io>
Subject: Re: [PATCH 1/1] files-backend: check symref name before update
Message-ID: <aOIqCY4vC0Eqiz_M@ArchLinux>
References: <20251001150805.9652-1-hanyang.tony@bytedance.com>
 <20251001150805.9652-2-hanyang.tony@bytedance.com>
 <xmqqv7ky1l70.fsf@gitster.g>
 <CAOLa=ZTnHQbg9ocdA1omqER6CJH-w30G14-F2JAQMtueXENWew@mail.gmail.com>
 <aN5mOTbGBcr355E6@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aN5mOTbGBcr355E6@pks.im>

On Thu, Oct 02, 2025 at 01:47:05PM +0200, Patrick Steinhardt wrote:
> On Thu, Oct 02, 2025 at 02:54:54AM -0700, Karthik Nayak wrote:
> > Junio C Hamano <gitster@pobox.com> writes:
> > 
> > > Han Young <hanyang.tony@bytedance.com> writes:
> > >
> > >> From: Han Young <hanyoung@protonmail.com>
> > >>
> > >> In the ref files backend, the symbolic reference name is not checked
> > >> before an update. This could cause reference and lock files to be created
> > >> outside the refs/ directory. Validate the reference before adding it to
> > >> the ref update transaction.
> > >>
> > >> Reported-by: Sigma <git@sigma-star.io>
> > >> Signed-off-by: Han Young <hanyoung@protonmail.com>
> > >> ---
> > >>  refs/files-backend.c | 10 ++++++++++
> > >>  1 file changed, 10 insertions(+)
> > >>
> > >> diff --git a/refs/files-backend.c b/refs/files-backend.c
> > >> index bc3347d18..d47a8c392 100644
> > >> --- a/refs/files-backend.c
> > >> +++ b/refs/files-backend.c
> > >> @@ -2516,6 +2516,16 @@ static enum ref_transaction_error split_symref_update(struct ref_update *update,
> > >>  	struct ref_update *new_update;
> > >>  	unsigned int new_flags;
> > >>
> > >> +	/*
> > >> +	 * Check the referent is valid before adding it to the transaction.
> > >> +	 */
> > >> +	if (!refname_is_safe(referent)) {
> > >
> > > Shouldn't this new condition share the logic with what is done by
> > > fsck?  IOW, after doing this
> > >
> > >   $ echo ref: refs/../HEAD > .git/HEAD
> > >
> > > "git fsck" or "git refs verify" should barf (if not, we should make
> > > them barf), and this code should use the same logic to notice that
> > > the target of the symbolic ref is bogus.
> > >
> > 
> > Good point. I see that 'git fsck' does complain about this:
> > 
> >   $ git fsck
> >   Checking ref database: 100% (1/1), done.
> >   Checking object directories: 100% (256/256), done.
> >   error: invalid HEAD
> >   dangling commit ccd1771e44a18887197d3ee26ca37c2e892b9fb6
> >   dangling commit f99d68ea2c378218e2360dee4e24115c404f6a66
> > 
> > However 'git refs verify' doesn't...
> > 
> >   $ git refs verify --verbose
> >   Checking references consistency
> >   Checking refs/heads/master
> >   Checking packed-refs file .git/packed-refs
> > 
> > Okay, so this seems like because fsck also parses all references to mark
> > reachability and also parses 'HEAD' via `refs_resolve_ref_unsafe()`
> > which fails.
> > 
> > This symref checks and checking root refs is definitely something we
> > should consider adding to 'git refs verify'.
> 
> Agreed! Overall, the goal is that all logic to verify references should
> be contained in `git refs verify`, so that git-fsck(1) only needs to
> shell out to that command to perform the full check.
> 
> So if this logic isn't yet part of `git refs verify`, we should migrate
> it over.

IIRC, I intentionally didn't implement the code to check the HEAD. HEAD
is so special as its correctness also indicates whether the current
directory is a Git directory. We would check whether the content of HEAD
starts with "refs: ". If not, we would error the user "fatal: not a git
repository".

So, the only check we should do for HEAD is check whether the symref is
valid. When I implemented the code, I think I wrongly forgot to add such
check.

Thanks,
Jialuo

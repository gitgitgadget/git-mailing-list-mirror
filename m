Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C98C1C8604
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 19:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741030441; cv=none; b=qbpCFV+9zBXNgDmIFHZErnl2zTmhLZjuiVeI6rRKbpL/GlPR3e1ZSujvsuke5rURnK9pBEmsokcUpig9Q3yBd6N1fphZSbf/0sSjE8Fp+aZs1ULqiE0eBb/ugPxPMNjJp4zEyNu92dX8urKOTFU7YMV9dDQ+aq3osu19cCZVcxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741030441; c=relaxed/simple;
	bh=+7IiaKIYQ7oOoILzRup9lfj1xphU3c2SODHtc1QZdys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZDGiycCvh4gKewgH/sasHDFL/fmKw3JHwMGlIenE7GxLJfZJ/FcX8NU0DFpp7I+SA8Eyxp20lzyj8WzkkB7Ws58KSGonkZj8mzjuMDdy+fR9/kQJPDi3aXpivrIyBOnhq17UIPMxmXOUqnuAdDiO4gVs+n7nhWABaDP7TmKHviI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i/P69zmQ; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/P69zmQ"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-390eebcc371so1794839f8f.0
        for <git@vger.kernel.org>; Mon, 03 Mar 2025 11:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741030438; x=1741635238; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1+cZKb3KNFRrzGjivP/GL4IigHCfzIvZGULAyTXHOp8=;
        b=i/P69zmQuWUjAv+t2EEhHCghXp5ibRSOQspmelVy3hzc/x5FR4qaa3yrCCQWPE5Syi
         Y/4Ox49YI9WRem9gy6rFStOUyw0EmkIDd940I15LYSQ8iac55RpVgxdEvZ7taFyGgIfu
         XSEOatJe0kZt2Bk3ogpAHVTRQZQvSqJHAiqGlnEsWKFTrPQO6bXcPPflRDF76LWwREe7
         WT4Ez038t03ZR8tFc/Hqv5DpIb6i+YM2iXjGzqGNKoEjqArDKBG+aCXs3pMFTuQgSFUq
         lnq4fUtxaER9/0j91/bT2tNOnLfUE0QtHSas7PAwub7selEzEilsTDubMuJezhnoHzno
         k4uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741030438; x=1741635238;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1+cZKb3KNFRrzGjivP/GL4IigHCfzIvZGULAyTXHOp8=;
        b=bNhGLS1pzqN7vZY/bz8SpY6K8Cmq46BkaH2GNGXPTrj8Rs7/uxyIGmv1XGdvVkpYsc
         pTP49Fz4l7kDVMktT1nC6Y9eWbY01zly1ZC40iQEMhhZHL0Aqy3ApSJl1mBeyI8KDrLB
         PIDjgaJU7e2UijkrtAMl4PNe2WQGX3tC+UcRl57BAOgiulJOGShUUhinL1MZ7KQ8PJGS
         mgeOKYowcD2N1WedCiL/VMGobhK+xgJQ3IhAwyApP+9Y/lrQ47cBa6yTg8LV0YRqsaUe
         e+iyHNQWJ97VtNvIU9lMeimNM+J3gh/4184ns2ab52Kvi0pzdq5lBoikGp9w2J6H+KVF
         nMKQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+c69DkKt0FbFYk6Lyn9uQcONlalrfR0TSk75Yn3Ji8nJEO7rGPHCmRg3Mgc4JwR02eho=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZU8jRKgGvMTnUag46/nkLEiXuNmPvIIRujldNDxuztg/FsWv6
	8gMpZ1RngAnxPCvTK6fHWwyjb+I5eZn77hkW0yE4H+yJBIGi+Nje
X-Gm-Gg: ASbGncuVoVcNU8z3g8vj7L7a2PKXckpBUkSBAhcA+f0w7r1wXIKHmZf3R43Dvkvf/P/
	hmQxtvaHeha+PSG706Dmav7rdacU5zIddNTPGn+crC9Daa8AmySiMgLVnrJ7Q0krdTX4qdLl56U
	DIAeM2IHNOV2HO9/0W783qTzGP5fJ5fYKXA4+MsZsdUd8U2UQ47xJ36L6lv5UzR3+fkHlmXeLXX
	hwWxznEJrZROFyacjXbp2Vp3HYiiqaqH/8m/qQshPSNCAazQ8bRZsEAyNeW3tNyrPR4o9BQMCrH
	Aa2VF5zHweOIWH3+x4HdQKmVJ1WzrNBF0ETZdMtKQfIQGIC04rygVzO/VVuzFIkgO5NnNFxR
X-Google-Smtp-Source: AGHT+IEz/0SnPj3yZXmTKPTj+v6m6W2980qm/0uYTgj0Ta/3zDVQ6OSLdhX+zfVkTb+QgF+1L12Aqw==
X-Received: by 2002:a5d:47c3:0:b0:38f:260f:b319 with SMTP id ffacd0b85a97d-390eca480e4mr14226344f8f.44.1741030438086;
        Mon, 03 Mar 2025 11:33:58 -0800 (PST)
Received: from localhost (94-21-58-229.pool.digikabel.hu. [94.21.58.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba58713bsm206114205e9.34.2025.03.03.11.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 11:33:56 -0800 (PST)
Date: Mon, 3 Mar 2025 20:33:54 +0100
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: David Mandelberg <david@mandelberg.org>
Cc: phillip.wood@dunelm.org.uk,
	David Mandelberg via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] completion: fix bugs with slashes in remote names
Message-ID: <Z8YEIo28bLS+t+20@szeder.dev>
References: <pull.1901.git.git.1740901525.gitgitgadget@gmail.com>
 <95ffa62df6ce394249a8ddabb84fb2b517825fe3.1740901525.git.gitgitgadget@gmail.com>
 <c03192bc-68d3-4645-9bd3-93a338a7496f@gmail.com>
 <2323bb52-f43d-4f40-8955-4c648677a93e@mandelberg.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2323bb52-f43d-4f40-8955-4c648677a93e@mandelberg.org>

On Sun, Mar 02, 2025 at 03:34:07PM -0500, David Mandelberg wrote:
> Op 2025-03-02 om 09:17 schreef Phillip Wood:
> > Hi David
> > 
> > On 02/03/2025 07:45, David Mandelberg via GitGitGadget wrote:
> > > From: David Mandelberg <david@mandelberg.org>
> > > 
> > > Previously, some calls to for-each-ref passed fixed numbers of path
> > > components to strip from refs, assuming that remote names had no slashes
> > > in them. This made completions like:
> > > 
> > > git push github/dseomn :com<Tab>
> > > 
> > > Result in:
> > > 
> > > git push github/dseomn :dseomn/completion-remote-slash
> > > 
> > > With this patch, it instead results in:
> > > 
> > > git push github/dseomn :completion-remote-slash
> > 
> > This sounds like a useful improvement and I like the idea, but I think
> > running "git for-each-ref" once for each remote is not going to scale
> > very well for people who have a lot of remotes. I think it would be
> > better to try and strip "refs/remote/$remote/" outside of "git for-each-
> > ref". I've not tested it but I think something like
> 
> Good point, I hadn't thought of that. Do you have a rough estimate of what
> "a lot of remotes" is? 100ish, maybe?

5.

In Git for Windows fork()-ing subshells and fork()+exec()-ing
processes is rather costly, about an order of magnitude slower than on
Linux.  The rough equivalent of the body of your loop, with two
subshells and a git process:

  time { a=$(echo 1) ; b=$(echo 2) ; git for-each-ref >/dev/null ; }

takes on average 0.17s on a windows box I have access to (with fully
packed refs, and merely 4 refs in total).  So guess at about 4-5
remotes it would take over a second to react to my TABs...

I would rather try to go in the opposite direction to see whether 'git
for-each-ref' could be taught to strip the "refs/remote/$remote/"
prefix with a format specifier option like '%(refname:strip=remote)'.

That would surely be faster than any shell filtering we might come up
with, and would also save us from the trouble of escaping glob and/or
regex metacharacters for shell/sed pattern matching.

> I'd like to do some testing to get
> actual performance numbers before trying to optimize this, because I think
> the optimization has some drawbacks, see below.
> 
> If optimization is needed, another approach is to parallelize the forks:
> 
> {
> 	local fer_pids=
> 	for ...
> 	do
> 		__git for-each-ref ... &
> 		fer_pids="$fer_pids $!"
> 	done
> 	test -z "$fer_pids" || wait $fer_pids
> } | sort | uniq -u
> 
> That might cause spikes in cpu/memory/disk usage that aren't ideal though.

Please don't do this, the completion script must not forkbomb the
system.


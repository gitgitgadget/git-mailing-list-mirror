Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA3016ABC6
	for <git@vger.kernel.org>; Tue, 17 Dec 2024 11:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734435859; cv=none; b=D3WWMzxYSBdxOkvrfGKGh1UKI8QZ+JFTjkaLW8sKkYayWdnQbR5pOOD3O0XWgYqv4L2oOhMW06GQBE7i+tT6DotSA6RunCt6AOWDrGdUSQ004Ellm/c6LFk5zWEeZLLROOZ0b6H0nCmWY1SDs56FnnBDKQAE3wz41TV9RS0Shcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734435859; c=relaxed/simple;
	bh=VwjKgyig6J/9CY9ADQ0M84ib09bkMSLP9nqqxx2OGHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K3QM0oBUO0f49iOemmp//LKfUhCso2oX+YALzJ2xpl1FgjCSV7UOPrMOe5DwtlpXNvHw8e+uMd4rPQXj00MldE0qHb6B4lzSFS0j4yeUMcdRX6X0hQHEiFnymGhu9ECnWg1VULhD3iBA/10DVJZDRHyUe4vdrhjNaRFZGhjgwck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ab6AR7Yj; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ab6AR7Yj"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-728d1a2f180so3855628b3a.1
        for <git@vger.kernel.org>; Tue, 17 Dec 2024 03:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734435856; x=1735040656; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TDFS4ylBXLsyVNQMoihnDcYDmQwq/G3+GvdIUsufw9U=;
        b=Ab6AR7YjmkS47+5ZC6v8f5x9/ET8SElIU8rqZ3b/bsFCsJTqKDiCyt0LwJjffM2WbW
         t3WR0gzb0hkVvMcN+2/umchACH5I4G2wSR6E79sV/1pAglTPE/N2hDPY+7lA8mXLae0k
         unSdRw0wV4RefE1cn+nbAwKWKHkjiG/oYBIJXMMrhK1aHUNPGB+A7WOejdVOCRUMC5qT
         gVMqmW/+FX38l8E4NvhxCOZ3eKkVjvQCAP8b83l8n4A9Tz2+YGHEiWUQynly6TmcRewV
         H3gFUXUp5VXku57ehMFQg3M4KlPrP2idY1CEZbXKzYFOs4tbgMCC/Gbb3DrLO3k/h7E3
         i44w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734435856; x=1735040656;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TDFS4ylBXLsyVNQMoihnDcYDmQwq/G3+GvdIUsufw9U=;
        b=H7DGIsKNAe+pDSeuj1RspjJUrsk3phVl57caKhX4DYjCalgoeoqBNfzlH+VnKGPqfN
         7iJaXAdB0KEgn+R1fb7gqrzCd4J1zEIG8Pg/S9qmCt5NqicEaq7NHKSB3xyR5NJMPs8P
         /yh0yvpKec2vWB8pu3Fui00vVl7+l5QK32u+yi8ra8vcn8OlX8fflfqx8RjpqK8V+O4S
         ZsKUkefkYT9TOSEZsbnpeuShabEsUKEHwGxLtApzkHtw60zOM3s4NetTD9al1BW6D1Bn
         G+THKdgCcvkj3ntW4Xhrcl75oz5HCbhwggHTThTEhzuJBrkC3fbRJ9veRFBL7EoYZos0
         K1CQ==
X-Gm-Message-State: AOJu0Yx6YjzYxpBKZ0f0tiV6/0qBa8Jcb4TmJkVCgSYtUMemLsov7OnQ
	bwrt9sbRlc8rsl1XEqh+rqiyhlrz+reLO3zLjTlGh6KEvbRqZJJm
X-Gm-Gg: ASbGncvq+NRjFxOuwfVX//HBSWC0aJW3IxhYKCJWloahwot04uEwZkIKPY6V1tzb93U
	xob176QqD1bHeFcUv62Oxt9zuZNKwEz0d3OZA4u+3IV4ouA3L+3rCmEnoF6/wIYI/F+CRpLiVB0
	gvndR+aLr0wifFq/KfIkAyaIiyRv65HoJBv8zoWGg7HQlWuwM00W9UAB6ygWwdWlM6/+23EgyBZ
	/UbSx4W0ETZHIQNmqeXORTmPtM930z59+bwevxP6grseuEjPJut
X-Google-Smtp-Source: AGHT+IEtCUd/uueqaxRFGGPT04+5nYkxVWQX6Bcre0SvenxhdqMzen99dWDBXxOzZNsgZSIIybEwrQ==
X-Received: by 2002:a05:6a00:1c87:b0:725:ef94:737a with SMTP id d2e1a72fcca58-72a787ef838mr5112077b3a.12.1734435856074;
        Tue, 17 Dec 2024 03:44:16 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-801d5ae979bsm5626706a12.48.2024.12.17.03.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 03:44:15 -0800 (PST)
Date: Tue, 17 Dec 2024 19:44:56 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Implement consistency check for packed refs
Message-ID: <Z2FkOO9bl-IS_era@ArchLinux>
References: <Z2Ax9dtx4XE5xjgw@ArchLinux>
 <Z2A93X2rxZEnYE76@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2A93X2rxZEnYE76@pks.im>

On Mon, Dec 16, 2024 at 03:49:01PM +0100, Patrick Steinhardt wrote:
> On Mon, Dec 16, 2024 at 09:58:13PM +0800, shejialuo wrote:
> > Hi all,
> > 
> > At current, I have already implemented the consistency check for files
> > backend. My next step is to implement the consistency check for packed
> > refs. And during these days, I have learned the source code of the
> > "refs/packed-backend.c".
> 
> Great. I'm also starting to work into the direction of consistency
> checks for reftables right now, which requires a couple more changes for
> the reftable library to expose reftable blocks. I'll probably get to it
> early in the next release cycle.
> 

I am also happy to see this. We are gradually making things work. It's
good. And maybe we could make a GSoC project "implement consistency check
for reftable backend" if we decide to attend GSoC next year.

> > The current "git-fsck(1)" implicitly checks the packed refs by calling
> > the method `refs/packed-backend.c::packed_refs_lock` which alls
> > `get_snapshot` and `create_snapshot`.
> > 
> > In the `create_snapshot` function, it will check some consistency of the
> > "packed-refs" file, if anything is wrong, the program will die.
> > "git-fsck(1)" relies on this to check the basic format correctness for
> > "packed-refs" file. It's not suitable to just call "packed_refs_lock"
> > in the code, we should not die the program.
> > 
> > Based on above, I have some ideas to implement the functionality. But
> > before I implement the actual code, I want to share my ideas to the
> > mailing list to get some feedback.
> > 
> > There are two ways we could add consistency check for packed refs.
> > 
> > 1. We simply read the raw file "packed-refs" file, check each line. Of
> > course, we should also need to check whether the content is sorted.
> > 2. We may reuse the data structure "struct snapshot" to do this. And we
> > call "packed_refs_lock" without calling the "creating_snapshot" instead,
> > we should just check. The reason why we do this is that we could reuse
> > some functions defined in the "packed-backend.c" instead of repeating
> > some logics. However, this way would be more complicated and require
> > more effort.
> 
> Hm. I cannot really say much on this. The important part is that you
> have enough information at hand to be able to implement those checks. If
> you have all necessary information in both cases I would recommend to go
> with the one that is simpler.
> 
> > However, one thing I am not sure is that should we lock the raw file
> > when checking? From my perspective, we should lock the file because we
> > are checking the consistency of it. If other processes are processing
> > the "packed-refs", we may encounter inconsistency and things would be
> > strange.
> 
> The consistency checks may run for an extended amount of time in repos
> with huge number of refs, and locking for the whole duration may easily
> cause problems.
> 
> Furthermore, "packed-refs" files are written atomically: the client
> writes a new "packed-refs.lock" file, syncs it to disk and then renames
> it into place. This operation doesn't invalidate any file descriptors
> that refer to the old file and you can continue reading from it, so the
> snapshot would remain consistent in itself. It could of course become
> inconsistent with any loose refs, but that's always the case with the
> "files" backend and something we'll have to accept.
> 
> So I don't see any reason why the consistency checks should lock the
> "packed-refs" file.
> 

Thanks, I either don't want to lock the file because this would bring
complexity but without much benefit.

> Patrick

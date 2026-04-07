Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4132C26A1AC
	for <git@vger.kernel.org>; Tue,  7 Apr 2026 22:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775599627; cv=none; b=T0Z5XSNc1YMea9p7iAtGVV/h8I+SxljF6sQq4pnJhG8FEKvaAAS5QdMzMzQLzs8GUxT4/21NxCUgh203PerIkELzHnpFMKvx3mpkDR/Uj+vM8TaZCXm6cGWSlSEllTwBVOImQhNOerx7bp3o5pUahKcT5euE3l8vcQJqurDoen0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775599627; c=relaxed/simple;
	bh=cKSKJ4dAs5WaU0KhrO2t/oRaeWo5wrX5oDRDlifjuCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EHqi07JIJCQ/cT4sWDMnkB6sLqyhmgNiqjTlKznt5z7DG7VGOhJoKw2NSEtaqXuGTHJW5icB1jryk/WfqNVkCVlOPmUPICmEZLUZBtRB8CMYobe2IZHWPlwQ4MtCdn7uUr+p5u0ftAnH/Yej4xzjK4a/hjwcPB3VRqRMlB1e/K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vjp2W6wD; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vjp2W6wD"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488b0046078so26711045e9.1
        for <git@vger.kernel.org>; Tue, 07 Apr 2026 15:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775599624; x=1776204424; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l32wCeW514o8EfMmzJ0BsKIMwbtSlA55ynfEh5XAN64=;
        b=Vjp2W6wDcK3N71ZXjnqoP5w/nL6lA7FpQqxbxC7D7PR613yqqTwVwwi0VUI/6CvcEm
         cAM03sLpJpN4V0Jjv5NlPXoU2lc3NcEr/JHmRqB7bcTDKTvM7VdDxRvqMSc3qoZV54at
         q6gaemkFTUJh6fgPqqsLwkmTqrR43LqWF4x5ycEO8eGJBv15kijNDudB9wZ+PGulSbz+
         4RYXVD55w7PGqI5eTK40DH437gZnxjwweeSF7T2JwJRv5WkFDCNJAGLCmZvW9HcSod/D
         RexbBq+83PcDv+CWCiIl2+NppXO9fDeUs+yvdupjEvMSo3XbBv1aXPpRzHdBk1HENwjS
         Q1vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775599624; x=1776204424;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l32wCeW514o8EfMmzJ0BsKIMwbtSlA55ynfEh5XAN64=;
        b=gAulqmnZ8euL7Pj/NoGDo0JfjeelfhO1X4spUjah+irb4eb/aVq2YhZoJ7NcU5dTfh
         9ow2ep/Fw4PronR/YRrDb08kFkv5URtlU671eRRVZS1IstR5btDB3XlRwcWJoT9KbkWZ
         KR56e2MQqhhxQnzchCiKp4hsnrzWM9ZtactI0QjjY3aGdvxT9HL7FlZ4hdsllnlxSa6J
         8thqjwSnH45zR5kC9NnvzA4CZTHgNUINOEa7kE9Rdn2pn+a0Lk48sNZ3ESTT1i8SxKnJ
         P9AeCeVp5lSu18vbUno7rb1PkXvjEWKAT4hdn9rxHqsJkIYc4LP/WA87dDWjQ8LFDeSE
         NRGw==
X-Gm-Message-State: AOJu0YwlFV2j9YqEzOe876ZvhKq8Gm7gcHaYNhIGRDipT5R7Pq2sg76G
	ESzLaNXH4wUk6FZ6tMdp/qu4Zka7cgfs7eGnx9PMWSey2uZofewG/Fna
X-Gm-Gg: AeBDietcc1G/4ZCWBqvr8N8+CgmT5XOcyWjgq9BDEn+/4kE0xLf9d7/B+Ohj+z5vCvR
	OuNRFAT+wAWOQqfwYjbT9mEEatdjAYBu5miMrdJvyqEfR1RbG40j653CVNv/ZqhDDPdr6J2ni2R
	TnVCRmoQY5KzdBebmFVONpFncrQWXE/4X1h0RVsZmXOBAm9nXRE7N3EDwcigxacTVwDEXCRzU8P
	fYj0KBiJZtaLQR9SOUlZ1RgobT8KPGSSzX/dg37CO6Uv7kSjRP+GioX6skqNP3MXBAaYAwDEULC
	pPqEJUPCHJNbfP0bO/Kh0tbnEVnDRcKjvIxitQdZfn2tNUy+3e5j3p+FzYC0mvuRPdVP6igI3A+
	ZT5eW4GlWwUOmNYkrsL+gmcf5r/Mmy+NK7YfCfqoKokpeAWDKsixM2bU4j7QybwT0iWYOYX0BHd
	ADtpVdnxyAr68vvPZysNN0TDwRdN3RWvth
X-Received: by 2002:a05:600c:358b:b0:485:4135:5c92 with SMTP id 5b1f17b1804b1-488995cb858mr315689145e9.0.1775599624409;
        Tue, 07 Apr 2026 15:07:04 -0700 (PDT)
Received: from lorenzo-VM ([84.33.160.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488a3d6944bsm308766575e9.11.2026.04.07.15.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 15:07:03 -0700 (PDT)
Date: Wed, 8 Apr 2026 00:07:02 +0200
From: Lorenzo Pegorari <lorenzo.pegorari2002@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>,
	Elijah Newren <newren@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [GSoC PATCH v3 2/5] pack-write: add helper to fill promisor file
 after repack
Message-ID: <adWABoOqHNkTTTyR@lorenzo-VM>
References: <cover.1774205661.git.lorenzo.pegorari2002@gmail.com>
 <cover.1775431990.git.lorenzo.pegorari2002@gmail.com>
 <3cd15429194c763727fbfd5981ba38c1dc2cc907.1775431990.git.lorenzo.pegorari2002@gmail.com>
 <xmqq8qazai3b.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8qazai3b.fsf@gitster.g>

On Mon, Apr 06, 2026 at 02:34:32PM -0700, Junio C Hamano wrote:
> LorenzoPegorari <lorenzo.pegorari2002@gmail.com> writes:
> 
> > A ".promisor" file may contain ref names (and their associated hashes)
> > that were fetched at the time the corresponding packfile was downloaded.
> > This information is used for debugging reasons. This information is
> > stored as lines structured like this: "<oid> <ref>".
> >
> > Create a `copy_promisor_content()` helper function that allows this
> > debugging info to not be lost after a `repack`, by coping it inside a new
> > ".promisor" file.
> 
> "coping" -> "copying"

Ack.

> > The function logic is the following:
> >  * Take all ".promisor" files contained inside the given `repo`.
> >  * Ignore those whose name is contained inside the given `strset
> >    not_repacked_names`, which basically acts as a "promisor ignorelist"
> >    (intended to be used for packfiles that have not been repacked).
> >  * Read each line of the remaining ".promisor" files, which can be:
> >     * "<oid> <ref>" if the ".promisor" file was never repacked. If so,
> >       add the time at which the ".promisor" file was last modified <time>
> >       to the line to create the string: "<oid> <ref> <time>".
> >     * "<oid> <ref> <time>" if the ".promisor" file was repacked. If so,
> >       don't modify it.
> >  * Ignore the line if its <oid> is not present inside the
> >    "<packtmp>-<dest_hex>.idx" file.
> >  * If the destination file "<packtmp>-<dest_hex>.promisor" does not
> >    already contain the line, append it to the file.
> >
> > The function assumes that the contents of all ".promisor" files are
> > correctly formed.
> >
> > The time of last data modification is used in place of the time of file
> > creation, because the former is much easier to obtain than the latter
> > one.
> 
> The time of file creation is not recorded anywhere if you are
> dealing with the usual UNIX filesystems (ctime is not creation
> time), so it is not the issue of "easier to obtain".

That's what I found out during my researches, but I wasn't sure. Thanks
for confirming it.

> The reason why this design chooses to add time is because in a
> never-repacked .promisor file, the modification time of the file
> itself can be used when you compare the entries in it with entries
> in another .promisor file that did get repacked.  By having
> timestamp, the debugger can tell at which time the refs at the
> remote repository pointed at what object---the same ref may appear
> twice in the same .promisor file and having timestamps would help
> understanding what happened over time.

Exactly. I'll improve the commit message to better explain the utility
of these timestamps.

Thanks,
Lorenzo


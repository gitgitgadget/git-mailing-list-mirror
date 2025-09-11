Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91867299944
	for <git@vger.kernel.org>; Thu, 11 Sep 2025 23:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757633167; cv=none; b=CCEG9erQEh3pQfvQMCnVHARCslXCmB0ituU889GW4YUqcMG+z1cPXfNYX9OhYoWc8DD2g0vJaosX5Zqp3xxl60rjveb7y6jiy2cfOh3+N2tTP3c9pX79uAA3HDZLirgik5V3KdIS8TFMjAwOTaRti7fJw6XY1ODFEFjBg3xWLVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757633167; c=relaxed/simple;
	bh=TBsqlfqXLlFDbTuBTFLRGvTeXc05/xfF3dbF8RBHd64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OnCcMOWFOyf/pTOmUZqwLfoL9re2N3KE20660thnOXBPLao9mXAE+4/7/A/d85qoHN+qC2QSfTN0V87Urg2kiEmaQ1iKzCnFP+ajjVqhKuNkXuNcTLjp1OWFWDbP2FBdHqF0jum8DA7WjTCV2EfLi9NWdLgARPOlzbtZSO4KLXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=DXQb7Uto; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="DXQb7Uto"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e96eb999262so811369276.2
        for <git@vger.kernel.org>; Thu, 11 Sep 2025 16:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1757633163; x=1758237963; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pPHkIm/ROuylfYvKqJdz1GTNfU9ncINyOhwB2SNRVeA=;
        b=DXQb7Uto7q9l5sMO7kSPiJCTZXQ2CVmRZAGMEzsgn6XDBakSjc4iSY46vciDwgDCgB
         5LuvsLoOcPLIF2CxxMRCADXXeMp8QWb7Trbn3OgfVH5MTTJWOdHGV7bPaS6aOILgzHZz
         4uYQjJUbpB2VW+QETeqr0QMzfhDusnrTgS6AYoV8BDTphxWJIkIOK+6d7i/V8UP6IJ11
         lyyM1/OAEP8z0nd8ODtS9aC5EQe/rtzt3t8FYLzcIAuQUmCndFgc7m/SO/kUQ2W1e4Zm
         A/+iy6f9QiE90Yc4gjgGxtpqF5ndzHfRyM+O4YGe+sDhYPjOSHlIExV5bjfHd+OicBWn
         kFfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757633163; x=1758237963;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pPHkIm/ROuylfYvKqJdz1GTNfU9ncINyOhwB2SNRVeA=;
        b=qrWYCS/cEADDP9irZWDLiZy+tgxqRtbkX9mQtEwo64bY0ldkag1DFQJ5gtDBZW2sGe
         CwC1L7csITjhQs4VFvJjnbZXMwHxpCzEZcPyiNrFxcrXYGZu27QkVNDeqot7nLIKHFEA
         EEF1/nB2JuKjncVkvAJyrwvmTMHUKVP94h9kyNYVsY6Z1b9JJU8DkYJZWyZiLBSsai2H
         hab1CjxvjUF1mP1aLwFnV72pCi1L2Qv6CvFxxreOKG9kU7xrrK1CZw2TTmL7AxJVa1Xa
         RYbhXSFX524Fx7zSLn0r/cLa+av5Zcn1vBM8qCvu7ZCfwZLMvii/46h6o26YZrFOdzbx
         N5zA==
X-Gm-Message-State: AOJu0YyOJB8A7kOKUJiC4ZmvyeTnh+AmgL8tci4OHmGrsGu6L2g/UCso
	7MlcH/qBomhw059dc3LnLmhjvpVbPZPzo1ScwMUsaqAYegmFmjbHIxRqRIwe7Q3xrV4=
X-Gm-Gg: ASbGncu2pOnTLmuD8hiMQ1Xkz21GSvwAW3BviWBsvu0/KWwY5ptJAvWpLx7J5tYl15/
	UWpEOgEh5Yrp+u1+q7wWjc29Y8ZrbH4zUOLJWCP+x1BncO2A7QaQ6FjVES7LvEFETH97u62FoIe
	rM1dIW8d53Fw6SVyHXK6SC103vi6s4EgNbfVjqkGiEVElh0m8HiLJJMz553NpRUcry8waMTltXH
	qJTQYLOhlSy9GABK5prPTpbynstGyeAaTfTJNImnML/zDKbr2ZUv9aos0tvEv6su1dmEm+A5q3m
	FGzxBLHp+rc1dBoDVjINzpHcq/gm/A1QgSkc0+q00Do0mcrJDwil4Svn84pL7xoGL79ligw9vSO
	LgHPsWT6Qthi78SjugnUXCtJItZKbKQYBYtjYI6gusGnIMzi5rdpSrXhYVgo9GJMz683lJ5B2X+
	0K9oyLLPeHNCOnyT78HfL8knJqV8SOyebbUhGaqduoirHFRbA=
X-Google-Smtp-Source: AGHT+IEu3p2/AxgYaVUj4njF944wD5LsmnYkuL3vxy202s85AfCa7p7NEiIdKHYdDZCi1l1TjnkThw==
X-Received: by 2002:a05:690c:9c0c:b0:71c:1a46:48d5 with SMTP id 00721157ae682-73063480b69mr11457967b3.21.1757633162024;
        Thu, 11 Sep 2025 16:26:02 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-72f769302acsm7082067b3.29.2025.09.11.16.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 16:26:01 -0700 (PDT)
Date: Thu, 11 Sep 2025 19:25:59 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 14/16] packfile: remove `get_packed_git()`
Message-ID: <aMNahx/RBoRljSZd@nand.local>
References: <20250821-b4-pks-packfiles-store-v2-0-d10623355e9f@pks.im>
 <20250821-b4-pks-packfiles-store-v2-14-d10623355e9f@pks.im>
 <aK5hpwcCgjkgQB1N@nand.local>
 <aLav7vdfxPGTVDQd@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aLav7vdfxPGTVDQd@pks.im>

On Tue, Sep 02, 2025 at 10:50:54AM +0200, Patrick Steinhardt wrote:
> On Tue, Aug 26, 2025 at 09:38:47PM -0400, Taylor Blau wrote:
> > On Thu, Aug 21, 2025 at 09:39:12AM +0200, Patrick Steinhardt wrote:
> > > We have two different functions to retrieve packfiles for a packfile
> > > store:
> > >
> > >   - `get_packed_git()` returns the list of packfiles after having called
> > >     `prepare_packed_git()`.
> > >
> > >   - `get_all_packs()` calls `prepare_packed_git()`, as well, but also
> > >     calls `prepare_midx_pack()` for each pack.
> >
> > Yeah, having two of these functions that are named so similarly as to
> > suggest they do the same thing (even though they don't) is unfortunate,
> > and I am glad that we are looking at it here.
> >
> > > This means that the latter function also properly loads the info of
> > > whether or not a packfile is part of a multi-pack index. Preparing this
> > > extra information also shouldn't be significantly more expensive:
> >
> > Right; get_packed_git() only loads the non-MIDX'd packs, and
> > get_all_packs() loads everything (regardless whether or not a pack is
> > part of the MIDX or not).
>
> I initially understood the distinction of these functions to be exactly
> this. But after looking further I don't think this is the actual
> distinction: both functions end up loading all packfiles in the repo,
> with the only distinction being that `get_all_packs()` also prepares the
> MIDX for each MIDX'd packfile.

Calling both get_packed_git() and get_all_packs() both result in:

 - prepare_packed_git(), which calls
 - prepare_packed_git_one(), which calls
 - for_each_file_in_pack_dir(), which calls (via callback)
 - prepare_pack

prepare_pack() only calls add_packed_git() and install_packed_git() if
the file it's look at ends in "*.idx", *and* there is either no MIDX, or
(if there is one) the packfile is not listed in the MIDX.

get_all_packs(), on the other hand, *does* call prepare_midx_pack() on
all MIDXs across all ODB sources, after having called
prepare_packed_git(). And prepare_midx_pack() will add MIDX'd packs to
the global list of packs, which is what differentiates these two calls.

I think this gets a little funky in practice if you have already called
prepare_midx_pack() on one or more MIDX'd packfiles before calling
get_packed_git(), because of the side effect of prepare_midx_pack()
installing packs into the global list.

So the above behavior isn't guaranteed, but there definitely is a
difference between those two functions depending on whether or not some
other site has called prepare_midx_pack().

> > So I think that want_object_in_pack_mtime() may need a small tweak, and
> > I am not 100% certain that cmd_grep() is OK to convert.
>
> I initially misunderstood the distinction between these two functions
> the same as you did, and had a similar list to the above in the initial
> commit message. But with the adjusted understanding of the actual
> difference between these functions I think it shouldn't be necessary
> anymore to go through each caller one by one.

From the above, I am not sure that this is true.

Thanks,
Taylor

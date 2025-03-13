Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA15745948
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 21:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741900050; cv=none; b=kXupH5IbQKGGDVV/LkGufDGtYv0qniqoqrCvKWAInt8lKIoj1z2m3O9/tCP+6HA0+iDotmIHzgl4cxZ0Y1AnFKAlaGS+9zQfpZYhWnBoqty065rFoe8JyIT4izyo0z2DHgRQaGJlNYEGuZZjT/e2zSjNDYkgmjj0P6jPYz1G3GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741900050; c=relaxed/simple;
	bh=WZg8yIyYKmk8XcRbb5pyHMPKHzWsq/rUsxERRUkkKC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LSWohq4NkZLcik3cbNsSmvCrcrY5izKTh+ao3k8S/q8hugB5JdTApkXfYWJukejXlhHv+jDdatULjUZ3v2NMOxGly2xCZvS3Cr1Qe/VaiVvCtJscjtLqNz9A78conpxIJgkGl5mCrcFppqDRjg8Fy/K4Tuz0Q9dtiG4JDD230LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rgnUpWgC; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rgnUpWgC"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-224341bbc1dso30505835ad.3
        for <git@vger.kernel.org>; Thu, 13 Mar 2025 14:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741900048; x=1742504848; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PEEQkUYiC5h6hc0BKPiyfiOpb+3ohO8LBdvXH+Hk9rI=;
        b=rgnUpWgCMF/MmMkw7J5ZyHKbTyWx18zmjRaUuocIhP+uI/25z5rACqxsMmsMls9a7p
         1lWVP6qy4TCByg7EodKyEOVjXH0hkDMr0H6PAHhGy8EbJpWTabHMo1BKwEGisHtZ9No6
         ZtCKIfg4OiexkrnLIkFgZp0u5h8mZ6JeQ6Szn2LtcCMDzbnJZgLgxP3o3rBFTlyibiEK
         p2RkHOHOZQmoammaLOzBflGQwrlomsvQEtXQp8TXfWpyXC9Fupnn+79VxABDLEI3uMdr
         DT6QPkW8IN/6mn2l/nBs0f+9hdsmkSd/SGMZjEu9QRJs3L/NnjoWYtEEdrmHljzg18jr
         bmWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741900048; x=1742504848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PEEQkUYiC5h6hc0BKPiyfiOpb+3ohO8LBdvXH+Hk9rI=;
        b=ewcdpYRw1sx/Ye/rR/q20fEuAC7eifgYyuCWIQZKJVqrGzYJke1KWReG2ZxCfV6QTC
         KHhxfbv3gVPIhcu8NgAbz4WMIir7DKVWZ6PheuzD1VH7tCRnVN+RN/Pbng/YGVf4u5Ls
         jSVidscEKzpT3pU/7YHMgPM8DWnpzie3YSZ9gs40IaQB/kwfHX8XiOHLbbl2+ouSx0mD
         VSqvUWBzvy4VuaTBZmPJxxiR5hasD0h0IkzenQVqiC56LrpuktDgpphfKWJbvadCzaIb
         wqsrDMFVYIO8OyWwoTBGldz2T08ctqjaUxjkxeBCUK+SZlQhPgePS+rHV87i/FeL5UPw
         /yAw==
X-Forwarded-Encrypted: i=1; AJvYcCUBmXR5P2ieeBXp5pVhNV6MW9+4+6xC3akUyZastUuDADygSQg0nzlwrcArkn5Xj9mnm+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YydTDyH1kRl3thCpYUCLXkK+w91qy9ZOb6XSrf1IrPHLH2Kl01d
	l5z0waFCa5uoeQFm2BrObirSDZWTKmQ4qhX0LR79V+6qsoe7H0TakqFg3yqCBaZ7VFg4IYVv4CQ
	NLdnr247jNeWBRaxv3pTPe3v2qdTZIsPIWlEu6FBbZAv7biKA0Q==
X-Gm-Gg: ASbGncvE9kmqCT3Da7IFAQPmQ7jlesuEyFqLKTNDnkK6Hw4uYeYaIjpnOAQaKFwhPjk
	6r3N3GabuGi88Zoj6KIw2QsVkVfPv377NapOtUAn57nafdwwryx7tNpPNonzh2Lawz//+4i18HB
	fnWPfCAmtIcm7UvTB3RSdHSF3UAuXTjmacUAyNVkCETyNG+ciwSHPUraFEFg==
X-Google-Smtp-Source: AGHT+IG/JY9fA8pxiBqUGoEUqT7hmRGHUosN6ZhJWsJboplXBMHv13ufwoQ5prUCPMmMOaqGPQ2/hBptSwm6Rqh2mms=
X-Received: by 2002:a05:6a00:a16:b0:736:53ce:a32c with SMTP id
 d2e1a72fcca58-736eb87c234mr15775447b3a.17.1741900047734; Thu, 13 Mar 2025
 14:07:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <871pv2jx4a.fsf@josefsson.org> <20250313051538.GA94015@coredump.intra.peff.net>
 <87msdo1yal.fsf@josefsson.org>
In-Reply-To: <87msdo1yal.fsf@josefsson.org>
From: Kyle Lippincott <spectral@google.com>
Date: Thu, 13 Mar 2025 14:07:16 -0700
X-Gm-Features: AQ5f1JrH6GultiRHGvBLaiGRpKFaR_wlq7ERZ9JFOF7Kdp8jBlSSF_T0VrvXo2I
Message-ID: <CAO_smVgSRaYqNrA4c1yeu-cpj+P36MY+bsQT=8K0SXpWHkaWCQ@mail.gmail.com>
Subject: Re: Making bit-by-bit reproducible Git Bundles?
To: Simon Josefsson <simon@josefsson.org>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 1:18=E2=80=AFPM Simon Josefsson <simon@josefsson.or=
g> wrote:
>
> Jeff King <peff@peff.net> writes:
>
> >   [now without threading]
> >   $ git -c pack.threads=3D1 bundle create --no-progress - HEAD | sha1su=
m
> >   c897caf9c68d2c37d997d3973196886af3b0b46e  -
> >
> >   [and we can do it again. yay!]
> >   $ git -c pack.threads=3D1 bundle create --no-progress - HEAD | sha1su=
m
> >   c897caf9c68d2c37d997d3973196886af3b0b46e  -
>
> That's the commands I use -- it doesn't lead to the same hash in two
> different 'git clone's.  I tried running 'git clone' with the same '-c
> pack.threads=3D1' but it made no difference.
>
> >   2. There is no way to pass pack-objects options down through
> >      git-bundle. So you'd have to either assemble the bundle yourself,
> >      or perhaps generate a stable on-disk pack state, and then generate
> >      the bundle. Perhaps something like:
> >
> >        # make one single pack, with no reuse, using the default options
> >        git -c pack.threads=3D1 repack -adf
>
> Yay!  You may have solved this for me.  I have to verify this a bit
> more, but this looks promising (these are two different git clones):
>
> jas@kaka:~/t/gnulib-1$ git -c pack.threads=3D1 repack -adf
> jas@kaka:~/t/gnulib-1$ git -c 'pack.threads=3D1' bundle create gnulib.bun=
dle --all
> jas@kaka:~/t/gnulib-1$ sha256sum gnulib.bundle
> c780bb07501cf016e702fbe3f52704b4f64edd6882c13c9be0f3f114c894e890  gnulib.=
bundle
> jas@kaka:~/t/gnulib-1$ cd ../gnulib-2
> jas@kaka:~/t/gnulib-2$ git -c pack.threads=3D1 repack -adf
> jas@kaka:~/t/gnulib-2$ git -c 'pack.threads=3D1' bundle create gnulib.bun=
dle --all
> jas@kaka:~/t/gnulib-2$ sha256sum gnulib.bundle
> c780bb07501cf016e702fbe3f52704b4f64edd6882c13c9be0f3f114c894e890  gnulib.=
bundle
> jas@kaka:~/t/gnulib-2$
>
> > So I think it's possible, but I doubt it's very ergonomic. You're
> > probably better off using some checksum over Git's logical model, rathe=
r
> > than the stored bytes. The obvious one is that a single Git commit hash
> > unambiguously represents the whole tree and all of history leading up t=
o
> > it, because of the chains of hashes.
> >
> > But that implies you trust Git's object hash algorithm.
>
> Right -- I think anything but bit-by-bit identical files is going to be
> too complex to verify.

I'm curious what specific attacks you're trying to catch here. Because
to get into a situation where you unbundle the bundle and have the
same commit hash but different contents, you would need to have a
collision in the SHA-1 hash for some object (or SHA-256 hash if the
repo is using that). If you're also providing the instructions (or
even just the commit hash and server to clone from, and linking to
instructions maintained elsewhere) to validate the bundle is
legitimate, it seems MUCH easier to just replace those validation
instructions to point to a commit/server that has already been
backdoored than it would be to generate a SHA-1 collision that would
go undetected.

>
> >   # print all commits in topological order, with ties broken by
> >   # committer date, which should be stable. And then follow up with the
> >   # trees and blobs for each.
> >   git rev-list --topo-order --objects HEAD >objects
> >
> >   # now print the contents of each object (preceded by its name, type,
> >   # and length, so there's no chance of weird prepending or appending
> >   # attacks). We cut off the path information from rev-list here, since
> >   # the ordered set of objects is all we care about.
> >   cut -d' ' -f1 objects |
> >   git cat-file --batch >content
> >
> >   # and then take a hash over that content; this will be unambiguous.
> >   sha256sum <content
>
> How to read this output?  Could this be made git bundle compatible?
>
> But if the above is solves it, this part isn't necessary.
>
> /Simon

Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B714B4CB5B
	for <git@vger.kernel.org>; Sun,  1 Dec 2024 22:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733091890; cv=none; b=VEfJFEJDJ+IEzI4mJqMtKZQ7kDolCpHElsh+fCxPZF4WjrZxd+92lczumBTlrNxE5XU2NWmch9Qu94BXoaXCYgdn5SBlV5zUsl5FG9tZFUGOzyoKZ0fOK/GUQtmlNmspDNHbren00mHIS+ezCGoHwNf/RiHWSgYw/fh444nkfsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733091890; c=relaxed/simple;
	bh=5Qt+bORMpuzEqZ7izJG7LfhQuKvUwr8UrlzisQHZMqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZqYJyinMeA4gCDxWLctYecd8kYvIfppcaDNfe3EfkFyWRcgZNCiDzBHLBrAE0N1sliCFDYtIawCxLumIDH9PxR9jZAUpDrkp3mYHNZZifuvMNJ6b9WSXlF/2QPtZVvVvUPbkszxd4oHuiBGuonhrLRTzqa01+2gXjYChHMM/McU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YYysu0Zi; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYysu0Zi"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53dde5262fdso3905600e87.2
        for <git@vger.kernel.org>; Sun, 01 Dec 2024 14:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733091887; x=1733696687; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kiRKirPNhv/KUQvlBFg05YAJVg3tqc3mWuZ6Y3p0q2o=;
        b=YYysu0ZiDkzGK2LMIjxGQssaqnUXjLtfUfN3SjNbzfQifue9z4fiWALY7PlRxreFeG
         5qFCmfaMwOI0BIVmi0p7jGaNAuc6DSCpkeDrmrZ7TAQI9EmtqVjUerfjJ/AgMbSTfM84
         aVOHOI3ANIt3+P0lFt1uL9FodnPbB/jcS/+igftAV2plp5AJo69ys4k6q3HYMxAW+Ny1
         ADtnYck/0vqAapdIs7avm4U7bNCOsporCyuP1nyq/mYm8Us7rQtTtIDDhForZbSRt40Q
         6fSaIz7mJUqGNKnLLH3oK7yc2bhuAXtQbHBhDQwyYmyffPCVtaQ9A4KBCmt0W73Gtnmv
         yF1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733091887; x=1733696687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kiRKirPNhv/KUQvlBFg05YAJVg3tqc3mWuZ6Y3p0q2o=;
        b=iwgX6yGldSJ+kE3gH1eDwjUL5vskhzWkXi2GQA4ACyC/BDFaPTsjYj5/sTHLsJsWxN
         /n4O4wsUTz3Rf0XnjwolaiKK42fgYCKY7sOxMid2VRJMXdIikpQfb/y/gOrmqhFLf1SH
         25XSCEamfaaGaAIqevfXFLYNpbhwxGYrpmtt79qjgfQ1bxpcmcydXAsvt/pCO5mbNNkp
         sPsmac6M5OVo3XQrfj7g+yQUGbjXTAzOCC2TRHyPovXWOw5whku3U776HEo7dg7kCUtK
         Si478X9luR0QeBsAr/ccJGsOCWmOmTNoYLLnZYuj+20jP1HwAAWY9hvN/c7ehm3RHr6w
         /z8w==
X-Gm-Message-State: AOJu0YxuAPBHO1+d8EAijloBlmGGy6a8NuyyixFQ5yPvRwF56HzHO8KC
	t5ar7fWaicz+X0nOFtESrwB84dX9iisUQTE4CmqFB+g6RltYilyUK0vOtKPAssWmfHnYQp+xDQ4
	e12C3xLdiCnqVz3rEmqFntcKEKhBTagRI
X-Gm-Gg: ASbGncu3hQdY2yL73K+4UeIrYBq9L28UuNdYLiytbVnkMMQ1Olaa8YLHWwWzx5cpAPi
	GFhQr5MMz5P4Lwpw3mJWWpOQn78iD8Xo=
X-Google-Smtp-Source: AGHT+IH76JCREMwSDsVWsrJFxDopZ7BKUz8jf619x72Guca4SYHuVIrnu/v/cQWeJvxGuXIiEA7X/YjhmcBkHoHtTjg=
X-Received: by 2002:a2e:be9b:0:b0:2ff:c83b:4dac with SMTP id
 38308e7fff4ca-2ffd60e173cmr97791011fa.29.1733091886475; Sun, 01 Dec 2024
 14:24:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJ-DG_DpNVmn1e=8hBX4YbEhzgX4xxn7AVBQnhKJOvHX4hx7kA@mail.gmail.com>
 <20241130163801.GA110697@coredump.intra.peff.net> <CAJ-DG_CNPGgfafyTcKWYeNXHD4gsspWakzQoRhfggMqZjenkyg@mail.gmail.com>
 <20241201213636.GB145938@coredump.intra.peff.net>
In-Reply-To: <20241201213636.GB145938@coredump.intra.peff.net>
From: Dmitriy Panteleyev <dpantel@gmail.com>
Date: Sun, 1 Dec 2024 15:24:35 -0700
Message-ID: <CAJ-DG_A3RY0ngY-pc6riho=OyzX2VjeaR2LRGb5=ru3CNruECA@mail.gmail.com>
Subject: Re: [BUG] commit fails with 'bus error' when working directory is on
 an NFS share
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 1, 2024 at 2:36=E2=80=AFPM Jeff King <peff@peff.net> wrote:
>
> On Sun, Dec 01, 2024 at 10:17:44AM -0700, Dmitriy Panteleyev wrote:
>
> > > > I attempted to upgrade git to v2.47.1, with the same result.
> > > >
> > > > I then downgraded git to v2.34.1 (the version for the previous
> > > > distribution release) and the error has resolved.
> > >
> > > Can you try bisecting between v2.34.1 and v2.43.0 to see which commit
> > > introduces the problem for you?
> > >
> > > -Peff
> >
> > Bisecting: 0 revisions left to test after this (roughly 0 steps)
> > [04fb96219abc0cbe46ba084997dc9066de3ac889] parse_object(): drop extra
> > "has" check before checking object type
>
> That seems like an unlikely commit to introduce the problem you're
> seeing. And how did we end up with 0 revisions left to check, but no
> final outcome? Did you need to do one more test and "git bisect
> good/bad" on this commit?
>

You are right, Jeff, I needed to run one more bisect. But it does point to
the commit I linked above. The bisect result is:

04fb96219abc0cbe46ba084997dc9066de3ac889 is the first bad commit
commit 04fb96219abc0cbe46ba084997dc9066de3ac889
Author: Jeff King <peff@peff.net>
Date:   Thu Nov 17 17:37:58 2022 -0500

    parse_object(): drop extra "has" check before checking object type

    When parsing an object of unknown type, we check to see if it's a blob,
    so we can use our streaming code path. This uses oid_object_info() to
    check the type, but before doing so we call repo_has_object_file(). Thi=
s
    latter is pointless, as oid_object_info() will already fail if the
    object is missing. Checking it ahead of time just complicates the code
    and is a waste of resources (albeit small).

    Let's drop the redundant check.

    Signed-off-by: Jeff King <peff@peff.net>
    Signed-off-by: Taylor Blau <me@ttaylorr.com>

 object.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

> Or alternatively, can you share what you're doing to test the bisection?
> That might help us reproduce. I kind of wonder if the results might not
> be deterministic, to end up at an apparently unrelated commit like that.
>
> -Peff

I am not at all familiar with the standard process for this, but the way I =
ran
the test is:

(0. cloned test project into /nfs/proj/ and made a change)
1. cloned git repo (from github) into /tmp/git/
2. ran bisect in /tmp/git/, starting with v2.34.1 (good) and v2.43.1 (bad)
3. ran `make all` in /tmp/git/
4. in /nfs/proj/ ran `/tmp/git/bin-wrappers/git commit -m 'test'`
5. repeated 2-4

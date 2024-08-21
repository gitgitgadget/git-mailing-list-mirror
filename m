Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC0416DEA3
	for <git@vger.kernel.org>; Wed, 21 Aug 2024 19:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724267363; cv=none; b=eZEke7SitY9qmnSMAkpU49xo3SrWMzJpGurF1hr2ej2Bk15lEGZoJ7o9Dh97WCaXILf2CCj/jPJ9MlyTBugiqUk9+lLbr4lu1ns/cgZxuIZ8086jBbjboGaYlB+zofgoJuJseLMX/EIE61xdlz2MNHFmTBmmd7ADT0rmiOuGqco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724267363; c=relaxed/simple;
	bh=6zD+CuBrWUGKGwJnu7QEy02DVFdo8HtgK2Qao8Jo7M8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=KgkImK7VK6ON+4N/VmfkbRAMUEQsS6gm14GNpswcfX1GtYp++pCmTBWdvYNsgpPcv1xWWMZeYfgE6HlQMw0kGtvCy8AK7d/DHTEtnMHJAlssmegtACOSflTaYFhdvbS9JOsQsuH2MUVlyC9TRD8BP9Y8E5949IsbIehIZShmaYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UpNIfYy6; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UpNIfYy6"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2d3c396787cso5540059a91.1
        for <git@vger.kernel.org>; Wed, 21 Aug 2024 12:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724267361; x=1724872161; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2EMO93EBvyx9bXOhXW+wqPK5ERukT4TaRdgLSE1Xda0=;
        b=UpNIfYy6sKfUzpD10gfvhI2gghe5UoLZJU9zbC34eFMoQuwfZBrAcRJWS6IPGWKDJ9
         irOOInwqJFGUOZrJ2pIrGLdVk+VEmwCeBrhfC8NQUiToefD6jk5/kJpXZrZAQTR3Qo3I
         Yj++uEJvUMDXvvgbGZZlyjixlS5K9lmrWPyrF5XFHo9j+7VuIVM7rvr+JZWJbonaxNla
         5fLYG7ZlAXC88DOJ5t6CHIXjxYiQoH2YfYL/Y5g4mm9HLNYfVZTK5XiZ0pLUVOe6y/lI
         tfpys9M2ViEm2iHj2d+fidueEHnKP6amM9FYfcvOUoYWzJts7SxoOoMWA9ZuWptXXkxT
         7W/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724267361; x=1724872161;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2EMO93EBvyx9bXOhXW+wqPK5ERukT4TaRdgLSE1Xda0=;
        b=QI+6LrOWASbpizQaBzd8q/ALDzgSDiu6NWY64zN0N1xig/QYy6w+9ASh9Gmu2kT7TM
         4AP4uhsLc2ipSgFHShpYIWgbAO1wopHtdylOOjmUu+2HEPl9O3zD9pver5zNqbSr+ECf
         rCrfXpLzPPj/h4nNVTWGwTlcK0EYI2UmAuWaMRoCTNHqc8iZ1xhWPpUNPTc/sg6AEMws
         a2bDBOWwOZWaIG8rYsBew7NHEL0MYYD6YWKr/ng40sDmTEjLjMeXnKDWGFZQcYsHd2Za
         eAv1VHO8CES5G3mB3TEwhZpXRywPj+V8GpMfQq6hsmgQSZSRtZmGP/NE6J9KnoD1R/pf
         2SmQ==
X-Gm-Message-State: AOJu0YwfHPOKXrwpkaVIrDfViG6RiPcX4AeFLM0AJmlBOPdcHz1UrUBJ
	BCQ1w50bDKLR4Lw/ie73loxJH4zPE3vo6KxTXaF5bMpW2qdIeJb8bzCRf8LnFcJKtEvuoXvN3/0
	GWFkejN9W/3SPUPQAP5aEKRdMEZXIf53+
X-Google-Smtp-Source: AGHT+IFyCmAxIyUYkLRU1PKyBlc0Lz+/vN2tmeVy5ItfhornvxnkezcSvPH+9djYel2komvcDRVP9Cqyrc8RQSX6Y5U=
X-Received: by 2002:a17:90a:a106:b0:2cd:7d6f:31ad with SMTP id
 98e67ed59e1d1-2d5e9dba854mr3709000a91.31.1724267361349; Wed, 21 Aug 2024
 12:09:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Piotr Siupa <piotrsiupa@gmail.com>
Date: Wed, 21 Aug 2024 21:09:05 +0200
Message-ID: <CAPM0=yBx4LiL+5vhCGgm30ThtsN99-zWeeQ7qhtwRR-N-2DmHw@mail.gmail.com>
Subject: "git stash push" behaves weirdly when files is added in index and
 removed (and the other way around)
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I'm writing a script that is based on "git stash" and I test it
extensively, which leads to finding a lot of weird corner cases in the
behavior of "git stash".

I've reported one bug already and now I've found two "inconsistencies"
that I'm less sure about. (and that may be related to each other,
which is why I write about them in the same email)

OK, the first one occurs when a file (that existed in the previous
commits) is removed in index but after that re-added without informing
Git about it. (So it's untracked.)
    git rm file
    echo content >file
    git stash push
The untracked file is pushed to the stash despite the flag
"--include-untracked" not being set. It even works like that with
"--no-include-untracked".
This looks like a bug for sure but I found a test "stash rm then
recreate" in "t/t3903-stash.sh", which test for this scenario, so
apparently it isn't for some reason? (Just in case, I'm asking for
confirmation that it's intended. Also, is there a way to disable this
behavior so my script won't trip over it?)

The second scenario is the exact opposite in the sense that a file
(that hasn't existed before) is added in the index and removed in the
workspace.
    echo content >file
    git add file
    rm file
    git stash push
After that, the information about the file deletion is lost. The stash
contains the file both in stash@{0} and in stash@{0}^1 and the
workspace is clean after the operation (the file is restored).
This, I'm quite sure, is a real bug and not an intended behavior
(although, I have a tiny doubt after finding the test for the other
situation).
I went ahead and tried to fix it on my own but I don't understand the
intricacies of Git's code well enough so I failed. I did write a test
case, though, which I'll send in the next email (because if I
understand it right, patches are supposed to not have any added text
in their email messages).

Piotr

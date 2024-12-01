Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B782B9BC
	for <git@vger.kernel.org>; Sun,  1 Dec 2024 17:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733073479; cv=none; b=MDlx1wAkogzjQr2H8pt3kauQ9nHjcJLE4825GYSGKPrHIeK/CvKof4Z6jjPBk9rAMsB/6qSyuR7qalGsKqBAnTBupK2aaRIlDyLldXWpvrAZjiDqyvTqUZAmr4cqj2eSn/gP2JR2IaFic+bNcFnXUedGzXH8RhD/RlrFKqt0jfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733073479; c=relaxed/simple;
	bh=L1lFI+6UQ/fSUeycL/Yh/qbyhq1iH+p01i+G1XPfdRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aGIF7/45ZeFZR60R3NRdmHo0IoB3ubTG7qf6xGlLjsiyVXeLythhN0uui8jtII+o9fG5eBk2fcjVzSvM50y/l2Tj40Z3JR9f+1F2iWkdKZPpAOZAcSANSEiZtq6IKnteCOyYEgSQAz0B+Q2xSmEfusA86tGjXH6XVMU9dSqQjo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kNnFKf4n; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNnFKf4n"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ffe28c12bdso29504041fa.1
        for <git@vger.kernel.org>; Sun, 01 Dec 2024 09:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733073476; x=1733678276; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L1lFI+6UQ/fSUeycL/Yh/qbyhq1iH+p01i+G1XPfdRI=;
        b=kNnFKf4n5ir2KM4DY/uPzxgk9xprx08pV99lACbmgo0ck26ec4sN6Y/61SyaKL+q3M
         30qgknEAafD96MxkJ6bqjl4FIVoLHW5fcKe7bYzavZxe+DQtOLLgrclhARMxpGkRLoH5
         ZJzTGoF9ZvwPHnoWMYlhVZ+psehIz4SA5Z9hrzhorYW5UXQ4cFX568wT4KlT9ABLqmiT
         3XcFBpNW15IBNbSxH9wj/8vSPsAXGAnSsHy6EJbPNvZUv7NsmAns2e6bbGXhoPeJ1b8p
         aIzKcXedXxwH3w+Dlm8FyBorkB412paWG16GPM9h8P3cmR9aa6peoVQhMtzb09fHiCL8
         qa4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733073476; x=1733678276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L1lFI+6UQ/fSUeycL/Yh/qbyhq1iH+p01i+G1XPfdRI=;
        b=kKIc1udyLJ/Gn/vEUyzAPSoMiD3FXkH8Os9NqNtHud32wrf6oqKH9HLtzr6gKPtucD
         BE4rRkADtDzdQTs32kYy7ENuMriV1xAchmfx1u/KlXEshB/zoNXOLc3cBTd9Nt9Jd5/h
         4MMV5hZaVdwMVR0eu7z69yGWVbd16WYG7AfWboqBoPFv1EmHvW6GBrRTPGDJYZU485nu
         PJJEdPJNmGF/sd5sfYGHmVml92cRkn8DEL0YAbVGWnHRcuPBdTpYCzdmHRWvSXUBR7cU
         LenRv3eFxgTuLfX3AEWjNQhTDIgvppM8mgDShKuBCIbp5YeaYD2KFeRox/p5CrR+mMEf
         r3eg==
X-Gm-Message-State: AOJu0YyDHfrePAFMG+OLa7G4tPEsWIb1UFRW8jsVv+43cEbNZ2AOXSey
	3mW7lbwXMyKpmINkue2XaVvIMUxb7VOd86KL4BnwLDxpe3SRftj/FTI3yinMdu1fYSo1t8W9VJ6
	1+/4Lnvv+Jr0+4QtB9uPTrGoBZ/eYGUEN
X-Gm-Gg: ASbGncs3lh8LeUrRpojGc8m6sjrLLQUv4i3UMK7plkMG9++NoA1aMuiQ4uaHhElm+eY
	SWRr4JjU7TCLAWL76YTJIKU5ECoaQHXM=
X-Google-Smtp-Source: AGHT+IHmc7rMT9EaQ6rXuGby5rsDvbvHlAuLcoK/Ol1dIzfP8e7J4iIDG+npxJJ3XURGb4lv0giqucoqmNyheVkQliI=
X-Received: by 2002:a2e:bea6:0:b0:2fb:59dc:735a with SMTP id
 38308e7fff4ca-2ffd60fafb5mr96735271fa.41.1733073475890; Sun, 01 Dec 2024
 09:17:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJ-DG_DpNVmn1e=8hBX4YbEhzgX4xxn7AVBQnhKJOvHX4hx7kA@mail.gmail.com>
 <20241130163801.GA110697@coredump.intra.peff.net>
In-Reply-To: <20241130163801.GA110697@coredump.intra.peff.net>
From: Dmitriy Panteleyev <dpantel@gmail.com>
Date: Sun, 1 Dec 2024 10:17:44 -0700
Message-ID: <CAJ-DG_CNPGgfafyTcKWYeNXHD4gsspWakzQoRhfggMqZjenkyg@mail.gmail.com>
Subject: Re: [BUG] commit fails with 'bus error' when working directory is on
 an NFS share
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 30, 2024 at 9:44=E2=80=AFAM Jeff King <peff@peff.net> wrote:
>
> On Fri, Nov 29, 2024 at 09:58:51PM -0700, Dmitriy Panteleyev wrote:
>
> > I've recently upgraded my (Linux Mint) distribution version, which
> > came with git v2.43.0 and I noticed that I can no longer `commit` on
> > any working directory which resides on an NFS share mount.
> >
> > Git reports "Bus error (core dumped)" and dmesg shows multiple "NFS:
> > server error: fileid changed. fsid 0:68: expected fileid
> > 0xf8e3d8e80230ddb5, got 0xeeb48230d99ed0d4" messages.
> >
> > This does not happen if I move the working directory off the NFS share.
>
> I can't reproduce any problems here on a test NFS mount. But since the
> old version works here:
>
> > I attempted to upgrade git to v2.47.1, with the same result.
> >
> > I then downgraded git to v2.34.1 (the version for the previous
> > distribution release) and the error has resolved.
>
> Can you try bisecting between v2.34.1 and v2.43.0 to see which commit
> introduces the problem for you?
>
> -Peff

Bisecting: 0 revisions left to test after this (roughly 0 steps)
[04fb96219abc0cbe46ba084997dc9066de3ac889] parse_object(): drop extra
"has" check before checking object type

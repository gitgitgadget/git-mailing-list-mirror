Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2B92C15AF
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 20:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758315048; cv=none; b=JkLCZcUPRxkbv5yyinevm8NBnQtFallf+mqXtp8i6mwzF0Xeu1JQpmgNaDIbdc9mC89NKlK1MO+dvUNY5X4Q+0ejby9uG8IYosJDkd11X1XNsdNicRl43d5EMj6ePifxlHkSzDRUr9zFQRBp0nmY6ptfxeE9mPEHRKbmjMDUqNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758315048; c=relaxed/simple;
	bh=uo664+MWsVaJtjaNJwOxFQepkoFbledNJo5X0erjW5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tXD8TPmSojGhgHveOytVIyB2EEm/Ej5L/Mc7GT6js7mJ4tFYacW/yvDSB/xFpmsCjt3WTex+BzLBFLGCXeiwpAGtJ3C0Tc0snIgwiIir2VEQExdTS30qb9/qNUuq0r8o1BkD0GbiEP1xKA33a/Zw4S2euoRGD1xI2vT40jBMe90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IKjVQm/D; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IKjVQm/D"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-837d73dddc6so33409885a.2
        for <git@vger.kernel.org>; Fri, 19 Sep 2025 13:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758315046; x=1758919846; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uo664+MWsVaJtjaNJwOxFQepkoFbledNJo5X0erjW5k=;
        b=IKjVQm/DsOjMZE/CwHRM9hoOdMZvtqcLOQPZnoyCyTtBZoHQaRHQb/405GHmP1iY5I
         MzP32udo/Ki0H1GvXsEq+KcSm/F+eJrT8YDDnD0n5JxZICvtLmNHYr/gwEwIY9Ttzr7f
         00F4bbnlCBYvlcEsaaxjhmi40wEtNIkDt9pDHKMhr6dd8DPUl7nznxs0EGEWmdcwJlnn
         kqpHWbtUhMBR6pIqJKWWVaJKZh3HfwQI1x1uPFNc5pIIWnnfr4uR8YJAWFuymMdsMr7E
         Gi/YmO+LrdG0TX+pzrN6IMsrflyaMVyDLMIXl9mYwExiIOPGTaZivGx4kGYAmeqBbfxH
         Y1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758315046; x=1758919846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uo664+MWsVaJtjaNJwOxFQepkoFbledNJo5X0erjW5k=;
        b=kdx3QF1c+KVJgvBNrQ+NDHlgAI7PHkt//1fslIcNrEpnupaCL8FjRHw2vAsbvb/7sE
         4jgOQe4Tvc/CsaLJjkUkyDDOdaqSYQ6TvJg574+4m5jfxVkq7ROpOLwmV36pHipR2foB
         htKG5BBvgrLgGKDVqxj7Yc4UYbjX1fmYhUF7WPh3UPPIfudJD3hY7IXmyy3Rc1eRLtSw
         kLnnO0rcYaWvX7Bmj+w0Sl2x6XtlwjPowrW0qKoY9pBj1SMqW5EBwSe+QF3+l+VmDt5O
         eh2YQxye68cmIhfPUKNconxSX9FSa66mGxNomiNFfllT/fV8yUn9xUYmmN+Rzl+Rl7wt
         NMrg==
X-Forwarded-Encrypted: i=1; AJvYcCWzNkAzjsvG48RlN6BKOuDZPuwozDRw/HzqTSDwFuziR7AZGHROerdAVWDRM4xfTJmef1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqAVg1nzqNcOyPOqaC6lSh5wThM6jziCUz8MFDOW+uVg7AEkWM
	nfGWi/VWjKbUb5M7Kz9S5jtAD6M3APTCl500X+xwHoMoav3E0XDz5qlMd4g1hzUN+jNCJJ9o9LF
	yMurpxUk7EhwQbAGRsptAGJ2I+h6cqoH+z5Ec
X-Gm-Gg: ASbGncsCMBcu089Hs7j+3g2FqNNiKXR8ajpX+kiD8b2w+PbHpzA1Y3Sx7JNpzRbrgPk
	z+0rbZkWdTNYjAm9tYh0a2LOm5PKzTPciCq2hqXQdz590dXvk2obs+VaHpdO/NUzqaavIMYHxiH
	laAOqIjKuWDX2/Fyr/PPaVklYc/CmJC5JBl/ycCFdeUqlTRR2EiD1j13O1NKBrQQJsGwG/SwpRn
	HhaFUBXQ+mPKf8Z5IYwY9CDvvMmdGUwxGofVIo=
X-Google-Smtp-Source: AGHT+IEW+Yv6bBkq6LjyCDpEIIKbJI8m4kAusNsS63mOQL0wyW7L5xT24AnenVGqcPEDXI+J7CTnSDIvfwj0Eli71mI=
X-Received: by 2002:ad4:5bca:0:b0:783:fd50:70d1 with SMTP id
 6a1803df08f44-79920e074d8mr35144456d6.7.1758315045756; Fri, 19 Sep 2025
 13:50:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
 <pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com> <17143ced6feea5927b66c0578f1c2fbb07378504.1758071798.git.gitgitgadget@gmail.com>
 <CAH=ZcbBf65E6aNN-cCp_0Nupk9GD3apjKRWrfi_JfJcwWi_mCg@mail.gmail.com>
In-Reply-To: <CAH=ZcbBf65E6aNN-cCp_0Nupk9GD3apjKRWrfi_JfJcwWi_mCg@mail.gmail.com>
From: Eric Sunshine <ericsunshine@gmail.com>
Date: Fri, 19 Sep 2025 16:50:33 -0400
X-Gm-Features: AS18NWB98VRGCSFwu3e4txKedC8NlMpMebmDs7nkGO-94KKB1Vn4bMA-2by-B5c
Message-ID: <CAPig+cR19fUmzCyH2yaHjom4ifGNi8tBz8eDJwe8dfpJVQXyCg@mail.gmail.com>
Subject: Re: [PATCH v2 16/18] build: new crate, misc
To: Ezekiel Newren <ezekielnewren@gmail.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 4:42=E2=80=AFPM Ezekiel Newren <ezekielnewren@gmail=
.com> wrote:
> On Tue, Sep 16, 2025 at 7:17=E2=80=AFPM Ezekiel Newren via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> To: Eric Sunshine
> It looks like my gmail never received your email, so I'll respond to
> my own patch.

Indeed, by sending reviews about earlier patches in this series, it
somehow triggered Gmail to think that I was spamming you, hence Gmail
thenceforth refused to deliver all subsequent emails to you (and
several other Gmail addresses in the recipient list, including Ben and
GitGitGadget). Hence, you would (presumably) have only received my
review emails and other responses indirectly via the Git mailing list
itself (assuming you are subscribed). As far as I know, Gmail still
considers my email address as being a spammer to you, so I'm using a
different email address to respond here.

> > Please extend the commit message to at least give _some_ information
> > about what the "misc" crate is all about since it is not at all
> > apparent based upon the name.
> >
> > By the way, is "misc" really a good name? It sounds like it's going to
> > be a dumping ground for anything which doesn't fit anywhere else.
>
> I don't like the name misc either. What should we call the crate that
> will be the new home for .c and .h files that live in the root of the
> Git repository? varint is so tiny that creating a crate just for it
> seems unjustified.

Would the name `gitcore` or `git-core` be suitable?

Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0719854918
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 17:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744650533; cv=none; b=lKlhxNhzyXkI8cYxG55Ly5z5aVECy28IlrL6i9suf2dnn40p5uSmK6Y0hXfh3J9SeTBRL0f4ZSImRt6LDTEhPRYqHkj18nIo9g43FxhRs9BdtdbBXvDWezpc0AcjQHJCpC7BgEO49dkPgNG713gOwHQmiQhuP0VvS30iJ3wEN7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744650533; c=relaxed/simple;
	bh=qEdX2uj+5iIb0x0PX0iqXHXAVOqvDLThF/I5LQhk8vg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i2bMT/Ma6ABkSfEkESqok79arP70DgK+6Ukn8tke/xBlGCIAQQrd6RK+JW1zYQB0ySMaty1H4UoAeuR0Jq040OgofladSCNQ65LsxUE7cMzqpDBu3mUEl/4bsA3rRxlLw1LEv8iZok/51mNrJsI8dEHuOLI+lwWxYSB7L0KP6yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fBy5rlfP; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fBy5rlfP"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-477296dce76so39225421cf.3
        for <git@vger.kernel.org>; Mon, 14 Apr 2025 10:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744650531; x=1745255331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SDKNSkdwhUKEDUJ9kCk3NoIQiY0NYzhIpdAm9w9ijIs=;
        b=fBy5rlfPtZwrlr1Ar0y4R5aNT675eo2MPKHg/79aT24wk+NQDSGieSOob1DXP2/bGY
         woPNVH/PaQu6SiP73cAeGBGq1z8Jzhi5YIy1FhXefq42zRfGRRxFWt1vJRhj389ODm5M
         ieACmkN/2YksMcdWFVYg12tM/31KnwbXE6feJMSDdi9eUAIByDv7dvVJCLckm+mTiW8O
         uW/ZJb1WCWMU8Ydivsh1tRmBWAoMD+kvoSNNdmYBVAggS39s8+yWCNBTBFl2AmtiIlQ2
         0HeplwFUSlFjtKGfs5mDKLKf9Zu2xJzy2YL8WkaljgKc6DOZnQzyZ0sUtz/60iFZvwfx
         hImA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744650531; x=1745255331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SDKNSkdwhUKEDUJ9kCk3NoIQiY0NYzhIpdAm9w9ijIs=;
        b=hP6VQYHzttq2iUqAZ2pGW1MUJI1vXfNfjV0SL7E63nyuqTalxE06YkjXwfCZZ7ySjJ
         gOD/xFjO/we6C9RyXXUXtWyz84XgLmbJRSRVCl121pXtvAvYHwLd1iIOSESWnHtyPuXL
         nBleeWejbSfxnH5Qr/XFUpJY/+yXD+iu73hOrKUGpibkomVH2/GanXCxlkcuLYHQ62p1
         WrZn61WpAEWKJWjuEL4UYSTHDuzT2+5zC+QxcCflcL4NX1uF7I5VXCT/5IF9fFKFLeJ3
         r3GAUjhjdOnBH2MDeOB9kvDTitJi2ZW3iGh0RjVtQgsO0VT1LU8YOf4C8BnaQpjkdXtn
         6FfA==
X-Gm-Message-State: AOJu0Yw3+I00RzQDeEmuP8/7Axzc3Sl7qc35mKhEVk0C+MXjHuJk2Xyn
	MZQzw7IM5eVuyBlDcOJdhK/9NjYEveKtCvY4Q5tRXshpBmvRxDm+7SfCGvSA73DAll8xF2Ve4aU
	KIBMAXaBQ93If1RhqiHLp/845lwpF+9vP
X-Gm-Gg: ASbGncvvEg9h+CAl+EG8lmjyrOIrlt28SCtfUHXyitNajMOpuHG243AwKfforX4uuhs
	rtEc1Z4k+yAWKbKoy3niVYGjEJMmjCz9bVbc6HrBEl0Eaect/GGnNJn4kw+o7TxmC/WyAYBhRK/
	FAGVH4LT8b3buDUv8DBR/jY5Ysac96oG+oJD/DMO0MaxgW0OAnEBhf6Gs=
X-Google-Smtp-Source: AGHT+IEowZKqonIimEWFsNCkJ8onhQCKW8GLpDmfSDiV3PVc8l+Q/xG1FL0qOLTEH6yPy23lrJYuJwyiMnigsNGaHo8=
X-Received: by 2002:ac8:7f4f:0:b0:476:7c7b:5dce with SMTP id
 d75a77b69052e-47977527fccmr131127721cf.9.1744650530643; Mon, 14 Apr 2025
 10:08:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250412094607.236382-2-jayatheerthkulkarni2005@gmail.com>
 <20250412174051.780148-1-jayatheerthkulkarni2005@gmail.com> <FFC5C6BE-9A4B-4EFD-AEC4-E69CE6610054@gmail.com>
In-Reply-To: <FFC5C6BE-9A4B-4EFD-AEC4-E69CE6610054@gmail.com>
From: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Date: Mon, 14 Apr 2025 22:38:39 +0530
X-Gm-Features: ATxdqUGto71qo1SeXKtuc4-e_VLPQq6ZaWxw4zn5DIdxmVEi9Jt6jYEMJ7UTtNk
Message-ID: <CA+rGoLc=CYehMms0bxaLAu3xP-p62cMJ++RnBxSMOF2Ppt38QQ@mail.gmail.com>
Subject: Re: [PATCH] t3706: Add test for wildcard vs literal pathspec
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, peff@peff.net, piotrsiupa@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2025 at 10:21=E2=80=AFPM Lucas Seiki Oshiro
<lucasseikioshiro@gmail.com> wrote:
>
> Hi!
>
Hi Lucas,

> > +test_expect_success 'setup: create files and initial commit' '
> > +    mkdir testdir &&
> > +    >testdir/f\* &&
> > +    >testdir/f\*\* &&
> > +    >testdir/foo &&
> > +    git add testdir &&
> > +    git commit -m "Initial setup with literal wildcard files"
> > +'
> > +
> > +test_expect_success 'clean slate before testing wildcard behavior' '
> > +    git rm -rf testdir &&
> > +    git commit -m "Clean state"
> > +'
> >
> > +test_expect_success 'recreate files to test add behavior' '
> > +    mkdir testdir &&
> > +    >testdir/f\* &&
> > +    >testdir/f\*\* &&
> > +    >testdir/foo
> > +'
>
>
> Two questions:
>
> 1. Does this need to be inside a test_expect_success? It seems to me
>    that those two tests cases are actually setup code for the next
>    two.
>
> 2. If so, does it need to have all that setup? I could reproduce the
>    bug by only running:
>
>    ```
>    git reset
>    touch foo 'f*' 'f**'
>    git add 'f*'
>    git ls-files
>    ```
>

Umm, I think the setup should just be a single block. I will send a
patch on this
I'm parallely working on a second patch.

>    btw, this works with your code, congrats!
>

Thank you, credit goes to Peff(Jeff King) I almost lost track.

> Other idea: `?` is another wildcard for matching only one character.
> Have you tested if the same bug happens with it?
>

Yup I think that's also a great suggestion, I think consolidating setup
and adding at least a few different wildcards will be good.

> PS: while I was writing this review I pushed this to my GitHub just
> to make the CI run the entire test suite since pathspecs are a
> sensible part of Git.
>
> Take look at this, it seems that your tests aren't passing on Windows:
> https://github.com/lucasoshiro/git/actions/runs/14450183624/job/405210158=
97.

Oh damn!! That's a silly mistake. I almost forgot windows exist!!
Thanks for letting me know

> Perhaps you'll need to change something there. It seems to be
> related to how Windows handle paths (specially the \ character, which
> means the same as / in Unix). Personally, I'm not a Windows guy and

Same not a windows guy, but I will have to read some things out.
Will figure it out.

> can't help you further with this. A quick reference on how paths on
> Windows work is this (and yeah, they are far more complex than in
> Unix):
> https://www.fileside.app/blog/2023-03-17_windows-file-paths/
>
>

Thanks again Lucas, these help.

-Jayatheerth

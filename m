Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F287413633F
	for <git@vger.kernel.org>; Mon, 27 Jan 2025 15:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737990476; cv=none; b=CybPy2zp/+u2FMZE46LOLCGFHlC9kztuzK1aeUQEimKSMzs6CIxNEUkXfHxH53KSrQaT9uzmishBDeUYCMrVFqewA7P1Ht6zA+O4ljUgfvafOpoXOjOT71o+nriu8HnzavYJuke4OeilFEbU6/DuaxW5x4y1go4B5H7bNalgyPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737990476; c=relaxed/simple;
	bh=nIAHwzaNriXFd5vaF0J5PhOetR2KrqqWpTtTB5Bd9r4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RxWanklCElU3WbidiaZgfd/ZorSMVGR6R2c897964mjmoa2+xF6nxME/dkHmgx0c49/KlJmIokzeNe/MJmRpDU7CAQURELfrohBczCEKg5UvPhWIlw84hjg8bMEwHqTzUQK2khVWbAR0DE+Id0R1Ql00JI5n48zVEyJtokD4DOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lXF0qtNr; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lXF0qtNr"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d96944401dso7549377a12.0
        for <git@vger.kernel.org>; Mon, 27 Jan 2025 07:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737990473; x=1738595273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nIAHwzaNriXFd5vaF0J5PhOetR2KrqqWpTtTB5Bd9r4=;
        b=lXF0qtNrthsbWIp3Nupolt4pplK/SJvCAbfS4jYbrzIof26ob8cClTCRP+1PEiK5sX
         xww7+fXt6gXzKCpQDI2y3RfOIZmuA7aCQCq0I8DOvAdv7FSJEsv7d0RlNWq0ixjVOqmC
         zgnMyDjm2mPlZxp5/Uza3HNTYiE/eujb6PZMDsKAGzjAS+W3lyuf9Y4IellAAWhaAdlX
         lJ8LQXE6f+hwiHICgxzIv8XLwEsUrHenUT0rJenH+VlhBsc036LoliI+O+gKcr2ClTaQ
         FtJBH0u1k2zvQ2VtL7/1h2Gz+nNR/gtd6At6BTG8HAYb+EVOUI1fVuBgYmkBiUHOnFsS
         WaBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737990473; x=1738595273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nIAHwzaNriXFd5vaF0J5PhOetR2KrqqWpTtTB5Bd9r4=;
        b=o2OZ9w8BNOQbRCEfdKZTNr5AcraNKMitd73nYf5QfswFkZmbx+h8ETg8XEp0cwZnU4
         /EjFbFPqiimPSYRGD8IXeiRdJL4jToQB4eS1BKO2Fh795tl43mzL5M22LEe8Xq7J54eC
         SgUriU1FdVMpcLAGS7Q5FQhR/CQUdh35C0fadYgWnWQ3E88U1PHRxP5F+k5itP7S/8cF
         hXiZG45O0z+aO4E+N1KBkQ7IMt0Vo8B3IzmKanH4ySI2fm0xILSRJubEARgZkHozsGn5
         zd1H/E7xj8g2uWRKpVvs03RY2ZjKCuautWd+IEL8f+91B90y8R+FdE5dDnrVJ5rn3HI/
         40+A==
X-Gm-Message-State: AOJu0YwgLUnon9YV0PnBn54/giJbCo6TVzAqs9PZtZj3MCD0wcrEMCR1
	PxG3+xIWi4xrtVIQS0VERqHKe/kbQyqT9Dr1ZO4zbKs1alyP9YD/LU5xO5skuPmrJ5p91ahhE3H
	ovk8CCR9KX1Hj4VR9ksU4cxQH0yA=
X-Gm-Gg: ASbGncscNj8sGb4h+7LOIJj1QHY8VI/9xdIsIbRONv51OdbjhVm3iKf/86jYYr1OVoz
	YCSx5uW7ihVs1AFFaVAOL46koY61D5y1K407AOLFLXHZErIFyRf1q9G8fLQefQpX3
X-Google-Smtp-Source: AGHT+IF2yJJ1QWp5lQFZODi7+yyERf0XebsVQWaRXb9sinBjCL/fnklg/r8tLRfeh+dQFG1EDppxqIxm8q14sUhGkXU=
X-Received: by 2002:a05:6402:358f:b0:5dc:1059:69f with SMTP id
 4fb4d7f45d1cf-5dc105a612cmr13836240a12.10.1737990472892; Mon, 27 Jan 2025
 07:07:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910163000.1985723-1-christian.couder@gmail.com>
 <20241206124248.160494-1-christian.couder@gmail.com> <20241206124248.160494-3-christian.couder@gmail.com>
 <xmqqzfl8t2yl.fsf@gitster.g>
In-Reply-To: <xmqqzfl8t2yl.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 27 Jan 2025 16:07:41 +0100
X-Gm-Features: AWEUYZk5S4ilsi5HpNiZDndpvj1U_YwR-bREusIWLfcEBzJ7NTNc-04ghCUuxYI
Message-ID: <CAP8UFD1fD4Rxz1=73kNxSWF+mwmUa4qF0cYUfD+PmMeNwA-cwA@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] strbuf: refactor strbuf_trim_trailing_ch()
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, John Cai <johncai86@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>, Eric Sunshine <sunshine@sunshineco.com>, 
	Christian Couder <chriscool@tuxfamily.org>, karthik nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 7, 2024 at 7:35=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > We often have to split strings at some specified terminator character.
> > The strbuf_split*() functions, that we can use for this purpose,
> > return substrings that include the terminator character, so we often
> > need to remove that character.
> >
> > When it is a whitespace, newline or directory separator, the
> > terminator character can easily be removed using an existing triming
> > function like strbuf_rtrim(), strbuf_trim_trailing_newline() or
> > strbuf_trim_trailing_dir_sep(). There is no function to remove that
> > character when it's not one of those characters though.
>
> Heh, totally uninteresting (alternative being open coding this one).
> If we pass, instead of a single character 'c', an array of characters
> to be stripped from the right (like strspn() allows you to skip from
> the left), I may have been a bit more receptive, though ;-)

Yeah, I realized strbuf_strip_suffix() can do the job in the following
patches, so I dropped this patch and used strbuf_strip_suffix() in the
version 4 of this series.

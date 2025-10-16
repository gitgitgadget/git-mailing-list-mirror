Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83C43346A9
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 17:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760634756; cv=none; b=I/0y+p+YeKgoXuu/yfj2W8ImFvnRshhOp3eBXTi5pmK3U1nBEE3KVUVRZtYvu6YrQaJ4EimHPvDGL5XaEnFYQAPZwzWjHaan2eQC/zDPloZZspqPaHS7wreWXAXpo54z3pemLI5zbPfbSAhpvdyZtToswWgdYLTZOg4Y875ykpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760634756; c=relaxed/simple;
	bh=7Or2tAUQojrT9pWkOXFpqi2ZlfZPrUzMn0P+DA6VPgc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aORNldtayi57/R9SMdTcCXVhs53peGhatnI0PM68HXVESXc4abkXVaNY6/yZZb4+NPbrVOi+ERQLGkgwxXdpBgGcRbaezP5DwHrIUCV+mY5wyYtLFU/3az9FbyGlcr0VqKCQ1jd5fcMHWYQ4u7awz0yd1a/iPwSw01tuCdeZ22I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bR7rJMYT; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bR7rJMYT"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-633c627d04eso525a12.0
        for <git@vger.kernel.org>; Thu, 16 Oct 2025 10:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760634753; x=1761239553; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HCWALsnfUWo5qZoqElxjrwHUuUseM8WW+KpmPNWTpNw=;
        b=bR7rJMYTDFuijOnhdJKB41VnpjxZ0mL72hf49E8yFdf+oZJwpqOibug6U7yjc6EBtM
         rXkm4QhMkJjJLxFqhYec10X/x5pB04s0DfCBsvoYqIg7schsFBNUAEoGxcRmc7/ir8Ma
         NHVrCZkSKNlj9pQSGJI5wJE2++bmh4UntoOWCOW5HkORn+No3yynM8Pq2M9+C5CB1cCp
         mQMfD25vIuRwMr9mE6/YzsUYnqolRIEW3tS6j2Uf3r2cOQANWqpLhvEzlHuIlUoriqXu
         4MgGq+q7fq1d3BN7ox9qgbggaLDOy9QcMDSBjSxxkG6zFfMh0iB9/P+OdNgbc+mL0yOF
         tgYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760634753; x=1761239553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HCWALsnfUWo5qZoqElxjrwHUuUseM8WW+KpmPNWTpNw=;
        b=vrL6wfNnB3iFfa1lOV17cS4CfqBCv70u9HUX8jet2VoBmOs9LMZQ4Idir2Ydgpzyok
         g3CmDzGnO/Fwr08v9wF8RKGMCi9I39UTkWSvnnqZIdLOcm8GrM7CNaQWhxYgEDex6OhO
         Y3kOxZei06X3ePSk6GV43yRsBi3RVPRJI7USaQb0Ailh2tVXiB0D0erjQS5avVv+nw/d
         DJqMtn7/A5gcSWVT0ote2tOmbJE/ESIvubF8jRujT9/H+O8oeGh0FRy7xV7b32CADTpz
         MMeGgDRtFd3TnXYKX382oBUx0TROomEGkONZG/TXJX1hpqKRm1xKJ0cflcE/z/MHi9hU
         YkqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXKlhFBDNLSfdwrjb0iH1XngK62xGEpRV6JOdWsOpQjrutS9pwjt1VEiuIWcI5CJz0v1o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5OWh8f4IExi8koRpr3f/jXRX3Z+NbI5rgsl6ayGw4+r7PVjJY
	sE35VyKTn79L9GYOO9bB6IvWvrjewtF+q3bmMK+3ws3VVO+AipHX7FWmme6iQYLYCpYXvOcyAJ/
	pzv4toudW5JvvR/AiFL0ITGBx2maNkvPx94qpKGAY
X-Gm-Gg: ASbGncv1OxvdbwVXBYoIGLRGozvuLmiU+tQQfn3a1rKMH6Ln97XXFTdBpIRzKOPzcFm
	Gq9VcLkHyTLweVRlgitn6X4HoOoKwzJTPczeWd9VrJlU1hftwgvPSeUTtAU7VHjE6wy1pyEQ/G/
	+s7VVcSN/APx4fF4iIZj0dvKZvZziasg58mYiU3UqvznMX6tMxjCP4iUZx90lavLXR+cTQjLv8l
	1hojMy8dXNAso8FziROBUs9UluCsfORsNOx5Opkg/CoCDh6WKZ9XFoiHii3t4MO6p/dcP/OaM/o
	XsF7hmul54uxPs0=
X-Google-Smtp-Source: AGHT+IGmkV7ExlcUNyVUiGSRgZNUSfnCntRTel8hyPdHaH+4NkJO+b3i8zgvxHMHIiP9dP/KuTO8VIHwMIEvlH3jW5o=
X-Received: by 2002:aa7:d859:0:b0:63c:1167:3a96 with SMTP id
 4fb4d7f45d1cf-63c11673c77mr78694a12.5.1760634752937; Thu, 16 Oct 2025
 10:12:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1989.git.1760566054455.gitgitgadget@gmail.com>
 <aPAgBPLH4QYa0ceP@fruit.crustytoothpaste.net> <xmqqh5vz7ygc.fsf@gitster.g>
 <CAESOdVAEN=YeMqozR4438L-U7mZ3nhRnMB5PV_sUPmwuWSkbhQ@mail.gmail.com> <d47e137b-c34d-49c9-bf45-226cbcdba416@app.fastmail.com>
In-Reply-To: <d47e137b-c34d-49c9-bf45-226cbcdba416@app.fastmail.com>
From: Martin von Zweigbergk <martinvonz@google.com>
Date: Thu, 16 Oct 2025 10:12:21 -0700
X-Gm-Features: AS18NWBC53GD5QtAmMwpKQZaP4VOUd4KCHVQaBfpvxGgu4UAI9zhPCyX0Sb1n4c
Message-ID: <CAESOdVCQR=z95MK1oHZO4_iBXS8Z9uz4Fs0gDDX+BfaG9_3=ag@mail.gmail.com>
Subject: Re: [PATCH] BreakingChanges: say that `git diff X..Y` syntax will be
 removed in 3.0
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Josh Soref <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Martin von Zweigbergk <martinvonz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 16 Oct 2025 at 10:02, Kristoffer Haugsbakk
<kristofferhaugsbakk@fastmail.com> wrote:
>
> On Thu, Oct 16, 2025, at 18:38, Martin von Zweigbergk wrote:
> > On Thu, 16 Oct 2025 at 06:44, Junio C Hamano <gitster@pobox.com> wrote:
> >>[snip]
> >>
> >> The same for "git checkout master..."  that detaches HEAD at the
> >> fork point of the current topic (so that I can "git am" in a new
> >> iteration of patches on top).
> >
> > I couldn't get this to work:
> >
> > $ git checkout main... --
> > fatal: invalid reference: main...
>
> `git checkout X...` works for me.  Apparently it is this part of the
> doc: =E2=80=9CAs a special case, you may use <rev-a>...<rev-b> [...]=E2=
=80=9D

Oh, I think I know what the problem is. The reason I tried it was that
I was curious how it would behave when there are multiple merge bases,
so I had set up a repo like that. Then I got this:

```
$ git checkout main...
error: pathspec 'main...' did not match any file(s) known to git
$ git checkout main... --
fatal: invalid reference: main...
```

I didn't expect those messages to mean "the common ancestor is
ambiguous" so I didn't think to try with an unambiguous common
ancestor.

>
> >
> > But don't worry about it. I think your point about there being other
> > commands that support the triple-dot syntax is still valid.
> >
> >>  As the syntax "git diff master..."
> >> is symmetric with it, if one were to change, both should change to
> >> the same.
> >[snip]

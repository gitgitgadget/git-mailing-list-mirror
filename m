Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F9B19D064
	for <git@vger.kernel.org>; Sat,  9 Nov 2024 21:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731186672; cv=none; b=posICjGg2QMxT+KSNKc5w6KIE4WUVdzFOVBoQ56BWxaNeZH55n6Vt2yjomo3+DeYG+CHUYX3Ynn9hMm6RCDY1wufMDugKwOmwo1B8qAPaU1KTkrN39lyUT4eyW9JfNXVb6mhYoDNWxKTwDYF1xRJamP8duCSNxeK+1t5OpWhBb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731186672; c=relaxed/simple;
	bh=xK8HQKlIDWFbUoPL7vBjeBeV1EZPhva583793C8Esv4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mm332gMn8+rlHhRx50cJBjQdjT7BxLnXEILtg8nfW77FK5jNGyXmHIq8M2HXqzOzjSY3TYPg5iPzSS7zY0laAoL3jqjY/FdeZd2I22Tm/5g2A9jt6dQjEzTb1QLtEQ4YrTP2YkggMgaHSn8lfXD8Umk7b6DFOMt6B/LShcVSrpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I7G/2sMk; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I7G/2sMk"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2110a622d76so29372495ad.3
        for <git@vger.kernel.org>; Sat, 09 Nov 2024 13:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731186670; x=1731791470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KOpr6ET/oC3DTzxFKx23jTT9VonXm8xMQkCmNyKs44w=;
        b=I7G/2sMkGKfk+qCiTJ0Z+G/knMB/KgRhXnCmP4J3TtA7I/dRhWSQ5k9B/uBxTJP9aj
         +kngrg0r4pKbN155uqpyvfbr51jqSR27SE5d49cHYSm/JQz1axWf3KZvdMgyH6kurYVb
         s0uaKbstBAdSBvCMyd275GHh15FZrG7j/89JC9XWaMh9Szm8OTYe6tZtw9AYBEHUj2gC
         6lWsT1EAfBN8kzcj2BkcSyJ9+MvlSiMZG3dvrjW7pecEKxU55SjuKRmCxyjq6b6htsM0
         nVt1i6RilZVFH4iAgMTjw1Trthcx8H8c/PT5EiRvoDMfMM0QU2fg+FGp/D3bUtFwGoS9
         dABg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731186670; x=1731791470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KOpr6ET/oC3DTzxFKx23jTT9VonXm8xMQkCmNyKs44w=;
        b=R3XzpZiXCEYr9sFuhu6m3SyQHlQSd+5TZ25UqdJ2IhLfCdKlIV/OafH1xGRc1NwW5Y
         FAcx+0MxN0y/gGi9JO/Art3x5dumrb96fjSM4m/8e26CEumas5waL/f2uOgsKzErEq9I
         G4H2Q2UTGAMC+wjJYWdpYFA+tCLwom9bwtOSvMVIJdXEpSajl4Jw46vGTNPfE4xAn66J
         6O0F5GkBPluNAtpBJTpwkRYnn5iYGOsnq8SSVdcdEMxbJM+i6dQY0lxdqLLF4cXgwxk2
         Ax3NPKzFn8AmrgD4JWjQqAnkeqAzSBCqKUiJYzHs+Par4QQPHsG/c75WxmBsQVCoIeTZ
         MH5Q==
X-Gm-Message-State: AOJu0YzsZpwgdHFD6tpFiguMLXIlkZFDX8/7t5AQbrewKyZJwijVylQq
	H0dcHTh2oBTZpYYEaWXXT4v9ZhNnCThJUZh+AE4OQAB9eK0v6Tgil3iJcwmVPJvMmHfNsPnjrLz
	KBH5/EQ+QRJe88RCnS9YzY3F6tHc=
X-Google-Smtp-Source: AGHT+IENnRn2/apMiMUjdb1A4kUQhemlkGDfFZbTIm4nl0MVCVVYdaGDo2Xk2rM/NhFCqnG/gc3/QXrxC0dwg7YjOxQ=
X-Received: by 2002:a17:902:f70e:b0:211:6b37:8b4d with SMTP id
 d9443c01a7336-21183d78606mr91396745ad.45.1731186670116; Sat, 09 Nov 2024
 13:11:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADYnh+Fudpy9kfg8npUMutMjzYNDy-XxJCCJ_9O4kLoB807_3Q@mail.gmail.com>
 <bc028fc5-c0e3-4d31-9790-86bdd3911cc5@app.fastmail.com> <447bb623-28be-4667-b571-935ff7d163d0@app.fastmail.com>
In-Reply-To: <447bb623-28be-4667-b571-935ff7d163d0@app.fastmail.com>
From: Peter Kassak <cache.sk@gmail.com>
Date: Sat, 9 Nov 2024 22:10:59 +0100
Message-ID: <CADYnh+EUNUaTDB9uLSgZkvWGHrpqrrO4XMrjmHzdH-6WXqZLqQ@mail.gmail.com>
Subject: Re: Extremely long subtree split duration
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I didn't compile my own version from sources, I wrote that it was
probably after 'zf/subtree-split-fix', because it was related to
subtree split.

And I managed to find out by trying that the change happened after
version 2.43.0 and was included in version 2.44.0-rc0, so i assumed
that.

Go on and try same split with 2.43.0.

Peter "Cache" Kassak.

On Sat, Nov 9, 2024 at 3:28=E2=80=AFPM Kristoffer Haugsbakk
<kristofferhaugsbakk@fastmail.com> wrote:
>
> On Fri, Nov 8, 2024, at 23:07, Kristoffer Haugsbakk wrote:
> > On Fri, Nov 8, 2024, at 22:40, Peter Kassak wrote:
> >> Main difference (except OS) is git version. On Ubuntu is latest
> >> installed via apt 2.43.0, on Windows is 2.47.0.windows.2.
> >
> > I tried a bit on Ubuntu 22.04, Git 2.47.0.  I gave it 14 minutes and th=
en
> > it was apparently about 10000/32714 done.
> >
> > --
> > Kristoffer Haugsbakk
>
> I tried again and ran the whole command.  It took 3 hours and 43
> minutes.  My `/bin/sh` is dash(1).
>
> I then checked out the first parent of the commit that you pointed to:
> bcf524023e (Merge branch 'zf/subtree-split-fix', 2024-02-02).  In other
> words I checked out bbc8c05670 (Merge branch 'jc/ls-files-doc-update',
> 2024-02-02).
>
> A *split* on that took 3m49s.
>
> --
> Kristoffer Haugsbakk

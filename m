Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89432270570
	for <git@vger.kernel.org>; Wed, 21 May 2025 13:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747834438; cv=none; b=AHdX7xljRklwCBTANshMuOemmg35rWG3eBb62HCBH40JRCJT/KSinNi1Wcvr6cdiTHEOSCqOu8BPlESXGJ3TNLzxdYwTWyHcqvCipJoNXonAs+QPrgLdASmr5I2xhgJP54md4RVF8+nS5ybIf3VGneJUrrUDtMCNgWr1+jc8n3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747834438; c=relaxed/simple;
	bh=NS9gYPeycf7GIoNLi6qBFjYCF6tFH3mRrXLz9yUN/g8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qLJZl3M0XTsukKIzxrjtFZ1bj+5rCfNj5pbEQDUIxLMw/mOaP3lVR5I5xwDd0OoX1VYyxE/pXe2Wj0BT9uDbArOYi9WHYiVT+XTDQNnU+WO/9C+iZ4HUnLrMysBET9vJYcc4cySxxSbk2PoLjIBanzrjETZHLqAl2rejqFfq7xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XhsLKQy3; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XhsLKQy3"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ac2bb7ca40bso1142494566b.3
        for <git@vger.kernel.org>; Wed, 21 May 2025 06:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747834434; x=1748439234; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NS9gYPeycf7GIoNLi6qBFjYCF6tFH3mRrXLz9yUN/g8=;
        b=XhsLKQy35BgdQpwH2E6O8Sn+zsMOTA6ukbTLgFgXYlkdDIj5VMxbT5mdJYcy9djQAH
         n74DrN5yQOnSgevCwet0GZQau9Mgp7rpIu2yp8BawgRJ8AnostlrlmxXbxDtKNPh8+Dp
         qxF9qAhn3L4TmWDZXdFWTkAy0jGA+DnfUyhqknCtl1ObRi80QaZ3d2srrKTC/rD4KjrS
         nU/ycNzWUCbMjY13MaRZjXdSP3Qq0i8FC74LtJoY4U35KfH2B8jBSb92PpPVyo/x67P1
         WhP/kbITtKdJZJ8RhKV+d8BB5IKTnYz0sfMZyG4Y54Wzv8RBwUsCeb6LcdJnTkCo15JK
         XKrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747834434; x=1748439234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NS9gYPeycf7GIoNLi6qBFjYCF6tFH3mRrXLz9yUN/g8=;
        b=EVErPxNO0+34CGe33ZwVoxjBT9Ha8dNFEo6SX5TrZbxkPTq5ddT/k/PeHB2QONwKJK
         KLjuwjBoJgUaH8Aw6zxjp4vyIPi6fOJ8CJEBAvROuOsLcDjvXbjYW1aZQ1pGDyqwe1g0
         1bXG4YS4ly+aK/H01nGVd0L+cDVJNS3/3Xx3L9JoAEc5dDXwqJW9XrJASwwXa2vPcLmh
         QBWZz1zrA4rKpi8peaRydyP4tLhYESEZwizVi1aCrza+F8zj7VlwIU919LzlEW4BFIUI
         +oIR2tbBMaZdaG9F4CG6ATT0E0y7+3/DkrHsWVQueiLEqOR/HwXQvW7Lf+dXVMpURxJV
         9W7A==
X-Forwarded-Encrypted: i=1; AJvYcCUZYMZ2+oq8WsOF1q2TGGBCPzL9ZwXL92SM1YCr/Y9SYsgvcIQpH+XK+GSEZcKWe+S0ZC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM61f8rJUz2qHPZ3D315XC/lhs8DCB8jUTmzRDlac7BZCrGsQK
	qFq9c+TcsaQRN3wAauOXXwIWihnlLxvBIrpFIOkRARwHQiDzm7tEpsHVF2qSODwmWiXIIpdJyik
	twepY4hDiYV4f21mdqjtniSgX1vHXklU=
X-Gm-Gg: ASbGncvAANPMLdmhLABjI5M1ZkfmPCLTJdFZceiDCt6XNkxYlOfU28d4nuRumYMWu29
	anIhvnNitjS05XnHyFA0asslkMtM5e60vMODJ1BYs14tftH9gM3reJc5zun7fz9wPWIMbjSK66T
	56XZ7oCpGV9iH3mezrOMNUHPLNv8tbJmI7VKo96q0ckybDSBPz8uwGkQvXA+iMWeOUExk=
X-Google-Smtp-Source: AGHT+IGZrspc4CXnoGqKk5TCr0sYd0GsqVZbHT0q4PL/wtk4iWRcOBLl9KQdaNPCwnZZ+DJuWJ8oMWIpakx8Uf2Fj08=
X-Received: by 2002:a17:906:7950:b0:ad5:53e0:8dca with SMTP id
 a640c23a62f3a-ad553e08ed5mr1356242666b.47.1747834433599; Wed, 21 May 2025
 06:33:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520193506.95199-1-ben.knoble+github@gmail.com>
 <20250520193506.95199-4-ben.knoble+github@gmail.com> <aC2HJxvrorJdMkL9@pks.im>
 <e5efc450-dfe1-48fa-9dcd-7e0634957e1f@crinan.ddns.net>
In-Reply-To: <e5efc450-dfe1-48fa-9dcd-7e0634957e1f@crinan.ddns.net>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Date: Wed, 21 May 2025 09:33:38 -0400
X-Gm-Features: AX0GCFt2kKZU11WruRsuMxdbMAYdYv7jFU6VHRDd3IdHsjPn66ynvH2I9YSCujk
Message-ID: <CALnO6CDWoOKZ6NHNT_Xh2Jd48cWU=qHkkwYbbZHfYGvEz5LWGw@mail.gmail.com>
Subject: Re: [PATCH 3/4] run-command: prep_childenv on all platforms
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Ian Wienand <iwienand@redhat.com>, 
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 9:07=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> On 21/05/2025 08:56, Patrick Steinhardt wrote:
> > On Tue, May 20, 2025 at 03:34:57PM -0400, D. Ben Knoble wrote:
> >> We only prepare the child environment on non-Windows platforms, but
> >> prep_childenv is the natural interposition point for our subprocess
> >> system to adjust the environment as needed. Use it for Windows
> >> platforms, also. In subsequent commits we'll use this interposition
> >> point to modify the environment on all platforms.
> >
> > What is the consequence though of calling `prep_childenv()` on Windows
> > now? Why didn't we call it before this change? Details like this should
> > definitely go into the commit message to explain why it's safe to add
> > the call now.
>
> The environment prep for windows is currently implemented in
> compat/mingw.c:make_environment_block(). That function is careful to
> handle unicode characters correctly, it is hard to see how that is
> compatible this change.
>
> Best Wishes
>
> Phillip

Ah, thanks both=E2=80=94I missed that it got special handling later (since
run-command throws the char **env over to mingw_spawnvpe without
modification). This patch is probably "obviously wrong" with that
context.

That makes me wonder: per Junio's comments in another spot, we could
be more targeted at the launch_editor family (which also requires a
separate patch to contrib/git-jump to scratch my itch); or, we could
try to push these modifications into both environment handling blocks.
I lack the knowledge needed to do the right thing on the Windows side,
though, so I'd probably leave it alone.

Thoughts?

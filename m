Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE2C3451B3
	for <git@vger.kernel.org>; Tue,  6 Jan 2026 13:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767707099; cv=none; b=Q6T/tC2vFXaeVTj/7rAOqJLbjPBDHH1TSDtfHF1dw8PEDNxIIdUs2ycvhHLqUKpNHhIQnsXx50u3Dq5nupvvBsWk170TSOfujoftgnVxWcCNyWNeGEsI1C8CItAB3BRWgurGADgOGqvIp8DaJhMC98Fxe7H03FCOuKqAGg5y/+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767707099; c=relaxed/simple;
	bh=cFXlbUP2VR/ayjG3geSjeOfwVKj6mkdaMSbpjG9FPOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QW4XsLE/RU3Qv4dW8mn1fhumqSoLmn0C893ScA8eJdqVw5GWxf8u5M89ZHRp8/dFF2s3dr+VgNGLhwb3+2K64JFf2AEuqstb0FWi14pLGSonFqOdBHuHYeWoEo6EGdgrTCNH0OqKWNxSgUBDp0ZvKyLhRV56Ci1cmkFcXJPZG4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eITDoBLI; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eITDoBLI"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-121b251438eso4283698c88.0
        for <git@vger.kernel.org>; Tue, 06 Jan 2026 05:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767707097; x=1768311897; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cFXlbUP2VR/ayjG3geSjeOfwVKj6mkdaMSbpjG9FPOI=;
        b=eITDoBLItodF9CTzb9VSkfgUU7oI1zDoslOczTQsMet4FT04G8etUT+eqxI1f5vp6O
         S9Y0W5lv7F9NwhRCWQfzB97AFNw2v1mUDiQKTdcVajEuzkVpRaYBroCFDCqYpasS1vv7
         sZGaWoX/BSBSoYEEM/getaBiRKXyB3PiW3iO8wfIuUnrsI6zKYjEX50ev9wxGPDR68EV
         6wCVX8qBB9nFds2U4hwGANmKFkHm1eChqX8WrzQJlLJH/oiwFJ4FIag2RTxWDZ06dQMZ
         b9Wi5W2IaD3juLZmAHDJt+/qCHO2Ot1U+oGzqZtnAsjly2QCb0ou5oDBKquyeBrIWeO1
         aN7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767707097; x=1768311897;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cFXlbUP2VR/ayjG3geSjeOfwVKj6mkdaMSbpjG9FPOI=;
        b=oLfxA4MLvrqK4Ja6y9MxgT4fZ6StvCWOVqPWsTiTxT6wu3NGLQLRrCfxu5KbTR07t3
         fGuBuAzswpfb1p96yIzI85lrCk8AFMgeObuS6jE0sZu7Bc8ZHV/60oIHk0E09Yp3/PeQ
         KasknkhO9+ghYO3M1btmGtqKQk0IuSZ5VjMDo92ntP3G1Bwc1gkVmAJYSC7zR515NX1U
         fCFUUXkHCThMCrts/ElVi8fgbkOJKcQgGNW07l+nMgleXxUgmJq9t2tNll9mGZa/pcIP
         GbgPrixL0AuqLTiAEXwud7SZLwwrw+Fkq9pd+uMr0N/bfx/AkODiSjVJajRS8rwrazIx
         zJIA==
X-Forwarded-Encrypted: i=1; AJvYcCU9JmbOJGjpT0Uh1noDJE/YLbBFpFw5ZO5ulULCoWLc3UY4vNFnKm/dvyKUV+E3kZhLalI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTjIN6BXAD6tjVaYVvyQiAT0yL56G3c+bVJTmgVmXvtyl6Baoa
	dQnjuytzDIFNRDmGvogp66UobbGWEjbE7jQQXgiwlPQtAMqSwIYWbr3JdDf2b+dhsPFpfcKrTi8
	w1LBRVO6MTqd1YCefvDjQ78dVd4Hl0+PHIUJ2YfY=
X-Gm-Gg: AY/fxX73Vq/CsiCK4LRI4qbR7VfB7uZSrflU7KYB0Lf/7bGroVvK3OredanXNYwMU67
	tnWwfJVWOMa87yJT1XnpaCGR+ARkeEz5qfQhztsu9NCP/VtxgvN+vfiBDu+ldlseendob76zhRz
	boyBr/BhzWh3v4ASrDD4cSys+ou9/SsPg4ZyKYDZn6OnqrczHqhXUvjnIEfuSqAs42tAnm0hHJU
	OXPMfty7p311FO0ViIu8dt8H7+lVeoFiNiCdPAduWSiF59Br6/HW6mwewLRK3xxAzTrfsRlxh4=
X-Google-Smtp-Source: AGHT+IEHPpE+gsGJqwWyo2yvh64q7oarCwbEgXOGrVbYxMW/fyfoxcT9o273P0UiDi5NgkizxY5B2cLBqy6vHzKyGwY=
X-Received: by 2002:a05:701b:250e:b0:119:e569:f855 with SMTP id
 a92af1059eb24-121f1b1ea9cmr1369728c88.12.1767707096504; Tue, 06 Jan 2026
 05:44:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aVfzMsN2ouY3UBFG@ubuntu> <a881499d-e236-4f8e-a217-b6bce69e3e3c@gmail.com>
 <3947f777-e08a-4c17-81e3-c4711fe666a0@gmail.com> <xmqqwm1vk83a.fsf@gitster.g> <CAD=f0L9BEPSQivgpM7qURT+WFDY-+Ys_M6Knv8hE0JDw4Wjj5A@mail.gmail.com>
In-Reply-To: <CAD=f0L9BEPSQivgpM7qURT+WFDY-+Ys_M6Knv8hE0JDw4Wjj5A@mail.gmail.com>
From: Bello Olamide <belkid98@gmail.com>
Date: Tue, 6 Jan 2026 14:44:56 +0100
X-Gm-Features: AQt7F2rWa2plZ63Svr2FZxD8hXDQlowHzDlJxMamj1p82PWJJtrp2o1ute14des
Message-ID: <CAD=f0L9H5Q=zW02nr11OSBNgFH3UMLwVjVjn3zhgZ2rjwE85WA@mail.gmail.com>
Subject: Re: [Outreachy PATCH v2] environment: move "core.attributesFile" into repo-setting
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org, 
	Christian Couder <christian.couder@gmail.com>, Usman Akinyemi <usmanakinyemi202@gmail.com>, 
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, Taylor Blau <me@ttaylorr.com>, 
	Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 6 Jan 2026 at 10:33, Bello Olamide <belkid98@gmail.com> wrote:
>
> On Mon, 5 Jan 2026 at 23:28, Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Phillip Wood <phillip.wood123@gmail.com> writes:
> >
> > > On 05/01/2026 14:23, Phillip Wood wrote:
> > >>
> > >> It is quite common that moving from parsing config settings eagerly by
> > >> calling repo_config() at startup to parsing them lazily via 'stuct
> > >> repo_settings' causes regressions like this. We really should find a way
> > >> to address that before moving more settings into 'struct repo_settings'
> > >
> > > See
> > > https://lore.kernel.org/git/d61c966b-61ae-4ba9-b983-c8dab6e2c292@gmail.com
> > > for some discussion about a possible solution.
> >
> > Nice, but I suspect it would be an improvement already without
> > passing repository instance via git_default_config() and instead
> > have the code use the_repository; it is even possible not to have
> > any repository when the callchain executes.

But won't this be a temporary solution since the goal is to prevent the use of
`the_repository`?

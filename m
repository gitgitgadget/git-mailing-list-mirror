Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00B5111BF
	for <git@vger.kernel.org>; Thu, 24 Apr 2025 21:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745531955; cv=none; b=g1B/qbCJYE0YZMv/TzeeIMeNrBgITqgS28L0hqijsyAFlkv2Tq8U4O3Rx/duDKQbMdGOVAoaycnFW+L/ELHSKLFf7Z/zGTY8QKiIcg4faYmKW+Sl8VO1HSS0czanqTp5RhIM15lb4a7FcofVR1BL/qBaJnEibW8MFMNdtRygB+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745531955; c=relaxed/simple;
	bh=lTzir4RcwB69MfNJGw3fiqIGYMCb7no/pcBjvm51VOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d7SQnnMx0FKtzb/6VHb36H3N5uU72Lzjdvrr1XEomfaYcpFVWnLeS/lbjzYmbfxZgaodGGLkm/DSdl+ZbulUkp9/puvVU0R84ipgz4Sts1BNzFfUtx+7kylF3FR69eiEDnJ2nZrG6NUDSHJ8TfjaEkRhS/AfAJpgB+jcRAoJIJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LKEKY68j; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKEKY68j"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3d900fda7bdso4958965ab.0
        for <git@vger.kernel.org>; Thu, 24 Apr 2025 14:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745531952; x=1746136752; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YOQaKXUN00o9MzojILRH8riPFV7kWdv9JH3TPHmYv/U=;
        b=LKEKY68jH43i0Mcw0/jdMYptHjqedgHVyGirTfvXkYDgO67TXlol+HjvGAlty1AVR+
         rnoscFmHk/NZPyKIsp6PIkWX87bxwMlPUlfXX5wWGBnoMVt5kwtdeNkEkyVuRPjBI6C8
         Ur9/Qny7t8l9HoVx6dop9rH94qr3uGvsNLPyAFWP/Xowosb0NqPiupyPoTkYz8+TleRf
         7t68KoWXByXvGnHfw1u0bXoCowauJx16sIt8dq0DUr5iwYTQ4ToHHOUNCflVEP9Curwp
         nfOwhhqotm7xBcw7ScbPd4nh0STWHj8bM4TCcXIH85I/yf9icEl0Ex60UMsS1pZS1Eo6
         fpmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745531952; x=1746136752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YOQaKXUN00o9MzojILRH8riPFV7kWdv9JH3TPHmYv/U=;
        b=i6VTTHlX3P8R/DisvNd3jLSB03JL2UR6/ydRDginUps3vmZMRHkPeT8bp3ZVTCWEIa
         2W9TZgshjrLLEcR0FLfLF5rM8uC0uLUi1lVKNWCpslPlSb9VFK+QPN8Nqet9c48LYO0b
         xe62A6fVaHQH9kIfCyITfPI6NNhC1kOIKoVTN6mG9RXoV3Sb3ig2IxvTWp3xfg95+jN5
         63OOnD/7rjPlgd+oPQQ/7gwBUA+C8CPmQ9XZSbl9tHgzMnlbgTyJTo6Ia3V63KOAqazh
         8oaxRLxe152VpHOCPDG9H3G4mX3Y6ITYfkSAkSJZZQCtYEI54ff+3B9UE8QRBQy3a9f9
         zJ9A==
X-Forwarded-Encrypted: i=1; AJvYcCU7VXBEdBwoEygufgC5cqmls4EL1j7Re3LxZ5kb8CTjt1YP0OaahKr7Wft//wIrDafLD7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRiVEI1Ai1W6ehNg+Ijd73l2H6R4c7yyeI82Xi7bL7+Tq5Z7Sx
	fpeUWBbacJvdGCiCH/Br/jNs8h4g6YL1gMCWj5J4JmMpkLxJmIStco2KHRak82PrfZUEW0w03jq
	jhCNVfAuKJ5dsxkAOD5Wna/t2icY=
X-Gm-Gg: ASbGncsYdcLLMLkt/t5436tM+P5fCXxOL0naboEwGZ0ScEl56khZFdedQFLPiYHcuG8
	UVzCGrlSFWmGqnFRdbgoUmFwCKvmOFKkibDpc7ZI9xXtR+t8NYA/DuIb8ABcR5AKQ+k3ulxv8Lg
	nnt4T0dVyhzelM1SWJOFl2ubTvwW3EGcMLHU25VGOX5k9kYb1Q8oq94Q==
X-Google-Smtp-Source: AGHT+IHvtlyVlFDAPoLurOmnp7FR7CNKIeCXuz2+WUQ6RJV6s7og8hQoCiQKSgRn7jQyQ0+H/22+oG2lUqSPLJJaSnc=
X-Received: by 2002:a05:6602:4086:b0:85e:a8db:fa10 with SMTP id
 ca18e2360f4ac-8645cc81093mr9207939f.1.1745531952656; Thu, 24 Apr 2025
 14:59:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424203904.909777-1-christian.couder@gmail.com> <xmqqselxtfyf.fsf@gitster.g>
In-Reply-To: <xmqqselxtfyf.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 24 Apr 2025 14:59:01 -0700
X-Gm-Features: ATxdqUE_VAvjGa5_DarWY5FFumRMkTdIrndwRR4H0-GnR7d-S_a2wtUL8G96RPo
Message-ID: <CABPp-BHudzADoYdBvoBZ1yDRj7Ra_V-or6ddAOV6nmXeMMpMaw@mail.gmail.com>
Subject: Re: [PATCH] fast-(import|export): improve on the signature algorithm name
To: Junio C Hamano <gitster@pobox.com>
Cc: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 2:19=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
[...]
> >
> > This is a follow up from cc/signed-fast-export-import that was merged
> > by 01d17c0530 (Merge branch 'cc/signed-fast-export-import', 2025-03-29)
> > and introduced the support for signed commits.
> >
> > The format that this series implemented was lacking a bit, so the goal
> > with this patch is to improve it and handle signed commits a bit more
> > consistently in the code base. It also shows in the tests and in our
> > documentation that SSH and X.509 signatures are supported.
>
> Thanks.
>
> It is a bit surprising and slightly sad that nobody bothered to
> report/complain about the brokenness until the original author
> follows up one month later X-<.  Nobody but the original author is
> using this feature?  I would have expected that use of signed
> commits were of high demand and many more people were actively
> interested in the topic.

Signed commits may be high demand, but we do have the intersection of
signed commits, usage of fast-export/fast-import, and using a
development version of Git.  I suspect that intersection is somewhat
small; my guess is that signed commits tends to be associated with
large enterprisy things, development versions of git tend to be the
opposite, and fast-export/fast-import are by design infrequently used
tools for any given repo.

(Also, not sure if this helps, but the original author was Luke, not
Christian; Christian was the one who came by three years later to jump
in and polish up the patches.)

[...]
> > @@ -2830,12 +2831,15 @@ static void parse_new_commit(const char *arg)
> >                       "encoding %s\n",
> >                       encoding);
> >       if (sig_alg) {
> > -             if (!strcmp(sig_alg, "sha1"))
> > -                     strbuf_addstr(&new_data, "gpgsig ");
> > -             else if (!strcmp(sig_alg, "sha256"))
> > +             if (!strcmp(sig_alg, "sha256"))
> >                       strbuf_addstr(&new_data, "gpgsig-sha256 ");
> > -             else
> > -                     die("Expected gpgsig algorithm sha1 or sha256, go=
t %s", sig_alg);
> > +             else if (valid_signature_name(sig_alg))
> > +                     strbuf_addstr(&new_data, "gpgsig ");
> > +             else if (!strcmp(sig_alg, "unknown")) {
> > +                     warning("Unknown gpgsig algorithm name!");
> > +                     strbuf_addstr(&new_data, "gpgsig ");
> > +             } else
> > +                     die("Invalid gpgsig algorithm name, got '%s'", si=
g_alg);
>
> Hmph, we used to have special cases for sha1 and sha256 but now we
> can handle sha1 with a more generic "valid_signature_name()" logic?
> And yet we need to still special case sha256?  Not that I trust the
> old code all that much and take deviations from the patterns in the
> old code as a sign of something not right...
>
> The fast-export stream produced by the code with d9cb0e6f
> (fast-export, fast-import: add support for signed-commits,
> 2025-03-10) used to identify a signature algorithm "sha1", but this
> new version of fast-import lost the support for it, and will barf
> when seeing such an existing fast-export stream?  I am not sure what
> is going on around this code.
>
> I am not so worried about the other case, where the stream produced
> by fast-export contained in this version may or may not be readable
> by an older version of fast-import.

I certainly can't answer anything here as I know little about
signatures, but your comment brought up a different question for me:
Given that d9cb0e6ff8b3 (fast-export, fast-import: add support for
signed-commits, 2025-03-10) isn't part of any release (not even a
release candidate), do we need to have backward compatibility with
that version?

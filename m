Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD55645
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 00:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741911911; cv=none; b=UtAL3y4Mye5Y4VlT7oeufRL3anhShiOl2sl2u1c1MWWT17h/k3ZOew4bveLAdkT5ZM+9Kt++ftxjXRvXo4c37sQckKxYdaVaGB8hB/5N/m57peKeq79dvb3JZXS+uVWlpe2BW4MkuG6sc/0im9mkwGJ8Imm5jDAS4uLHJ847/RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741911911; c=relaxed/simple;
	bh=2PP6jd9nubwXj0eeOgqpQy04rod2gX8XMm7R4sWdxW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sjfbTF/yNn5jGgD7QxpIENFXMfduz5NicHvSxfFgxvUotyBDtWms1RWmco425cnlxjay2o2qcbYlSPLUiXYdMZXSAuqeSlTx4sgVBH0Yvsk7szqvARyWRUT9Au6hP2/GKEawjkyUEkVCkcbmljHt/695m+ZBmIfWgdcr1IYbbvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lf4hyhw/; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lf4hyhw/"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3d03ac846a7so5549485ab.2
        for <git@vger.kernel.org>; Thu, 13 Mar 2025 17:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741911909; x=1742516709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j5hqtG84zN2YaFW6sm3IKhClnq6AYGBtlYmzlLWRXUE=;
        b=Lf4hyhw/ti3F8VKmfF8mstZlc9EpiQZ2Ilf0Ih01U0y/CHiFG5tKlERtrU6D8xMR6Z
         3kVhUyOKMhb9VMHcMIXowZe4VpnmKfRpnEx2njz8bpqMqoUnq4f345ZPTn4oi9KjvVjs
         uWEGjsyIb47il54c81vbCM3taxv+rJMLCc7IKeSi10yVLyedLrJ7ijKk1LQ7h273Evby
         9tRrm9QVPAd6GQwi51wo4Qf0Owg6/heX7+Qqphb+1r0nFG/NWYkXCxbQBan6Uw41V1Hx
         9e4B5ywU9bqtnwHcKD/MMtLMxA+XsW55frmfi/+OH4WKjl6p5NU3EwVGtLXQNkEKnE/k
         v2FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741911909; x=1742516709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j5hqtG84zN2YaFW6sm3IKhClnq6AYGBtlYmzlLWRXUE=;
        b=n7bDXUXH5svGOe+BUjZFN0OBjuU0A31SL71eyuEaCXibjDYyb5g2nSzi7GNQ+9wBFc
         w32aHIhg/VjUG7i5n3tNCEzDG/eGUWpyj7twc6LlBw3I5a6wfzbsJrY+Ld5582OcayUr
         OTK1M4/sN/Pze2+L2+PkngQ/b7mNnvnbLMqmD6mr7F0N79xTWIac6SKtnC5iFRGnr/Cy
         Pnlcuc2EHro/1qmXcUQeiZE8x8gfHatfbhIRE8RpouxMwJahn+Umlc1P88XYB7QuYsFj
         watS32/fMLMM4ga/OEPHNgAfYDIxkfn+GWlHhGR7lr6xqyudGizqFHga91mgL8RVyWTT
         aYlg==
X-Forwarded-Encrypted: i=1; AJvYcCWhYBbLIH3cHqqulUZwaDM6GPSVdDXhpssIsm8Ov05vkf9cC6tEzcsP2bsqvsu2IsBkeP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLn/M7RVlm/BuiIbUT5W/A4aS68MfVq9G/eGEUPLwxiganOm0T
	wbNHtkR2xuE1C4MUQBAIxv0LfzNf+Utb60HpwjF0X58jv99mq8I30/kYTSEuWSh2BzCNvH2ad43
	G3bBAWSLEcywVwn52JjUvzQ3TdzM=
X-Gm-Gg: ASbGncvFcYnYMuHf8rS6uOwgiXz13pOclAVALokwyEP5ZTEA1Hzb2Rnx7huCeRhtxS0
	QRRERR//Z6DAy2x9u/gFyJ/LILBwFkeAewR6e+iK47vcQs54299YJni6PpWCV/fqXTUBh/uqDU6
	GidAj0hZfp/NWmN/CGBL1nbyDlAGvJMOYueFjkOm7SW8PO5y30Kbt9xE2cr8rYNqzN3jPspQ==
X-Google-Smtp-Source: AGHT+IH/zaJIl0MI6upbjkGLygoLjeAs9+31741i8ahkUSF4Oe7lLRxjq4fP5Ok29/M0TWNVsdnOQTsfhL71zn0k2FY=
X-Received: by 2002:a05:6e02:1a27:b0:3d1:78f1:8a9e with SMTP id
 e9e14a558f8ab-3d483a80000mr4301085ab.20.1741911909141; Thu, 13 Mar 2025
 17:25:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1873.git.1741275027.gitgitgadget@gmail.com>
 <f48b3310d4ae8d05780fd25e467083c4dc9852cc.1741275027.git.gitgitgadget@gmail.com>
 <Z9ID/2zx25qesuJs@nand.local> <CABPp-BH+9JcP6FDP6RFQzZbwW=XOWnWAR8PmrCS6hG4iyd2pPQ@mail.gmail.com>
 <xmqqr031x2gg.fsf@gitster.g> <CABPp-BF7iTvqKFvuOZ5wZ3vZADjCvB63iKR-4D5+WeTxnZGThg@mail.gmail.com>
 <xmqqbju4q39j.fsf@gitster.g> <CABPp-BF01a8bEZ2mfp7H_=HKsv6mSE4+ee8bi9D9xKWbH=0b5g@mail.gmail.com>
 <xmqqcyekok4g.fsf@gitster.g>
In-Reply-To: <xmqqcyekok4g.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 13 Mar 2025 17:24:56 -0700
X-Gm-Features: AQ5f1Jq_IYFQOur_ZN3SQqnAO_PPT-KUx9ogQTOwTjorMmYJb3zzKAtGYUzidUE
Message-ID: <CABPp-BG-7RYskvG6K+gYYNQxqRkVSQYLPvcFaFaT3u-w3bBrYg@mail.gmail.com>
Subject: Re: [PATCH 2/2] merge-ort: fix slightly overzealous assertion for rename-to-self
To: Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <me@ttaylorr.com>, 
	Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Dmitry Goncharov <dgoncharov@users.sf.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 11:34=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > "if (condition) BUG()" is invalid; it needs more arguments.  "if
> > (condition) BUG(something)" requires a separate "something", which
> > requires awkward additional wording and/or is needlessly duplicative.
>
> Ah, obviously we differ on that point.
>
> I consider it an advantage that <something> can be more descriptive
> in a developer friendly way than <condition> expression alone.

I think there's been a communication disconnect.  I too like "if
(condition) BUG (something)" and often use it, as I pointed out
earlier in this thread.  The fact that it _can_ be more descriptive is
an advantage in some situations (and you provided a great example.)

The problem is that some situations !=3D all situations, and I find it
worse when trying to force it for all the other cases.  If we still
disagree on that point, that's fine, but I wanted to make it clear
that I am a fan of and use "if (condition) BUG (something)" where it
fits.

[...]
> > If you don't want to see assert in the codebase because of NDEBUG,
> > then obviously we'd leave NDEBUG out of BUG_ON().
>
> Absolutely, because the largest problem with assert() is that the
> condition can be compiled away while the compiler does not help
> ensure that the condition part is free of side effects.  If we drop
> NDEBUG, that problem goes away.

Or we can just add a static analysis job that will error whenever the
compiler/linker can't prove that assertions have no side effects, and
suggest folks use an alternative macro for those instances.   I just
submitted a series to do that over here:
https://lore.kernel.org/git/pull.1881.git.1741911652.gitgitgadget@gmail.com=
/

That should be far more thorough than any CodingGuideline at making
sure we don't have asserts with side effects, be far less effort than
attempting to change our several hundred existing assert() invocations
in the code base, and should be enough to consider the problem solved
and let us move on to something more interesting.

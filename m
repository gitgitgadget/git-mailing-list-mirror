Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53ED21DF265
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 12:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758804368; cv=none; b=kIJb/ZOg9t/1qjv6e8e+nOGNsWtuS+SiBkF7np/SsX5AAlVb/25gn58DFCgP1aiSLbn4LXe8hrJjvCl/b3/aLOs/i9M848XONJOxLz/RSOGlo8QCgTML4pCX8D419BKow5zCzcpIgiCYYBrsQhf7HG+w0WqWhpbd5GvTF0jz554=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758804368; c=relaxed/simple;
	bh=2nTIKmm+FqpGHAYR08MsW8Nn1EIOqTvkF38m63P4pmw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BnXgJ44mXrsgOk2DsZW3RhgOrL6oGqLvsWH0txxjnGELDIeXAODH2Q5zvWy5fz6VaqTpAWqBTZPOGxW2ML694lFCvk1ZlAlRQk94GvDQ/R8yOy4qRSacvAUZHbxaQqUqS/7g0YSJUBJrnkLf+oUGAuO0oSSDURjpxVzSJPP4MHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PcNZ4xLc; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PcNZ4xLc"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-36a6a397477so9228131fa.3
        for <git@vger.kernel.org>; Thu, 25 Sep 2025 05:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758804364; x=1759409164; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u0SBX0ksJ1fQKrvBntTvoe3iiOWKcQ/a/lA8BcqnPNQ=;
        b=PcNZ4xLcuVvcDQ4+07aM5xNS5+oEdb2MuPV4RWIUIVtwtehD3tdY6ezkNg/JsnG7q5
         ZOe5hAkVvctxKBAQ574zHdeaUVNUe4+DjfdqR/fK/f1K94UigAJRGhNgWDKa4LiZIW55
         kV9qZp65OiFJ907MmHGn0nM6h+iYhHsoZJKl0iDRCJt7bZ5hMXMe8MBV7/+ltmCDsAN5
         V30AfRpvAffukhgxjf2jyHVciJMrC2Hd2aEDg1cfaxDdHTSc91ZW+cMRd5tf6s5W5lLq
         KnX4uqsk5Vjaw9F7zNyIDsQFHSIHP/YvNwswiCJgSkyDD7O0A0VXd5mLQkEJnAdRKx3U
         SVwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758804364; x=1759409164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u0SBX0ksJ1fQKrvBntTvoe3iiOWKcQ/a/lA8BcqnPNQ=;
        b=kILgbbWsicfXerB8LThcMIOTPm3ihnn7TEytkldsyaI5hqHyMf0B2sxc332yk+Y+in
         DW6wes/VHx9EUS2XMI2RW5fCwsvrp4txESROAWPJJWLWQgQ0f2M+juAfM8/0KXhB+86c
         t+Dkgwm40JD2RZ9Eh1RJJQ4fe6Xb0cQZs9nm72LLHnN2zPA7imkrmoWys2byKB4R5KmV
         NyDsEy5KAwdfl55Gqx41OCdR0rN2b8kepBGSANzGyl0LoSgHFV3akcQHfHisZiamKn7u
         xlIydg2pc7juLfR689tQf4xX+UHNCLzfcJV3oGyVrYa2TfUmMV7mZuLgdVG+5JI7wj3r
         5BtA==
X-Gm-Message-State: AOJu0YwdOopjAf3o7MkD86Asj7Lhs6splnwLPl7NmZuwjdqHI5S/uTsG
	JCtNexYOwNYIrGsT8Pv1ChDrhXxHTzIGcJN4bjgiMyIMXTeb4Wui3lZC3Yylx8Jjuw/PtbY4YAg
	xE4gvqs2i4WhBCImMEi/twHsul9fXAeVUFAyoWog=
X-Gm-Gg: ASbGncsnp/pwA+o1vb534k1kNNc78wKUrRR5wWjdhvpylLHtucTibdF8Y1+fOu55563
	2PDdyW87E/ibrZs9YxV/1H2sYN0bfJ1V4H07O2/EspCu9UnOuwQW5dLUGftrrvlCrLjjvzcEiiy
	cMAAzjbdx8LhSfa86/sguzkWps5bkNA9MCbeFEG+LzJo5riRp6W9VsY24zjmrQaAzCQrrcKmhZ4
	1UR3KM=
X-Google-Smtp-Source: AGHT+IFP21ypVNSmYL6YLa5DDsfLvfvOJXWeIaWAV5uR8FGXMt3J3gqBpLKBbY+RTb+NAEQmjGYxEu1q6yMbqnV6jO4=
X-Received: by 2002:a2e:9a12:0:b0:36a:878b:6e2c with SMTP id
 38308e7fff4ca-36f7c9e7f29mr10504731fa.3.1758804364145; Thu, 25 Sep 2025
 05:46:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250920184007.26183-1-rappazzo@gmail.com> <20250920184007.26183-3-rappazzo@gmail.com>
 <c6a33014-5d87-4750-b6ce-234e944131b4@kdbg.org>
In-Reply-To: <c6a33014-5d87-4750-b6ce-234e944131b4@kdbg.org>
From: Mike Rappazzo <rappazzo@gmail.com>
Date: Thu, 25 Sep 2025 08:45:52 -0400
X-Gm-Features: AS18NWDWpnw6-n8bkvzPiVABXqD4NtHHEdIvAU9skvYX0sb5CY7IWEYhrDeM0AA
Message-ID: <CANoM8SW6gsfmhPYWq2_7f9DuwyQ4vVpbWkaPn4mDTg--LAZUJg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] gitk: make Tags and Heads window geometry sticky
To: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 2:34=E2=80=AFAM Johannes Sixt <j6t@kdbg.org> wrote:
> > @@ -10249,6 +10256,8 @@ proc showrefs {} {
> >      bind $top.list <ButtonRelease-1> {sel_reflist %W %x %y; break}
> >      set reflist {}
> >      refill_reflist
> > +    after idle [list manage_showrefs_geometry $top restore]
>
> My thinking without having debugged it is:
>
>  1. A Configure event happens with the default geometry when the window
> becomes visible. This records the default geometry in geometry(showrefs)
> by the handler that is bound in the next line below.
>
>  2. "After idle" the geometry is set to the then-current value of
> geometry(showrefs), which would then be the default geometry and not the
> one restored from the settings.
>
> Why is it not necessary to encode the now-current value of
> geometry(showrefs) (the restored value) in this after-idle handler? IOW,
> why does this work?

When I was testing this, I used MacOS, Windows 11, and Gnome (Ubuntu).
On Mac the call
worked without the `after idle`.  On both Windows and Gnome, it needed
the `after idle` for it
to work as I expected.  I'm not sure exactly why.  Do you want me to
try to adjust this?  Do you
have a suggestion for it?


> > +proc manage_showrefs_geometry {top action} {
> > +    global geometry
> > +    switch $action {
> > +        save {
> > +            if {[winfo exists $top]} {
> > +                set geometry(showrefs) [wm geometry $top]
> > +            }
> > +        }
> > +        restore {
> > +            if {[info exists geometry(showrefs)] && [winfo exists $top=
]} {
> > +                after 1 [list wm geometry $top $geometry(showrefs)]
> > +            }
> > +        }
> > +    }
> > +}
>
> The two branches have no common code path. What is the rationale to have
> a single function with sub-commands instead of two distinct functions?

Yeah, that's my bad.  I started with something different, and whittled
it down to this.  I'll adjust
in the next iteration.

_Mike

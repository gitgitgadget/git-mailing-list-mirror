Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA8133E1
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 02:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707792525; cv=none; b=rE7prQ2JtmBTI7CRBQSkH2XetwdAlgneWbt4FB8Sf09FFICWNai5dXvADLkIVp5u9+XDjmpF/lRDkE7Qd7HmMqVVha4dhVWm73lrLc2+O+2//vhWXHdXvCzwiL2mV2NicZYyOEyGG80/ASSD9KknYKTJwRc13xP3zCoQf4pKCWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707792525; c=relaxed/simple;
	bh=p8pjSLJSr9e/rd5t4s7ub5GLezIzQpZxPrGkveWxrp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=psKA8Hr9PUDa2hqApC6T0HW5Cq6HwLJuZjAw9KhexGM9METwlcwdtCyoGwkQub/huiS5sfLkET3CPeixIIifGnYYJVBlflxk/Lpkkw1gpucKXkK0Z9Q4/C/pI9sM3YcA/u6y6MAdtuLXrj7a3qx1IS4gnTGmA3X5cExwVhrgwGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0dfmeZHr; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0dfmeZHr"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-55ad2a47b7aso620554a12.3
        for <git@vger.kernel.org>; Mon, 12 Feb 2024 18:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707792522; x=1708397322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NMuLmFYrr146KyuiNyb7xysnUctSlTSZ3bXl82K1LOQ=;
        b=0dfmeZHrUg3KzNwTC+erw4RQYtbpUpJ9tODITjW69/dG8JEVH9+nUrAOPvPHHQCSbn
         sHQpq+dCbzyQdeupwEPCKnYvas1pGs+2gOKljpaG7Mbo47iVCcGT5WPaQACSucIwM7D4
         Vw7h/iN8f6iiz6Sw+gnjoEmedyVwBGdRN7YCDo2Y0dVCxT15AK1XNvpY7VuR9Mpr+oCu
         CJBysQWxh+JIStLwViW5Unrgg4umLbvDuBfSCwN4NwO0m+HtKUqXzg30rfzG4gYYwH63
         bbBRIlNh6nv9p3+a04bBqV0MPU6AxcIDWBPCywyVgejMPX/T4Fu25lPuOvqrYuNIWRZe
         IZVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707792522; x=1708397322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NMuLmFYrr146KyuiNyb7xysnUctSlTSZ3bXl82K1LOQ=;
        b=xOIINMJTMcCaYmGBdKo/51z+Ibea2Syvf+Mv3tRKqpXE36WVU1Zik0EA5lmIRf7M6O
         3QMWMrzMpX6XgyjxV3ugXrKQcJKeGxz6EVdvYfViNmzbB4zhpKJLONq07rb0pz00nmbh
         oPxlx/WdshrQ0qPe32er+wlt7UV+ENlSmjr14f6Sf5g0h5MbOgFyLxtaIHKFQiPYx3G8
         dxBN5CYf/hxdQh776UrpZ9Z8Dtxzi7lWmbK6a+RJMeEo1KdPJeakj/7wDaqvbQnzrYnA
         zgt03w9Y+5SQZOCBS+9FX8gx8tCq6FMLWscFb7U/5VyFIvTeQeG4SWA/n5cFJkRh64OJ
         sL9g==
X-Gm-Message-State: AOJu0Yw43ZOPCIp4k4e/F9Ao7UzBVsL3Mwwo5aErUPe2uWKo/Z9dsPCJ
	/k5KUZBsxoBseYw/NIa8qm9gOHb1clKHu983dkjOjGqGNLitYecmSY0DdPUqxgxP53CVDam89i4
	oZTxQrLKbQbj1ud0ZAVU3GLEIIvZGVRMg9RT9rScmvHJcP8HIsBCI
X-Google-Smtp-Source: AGHT+IHdczrMAC4DSdCB8BI5vjgMRf2e5dcDuE+QYrc3VGiyfnMEhYq3teSA9Dp+WPxXvq8FbmATuucPvkVZ8L11Krw=
X-Received: by 2002:a17:906:cf9b:b0:a37:4765:658 with SMTP id
 um27-20020a170906cf9b00b00a3747650658mr4951060ejb.34.1707792522285; Mon, 12
 Feb 2024 18:48:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAO_smVji5aGjx1V-EGbumRRpOuGY0SkXZUn9g4LxKmMO3aw=Sg@mail.gmail.com>
 <xmqqil2ximxq.fsf@gitster.g>
In-Reply-To: <xmqqil2ximxq.fsf@gitster.g>
From: Kyle Lippincott <spectral@google.com>
Date: Mon, 12 Feb 2024 18:48:26 -0800
Message-ID: <CAO_smVizKLL2NHFBpszJn+ieJhCEZyvvOT-BWv6Oz5pGiafPVg@mail.gmail.com>
Subject: Re: libification: how to avoid symbol collisions?
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 9:10=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Kyle Lippincott <spectral@google.com> writes:
>
> > If I'm right that this is an issue, does this imply that we'd need to
> > rename every non-static function in the git codebase that's part of a
> > library to have a `git_` prefix, even if it won't be used outside of
> > the git project's own .c files? Is there a solution that doesn't
> > involve making it so that we have to type `git_` a billion times a day
> > that's also maintainable? We could try to guess at how likely a name
> > collision would be and only do this for ones where it's obviously
> > going to collide, but if we get it wrong, I'm concerned that we'll run
> > into subtle ODR violations that *at best* erode confidence in our
> > library, and can actually cause outages, data corruption, and
> > security/privacy issues.
>
> If you end up with a helper function name "foo" that is defined in
> our X.c and used by our Y.c but is not part of the published "git
> library API", we may want to rename it so that such a common name
> can be used by programs that link with the "git library".  We may
> choose to rename it to "GitLib_foo".

If it's internal, we may want to name it with a different prefix than
GitLib, if we expect the exposed API of the library to have this
prefix, just as a signal to readers where the internal/external
boundaries are.

>
> Do we want to keep the source of our library code, which defines the
> helper function "foo" in X.c and calls it in Y.c, intact so that the
> helper is still named "foo" as far as we are concerned?  Or do we
> "bite the bullet" and bulk modify both the callers and the callee?
>
> I'd imagine that we would rather avoid such a churn at all cost [*].
> After all, "foo" is *not* supposed to be callable by any human
> written code, and that is why we rename it to a name "GitLib_foo"
> that is unlikely to overlap with any sane human would use.
>
>         Side note: if a public API function that we want our library
>         clients to call is misnamed, we want to rename it so that we
>         would both internally and externally use the same public
>         name, I would imagine.
>
> The mechanics to rename should be a solved problem, I think, as we
> are obviously not the first project that wants to build a library.
>
> If the names are all simple, we could do this in CPP,

At first I thought you meant C++, and I was like "Yeah, that's a
possible solution: when building a library, compile it as C++ with
name mangling, except for the symbols we intend to export!" -- this
was not what you meant, though. Kind of amusingly, that idea might
work, and might even be maintainable once we got to that state, but
getting to that state would be a lot of cleanup because of C++'s
stricter type system (`char *p =3D ptr;`, where `ptr` is a `void*` for
example; maybe this is a call to malloc or similar). Since the git
libraries don't exist yet, there's technically no worries about
backwards compatibility with requiring a C++ compiler.

> i.e. invent a
> header file that has bunch of such renames like
>
>     #define foo GitLib_foo
>
> and include it in both X.c and Y.c.  But "foo" may also appear as
> the name of a type, a member in a structure, etc., where we may not
> want to touch, so in a project larger than toy scale, this approach
> may not work well.

Glancing at the tags file, it looks like there's a small number of
cases where this would be problematic, and they're mostly things where
there's a function named the same thing as either a struct variable
storing the result of the function. So it could work, but there's over
3,500 symbols (if I did my filtering of the tags file correctly) that
are not scoped to a specific file (i.e. static), or
struct/enum/typedef/union names. That's going to be quite annoying to
maintain; even if we don't end up having to do all 3,500 symbols, for
the files that are part of some public library, we'd add maintenance
burden because we'd need to remember to either make every new function
be static, or add it to this list. I assume we could create a test
that would enforce this ("static, named with <prefix>, or added to
<list>"), so the issue is catchable, but it will be exceedingly
annoying every time one encounters this.

>
> "objcopy --redefine-sym" would probably be a better way.  I haven't
> written a linker script, but I heard rumors that there is RENAME()
> to rename symbols, and using that might be another avenue.
>
>

I'd thought of linker scripts, but rejected the idea due to
assumptions I made about their portability - this could be mitigated
by having a linker-script-generator step in the build process, but
this seems difficult to maintain. It also implies the same maintenance
burden as the #defines, where when introducing a new function to X.c
that is called from Y.c we'd have to edit the list of "symbols to
rename".

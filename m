Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391833DABF1
	for <git@vger.kernel.org>; Thu, 30 May 2024 06:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717052149; cv=none; b=AablFx/3Fu3Nr5JDlQdnLs7VhsC1xVRSftqigekkRi0RGBMfzwWf09dJV+Q0bXSW6StLFMayfY34GsyWgi9m4VdYL40IpwZu15zAH6w0vr+9Z+q6Szesw16+IS0H2MVGlxFE6EQTdiQqpsst+vJx1Jef9S6GjaVe/WiB6+x7AOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717052149; c=relaxed/simple;
	bh=fgh9C7Cv4LkIhlT+szi9xPPVEKbqBrvwyBwWroz7zV8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ahqu/VElgtRrHMYq1bRqYRPN2D1IdXU9KPjBP4lYiMcS0//RtFOy73XWOjwWJohXyWatibofIbDQ+ILz4WQTeTROr6nv5yDXLJETBnEDYXm7YQ6GQGtH5bHR51W+feZ3eE0RADKjZuRHSW5Xk9xxszZkg7irzxjXQgyYc/sK5QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RzqYvfHR; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RzqYvfHR"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57a183ad429so476903a12.3
        for <git@vger.kernel.org>; Wed, 29 May 2024 23:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717052146; x=1717656946; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QQKReMq0EG9Km9mK6L7vJOVENiJkmXiPiGADeuMcQ38=;
        b=RzqYvfHRUtvHE5NnJvWWNRZzRgEMl8PIR7NhyAIvVvfihp2Q4c83yjisKNuVBtX+Mx
         9OgVVDLGZq08XTMJ/ZVFhPV6GIdV7XLdjiSKmqmnWaTbtgMDM81wxKmwUR/valgRhcJz
         p/MoiiTiVAZ0IsZjw6Qy7zfIF9pCtXftZdR/ulLx7/Qbkid/W30VP7ImafLvYXLm3wwb
         UVHHyS6Nrkb+uo2OfBE6Bcw2TW4Zgmh/4vyW4tTqiF4/JTAGw6upr1D2a53oTSIEdXs2
         9HBDWgBsOWO/s8kM+b3i/wiUtVUp32nv/LIAsPUL9VvL3zTZd3CBYQzTghKZCaGakd2t
         sDiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717052146; x=1717656946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QQKReMq0EG9Km9mK6L7vJOVENiJkmXiPiGADeuMcQ38=;
        b=dBn078tpcF2KLBm2yqXGz5CAVsToEXwgDKOmv0lBBlXdxqgm/gr5aoS+7/WBz8Boju
         33tFPPf48V2dy+gEZ9oSVaNFtQ5fd0oL48E+GLf8v2w7g5ltPwepVRPXkVzU86rX9P4L
         nj83i35ugabmsFRaY8KPKYVCxWL/C7QF599Wsk/OlOOqxGwJBZ4XdMWPLSZd1QRfkt8t
         DAKKHGj5TkqfaEa8YWELARtxKwPIoZtQMF+Hwmy3UDQaSvGxSil+v0I4gncSKEI7Nm+5
         SjSiSZIscCqdd0Z5OS0Di+P1uxUbl5Y/C/ezK4SZK3pG1Oe33oAQIeFRnh1kRw7A/Bzz
         ZuNw==
X-Forwarded-Encrypted: i=1; AJvYcCWgKtDKrJ2Dcl+nxJMr+NX0Txp1jXHGDsHb9j3qOuUQlwat5Yy6QfMfaVdVPzQha0Vq9ZUwOBGPfl4Z0gRHmJAeu6h4
X-Gm-Message-State: AOJu0YyUH/z778CCCRpGNdrljOZEVhTz/L9E8cA/jhbCrJT0D7Tvuz8/
	6IXULpRMu6W2exiUPI5fuNIaJ+5LqToskhOPMdrMGrgcPseJ80/OYI/dmVIvym/JW9bXJL4xN+W
	cG/lw08m6UUXhdZLvk34Ttnunw5oj+nbW
X-Google-Smtp-Source: AGHT+IHfCSxfiWXtbQBxqbiJw3LX07yyniCxFvPYLm8hgPY190kqdfKm/WTnWQkPNPm81qMJ2QJfTb8rJlLt6uS3LDw=
X-Received: by 2002:a50:a68c:0:b0:572:a7fb:b6ad with SMTP id
 4fb4d7f45d1cf-57a177cf23emr790884a12.5.1717052146386; Wed, 29 May 2024
 23:55:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528125837.31090-1-shyamthakkar001@gmail.com> <xmqq8qzsuwh1.fsf@gitster.g>
In-Reply-To: <xmqq8qzsuwh1.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 30 May 2024 08:55:34 +0200
Message-ID: <CAP8UFD1YVyZj-uGfGXp6UxMfj3kZC5XXNed-5s-jj=ROx4URnA@mail.gmail.com>
Subject: Re: [GSoC][PATCH] t/: migrate helper/test-example-decorate to the
 unit testing framework
To: Junio C Hamano <gitster@pobox.com>
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>, git@vger.kernel.org, 
	Christian Couder <chriscool@tuxfamily.org>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 11:41=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
> Ghanshyam Thakkar <shyamthakkar001@gmail.com> writes:

> > +     TEST(t_add(&vars),
> > +          "Add 2 objects, one with a non-NULL decoration and one with =
a NULL decoration.");
> > +     TEST(t_readd(&vars),
> > +          "When re-adding an already existing object, the old decorati=
on is returned.");
> > +     TEST(t_lookup(&vars),
> > +          "Lookup returns the added declarations, or NULL if the objec=
t was never added.");
> > +     TEST(t_loop(&vars), "The user can also loop through all entries."=
);
>
> These tests as a whole look like a faithful copy of the original
> done by cmd__example_decorate().
>
> I do not understand the criteria used to split them into the four
> separate helper functions.  It is not like they can be reused or
> reordered---for example, t_readd() must be done after t_add() has
> been done.
>
> What benefit are you trying to get out of these split?  IOW, what
> are we gaining by having four separate helper functions, instead of
> testing all of these same things in a single helper function t_all
> with something like
>
>         TEST(t_all(&vars), "Do all decorate tests.");
>
> in cmd_main()?  If there is a concrete benefit of having larger
> number of smaller tests, would it make the result even better if we
> split t_add() further into t_add_one() that adds one with deco_a and
> t_add_two() that adds two with NULL?  The other helpers can of
> course be further split into individual pieces the same way.  What
> ere the criteria used to decide where to stop and use these four?

The original code has some kind of "sections" (or paragraphs)
separated using comments like:

      /*
       * Add 2 objects, one with a non-NULL decoration and one with a NULL
       * decoration.
       */

or:

      /*
       * When re-adding an already existing object, the old decoration is
       * returned.
       */

I think it makes sense to separate the code using functions matching
these "sections" and to reuse each comment in the TEST() macro that
calls the corresponding function. If this patch is rerolled for some
reason, I think it would be a good idea to mention this in the commit
message though.

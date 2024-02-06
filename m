Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7F212C7E1
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 09:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707213319; cv=none; b=hNJ3tdDzf2TADfRB+SI9L+6k2nVVPMleBa/Ud5VlhiYJoGfd+hRQyDGqoXaQOOc7EhAb/AYHT9iD0oP5B8o5h5zXcd8EKJgFFEMtnKP/DGvOEkanJ3CRMotSTpoDSEsV6X/tVUrkGBdy5zsxUZV3dnGTTjeSD/y/ZHXqrJB7hMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707213319; c=relaxed/simple;
	bh=tK7QKfUubxwYnmyqlsQNBJkqh671KaYkNGmAyjvfUpk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n9O9rz5W0vGp5YRfBvltasF/299MLFZryseirMKWwiUYK3Cs46Ou/e0wy7xyslUdDBvL85tp3/0e5SwjLCls/rZzUIF6SbuXhFyniGh1DgqNcbyhlR9QWCSXduDGlz6XVonkR+89QOLA7NlhSiYTEuzXuqdoHYTrGtvojgAwpNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fI6PkNJ1; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fI6PkNJ1"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d0b750518bso14205191fa.0
        for <git@vger.kernel.org>; Tue, 06 Feb 2024 01:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707213316; x=1707818116; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nazWR0R+R/XKWaQAmjXnbcGqbFLUm0IFMAlcJZ4MrzQ=;
        b=fI6PkNJ1dkdmWA36thiFrfyuTYTIG7u6hq/X8Fy1WBoEGNFibncwloSK+gmtPP0rHb
         eg2jhoykZ6YHadrvJ1iFDVWAOeXyUFO1vwB9xLYoETDFTVyUNuQFjtiTI+luBLcXRFfA
         iiPfGXU0YsQp9Ftr/bnL2epcna1ResbflTycsRAfZDkO6Xwu+nXZ2WjiM5cOoYxjGHKK
         ZKUCESSJXgc0mpvizqA8+2C22qTNjgTP+dOQ0yvR3iv/H//MsSc+DUC0NAEc00h3mo+d
         1Hd21qxOvtcopesFI8oNcgWkSd/LlbOkLru21LEjYCHLeeNGxhY0G2W/L2G9NjvhguLL
         76+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707213316; x=1707818116;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nazWR0R+R/XKWaQAmjXnbcGqbFLUm0IFMAlcJZ4MrzQ=;
        b=tYXek7Kh5Xo2jSEnEVBv5zt8cVB6oGS9BDA4pWtkrnslS/VNC+nV4vGYAcACGj6Cq4
         mnUFDtuvn0zrO7Trg2mIknhi9dF+71h4DcUrC4+dIzCyxslNtWld4V1oOQMeqtSR7Vwh
         GlUGIteJL1nwpAjfC601DcOdVjpRMpnHtUKfmc5XqqpI4SO3tgOT9PBuaFs9zDRrU0vs
         xse/bWaCTJtHYSXRoP4DIt4iZmu8x2BDlbtwMeFpp/wB/2V5sO7imjUnJmaZAqV693pn
         6HGFYmcgNTVQGB6GgQP288bBBM7c0Bp55Cty6S6eNDRpsCO0D3qsWFTloAr4fQS1Fti8
         XlCQ==
X-Gm-Message-State: AOJu0Yzt6I3XjTtYd8BF66kUe8o89spAM6OyfjZ5IapW3NJtvErvUJQf
	sjc2cjn90mEB7WEMc29qSPKj9X5RNp9hEUNRJTo/L2sCBTyfodyZR41D3Ykyk237fTwXR+Ov+Qz
	UQKu0P1CJjQ8XaCMIHz5NxFgV9lQ=
X-Google-Smtp-Source: AGHT+IHy2k4UVGpQmG3lguP1jdoMTHj8dmoX0mckcY2QpioJQBv+pySaqkMqiNA0elvTZevtpIsbSRs8ILjEB6cgmXc=
X-Received: by 2002:a2e:8053:0:b0:2d0:992a:cc5f with SMTP id
 p19-20020a2e8053000000b002d0992acc5fmr1401411ljg.15.1707213315417; Tue, 06
 Feb 2024 01:55:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205204932.16653-1-maarten.bosmans@vortech.nl>
 <20240205204932.16653-2-maarten.bosmans@vortech.nl> <xmqqil32l0i6.fsf@gitster.g>
In-Reply-To: <xmqqil32l0i6.fsf@gitster.g>
From: Maarten Bosmans <mkbosmans@gmail.com>
Date: Tue, 6 Feb 2024 10:55:04 +0100
Message-ID: <CA+CvcKTtcHCCKucQ0h1dnaDAMNfErJ+a1CXEVi=ZE5dv57Tb3A@mail.gmail.com>
Subject: Re: [PATCH 1/4] notes: print note blob to stdout directly
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Teng Long <dyroneteng@gmail.com>, 
	Maarten Bosmans <maarten.bosmans@vortech.nl>
Content-Type: text/plain; charset="UTF-8"

Op di 6 feb 2024 om 04:44 schreef Junio C Hamano <gitster@pobox.com>:
>
> Maarten Bosmans <mkbosmans@gmail.com> writes:
> > Avoid the need to launch a subprocess by calling stream_blob_to_fd
> > directly.  This does not only get rid of the overhead of a separate
> > child process, but also avoids the initalization of the whole log
> > machinery that `git show` does.  That is needed for example to show
> > decorated commits and applying the mailmap.  For simply displaying
> > a blob however, the only useful thing show does is enabling the pager.
> >
> > Signed-off-by: Maarten Bosmans <maarten.bosmans@vortech.nl>
> > ---
> >  builtin/notes.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
>
> I am not sure if we want to accept an approach that feels somewhat
> narrow/short sighted, like this patch.  When "git show" learns an
> improved way to show blob objects, who will update the code this
> patch touches to teach it to use the same improved way to show the
> notes?

Yes, you would loose some of the flexibility by just calling out to
another git command. But whether that is actually an issue depends on
the way git show would be extended. As I mentioned in the cover
letter, there is some handling of textconv
being done in git show for the blob case. I though it would not be
applicable to note blobs, but am not entirely sure.

To address your concern and the textconv case, instead of calling
stream_blob_to_fd() directly, show_blob_object() could be used. Right
now that is a static function in building/log.c I guess that needs to
be moved then to log.c (or show.c)?

I'm still not sure that is a good approach though, as the notes
edit/append subcommands use repo_read_object_file() directly to fill
the current note contents. So anything fancy that git show would do to
blob output is not reflected when editing a note.

> I actually was hoping, after seeing the use case description in the
> cover letter, that the series would be introducing a batch mode
> interface to allow callers to ask notes for many objects and have
> the command respond notes for these objects in a way that which
> piece of output corresponds to which object in the request, reducing
> the process overhead amortised over many objects.

That is also a cool idea. That would probably use the functionality of
the cat-file batch mode, right? In that case you loose any future
changes to git show anyway. At least the current behavior of git show
when fed multiple blob hashes is to simply output them directly after
another, without any way of identifying the parts.

My concern would be that this additional functionality would not get
used much, as it requires a bit more than just a quick-n-dirty bash
script with some loops and command substitutions. If that approach is
reasonably fast (the object of this patch series), then there is not
much to be gained in a practical sense by a batch mode. To me it seems
the git notes code is already a bit undermaintained currently, so I'd
rather keep it generic, instead of customizing it to more specific use
cases.

Maarten

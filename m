Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC6E2A1BF
	for <git@vger.kernel.org>; Sat, 10 Jan 2026 01:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768007836; cv=none; b=OXTw6cUqAV6zXiic51SioqBvcZFBHDt7SVGtflZ1kfkkEmXmzBDyW1alGm+HjIX+JqUx2a4xbBgzTLgQXHWPjHksUpqA4aPbLK/j9VstBU8nmAoDDlHoH2LhVWqUEw+yxYbIIEMx5yezEXACwVWEjaprzYOVUfmUWybaNAbVxgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768007836; c=relaxed/simple;
	bh=2L/SawsWv50ShoapEgCHd/WtHj9/g7csUXl2kPBEIj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XwpR6LsxZ7X0VwQD/vZnZVdm72E8XLCUfWInz1jSjUAsT19GhH7Ro5sKjM2CLHhLWUwL4zXXFVX4x2s2KW3jvqTE+3HXsagXzgT1g4TYScyLXgL9/P4qjs7Hp8pyuktrNKU6G+saj54Mkj6pFuXfqNmmgTbajXr8js5ViyvJ+/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PX7AaoXB; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PX7AaoXB"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-65e9430489eso1754133eaf.0
        for <git@vger.kernel.org>; Fri, 09 Jan 2026 17:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768007833; x=1768612633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WR9LGbM3+3xrPc1tCRfeL93djQsKZTXeZ+pxx4Q2R7Q=;
        b=PX7AaoXBpwrND1K4eMsGl5WATq+Iexhq+3A6gSmxow7atlOfUhhOGVLAprbvdsSSbG
         zV088wMBnJ0WWISlb1XTrWR31OHUdephe4eLh8RsqJ1ygN+dJ6IjKe5bgg2gnoB6G/Df
         6MMZ9i2GKPdi3/rGcsSA+Oj1isq6jkhYs/Mp7MHmD57LMrtpoTA1yBPJvjrTGuAjOTBq
         UIU9IAPK/i3SwdVy0V61jHBkzgVqZcharLSvWWnDNJYOgO2yQ0Io9rkEt38/d7HxQ10n
         oWLQPkH+bkjt/Wx7Wf6ZWUpVpCn3JTUM43wETiWbC9fR1W/Qiiu88TH3wRphntPyF57K
         ukZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768007833; x=1768612633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WR9LGbM3+3xrPc1tCRfeL93djQsKZTXeZ+pxx4Q2R7Q=;
        b=ib7sKOYSh8jd3GHzSeHWY1/Rl+lOCopq8K5he6hU6NWdu4u18s3szguDY2kcP+RlMO
         vxUJ5oZAV9XmVWu929SM3drLLWVcSRBYrVtwSM/ffTFFxkxrvye4KWuX77zNaOUxVHKa
         mvl8D9ZicmxMRvqWI4yKpZih2xm81QTrM7Tvg9DR0Oy8+LSizplBYbmP3Q85qlDA+5T3
         tVbce3TXuJs0rOsMa+t371H5K2jfGiEMtJEn52JXISg3ie6ouGnhTW4GTMSPe/QXQykw
         xG1ZjM0TpyTmZsTJ6vxq0AVCbp4PRI6uyLeFkZ4B1MwFnaUfO5SC2Qym1yeqGa1utuEW
         KhEw==
X-Gm-Message-State: AOJu0YwXDnIliSEjp1TZ9X59ibnWUsMXnHU4qzyOWXqTKbmmpcl1qPGz
	n/3knj3nbrmXm4J0VfIaCGwUuxtkc30j4AOZxKqRga7+0vQpPi1y7RkqDQkBioh7V8euOijt77y
	/bMpTkLBbAUqnIAwpAJfcaPqOqaSXxMo=
X-Gm-Gg: AY/fxX7DrRkC215wEj4xvlBQ2XaShX0nrUUqa3AsL5C2DBNvQqim0oPFczoplrySWWP
	Q2IRndcrJn9S7Gemhd0g/KF79TWlLW1JCMfL9MseQMLf6VahTb9LkkM3JIDjKm3TQ1wmWvzht6S
	tQ+tlJzcAcowgiEzWeKWLOlVyJSHhYzQ0q416BimLrmg6p4ube7LEpqYE/S88CqbFcSk4NdVRgi
	ImvX4XJKH1sy6ucidO5PVwK/XU3VLqsIYcpR9RNGOX4Cuz7bGaGB5Md1Lbvpzvlm76qhgO0rjHT
	urZeR8+hQpCs1qWgfDK4U/dApKE=
X-Google-Smtp-Source: AGHT+IFlJQ1cfN0HAtuI8LKzvh7eTA9qn60OuUqePmnnHHl7BJHBJQFfY3rbcnhztY1wft+l0EtNv+TgNTehJPfrkTg=
X-Received: by 2002:a05:6820:6206:b0:65c:fb36:f239 with SMTP id
 006d021491bc7-65f54ef2065mr3842093eaf.9.1768007833448; Fri, 09 Jan 2026
 17:17:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260109-b4-pks-history-builtin-v9-0-8766101814c6@pks.im> <20260109-b4-pks-history-builtin-v9-4-8766101814c6@pks.im>
In-Reply-To: <20260109-b4-pks-history-builtin-v9-4-8766101814c6@pks.im>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 9 Jan 2026 17:17:02 -0800
X-Gm-Features: AQt7F2q5qeBwRlYmMNTjCGLQueqvXbUCvr5hkVQmt05Wi3FR0-DQ4jkJ18RUpww
Message-ID: <CABPp-BFXsZe5k-2qbkTfMaU7xxpViiHACOG+vwiRnf9xemd0QA@mail.gmail.com>
Subject: Re: [PATCH v9 4/7] replay: yield the object ID of the final rewritten commit
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
	=?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>, 
	Martin von Zweigbergk <martinvonz@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Karthik Nayak <karthik.188@gmail.com>, 
	Phillip Wood <phillip.wood123@gmail.com>, =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
	Matthias Beyer <mail@beyermatthias.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 12:35=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> In a subsequent commit we'll introduce a new git-history(1) command that
> uses the replay machinery to rewrite commits. One of its supported modes
> will only want to update the "HEAD" reference, but that is not currently
> supported by the replay machinery.

I'm a little surprised.  In that case replay_result->updates_nr would
be 1 and you'd just use replay_result->updates[0], right?

> Allow implementing this use case by exposing a `final_oid` field for the
> reference updates. This field will be set to the last commit that was
> rewritten, which is sufficient information for us to implement this mode
> in git-history(1).
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  replay.c |  2 ++
>  replay.h | 16 ++++++++++++++++
>  2 files changed, 18 insertions(+)
>
> diff --git a/replay.c b/replay.c
> index 313fb2a768..20560e792b 100644
> --- a/replay.c
> +++ b/replay.c
> @@ -338,6 +338,8 @@ int replay_revisions(struct repository *repo, struct =
rev_info *revs,
>                                            &onto->object.oid,
>                                            &last_commit->object.oid);
>
> +       out->final_oid =3D last_commit->object.oid;
> +
>         ret =3D 0;
>
>  out:
> diff --git a/replay.h b/replay.h
> index 84bc8a7a5b..f8f9889112 100644
> --- a/replay.h
> +++ b/replay.h
> @@ -46,6 +46,22 @@ struct replay_result {
>
>         /* Set to true in case the replay failed with a merge conflict. *=
/
>         bool merge_conflict;
> +
> +       /*
> +        * The final object ID that was rewritten. Note that this field h=
as
> +        * somewhat special semantics and may or may not be what you want=
:
> +        *
> +        *   - If no commits were rewritten it will remain uninitialized.
> +        *
> +        *   - If a thicket of branches is rewritten it is undefined in w=
hich
> +        *     order those branches will be rewritten, and thus the final=
 object
> +        *     ID may point to a different commit than you'd expect.
> +        *
> +        * That being said, this field can still be useful when you know =
that
> +        * you only replay a single strand of commits. In that case, the =
final
> +        * commit will point to the tip of the rewritten strand of commit=
s.
> +        */
> +       struct object_id final_oid;
>  };

I don't understand why this is needed for the usecase you provide.
Are you perhaps trying to rewrite a set of commits whose tip is not a
branch or something (directly contradicting your first paragraph of
the commit message)?  That's the only case I can think of where this
would be useful, unless I'm missing something?

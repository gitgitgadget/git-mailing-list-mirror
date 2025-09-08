Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E8C225762
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 05:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757309508; cv=none; b=dlrKvIUELDZmB31z4iqpzFzsJC0U1KAymAzQAw2NcLQEO5Swh6eN0oqu2/CSCsXB42Vn39cSQoQ9nXKlfsl9hmKX33pXiqsco5Gyd05ekSbOofv8nhjMRjfeJIYZpL9/WqoCE6mJ7YAWXihHStavQuM8Ug+4qMvvl3zKT+i3PR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757309508; c=relaxed/simple;
	bh=uX2uSbcA2NEoN39ZS19HBbbw1OjSht5aZtTe4TZe5co=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sdHlgTWFCQwPvkdScyP+HxljhJ3QPgK0eReXL6LoRbB5O+xUcEhWaPhN3hOqX5S/6Il8w159mucE7Zra6gmYJoNVbw5gaJD7nADkt/lWo9LNX0W74mmFuLC2FImvoGDJ+yNmUx48GzvP1IHrSDXlilspH9fpNjQ8QplZxCmhLNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gApBnKdw; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gApBnKdw"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-625e1dfc43dso2277628a12.1
        for <git@vger.kernel.org>; Sun, 07 Sep 2025 22:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757309505; x=1757914305; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Agi78FlzY/NRnvanYmX5BWGxNAJeIxVmU6DDHyc3paA=;
        b=gApBnKdwspMXGjgZJXW2alsRTDy43aOrc5NDt6Ii8/fYpm7icSJVqrBMwLmc3CeZhk
         whTWNTK9xlE8dSBawETccjRHfuZP3wBiVXd1Gqn/7BOWTpHG50jljVaEvBv1N11Su1cM
         JiWDhB5ew5o0pM8a6Q2ZXIRrEeePOHL13ltHnD5gqfaftw8VL47N7NJO8I9O1Yww+/Ft
         J+/9X4RDbjTWlUZ1SaTnAvckBbfmVJG0NHvkic/N2Qv/Sl8dV/GyYtNTNgjyjVThZxtf
         oI1FbIsEcd+w/1Kkmd3yYpPs0c1dmW/si8CG4KHh4CVKv1f59TYMsOXlxMCME4C41UVM
         Q5/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757309505; x=1757914305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Agi78FlzY/NRnvanYmX5BWGxNAJeIxVmU6DDHyc3paA=;
        b=rYhsjVbcURtyjwpZsuET6L7H3rfCeuzDuoGZniR3ZockLapOo/JABIxzStFduQKuXG
         pM54LvE+oePhlZlmFGo3BQgEq7+8+63rnT28aJ0sRJLcP/Mqqkn/gyPXa7F7hU5I/oO2
         /AMfL/bBMZNjmQbJSgdXJ80o0krC6igf2/cJ2Fs0TG0GDRu293IbGId0HUDyrOdrxQDP
         fkvZv6CXePcjJcfT7Nu+MCFCdTd72q2r09ntkz4K5DUPOc+Ua0CVtSEJ1vYQLketXXAu
         y1+3dBI24/GwL1xTlXAmjP/ao9ZZ1wmF6XoQEp054LwbwJ/tpxAJlRQX7dTkYZ7rb8pQ
         hOPg==
X-Gm-Message-State: AOJu0YwPlkglhwQtKsdAV+aE49TNh/ebMnJI9bT7bNLz5mNub0l3IXSp
	0qp84atwYca+ZxZIlKDyMeBMyc0RN2xbiWydgjdlVNthLv5tzXoppHDOFJnyTx4HrrhgK5AR7Pk
	fPUYn5sG1opjJwTBXj0u857/OFBo4tsI=
X-Gm-Gg: ASbGnctXsfm8dL2+aFXuOO2Xg6UA2XIgtKfmEjVo6ecvicu5IGokiKxrP896r69S5qB
	6Zj9kiHvK/ePngSpFkHTQWdXe5sDpHqpV2wjN8uRn0gDoINx/0Pgy4d1Px23Hlpp16kOe7vbqAH
	DhYwIFFFMnLvNpG2SLTSUi2ZlEaacn5shILDpK+AedsDQd7oD5yqgFr3yZKdlueGtgmI/4G4NYh
	mnsa/atmqU5+01cuNxf
X-Google-Smtp-Source: AGHT+IGdzsYCCgMJes7QrrFmF8nVZSIjJI/D+uaP2YrdjrDv/Vz5sO61KFmlCO51FlY8hKnGtYXMVIWPoVXAQItUrh0=
X-Received: by 2002:a05:6402:3594:b0:615:8db4:2602 with SMTP id
 4fb4d7f45d1cf-62377109b46mr6724990a12.22.1757309504898; Sun, 07 Sep 2025
 22:31:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721141056.2283349-1-christian.couder@gmail.com>
 <20250731072401.3817074-1-christian.couder@gmail.com> <20250731072401.3817074-4-christian.couder@gmail.com>
 <xmqqh5yss5xx.fsf@gitster.g>
In-Reply-To: <xmqqh5yss5xx.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 8 Sep 2025 07:31:32 +0200
X-Gm-Features: AS18NWC2sWBy9E2BeRAH8OkHMUpSyRcEkjLkRYTuuaRgMimGtw9jThJYcon0QU4
Message-ID: <CAP8UFD2XBwxH-2+qxWMq7Q28iGOoJJyMrNAb5zTe2B1bZ+6tkg@mail.gmail.com>
Subject: Re: [PATCH v7 3/5] promisor-remote: refactor how we parse advertised fields
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>, 
	Karthik Nayak <karthik.188@gmail.com>, Justin Tobler <jltobler@gmail.com>, 
	Jean-Noel Avila <jn.avila@free.fr>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2025 at 6:04=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > +static struct promisor_info *parse_one_advertised_remote(struct strbuf=
 *remote_info)
> > +{
> > +     struct promisor_info *info =3D xcalloc(1, sizeof(*info));
> > +     struct string_list elem_list =3D STRING_LIST_INIT_NODUP;
> > +     struct string_list_item *item;
> > +
> > +     string_list_split_in_place(&elem_list, remote_info->buf, ",", -1)=
;
>
> This munges a strbuf pointed by a structure that was supplied by the
> caller as a parameter to this function.  Most notably, all commas in
> remote_info->buf are replaced with NULs.

Yeah, this is bad. This is fixed in the v8 by using
string_list_split() instead of string_list_split_in_place(). See
below.

> A quick read of the sole caller of this function reveals that the
> caller passes one element of an array of strbuf it obtained by
> calling strbuf_split_str() for the only purpose of calling this
> function, and the caller never looks at the .buf member itself, so I
> think this munging with _in_place() would not hurt the caller.
>
> > +     for_each_string_list_item(item, &elem_list) {
> > +             char *elem =3D item->string;
> > +             char *value;
> > +             char *p =3D strchr(elem, '=3D');
> > +
> > +             if (!p) {
> > +                     warning(_("invalid element '%s' from remote info"=
), elem);
> > +                     continue;
> > +             }
>
> We find the first '=3D' and ...
>
> > +             *p =3D '\0';
>
> ... replace it with NUL; the item->string here is now split into elem & v=
alue.
>
> > +             value =3D url_percent_decode(p + 1);
>
> And the value gets decoded.
>
> > +             if (!strcmp(elem, "name"))
> > +                     info->name =3D value;
> > +             else if (!strcmp(elem, "url"))
> > +                     info->url =3D value;
> > +             else
> > +                     free(value);
> > +     }
> > +
> > +     string_list_clear(&elem_list, 0);
>
> And we are done with the string list that holds the pieces of remote
> info split out.
>
> > +     if (!info->name || !info->url) {
> > +             warning(_("server advertised a promisor remote without a =
name or URL: %s"),
> > +                     remote_info->buf);
>
> But this use of remote_info->buf will no longer give us much useful
> information.  It might say something like "name", and the warning
> would not let us see what the rest of the remote_info->buf used to
> have before _in_place splitting.
>
> I think initializing elem_list with INIT_DUP and using string_list_split(=
)
> without _in_place should be sufficient to fix this.

Yeah, right, this solution is used in v8. Thanks.

> > @@ -604,32 +651,19 @@ static void filter_promisor_remote(struct reposit=
ory *repo,
> >       remotes =3D strbuf_split_str(info, ';', 0);
>
> If we splitted this into a string list, then each item in it
> will not have the terminating ';' at its end, therefore ...
>
> >       for (size_t i =3D 0; remotes[i]; i++) {
> > -             struct strbuf **elems;
> > -             const char *remote_name =3D NULL;
> > -             const char *remote_url =3D NULL;
> > -             char *decoded_name =3D NULL;
> > -             char *decoded_url =3D NULL;
> > +             struct promisor_info *advertised;
> >
> >               strbuf_strip_suffix(remotes[i], ";");
>
> ... this strip_suffix() will become unnecessary.
>
> > +             advertised =3D parse_one_advertised_remote(remotes[i]);
>
> Such a change would require this call to be made with const char *
> not struct strbuf * as a parameter, but the callee we just saw above
> uses its parameter (i.e. remote_info) only to look at the .buf member,
> and does not take any advantage of it being a strbuf (like it can be
> trimmed or its length is known without running strlen(.buf) on it),
> so that should be an easy conversion.

Yeah, right, all these suggestions (splitting into a string list,
removing the strbuf_strip_suffix() call and passing a const char * to
parse_one_advertised_remote()) are implemented in v8. Thanks.

While at it, in v8, all the calls to strbuf_split*() functions left in
"promisor-remote.c" were replaced with calls to string_list_split*()
functions.

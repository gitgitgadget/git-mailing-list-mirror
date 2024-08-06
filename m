Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B56B663
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 07:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722927890; cv=none; b=bVuRqnQI+Jay5MnilFmqO4FXvDCNgbM2tuyZq+MLKrLKvFZ7/WQhXUKm5mZmd5XVwJTed3TadB9F4kpSzzFgUe2l9sgWNxg2/icvewW0mmyOB4dzwSkuqOhRSDJUv/2IUobXEnEHL9Rds+2ljW92QhURiExMlxRAqzI6JkdBCK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722927890; c=relaxed/simple;
	bh=6L2/NSDDIaqxnDL3lvJoXABJEZHoXEerfC+rj5xcpb0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uEs2L3iqLSam64+7V+bYfi0mDXN6Fxjav4VmVBJnAAUxuo4e3AqWG2ww/XuifAORXT4iiQQc94FgvSzIb9Y62It5XMS1+jyffhvI1PQ33CTKsgAT3fHRXWXyn8Oqu+CviUdKNn9T5/pEA5s+AUuIDJAOEJ2Airg5WmhSNCgl9iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OtCXGHlJ; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OtCXGHlJ"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a7a94478a4eso1056469566b.1
        for <git@vger.kernel.org>; Tue, 06 Aug 2024 00:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722927887; x=1723532687; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T9P6dfdqAa6yaKHhjafubVd1g2r1bDG6tO6xYTZo2IE=;
        b=OtCXGHlJOw+LltGDi4pGktM0tBG0Ps25b2vTJAqHvQX5yaUSN3bIs1bZF3LRZAQtcB
         fsm/ZUHBzZ+mS19Kz/3TIRBKSVrAiDUGO52RphZJoiARL4hknC5c5+S0eaweqSe42auR
         P05Sr/zqpoQ7XjN9fbm3Zc4blvz+goab37tbYBcq32q7sXIU8pV8GO0NG79Pui364ZKa
         hy1gBFtwn8iU7dq3JFQ6Zb8XTjn3kSrC1xwhc5OiA/yllZpBoABPqZ5M8oO9ezXXNcUj
         kq6qSuQYGQP/QkFfDShePEqxo+AK5NKuKyEds7ANRTZZGG/sHGdCwYziLJHDqHpXn5ms
         TQrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722927887; x=1723532687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T9P6dfdqAa6yaKHhjafubVd1g2r1bDG6tO6xYTZo2IE=;
        b=kciEXUWXdCxN2byd0RG5dNQOIK2hsVkQyy2XZRzkKIGYIkZqEMC/4TUk8An9mpGCA8
         RIXro0SCtWjKitw1M5NURwyZI/2mvJg4BGSS2bFUd7DJZUSVkIVE1BBOKbtkxKcLYfnE
         1rq3d0lejQZvF9BbYye6DqT1IVnbjTf+dR1CSdjfjzcUH5ioCvKUKFKGNOJcImV83/I0
         DqNEpmsjpVWrA9n3nFBRpFpeue0zzHF/9fvlOPj35n6b2/+GThXLhXTTtKt1q6TP2zuH
         4KXz6s3PggyN1roLnIwViQkgHRScUunYi4pXyBHtNe8Hn8beKjbgbkmnNv2iOf2+YEKA
         Odiw==
X-Forwarded-Encrypted: i=1; AJvYcCXT3AX8fd/Ml1zOj8spSztwE/LdNFXqFWGNQQq1q8zK++9NYI7kxIC7wbVISWzeTXD/Q+2fiCmnzVQqSCLksssQF24S
X-Gm-Message-State: AOJu0YxUq6EvrXbNXQD6+ge0q+RQV4n+wruSprzBJH3+5j1KZKK1NoOy
	buYISyGsN8FCICBjIAqLWD4B8+G7cCb9X16l27VvijFOVUGCF4ygFqV6VxsrdKkj+WHudFKDkJd
	PFpeGgtRrDnkO/wyCYLze8AOEenIztUKO2QgF
X-Google-Smtp-Source: AGHT+IEwBeEKWV6B7syuzgSmefqHbjFOiGBtSv9rsRjiQLRUL7dnoIP7UNVZpstToWiKGPClSTsPBpKqBqJinqNFoeI=
X-Received: by 2002:a17:906:7956:b0:a7d:2772:6d5f with SMTP id
 a640c23a62f3a-a7dc6245f89mr1179523566b.23.1722927886673; Tue, 06 Aug 2024
 00:04:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1756.git.git.1722571853.gitgitgadget@gmail.com>
 <pull.1756.v2.git.git.1722632287.gitgitgadget@gmail.com> <0ed09e9abb85e73a80d044c1ddaed303517752ac.1722632287.git.gitgitgadget@gmail.com>
 <xmqqv80ia9wf.fsf@gitster.g> <CAPig+cTmzk7AN2x8-WCK_T5-_G7Wd-akB2++_4HFEbT67Rnc8A@mail.gmail.com>
 <xmqqv80f3r3d.fsf@gitster.g> <ZrHCCBXXWZPzAcQb@tanuki>
In-Reply-To: <ZrHCCBXXWZPzAcQb@tanuki>
From: Kyle Lippincott <spectral@google.com>
Date: Tue, 6 Aug 2024 00:04:30 -0700
Message-ID: <CAO_smVj7kN1ywAMVagTb_ALwqb-aycUy4tSaJ47ocC1ZRBHcqQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] strbuf: set errno to 0 after strbuf_getcwd
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>, 
	Kyle Lippincott via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 11:26=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Mon, Aug 05, 2024 at 08:51:50AM -0700, Junio C Hamano wrote:
> > Eric Sunshine <sunshine@sunshineco.com> writes:
> >
> > > On Fri, Aug 2, 2024 at 5:32=E2=80=AFPM Junio C Hamano <gitster@pobox.=
com> wrote:
> > >> > [...]
> > >> > Set `errno =3D 0;` prior to exiting from `strbuf_getcwd` successfu=
lly.
> > >> > This matches the behavior in functions like `run_transaction_hook`
> > >> > (refs.c:2176) and `read_ref_internal` (refs/files-backend.c:564).
> > >>
> > >> I am still uneasy to see this unconditional clearing, which looks
> > >> more like spreading the bad practice from two places you identified
> > >> than following good behaviour modelled after these two places.
> > >>
> > >> But I'll let it pass.
> > >>
> > >> As long as our programmers understand that across strbuf_getcwd(),
> > >> errno will *not* be preserved, even if the function returns success,
> > >> it would be OK.  As the usual convention around errno is that a
> > >> successful call would leave errno intact, not clear it to 0, it
> > >> would make it a bit harder to learn our API for newcomers, though.
> > >
> > > For what it's worth, I share your misgivings about this change and
> > > consider the suggestion[*] to make it save/restore `errno` upon
> > > success more sensible. It would also be a welcome change to see the
> > > function documentation in strbuf.h updated to mention that it follows
> > > the usual convention of leaving `errno` untouched upon success and
> > > clobbered upon error.
> > >
> > > [*]: https://lore.kernel.org/git/xmqqv80jeza5.fsf@gitster.g/
> >
> > Yup, of course save/restore would be safer, and probably easier to
> > reason about for many people.
>
> Is it really all that reasonable? We're essentially partitioning our set
> of APIs into two sets, where one set knows to keep `errno` intact
> whereas another set doesn't. In such a world, you have to be very
> careful about which APIs you are calling in a function that wants to
> keep `errno` intact, which to me sounds like a maintenance headache.
>
> I'd claim that most callers never care about `errno` at all. For the
> callers that do, I feel it is way more fragile to rely on whether or not
> a called function leaves `errno` intact or not. For one, it's fragile
> because that may easily change due to a bug. Second, it is fragile
> because the dependency on `errno` is not explicitly documented via code,
> but rather an implicit dependency.
>
> So isn't it more reasonable to rather make the few callers that do
> require `errno` to be left intact to save it? It makes the dependency
> explicit, avoids splitting our functions into two sets and allows us to
> just ignore this issue for the majority of functions that couldn't care
> less about `errno`.

100% agreed. The C language specification says you can't rely on errno
persisting across function calls, and that the caller must preserve it
if it needs that behavior for some reason. The POSIX specification
says you can't either except in very rare circumstances where it
guarantees errno will not change. The Linux man page for errno says
you can't rely on errno not changing, even for printf:
https://man7.org/linux/man-pages/man3/errno.3.html

       A common mistake is to do

           if (somecall() =3D=3D -1) {
               printf("somecall() failed\n");
               if (errno =3D=3D ...) { ... }
           }

       where errno no longer needs to have the value it had upon return
       from somecall() (i.e., it may have been changed by the
       printf(3)).  If the value of errno should be preserved across a
       library call, it must be saved:

           if (somecall() =3D=3D -1) {
               int errsv =3D errno;
               printf("somecall() failed\n");
               if (errsv =3D=3D ...) { ... }
           }

Basically: errno is _extremely_ volatile. One should assume that
_every_ function call is going to change it, even if they return
successfully. The only thing that can't happen is that the functions
defined in the C and POSIX standards set errno to 0, which is why I
withdrew the patch (since it's a wrapper around a function defined in
POSIX). But in general, I don't see any reason for any of the
functions we write to be errno preserving, especially since any call
to malloc, printf, trace functionality, etc. may modify errno.

>
> Patrick

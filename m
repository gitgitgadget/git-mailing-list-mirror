Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A58B19D8A8
	for <git@vger.kernel.org>; Fri, 27 Jun 2025 19:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751054000; cv=none; b=Gibspv4gWgQKY4XRprGEzYhiiKcO8aSiSr1ZO1Awtvb9nZbLEum0xHWVFu1hmETyxTaid1xYkvaYxP7gdKb/L2m2g/GkthDIGfF9b1cuxR0lkm2LVs3t4S/BgPZAm4KO8DvnIFvpqcPItDugmCDRrjcR3RHPhJ2SC0XI2cGWNlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751054000; c=relaxed/simple;
	bh=PfcEKLE/jcycBHDM5xpaMNUOlEJz+3Tqo9xMs9qoQh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uNDG5nJJMfdmni2AiGJDx6xD7svOGEj6SHM5Pb4PXdmawnnmvmUBKqawC+IH59HKVpGL2FegMLRvoPP8zuBQKlS65gLeeN0eZDSnSwUC4NSdmLbowtPT8wpqjCxqea+nLexllF/nvEJbLJGfe8ynzINxKyuW8uCS/fsfPp6yxkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fMzeFVXM; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fMzeFVXM"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ad574992fcaso30179866b.1
        for <git@vger.kernel.org>; Fri, 27 Jun 2025 12:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751053994; x=1751658794; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jSx1/Assd4N0ay56Eo8NZ0bPs9i8a/aIlrgL0VMYT5Q=;
        b=fMzeFVXMaNqI2vHjhrXqyqRJ8PvCrGMQkL7yR8ncwMBHX1m0lRnosXTfBsY0wtTJQU
         OIA+igpg9Tt4KHWcaXZG7r/IjL1Bj0K6+p11oFycGwELzSRn4UZp581FwofatWyUw4+z
         YlVN3yU2PSbgZ2WLPiALjOVGZmJv1G06bEOAPtTkN1uC8YgtAhl+mbr9zAN7dbPWspV4
         UIWwGLZYNKpEps8YiranuEdUzKKlLLoP6J/s49GsE7VkNjuPCAsIaBYm+UvwzgQ7oEsI
         PXpb+sYKBGMfq6Rs1U2zZ6ZWJUfT2FIgehvfZ/wc8p30Gu2xUWSqjSc+bUu++vgSiHuo
         qLDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751053994; x=1751658794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jSx1/Assd4N0ay56Eo8NZ0bPs9i8a/aIlrgL0VMYT5Q=;
        b=JwRhIKxcrCF76TQ7RSPZUYYj8fMXLWBO25j00EBovR/6pFlngO+7N+oUYImmveEgQt
         Vw/WI0lHB705gDd0xPCb4n5k+Uousj23uVQk/ze94OTrPs4DdTM8rQh4xXK+oZb9DX6y
         yaKg9Iy7Dkm985h88GOWRvNkcR2UuS+rb5WFOhKCn0W9rZf4nyiVEAsaHaVZB8D/ExD/
         bNrvIKowptMKwGOHFb2qe6A5flW7D3Cq3KaSLt9DgOR5TKSjDYDvRmx/9U9EnTWfwCZM
         hZNgiUqyOm/khGtVAW5DVnWA7tUSV2K/OccXMpOwJVjKz0GcZaGFI2M/K3pINLnoet79
         WqSA==
X-Forwarded-Encrypted: i=1; AJvYcCW7GuE6nslGFoGtEU1hQeB+fml6zQlDq5qitdqi6L7cTnWUko9YscmCrtAQE6GLR2Ip0hE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIFyQRjSoim2clBAzWYzwaerHI69axW2a+daqBOJ6oVK5Rn2ag
	jx042xFviTHbj7i9Jbjyeu53w6fYhPMQ4g+53xYs0Bbh36xdV/MmiteLLeAh+zOFXndoGt2N/DF
	q2UdIQBBP2VaUYJs2XfVYG5urw3/Qw5Y=
X-Gm-Gg: ASbGnct6z2BFgmuZK+Bh6ZDNSV08cb28CltmeKhM0JUpr6bATTfHlH3iAgRn0r6S+gq
	F9iqm1m81Kprc7zEVdFw8zur1RAga7CG3U9BoSq/UfWz2X+Tt0Bj4MhRhKGUzE1EjkRXnEcOXT4
	c8C+rj0FLKLO1gtRN885tmraQsWMEOsf6PfeDDSsSkOXM=
X-Google-Smtp-Source: AGHT+IGVv6l9SDOazwijEe4EUNzruyNAW4Y3FSqyFrBJbGXU36E40LZEMtJkQb1PaP4JWRdexiWDLkGrF+okM2gKr5w=
X-Received: by 2002:a17:907:7e9b:b0:ae0:628a:5093 with SMTP id
 a640c23a62f3a-ae34fd18230mr438494266b.3.1751053993583; Fri, 27 Jun 2025
 12:53:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAUd64333fEMHAaNW=-CkfUMN4HDFF2v==HdO0OFnOgm+W+Jog@mail.gmail.com>
 <a3cd775d-99fa-49de-881b-1e8f178f9102@app.fastmail.com>
In-Reply-To: <a3cd775d-99fa-49de-881b-1e8f178f9102@app.fastmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Fri, 27 Jun 2025 15:53:02 -0400
X-Gm-Features: Ac12FXzNNsNtnJMNo0K2HrWK8k_pVGLL03yCwI4YzVQON7_4FB30DL4w3NTdVmk
Message-ID: <CALnO6CB8GWVNPS_eud6QEpzh7M5oQ6Vcm1-Hx5VqP=L1ovtyaw@mail.gmail.com>
Subject: Re: [PATCH] completion: new config var to use --sort in for-each-ref
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: =?UTF-8?B?TmVsc29uIEJlbsOtdGV6IExlw7Nu?= <nbenitezl@gmail.com>, 
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2025 at 3:48=E2=80=AFPM Kristoffer Haugsbakk
<kristofferhaugsbakk@fastmail.com> wrote:
>
> > Previously when completing refs eg. "git checkout <TAB>"
> > all refs were alphabetically ordered, this was an
> > implicit ordering and could not be changed.
>
> Style-wise, the commit message is supposed to discuss the current
> behavior (without the patch) in the present tense and what this patch
> does in the imperative mood.  Like you are commanding the code to
> change.[1]  Something like:
>
>     When completing refs, e.g. "git checkout <TAB>", all refs are
>     alphabetically ordered; this is an implicit ordering and cannot be
>     changed.
>
> This also gels with the general pattern of:
>
> 1. Introduce the current behavior
> 2. The problem it causes (maybe merged with (1))
> 3. What to do to fix it
>
> > Previously when completing refs eg. "git checkout <TAB>"
>
> s/eg./e.g./
>
> Maybe also some commas like
>
>     ..., e.g. "git checkout <TAB>", ...
>
> Or maybe it should be =E2=80=9Ci.e.=E2=80=9D?

Alright, I'll take the bait:
- "e.g." and "i.e." are typically offset by commas, e.g., like this
- since there are other ways to complete refs, using "e.g." (roughly
"for example") is better than "i.e." (roughly, "that is") here

>
> > This commit adds a new config var to allow setting
> > a custom ordering, the conf value will be used
> > for the --sort=3D<val> of for-each-ref.
> >
> > When a custom ordering is not set then alphabetical
> > default is kept, but this time is explicit as we
> > pass --sort=3D'refname'
> >
> > This commit also adds '-o nosort' to 'complete'
> > to disable its default alphabetical ordering so
> > our custom ordering prevails.
>
> Super nitpick: the paragraphs could be wrapped closer to 72 characters/
> columns.[2][3]  This alternative (slightly modified) is closer
> to that yet not very uneven, still.
>
>     Previously when completing refs eg. "git checkout <TAB>" all refs
>     were alphabetically ordered, this was an implicit ordering and could
>     not be changed.
>
>     This commit adds a new config var to allow setting a custom ordering,
>     the conf value will be used for the --sort=3D<val> of for-each-ref.
>
>     When a custom ordering is not set then alphabetical default is kept,
>     but this time is explicit as we pass --sort=3D'refname'
>
>     This commit also adds '-o nosort' to 'complete' to disable its defaul=
t
>     alphabetical ordering so our custom ordering prevails.
>
> > This commit also adds '-o nosort' to 'complete'
>
> =E2=80=9CThis commit=E2=80=9D should be replaced with just the imperative=
 style
> =E2=80=9CAlso add=E2=80=9D.[1]
>
> =E2=80=A0 1: See Documentation/SubmittingPatches, =E2=80=9Cimperative-moo=
d=E2=80=9D
> =F0=9F=94=97 2: https://lore.kernel.org/git/CAPig+cT1VfY8QiUvrrV3-obTBP14=
39b6iwaebJtGwML5MScnQA@mail.gmail.com/
>
> --
> cheers
>
> Kristoffer Haugsbakk
>

All great suggestions, thanks.

--=20
D. Ben Knoble

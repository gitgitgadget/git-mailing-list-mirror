Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C00772612
	for <git@vger.kernel.org>; Sat,  2 Aug 2025 16:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754151220; cv=none; b=DJlrqqy/humPQHVvvgYAYUghGbeYzC8wwN9LrGYL4LdQo6IHmUMPJ7tEEPoehsI5DqiUrx1pcJ4/kG9u/tZY5scV0rJ3skX/N3EXRGpy5mVNx5AIgUJjKkIaPAS6hd1xq8XvNyBRKNxE5bLW+0yNRqPl0BqbaKXVK+g37zkrQ6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754151220; c=relaxed/simple;
	bh=1H+jYTRSUkWfmHKX9KwFhylVI+H2gX/qLcn6RHtUCdM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lvFN1fiINYHP5EZzjtk6Ns1MDeyPdo5+2AYv8Aj9IbcssVc+TUyhzdFwH/EhUWxknuUe/tP2lhQyEFId8nxyUNSdmn0CYlz40WEi9BoiGZI3kZLKBLGVfUyN4fQTowz0DsHC8O8VCL/u85dwnGteDMcA756jyy3yxQSkEDabk7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LOYXUEN/; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOYXUEN/"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6156a162537so3870533a12.2
        for <git@vger.kernel.org>; Sat, 02 Aug 2025 09:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754151217; x=1754756017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4KL/S6fBM/ji1Lc3pjK54y5F9SSE6V3q/wKypaYNDQI=;
        b=LOYXUEN/o0xjhdjLQYjsNdOwLkjRZEt7DBKBXtHsuWOg4x2VGPIZNlBVwjxYBHAxx2
         OpnZ5zfmkoiUJNkfbd4dH23vjmiUHXxlnV2vOA44xow/QNP5VoGnRAERetnUysF/37aU
         eEm/J4+oypZGWqeRbTWXfXZ4UF8Ef01rSRQY6VR/JktLEYBYIDANPzsK7eLzwkn5Hvg/
         4+QzxHgt5VVPaXhQKgLSLCZS87jRYiz5ByPxQQH2IFD0RloX1TdXzRPuwuggBMyapreZ
         uPtqYK8BI6w76i6VCz71ESA4tDbHoNAynBVA4DyUtYJCB2bN6wiiX56rIXlCoVEtcx+R
         qKRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754151217; x=1754756017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4KL/S6fBM/ji1Lc3pjK54y5F9SSE6V3q/wKypaYNDQI=;
        b=TWuxUXfJHV0YNl5On2ZaEW/wPZaTtcE7dHksdv0atX92T00lUdU/yDBS3MPjxpJt/5
         kbDG9RrOxaA4lhbxz850BjE4Rfs8WI0m9HSb5O6N4zlipywOFW667v5rbW+lax7nShP+
         WtUghXzEyR6sHnf5Hnm+o0yAlUtN521LoATlbsAPzj/knZbqeD9TDaHAFPQVxbQAxd9b
         MKaczpbwU2ZFeeAsUj6IJm9SH69JGdxh+f/52di4seNYcWxfjaxqsomKP4LWlll3Wjh0
         8pYouzc/zW6ZDUgEXKZouuaTqH3na1SdUNigqrDu/r5kCAGXYP2UiwQps9S3MVdc1r7S
         JI/g==
X-Forwarded-Encrypted: i=1; AJvYcCVW4rfSK3HQ15H4Ml9Oty/9ctoyFxyqfweOjm2wsOdDYk8qSMlicQU01NVNiq+VwmqEjSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWLBti9ZUhNJ7+21JrcD7PGbZskuyxshogmqt/QK5hVk6mMurD
	i6G1mO9VKwYLPUxjFTET0hZRthjKnh+d48Agbh6ohtZd4R82EaToB1Mx4XarCqGsCgW9Z2ijJpq
	3hJjSYoHqH3vWPw4FwIu6APqWM01L1DE=
X-Gm-Gg: ASbGncsZTEMR1hbJRzcGXGJ3EclllKbsa3gFd0et7og3EW0PkZmEj+Rw74s2bPHyY/f
	YxovFHxm6aRGlIrzoO+gaqEFDv6JgqA8mXJ7qml2jBalv7qfhUdBwxTPeNft0feubJDWrd9dHhw
	hOw2Azduc1IfPeuNm42uQIgGPAuCQV/XUJpuMCDBHXvYz3NXJvWGhpFmC7fIwvHajSOsVGSwiGv
	hmuEi06Q1+OIu/uF9/gTNUzWdV74+Ml36WyjgILYQ==
X-Google-Smtp-Source: AGHT+IEwCrfdyyWU7oTWr/4VNT3+QskPFL1Kbk3UP+tuhdNDCq0sLUy6KkWXh16XV9rTteDxMQaFVhIJihRt4OxBCy0=
X-Received: by 2002:a17:906:f59f:b0:af9:38ed:935c with SMTP id
 a640c23a62f3a-af93ffc5908mr390859666b.3.1754151217237; Sat, 02 Aug 2025
 09:13:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALnO6CAOOTBQf3s9B1G8AgwcbYnv5VNY63q-6bGPeoaLy208rg@mail.gmail.com>
 <xmqqv7nezdw2.fsf@gitster.g> <CALnO6CDNDfx6L7CmPwE0eBZFkd_JkZf6hDwrADccAb14QhJGDg@mail.gmail.com>
 <20250802094657.GG3711639@coredump.intra.peff.net>
In-Reply-To: <20250802094657.GG3711639@coredump.intra.peff.net>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sat, 2 Aug 2025 12:13:25 -0400
X-Gm-Features: Ac12FXyj-3OzJPvMDNEgp4pBzdcmjSEU_hqxDC6WV4vsAUCQc6wyVTLbjqt8yxM
Message-ID: <CALnO6CALb-_RjNZw9u-0R33O+KfccfZK0+mF-W7G659wc4PW7Q@mail.gmail.com>
Subject: Re: Why does git-grep appear to treat exclude pathspecs differently?
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 2, 2025 at 5:46=E2=80=AFAM Jeff King <peff@peff.net> wrote:
>
> On Wed, Jul 30, 2025 at 05:49:29PM -0400, D. Ben Knoble wrote:
>
> > which eventually dies as noted. However:
> >
> > - looks_like_pathspec() only checks for long magic, as you noted
> > - setup.c:check_filename() looks for short-magic, too, but only
> > considers ":^" to work like a pathname if we're excluding everything?
> >
> > I think what I find confusing is that, while this is definitely a DWIM
> > case for git-grep, it doesn't seem to do DWIM :) We are verifying that
> > the remaining arguments are filenames, but couldn't they really be
> > full pathspecs, as long as they aren't revisions?
> >
> > The difference for "^:<path>" from ":^:<path>", just to complete the
> > story, is that in setup.c:check_filename() we try to stat whatever
> > comes after ":^":
> > - for the former, that's <path> and we are ok
> > - for the latter, that's :<path>, fail.
> >
> > So it seems like the places that check for short-magic should also
> > consider the optional trailing colon?
>
> Yeah, I'd think so. But it's worse than that, even. According to the
> glossary definition you showed:
>
>   In the short form, the leading colon `:` is followed by zero or more
>   "magic signature" letters (which optionally is terminated by another
>   colon `:`)
>
> we allow multiple bits of magic. So the code in check_filename() that
> looks for ":/", ":^", etc would be fooled when seeing more than one
> character, like: ":/^exclude-from-root". AFAICT there are only two short
> magic types, so I guess nobody has really run into this before.

Good call out! I also see only 2 magic items (one with a synonym) at the mo=
ment.

>
> Also, I guess this function ought to be respecting the literal_pathspecs
> global? The actual pathspec parser does.
>
> If we can, we probably ought to be feeding the paths to a function like
> pathspec.c:parse_element_magic() and then checking the resulting flags
> (and skipping past the prefix as it indicates).

Thanks for pointing me at this; maybe I'll find some time for patches
unless someone beats me to it.

>
> -Peff
>
> PS I didn't even know that we allowed multiple short items or a trailing
>    colon until your email! Hidden corners of Git.

;)

--=20
D. Ben Knoble

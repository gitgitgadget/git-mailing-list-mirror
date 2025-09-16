Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9BE1B5EC8
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 17:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758042631; cv=none; b=Fxtc1PXzQ5c5org+NBfvaXjtfYcjASwjiWa6pJpGDdcVeLRTEISKrUvUFVqGiwik5tnp9QkUCTVUG429wNyts/0bsGORbrNBwTltmUn494U2kRua3tP81nYoxgo8bLcvRlXONd4cAcardRQNYCAffLQJWVlsz/QcVfTX7ImwYS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758042631; c=relaxed/simple;
	bh=dwwp1PsrSgplWH1Pm5tRp/FyzWMgiwJMF9aIWhSITAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OUjT9igIJDW1qqQZnHno0XBe8LZiMMbbXSkA6pBMgk7lX49qDOxSlh/QZkxGk7r+DNqI6SBG3BMz9LBddzZC+V/xTsGQvSmEib+aTdRihIJB8apoBeyMzi8jorSblghlLzU57fe7sRMcF8j9p3uCeMPnGzw2ISHSi5Y2rwZCNF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aWvnABaq; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aWvnABaq"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b07883a5feeso989363466b.1
        for <git@vger.kernel.org>; Tue, 16 Sep 2025 10:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758042627; x=1758647427; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dwwp1PsrSgplWH1Pm5tRp/FyzWMgiwJMF9aIWhSITAM=;
        b=aWvnABaqMVEDyaeoIE9XmdNHAInbwuD6QL+sdlLNdSGNhxG9gznhNr7LV65NHj1zyW
         8l89oZafLTvIIz9K+gOtMG4QvC7io5sHutbM7WbP6sf4j6kTEmjCY0odb3bGBY8EjpI0
         /arllto/rJL93budQWa0P6VwDRz68I37HeHDgOrNgI3vjg/uqleTavKY23TwQJ/1tSol
         QkvV/vdnUlVRZDxHYVSTPN25yzbK7wqWIyuvpeZBeHCApeGagQGE9lvHJ44zui75l/vG
         3yAs6WX530JbmQoWnm02tySjseyJigATw4oAlfvDFMuOBmBvl/JpfmuC8lmSYbPv6ssx
         kVuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758042628; x=1758647428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dwwp1PsrSgplWH1Pm5tRp/FyzWMgiwJMF9aIWhSITAM=;
        b=CVciV3Jh3iHR2uyIwkfFDcEgvya6Ul+fRac3W4SVhYOcZ/X8TrZi2jvuUroZ+88eB1
         IEc83H4VEGWT++bNj+X2LydJG6AR0K/2JCfYKAgqFRyhdblgu8YQeV0WuP9v3FJ5nawn
         KsrB/+NyoGONEf5+JkGErT2TZpAwvkr4usVFg4pZUIe6pZbkIgUqWvwAjwYGTlU8plDX
         SheVvU59ul6mmBKWm69Hizv6T9Qg/ZTBzDp0TPu6FQDyW6O4+loioZkKPZ0zV8RjU+p+
         RYHm2ZqzBxU3aapq9UX9PCJ0OfJu0BRBEDEoaA5D7XfWxiRCbVifOEti48CBLPHvkw6l
         0XWg==
X-Forwarded-Encrypted: i=1; AJvYcCVK4gRMeSV7AUV9fsqzsXqS/DDu7b8VSBaHds7LtXQCjyT2HdBsejpcQnbb2NXsJjAAD8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJWm02xx7br0UgLfxqezRJtWhS/AdW9u4Arwursxy0Bepo8ft7
	qJrhaaSIucwr92MdR/Mun5IfKo6M46XA0TSkF7Dy9tqMW7vGeVecfH+FNCIWl7++BFgejjbaKvd
	IJYgY8cC9UsIFdk/tdzYf9wJmZFKCOPU=
X-Gm-Gg: ASbGnctKkGy0RnQYCbTIssChXJ6RAnNRFOVII5KixAFEFvLqPCjnMA5W8hH6Nj+CEeD
	RK3o2ERWTximQDgjz+C4v7Li620ug+JjnyMEJVKEEYrA8DibBJ7PltBlT2jSCcDXLlEKD5y+OTf
	EwxfAmzPvdabm7K8i9iCvdHqBGMqiJIyA1jFxYolqUK/ZKd/vjnpFYIcssakxQ+u/xlhcJsqqzn
	NOsYwVOxLeugE+mQADmYBJWN34oIri+JCm4+XWT7MOClrK6QyWv
X-Google-Smtp-Source: AGHT+IEYDW1rabxgShL3TbnfVrAeNtX4yf/DP8uc51HxDw0Ref6ARoHsMxB8ucTfQXybYfldTlhf2uClreacFO5/ykA=
X-Received: by 2002:a17:907:930b:b0:b04:4975:e648 with SMTP id
 a640c23a62f3a-b07c37fd7cemr1794680666b.35.1758042627553; Tue, 16 Sep 2025
 10:10:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <89394e50-9077-4a7b-b30e-afd1be1a40e8@gmail.com>
 <18A45EC6-2D2C-45A2-8802-0E5060539398@gmail.com> <9f9e49c5-5612-4e6d-89af-839b353506f1@gmail.com>
 <CALnO6CCsFuYqo-q8D1g=vR9q22+Cy1MAgk1Ld0cD1wFNjr-eSw@mail.gmail.com> <4b689f92-5277-4e57-b4b7-8cc241ddd664@gmail.com>
In-Reply-To: <4b689f92-5277-4e57-b4b7-8cc241ddd664@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 16 Sep 2025 13:10:16 -0400
X-Gm-Features: AS18NWDSrFbj0gms5wB1_4FrRvrYIKUznI6RPj6qCMiU-3QILpli2WNgiCgXHg4
Message-ID: <CALnO6CBprG+TSa3vtVjDOX5sF3MorvPv4Do7gA8mXXz26+3hUA@mail.gmail.com>
Subject: Re: [FEATURE] Proposal: git stash --only-unstaged
To: phillip.wood@dunelm.org.uk
Cc: Junio C Hamano <gitster@pobox.com>, "J. Dettweiler" <git.vger.kernel.org@dettweb.de>, 
	git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 7:03=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> Hi Ben
>
> On 29/08/2025 14:30, D. Ben Knoble wrote:
> > On Fri, Aug 29, 2025 at 9:06=E2=80=AFAM Phillip Wood <phillip.wood123@g=
mail.com> wrote:
> >>
> >> I think the example works but may generate conflicts when the stash is
> >> popped. One can argue that the conflicts are unnecessary because they
> >> could be avoided by popping the unstaged changes but I don't think the
> >> example is broken as such.
> >
> > Thanks, let me try to rephrase: the example makes no mention of
> > conflicts appearing or having to adjust them. It seems to heavily
> > imply to me that no such conflicts are expected, though as we
> > discussed upthread it seems unlikely you _won't_ get conflicts if you
> > do
>
> Yes, I think if you edit any staged changes (that is the lines that
> differed between the index and HEAD when "git stash" was run) you'll end
> up with conflicts. If you edit a line where the index, HEAD and the
> worktree matched when the stash was created then I don't think you will
> see a conflict. Overall conflicts seem pretty likely, so maybe we should
> mention them in the documentation.

Thanks=E2=80=94I realize we were talking across each other, so I'm glad we
were able to get on the same page.

> > [...]
> > I suppose my main complaint is nothing about the example makes it
> > clear that's the intended use case to me? Hence
> > - we could change the example to mention conflicts and/or use case
> > (smaller patch, punts on the problem)
> > - we could change the code to accommodate the example as written
> > (using ideas from your script; harder but bigger win IMO?)
>
> I was hoping that we'd hear back from J. Dettweiler as to whether the
> ideas in the script were useful. It would certainly be better to update
> the command to avoid conflicts if we can.

Sounds like a good idea.

--=20
D. Ben Knoble

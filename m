Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E9E27F73E
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 16:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745425172; cv=none; b=RQ7LL5Mf/0jjPOsgPsLRwFtwQ50mC3q11380npk+icu9LH39MhA1KuGYNCo1tWj+ofnoAJLWnhU6WD/YwCGkpW6DtXovEN2SQ8krL6pf3JghJ7vAqLuW3OpMBhZZ2sPLZiyn+nWkYvTo3Qz8FeSIi4eZ6e2P3AlMs9VQblBnX70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745425172; c=relaxed/simple;
	bh=WSHpMmLBOQ4AkZxDBY0+jrAMbQAFE4jrr18GxjBQ7Wo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MLvOY911vDcN+S9hy80Pu7SrPUg7ex8pRrrLK4FhJRWw51NX6i8xiGGZdwUlVexkvwgceVwGz4j56yylgdjFLSXMIycNKjiPyO0dv3Txgu7PedrubpOqNVi0vpWfj5NMtKdANjz7a2pU9dZeog6eeuUOoFi8W31TG91iE8+yPXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cFp6MZ2E; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cFp6MZ2E"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5f632bada3bso11456a12.1
        for <git@vger.kernel.org>; Wed, 23 Apr 2025 09:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745425169; x=1746029969; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xtkL1WwsxCtVetaOOhfV36aRt9BQm9Wg8Z4td7BUGXA=;
        b=cFp6MZ2EozKWskx5g0y6kbz35jIW+pdCbcbT25To6GWjAUn/wRaAZ4i5KvqqE5xFKN
         SxG/U4nPVk2SIoBahSAfqxT5mjQSTg1fqKkDwyXzRnKmpIJASgCYfh+IlwpciuMeVgO9
         nPwRU4XbhOMx9nf3hQ+wugWCrf95ONhJ9OBdQCRFfWGhvxq6xOJgFFqUiRhlioVVqRQu
         8DrZ6YPU1Xg6Tlv65tmVFfIceVtXjBkr06Xofcae75REWujVoQ0n717hPpaHeLWwthMs
         +MwwIWA8oZQpqJU4v+Xu7jNUEdXyrNmrGollDLK4zDAW9GfdH7eYQ7AdrQiQM4AkkbIa
         FeSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745425169; x=1746029969;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xtkL1WwsxCtVetaOOhfV36aRt9BQm9Wg8Z4td7BUGXA=;
        b=Gt7duRbwQ9MDRAOAhwqYfFNZyD8T/t2eN4rDVCPSCYDssqC8ovvPEWqpbQvpJ9NWsd
         MoPhltLt7wSgkGeWdm4UwtUD0bM2ez8Ch46oiSefwt9HyYxJq7lN59Bc9AfUpToleeSB
         XcH+xpeMyC5XI/7CS5opxwP7hFn8iiDpYihn92VTK/86C6WZRLs5BMU97ebPKSFgbn7j
         +xYmYK7mM+LsHxeNgn7kqsuk0DUmRXVrkv3wqKxztCITswKSZd/GIl4ZpCTYWODooUm2
         kZ5i7bNZIKgJcLYORwuaG+USRu6LusYHMVPUK7LEO8FhlaxlidoosLNWkSjA3U1606zQ
         UsEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkAB+P6rOZGWhOdj6/S8nQ3H86U+97hWB3gJkPV90mEj8A6dwLxvjpW4c/2Yql1KwQEXc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzavBWoUO/ariJtxu0PAkrP2imL1qLw0OrEXKj/KX9rZz4g8S5C
	red54nYUKxK0QuDViLs49CkFWfuW1UxEUknk6rtyytE51nxc71ppbCkv/+/5v5+BSz0LLRDCiT9
	LnVpt64JZTXALrZjIqKI+VClhAtyzdlvxFOuZ
X-Gm-Gg: ASbGnct+s0B6esKmOIZG4GoUIEDtd7tpo9xY2I/MbqqrfEx0eqYFjmP4/YeLRfz4cmA
	Ua5s7sbpjBMX0/U8ey3o7yWFXJizHV+2CMPID39GnNxl4fOIknCY1KjYZy49MU55a5R3/CPpbCq
	ELEgxcW1PjViCz13O7/54upi56o7f4w60j3GzgBXuLLiU/FgLbZaoR
X-Google-Smtp-Source: AGHT+IF3GwdIEyeEVIe6VVSKFRHOulYNmDSzVRXFAaKmyX/6P71C2+ffZgYKPrvoI42MJ8x2ZlgIY/DiE5wLeb81iWI=
X-Received: by 2002:a50:8a9a:0:b0:5e5:b44c:ec8f with SMTP id
 4fb4d7f45d1cf-5f6d0ad3d26mr105526a12.3.1745425169181; Wed, 23 Apr 2025
 09:19:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com>
 <xmqq4iyzn0vn.fsf@gitster.g> <Z/RFQY433muaCW44@ubby> <20250408125521.GA17892@mit.edu>
 <Z/VGYrrVZYQ13TLj@ubby> <20250409121924.GA148735@mit.edu> <Z/amMj/eg0RbXdkS@ubby>
 <CALnO6CC_Gvqhcxp4AknwM+YSsngv_0zngKb2XHXN4u0AvKEMMg@mail.gmail.com>
 <D9816I5AX1RG.AA4A7H2D8SJ7@buenzli.dev> <CALnO6CCjkxv40+5wZ_vwZTKv7Te8Xh--M1fY2wbuOfgJm5LZxw@mail.gmail.com>
 <D9DIPNY431IJ.23DG6UL5CIQJ@buenzli.dev> <xmqq8qnr3jji.fsf@gitster.g>
 <CAESOdVDG_tfrWMvV6V_Ad76EqXU3Be+EpJDLvtgPcfCRHoJoYQ@mail.gmail.com> <xmqqjz7a27ww.fsf@gitster.g>
In-Reply-To: <xmqqjz7a27ww.fsf@gitster.g>
From: Martin von Zweigbergk <martinvonz@google.com>
Date: Wed, 23 Apr 2025 09:19:17 -0700
X-Gm-Features: ATxdqUGG4mXIhixXi2ds08aUYLvC7sT2PAL5NtCO_1RUTIIhaaWn0jOX4NmeqF0
Message-ID: <CAESOdVCjc1kvQSKnxGfNNSTvFhLRjH_vzwMauP8ZWQ5hhfBnEw@mail.gmail.com>
Subject: Re: Semantics of change IDs (Re: Gerrit, GitButler, and Jujutsu
 projects collaborating on change-id commit footer)
To: Junio C Hamano <gitster@pobox.com>
Cc: Remo Senekowitsch <remo@buenzli.dev>, "D. Ben Knoble" <ben.knoble@gmail.com>, 
	Nico Williams <nico@cryptonector.com>, "Theodore Ts'o" <tytso@mit.edu>, 
	Git Mailing List <git@vger.kernel.org>, Edwin Kempin <ekempin@google.com>, 
	Scott Chacon <scott@gitbutler.com>, "philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Content-Type: text/plain; charset="UTF-8"

On Wed, 23 Apr 2025 at 08:51, Junio C Hamano <gitster@pobox.com> wrote:
>
> Martin von Zweigbergk <martinvonz@google.com> writes:
>
> > On Tue, 22 Apr 2025 at 15:42, Junio C Hamano <gitster@pobox.com> wrote:
> >>
> >> "Remo Senekowitsch" <remo@buenzli.dev> writes:
> >>
> >> > Btw. since the thread was started, the implementation in Jujutsu has
> >> > been completed and I've been pushing commits with the change-id header
> >> > to various remotes for a while now. It works well. Forges can start
> >> > taking advantage of it. (I hope I find time to help work on that.)
> >>
> >> It should work well, until somebody finds your random is not random
> >> enough, right?  Unlike our object name that depends on the contents
> >> (hence a duplicate unless the cryptographic hash function collides
> >> means they are truly the same commit), there is no grabally unique
> >> ID assigner involved in your implementation, right?
> >
> > A forge can decide to enforce that no two commits on the main branch
> > have the same change ID, for example.
>
> Would it make sense, though?  Imagine that a contributor in your
> project did not refactor code properly and instead made a
> copy-and-paste duplicates of a very similar code.  I find a bug in
> one of them, without realizing that the old mistake of duplicating
> code (instead of making it a shared helper that is called from the
> two places) and create a fix for it.  Later somebody else realizes
> the same fix is needed for the other copy---attempting to cherry
> pick the original fix may find that remaining copy of a buggy code
> as the logic to perform a three-way merge across renames that is
> sufficiently clever kicks in.  Shouldn't these two commits to fix
> the same bug in two places share the same change ID so that it is
> clear to the later developers that the latter fix was derived from
> the former one?

Maybe it depends on how the forge uses the change id. If the forge is
Gerrit, it will use the (change id, target branch) to identify a
review (IIUC), so then it will require a new change ID because it
requires a new review. If it doesn't have that requirement (maybe it's
PR-style forge), then it could at least highlight to the reviewer that
there was an old version of the change that has already been merged.

As Remo said, we've implemented this feature in Jujutsu and we'll
probably enable it by default soon. I think GitButler has had it
enabled for quite some time. So maybe we'll see in a year or two what
problems it causes :)

Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5385F2F3E
	for <git@vger.kernel.org>; Sat, 10 May 2025 19:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746906385; cv=none; b=h6aoxfRgLj6yQCiez9B94eaSbxn+j/pcLDEJ+kIxMgPl2pxsuWesY+UahJFgWOcmGGz4V07XvfsOroU8kXvWA3ski4KEWjVnzemlCGyjwai3qCm8NDjf/Dxchv5ccSiSMEx7eL+2xWKJbfGyqQxnhyDuxFubqWbNkmbOBp+Enc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746906385; c=relaxed/simple;
	bh=jN+zjPvahBujeHlQRiugm/d1b/jJ2I38CcEMBvWgpBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cy0/XwZ/GOVm7Ir3mtPspIjOYfT3ICD6+dlbZox2YThp59mi9DaoHZGweHAs8mA4qImagBobBLSyD4gBPHjAJJwgN78tKmf6Aoln60S5rSX4WHYJ4f0DGD5g25wBaqXZFcj77YqT3dWPN5qNpZiGmeGFEBQP4SGmXIylQ7tNQsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HDOpRhT/; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDOpRhT/"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ad216a5a59cso301100166b.3
        for <git@vger.kernel.org>; Sat, 10 May 2025 12:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746906381; x=1747511181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jN+zjPvahBujeHlQRiugm/d1b/jJ2I38CcEMBvWgpBA=;
        b=HDOpRhT/C+8PhnlpjwCFP1DX8JwKi8XliNVv7/dSSfqdM93OeFrONlEGJpUwuMpwE/
         lwePv+2gKJch12P0j1uQL0NoQgtZN5Mk2sxaZ13amPifiEONzslWXCFAHlM82Sa+Y8/H
         DAdCS/WW6qgwDkQDdThAfgQck9ZnwCSb57GHARAxse+Mn5W0Sr2EwPo1iq4M5XY3l7M5
         au5MIkh+Nj55foh4FWvMZaKEYX2fXCCJ/fKZsLP+wzWFgvafdL9BBCUvM8P8+nR2lScR
         CSFrV8Ss1aT7zPqNO56OqdLsSFekwbJwG+dUpv1HQaoYpAyWEuKY9OceVPr9bFf9JRL1
         /d8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746906381; x=1747511181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jN+zjPvahBujeHlQRiugm/d1b/jJ2I38CcEMBvWgpBA=;
        b=WMgVhli2gB3ypMQDSk2/2ks9mOs8J6YapG3A9lJ9HY37aNR+bLX1CA0bOHzGwtnT4D
         kY6baGvT65ktK0xsBH/amvG4Lk7azkoDLmT9g3CWqKIY50N/jZmEreXHdtd9yajt5UMr
         N79SA57pFhmjuELsQ3i8a55QQ6k3XCWyogXIICOVMstjB7t6QBNe/zYoUvvUW+pN8Czl
         0j4/gO3N4eD/W+H43LIKMrkqLmJA8r6yZi7/EuUcm0IolXeT39AgmaIe7m//tEt/jQ+B
         +l8QtJtNOJfPKE3srfZ4N/tZLkpuaHHeNssEqrVsEpIQy4tIar16DpWC20U6jJI/TboG
         m7Gw==
X-Forwarded-Encrypted: i=1; AJvYcCWP5Tb0qgz9C8KZlmJvlhEW+XRq5igl/cTl+sUqsrmgCCAa9KhwqxkBIzisFr0Btgas1ZM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk6VEZmNUVS7G03iaKQd+1mCxK8VM9M0c8l+5/Vs+t5TbrlwJO
	H4Ro1BTNS/ozi+SnVyDCqpOsHWDh7Wh8SQHy6d+3+Yt5wb/Ch2fYx0IwL0uLymBw+PHhsFA0yvh
	1FXl6ROxzUFL5gek6VcZ5qSnjeTo=
X-Gm-Gg: ASbGnctKDvTFg+o7f11zsZ+mE0eXmWmvmK7u3C/izygRBErG7pr/2J43+kd+3fd/OTY
	l8JyIcp0VsoKOQTzFGfBsvP6VcupPcMFJyDo7Yc0GzUC0LCVO93pVcCtBtZRcIOyzDriMVjN7D5
	2xzcJDk97zIB2aD39Z3Gyr7fuD5phR0g4R1MWXgm/hPa+SqZAv2hGkQeTht6dX6CUtKw==
X-Google-Smtp-Source: AGHT+IHQYYwM72cGRnqfdlFO3/ii2wPblXtAnk07RJgjikARaJT5bucV0zZfj3oSO//3yiWjqlcR9tDDC+UR5AJ0Ic4=
X-Received: by 2002:a17:907:a08b:b0:acb:5adb:bd4a with SMTP id
 a640c23a62f3a-ad218ea828fmr741864466b.12.1746906381340; Sat, 10 May 2025
 12:46:21 -0700 (PDT)
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
 <aAgWytQNqtLzg2TU@ubby> <CALnO6CBq2cqBAhzMh8rnXzc8cPTsB4hz98YVn3B4+PGdiyn9_A@mail.gmail.com>
In-Reply-To: <CALnO6CBq2cqBAhzMh8rnXzc8cPTsB4hz98YVn3B4+PGdiyn9_A@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sat, 10 May 2025 15:46:10 -0400
X-Gm-Features: AX0GCFszl95GWb9jMGIwHXkwWGEiHQzHQ7vUclXrzbYRnwivQTI31AL100VqtJo
Message-ID: <CALnO6CD8JTnNGfuCtb1QKFhx+Vv1txUZ+wCL1nZCDGAvHx6A6g@mail.gmail.com>
Subject: Re: Semantics of change IDs (Re: Gerrit, GitButler, and Jujutsu
 projects collaborating on change-id commit footer)
To: Nico Williams <nico@cryptonector.com>
Cc: Remo Senekowitsch <remo@buenzli.dev>, "Theodore Ts'o" <tytso@mit.edu>, Junio C Hamano <gitster@pobox.com>, 
	Martin von Zweigbergk <martinvonz@google.com>, Git Mailing List <git@vger.kernel.org>, 
	Edwin Kempin <ekempin@google.com>, Scott Chacon <scott@gitbutler.com>, 
	"philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 10, 2025 at 3:32=E2=80=AFPM D. Ben Knoble <ben.knoble@gmail.com=
> wrote:
[=E2=80=A6]
>
> Thanks for thinking out some concrete options on where IDs come from!
> I think I've gotten even more confused on how they are supposed to be
> used (which should probably inform the implementation), but hopefully
> we're getting somewhere :)
>
> --
> D. Ben Knoble

[Trying to summarize?]

On a re-read of
https://lore.kernel.org/git/CANiSa6gwup5vXU235mG+Ybbc+P=3DSbwoNFEmuhg=3DiYu=
0yGvSXVA@mail.gmail.com/,
I see that change IDs were motivated partly by identifying (related?)
commits after rewrites. I can certainly see how it would be nice to
track down how a commit I'm working on evolved; I can even imagine
most of the problems brought up in this thread wrt splitting or
combining commits (not to mention, say, cherry-picks where the
committer makes non-trivial changes to the patch).

There was also a note about using a change ID to identify a code
review in supporting tools. Neat!

I'll leave it to someone else to summarize the open questions? (I now
have a few of my own about how tools in Gits ecosystem respond to=E2=80=A6
unexpected=E2=80=A6 headers.)

In the meantime, I think I'll repost this, since I'm not sure I ever
got clarity:

Re-reading the original post [1] (which didn't mention this kind of
ID?), I'm having a hard time seeing the problem statement. There's a
lot said here about the specifics of the solution, and some other neat
things it might unlock=E2=80=A6 meanwhile, I'm wondering if all the
consternation about change IDs is because the problem being solved is
underspecified for a core Git feature? (That might tie to Ted's
initial concerns about semantic meaning, on which I think I concur:
the parent and committer/author headers have unambiguous meaning to
Git, independent of anything else.)

It looks to me, an outsider, like the problem is some combination of
"I want to track a commit's evolution" and "I want to see related
commits in review, esp. when it's an identical and already-approved
commit." But I might be misreading, and clarifying the problem
statement might help bring us to a better core solution?

[1]: https://lore.kernel.org/git/xmqqh62tm5fo.fsf@gitster.g/T/#m038be849b9b=
4020c16c562d810cf77bad91a2c87

--=20
D. Ben Knoble

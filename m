Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B545B697
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 21:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711400417; cv=none; b=A1xysA6DL4Jbxqw6/bg5dCB6EqgP1WEWJTMfB5PZIgHbfJIwD9rlAzOVSU4CBo97HCKYRUZYZWUpeyeRnU6d7XwaUkn8FFSir9y2IhqCENdaBfbDtyxr2HyW+Lr1IPXcsMLo/o0PHfQwnwN0I6qX9RBSLnOeA0FNvMTsTROBPkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711400417; c=relaxed/simple;
	bh=Fhybo/gTV5x5ndDcw2XYaXOnAZfp2Ul6+YYcuRVk4dA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XU+TnjcnjXs+rcO5JYd9I5fMA5aEthQPUbUPvE/tcT0G0YNQPnjk935geCss1DMnSD1P6V2x/6Z2M9R3545Q2ut5r+zuy/TkLU09kaSgtG7a9EYpbRgVld5jfs5I5Ic+iRWNtwpcu+7tXXTXS9G/Pj5Z1m+YUtFPNlSN2OHtgeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DGcr/B92; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DGcr/B92"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a46ba938de0so651918266b.3
        for <git@vger.kernel.org>; Mon, 25 Mar 2024 14:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711400414; x=1712005214; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+RqQpfpKqWJX8LYDIsZkb+rQ/GhYJkDc3TgiufCuJcY=;
        b=DGcr/B92xacd29CjQyVU3dT8QBOgl7AAQcWewi0tlUil9xGAvmCQf7U0eopKh7cqjg
         zwEbInj9GKMY5MoAPKohPBQO8rc0hqpIVA195NyjNpohkYz3Dn517KBRRv9pytJ++MHi
         ZUL5tWmIaord18+lpgyKF85sXUcHadUBd8AsgcMh8dFdWlkdtl86nkPxYCntVUJgSElJ
         Ob/ethD699gyqi5EgjoFp1t7/J7tLbFmOCNrL1v0bB6njSItoUNJQ+BqzdEL+4EjrXQW
         dktbjhLJdZWKYvI3CP31SvEe+rj6n6BCUmrlRTBGIkNM/vidtMX5yr83BnpirGJULye/
         90Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711400414; x=1712005214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+RqQpfpKqWJX8LYDIsZkb+rQ/GhYJkDc3TgiufCuJcY=;
        b=OdOsaH5zthpMHFdA9KyKDopU0zAv4MP0jgD4ielJ9pma+j2nlb0ImkrJjLrg08Esdg
         oedxsREliUGyWXwVfutO1zSJkgjy6Sfcotfac2e6MNgYYCPsi2IKsXA/lmJGYhh/8+Mk
         CSKYWokz+k4Zy2Dy+PgtWD8e7Jd9YGF4v/nUI8tQ5Q7T5baS8ipS0DZz6M567gmfAtt7
         /BvBjOTGhqEaY+yGIpmUkQ3DkpJ5EFT8ty0l1+zju1wSYQiAIQoGgM94CKvst7qCy6zQ
         n6hd9X7roNOKDwqIf7HEc2sWaW0C0n6NldQ5Aw7OMMV/Dr2ZF/8ozt6+uz99LXRpYUsT
         OpXg==
X-Forwarded-Encrypted: i=1; AJvYcCVDVCD6SG55hDwYHJ5203g7h4DqEi6FU2lV6yr77MGkR0g+GeiF6RshOCPx59ieXEggFefOsOqYxyK3G+l+wOHlK4DL
X-Gm-Message-State: AOJu0Yzqxx82sSUF5vLIcgVRLbB6YTuDVl6i/yGRILPdPFjB82Ez8x2l
	sgG0JUkRqwTjWIdG8viAIlexYcDFGj0s9K2u4lD7/mI8ktwxC6tlD4Wi9gGhl/3UdSe9V6C5A8W
	8vqz4mgIDCloqv7F+Yo61qlItxZ1OBem4sQjn
X-Google-Smtp-Source: AGHT+IHJeqQK8poggO+AgqMXSrmPmu9sqIvfJ3SheeGJttvblQTXc3+8SKS3iN63N7FvPS3k7kQGINTwQCUkjfMHFWw=
X-Received: by 2002:a17:906:fcb2:b0:a46:6808:2cee with SMTP id
 qw18-20020a170906fcb200b00a4668082ceemr620619ejb.66.1711400414260; Mon, 25
 Mar 2024 14:00:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1710840596.git.dirk@gouders.net> <cover.1711368498.git.dirk@gouders.net>
 <cfa4b9ce503e98035d3ce09b0c9e00bcfb6ff70a.1711368499.git.dirk@gouders.net> <xmqq34semden.fsf@gitster.g>
In-Reply-To: <xmqq34semden.fsf@gitster.g>
From: Kyle Lippincott <spectral@google.com>
Date: Mon, 25 Mar 2024 13:59:59 -0700
Message-ID: <CAO_smVhTQS2+QH0--ZtiCKyrFWx9fak0-0mbN-xY=_Ayx8JW=A@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] MyFirstObjectWalk: fix description for counting
 omitted objects
To: Junio C Hamano <gitster@pobox.com>
Cc: Dirk Gouders <dirk@gouders.net>, git@vger.kernel.org, 
	Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 10:25=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Dirk Gouders <dirk@gouders.net> writes:
>
> > Before the changes to count omitted objects, the function
> > traverse_commit_list() was used and its call cannot be changed to pass
> > a pointer to an oidset to record omitted objects.
> >
> > Fix the text to clarify that we now use another traversal function to
> > be able to pass the pointer to the introduced oidset.
> >
> > Helped-by: Kyle Lippincott <spectral@google.com>
> > Signed-off-by: Dirk Gouders <dirk@gouders.net>
> > ---
> >  Documentation/MyFirstObjectWalk.txt | 14 ++++++++------
> >  1 file changed, 8 insertions(+), 6 deletions(-)
> >
> > diff --git a/Documentation/MyFirstObjectWalk.txt b/Documentation/MyFirs=
tObjectWalk.txt
> > index a06c712e46..811175837c 100644
> > --- a/Documentation/MyFirstObjectWalk.txt
> > +++ b/Documentation/MyFirstObjectWalk.txt
> > @@ -754,10 +754,11 @@ points to the same tree object as its grandparent=
.)
> >  =3D=3D=3D Counting Omitted Objects
> >
> >  We also have the capability to enumerate all objects which were omitte=
d by a
> > -filter, like with `git log --filter=3D<spec> --filter-print-omitted`. =
Asking
> > -`traverse_commit_list_filtered()` to populate the `omitted` list means=
 that our
> > -object walk does not perform any better than an unfiltered object walk=
; all
> > -reachable objects are walked in order to populate the list.
> > +filter, like with `git log --filter=3D<spec> --filter-print-omitted`. =
To do this,
> > +change `traverse_commit_list()` to `traverse_commit_list_filtered()`, =
which is
> > +able to populate an `omitted` list. Note that this means that our obje=
ct walk
>
> "this means that" could be rephrased in a way a bit more helpful and
> to readers with clarity, perhaps:
>
>         Note that our object walk will not perform any better than
>         an unfiltered walk with this function, because all reachable
>         objects need to be walked in order to ...

This proposed text has a small ambiguity, it can be parsed as:
- Note that (with this function) our object walk will not perform any
better than an unfiltered walk [implying that the function change
itself is the cause of the performance concern]
or
- Note that (our object walk) will not perform any better than an
(unfiltered walk with this function)  [implying that
`traverse_commit_list_filtered` has a filtered and an unfiltered mode
of operation [which it does...]]

The issue is that the name `traverse_commit_list_filtered` is poorly
named: `traverse_commit_list` and `traverse_commit_list_filtered` are
the exact same function (both support filtering!), it's just that
`traverse_commit_list_filtered` is able to announce what was filtered.

Perhaps:

    Note that requesting the list of filtered objects may have
performance implications; all reachable objects will be visited in
order to populate the list of filtered objects.

I'm intentionally being ambiguous about it _definitely_ having
performance implications, because it's context dependent. It looks
like only the `filter_trees_depth` function actually changes what it
visits depending on whether the omits list was specified or not.

>
> > +will not perform any better than an unfiltered object walk; all reacha=
ble
> > +objects are walked in order to populate the list.
>
> Other than that, looking very good.
>
> Thanks, both.
>
> >  First, add the `struct oidset` and related items we will use to iterat=
e it:
> >
> > @@ -778,8 +779,9 @@ static void walken_object_walk(
> >       ...
> >  ----
> >
> > -Modify the call to `traverse_commit_list_filtered()` to include your `=
omitted`
> > -object:
> > +Replace the call to `traverse_commit_list()` with
> > +`traverse_commit_list_filtered()` and pass a pointer to the `omitted` =
oidset
> > +defined and initialized above:
> >
> >  ----
> >       ...

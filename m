Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880342D03C
	for <git@vger.kernel.org>; Sun, 28 Jan 2024 16:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706459843; cv=none; b=rbzGCUqu5h4yXvZnA98288PXxpIsngAueb/k+dz31mnG+fJfmLYUA68or5JtNNN0Dg3+eDoP6l3a4ilKdnC7NctwL416Wk4MQkAex+GESnOqZuabJXoeuieSxw/aikw0TuZ970zUc91Ogwj/esp1SKAA91ebmfpi3VyzMu/GkBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706459843; c=relaxed/simple;
	bh=sMR57gT0XJZUlCTvHOPzJPqIpr7mpMySTXoa4BdgvCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CJ0s0mJ9d4qfsVxxCSyZiZskeOuloAa3sKQgnauyOYnfAVDZ1BBO2VvOM0IlLcJXPp5N1emxMUzxvUu9WmkSd2/BgSmGkoGdn/EuEuaIEHv8bfJ276nQzZKyMEeYUOfC8oErxtFMeGUT79031lzEpEicv19YQyjgfh449LVFGeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KuMTrk1a; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KuMTrk1a"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2cf47acf8f8so19908031fa.1
        for <git@vger.kernel.org>; Sun, 28 Jan 2024 08:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706459839; x=1707064639; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0X4mVrSge2VOyxNdLqPDSud8ms9voYbecuIT+VBQoB8=;
        b=KuMTrk1acPUAKoinwPc7Z7pXipAtMYDJAL4VZKw4f/iLWlggBq8UaYPmjvmNQrnxO3
         elw0AHOBB8QQ1oBO7j7oKHIAlBn982u/xmraeLR+tpfcCvTsNhrOg/v+PBkIpgHWkONz
         saL8eI3WiNZfLjz5ZsKbEnTFcQrj2sP/BD1krxHq9IPLVbBcpE46+34fq0zoQyjN70c+
         JThVPJHLJ+4ebNqziJmJ1T2dLNY+8ek/Ke6YIG7tNU7c16cBMW3oJrlBnnoP7N6rxN73
         Z/tQzB9ULHOHE+h2Pbzmyvp32GA+UGTlYft5FQGrSbV+nJKdc0nwv+OcV8yAlb5ly2rO
         ju/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706459839; x=1707064639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0X4mVrSge2VOyxNdLqPDSud8ms9voYbecuIT+VBQoB8=;
        b=v84faqkcZ7yF/WVtN4SZKDcw9v6Ug5PGvbhgspU3ROo7L6QOrnXKMnxOy03oS6J2f9
         FmJRiVjMIq0RiK/Q6fxQhg/TZ8KaDXMHD5sOLaDVDZTltYdCmbo8huswQk1dueWSZ2Wy
         CE3aPjQCxv08qbAC6PeVxAE8Ft8vzAxSIdcuPs8cSY2eLJYFOZh9FGIu/ApKA/t6ihi1
         MhUaT/LZ5A9EE/+4RsIr7iETfhMlVMCNxrWQGPxt0XirRt0dL2/NiJUuX+JeqXLu2QXs
         KlZA0DysWs7my6gE0xmj9aKN2SYZqGqd1qnM6EQ3S7lRr/V2kifmVbTgBYc+LNrT5BQc
         RmvQ==
X-Gm-Message-State: AOJu0YyQBLuhukKuTclEY14hPPiXiezt70niQd3PDUCDeMFHGdCOKycj
	l5MF8OWLy5VoSSCwHK9qyy1vgGdk1wFeaftXfbJK/4m6khZ+z0H9pJ1PO8v0gFnZmScCvZcNQio
	z3Ubz/YNrXY01S51P/WyVeN6bIZ0=
X-Google-Smtp-Source: AGHT+IFZ1THSoC6a7xnk2OTSPkpZQeIXRXt1Ycm5Mt7aILSAQCaK5KWwAuIp81THO1+anYDr8MxwGgkyTqe230xQovw=
X-Received: by 2002:a2e:b178:0:b0:2cf:1764:891d with SMTP id
 a24-20020a2eb178000000b002cf1764891dmr2251146ljm.1.1706459839153; Sun, 28 Jan
 2024 08:37:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119060721.3734775-2-brianmlyles@gmail.com>
 <7229fe62-cf9b-4829-80ec-c6b44c52163e@gmail.com> <CAHPHrSeKY2Ou9VCq6rtADTOwycc0KCTPaCCwtqf94yLi0wj0OQ@mail.gmail.com>
In-Reply-To: <CAHPHrSeKY2Ou9VCq6rtADTOwycc0KCTPaCCwtqf94yLi0wj0OQ@mail.gmail.com>
From: Brian Lyles <brianmlyles@gmail.com>
Date: Sun, 28 Jan 2024 10:36:42 -0600
Message-ID: <CAHPHrSf=UkR9+hMfb7pp5Y6uHqa2pBrEf+cTLJv=z=BOFdL3rw@mail.gmail.com>
Subject: Re: [PATCH 1/4] sequencer: Do not require `allow_empty` for redundant
 commit options
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[+cc Junio]

On Sat, Jan 27, 2024 at 5:30=E2=80=AFPM Brian Lyles <brianmlyles@gmail.com>=
 wrote:

> > > For some amount of backwards compatibility with the existing code and
> > > tests, I have opted to preserve the behavior of returning 0 when:
> > >
> > > - `allow_empty` is specified, and
> > > - either `is_index_unchanged` or `is_original_commit_empty` indicates=
 an
> > >    error
> >
> > I'm not sure that is a good idea as it is hiding an error that we didn'=
t
> > hit before because we returned early.
>
> I think you're right -- Previously the error could not have been hit,
> but now it can. An error is still an error, and we should handle it
> regardless of how `allow_empty` was set. I'll address this in v2 by
> simply returning the error.

As I dig into this more, I'm noticing that this may have unintended side
effects that I'm unsure of. After making this change, I noticed a couple
of failures in the cherry-pick test suite. The others may be a knock-on
of this initial failure:

    expecting success of 3501.8 'cherry-pick on unborn branch':
            git checkout --orphan unborn &&
            git rm --cached -r . &&
            rm -rf * &&
            git cherry-pick initial &&
            git diff --quiet initial &&
            test_cmp_rev ! initial HEAD

    A       extra_file
    Switched to a new branch 'unborn'
    rm 'extra_file'
    rm 'spoo'
    error: could not resolve HEAD commit
    fatal: cherry-pick failed
    not ok 8 - cherry-pick on unborn branch
    #
    #               git checkout --orphan unborn &&
    #               git rm --cached -r . &&
    #               rm -rf * &&
    #               git cherry-pick initial &&
    #               git diff --quiet initial &&
    #               test_cmp_rev ! initial HEAD
    #

It looks like this is caused specifically by not hiding the error from
`index_unchanged`

    index_unchanged =3D is_index_unchanged(r);
    if (index_unchanged < 0) {
        return index_unchanged;
    }

At this point, my inexperience with the git codebase and these more edge
case scenarios starts to show. I'm unsure how to best approach this. It
seems that exposing these errors when `allow_empty` is not set causes
the entire cherry-pick to fail in situations where it would not
previously. Here is what that same test looks like prior to any of my
changes from this series:

    expecting success of 3501.8 'cherry-pick on unborn branch':
            git checkout --orphan unborn &&
            git rm --cached -r . &&
            rm -rf * &&
            git cherry-pick initial &&
            git diff --quiet initial &&
            test_cmp_rev ! initial HEAD

    A       extra_file
    Switched to a new branch 'unborn'
    rm 'extra_file'
    rm 'spoo'
    [unborn 38e6d75] initial
     Author: A U Thor <author@example.com>
     Date: Thu Apr 7 15:13:13 2005 -0700
     1 file changed, 15 insertions(+)
     create mode 100644 oops
    ok 8 - cherry-pick on unborn branch

Conceptually I definitely agree that it seems odd to hide these errors
just because `allow_empty` was not set, but I fear this to be a breaking
change for which I don't have a good understanding of the impact.

Any guidance here would be appreciated.

Thank you,
Brian Lyles

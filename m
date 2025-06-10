Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1FA268FE4
	for <git@vger.kernel.org>; Tue, 10 Jun 2025 21:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749589918; cv=none; b=jZrE3uLfmYc7I7CDAYQ1zVzO7aZJhVcz2lK3E/H5Ni6IBYsUAYG5mL6sUBuc8pddJnGXS17GphYOGdI8OnZ5cl4KwaBYmnJQQrW7V0pBb61OiGy26xRC6X6qW/enQGhMd42U6Ax4XvsZF+CiJGLTSDh7QBDfd9S/2VTMzniCRRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749589918; c=relaxed/simple;
	bh=2cxkFYUTq2HRcOmzlqzYTnjjVXORHjIu/oyL1+z9pes=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UARJ8wCGW1xW2Xoe5KzMwGihds6cdgvBaagvrd6wKvXm90eutcN2yVOLZfxoE+PwsZEhigXJwUyK0mFiqJnQvt4tThrTAHkSrCbEJXR0PGy7kWasb/PX70U5QGo1UcWwRNthiV/z/HUZK/PVxZ/siWPE65lKmRtcePuWnGEwqW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jKnzoacs; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKnzoacs"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ad88d77314bso1104909766b.1
        for <git@vger.kernel.org>; Tue, 10 Jun 2025 14:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749589912; x=1750194712; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Mqoaw5n4eJsjySmwg24IGS8y7/1krcxObDdGxxKoVo8=;
        b=jKnzoacsmjf9xzCEB/uXRdv9EN2aE4NFa2/04VvMhVJoG01os4A/h1AbWCi/kmj/xe
         gLxu1m+RQMGUqIad29AZIBZE5iIyuesMFhSRmIJ2SJL0kB6uGhUGc1SBeO+gi/0ge68j
         M8H/XJ3SPVqHWqcfR2YenrnMlOLBdLcdq8eENoLYL22akLsptIaF/LJVpoyfPS2oXCdu
         jhOUQAqu8ZJc/jQNjTt4Z2sAAxqyBvHfqwKIz8h1wGZIB7Pu9DsFA8NeaJX0AZ1kGcl3
         LnfwhPsw3ssw8ahbuWbsWnLV20uATklgQsLx/pXwBimY6W8pU0AdgvJeeYQTRmykXmqy
         uIzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749589912; x=1750194712;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mqoaw5n4eJsjySmwg24IGS8y7/1krcxObDdGxxKoVo8=;
        b=aSrc7B38jsfK+ef+f6KflPke8lya57bhkzyb9PdgT+OJ+J9KnHuQ6JEwV0RQuZcQlW
         mkfYTxW4EPQ+t7qcqxkr+AvTmvNaqFDwMvNo821pv3VU4DgFLkmxoS02PKD/YE3nEEZv
         7QRw1BmR7wLh05GxnqmG7w5XOmn5CoTgHjkP0+lVRYI+5dYffeyWXzG0tI/AXMsVrxk7
         ZgEBHvW0FXVZg+Z97FAuE/GQpnZe5TpsAbLeTjvrJZWxvFpVCA7lT/+GgxcazfmrCmTU
         C2Y0yDKcKdDbzPMFtDw7WJF/i0hFSqtMwuJ1zMA6a4x0NRpvgqg2+FJjZXuPjoWo41hc
         ijKg==
X-Forwarded-Encrypted: i=1; AJvYcCXCO2yIsuYVnc7X5tWhNTOXpj1Iw0ata3T2jNakUsJGC+WEK0tesShuRyxhQnHUQ0Ryb6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbU2L8DBU2OBuqwVtptJ9TeOran9O2HMLn8m3i4ldA8wV+yKp0
	1MVjXkl4GpcAUmDoz1mVUuGSiC1GrthkGezrgo5XfU5aqCqtOiGWcok3Q2Z3nxDc5rjqRs6PzOz
	5e8Qm/3yiMHo8v5ofg3BAM3K0CL+E/Tg=
X-Gm-Gg: ASbGncvfbpavX0wgAocd42YXjMIn7o/IK6qIXM3MT6MJ+1DBOoi/Xg8lM2U080usPsU
	AIBAO9o17c0jLPzlXvY4iWEdbpLkJlmNFTWUL3YEMZaXQJI5cKSQp71Qaaub5Pznm94PfktPiez
	LqQROEKEWcFItTMMLb8RL8pFzJou9seBpl57IosfbRfFRoe4dtlmJXStJZABPKRxFEyzplM/luh
	w4tkeTuhpggwODg
X-Google-Smtp-Source: AGHT+IEC/E6KAaO5x7GqNKZYn+mMvRtrTYpZc0QRJgZYoPkWZei7/aPDS2GX0izaP5SQZ1iR6u6HDyZin4gc3y2gbOY=
X-Received: by 2002:a17:907:3d4e:b0:ad8:9b5d:2c1c with SMTP id
 a640c23a62f3a-ade894b77edmr84154066b.19.1749589912156; Tue, 10 Jun 2025
 14:11:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c59ae2c0c7c8420ec1c5bedb87f28c7f5b573a60.1748122397.git.code@khaugsbakk.name>
 <66e92d69-8372-47cf-a350-95365f72ca1c@gmail.com> <xmqq5xhmvuol.fsf@gitster.g>
 <CALnO6CDgcQCuhxcJLH-XwxB85mxqokxsf04CU4yseTy-=XUWLQ@mail.gmail.com> <5ca4e740-d243-490c-ad85-13b330165365@app.fastmail.com>
In-Reply-To: <5ca4e740-d243-490c-ad85-13b330165365@app.fastmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 10 Jun 2025 17:11:39 -0400
X-Gm-Features: AX0GCFuI75bM_efUSi7WmHU60hHMrXFb9wxYn3-56KigqC9noVUqO7ELMLmJJD0
Message-ID: <CALnO6CB+ZBChPg0CLXO+i3AUEwiiF7z5euXa4N3Yh4FoEX4A4w@mail.gmail.com>
Subject: Re: [PATCH] notes: remove trailing whitespace from editor template
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <code@khaugsbakk.name>
Content-Type: multipart/mixed; boundary="00000000000037bbfc06373e250f"

--00000000000037bbfc06373e250f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 9, 2025 at 5:13=E2=80=AFPM Kristoffer Haugsbakk
<kristofferhaugsbakk@fastmail.com> wrote:
>
> On Tue, Jun 3, 2025, at 22:37, D. Ben Knoble wrote:
> >> In this case I am not all that sympathetic to the idea of the patch.
> >> The consistently indented lines makes it more clear from which line
> >> to which line came from a commit log message; running stripspace
> >> would break them into paragraph pieces.  These editors that complain
> >> probaly can be fixed?
> >
> > My editor doesn't complain, but it does highlight trailing whitespace
> > at my behest, and it tends to be an eyesore (on purpose: that way I
> > clean it up). Perhaps Kistoffer is coming from a similar place?
>
> Yes exactly.  Ain=E2=80=99t nothing more to it than that.  :)
> >
> >>
> >> Alternatively, if it bothers users of certain editing environments
> >> too much, perhaps the indent code in the output phase of "git show"
> >> should lose the indents for empty lines uniformly, shoudln't it?  It
> >> probably should be a fairly isolated change, like the way how the
> >> expand_tabs_in_log bit is handled in pretty.c; give another bit and
> >> teach pp_handle_indent to return when that bit is set and the
> >> payload it was asked to show with indentation is empty, or something
> >> like that.
> >
> > I think this suggestion would also help folks who "git commit -v,"
> > which IIRC is also indented in the template.
>
> In my testing though it doesn=E2=80=99t introduce trailing whitespace.

Really? When committing a recent patch (editor template attached) with
-v (for testing this), I saw trailing whitespace on the blank line
under the added feed.

>
> --
> Kristoffer Haugsbakk



--=20
D. Ben Knoble

--00000000000037bbfc06373e250f
Content-Type: text/plain; charset="UTF-8"; name="commit-v.txt"
Content-Disposition: attachment; filename="commit-v.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_mbr0n9wx0>
X-Attachment-Id: f_mbr0n9wx0

bmV3czogYWRkIG5ldyBmZWVkCjsgVmV1aWxsZXogc2Fpc2lyIGxlIG1lc3NhZ2UgZGUgdmFsaWRh
dGlvbiBwb3VyIHZvcyBtb2RpZmljYXRpb25zLiBMZXMgbGlnbmVzCjsgY29tbWVuw6dhbnQgcGFy
ICc7JyBzZXJvbnQgaWdub3LDqWVzLCBldCB1biBtZXNzYWdlIHZpZGUgYWJhbmRvbm5lIGxhIHZh
bGlkYXRpb24uCjsKOyBTdXIgbGEgYnJhbmNoZSBtYXN0ZXIKOyBWb3RyZSBicmFuY2hlIGVzdCDD
oCBqb3VyIGF2ZWMgJ29yaWdpbi9tYXN0ZXInLgo7CjsgTW9kaWZpY2F0aW9ucyBxdWkgc2Vyb250
IHZhbGlkw6llcyA6CjsJbW9kaWZpw6nCoDogICAgICAgICBsaW5rcy9uZXdzYm9hdC91cmxzCjsK
OyBGaWNoaWVycyBub24gc3VpdmlzOgo7CWxpbmtzL2Jpbi9naXQtc3RhY2sKOwo7IC0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLSA+OCAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KOyBOZSB0b3VjaGV6
IHBhcyDDoCBsYSBsaWduZSBjaS1kZXNzdXMuCjsgVG91dCBjZSBxdWkgc3VpdCBzZXJhIMOpbGlt
aW7DqS4KZGlmZiAtLWdpdCBjL2xpbmtzL25ld3Nib2F0L3VybHMgaS9saW5rcy9uZXdzYm9hdC91
cmxzCmluZGV4IDUyMmQ5NTVkLi5kMTkyZGU4YiAxMDA2NDQKLS0tIGMvbGlua3MvbmV3c2JvYXQv
dXJscworKysgaS9saW5rcy9uZXdzYm9hdC91cmxzCkBAIC0yMSw2ICsyMSw3IEBAIGh0dHBzOi8v
bG4uaHQvXy9mZWVkL35kZGV2YXVsdCAidGVjaCIKIGh0dHBzOi8vbWFpYS5jcmltZXcuZ2F5L2Zl
ZWQueG1sICJ0ZWNoIgogaHR0cHM6Ly93d3cuZmVsaWVubmUuY29tL2ZlZWQgInRlY2giCiBodHRw
czovL3JvbmplZmZyaWVzLmNvbS9mZWVkLnhtbCAidGVjaCIKK2h0dHBzOi8vZWV2LmVlL2ZlZWRz
L3Jzcy54bWwgInRlY2giCiAKIGh0dHA6Ly9qb3VybmFsLnN0dWZmd2l0aHN0dWZmLmNvbS9yc3Mu
eG1sICJ+Qm9iIE55c3Ryb20iICJ0ZWNoIgogaHR0cHM6Ly9ibG9nLnNhbmN0dW0uZ2Vlay5uei9m
ZWVkLyAidGVjaCIK
--00000000000037bbfc06373e250f--

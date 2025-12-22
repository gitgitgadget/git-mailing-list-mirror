Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D9633F8C8
	for <git@vger.kernel.org>; Mon, 22 Dec 2025 13:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766411272; cv=none; b=A81T6orTjbLOmCBV7OvYDLVvEpcZosMkaWkurG4opyHjyk5FZhzz583rC+2ypcfDH0FxZlZxwtF/FHce0qR7/GuZXLUgSclhn1s0zssDVyW0AOuexIitP870utijEn/M3tgPk0iZbltvzXxLEMJUYnyQvJCIunqyt1PHonGE0lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766411272; c=relaxed/simple;
	bh=ZM49pdvesCRCqmFjZH6bbbAgEDU060sIx1DiTs3qlCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l+u7QzGM2c0r95OjZoskEuLpaZpy5yf4BygjnKBv3QFe9RjKK9JBnT5JJMqoIn374w+8w7NK20SkKI9eWmj6ZhfeCgHDtsQVqnz1WUbCHvdJCfQkroMYchS0fCj+6e0zQbQP1jJON/+n0DDxsWT77xT1t0XG8glHPppTwKawuog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hGxxoOv9; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hGxxoOv9"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-34c2f52585fso3405590a91.1
        for <git@vger.kernel.org>; Mon, 22 Dec 2025 05:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766411270; x=1767016070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yXJ794or44R3tBXMaXabJifFgnqKtrJrhPfTNsUY2pQ=;
        b=hGxxoOv93gV/+O5EmwT71hN2lBk7xc1kZOVoA+cJ4ev0032aPNqpWijpZCbQEwV48Y
         vNyoBmotcrmIwEcaDvzP7n9FlQZiYmV1fbW/W6YJh0la7hjsS4a53ydQx4LBT34UksSi
         E6e3d36c71SCp/Kl4gTqiEtKzfSz/vNUyV12eu1G95UcjkoZdXXBx9yl0Stm+NG3rCoF
         A2J1qZ9qlPVClzXsQ2m2qE1Msyi0SH5LLh09cGuO4fbklpHfpYU9JcfyEps54MpizyBw
         3GY5RdOc9DVKlGjG+8oR8XWHf297Nnhu6CAuxvN4fgWTL6DmDlRRVKNT8xCKjVvRPUId
         IYlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766411270; x=1767016070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yXJ794or44R3tBXMaXabJifFgnqKtrJrhPfTNsUY2pQ=;
        b=ater3005xiO6cuk+U+ciL8nLYkYuhrNWCK8aF0VcM4u6GnD3eRQfLzmiwfq4Lx3OCo
         eROrBz2hNGqGDnGu2LaxR5Ouu6Xdn9P8e11QbPNKhcAzCgpFkGwNqnnFCnzNZ7mrdUhC
         ppPSEqrzjKGkodG8o4P6VVDfCA9QMYPc1npyXL12eqoJ+oLRRxzARlVNigJ77JshIGGo
         NIAM+qwEqnUh3XDLTnt+3zt/U8ZcQPbOHml+Bb5lxRJ0xSi3A1yzMoYEnPNDRBBalNIg
         8VMSFyx6Y8Xn9NQIwEm7Uj8/vkOzJ/GUVeXClqh/C/CGjTqw6qX/MgdwhCdXLX3aXakN
         /jdg==
X-Forwarded-Encrypted: i=1; AJvYcCWL/nl5ue13nCTizAqhYaVvGE5nAyJUzAjE4xIT+1Wtn0SAQGwujjSYQ36O1Vw8KNL3YaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuvOF52ptEtBjFuBdEeaoLHnUv7i/eMFFitiM4wMF64OV7wOND
	zmJWU4gLADuoU27baAVYagYOttct/FKhadRSgGtDrnwp2Nk6qH6BuTxDtCXmUIukIo3xLeb0kI8
	a0ezW9cyBbvEsoC0Cx5E/A0HGwBChLp8=
X-Gm-Gg: AY/fxX5Eie4XKQeyTo+zF47bfpwy4tbcmrNclAxB4A2KlXfhcKAXo8GMGV/U4lqOA57
	dwfKFnqzc/a8MBj9f/Lj+C4EcWo9OMgMEe61bqy+v2Bcf3XCy+OEETpvxwTxPz5b8uaZU+icl+9
	xkSqy0Ql03wc4d+XSDMTn08+0wJU2B3RiMY+EJzhFO46+e2RZhem1pR1JVznaipf/l+3h33Rv8k
	j3+apakJnG8brgqhoek5X71zzmKYAkf3L39OciVWU7x7WHFdV1SCyxcIMZhZuyija4spJ1TXw6n
	0goKgpgMBLBGTgbxOeCwFuKj2yCbMg==
X-Google-Smtp-Source: AGHT+IFVYQuvNNeT91+UmkMjRGyiyP+cHpQav/qntp4oJfpngGgZIzIGA/Al+lppQyvUm86MIULiMncoWq3e9+OaxxM=
X-Received: by 2002:a17:90b:2585:b0:32e:389b:8762 with SMTP id
 98e67ed59e1d1-34e91f74301mr8283545a91.0.1766411270257; Mon, 22 Dec 2025
 05:47:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
 <CANiSa6gXbrZaMLVq-AAg38sm+7qgzn4w98WWowLtUHA2P+BdLw@mail.gmail.com>
 <aKs3tqjE510MF0T-@pks.im> <aMsWL2cSoytbmRjA@szeder.dev> <4m6rmefbv4hftclimitz5rp6yapswjtnjsxymrsdkuan4jbg3u@dm5jzdiq5cxz>
 <bc01706e-b9cc-4cd4-953a-971a3ccd6c79@gmail.com> <paqf2ko6kcm5qdcqxqz57qu6gjw3vf6boabjsryeugfnlzzb7z@4dzqo6jug6l2>
 <a6efc710-4062-4955-8fe8-bb6d428a44c1@gmail.com> <xmqqms3qh13e.fsf@gitster.g> <aUVDax0PbkaXGB61@pks.im>
In-Reply-To: <aUVDax0PbkaXGB61@pks.im>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 22 Dec 2025 08:47:38 -0500
X-Gm-Features: AQt7F2ocpj8EzxSmUDMs8z5tKLQ0bd8KpRsA21gQ_JaTPKFqYsRt7PtxnW3vyWI
Message-ID: <CALnO6CDCRgpgsU1W38NDXe=Gzk9qpTfdTSHXf3TXVH95CmxrtQ@mail.gmail.com>
Subject: Re: [PATCH RFC 00/11] Introduce git-history(1) command for easy
 history editing
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, Phillip Wood <phillip.wood123@gmail.com>, 
	Matthias Beyer <mail@beyermatthias.de>, phillip.wood@dunelm.org.uk, 
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
	Martin von Zweigbergk <martinvonz@gmail.com>, git@vger.kernel.org, 
	Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[resend] I originally wrote this before some of the fruitful
conversation replying to this message, so grain of salt. I think my
questions have been answered in terms of how --update-refs behaves,
etc.

I still don't think we lose anything by not deviating from other
commands now, but I also agree (perhaps to come later, actually using
the experimental status to break things?) that I don't want to have to
remember to rebase descendants myself.

On Fri, Dec 19, 2025 at 7:48=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Wed, Dec 10, 2025 at 11:18:29PM +0900, Junio C Hamano wrote:
> > Phillip Wood <phillip.wood123@gmail.com> writes:
> >
> > >> Its mostly because I don't like too much magic and because I think b=
eing
> > >> explicit is always better than not.
> > >>
> > >> So from my POV, I would expect "the simple case" to be "the simple C=
LI
> > >> call" and if I want the tool to do magic and "rewrite all the
> > >> things"^tm, that I would need to specify a flag for that.
> > >
> > > Thanks, that's useful to know. I'd assumed rewriting all the branches
> > > descended from the rewritten commit was the natural thing do do but
> > > clearly not everyone thinks it is.
> >
> > It probably depends on the way one looks at the tool, as a building
> > block (in which case less magic may be preferrable) or a complete
> > solution for one part of workflow.  I probably fall into former camp
> > more often than other people, but for this particular one, I tend to
> > think it is less confusing if we moved all branch refs away from the
> > commits that are obsoleted by rewriting/replaying.
>
> Okay, so the majority of folks here seem to favor rewriting all
> dependent branches, which is also the default that JJ uses here, and
> git-replay(1) does it, too.
>
> There is one major difference between git-replay(1) and git-history(1)
> though: the former works with revision ranges, whereas the latter does
> not. By using revision ranges we avoid the problem I have mentioned in a
> different branch of this discussion, which is that we have no easy way
> to figure out which branches we'd have to touch in the first place. This
> is because we simply walk the revision range there and then look at
> which of our references point into that range. That's simple enough.
>
> But in our case we're not working with ranges, we are working with a
> singular commit. In my head this meant that we'd have to basically do a
> revision walk that starts from all of our branches so that we can figure
> out which of them would eventually reach the commit that we are about to
> rewrite. And that of course doesn't scale.
>
> Now we could of course also introduce ranges into git-history(1). That
> would indeed solve the issue, as we can reuse the same architecture as
> we already have in git-replay(1). But I don't really want to go there as
> it is leaking complexity to the user: they want to rewrite a single
> commit, why should they have to think about ranges?
>
> But now that I've thought about the problem a bit I think we can avoid
> that issue by implicitly identifying the range: it's all the commits
> between the commit we're about to rewrite and HEAD. So, same as with
> git-replay(1), the set of branches that we'd need to rewrite is any one
> branch that points into that range. It keeps the UI simple as the user
> still only has to think about a singular commit, should be sufficiently
> fast to compute in most cases, and it allows mega-merge workflows like
> JJ supports.
>
> Does that make sense to everyone? If so, I'll revise my stance and will
> adapt the current implementation to do exactly that.
>
> Thanks for the discussion!
>
> Patrick
>

Makes sense to me, and is easily explainable.

One thing that I think JJ handles and which it sounds like replay,
history do not (I=E2=80=99m not sure about rebase with update-refs): stacke=
d
branches that point to a chain of commits reaching into the range, but
whose reference is still outside it. For example:

A <- B <- C

If branchB points at B and similar for branchC, and branchB is HEAD,
then =E2=80=9Creplay <stuff> A..B=E2=80=9C and =E2=80=9Chistory <cmd> <A|B>=
=E2=80=9D sound like they
would leave branchC alone? That means I have to remember to do
something like =E2=80=9Crebase --onto=3DbranchB branchB@{1} branchC=E2=80=
=9D, and if I
forget I usually have to later replace branchB@{1} with branchC~<n>.

OTOH, it means branchC serves as an additional backup of the original
branchB pre-rewrite :)

Anyway. If the other commands don=E2=80=99t support it yet, I don=E2=80=99t=
 think we
lose anything by not rewriting descendants. But something to consider
in terms of workflow.

--=20
D. Ben Knoble

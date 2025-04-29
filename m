Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D38253F28
	for <git@vger.kernel.org>; Tue, 29 Apr 2025 19:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745955367; cv=none; b=clWLdTqA2NXg5pRAMzwHiIjPH2OX6tdY510PszcBgj2vP0jWD9KelXJCmtI/Ie+And2V/Ms8UKFpt3bGbeErrtB1dvjZV3HPkvX9CjsILje+taXDYkxTVUltCVlWPL7PQZaFpzkBamEk7nCfWEENnum8PrvNcBGT2f9IYkARpXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745955367; c=relaxed/simple;
	bh=mTRNjQFeNOI887VJiO5kJMv3IsmoJCB7aUfiLq2Cl/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UY7pkS48Nb+pjzE2CrRq5eEkhnky8pOkevFn+QUbj/RUSTxOqHUUFhTDpR2+67tPs/WZQPlQEpYPJUUtmJ2uM+7Fa6tlIRJWEPxgiRFeWu2o3OSuf522JKmuHfxffaV5faJN8t9mEPLInFYFFdXAJ5TiAMZbRpa4suwSNJ3+1Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=klerks.biz; spf=pass smtp.mailfrom=klerks.biz; dkim=pass (1024-bit key) header.d=klerks.biz header.i=@klerks.biz header.b=TychVbLj; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=klerks.biz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=klerks.biz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=klerks.biz header.i=@klerks.biz header.b="TychVbLj"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-310447fe59aso73078391fa.0
        for <git@vger.kernel.org>; Tue, 29 Apr 2025 12:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google; t=1745955363; x=1746560163; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ty3zRCdTLWw5gAgivOWOPq/ObTFCQBZ9/D3CcRJvjbw=;
        b=TychVbLjLJ1W/AmfYGVa5tcWm99ZpMsbK4NTXpyTwvd4qa234e5dl7W2GRrgsLsc1D
         bgClWgUoY3reVIhAr9Abw/v/e3ATMEYaIzxTYX4sZpcIlKBc6NqJAziRGfKyXrrrthBG
         IQBETIKAhiEpWwEOL/FbWpiQCIA9I0D6n1l7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745955363; x=1746560163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ty3zRCdTLWw5gAgivOWOPq/ObTFCQBZ9/D3CcRJvjbw=;
        b=rTtvJL7DwH3lyAB0iOXLMKa9v6RZLltOXcSaWOb3ka4dNNhsOsSF7Xg2egTK3uMoDp
         Hl/4cMxYxDcXyw2y3GcdXkrqsKYdU/ZECywzPdFoIqxMg5LiF4QrncY42iZLpQ67pZOo
         OQWJQWJ67RVRmKVtQKBCJKe4IBxSAjArIGp//H14hSx7smvASkEdVbz67oVf12XLtL7s
         Fp+U/FsgLsTmNICRFjVsNNiGS6E2jCn/qhXzzYZXnh/QVUwrqzOiDgw/qb4OBxLWrpTa
         BwNOnbebv46w/45P7fl/UgzoAFol4ntWgf8uYYwSmDP3Qrq4yWofwASP5jaXdveKdz7J
         Ctqw==
X-Forwarded-Encrypted: i=1; AJvYcCUjgDTlilM0DTCkFnyU8Pzo9DAj2PHBO1D7dSexl/cHoAMP5uu0SUQyUQ4a0r4Mu+0uLuc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym30bRuEMeL8yuE9etahS6J46o93Vj4d1adTqUZmkSoQX5kDzr
	01KrhXi/TNjkV1UtvdKr9irDvdDez0a/dC6jJubW4uxt3GkptXezgSNu6OvgA6Bnq+NbmNCgrj1
	MZUDgCdBSLeWk9Itnt2uiDrMnYHxnIyT0jy5U
X-Gm-Gg: ASbGncuop2XGkr6aiuyFrAWzGx9KBSAWgsCz2vfZQEZG61w9ze5H/CYhbz6cJcIlc3J
	pGHCsa8SGuDhDfH+WKKdSnxuu8ApVLeG4FwUfxp+rtZWVVJz8YAL/nJizOp8EIL1hpqqnzjHL3k
	brxKB25YRw5/WMhN2cJQ==
X-Google-Smtp-Source: AGHT+IG0q3aTobTxuKHe/t2YXJcfOE37LBHr+jo3wEsU3gP6B3f0AnBAgZl8tPzxmeIlstbbPr6AwgF4TQfnAcL+MzY=
X-Received: by 2002:a05:651c:312a:b0:31a:4906:fcfb with SMTP id
 38308e7fff4ca-31e69a2cba4mr1277241fa.7.1745955363197; Tue, 29 Apr 2025
 12:36:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1903.git.1745651452869.gitgitgadget@gmail.com>
 <aBCt8YrqJ7IM0ld6@pks.im> <xmqqh6266c1c.fsf@gitster.g>
In-Reply-To: <xmqqh6266c1c.fsf@gitster.g>
From: Tao Klerks <tao@klerks.biz>
Date: Tue, 29 Apr 2025 21:35:52 +0200
X-Gm-Features: ATxdqUHYEOhJiCCGRDKYuapBhYagy-sh7KtKJRg25gc7LvyiIgiUimgj9lvExX4
Message-ID: <CAPMMpohgEXVPHKCQtvc-zLC35qtY+qJ9WgQO_quOgUG01eyTOw@mail.gmail.com>
Subject: Re: [PATCH] replace-refs: fix support of qualified replace ref paths
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 8:46=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Patrick Steinhardt <ps@pks.im> writes:
>
> > I wonder whether this really was an intentional choice or whether it is
> > simply a bug that led to useful behaviour.

I don't know that for sure either - although the fact that we *do*
already have sanity checks against multiple replace refs targeting the
same object id leads me to believe it was intentionally allowed.

I tried to explain why this is useful, and why it should be *better*
supported, in the change description: *without* this behavior, replace
refs cannot be "namespaced" - they are always inherently an
undifferentiated pile, and that in turn makes *sharing* of replace
refs completely impractical.

>
> ... where the "funny" replace refs are honored in some but not all
> situations, it also can be argued that it is highly unlikely anybody
> sane is actually depending on this "feature", so such a tightening
> may not hurt too much.

Well, I guess my sanity can be reasonably questioned, but it would
certainly hurt me and my thousand plus users - we use replace refs to
keep nice tidy squash-based history by default, but allow for
different types of "deep blame" by setting up one or more fetch
refspecs that map into "refs/replace/SOMETHING/*"

>
> The reason why I would slightly prefer tightening the rule, rather
> than making the loophole even larger by adjusting the code for "the
> commit decoration process", is what it means to have two different
> replacement objects for the same object, which would naturally be
> prevented from happening if we did not allow extra levels in the
> middle.

This is already accounted for with a hard error: If you end up with
duplicate replace ref targets, many operations fail with a clear
error. Clean up your replace refs and you're off to the races again.

> Would one always consistently trump the other?  When a
> filesystem rebalances, would we just pick one at randomly based
> purely on the first one readdir() happened to return?  It smells
> to lead to nothing but a confused mess.

Reasonable concern, but already addressed.

>
> Maybe the answer is "don't do it, then".  The same answer, however,
> can be given for creating any extra level between refs/replace and
> the object name itself, so...  I dunno.

The same answer should probably not be given: One behavior is
*useful*, and one is not.

>
> > If we can agree that this is something that we want we should definitel=
y
> > amend git-replace(1) to document this new format.

I will (propose to) do so.

> >
> > Which raises the question: is this something that we want? Are there an=
y
> > arguments that would speak against loosening the format of replace refs
> > now?

My point here is that it's *not* a loosening - this "loose" behavior
already exists, it works, it is useful, and there are people using it.
At least my thousand users. All I'm proposing here is to show them
less spurious warnings when they run a log with --decorate.

>
> "What if refs/replace/{a,b,c}/$name point at different objects?"
> would be a solid reason why we shouldn't do this, but I personally
> do not feel too strongly about it, as "don't do it, then" may be a
> reasonable answer for such an insane scenario.

That is indeed the current outcome: don't do it or you get a hard (but
nondestructive) error. You can then of course fix it and you're set.

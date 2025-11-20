Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBE3354AC4
	for <git@vger.kernel.org>; Thu, 20 Nov 2025 18:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763662743; cv=none; b=EUYW/v7VbkKVTABYJ0EEIX4NXtZzij2hR8d5IPqNxIk+ZZw+tP5PY20wPQX7dalV5GLqr8axkpVZjr5O80RLnLPL8o5yjf+nIDjCvjY3q2aML8BDyFIIbvMPQ+D7I0fMwRQlKRBf4lT3lkNY4Zbn+2bjNA2Kg5p/TZKAzAP+y3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763662743; c=relaxed/simple;
	bh=iooTa0BOgZQ2MEfaKyV8F4Rofp0V91JyUzjvv2CJf6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AMve1MbxxF3VKWq7ET77HrGFeSf8jj7AzckyLuRsjIg2wo9S5YgwovS1WeFUg7IaoQ/J/udvC3EXupDotsnZFHKhAnNatlILhwCjDoo4/d0GlETIt92TBHha2maL3qWKOOf9m9zF4SljVfSMTxomZHTldmS2k3egXng05vh08uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C2zGSTPa; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2zGSTPa"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2984dfae043so11686505ad.0
        for <git@vger.kernel.org>; Thu, 20 Nov 2025 10:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763662733; x=1764267533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1BrywyG1hOy7kAv+f091SDz9V2pzLBp1xF0S6DsH1Q4=;
        b=C2zGSTPajyYnyhQSCgBGuGCLAbJY3cNY8DEfB5Cga6QXzgxOcr/VoPXAXnoekpeqT7
         Tc8uVnUuLSbDXEMt8WjOYoWYSa+OXVjiSzaEW55UGOfB6ggbfjtR5E9PJDZMrBlvlk9m
         0Ay8UxoxSxGDF0VJtKWFeyjnK6YA5RM4L3aQ20lM3OdCfV6BO7hmCrk5zf1HKkSz698H
         WDDvTvQHemrHTXYjuwfHArlfb8h59kW2MbmI0k+5QGczkuui5mi/8GLqzrTVtXT68COX
         ROlT9qQ61GXJlYt+dzoisUc4EAepkCq/fvxThQ7jcItYjKjR7ZQdo8NzN3dXSjgl74eP
         2s9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763662733; x=1764267533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1BrywyG1hOy7kAv+f091SDz9V2pzLBp1xF0S6DsH1Q4=;
        b=cCL6AOyQ9elSzw/NyzRc4CuBWEXdYMbqVt35I+JBumzo7JcmVQw23dCRd21c/IZGNH
         oEl5RIFmFaxBDeVxQGtDJ23kuYM+prwA5N5S+yAG2iS9CrLEGfe21cbjTAK6H3GCwDwJ
         7VzY5UmBO+6w9GaJHCATaTR+iHFHpIOcu6YBoYTdBuaY2cFjpu5qOGnHiYmOfViTCSZ9
         ntSI8vbjBpOaQBHs1ECScKB3k4C0W463WnfmJw/HqFDyi6RRNcmd4RiZgrEmSifd5nEL
         QmAjVhpF0DCtORCEspN3sVQ6zHEeshBUDNCaTa3Dgxh16fEmtJZV5FZG9ygwzA5mH5qW
         SaDw==
X-Forwarded-Encrypted: i=1; AJvYcCVPdKv76VESBOGHa5JvZIeTgtm0qkynZSnGwtb9t5qxBsuQXMR2bsB4x7yD1sD4vX/Zuqw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl6kmWOsQQ7ya8nXxXTwnNE84BHUH0WSmvwkxYJUgLOoR9S5Qw
	yU+Vp89ro6qyqkv8iijLewU8Np80gWEiy+zfMqPnSdT2S+/39D+QofRTWCuUxHyYLS3XTR46ckr
	p2D1c77EZx93/bj5Wt/aRNOYkY8yzyIuxPEjh5nU=
X-Gm-Gg: ASbGncsjyv3CVeUn3hWOAkVRMkO6gGWjltdgDOvOYQpTAKgQaARsR0Ij5dc0vg6iiF+
	CCabmwuTi+IKSkU2QCew23wWxiY1HBf7UbqSoQ74r4fNEK8nfxIh7sTgtDObx56+jEcjkO5I2jm
	Cy/B/DVrR9oxoo5J5frGBFnGDsL02lgkBe1XmGZ+AbxENa9ibt+6YQF57Ai0UvWZl2jRfd2L+N6
	nwQgvGGS3UiHroU+6Wr0xGK40MjgfcDG9I1ytz2yzvYi3eeFCN3NHSvacLjwVXpLFV88gWUYPVt
	u7A8EJior32DClG/HGYSQylEExQhrA==
X-Google-Smtp-Source: AGHT+IHHh/FqaRfEcKyEDKXDiRJco5H7vXR/iNX2CkM6e6ACbdWqqWKnWJwE0cUWLTmNgQcl3ZyoI6UaMuE76ztW0uM=
X-Received: by 2002:a17:90b:2243:b0:341:c964:125b with SMTP id
 98e67ed59e1d1-34727c4bea3mr4168090a91.31.1763662732896; Thu, 20 Nov 2025
 10:18:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2101.git.git.1763232863.gitgitgadget@gmail.com>
 <39b17bc64ff0d2e4162437ab745845c055315037.1763232863.git.gitgitgadget@gmail.com>
 <CALnO6CBzE-+51LfgjpEv665oG6kZG9_4YZTv8qgqtNrhh+a-Bw@mail.gmail.com> <CAPig+cTpDdTceBSYoVRBS7wKoSxURMeTA7TruiAmjgTX4B=m5w@mail.gmail.com>
In-Reply-To: <CAPig+cTpDdTceBSYoVRBS7wKoSxURMeTA7TruiAmjgTX4B=m5w@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 20 Nov 2025 13:18:40 -0500
X-Gm-Features: AWmQ_bnDuWyiB30mdIR49tP35ge_f12lTKxgCJXnH-N3YjNT-KVDo0zsNytD--M
Message-ID: <CALnO6CDin=zO5EBU2fC7xj6N9ZtAw0ge=GC=TRtE=2dM65+UxQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] git-prompt: add quiet upstream indicator option
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Kiril Ivanov via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kiril Ivanov <ivanovkirilg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 1:06=E2=80=AFPM Eric Sunshine <sunshine@sunshineco.=
com> wrote:
>
> On Thu, Nov 20, 2025 at 11:10=E2=80=AFAM D. Ben Knoble <ben.knoble@gmail.=
com> wrote:
> > On Sat, Nov 15, 2025 at 1:55=E2=80=AFPM Kiril Ivanov via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> > > diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/gi=
t-prompt.sh
> > > @@ -275,6 +279,8 @@ __git_ps1_show_upstream ()
> > >                 "0      0") # equal to upstream
> > > +                       [ "$quiet" ] &&
> > > +                       upstream=3D"|u" ||
> > >                         upstream=3D"|u=3D" ;;
> > >                 "0      "*) # ahead of upstream
> > >                         upstream=3D"|u+${count#0  }" ;;
> >
> > Our coding style also prefers "test" to "[".
>
> In this bash-specific script, the normal project coding style is
> relaxed and `[` is used regularly, far more so than `test`, so use of
> `[` here is appropriate and consistent with surrounding code.

Good to know, thanks! That'll teach me to respond without looking at
surrounding context ;)

--=20
D. Ben Knoble

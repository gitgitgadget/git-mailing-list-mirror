Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2127932A818
	for <git@vger.kernel.org>; Fri, 12 Sep 2025 18:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757700876; cv=none; b=XfVHtbgJfd3pgDGi/2xCVv7Bt5Vj8HWSe4k7vHCVVSeROemY0ol/jbYczfvrTZQhlLDxxnJUkac8ymdRFRnmDxLzfyMutU8qjsTBNUGK6L3DkvDDQdbw8nobmIBKgW2NJqzsWUfv91/ey9is/CzQ4wMqeFWGvBD4JFr462Ng2Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757700876; c=relaxed/simple;
	bh=tOxvFNx0Mi6QWWLhW2Uem2E+FRbWpES11kEdpZ3NAZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BIbywoF247fFPTO64cmOy37cMthBbPdktKrl2Tl/HV9FGkDMnqFf8o252SPK0VrAQn9qtITnp/zGrUMplzK4/Sk/KiWHIh7aq6nOmC224E2ghcurh/lVV4eeMVjPKuhkluCUaB14jN2kRsdYPvvYRBVn/hQfbRSzcIluIF4TB80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=krlo50tB; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="krlo50tB"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b079c13240eso365865966b.1
        for <git@vger.kernel.org>; Fri, 12 Sep 2025 11:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757700873; x=1758305673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ykPEwCvEDNhI7W5snGTWshHaQ6IgY/9lNg/pVehnhXI=;
        b=krlo50tB++vlGfXeN0+LxMZZOBaALHTrzTHij/uXX0ssFEvzNGcAif92p36MpypHcH
         cyuGsK5zu/oH64bLj5JjwaWjwwPLGcANuI7CoPcVK+qV0tzYGYNAs6YI/6TBXp3K5Y5h
         ZtNTTUMj8XcEvWEzkm/HTfaVz8FYJU4kdbpWhoEfnlAMSesehH+8HwzRw95rJ3VubPVE
         VUImxO26EUYwB98LvGTqqhsxbhAL6XAgJLlscG4O05MYAAtqE1VnjBa5HyzLlnOsjWfC
         MxLAD4ogqnnOm6TxL42ou1zM3F+GxmNb56+twMbZu9b9ztA40ZKJNoLiQDcyXwsOD7sG
         82fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757700873; x=1758305673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ykPEwCvEDNhI7W5snGTWshHaQ6IgY/9lNg/pVehnhXI=;
        b=rDdfIn/MrD2jegxln3Q5KCRbd42ygoP6c59EVfyB3JLn0JJdzv0pO+oTj+s/2B2R6W
         CKfbliCs7FkYpW1+sdZVFrfIw9w50C2qsbwkJ/EKu9xGJS+o5glSPDfFQXhrMgKTlLiH
         vlqF/P4rHmsp6AFH+NOR/+Pn4M5gEriZzA4d14aL/XFJfa3eoc+Meu3rWtngc44t1LI0
         4CV1QpXGrlDU8UIpvh6a67GeAxn8DJc9ZqL29btokkryKBOMpM8CNtjm90y1Psrg00mU
         R3PUlgWeNIDD/7up8WWQLniG8SJsn0ViagvhTKjTvxweUaFTQoscfye1T+OHhv+uGwdn
         rvSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpb6hpZjuC/gFunLeoySISl0tmoZ8FN3MdFn8YtFETqLrgdMwwzyG4qcPIrSufbSDeaNw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzSVmw0VJKU+p8KXi2ZfoHUewO586ufuJYuTT7lYc9I+feUtOq
	AzUYaP76cB1oCzM6HgluT7ZmOYteN/i07+85Re8Df5s/kuD40FsDeeNr7hpcOzKVaztFm0MQlQJ
	Fhplqd0+FlbaeqOr06fvLdiQkdhUUUYo=
X-Gm-Gg: ASbGnct10vsiCOZhUaSyB5OqgJmMkX2KgNF/0gowdy93zWBOPjf93JrhctmEFPOui/H
	s7G8D7VqfsWrFdFyRWbcsxB8e95RkXG/4K23QP+hBZCp3XQaolgnGmuBhNTBx+L2Z6hWilBJTJQ
	pJ3hcqKumvgH9MBvdXZzwRBGBIPGsJLVj0ZrjcSwyi7rVNTlQ16TZhN+jAnR8oj6qQwWZiusmhT
	vJf3T8QauhKZgxnDuQip9cERuhZaLTTb3KQbYPi6v82xmOk0OC4M2+tw7X1Q+g=
X-Google-Smtp-Source: AGHT+IHoy2wwcbc+eYaJpggc20MJhUoEOeutbhn8dZ8iBxVGefTvDpvGcWNCEltWGXby2dhPVMP/MA2Ux8tyg/Xmg1o=
X-Received: by 2002:a17:907:970b:b0:b04:616c:d762 with SMTP id
 a640c23a62f3a-b07c335324cmr343799266b.0.1757700873185; Fri, 12 Sep 2025
 11:14:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512-pks-contrib-spring-cleanup-v3-10-32e151b0bfb0@pks.im>
 <5580aa89-09f1-426e-8483-c99481c998ab@gmail.com> <2b3c951b-0400-4cc5-b790-17ff77154ec2@app.fastmail.com>
 <e6003a2c-bc1b-4cf5-aae7-ef5aa9c82f10@gmail.com>
In-Reply-To: <e6003a2c-bc1b-4cf5-aae7-ef5aa9c82f10@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Fri, 12 Sep 2025 14:14:22 -0400
X-Gm-Features: AS18NWDm3gIbCGBZFqN03FJNR4wIn_T-6H3M1h3ebnkdsse7391FtuenX8jYY6c
Message-ID: <CALnO6CBDcDEXe3a_mpdwTi7ujL-fU5QrDeK704X+5bbkpNgb5w@mail.gmail.com>
Subject: Re: [PATCH v3 10/11] contrib: remove "git-new-workdir"
To: Gabriel Scherer <gabriel.scherer@gmail.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Patrick Steinhardt <ps@pks.im>, 
	Matthieu Moy <git@matthieu-moy.fr>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>, Elijah Newren <newren@gmail.com>, 
	Eric Sunshine <sunshine@sunshineco.com>, Todd Zullinger <tmz@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 11:23=E2=80=AFAM Gabriel Scherer
<gabriel.scherer@gmail.com> wrote:
> On 08/09/2025 11:58, Kristoffer Haugsbakk wrote:
> > On Mon, Sep 8, 2025, at 11:28, Gabriel Scherer wrote:
> >> I understand
> >> why its designers felt that this would provide better guarantees (it
> >> is not a good idea to mutate branch names that are checked out
> >> somewhere else), but checking out various branches to test them and
> >> inspect their code (before returning to the feature branch I am
> >> actively working on) is a common part of my workflow.
> >
> > I agree, that=E2=80=99s a great use of worktrees.  But I never feel lik=
e I have
> > to checkout the branch itself.  I detach on top of the branch.
>
> I'm afraid `git checkout -d` is not part of my typical git workflow. I
> could retrain myself to use it, when I get into a worktree error, but it
> is cumbersome to know of this new complexity=C2=B9, and various things wo=
rk
> less well in detached state -- for example my bash prompt tells me in
> which branch I am, and in detached state it only shows the commit hash.

From a quick glance, the old script symlinks various repository state
together. You could probably get something equally useful out of

    git clone --shared . ../new-worktree

(Provide branch options, etc., as desired?)

With "git config --global alias.new-workdir 'clone --shared'" or
similar, you might even have less finger re-training to do.

Alternatively, you could maintain the script yourself by e.g. copying
it to somewhere on your $PATH or extracting the contrib/workdir
history into a repo of your choice.

--=20
D. Ben Knoble

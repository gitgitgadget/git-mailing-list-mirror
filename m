Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965F21BA285
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 11:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728299471; cv=none; b=KYg6UMtTgcxaGScqAMlIbqNYMyxlUVbDjhOPfsv8KPY7dzKqqPQ34Tkdp/J9PHaopf+a4ph2ptSQPuF1uikueVDd7Pn0tGg19/dugkxC15wIkTYPz3L018LhXlhyXje6TNUTOgZl2QPgMma/dUN6FWMfs+JF/c3p9lzvvSZb/Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728299471; c=relaxed/simple;
	bh=ufdTXRdMhUHsn3zBA8MvyG50LU71dlqYudjxuxS932E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h/+84K8RpVIWHrMzU0tlt2To83W54b+Qy3p65vnm8894jIMWXOQ/NfopKuNORQnpzPNKDHEJGOOIUU3ya9T2GCTZC8clasZFrL45KpHU/SOqL0VQY+WU346OhJ4FcWUlSHkiChtvcyX9S6zkP/NK85dHr46qnDQaGrm6HqIT7XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MsmPw84/; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MsmPw84/"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-84eb2f32097so1195570241.2
        for <git@vger.kernel.org>; Mon, 07 Oct 2024 04:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728299468; x=1728904268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tx0UfZ1sl+tyPZUxxVa9Eov5lHOUBS+RMHWFpsIL03s=;
        b=MsmPw84/gHy6xpqZcWwcjKqIjRFDlC35Pq1xvWgvGbJ81jW1gfQoum8HN8W8k9kVny
         c6LTYVtKU08SuAMbmezNVmPmbXyZD2nDgbU+5konPsowxllNHBWDJ4AGvV9Re7ZDBVgk
         05xCbmrALNsc36l+u5Uwx2GWTANDLRvCJ51nWq3DaoXvdZAuYdnOcGq9DsEuWxI8Pt0l
         Hfq0Qb+2+Bu9pOm9oN+e45BmrY7PbTaCnyDdE8ZVec1ZNHlnFeFw/T/khGjIFwtPnINm
         qtwK2PdIHSZzb/+q5OZ2xN07STg1iwG93pkCTfIaEZsJt1pDi5nUp4gWbMYkVvWaKkJy
         /DIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728299468; x=1728904268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tx0UfZ1sl+tyPZUxxVa9Eov5lHOUBS+RMHWFpsIL03s=;
        b=FsJMQDMRv3+zIrJ94tF2cB1K4TPyDLcKSCvZJ5rZJX4P3PGLn1xq6m58srrvloOpCu
         /L/b12IlpP04JIqVF5DubkIvvnro0+Sk4fGMWxX6fwxOyifEdAZSsUZSBUxwQB92cRBK
         knBHRNHULqtKrdyPXCbFKFkWanT69qduF2b/2l/SIoYmKA/eG+VF006XVUOHXDX/oEas
         h6x7utjHYZPS5y6aQW6EToTB75b0SLNDKCw7MrkssJPOos0yYVxCBZOlN4Fkk+uqu7gJ
         Qre8bgs+eZJCk2wung9c1cPhDk40l9lyiK6/Hzq5ujexT3wrLJgEfCMI8H6Apohxa5h6
         avgg==
X-Forwarded-Encrypted: i=1; AJvYcCUpN6wmhrnMJG4IzDq1qCaXQwHkH93BFKhtOuv5K6MRMDJK0+ZHYuhVG1n1l86J8XwDebI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMW2Bd8UdXVJbxsfqipNlYyltmiDmFX6KGakonA0Jc1VYeW2Gs
	0Ud+3IfC2+fCIghKYqRy7H4UKhJ/yJWd/9ug2C7m2p5z304FIqodyxJzcnv/F/WcdKTV2JUKgoZ
	wqdUAkHcDDED+e8UR4pjDl7FLQWU=
X-Google-Smtp-Source: AGHT+IHGeLSQhuuNr28/pbuVLHuEjrHKqTXvDLBnrmY6qSC9HCW14/5bCVM1U8PPHeakWFaUSLMK8BKX6avjOCjJfQA=
X-Received: by 2002:a05:6102:3593:b0:4a3:c7ff:8263 with SMTP id
 ada2fe7eead31-4a4058e136dmr8291192137.20.1728299468403; Mon, 07 Oct 2024
 04:11:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1805.v4.git.git.1728296531.gitgitgadget@gmail.com>
 <pull.1805.v5.git.git.1728298308.gitgitgadget@gmail.com> <0ce40300fa32bde27c789fae9e0c642498710a25.1728298308.git.gitgitgadget@gmail.com>
 <ZwO96ACW05R_9DPb@pks.im>
In-Reply-To: <ZwO96ACW05R_9DPb@pks.im>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Mon, 7 Oct 2024 11:10:56 +0000
Message-ID: <CAPSxiM8UFdS_T5CHSOUPt6ax=i1KuNf7-9XWnNeQQCtOiR6KCg@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] t3404: employing test_line_count() to replace test
To: Patrick Steinhardt <ps@pks.im>
Cc: Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 10:54=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Mon, Oct 07, 2024 at 10:51:48AM +0000, Usman Akinyemi via GitGitGadget=
 wrote:
> > From: Usman Akinyemi <usmanakinyemi202@gmail.com>
> > diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive=
.sh
> > index 96a65783c47..1073eb88fa2 100755
> > --- a/t/t3404-rebase-interactive.sh
> > +++ b/t/t3404-rebase-interactive.sh
> > @@ -281,7 +281,8 @@ test_expect_success 'stop on conflicting pick' '
> >       test_cmp expect2 file1 &&
> >       test "$(git diff --name-status |
> >               sed -n -e "/^U/s/^U[^a-z]*//p")" =3D file1 &&
> > -     test 4 =3D $(grep -v "^#" < .git/rebase-merge/done | wc -l) &&
> > +     grep -v "^#" < .git/rebase-merge/done >actual &&
> > +     test_line_count =3D 4 actual &&
> >       test 0 =3D $(grep -c "^[^#]" < .git/rebase-merge/git-rebase-todo)
> >  '
>
> There's still the space between `<` and `.git/rebase-merge/git-rebase-tod=
o`.
> But overall this version looks good enough to me, so I don't think this
> requires a reroll. Thanks!
>
> Patrick
Thanks for the review. I think it is better to fix it now. I already
did. Thank you.

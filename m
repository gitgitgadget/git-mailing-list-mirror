Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C1874C08
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 07:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728286380; cv=none; b=KmMDZFI0e3qNOWI1fzeN2hVQJ9lpV2unN6XmuD5y3bn1uPmID2M+mCoELJjtWFmAw0dTqdsUWAZLmLtfZeJHcqf4S+gT5RxLJk08tomrmlWjRgJ54G9JlodxorMmNTgPZWb/cFIcLGU/o60cJmklTGbXojM1OdetAtfgyNlXKNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728286380; c=relaxed/simple;
	bh=nFpaeSXrzFXFld+SATpcc2RS1TnUPdt3Cz1xcong1vk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wfv+SGmQhUPb7w1lYr6mbJ4zWb4yR5PBr1WoqaaKDiMJ4d1ySPWd51vqHvo//m7tfafHprZF6ustYDQ/kyuYjC9ai1KqhXmtPtyacuKol8Z8TmFxsrz4Zyrj5BjerYfl+bggjb5aGXQgW5oHn/+R2+nj7xYkHVWBZOG80939ErQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dyUEBmGD; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dyUEBmGD"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-84e9dda8266so877475241.3
        for <git@vger.kernel.org>; Mon, 07 Oct 2024 00:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728286378; x=1728891178; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wh9UUByZaJCZow+WyGU1JPo/jEFCXRAGvzT7pKoee70=;
        b=dyUEBmGDto9zFxtUAsFSQfIQcu0k0KrgpRM0m3gO3azpqyrkBsNEmW40pqhptgqFsa
         9Jr49RREnEy6Kf1fF4MEUsGZcIECoaPTTuL8mm/wZYRG+wSqPmWgLw7uS9GQwbmCNB5s
         WgKR+OwavL7SAFNVJMV79IfMFdOHUJ5Bk0z8GB0yvh+9o0EQKcLT8E6visDG22/MgldQ
         9/NNgFmgxHwd6TdSOmsueg1v00FAbVXn6KvKPEdhzUFIAsnec1m5cz1Aose4ADvi1qQp
         unbzkPiwnmZo2fzQ2Zf3yPLhqQOfdPtqpw88hyk/9HM33asr6kM4YALJwyP/WMrIWy+e
         k1/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728286378; x=1728891178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wh9UUByZaJCZow+WyGU1JPo/jEFCXRAGvzT7pKoee70=;
        b=c49iA81QpNgxsV2nkpARGx/ZxFHwsABelgH2u+bu+/JjH+o7vFuOhUE45wuRiSYxN3
         R5bSs0QfVkIf8SVzn1iCYO0rHPCc0bP92nxH0Ik9OVrWjCzxeXK51uROncOoc7qid3/+
         iZth7fn5+1lxYmypOewVEHVHhDxigL6Y50o01VU9SQTpY0+NNbImsCPQ4MaWoADeSy+v
         1EEw8aJfO+1mn5qZKjYkGAjpmGshupBG9/28bNLEByEMev33en6RoqMvYzh1hnyhXCKy
         p+d/kxTuEexK+Z5rjNaas/WMcHUKHKr9VBLLCGJ7KciZMBihe2qyTZEYi+0XplmW6Rqp
         DPtg==
X-Forwarded-Encrypted: i=1; AJvYcCUO0d9dUAHd/YtenCiv3FDfyeQq6B0T7sRszjp+tbbPEoQnf1AzH3R8MvvLeTJLuPgYeKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJl/IeSduvcYmozx/cATwlleDpfUBsJ0k73PI4nqUdDSDf8eyH
	rcMfjSUH2g2BpKKRf4VU31UvmbmP7xDegDQdTlytMy/oi4M9PxGO4Zb3bNcv5dy6nL4hGC6d95J
	AE2A7e3V0+Bjkn4xQX0AsASZtC/RBc40pq4c=
X-Google-Smtp-Source: AGHT+IGOBaLJXSKfo1yM+WqQHF4Z5fmiHZfUTfYa0v4RUQv53r2UaOE7rnPm5TAcUPplvY4sF8dZRVxu/laFg2IOneE=
X-Received: by 2002:a05:6122:3198:b0:4f2:ea44:fd2b with SMTP id
 71dfb90a1353d-50c852eef61mr6718372e0c.0.1728286377863; Mon, 07 Oct 2024
 00:32:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1805.v2.git.git.1728203495287.gitgitgadget@gmail.com>
 <pull.1805.v3.git.git.1728230769.gitgitgadget@gmail.com> <37b1411ee2c420f1a8578d27a2f7d54ccd3f329f.1728230769.git.gitgitgadget@gmail.com>
 <ZwN6D_-Ak1FoE0ix@pks.im>
In-Reply-To: <ZwN6D_-Ak1FoE0ix@pks.im>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Mon, 7 Oct 2024 07:32:47 +0000
Message-ID: <CAPSxiM-Lm-1AvpFuEOtYuA2rDEJ0PY9YTV9SwahW0vBdRdjeGA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] [Outreachy][Patch v1] t3404: employing
 test_line_count() to replace test
To: Patrick Steinhardt <ps@pks.im>
Cc: Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Christian Couder <christian.couder@gmail.com>, 
	Phillip Wood Phillip Wood <phillip.wood@dunelm.org.uk>, Eric Sunshine <sunshine@sunshineco.com>, 
	shejialuo <shejialuo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 6:05=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:
>
> On Sun, Oct 06, 2024 at 04:06:09PM +0000, Usman Akinyemi via GitGitGadget=
 wrote:
> > @@ -401,8 +402,8 @@ test_expect_success 'multi-squash only fires up edi=
tor once' '
> >       ) &&
> >       test $base =3D $(git rev-parse HEAD^) &&
> >       git show >output &&
> > -     count=3D$(grep ONCE output | wc -l) &&
> > -     test 1 =3D $count
> > +     grep ONCE output >actual &&
> > +     test_line_count =3D 1 actual
> >  '
> >
> >  test_expect_success 'multi-fixup does not fire up editor' '
>
> Oh, you already do the change I proposed on the first commit. It's a bit
> funny that we first change things one way and then touch it up again in
> another commit as it leaves the reviewer wondering for a bit.
>
> But I guess that's okay, especially for a microproject. So overall I
> don't see a strong reason to reroll this series, thanks!
>
> Patrick

Thank you very much for the review. I really appreciate it. I had to
make this separate commit as recommended in the resources you provided
and reviews from other reviewers.

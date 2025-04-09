Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0A41E260A
	for <git@vger.kernel.org>; Wed,  9 Apr 2025 08:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744186568; cv=none; b=gCxIAdQMqnAz9dj6NxSE+u1QTQSqCDoY2gubqkbBAv36cYGtKF9/+EjDLy4/NlZCePyew3abpqDDgQ52GHYJVF2FJ28Q8pa1l73lkotoFBGbdK88R0hrNeoMt8to1lEkTT4bA8D8/l3DsyJCH3Jn8846ehPAU5gkCtnhSOma+04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744186568; c=relaxed/simple;
	bh=d1VPrbmOUKAV1zCiVff1ERl2EHTMVuMUrBBxO2VDdSw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UMwewf1oArbjMBHzoq55KkvyFRa3bLyIyoPQ9EUF32aqFm9eHnfCxf6pasyaMAeVfcCnBv9ZsnCrW/6ide7CZCZyYwC9L48JE6Y2xX8o3yLrmtV+S9x3Byu0DavPnbtPKszkFcwIaTT+2r7e5fphsJ4GFtjidKWOPdNKH+iN5Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fXL6xvpW; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fXL6xvpW"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c54a9d3fcaso662323785a.2
        for <git@vger.kernel.org>; Wed, 09 Apr 2025 01:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744186565; x=1744791365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8uzNtn1/pX3VXqSvoutQltV1vNrHoLBs8ws38ZmD+9U=;
        b=fXL6xvpWa4hM3vBTc7azzsvXI6nb0xCdniFbjJQFEXPmTlKFSi+hL2obB00wI+ytbq
         PtwH5ZE2afCUf5/Qx3CnE18w5vy4XhpWqwxuUbYoBmlV+S13/DBtvaVGb7AH+c98WgIo
         kO2N1XqY+fPRxSnTfkKLWVae+TgeEByORXkIEnmDtko/mtlBpCa90mCG/fXjAPhFiIBs
         vRZ+pGkwPUUzHFV0SEHoO6VGZDI6yajkjufFfur9jVxk1c4iQGb+VB9048SmoBG2xYdV
         OU9gJ9aKoTyHgZ2b8sacL87y2Zg3VZr7jncB9+u84T3FZbjcDTWBFi0kwZ6HSDe3F8Um
         7BCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744186565; x=1744791365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8uzNtn1/pX3VXqSvoutQltV1vNrHoLBs8ws38ZmD+9U=;
        b=C+lR4vBhjOy+Yc8F8LoaagNpioBt3sHES5KpoEW2o49n3OCf41GbaxvVWOJZPVMnQ5
         tpjxjw6+JxrsmBmBlpQZzOqA79GxEXyYQMi3weBcGKA4D8sUKSv3Z01aKdElvRPtqyKg
         YHggy5GF7HAGTbgxVy3e+NjFcfZNBkpUdF7UU6NR1aGMDru1Tp3w+11GsZpmIKbStQ6F
         JF37jeTTBeCTnnIpW/tFBl+XeFmlcMrJKkR7TZE8uo/R7prlFeYoyUw62LNxZzrh2wsY
         F8OJt9wzPbY6MIFEJaLS/pBWuWUHVUbnuC3xq19d0kR6wzRFjgJtgp87AKCarOTeR5Ha
         qT2A==
X-Forwarded-Encrypted: i=1; AJvYcCWxj6swpvc4hzBIUpGLynFNhZ1dsslhAAHG6vjx66+SX0q0ALmsq7R9yAESKEv/HHXl2aQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwurjOqplqgoUUFj1uVuY0bsEKZkCBOl9hqLc+5uWWBSkoEfsaN
	Ii1dVuhYkzigCJ0M36QPMPuQ1wKFBA77lW6ZZXPobK2nRokZOIAR0uugsHqTLhfDIH7lpg2jmHl
	V3gO5w816qezY0KNq7r4kUplGEQ==
X-Gm-Gg: ASbGncvarED4dGOsjctrAeNf4+JElkkGWzslIbn1nY8DB+oOgweD+4O7sm5FsLJGdON
	xD+8Sx4uDYl//doe6zlHerAVklrE8Tgc2F70eX19C9aSjhJKQhqFtJc4uyQnKwrPOrNdgVHqZbY
	vJi1YdXhn4CSFsePlROUQzLw==
X-Google-Smtp-Source: AGHT+IGlAiifl1i8c8NrLYAMbyrbKVgCepBA+jnlkeCukvtHVBMqfPGWSjmtmy21aCJt4ECXWNhgjBZmd8DPQPAJNfs=
X-Received: by 2002:ac8:5d0e:0:b0:476:71d2:61e6 with SMTP id
 d75a77b69052e-4795f3880cdmr26994001cf.45.1744186565299; Wed, 09 Apr 2025
 01:16:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250405103718.25160-1-anthonywang03@icloud.com>
 <20250408114841.58592-1-anthonywang03@icloud.com> <20250408114841.58592-2-anthonywang03@icloud.com>
 <xmqqbjt6wdrk.fsf@gitster.g> <CAPig+cSo2hPpA0DOn7Tr3pcYfN6jxyyo+n0Y0QetvKvNVoLqbA@mail.gmail.com>
In-Reply-To: <CAPig+cSo2hPpA0DOn7Tr3pcYfN6jxyyo+n0Y0QetvKvNVoLqbA@mail.gmail.com>
From: Anthony Wang <anthonywang513@gmail.com>
Date: Wed, 9 Apr 2025 10:15:53 +0200
X-Gm-Features: ATxdqUHFHYY9IlrU7mcDIZPO9kfIMmbH3eFCI5DVJbnwNCTCwh2484GQSx5nvS0
Message-ID: <CAOSofofyfDpFqFzApwMnmYdFb4nk8DS7WwWmYKLPbe+okOE=Tw@mail.gmail.com>
Subject: Re: [GSoC] [PATCH v5 1/1] t9811: Improve test coverage and clarity
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, ps@pks.im, 
	karthik.188@gmail.com, shejialuo@gmail.com, christian.couder@gmail.com, 
	shyamthakkar001@gmail.com, Anthony Wang <anthonywang03@icloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 11:28=E2=80=AFPM Eric Sunshine <sunshine@sunshineco.=
com> wrote:
>
> On Tue, Apr 8, 2025 at 5:21=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
> >     t9811: be more precise to check tag creation
> >
> >     The tests grep tagnames they expect to exist from "git tag"
>
> s/tagnames/tag names/ perhaps?

How does "t9811: be more precise to check importing of tags" sound?
The tags are created in the p4 repository, and what we care about is if
`git p4 sync --import-labels` correctly imports the labels from the p4
repository. Specifying tags instead of tag indicates that there are
multiple tags, which is the whole purpose of the test.

>
> >     output, which can be fooled by false positive if an unexpected
> >     tag whose name has the expected tagname as its substring.  Fix
> >     them by using "git show-ref --verify" instead.
> >
> >     While we are at it, add a negative test to verify that a tag
> >     that is involved in earlier tests that is not supposed to appear
> >     in the result does indeed not appear in the resulting
> >     repository.
> >
> >     Incidentally, this would also correct the problem the original
> >     had, which lost the exit status of "git tag" that was placed
> >     upstream of a pipe.
> >
> > or something, perhaps?
>
> Yes, better and much more illuminating.

I see, that message does communicate the intentions of the changes
much better than I did. I will expand the message and write something
along the lines of what you have recommended.

>
> > > -             git tag | grep TAG_F1 &&
> > > -             git tag | grep -q TAG_F1_1 &&
> > > -             git tag | grep -q TAG_F1_2 &&
> > > +             git tag &&
> > > +             git show-ref --verify refs/tags/TAG_F1_1 &&
> > > +             git show-ref --verify refs/tags/TAG_F1_2 &&
> > > +             test_must_fail git show-ref --verify refs/tags/TAG_F1_O=
NLY &&
>
> Do we still need the standalone `git tag` invocation above?

The original intent of the patch was to expose the exit code of
`git tag`. By keeping the standalone `git tag` we are able to pick up
the exit code if there are any issues, such as if `git p4 sync
--import-labels` somehow breaks `git tag`. I believe this is the intent
of the standalone `git tag` in the section below, and as such, I added
it to the top section in order to test the `git tag` functionality, as we
removed the other `git tag` instances. However, I can understand
if it is unnecessary, and I will remove it.

>
> > > @@ -208,7 +209,7 @@ test_expect_success 'use git config to enable imp=
ort/export of tags' '
> > >               git p4 submit --verbose &&
> > >               git tag &&
> > > -             git tag | grep TAG_F1_1
> > > +             git show-ref --verify refs/tags/TAG_F1_1 &&
>
> Similarly, it's not clear why there is a standalone `git tag`
> invocation here. Does it buy us anything or am I missing something
> obvious? The originating commit[*] doesn't explain its purpose.
>

Again, as we have removed the other `git tag` instances, it might
still have value to test the result of running the `git tag` command.

> [*] e71f6a53e2 (git p4: add test for tag import/export enabled via
> config, 2012-05-11)

Thank you very much for the valuable feedback, it has been very
eye opening to see how you two approach patching code like this.
I wanted to bump one of my previous questions, as I am very
curious about what the best practice is here:

To this point, I have a question about when to modify code when making
patches. My understanding is that we should try to only modify the code
necessary to fix the bug, and not modify other parts of the code.
However, because in this case the test itself does not correctly test
for the intended behavior, we should modify because we are already
touching this piece of code. Is this correct? Would it then be desired
to check the rest of the tests in this file for further oversights and
correct them as well, or would that be overstepping boundaries?

Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CC54C84
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 00:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711499009; cv=none; b=eeJjQCobT5ou+5ITf1xzoXOpWsAxz9OzZrgiZMQ8mCz34/MhZWb+6gaOfiXvzYl3DEsrNVnkHJMIdIAvoPwDB0RKa7XQkhrW0xvmnKzoENeWXFzFwKZ7mDcRi59iFCCYT0GMKxb5vhPwrT1cYRSDmI9hE11AG41dSsMaQ6HkWsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711499009; c=relaxed/simple;
	bh=NqkOvGyezJkJVzw2jJ/0P4vnG11cWfxWdREn4cEIVhM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ppBY63e+8r11C93Q/f0Et7iEbH9VeWdbBkmW7dY66MGaGDkiSFF69XAU+kmc03kfrV7TsA5xPofDHISE3YAmZvk1/Pd8TNov1rpF2NBshFhUfph+Bpz2fm06ik7DSlLAsmTeI4pQWjk70gP0cGmTlseU04AQ6wolK3/1EkehCZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F+wIm3r7; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+wIm3r7"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56c147205b9so646693a12.0
        for <git@vger.kernel.org>; Tue, 26 Mar 2024 17:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711499006; x=1712103806; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gPDYNm8woSDNO37WmJFuauCSOORMLGwjs/2wgZ5K+8s=;
        b=F+wIm3r76BQVQ98FvGbJm/I3E3GcjQ2yrgW/uuRu318WjFIpvHR0PjF1KdxA/E2pUY
         U2VlpRMJv5Nq0aM0VXWn+yiM4IhZDQvMNJMAuUDu5jjYDmT3q6SY3UwQ5NRiLqws+m3Q
         OZuC29y1OL6xPRBAlfc4YBGw/oyi7qzxKBQeIZdGKbhVQ5mUN+MUSC+uOXdzSXsrCSh1
         UGGTwEvorxSaf2cuZLn3ifRPndGgElukkrU5FhNR0pPw//6ThaRxgeAndKqGqXOZTXp7
         6YMxXvSlbQyVEbck/fN90fQdp6JlDQhSpnm13FLRUUgR9qICBErqZnwwdRWN3UhVaFas
         TbPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711499006; x=1712103806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gPDYNm8woSDNO37WmJFuauCSOORMLGwjs/2wgZ5K+8s=;
        b=O7eQexVE+vUdt1ASmRR3d9LNXay8W+jKoAXhAmtkTcM+xapcr5KZl8OQc+EKQHWuNK
         hwPDGxnhX+aNWrRpOJ7EQI/WJkps/o7YVHwz6616iOU6XTdaE00B8HSO/dY0hsJAyjvV
         9/FYS7o0mRyWz0DM3JjwYg4iQn4BQRAKkfrf/h9zHZTAh97HhHOLFQ0IEyUVbydLUdvI
         RJ/iVoRVIKONzLVbDmZs5EWr4b68hkHnclPQnbPWDv3yBHO4PSBZhxDe/lsNN/gzyc3r
         YR4HueteAUUsf1T6RKM2GTTr5+mKYuIf/UCXBQy14xjo9eaYnCnMo9coa4rpbDtZF/uP
         HFfA==
X-Gm-Message-State: AOJu0Yz17vuUXuZUkECPG3SlV8g4JG5R6PFL5HLfdTPAFMmYcc2+aueP
	7IyxBO60aqKuSalOpz8Lle4GxK+spAgEwGFyPrp9hTvgSymi+ek3+Xdtpsx/blS1oXMwsETjpof
	/TEUFynvK3uUWzcOTLoHMh/C0zm25yPJhgMY2OS/r
X-Google-Smtp-Source: AGHT+IEVVc4k+xjyPmXNcsOYYjm5/E3Crnh8Nn1u4l8duP1ozs3LqyXA7+tJSYY5wLbr8QE1fmr770+wwhjkNvGXYcY=
X-Received: by 2002:a50:d5cb:0:b0:568:9b14:d6c7 with SMTP id
 g11-20020a50d5cb000000b005689b14d6c7mr2598462edj.16.1711499005892; Tue, 26
 Mar 2024 17:23:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMbn=B4HDXOAThvAmmyA5GEzG1nnvbGvc4yjpg7FHSHQQ-WQfw@mail.gmail.com>
 <CAP8UFD3qf1MW1PkCh7DvwmNoi51sLq4r0Z=K57OCa65WtorAKw@mail.gmail.com>
 <CAMbn=B58_KSvkEMEsCnrN6rGL61+qFv9NqcOO8adyU5A37=vjQ@mail.gmail.com> <CAP8UFD1U3j4tf3snk0qcDjHPRKxuaUVZOw7GuCEwAnXb-gRvHQ@mail.gmail.com>
In-Reply-To: <CAP8UFD1U3j4tf3snk0qcDjHPRKxuaUVZOw7GuCEwAnXb-gRvHQ@mail.gmail.com>
From: Aryan Gupta <garyan447@gmail.com>
Date: Wed, 27 Mar 2024 01:23:14 +0100
Message-ID: <CAMbn=B6vARzcqkqFRHDhZ2NJoBRyaUCCUcvqd=3pFk92T-gjWA@mail.gmail.com>
Subject: Re: [GSoC][PROPOSAL v1] Refactor git-bisect(1) to make its state self-contained
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, "Patrick Steinhardt [ ]" <ps@pks.im>, karthik nayak <karthik.188@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Christian

Thank you for the response.

On Tue, Mar 26, 2024 at 11:30=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:
>
> Hi Aryan,
>
> On Thu, Mar 21, 2024 at 2:21=E2=80=AFPM Aryan Gupta <garyan447@gmail.com>=
 wrote:
>
> > On Wed, Mar 20, 2024 at 12:06=E2=80=AFPM Christian Couder
> > <christian.couder@gmail.com> wrote:
>
> > > On Sat, Mar 16, 2024 at 7:58=E2=80=AFPM Aryan Gupta <garyan447@gmail.=
com> wrote:
>
> > > > -- About Me --
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >
> > > > I have been enthusiastic about open source from the very beginning =
of
> > > > my journey as a software developer. I=E2=80=99ve contributed to oth=
er
> > > > open-source projects, though still a beginner, I=E2=80=99m generall=
y familiar
> > > > with the process of contribution. The related experiences are all i=
n
> > > > the contribution graph on my GitHub profile page [1]. In the ZAP
> > > > Project[2] community, I=E2=80=99ve made over 50 PRs [3]. I also par=
ticipated
> > > > in the Google Summer of Code 2023 with the OWASP Foundation and
> > > > successfully completed it as well [4]. I have contributed to some
> > > > other small projects as well on GitHub.
> > >
> > > It's interesting to know that you have already participated in a GSoC=
.
> > > Is there a single blog post about this or more?
> >
> > Here it is: https://www.zaproxy.org/blog/2023-09-11-browser-recorder/
>
> I saw that there is one blog post, but I wanted to ask if there are
> more blog posts. That's because we ask GSoC contributors to post on
> their blog at least every 2 weeks and if possible every week.
>
Oh okay. No, the org didn't have any such criteria we usually had
a google meeting once a week where we discussed everything
about the week's progress and the next week's plan. Yes I can
surely write a blog every one or two weeks whichever would be
comfortable for sure if I contribute to git.

> > > > -- Strategies for Handling Backward Compatibility --
> > > > ---------------------------------------------------------
> > > >
> > > > 1. Before implementing any changes, a good understanding of how
> > > > git-bisect works and how it is structured is very important. So, I
> > > > will thoroughly analyze the existing usage patterns of git-bisect a=
nd
> > > > list down all the potential areas of impact.
> > > >
> > > > 2. To validate the codebase changes and ensure the stability and th=
e
> > > > backward compatibility of git-bisect command. I will write unit tes=
ts
> > > > for all the required changes.
> > >
> > > Do you mean unit tests using the new unit test framework in C. Could
> > > you show an example?
> > >
> >
> > Not sure about what is the standard way that git uses for writing unit =
tests.
> > Could you tell me a bit about this?
>
> I was just asking if you planned to use the new unit test framework in
> C. The "Move existing tests to a unit testing framework" project that
> we propose on https://git.github.io/SoC-2024-Ideas/ is about moving
> some unit tests to this new unit test framework. Please take a look at
> that project to get more information about this subject.
>
Got it. I read and researched on this and yes I can use the latest unit
test framework for writing the unit tests. Also I was thinking of a backup
plan. If the community later (after getting the proposal accepted) do not
agree with the project idea. I can work on the migration of these tests as
well. Since there are so many tests, I think I can work on a few if this
happens. Here is an example:

#include "test-lib.h"
#include "bisect.h"

static void test_backward_compatibility(void) {
/*
* will try to do some bisect operations by
* keeping the new way of storing bisect state
* files, not sure about the how the code will
* look like for now because I haven't gone
* through git-bisect much but I will do it
* for sure
*/
}


int cmd_main(int argc, const char **argv) {
TEST(test_backward_compatibility(), "Test backward compatibility of
git-bisect");

return test_done();
}


> > > > 3. I will also try to create some real scenarios where I will be
> > > > manually testing the desired behavior.
> > > >
> > > > 4. We might also need some regression tests to test some of the
> > > > functionality which can't be tested using unit tests.
> > >
> > > In which test script would you add them?
> >
> > I will be writing these in bash and will be adding it in a new test cas=
e file
> > inside the git/t directory or maybe in "git\t\t6030-bisect-porcelain.sh=
"
>
> It's better to always use the Unix notation for paths like
> "t/t6030-bisect-porcelain.sh" starting at the root of the repo, rather
> than mixing the Unix and Windows notations and adding "git/" before
> the root.

Okay.

>
> > file. I will try mocking a scenario where we have the BISECT_* files av=
ailable
> > in the .git directory and then run git bisect using the command line an=
d then
> > check the expected results.
>
> The t/*.sh test scripts are the right place for end-to-end tests
> (sometimes called "black box" tests), but not for unit tests that
> would test some C functions. Both unit tests and end-to-end tests
> could be regression tests or performance tests.
>
Okay

> > > > 4. Adding Tests
> > > >     - Through testing for backward compatibility is very very
> > > > important so that the changes don=E2=80=99t break the existing chan=
ges.
> > > >
> > > > 5. Documenting the changes
> > > >     - This might also go side by side if mentors need some weekly
> > > > documentation of the tasks done.
> > >
> > > Tests and documentation should be part of the patches that change the
> > > behavior. So it doesn't really make sense to list them separately in
> > > the timeline.
> >
> > Okay. Maybe a blog post could be a part of this?
>
> We ask GSoC contributors to post weekly on their blog, so except for a
> final blog post, most of the blogging should be also part of the
> regular work.

Okay.

>
> Thanks for updating your proposal.


Thank you
Regards

Aryan Gupta

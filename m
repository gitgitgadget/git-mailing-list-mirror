Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF31524F
	for <git@vger.kernel.org>; Fri, 25 Oct 2024 18:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729882580; cv=none; b=nbBNqV8oHDZFYA/xPb9i00W3Fcsy9sJHTni0nQWevLVNY/06KceDGEjjHegI6GHCf8cKuHwFKWYccwlDw95388fgVFzkgPEZ4JPDhjiMKTUkrGjIPAJ24NRENY+7UHShrVCzwyyIsGe+hB9qNm9oTyzqp4uCNqSKfJE+bmWXHY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729882580; c=relaxed/simple;
	bh=0vZHEsyPSe67U9w0kX8PWfrVVBvo9nuY8KhG38NA6ZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FrYZENdOYLPJSZ4nD+lZvMw54BzieqGn9abyyHcPJf8Uz663zqcUOPAc5X+XqTL/vstjUzRyXA5GAA6y/dPk5A/6JyF0WRlaUzcej6xLvX71UGaouEJsVELijRal1O4ZAbbqpFMJ2obMLESMYEIJHa8KVFzw1oVwr/X2QtQDMSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PtGqBnBN; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PtGqBnBN"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-431616c23b5so16957405e9.0
        for <git@vger.kernel.org>; Fri, 25 Oct 2024 11:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729882576; x=1730487376; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K9/MdjD5pzh3pRyjdbDICANCPPVEMvfQVl/br1iEfjo=;
        b=PtGqBnBN+tPNwoXHOpk/pTA/KDkyr80/OSvDye5ncC03YdnhcJ2IL5XLqwSqPZeRFo
         6Xl5hRd/r1b+Wpqzp9DwB+mryZ4ZHnoSmaa7fVkpEqEBmlF40CtbRDqqMuKdiTbk00dX
         3lZ0tdOLuKbYDbaRdf93Ao0+C2WWKhcpb6l06Ykl9Lx87iahbrmoYEvnWE/onYVlTsU8
         Fd0A5AKOM7Ee0bPGLYP6cj4elVl5jZsYyJmHVNLtu6zBp64q9Wmj0BVCa+ksC1FehtKR
         G+LoFglt7T08gV0sdFlysw671hdaKd1doeV0f9mvpSNzrKspAlX8o6Sp+SP2FtKijTEj
         96/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729882576; x=1730487376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K9/MdjD5pzh3pRyjdbDICANCPPVEMvfQVl/br1iEfjo=;
        b=qrOAa/2876y02aLA7JEfHTi5Mkp41lT7kirgaot3WLtf3NLuLvubnAajDCDc4HjFg3
         vpC/GXsiQIb1oRmt2rnyqEfrN5Uy6TVHcECVpNsW6IU+CjAlGMZDrkQHuAtnoCAACOxB
         U4niIqdWKjFCNbuATPTlB3iFi1ZMEkqj0cuJ7wvnR06Y7InehTBz98iTDm6YLx8Bg1yM
         FAGzLSGGXazxu8WACnnXuXB2r5Gq9GqSpMiymw642BjAl4P5xxHsxQI8rWb8Jx1UPGnD
         jumr22X/iyOEBWh/Hhmtx7e3tzUpcpjm5KYJjHQNUYJFPz4Qh3gTKY67HrTkUVarWqlR
         aG3Q==
X-Gm-Message-State: AOJu0YwGXJgLZwsTSHkt6wJ98cDC7BXdllT20dAuB9xa3sX+9qREeqaD
	W9hoNUjLBRzJxQFZvcJIvPRgfw3JVAfkOydnwVs0Ux+YZqj95NX8S9L8puKeKydQmz+zEYSOCQJ
	yTnCmhL3Fxn4C8GXmntK2S6hzgMY=
X-Google-Smtp-Source: AGHT+IFhamThBdCCe5Tp7153s2gpgnIJhmqtpxUYej+SdNVo05/UjQMQoxmLRIb0OmMvP8KeECtwmsPh8+xyeVbAiak=
X-Received: by 2002:a05:600c:5250:b0:428:b4a:7001 with SMTP id
 5b1f17b1804b1-4318bc93031mr49671235e9.15.1729882575268; Fri, 25 Oct 2024
 11:56:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADYq+fZBGZiTQduQ+4KcQ7H2Hysb04pg8YR++8PWAkQOM76OPg@mail.gmail.com>
 <ZxttGFtt5nnc7g9Z@pks.im> <CADYq+fZeTDnpsvBenLV6GHz5vBRW0nwcmWqQ4kvpNd5LocPRow@mail.gmail.com>
In-Reply-To: <CADYq+fZeTDnpsvBenLV6GHz5vBRW0nwcmWqQ4kvpNd5LocPRow@mail.gmail.com>
From: Samuel Abraham <abrahamadekunle50@gmail.com>
Date: Fri, 25 Oct 2024 19:56:05 +0100
Message-ID: <CADYq+faOBCRMS3GiQMuACJ2pLdirnODJBxuJTsR=2QPPpzwo2A@mail.gmail.com>
Subject: Re: [Outreachy][proposal]: Convert unit tests to use the Clar testing framwork
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Phillip Wood <phillip.wood@dunelm.org.uk>, christian.couder@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 2:22=E2=80=AFPM Samuel Abraham
<abrahamadekunle50@gmail.com> wrote:
>
> On Fri, Oct 25, 2024 at 11:04=E2=80=AFAM Patrick Steinhardt <ps@pks.im> w=
rote:
> >
> > On Wed, Oct 23, 2024 at 10:45:52PM +0100, Samuel Abraham wrote:
> >
> > Thanks for your application!
> >
> > > ## Project Overview - Convert unit test to use the Clar testing frame=
work:
> > >
> > > I understand that the Git project is in the process of converting its
> > > unit tests to the Clar testing framework to improve test readability,
> > > consistency and maintainability, a move away from homegrown unit test
> > > frameworks such as t/helper/test-tool.h and t/unit-test/test-lib.h.
> >
> > Nit: we've basically moved away from test-tool for unit tests already,
> > to the best of my knowledge. So this is more about the second part,
> > moving away from our own test framework.
>
> Thank you very much for the clarity.
> >
> > > Clar provides a structured and efficient way to write and execute
> > > tests and is well-suited for a project like Git where robust testing
> > > is essential to maintain quality and stability.
> >
> > It would be nice to provide some pointers _why_ we think that clar is
> > better suited ;) Hint: you may have a look at the patch series that
> > introduced the clar for some ideas there.
>
> Okay I will do that.
>
> >
> > [snip]
> > > ## Project Plan:
> >
> > Formatting of this section is a bit funky, which makes it harder than
> > necessary to figure out which parts belong together. I'd propose to
> > first provide a high-level list of the steps you want to do with a
> > bulleted list and then maybe put more detailed explanations into
> > separate "### subsections". You may also want to convert links to use
> > [Markdown syntax](https://www.markdownguide.org/basic-syntax/#links),
> > which provides some structure aronud them.
>
> Okay thank you for this.
> >
> > > The first steps to migrating existing tests to Clar would be studying
> > > existing tests in the t/helper and t/unit-tests directory which will
> > > enable me to determine those appropriate for conversion.
> > >
> > > Liaise with mentors and community members to determine the viability
> > > of converting the selected test for conversion.
> > >
> > > Convert the selected test to Clar while in constant effective
> > > communication with the mentors and Git community, implementing
> > > feedback and review suggestions.
> > >
> > > Properly test converted scripts to ensure validity and correctness.
> > >
> > > Steps to converting the existing unit tests to the Clar Testing Frame=
work
> > >
> > >  From the project description in the Outreachy Project Description pa=
ge,
> > >
> > >
> > > https://www.outreachy.org/outreachy-dec-2024-internship-cohort/commun=
ities/git/#convert-unit-tests-to-use-the-clar-testing-framewo,
> > > the goal is to convert all Git=E2=80=99s existing unit tests to use t=
he Clar
> > > testing framework exclusively.
> >
> > It might also make sense to plan some time to add missing features to
> > the clar if we hit anything during the conversion.
>
> Okay noted.
> >
> > > The existing unit tests which would need to be converted to Clar are;
> > >
> > > .c test files present in t/unit-tests: Tests in this directory use th=
e
> > > t/unit-tests/test-lib testing framework and are =E2=80=9C.c=E2=80=9D =
scripts,
> > > converted from the shell-based testing which used the tests in
> > > t/helper/ and corresponding t<number>-<name>.sh test files. Examples
> > > of this conversion can be seen in the link below which references Ach=
u
> > > Luma=E2=80=99s work
> > >
> > > https://lore.kernel.org/git/20240226143350.3596-1-ach.lumap@gmail.com=
/.
> > >
> > >
> > > The link shows the work done in converting the test from
> > > t/helper/test-sha1.c and test/helper/test-sha256.c to use
> > > t/unit-tests/t-hash.c which uses the t/unit-tests/test-lib.h framewor=
k
> > >
> > >
> > > The steps to convert files located in this directory include;
> > >
> > > - Identify the test files to be converted.
> > >
> > > Examples of such files are the t/unit-tests/t-hash.c, t/unit-tests/t-=
strbuf.c
> > >
> > > - Rename the test file from t-<name>.c to <name>.c. This pattern
> > > follows the style used by Patrick Steinhardt in his conversion of the
> > > t-strvec.c and t-ctype.c files to use the clar framework.
> > >
> > > https://lore.kernel.org/git/604303e31aad3a9e74f7bdddc84f11d4d137c864.=
1725459142.git.ps@pks.im/
> > > and
> > >
> > > https://lore.kernel.org/git/ba05b9f1eef8136e087846ee54a076558097a240.=
1725459142.git.ps@pks.im/
> > >
> > > As a sample demonstration, we will convert the t/unit-tests/t-hash.c
> > > to use Clar.
> >
> > I think the previous explanations are sufficient -- going into the
> > technical details like you do below is appreciated, but ultimately not
> > necessary in my opinion. What I'm after here is that you have a rough
> > understanding of what needs to be done for each of the tests, and that
> > is sufficiently demonstrated by a high-level explanation.
>
> Okay noted.
> >
> > > The test scripts in the t/helper directory:
> > >
> > > The tests in this directory are invoked by the corresponding shell
> > > scripts which spawn processes to test the different unit tests in the
> > > t/helper directory.
> > >
> > > The process involved in converting these shell scripts to Clar
> > > framework will typically follow the same steps as illustrated above
> > > bar the following differences.
> > >
> > > Identifying the tests to be converted to Clar
> > >
> > > Create a new .c  file name which should be named appropriately to
> > > illustrate what the file is testing.
> > >
> > > However, the shell-based script which tests the functions in t/helper
> > > will be studied for in-depth understanding and then refactored into a
> > > .c file which follows the steps above in converting to use Clar.
> >
> > As mentioned above, I thought we didn't have any such tests anymore. If
> > we do, it might make sense to provide an example of such a thing that
> > needs to be converted.
>
> Thank you Patrick
> Okay from my understanding, such tests have a .c file in t/helper and
> a corresponding t/t-<number>-<name>.sh file.
> From my master branch which I study, I can see for example
>    - test-env-helper.c in t/helper and t0017-env-helper.sh
>    - test-find-pack.c in t/helper and t0081-find-pack.sh.
> I concluded since the shell script used to compare the output against
> the expected still exists
> and no such file names exist in t/unit-tests, I assumed they have not
> been ported which is why I listed files
> in t/helper will be converted to clear.
> Please I will be happy if I can get more clarity, thanks.
>
> >
> > > Project Timeline:
> > >
> > > Community Bonding (Present - November 26):
> > >
> > > Continue making contributions to the Git codebase working on differen=
t
> > > things within my capacity and getting more familiar with the codebase=
,
> > > participating in patches review.
> > >
> > > Conversion of tests begins (December 9 - December 23): Familiarize me
> > > with the conversion process to further enhance my understanding,
> > > identify files for conversion and start the conversion process, and
> > > set up a blog for weekly updates on my conversion process.
> >
> > Makes sense.
> >
> > > Implementation of community and mentor reviews (December 27 - January=
 31):
> > >
> > > Continue with conversions while testing converted tests, communicatin=
g
> > > with reviewers and implementing reviews.
> > >
> > > Testing (February 1 - March 1): Continuously determine the correctnes=
s
> > > of the converted tests by continuously testing and also liaising with
> > > mentors constantly.
> >
> > For this one here'd I'd recommend to start more iteratively. What you
> > have here sounds a bit like a waterfall model, where you first convert
> > all tests and then eventually test and send things over to the mailing
> > list.
> >
> > In the Git community you will likely have more success if you work in
> > smaller patches. E.g. pick a small set of tests to convert, convert
> > them, polish the series and then send it to the mailing list. That cycl=
e
> > would then repeat several times until you have converted all of the
> > tests.
>
> Yes, my contributions have made me understand this process.
> I will make appropriate adjustments. Thank you
> >
> > > Availability:
> > >
> > >  I am not currently enrolled in any academic program or have any jobs=
,
> > > and will be available to work on the project for a minimum of 45 hour=
s
> > > per week.
> >
> > You really shouldn't be working more than 40 hours per week ;) The
> > [Outreachy Internship Guide](https://www.outreachy.org/docs/internship/=
)
> > recommends 30 hours per week, and I don't expect any more of you,
> > either.
>
> >
> > Other than that this document looks good to me, thanks!
> >
> > Patrick
>
> Thank you very much Patrick, I appreciate your time. Please I will
> also like to know if i should send the corrected proposal
> as a mail to the list as I did with this first version.
>
> Thanks again for your time.
> Abraham Samuel


Hello Git Community,


I hope this mail finds you well.

I am Abraham Samuel, participating in the Outreachy internship program
and I write to express my delight, enthusiasm and interest in working
on the project =E2=80=9CConvert unit test to use the Clar testing framework=
=E2=80=9D.

My first exposure to Git started with the book =E2=80=9CLearn Enough Git to=
 Be
Dangerous=E2=80=9D which taught me the basics of using Git for version cont=
rol
and collaborations and I felt truly dangerous :-).


I am passionate about FOSS and now that I am presented with the
opportunity to contribute to Git, It is indeed a great opportunity to
understand what happens under the hood and I have never been happier.


## Introduction:

I completed my ALX Software Engineering program in 2023 and I have
been engaged in various software development projects, open source
development and various personal projects, providing me with valuable
technical and collaborative skills.


## Project Overview - Convert unit test to use the Clar testing framework:

I understand that the Git project is in the process of converting its
unit tests to the Clar testing framework to improve test readability,
consistency and maintainability, a move away from homegrown unit test
framework t/unit-test/test-lib.h.

Part of the reasons for this
[decision](https://lore.kernel.org/git/cover.1722415748.git.ps@pks.im/)
includes:

1. Avoidance of duplication when declaring test functions which occurs
when using the t/unit-tests/test-lib.h framework

2. Having a proper unit testing framework instead of reinventing the wheel

3. Clar can be easily extended

4. Clar provides a structured and efficient way to write and execute
tests and is well-suited for a project like Git where robust testing
is essential to maintain quality and stability.


## Contribution to the Git Community:

I have participated in contributions to Git=E2=80=99s codebase after gettin=
g
accepted into the contribution phase in October 2024, working on what
I found doable and within my reach. Below is the list of my
contributions:

- [PATCH v4] t7300-clean.sh: use test_path* helper functions for error logg=
ing.

       List thread:
https://lore.kernel.org/git/pull.1811.v4.git.1728498122419.gitgitgadget@gma=
il.com/

       Status: merged into master

       Merge Commit: 77af53f56f100b49fdcf294f687b36064d16feca

       Description: The patch converted instances of  =E2=80=9Ctest - [def]=
=E2=80=9D
in test cases to test_path_* functions to get error logs when the test
case fails when testing for the existence of a file or directory after
=E2=80=9Cgit clean=E2=80=9D or =E2=80=9Cgit clean -d=E2=80=9D is called as =
the case may be.



- [PATCH v4] notes: teach the -e option to edit messages in the editor

       Status: integrated into Seen

       List thread:
https://lore.kernel.org/git/pull.1817.git.1729296853800.gitgitgadget@gmail.=
com/

       Description: The patch worked on a #leftover bit which added
the =E2=80=9C-e=E2=80=9D option to =E2=80=9Cgit notes add=E2=80=9D and =E2=
=80=9Cgit notes append=E2=80=9D subcommands
when the message is supplied with the -F and/or -m options. The patch
enables fine-tuning the message by invoking the user=E2=80=99s default edit=
or
prefilling the message in the editor to allow editing the message to
the required taste before adding the note to the commit


## Project Plan:

      - Identify files for conversion in the t/unit-tests directory

      - Write incremental patches

      - Convert test and implement community and mentors=E2=80=99 feedback

      - Validate converted tests


## Detailed Steps


### Identify files for conversion in the t/unit-tests directory:

From the project description in the [Outreachy Git Project Description
page](https://www.outreachy.org/outreachy-dec-2024-internship-cohort/commun=
ities/git/#convert-unit-tests-to-use-the-clar-testing-framewo),
the goal is to convert all Git=E2=80=99s existing unit tests to use the Cla=
r
testing framework exclusively and also add any missing features which
might be necessary for the conversions.

I will begin by selecting files from the t/unit-tests directory for
conversion to the Clar testing framework. This approach allows me to
start with smaller, manageable patches that the community can review
incrementally.

The existing unit tests which would need to be converted to Clar are
.c test files present in t/unit-tests . Tests in this directory use
the t/unit-tests/test-lib testing framework and are =E2=80=9C.c=E2=80=9D sc=
ripts (for
example t/unit-tests/t-hash.c and t/unit-tests/t-strbuf.c), converted
from the shell-based testing which used the t/helper/test-tool
framework and corresponding t<number>-<name>.sh test files. Examples
of this conversion can be seen in [Achu Luma=E2=80=99s
work](https://lore.kernel.org/git/20240226143350.3596-1-ach.lumap@gmail.com=
/),
which shows the work done in converting the test from
t/helper/test-sha1.c and test/helper/test-sha256.c to use
t/unit-tests/t-hash.c which uses the t/unit-tests/test-lib.h framework


### Write incremental patches

Each test conversion will be submitted as an incremental patch,
following [Git=E2=80=99s contribution
guidelines](https://github.com/git/git/blob/master/Documentation/Submitting=
Patches).
By keeping patches incremental, the community can provide focused
feedback on each test conversion, improving the outcome.


### Convert test and implement feedback

Once the files are identified, I will proceed with the conversions
while regularly communicating with the mentors and the Git community.
This communication will ensure alignment on the implementation and
allow immediate adjustments based on any feedback received.

Each file conversion will typically have the following steps:

       - Rename the test file from t-<name>.c to <name>.c. This
pattern follows the style used by Patrick Steinhardt in his conversion
of [t-strvec.c](https://lore.kernel.org/git/604303e31aad3a9e74f7bdddc84f11d=
4d137c864.1725459142.git.ps@pks.im/)
and [t-ctype.c](https://lore.kernel.org/git/ba05b9f1eef8136e087846ee54a0765=
58097a240.1725459142.git.ps@pks.im/).

       - Add the module name to CLAR_TEST_SUITE variable in the MAKE file.
            CLAR_TEST_SUITE +=3D <name>

       - The next steps will typically involve writing optional setup
and cleanup functions with the signature =E2=80=9Cvoid
test_<suitename>__initialize(void)=E2=80=9D and void
test_<suite_name>__cleanup(void) and the actual tests also with the
signature

void test_<suitname>__<testname>(void) and the Clar methods such as
cl_assert(), cl_assert_equal_s(), cl_assert_equal_i() and any other
implemented assertion methods can be used to verify the results
against the expected.



 ### Validate converted tests

Finally, each converted test will be validated to ensure it behaves as
expected. Tests will undergo a thorough review to confirm that the
converted scripts accurately replicate the original test=E2=80=99s
functionality.


Project Timeline:

Community Bonding (Present - November 26):

Continue making contributions to the Git codebase working on different
things within my capacity and getting more familiar with the codebase,
participating in patches review.

Conversion of tests begins (December 9 - March 1):

    - Identify files for conversion with mentor=E2=80=99s guidance

    - Start conversion process for selected

    - Send incremental patches to the mailing list for review by
mentors and   community members

    - Implement review feedback and resend patches to the mailing list
until an agreed patch is agreed upon.

    - Update my blog to talk about each conversion and the
achievements, challenges and goals achieved.



## Availability:

 I am not currently enrolled in any academic program or have any jobs,
and will be available to work on the project for a minimum of 30 hours
per week.


## After the Internship:

The Git community fosters proper and effective communication,
regardless of one=E2=80=99s level of experience. The patience, guidance and
explanation of technical concepts shown by community members are
wonderful and this has made me grow not just technically but also
behaviorally. Due to this, I plan to continue actively participating
the in Git community and be part next generation of those saddled with
sustaining this great project and preserving its legacy.


I look forward to reviews as regards my proposal.


A special appreciation to everyone on the mailing list for reviewing my pat=
ches.

My mentors Patrick and Phillip, Junio, Eric, Christian, Brian,
Kristoff, Taylor, and Josh.

I am grateful to you all.

Thanks

Abraham Samuel.

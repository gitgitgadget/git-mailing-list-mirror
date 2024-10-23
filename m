Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366B622615
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 21:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729719967; cv=none; b=kzvR4Cxyu2QX/iaC50bSMmzWhMiaZtaOfx5A3F/7R4bpBq5obimK/kDiN5Du+yodPmm2JzV0ZwkWJPg8dmFRwJsw3bD9uv5m38dGir3VmJBnHRZiY7/dYvEuaSZRzR8djbGWscQt/XJM3XEg3tePMplfXvhwgqyzK4gGoB5uis0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729719967; c=relaxed/simple;
	bh=1gsWh0VVYagotI2h2zLjiUGdh1xQKhWMPxafQlPhKYA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=is6Cenu8be+MyEOMZekSFY4k27vpriqmpzb3omP7hdzV3uiM9RYdqp4G2RSek/FtcX06eSPmwuXCpcV7GGnTpZSyOJUWnZk+43xCU9frXQIP7RQ961D3lIyy3ySewphl1i0Arojh73TNUXaBldraLXTWQRwtmg7K6smsxrKUqD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fyxDN4lW; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fyxDN4lW"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43162cf1eaaso3254805e9.0
        for <git@vger.kernel.org>; Wed, 23 Oct 2024 14:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729719962; x=1730324762; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TU+Jh2SRZOgufebTfwXiXAciRd3cKw8mON6dD5EXsQA=;
        b=fyxDN4lWmXY79J4nmc2y4SQ81OzvopCLnUKUDwmaTqQdFEJtwwSoYiHGhXYMvf8a7l
         ImFJLgfd7XyQ4tdVrofac4N9Fr2BHOc4J0LoIy4GDspBMl5StDqNdtl20l/eibIgQcqJ
         m4Yqm9ZFQJU+yIbZjA2Q1UfpivmjJF6s1wEVtH9/pp8ymEtrbuLNt0nNz5JgLdSetdrO
         8RtY6ACQwIeWUmPnm3oJeFcRX5lc1kfjbJoxcv2IpTLgs+mwE8RXiX899gfTKmImqUOn
         GSkT2PPIEfC0PUBVx3n7Xyaj32U9Cfz0DZ0KF4oxMEpPrPSYU84Q5NcpUpfalkAuKRPa
         tzdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729719962; x=1730324762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TU+Jh2SRZOgufebTfwXiXAciRd3cKw8mON6dD5EXsQA=;
        b=LRoXpZPDE4jE378fEgKqN3ZtDEEhFAs+j1ozg9qkEBoOxLGMWwhwWTP1w8X4ri1ZYw
         zAaTKWjctAbTKbGs9Iy2mV8md//6Ntk9YiIjcvTG62ADvNVS0sJ8xwa/fU/2I0moZcCo
         5RTKfN4mQYTjgcsNgfLKcEik7ZJ3yP2tSXudWWi1PiFzOUDWhNuSs6n3ZGiYCfBOZeAL
         9RCwnJjDlgeMdB7FZydnTihtxH//3wWKBaPKE7U4UQBmbLTvoRIjWfq7mkGoC5VHSVbh
         +2KYH4HOzmZMMMrnHoDsMcHqZKOG4QXTGQFsY3lGV7lqADZ29+3XN6n6zoYX/g8FGchj
         Is1Q==
X-Gm-Message-State: AOJu0Yz8z4l0josXt9joo+nHmAypFtK0VgN30P0ThTYKuWa0+fqvSFPs
	diGzYa0nkuZwpjD9ZjMLgwMiabdsSf4pJ1twHulxT3Fq/NOkLLkZmfbpFdUBoB1ZTbLLXge9INq
	vnNobwN1nY8uANircZsdWcNPiyjbsWkePbTtHiiMe
X-Google-Smtp-Source: AGHT+IFyRrcXJqZIWKJA3P5JcgmvE7ZQVJVqsPlJuJ2S+XQp3twvDc9MYbSVKhtaMMpX9se11Ir2RH6v8JEOAV/2Ax8=
X-Received: by 2002:a05:600c:6002:b0:431:52cc:877a with SMTP id
 5b1f17b1804b1-4318424f1b0mr38472865e9.34.1729719961953; Wed, 23 Oct 2024
 14:46:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Samuel Abraham <abrahamadekunle50@gmail.com>
Date: Wed, 23 Oct 2024 22:45:52 +0100
Message-ID: <CADYq+fZBGZiTQduQ+4KcQ7H2Hysb04pg8YR++8PWAkQOM76OPg@mail.gmail.com>
Subject: [Outreachy][proposal]: Convert unit tests to use the Clar testing framwork
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, 
	Phillip Wood <phillip.wood@dunelm.org.uk>, christian.couder@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

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
frameworks such as t/helper/test-tool.h and t/unit-test/test-lib.h.

Clar provides a structured and efficient way to write and execute
tests and is well-suited for a project like Git where robust testing
is essential to maintain quality and stability.


## Contribution to the Git Community:

I have participated in contributions to Git=E2=80=99s codebase after gettin=
g
accepted into the Outreachy contribution phase in October 2024,
working on what I found doable and within my reach. Below is the list
of my contributions:

- [PATCH v4] t7300-clean.sh: use test_path* helper functions for error logg=
ing.

List thread: https://lore.kernel.org/git/pull.1811.v4.git.1728498122419.git=
gitgadget@gmail.com/

Status: merged into master

Merge Commit: 77af53f56f100b49fdcf294f687b36064d16feca

Description: The patch converted instances of  =E2=80=9Ctest - [def]=E2=80=
=9D in test
cases to test_path_* functions to get error logs when the test case
fails when testing for the existence of a file or directory after =E2=80=9C=
git
clean=E2=80=9D or =E2=80=9Cgit clean -d=E2=80=9D is called as the case may =
be.



- [PATCH v4] notes: teach the -e option to edit messages in the editor

Status: integrated into Seen

List thread: https://lore.kernel.org/git/pull.1817.git.1729296853800.gitgit=
gadget@gmail.com/

Description: The patch worked on a #leftover bit which added the =E2=80=9C-=
e=E2=80=9D
option to =E2=80=9Cgit notes add=E2=80=9D and =E2=80=9Cgit notes append=E2=
=80=9D subcommands when the
message is supplied with the -F and/or -m options. The patch enables
fine-tuning the message by invoking the user=E2=80=99s default editor
prefilling the message in the editor to allow editing the message to
the required taste before adding the note to the commit


## Project Plan:

The first steps to migrating existing tests to Clar would be studying
existing tests in the t/helper and t/unit-tests directory which will
enable me to determine those appropriate for conversion.

Liaise with mentors and community members to determine the viability
of converting the selected test for conversion.

Convert the selected test to Clar while in constant effective
communication with the mentors and Git community, implementing
feedback and review suggestions.

Properly test converted scripts to ensure validity and correctness.

Steps to converting the existing unit tests to the Clar Testing Framework

 From the project description in the Outreachy Project Description page,


https://www.outreachy.org/outreachy-dec-2024-internship-cohort/communities/=
git/#convert-unit-tests-to-use-the-clar-testing-framewo,
the goal is to convert all Git=E2=80=99s existing unit tests to use the Cla=
r
testing framework exclusively.


The existing unit tests which would need to be converted to Clar are;

.c test files present in t/unit-tests: Tests in this directory use the
t/unit-tests/test-lib testing framework and are =E2=80=9C.c=E2=80=9D script=
s,
converted from the shell-based testing which used the tests in
t/helper/ and corresponding t<number>-<name>.sh test files. Examples
of this conversion can be seen in the link below which references Achu
Luma=E2=80=99s work

https://lore.kernel.org/git/20240226143350.3596-1-ach.lumap@gmail.com/.


The link shows the work done in converting the test from
t/helper/test-sha1.c and test/helper/test-sha256.c to use
t/unit-tests/t-hash.c which uses the t/unit-tests/test-lib.h framework


The steps to convert files located in this directory include;

- Identify the test files to be converted.

Examples of such files are the t/unit-tests/t-hash.c, t/unit-tests/t-strbuf=
.c

- Rename the test file from t-<name>.c to <name>.c. This pattern
follows the style used by Patrick Steinhardt in his conversion of the
t-strvec.c and t-ctype.c files to use the clar framework.

https://lore.kernel.org/git/604303e31aad3a9e74f7bdddc84f11d4d137c864.172545=
9142.git.ps@pks.im/
and

https://lore.kernel.org/git/ba05b9f1eef8136e087846ee54a076558097a240.172545=
9142.git.ps@pks.im/

As a sample demonstration, we will convert the t/unit-tests/t-hash.c
to use Clar.

- Add the module name CLAR_TEST_SUITE variable in the MAKE file.

  CLAR_TEST_SUITE +=3D hash

The next steps will typically involve writing optional setup and
cleanup functions with the signature =E2=80=9Cvoid
test_<suitename>__initialize(void)=E2=80=9D and void
test_<suite_name>__cleanup(void) and the actual tests also with the
signature

void test_<suitname>__<testname>(void) and the Clar methods such as
cl_assert(), cl_assert_equal_s(), cl_assert_equal_i() etc can be used
to verify the results against the expected.


 The sample hash.c will have contents as follows
--
#include =E2=80=9Cunit-test.h=E2=80=9D

#include =E2=80=9Chex.h=E2=80=9D

#include =E2=80=9Cstrbuf.h=E2=80=9D

static struct strbuf aaaaaaaaaa_100000 =3D STRBUT_INIT;

 static struct strbuf alphabet_100000 =3D STRBUF_INIT;

// Setup function for the suite

void test_hash__initialize(void)

{

strbuf_addstrings(&aaaaaaaaaa_100000, =E2=80=9Caaaaaaaaaa=E2=80=9D, 100000)=
;

strbuf_addstrings(&aaaaaaaaaa_100000, =E2=80=9Cabcdefghijklmnopqrstuvwxyz=
=E2=80=9D,100000);

}


// Teardown function for the suite

void test_hash__cleanup(void)

{

strbuf_release(&aaaaaaaaaa_100000);

strbuf_release(&alphabet_100000);

}


static void check_hash_data_clar(const void *data, size_t data_lenght,
const char *expected_hashes[])

{

cl_assert(data !=3D NULL);

for (size_t i =3D 1, i < ARRAY_SIZE(hash_algos); i++) {

git_hash_ctx ctx;

unsigned char hash[GIT_MAX_HEXSZ];

const struct git_hash_algo *algop =3D &hash_algos[i]

algop->init_fin(&ctx);

algop->update_fn(&ctx, data, data_length);

algop->final_fn(hash, &ctx);


cl_assert_equal_s(hash_to_hex_algop(hash, algop), expected_hashes[i - 1])

}

}


// Sample Test

void test_hash__empty_string(void)

{

const char *expected_hashes[] =3D {

=E2=80=9Cda39a3ee5e6b4b0d3255bfe95601890afd80709=E2=80=9D,

=E2=80=9Ce3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855=
=E2=80=9D

};

check_hash_data_clar(=E2=80=9C=E2=80=9D, strlen(=E2=80=9C=E2=80=9D), expect=
ed_hashes);

}


// test that uses variables set by the set-up method

void test_hash__large_aaaaa(void)

{

const char *expected hashes[] =3D {

=E2=80=9C34aa973cd4c4daa4f61eeb2bdbad27316534016f=E2=80=9D,

=E2=80=9Ccdc76e5c9914fb9281a1c7e284d73e67f1809a48a497200e046d39cc7112cd0=E2=
=80=9D

  };

check_hash_data_clar(aaaaaaaaaa_100000.buf, aaaaaaaaaa_100000.len,
expected_hashes);

}
--
The test methods are then added to the t/unit-tests/clar-decls.h
included in the unit-test.h file

The test can then be run with =E2=80=9Cmake unit-tests=E2=80=9D or
./t/unit-tests/bin/unit-tests.

 While the sample above does not fully contain all the cases I
converted, below is the sample output I got.

...
# start of suite 3: hashes

ok 37 - hashes::empty_string

ok 38 - hashes::single_a

ok 39 - hashes::abc_string

ok 40 - hashes::message_digest

ok 41 - hashes::large_aaaaa

ok 42 - hashes::alphabet_large

ok 43 - hashes::literal_blob_0

ok 44 - hashes::literal_blob_3abc

1..44


The test scripts in the t/helper directory:

The tests in this directory are invoked by the corresponding shell
scripts which spawn processes to test the different unit tests in the
t/helper directory.

The process involved in converting these shell scripts to Clar
framework will typically follow the same steps as illustrated above
bar the following differences.

Identifying the tests to be converted to Clar

Create a new .c  file name which should be named appropriately to
illustrate what the file is testing.

However, the shell-based script which tests the functions in t/helper
will be studied for in-depth understanding and then refactored into a
.c file which follows the steps above in converting to use Clar.


Project Timeline:

Community Bonding (Present - November 26):

Continue making contributions to the Git codebase working on different
things within my capacity and getting more familiar with the codebase,
participating in patches review.

Conversion of tests begins (December 9 - December 23): Familiarize me
with the conversion process to further enhance my understanding,
identify files for conversion and start the conversion process, and
set up a blog for weekly updates on my conversion process.

Implementation of community and mentor reviews (December 27 - January 31):

Continue with conversions while testing converted tests, communicating
with reviewers and implementing reviews.

Testing (February 1 - March 1): Continuously determine the correctness
of the converted tests by continuously testing and also liaising with
mentors constantly.



Availability:

 I am not currently enrolled in any academic program or have any jobs,
and will be available to work on the project for a minimum of 45 hours
per week.


After the Internship:

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

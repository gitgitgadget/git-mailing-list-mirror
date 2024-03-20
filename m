Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C5B41C86
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 13:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710943116; cv=none; b=cCwUmQEIIugigKfh6/wz/bzji7iK8y9lFfgYvpXPFSqNP/mWXxu8Thul79vIvNCuLQhH5RjYLcLQayHN982YmzzQFrp1ZyA3eX3yCcA8yPqEpiJDO/0JLfkQcBP6o3OYi4/6h9lRwNwtgsrCDPKoAmNHk8lQqgEXA2NtbRPaOhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710943116; c=relaxed/simple;
	bh=O3kyjM+/in0hltxbCGHAkVI6zI04gyzgig4vLvbz6io=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PgvgW0ZflW+PxHx+IrVxhYYboCPeFO4lyKAV3fIIewKtdWFyAPfJBsO1Sh9cTZltHuOA1dtjS70qIsmGIkaG9EKkH6yjEWOrzb5BDcWVrg7B7i7ybyvcRORFA4ikfi4zXfxanvOR5O4FaIZ9UgHwDgwuzswq1NjKuRuCsNjYTV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hJxPsR6k; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJxPsR6k"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a46db55e64fso253163266b.1
        for <git@vger.kernel.org>; Wed, 20 Mar 2024 06:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710943112; x=1711547912; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gBLFVcCwhN/bim0AabfhELA8cz9Y59u1/Nt44ZbKBvo=;
        b=hJxPsR6kHUpyFArymkr+nK/ZRIrhRiQna08VhLN0snQ0Kl2Xi96naMbXAcpgFKZ4af
         dRw6fwWa+gHmhScN3Q6eqz8gWf/9gKK128XPpMo5SSIMZ4ZfJU8hg/6UNxztV5GIkUuk
         5B8jdRds4pltxwRGxbrfOfroxVozeQ91yHgnSlMlgmBXIIe18yfPLR1v9M9T0IwIp/3b
         kgD4Gj6gBOXOgNzICC06yRScQCaLinqhTXilynrTw1OKdBl9Cudl6++B6YBx02ZNIqi5
         JB3OW5muRdzz2u3p8Ac5UgIsAlYu7JQKtYehQd/hBdiIkW/UlxSS+kaIgyil0W3x4e+K
         ulSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710943112; x=1711547912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gBLFVcCwhN/bim0AabfhELA8cz9Y59u1/Nt44ZbKBvo=;
        b=d7HE3xRvCF4v7En2QgppzaxaWqc1kyDlbeMPdD6FNo6O/D3iDJsl+OBOkoM8sYVgZN
         F9X9/eH4yfOuqJrROHk0/NBzK/YUuvaJE8f5KRhu8GqkjJ9GU/3OpQuWafThgJzkC08F
         WqfXopx/7og122cmt0vvi9WahraWlFurHKhzdXB44je5ju3hFelJxQ4OaKF086VNibX/
         EaN4IQ6odHFewSvUq8OdzcLE+Crhw6qf5VxISGXu/Sx5acEsGCfQS3TcuhG5G6yyASq7
         ZWFwEcLXfFYMcBoj7yRAUpqisrH6pZyoSLsqcJCff36AdB93MSUKAowgxXifu0y9zlmD
         AcQg==
X-Gm-Message-State: AOJu0YwazN3sPvoxDZJNH59TWrAP6U+TsZhXlf6FJaUEJt/sPKrhOjHt
	fnpFPHjpIEW0hmblVppxo81FT2izDea/YbHFON68soUbPImuvQEBU8Fq9TkUMnsGlkDNxdcgNXl
	QSCiLirenezSkK7HJpp/RK5tq0mEB+TRhjOY/1w==
X-Google-Smtp-Source: AGHT+IEZQYLDkwR6PcS8KSHrjvnrXcbrdBmYL8m6wLjDTQxY06Yd4DU5ELDZtGMnf7R+HtjoDDav5Tbyc+Rx+L8o49M=
X-Received: by 2002:a17:907:990b:b0:a3f:33b2:5ce2 with SMTP id
 ka11-20020a170907990b00b00a3f33b25ce2mr12020722ejc.35.1710943111562; Wed, 20
 Mar 2024 06:58:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319225444.21574-1-shyamthakkar001@gmail.com>
In-Reply-To: <20240319225444.21574-1-shyamthakkar001@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 20 Mar 2024 14:58:19 +0100
Message-ID: <CAP8UFD2COoXfDdS1eg5DR_0NL8bOhCHvXUkqkfzLbSejRmgwSw@mail.gmail.com>
Subject: Re: [GSoC][RFC][Proposal] Move existing tests to a unit testing framework
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: git@vger.kernel.org, kaartic.sivaraam@gmail.com, ps@pks.im, 
	karthik.188@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 19, 2024 at 11:55=E2=80=AFPM Ghanshyam Thakkar
<shyamthakkar001@gmail.com> wrote:
>
> Hello everyone,
>
> This is my proposal for the project "Move existing tests to a unit testin=
g
> framework" in Google Summer of Code 2024. The web version can be viewed a=
t:
> https://docs.google.com/document/d/1wmosedy-UKd_mhAAjccv1qETO1q00s-npYj2m=
6g-Hd0/edit?usp=3Dsharing
>
> I appreciate any feedback on this proposal.
>
> Thanks.
>
> -- >8 --
> Move existing tests to a unit testing framework
>
> Personal Information
> --------------------
>
> Name: Ghanshyam Thakkar
> E-mail: shyamthakkar001@gmail.com
> Ph. No.: +91 7990974044
>
> Education: L.D. College of Engineering, Gujarat, India
> Year: IV

Is it year 4 out of 4 or 5 or more? Sorry, but it's interesting to
know when you are going to graduate and if you might need to look for
a full time job soon.

> Degree: Bachelors in Electronics and
>         Communications Engineering
>
> GitHub: https://github.com/spectre10
> Time-zone: UTC +5:30 (IST)
>
>
> Overview
> --------
>
> Initially Git used to only rely on shell scripts to test the functionalit=
y
> usually deemed to be internal (e.g. libraries, functions etc.) This was a=
chieved
> through t/helper binaries which would take input via stdin and output thr=
ough
> stdout and the test scripts would consume those outputs.

I think some test-tool helpers also take arguments on the command line.

> This translation is
> costly due to the following reasons:
>
> - Each test script creates a new git repository which is many times not n=
eeded.
>   See here[1] for example.
> - These scripts spawn processes every time they need a certain output. An=
d
>   spawning processes are expensive (especially on windows).
> - Difficult setups: sometimes the functions or the libraries we are testi=
ng need
>   some special setup such as defining flags for custom behavior etc. whic=
h
>   cannot be done through the shell scripts, hence we might forego testing=
 those
>   conditions.
>
> Moving to the unit testing framework would give us many benefits such as
> increased runtime performance, and therefore lower test duration and solv=
es all
> of the above points. The choice of framework and the rationale behind it =
is
> thoroughly described in Documentation/technical/unit-tests.txt. Therefore=
, the
> goal of this project is to move existing unit tests from t/helper/* and i=
ts
> corresponding scripts to the new unit testing framework. And there has be=
en work
> going on to do this by Outreachy intern Achu Luma.
>
> The expected project difficulty is medium and the expected project size w=
ould be
> 350 hours.
>
>
> Pre-GSoC
> --------
> I initially got into Git=E2=80=99s codebase in December, 2023 and started=
 my
> contribution journey in January, 2024. I worked on mostly what I found
> interesting and within my reach. Following is the list of contributions t=
hat I
> have made, in chronological order:
>
> - [PATCH v6 0/2] t7501: add tests for --include, --only, --signoff
>     Status: merged into master
>     Merge Commit: 2be9ccf23e0592b83b78e719574e580e79db0375
>     Description:
>     This patch series added missing tests for --include, --only and --sig=
noff
>     options of git-commit. While working on this patch I accidentally rep=
roduced
>     a bug where in an untracked path provided to the commit command with =
-i
>     would not error out. This was noticed by Junio. Therefore, this patch=
 also
>     included a TODO comment describing this bug.
>     Mailing list thread:
>     https://lore.kernel.org/git/20240109060417.1144647-2-shyamthakkar001@=
gmail.com
>
> - [PATCH v3 1/2] t0024: avoid losing exit status to pipes
>     Status: merged into master
>     Merge Commit: 40225ba8b494080d7f90dd5e129daa7b11c613d1
>     Description:
>     Although this was not my first contribution, it was done to fulfill t=
he
>     microproject criteria from the list of micro-projects on Git Develope=
r
>     Pages. The first patch replaces the pipe to the redirection operator =
to
>     store the output to a temporary file to avoid losing exit status of t=
he git
>     commands. And the second patch of the series fixes the style violatio=
ns to
>     adhere to the current standard described in CodingGuidelines.
>     Mailing list thread:
>     https://lore.kernel.org/git/20240118215407.8609-1-shyamthakkar001@gma=
il.com/
>
> - [PATCH v6 0/2] add-patch: classify '@' as a synonym for 'HEAD'
>     Status: merged into master
>     Merge Commit: 65462776c2963b377968e580ace1590238bf79c1
>     Description:
>     The first patch of this series removed the disparity of command line =
output
>     of using =E2=80=98HEAD=E2=80=99 vs =E2=80=98@=E2=80=99 in =E2=80=98gi=
t reset/restore/checkout -p=E2=80=99. And the second
>     patch removed the perl prerequisites in the test scripts which use th=
e patch
>     mode functionality.
>     Mailing list thread:
>     https://lore.kernel.org/git/20240128181202.986753-2-shyamthakkar001@g=
mail.com/
>
> - [PATCH] restore: allow --staged on unborn branch
>     Status: Discontinued
>     Description:
>     This patch added functionality to assume an empty tree when on an unb=
orn
>     branch to be able to use =E2=80=98restore =E2=80=93staged=E2=80=99. H=
owever, this was discontinued
>     due to lack of community interest. In hindsight, I think that this wo=
uld
>     have been an acceptable patch, had I described it well.
>     Mailing list thread:
>     https://lore.kernel.org/git/20240206230357.1097505-2-shyamthakkar001@=
gmail.com/

I think it's still Ok to send a V2 with improved explanations. Perhaps
you can do it after improving this proposal though.

> - [PATCH] unit-tests: convert t/helper/test-oid-array.c to unit-tests
>     Status: on hold until GSoC
>     Description:
>     This was used as a practice patch to the current project proposal. Th=
is will
>     be used as a reference in the proposal ahead.
>     Mailing list thread:
>     https://lore.kernel.org/git/20240223193257.9222-1-shyamthakkar001@gma=
il.com/
>
> - [PATCH v2] setup: remove unnecessary variable
>     Status: Merged to master
>     Merge Commit: 272fd9125aae215ece1c465a4b7d336cf81c3e62
>     Description:
>     I initially proposed the TODO comment removed through this patch as a
>     micro-project for my first patch. However, the TODO comment was a res=
ult of
>     misunderstanding, therefore this patch did some minor code simplifica=
tions
>     along with the removal of the TODO comment.
>     Mailing list thread:
>     https://lore.kernel.org/git/20240304151811.511780-1-shyamthakkar001@g=
mail.com/
>
> - [PATCH 0/2] commit, add: error out when passing untracked path
>     Status: WIP
>     Description:
>     This patch series would fix the potential bug discovered in the first=
 patch
>     that I sent (--include tests).
>         Mailing list thread:
>     https://lore.kernel.org/git/20240318155219.494206-2-shyamthakkar001@g=
mail.com/
>
> - Helped a fellow contributor by reviewing their patches
>     Thread links:
>     - https://lore.kernel.org/git/CZG3HO25QLAG.3Q9V03SCO99HL@gmail.com/
>     - https://lore.kernel.org/git/CZHJPF604DV9.X0A0VX1AB7P8@gmail.com/
>
> Proposed Project
> ----------------
>
> ----What=E2=80=99s unit testing----
>
> Unit testing is a method to test a specific unit of source code (i.e. a
> function, a module etc.). This is very helpful in catching all of the cor=
ner
> cases and possible scenarios.
>
> ----Steps to convert the existing unit tests to the new framework----
>
> It can be thought of as a series of steps which are outlined below:
> - Identify a suitable candidate from t/helper directory.
> - Each t/helper unit test has a corresponding shell script which actually=
 tests
>   the output from the binary. Each test-case in that script would ideally=
 become
>   a separate function (and therefore a single test-case) in the migrated =
unit
>   test.
> - Convert the test logic from the shell script to C. This would involve
>   understanding the underlying library/functionality which is being
>   tested. Subsequently, make functions which would be ideally be a single
>   testcase.
> - These functions can be called via the TEST() macro in the cmd_main
>   function which is the entry point to the test.
> - Each of these functions contains a set of {check(), check_int() etc.} m=
acro
>   functions which check the condition provided to them and if it fails, p=
rints
>   a message to the stdout. If even a single check fails the whole test-ca=
se is
>   considered a failure.
> - Modify Makefile to add the reference of the new test to the UNIT_TEST_P=
ROGRAMS
>   variable.
> - The skeleton of the new unit test would look something like this:
>
>     #include "test-lib.h"
>
>     static void testcase_1()
>     {
>             ...
>             check(actual =3D=3D expected);
>             ...
>     }
>
>     int cmd_main(int argc, const char **argv)
>     {
>             TEST(testcase_1(), "test description");
>             return test_done();
>     }
>
> - After the migration remove the references of t/helper/{old-test-helper}=
.{c, o}
>   from the Makefile and from the t/helper/test-tool.{c, h}. And subsequen=
tly
>   remove the shell script which used to consume the old helper binary.
>
> ----Additional Notes along with a Reference Implementation----
>
> These tests usually contain duplicate logic with variations in input and =
output.
> In such cases, we can define macro functions to not duplicate such logic.=
 I.e.
> in t-ctype, we can see how a custom macro is defined to avoid duplication=
 of
> test logic, with variation only in the input being used. Also, some these

s/some these/some of these/

> existing tests are not worth migrating. For example, test-tool binaries w=
hich
> are also used outside of the corresponding shell script (i.e. used in oth=
er
> tests for setup purposes) would be low on the priority list of possible
> migrations.
>
> I have made a reference implementation of t-oid-array.c which migrates
> t/helper/test-oid-array.c and t/0064-oid-array.sh to the new framework, w=
hich
> can be viewed here[2]. Note that the failing tests are not related to my
> implementation and rather a known issue[3]. It may or may not to be good =
enough to
> be merged into master, however it sufficiently showcases my abilities to
> understand framework, the use of different macros and the ability to unde=
rstand
> different internal libraries and data-structures such oidarray itself.
>
> This implementation was also reviewed by Christian Couder on the mailing =
list
> and I have made some adjustments according to the feedback.
>
> This implementation uses a macro to test the ordered enumeration of oidar=
ray
> with different inputs. And also tests the lookup capabilities of oidarray=
 with
> different queries and inputs with the help of a macro. There are also var=
ious
> helper functions defined to help with printing debug output, generating
> hexadecimal representations, etc.
>
> ----Previous Work----
>
> TAP implementation along with t-basic and t-strbuf:
> https://github.com/git/git/commit/e137fe3b
>
> t-mempool: https://github.com/git/git/commit/6cbae640
> t-ctype: https://github.com/git/git/commit/e875d451
> t-prio-queue: https://github.com/git/git/commit/808b77e5
>
> Achu Luma has been doing this migration as part of Outreachy internship. =
Their
> branches can be seen here[4].
>
> ----Goal----
>
> The end goal of this project would be to migrate as many unit tests as po=
ssible
> according to the steps outlined above. In doing so, also enhance some of =
the
> tests as needed to be extensible such as the ability to test different ha=
sh
> algorithms on a single oidarray. This enhancement is not yet implemented =
in the
> reference implementation due to the series which enables the use of diffe=
rent
> hash algorithms on oidarray not yet merged into master (in next though).
>
> Currently, there are 78 test-*.c files (not including test-tool.c) in t/h=
elper/
> directory according to the master branch. Of course, migrating all of the=
m would
> be a difficult task in 350 hours, therefore I plan to migrate around 1 un=
it test
> per week during the Community Bonding and Coding Phase. This may fluctuat=
e
> depending on the type of test. Some of those tests are already being work=
ed on
> by Achu Luma.

I think it would be interesting to know which of these 78 test-*.c
files you would like to migrate first, especially as some of them
might not be worth migrating as you said earlier.


> ----Timeline----
>
> Pre-GSoC
> (Until May 1)
> - Continue to work on different things like solving the bug discovered in=
 the
>   first patch series that I sent. Be engaged in the community.
>
> Community Bonding
> (May 1 - May 26)
> - Talk with mentors and identify the tests which are suitable for migrati=
on.
>   Learn the libraries which are used for those tests and read up on the A=
PI.
>   Look at Achu Luma=E2=80=99s branches to further familiarize myself with=
 the migration
>   process. Start the migration early with the mentors=E2=80=99 permission=
.
>
> Phase I
> (May 27 - July 11)
> - Continue implementing the tests in the unit testing framework with the
>   guidance of mentors and send out patches to the mailing list for commun=
ity
>   approval. Approximately 6-7 tests would be done/cooking for migration a=
t
>   the end of this Phase.
>
> Phase II
> (July 12 - Aug 18)
> - Continue the migration and talk with the mentors about the pace, qualit=
y of
>   patches and seek feedback. And enjoy the process. Another 5-6 tests wou=
ld be
>   done/cooking at the end of this Phase.
>
> Final Week
> (Aug 19 - Aug 26)
> - Finish up any remaining tests.
> - Fix any bugs and some final touches.
> - Make a final report about the work accomplished and outline future work=
.
>
> ----Blogging----
>
> I believe that writing about one=E2=80=99s work helps them track their pr=
ogress from a
> bird=E2=80=99s eye view. And also helps them realize if they are making m=
istakes from a
> long term perspective. I plan to blog about the progress bi-weekly. Altho=
ugh I
> have not setup the blog yet, it will be at:
>                         https://spectre10.github.io
>
> ----Availability----
>
> My current semester ends on 30th April and my exam/viva is tentatively on=
 7th
> May. After that I have freed my summer for GSoC, therefore I will be able=
 to
> give a minimum of 35-40 hours per week.
>
> Post-GSoC
> ---------
>
> The Git Community has helped me very much and tolerated my beginner mista=
kes.
> I have grown as a developer since I started contributing to Git. I learne=
d the
> importance of writing good commit messages, benefits of splitting up patc=
hes,
> effective programming style and good communication etiquettes. Therefore,=
 I plan
> to be involved even after my GSoC journey ends. I am very much involved i=
n the
> Git ecosystem and also contribute to another project in the Git ecosystem=
 called
> gittuf[5]. Also post-gsoc, I am planning to help out in aggregating for G=
it Rev
> News, which I personally enjoy reading.
>
> My Appreciation
> ---------------
>
> I would like extend my thanks to all of the folks on the mailing list and
> Discord who have helped me in contributing to the Git Project including J=
unio,
> Christian Couder, Phillip Wood, Elijah Newren and many others. And I have=
 also
> taken some references of Achu Luma=E2=80=99s work for this proposal, so t=
hanks to
> her, too.



> -- After GSoC --
> ---------------------
>
> After GSoC I intend to be a part of the community and keep
> contributing to the git=E2=80=99s codebase. I eagerly want to learn a lot=
 from
> the git community and enhance my skills. I also see myself making
> important contributions to git in the future.
>
> When I first joined the community 2 months ago, the ancient way of
> collaborating through a mailing list by sending diff patches was
> really puzzling (GitHub was the only means that I knew about for
> open-source collaboration). After sending a patch I got a little
> comfortable with it and started loving it.
>
> -- Closing remarks --
> ----------------------------
>
> I am really enthusiastic to contribute to git. I really want to learn
> a lot from my mentors and the whole git community. Everyone
> contributes using git, why not contribute to git :).
>
> In the end I really want to thank the whole community, especially
> Christian and Junio, for their valuable time in reviewing my patches
> and guiding me with the problems I faced.

Thanks for your proposal. Please make sure you submit it soon as a pdf
file to the GSoC website. It can then be updated by uploading a new
pdf until the April 2 1800 UTC deadline.

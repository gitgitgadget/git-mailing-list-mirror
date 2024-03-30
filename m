Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E703EBB
	for <git@vger.kernel.org>; Sat, 30 Mar 2024 14:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711809537; cv=none; b=DV4CqBqXPBVZwnK0jfRAAMRTbSAJDW5o/mdjVR4avsKNpMJmY0MLNk2SAxjFM039UkPthWTTXDZxu0Ihh+HVo+1xGVbMkfOQ9SRZyjlnKZ9C+QrTA4HDlp6e6Tg5HCdTs8QEEzv9vMxWNC4xEt1lnTDcWbTg0SA4aBSVWYfz5vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711809537; c=relaxed/simple;
	bh=zqtcIi+6aZsC8ilLd+WIA/lYO0YM9KB+0JKDjkIJM/k=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=reaxBBQWrx1Rxzw7Eynfjr3H0ar1CtbtwNZ6gROp4LAJQ8/h+VsZCU+ybOQKb28V0qCbMjy9gpEZ9r0CIGbh4rSzCvNvXCr09pP9D+LMd89oH+/zj20vs84Wjgg4PF7RmyuSxRd5985VynJKMxDutMY0HKxRsKplB4BfFnCttAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KHhqlRCi; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHhqlRCi"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d68c6a4630so29629281fa.3
        for <git@vger.kernel.org>; Sat, 30 Mar 2024 07:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711809533; x=1712414333; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GBTkHwHn8RitIIY8N6EbspZnu9A3Ce4Cf0uMwlflqko=;
        b=KHhqlRCiS15LzObiibjgQULYpaI9tSZMFKktpLRgnQdbShinmrZEftix1DSEWMiAgw
         v9Y3pxPG1sykz7DUCcsXBxvAWq0LG9XKS5X6Cj+7fbm+fsGQdATvlEsAqDKBQL3+yDcr
         tHvVt1okY4BSJUxDS+qKPo6abdR6p8BqAL15oq4pIw5F4benD4+JoyDMEBxGhfZf0Fdl
         0WqphJEAU8FPEsx5uvZ8Uwuvgnejrzu9pOd2ZxGLK6bha0fDitbRo7SJqabF6K+VubPb
         R/oNUJVyTliMpLWppFlwvjitEbrVA8AEFHYRFpNdBWFHHmCkZVIFab0x/j9iRqc8Nril
         yy1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711809533; x=1712414333;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GBTkHwHn8RitIIY8N6EbspZnu9A3Ce4Cf0uMwlflqko=;
        b=OlW28uiMg5ygI56i7m9pFDXrrtwgCAcspSTr46uJjrhmIGUv5Zw6dEEcGVASjRoRtQ
         G8JygEZk9LLoPS3xqW/Va+urzu3S+KyUgiTAQ4in8i3OeO3/J753XBWp0oKW/knagGkx
         bPUEntAouFpJ2OuuhDtgvGe+i6dUIIpSFImpAiNB81k8Tql2fISTwqz+BkNLMU7Jyb4h
         E9hk5cejrMkbMzAKDC+9xDE/Cyd8PnC+ESgerGveIJoW9QpQ7ShKlzowd+8SBY7oMuAv
         po4bUIKgrQlxgEHQmDq8ySPZUCI4fJuGNFv4Dly2Uou0i8FOszSZQ+BOzEnACEWzi1t6
         jWwQ==
X-Gm-Message-State: AOJu0Yyv/Ts2hLBgd3pa+c47wWCca2ywscX9mhCsBSohb3FOFQ5K5TFi
	OPuYjA3GjoXPQZnYUwYyPIQWRsDAKi+iPqyXpZVnLhJfsoXGgl2XQ1ColPzqngC4rz3baWiKrpu
	ELETu8ArYJUAVR6n9h/VoNeBfw1bY6pQfcBpWkQ==
X-Google-Smtp-Source: AGHT+IHVF4UoohAbpdPBWNfu8m8G9WHFMVbYThRb2qF6tL0c7Wm6jI1Z1JhN0EKPstbUJtCWNyUBS0va/c7ENFpo88E=
X-Received: by 2002:a2e:8699:0:b0:2d4:6815:fc6f with SMTP id
 l25-20020a2e8699000000b002d46815fc6fmr2950205lji.30.1711809532692; Sat, 30
 Mar 2024 07:38:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Aishwarya Narayanan <aishnana.03@gmail.com>
Date: Sat, 30 Mar 2024 20:08:43 +0530
Message-ID: <CAHCXyj0fn5_sS8FM+US-6trM+_QbCcUnLtx8=4eJdFe=rXxkQQ@mail.gmail.com>
Subject: RFC: Move existing tests to a unit testing framework - Seeking Review
To: git@vger.kernel.org, christian.couder@gmail.com, 
	kaartic.sivaraam@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Git Maintainers,
This email aims to gather feedback and initiate a discussion on the
feasibility and implementation of this idea.

---
Google Summer of Code 2024

Name: Aishwarya N

University: SASTRA University

Program: B.Tech Electrical and Electronics Engineering

Organization: Git

Project Idea: Move existing tests to a unit testing framework

GitHub: https://github.com/Aishwarya-Narayanan03

Email: aishnana.03@gmail.com

Timezone: IST (GMT+5:30)


About Me

My name is Aishwarya N., and I am soon to graduate from SASTRA Deemed
University in Thanjavur, India, with a B.Tech. in Electrical and
Electronics Engineering. With graduation only two months away, I'm
ready to plunge into the exciting world of open source and offer my
expertise to a project that enables developers. The power of building
something from nothing through programming is a truly special and
empowering feeling. It's no wonder it resonates with me! The Git
project particularly appeals to me. Contributing to the tool that
supports innumerable software developments provides an opportunity to
have a genuine, global impact.


Why Me?

Adaptable and Open to Challenges: I thrive in lively surroundings and
see new challenges as opportunities to learn and progress. I
acknowledge that mistakes are unavoidable on the route to mastery, and
I am not afraid to learn from them.

An avid learner: My thirst for knowledge is boundless. I'm always
looking for new methods to improve myself and push the boundaries of
technology.

Collaborative Spirit: While I'm quite satisfied working independently,
I believe that collaborating is crucial for accomplishing ambitious
goals. I am an adept communicator who is eager to work with the
brilliant Git community.

Why Git?

The fast-paced world of software piques my curiosity, and Git, a basic
tool for collaboration and version control, is a necessary skill set
for success in this area of expertise. But, beyond its functionality,
Git is fascinating.I'm excited to contribute to the project that
underpins numerous developer workflows.



Project Summary

The Git project recently introduced a new unit testing framework aimed
at improving the quality and maintainability of its source code.
However, some legacy unit tests, such as the "reftable" tests in
't0032-reftable-unittest.sh', predate this framework and continue to
use the previous testing method.

This project's goal is to adapt the existing "reftable" unit tests to
use the new unit testing framework. This conversion will assure
codebase continuity, increase test readability and maintainability,
and allow for the use of the new framework's additional features and
capabilities.


Before GSoC

Microproject:Avoiding suppressing git's exit code in test scripts

Learning Git Codebase

1.Understanding Test Scripts: Exploring the test scripts in the Git
project's t- directory provided personal experience with real-world
Shell scripting used for integration testing. This helpd me understand
how Git's features are tested and confirmed.

2.Reading Commits: The reference to commit c6f44e1da5 demonstrated how
to handle Git commands in test scripts. Analysing this commit allowed
me to examine the adjustments done to address the issue of suppressing
Git's exit code, as well as get insight into the codebase's structure
and convention.

3.Navigating the Git Repository: Searching for instances of
problematic code and finding solutions within the Git repository
enhanced my ability to successfully navigate and search a big
codebase.

Best Practices

1.Avoiding Pitfalls:Avoiding typical mistakes in test scripts, such as
suppressing exit codes, can lead to more dependable testing
infrastructure.

2.Understanding Pipe Usage: Knowing when and how to use pipes in Shell
scripting is critical. This microproject describes circumstances in
which pipes may mistakenly suppress exit codes and provides
suggestions for proper use.

Connecting With Mentors:

1.Engaging with Git contributors: This microproject allowed me to
connect with mentors and Git project contributors. Seeking clarity on
specific code practices or debating changes to test scripts encourages
involvement in the open-source community.

2.Receiving comments: Submitting updates or queries about the
microproject helped in receving useful comments from experienced
developers.This feedback helped me learn the Git codebase and improve
my scripting skills.

3.Community Involvement: Participating in discussions about the
microproject on platforms such as Git email lists or forums allowed me
to communicate with a diverse community of developers while sharing
information and experiences.


Related Works

https://lore.kernel.org/git/CAHCXyj3U69qyhYewOLY9hN2rvi_5ZuSxQEBJbDxrKefm9M=
zVWg@mail.gmail.com/
- Microproject Approach

https://lore.kernel.org/git/ZgQffea0krKmZUEt@tanuki/ - [RFC PATCH]
Description: While printf might be unlikely to fail here,I felt the
change aligns with the project's goal of ensuring Git command exit
codes are captured. This approach is more robust and avoids potential
issues in the future. Status: Declined

https://public-inbox.org/git/xmqqttkqwfwe.fsf@gitster.g/

Description: This patch increases the robustness of Git's testing
framework by guaranteeing that Git commands' exit codes are
appropriately examined during test execution. Previously, suppressed
exit codes allowed tests to pass despite Git command failures. This
fix stores the output of Git commands in variables and examines their
exit codes to detect errors.The discussion focuses on improvements to
the patch submission process, such as adhering to coding principles
and referencing appropriate documentation for proper formatting and
test script adjustments.
Status: Declined

https://public-inbox.org/git/CAHCXyj1hUVNNuCOgsNv4GJUi79_o9iWZDvV8Ocz3Dodre=
YoL7g@mail.gmail.com/

Description: This patch resolves an issue in Git test scripts in which
the exit code of git ls-files -t may be disregarded, resulting in
tests passing despite Git command failures. The new version guarantees
that Git commands used in pipelines produce captured output and
perform adequate exit code checks. It also enhances code style by
adhering to established rules. This adds to more robust Git testing by
ensuring the identification and reporting of Git command errors within
test scripts.

Status: Under Review



Porting Unit Tests:

[1]https://lore.kernel.org/git/cover.1692297001.git.steadmon@google.com/

This patch series provides unit test functionality for the Git project.
The series includes the following patches:
A project plan document that outlines the goals for introducing unit
tests, as well as a review of potential frameworks and the features
used to assess them.
An implementation of the TAP unit test framework with a sample unit
test and Makefile integration.
Changes were made to the Git build system so that the unit tests could
be run in CI.
The TAP framework was selected because of the following advantages:
Simple to use and comprehend.
Widely used and integrates seamlessly with existing Git tools.

The project plan document mentions a number of outstanding TODOs,
including how to ensure tests run on various OS platforms and how to
gather unit test statistics.
This is a well-written patch series with a straightforward and logical
approach. The documentation is comprehensive and instructive, and the
code is well-organized and simple to grasp.
Here are some extra factors to consider:
The patch series discusses collecting unit test statistics. We could
you clarify on the type of statistics we want to collect?
How do we intend to deal with flaky tests?

[2]https://lore.kernel.org/git/20240112102743.1440-1-ach.lumap@gmail.com/

This is an email thread about a patch series submitted by Achu Luma to
port the unit tests for C character classification functions from the
legacy helper tool to the new unit testing framework
([Outreachy][PATCH v5] Port helper/test-ctype.c to
unit-tests/t-ctype.c).

Here are the major changes implemented in the patch series:
The unit tests for C character classification routines (isdigit(),
isspace(), etc.) are moved from the historical approach, which used
the test-tool command test-tool ctype in t/helper/test-ctype.c, to the
new unit testing framework (t/unit-tests/test-lib.h).
Refactors the tests to use the framework's testing macros (TEST() and
check_*()).
Added tests for handling EOF (end-of-file).
Overall, the patch series was well received and thought to be a
positive development. The reviewers made various suggestions for
improvement, such as expanding on the types of statistics the author
is interested in gathering for the unit tests and how to deal with
flaky tests.

[3] https://lore.kernel.org/git/20240112102122.1422-1-ach.lumap@gmail.com/

This patch migrates unit tests for the advise_if_enabled functionality
from the legacy approach to a new unit testing framework. Here's a
breakdown of the changes:

Legacy approach:

Used the test-tool advise command in t/helper/test-advise.c.

Relied on helper functions from test-tool.h.

Tests were written in shell script (t/t0018-advice.sh).

New approach:

Uses the new unit testing framework with TEST() macros
(t/unit-tests/t-advise.c).

Includes necessary headers for advise.h, config.h, and setup.h.

Tests are written in C code.

The patch removes the following files from the legacy approach:

t/helper/test-advise.c

t/t0018-advice.sh

The new unit test file t/unit-tests/t-advise.c includes three tests
covering different scenarios:

Advice is printed when the configuration variable is unset.

Advice is printed when the configuration variable is set to true.

Advice is not printed when the configuration variable is set to false.

Overall, this patch improves the codebase by using a more standardized
and maintainable approach for unit testing.

[4]https://lore.kernel.org/git/20240205162506.1835-1-ach.lumap@gmail.com/

Refactoring 64-bit Pre-requisite Checks in date.h

This is a patch for the Linux kernel which refactors pre-requisite
checks for 64-bit systems into reusable functions in the date.h header
file.

Context:

The codebase recently added a unit testing framework.

Some shell tests use a helper tool that checks for 64-bit
prerequisites (TIME_IS_64BIT and TIME_T_IS_64BIT).

These checks are also needed in the new unit tests.

To avoid duplication, the patch moves these checks to date.h as inline
functions.

Changes:

Two new inline functions are added to date.h:

check_prereq_TIME_IS_64BIT: Checks if the size of timestamp_t is 8
bytes (indicating a 64-bit system).

check_prereq_TIME_T_IS_64BIT: Checks if the size of time_t is 8 bytes
(indicating a 64-bit system).

The shell test functions in t/helper/test-date.c are modified to use
the new functions instead of directly checking the sizes.

Benefits:

Reduces code duplication.

Improves code maintainability.

Simplifies porting shell test code to the new unit test framework.

Next Steps:

A following commit will port the relevant code from
t/helper/test-date.c to the new unit test file t/unit-tests/t-date.c,
using the newly introduced functions for pre-requisite checks.

[3] Unit Testing in Git:

https://github.com/git/git/blob/master/Documentation/technical/unit-tests.t=
xt
discusses unit testing for the Git project. This gives an idea of the
background and importance of unit testing in the project applying to.



During GSoc
The main goals of this project are:
1. Understand the existing "reftable" unit tests: Examine the present
implementation of the "reftable" unit tests in
't0032-reftable-unittest.sh' to ensure that you understand their
functionality and purpose.
2. Learn the new unit testing framework: Get a thorough grasp of Git's
new unit testing framework, including setup, usage, and recommended
practices.
3.Ensuring test coverage and reliability: Check that the converted
tests have sufficient code coverage and accurately simulate the
expected behaviour of the "reftable" capability. Test and validate the
new tests thoroughly to ensure their reliability.
4. Documentation and code comments: Document the conversion process,
including any issues encountered and the reasoning behind design
decisions. Update the code comments and documentation to reflect the
changes to the tests.

Deliverables

=C3=BC Migrated reftable unit tests created in C with the unit testing fram=
ework.

=C3=BC  Unit tests thoroughly performed and validated to ensure accurate
coverage of reftable functionality.

=C3=BC Documentation explaining the migration procedure, as well as
revisions to existing documentation.

=C3=BC The final report summarises the project's accomplishments, problems,
and future recommendations.

Expected timeline
Community bonding period (May 1 - May 26)

Familiarise myself with the Git project's code and contribution standards.
Discuss the project plan and milestones with mentors.
Establish the development environment and tools required for the project.

Phase 1: Analysis and Planning (May 27 - June 15)
Examine the current reftable unit tests and the unit testing framework
documentation.
Plan the migration process by identifying the test cases and
capabilities that will be covered.
Break down tasks and establish a precise project timeline.

Phase 2: Transition to C-based Unit Tests (June 16=E2=80=93July 15)
Begin rebuilding the existing shell scripts as C-based unit tests.
Ensure that the migration process is accurate and comprehensive, while
retaining test coverage.
Communicate with mentors on a regular basis to receive feedback and guidanc=
e.

Phase 3: Testing and Validation (July 16=E2=80=93August 5)
Evaluate the migrated unit tests against different scenarios and edge
situations.
Debug and resolve any errors or anomalies that arise during testing.
Before finalising, ensure that the unit tests are proper and reliable.

Phase 4: Documentation and Reporting (August 6=E2=80=93August 26)
Document the migration process, including the obstacles encountered
and solutions implemented.
Update the relevant documentation to reflect the modifications to the
reftable unit tests.
Prepare a detailed report summarising the project's results and contributio=
ns.

Availability

My university holidays begin on June 30. However, considering this is
my final year with only three classes and major project, I believe it
will not be a problem. I intent to work 6 hours a day, 5 days a week
this summer.I have no scheduled trips except for GIM-SRIP from May 6th
to 31st. I will inform Mentors advance notice of any changes in
availability.

After GSoC

I realise that it would be much more beneficial if our GSoC
participants could stay after the event. And that is exactly what I
want to do. I think doing open-source, especially with a community
that fuels a popular development tool, is simply fascinating. And, in
addition to being refreshing, such a community allows me to learn and
grow, with the possibility of making more significant contributions if
I continue to participate.While this is my first foray into
open-source development and GSoC, I am excited by the prospect of
contributing to the ongoing success of Git. I have been actively
learning and gaining a strong foundation in Git commands, programming
languages, and version control concepts.

Closing Remarks

Finally, I'd like to express my gratitude to the community and, in
particular, my mentors, Patrick Steinhardt,Christian Couder,Karthik
Nayak,Junio C Hamano. They did and continue to do an exceptional task
of maintaining and empowering the Git open-source community, as well
as offering much-needed and kind assistance to a new contributor like
me.
---
Regards
Aishwarya Narayanana

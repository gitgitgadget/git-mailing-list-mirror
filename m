Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7621A7044
	for <git@vger.kernel.org>; Mon,  7 Apr 2025 12:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744029434; cv=none; b=SocjalgNw48axCLpNC4S1tyqXzS5XPn0lLRHlYcOqASJhFodMEVPkcBt3pBW94oeyhxyzFu+QwOO2eeOz0J6wH6ZicbNRHEDva7C9af+dobAru9KcoPN7l3ciIW0rJQHpigZJy8BQbhIPcQrNeMDGJW1+H+spt+DgcElouxS44c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744029434; c=relaxed/simple;
	bh=XkYYSAUwyTwDKmN4ok5PUoSvNYGzJQEkvKSWRbtjhLE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=b0ajmbISWbyHPg0VcQVwC19s4u8xRBBTbCnU4tN9r0Tf219RfhG8UZU0upLDPbDEQxVTfPSBvVN+87AE45AfKHGjy8Gbd59B6L7qGufRWqwMsiVC373W7+HeKmBMH2FBTXMQXX7LZ3VVOKX6ofc1/H+FpiPbXcBWYyzhQpInciI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I9OCqqFw; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I9OCqqFw"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3fe83c8cbdbso1513232b6e.3
        for <git@vger.kernel.org>; Mon, 07 Apr 2025 05:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744029431; x=1744634231; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P/uKnfg5nakfqgLDLKYxrBsK3JXkSQG9cVmbM6mflLU=;
        b=I9OCqqFw6JF1YKm+LZ+4XTTrosdANSbs742e8QgCmUA/OvzQgNyl6tDH5XFJI3MKyt
         KDUXhmPUTpqAKIHq9FqWkumUwl+5KLhcZyvFmcvWVRbOaYsFdYSzgLvyp4v9jJL3ENxZ
         e4IGoMBjP81fSgaVf8SwBYvjyc129fMGHM4MzHNtdqzzMCULik3/SJPGDw12pV8SDvNF
         QX6sdiU3E/PHEXTGwMnGXza9Eg2fiYb1pGK3HdfPgZrSriUjafg9ARy0JTFR8NdEsCgx
         v+0C7qK4IlNt26eTTp0iax0nkplsmE+EuY9I0tA3doKpgZY9+0WOysAfc9jL4aTitkLJ
         T1jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744029431; x=1744634231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P/uKnfg5nakfqgLDLKYxrBsK3JXkSQG9cVmbM6mflLU=;
        b=iuQdtMiIpUGrwgn6mmH38kHp9gS9Cn/FCMZfClcZiVt6fjWMhNJ8J2GieEf6YA8oQL
         PGV3AMmHTMHlfsNtGVisoGFQUhoO6A2UjIJsJNz8p0chDe+3h+utrIsKFGVpceAu+iPM
         Ixf6/kG3Znf0Nojd5s6atV34vSS3EA4PM8Pn7bLMln6PHZHtJRLSUBhLhzYVrV0PxY7M
         9lNhqh1OBsgrF0Bf7JzV4fNednjePgzsWqIredTxnUMxL3qag2CcOiRfs459DA8xQKwm
         Jm8hcR8tdKbv4HpUw5C6sKQKIr4bIRKZCh9ydr3EBbQlaDPaDH87u2csoFp3UPEch0od
         AXnA==
X-Gm-Message-State: AOJu0YwPNwKnpZiWjcYIut7KqAdXyA3du4fbcZRwOPtZ77ahYhO6P+Ns
	ZtHujV7tvGYpOdJ5pWGzDY4ZJMLlnJ/u9W/PyVQS/BoF/XPqqbqJqQKRCfoomiQmv7/ihARAVOT
	djMSYopHwT/fBAGodpdRsvmZj/2opvdls
X-Gm-Gg: ASbGnctVzSbAm2C9LQUOxXsM670JHqlszJPCNmGETL9VKAasRjg3GROF9I1tRMTay3v
	aIBBKrmcG7kMQ1NDxRE3ZpqlEr/5g+WxfYucKYTYy4wtEjagAmpPrAPp2MF/ijyRBPWKZL3lErA
	DzYA9m860eqlinYt1xUvtIHm8lwOIrjnJb0BbtdkbjX46MjUQsb4Nr6xSEfuK1sXmVqG4eGZM=
X-Google-Smtp-Source: AGHT+IHKR1WUlvYwKjzM4Oo60IeWvkS6WQ94KLxgLLwqsqHfg9CplGifMSIWrrZD8WZv2jBG1WhU5ujfyeRwCGlH6FU=
X-Received: by 2002:a05:6808:144e:b0:3fe:af39:d069 with SMTP id
 5614622812f47-4004563e4d3mr6160849b6e.37.1744029430923; Mon, 07 Apr 2025
 05:37:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: MOUMITA DHAR <dhar61595@gmail.com>
Date: Mon, 7 Apr 2025 17:59:17 +0530
X-Gm-Features: ATxdqUEUVKzPqdAC2UiL31VeJSTayJzE1FWD9RFIfpom331XavUwI7YXdvp_eGI
Message-ID: <CAF=ncLb0gD_b2GENsaMrXvWg8JvYtkWXyVQjb1CN9JOVgB7E3A@mail.gmail.com>
Subject: [GSOC PROPOSAL 2025] Machine-Readable Repository Information Query Tool
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, karthik nayak <karthik.188@gmail.com>, shejialuo@gmail.com, 
	christian.couder@gmail.com, Ghanshyam Thakkar <shyamthakkar001@gmail.com>, 
	MOUMITA DHAR <dhar61595@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello ,
This is my GSOC proposal
The doc version -
https://docs.google.com/document/d/1f1npZ7Ye-FOZENkfaR4SR2TrgSXnNlI8hvC2T0h=
JA_Y/edit?usp=3Dsharing

# Proposal for GSOC 2025

## Project \- Machine-Readable Repository Information Query Tool

## Personal information

Name \- Moumita Dhar
Email \- [dhar61595@gmail.com](mailto:dhar61595@gmail.com)
Github \- [https://github.com/Mou887](https://github.com/Mou887)
LinkedIn \- [https://www.linkedin.com/in/moumita-dhar-234940253/](https://w=
ww.linkedin.com/in/moumita-dhar-234940253/)

## About me

I=E2=80=99m a self-taught programmer who began my coding journey in 2022\. =
I
got started by taking [CS50: Introduction to Computer
Science](https://cs50.harvard.edu/x/) by Harvard University on edX,
which sparked my curiosity about how software really works. Since
then, I=E2=80=99ve been learning independently, completing several follow-u=
p
CS50 courses like **CS50=E2=80=99s Web Programming**, and **CS50=E2=80=99s
Understanding Technology**, to build a strong foundation in computer
science and software development.

While I hold a university degree, my academic background is **not in
computer science**. However, I have consistently dedicated my time and
energy to learning programming concepts, tools, and real-world
development workflows on my own. I=E2=80=99m passionate about systems
programming, developer tools, and contributing to meaningful
open-source projects.

I=E2=80=99m participating in GSoC under the **Open Source Beginner** catego=
ry.
Even though I=E2=80=99m not currently a student, GSoC represents a unique
opportunity for me to gain valuable mentorship and experience in
large-scale software collaboration, while contributing to a project I
deeply care about.

Outside of coursework and learning, I=E2=80=99ve also explored Git=E2=80=99=
s internals
through personal projects and patches, and I=E2=80=99m excited to take this
further through GSoC.

## Microproject

Status \- Under discussion

Mail thread \- [https://lore.kernel.org/git/20250330134018.9662-2-dhar61595=
@gmail.com/](https://lore.kernel.org/git/20250330134018.9662-2-dhar61595@gm=
ail.com/)

Description \-  I contributed to Git=E2=80=99s `userdiff` system by enhanci=
ng
syntax detection for shell scripts. I focused on improving how Git
highlights and navigates function definitions and words in Bash
scripts during diffs. I have iterated over four patch versions based
on reviewer feedback.

## Project Overview: Decluttering `git rev-parse`

The core purpose of the command was to \-
**Parse revision identifiers** like `HEAD`, `master~2`, `origin/HEAD`, or t=
ags.

**Convert symbolic references** into full 40-character commit hashes.

**Resolve user input** into unambiguous commit IDs for internal use.

Over time, developers began adding utility options to `git rev-parse`
that had **nothing to do with parsing revisions**, such as:

* `--is-bare-repository`

* `--git-dir`

* `--show-toplevel`

* `--is-inside-work-tree`

This project aims to:

1. **Extract non-revision-parsing functionality from `git rev-parse`.**

      2\.    **Create a new structured command** (e.g., `git
repo-info`) dedicated to:

*   Repository paths and environment
*   Status checks
*   Format queries
*  Superproject relationships
* Git environment variables

## Project Timeline

### Community Bonding Period(Before June 2\)

* Finalize the scope and confirm overall design with mentors.

* Settle on command name (e.g., `git-info`, `git-meta`) and structure.

* Review how `git-rev-parse` implements the related options.

* Draft the expected JSON output format for each functionality area.

### Week 1 (June 2=E2=80=938): Repository Path Information

* .Implement logic to report on repository layout and paths:

   `.git` directory, common directory, top-level path, relative and
absolute paths, etc.

    Related options: `--git-dir`, `--git-common-dir`, `--git-path`,
`--show-toplevel`,       `--show-cdup`, `--show-prefix`,
`--absolute-git-dir`

*     Introduce new command skeleton and first subcommand infrastructure.

* Output structured data (e.g., JSON).

* Write an initial test suite and begin documentation.

### Week 2 (June 9=E2=80=9315): Git Environment Context

*  Handle environment reporting:-

      List Git-relevant environment variables (e.g., `GIT_DIR`,
`GIT_WORK_TREE`, etc.)

      Related option: `--local-env-vars`

*  Ensure the output is shell-safe and informative for scripting use.

* Write tests covering multiple shell environments.

* Finalize docs and polish previous week=E2=80=99s code based on mentor fee=
dback.

### **Week 3 (June 16=E2=80=9322): Repository State and Status**

* Implement checks for current repo state:-


               If the repo is a bare repo, shallow clone,  inside
`.git` or working tree.

   Related options: `--is-bare-repository`, `--is-shallow-repository`,
   `--is-inside-git-dir`, `--is-inside-work-tree`

* Add structured output with booleans for each status.

* Test across various repo types (bare, shallow, normal).

* Document usage and update test coverage.

### Week 4 (June 23=E2=80=9329): Object and Ref Format Reporting

* Report the object format and reference storage format used:-

       SHA-1/SHA-256, loose or reftable, etc.

       Related options: `--show-object-format`, `--show-ref-format.`

*  Ensure fallback behavior works for older Git versions or partial
configurations.

*  Add comprehensive tests and documentation for this area.

### Week 5 (June 30=E2=80=93July 6): Review & Midterm Prep

* Integrate feedback on the previous four areas.

* Finalize documentation and tests.

* Clean up patch series.

* Run full test suite and verify output consistency.

* Prepare for **midterm submission**.

### Week 6 (July 7=E2=80=9313): Superproject Awareness

*  Implement logic to determine whether the current repo is inside a
superproject:-


                Show the outer working tree if present.

                Related option: `--show-superproject-working-tree`

*     Handle edge cases where repo is not a submodule.

*     Write test coverage and update documentation accordingly.

### Week 7 (July 14=E2=80=9320): Path Resolution Logic

* Add functionality to resolve Git-related paths:


                Handle symlinks, relative paths, and `.git` indirection.

                 Related option: `--resolve-git-dir`

* Focus on correctness and compatibility.

* Add comprehensive tests (symlinks, embedded repos, relative vs absolute).

* Document clearly.

### Week 8 (July 21=E2=80=9327): Code Review & Integration



* Submit patch series for areas from Weeks 6=E2=80=937.

* Begin integrating all subcommands into a consistent command structure.

* Ensure consistent JSON schema and error handling.

* Begin polish and unification.

### Week 9 (July 28=E2=80=93Aug 3): Unified Output and CLI Polish

* Implement a top-level dispatcher for all functionality areas.

* Add `--format=3Djson` or similar flags for consistent CLI interface.

* Write integration tests across all supported repo states.

* Run  full test suite in clean and dirty trees.

### Week 10 (Aug 4=E2=80=9310): Final Documentation and Usability

*  Write a complete manpage for the new command.

* Add real-world examples and shell usage patterns.

* Run `check-docs`, validate formatting and help output.


### Week 11 (Aug 11=E2=80=9317): Final Mentor Review and Bugfixes

* Submit a full final patch series.

* Incorporate the last round of mentor feedback.

* Clean up commit messages and inline comments.

* Final CI runs and Git project best practices review.

###  Week 12 (Aug 18=E2=80=9324): Submission and Wrap-Up

* Submit final work to Git mailing list (if not already).

* Complete final report, blog post, and GSoC submission.

* Add final tests or polish based on review feedback.

### Final Week

* Reserved for unforeseen delays or last-minute polish.

### Time period from April 9 to  May 6

During this period, I plan to work on a **practice patch** based on my
current understanding of the project. This will help me evaluate how
well I can implement the ideas outlined in my proposal and whether the
timeline I=E2=80=99ve suggested is realistic.

This preparatory work will allow me to:

* Explore the relevant parts of the codebase in more depth

* Validate my implementation approach with a small, isolated prototype

* Build confidence in handling Git=E2=80=99s development workflow
(compilation, testing, patch submission, etc.)

I understand that official coding for GSoC begins in June, and I will
reserve actual patch submissions for that period, in accordance with
GSoC guidelines. The goal of this exercise is solely to prepare myself
to contribute effectively and responsibly from day one.

## Blogging

I will maintain a blog  to document my progress, challenges, and
learnings throughout the program. This will serve both as a personal
reflection and a way to give back to the community by helping future
contributors understand the development process within Git. I will
post regular updates=E2=80=94starting from the community bonding period
through to the final evaluation=E2=80=94covering details like subcommand
implementation, testing strategies, mailing list interactions, and
reviews.
My blog :- [https://hashnode.com/@Moumita](https://hashnode.com/@Moumita)

## Post GSOC

My involvement with Git will not end with the GSoC coding period. I
intend to continue contributing to the Git project even after GSoC
concludes by following up on any remaining feedback related to my
project, further refining and expanding the new command as needed, and
actively participating in the community through patch reviews and
mailing list discussions. I also plan to explore and work on other
issues or features in the Git codebase that align with my interests.
Through GSoC, I hope to establish myself as a long-term contributor to
Git. I see this project not just as a summer commitment, but as the
start of a deeper and ongoing engagement with the Git project and the
broader open source community.

## Availability

I am fully available for GSoC and can dedicate **approximately 8 hours
per day, 7 days a week**, which totals to **about 50=E2=80=9356 hours per
week**. I do not have any academic or job commitments during the GSoC
period and can devote my full attention to the project.

This flexibility allows me to accommodate feedback, mentor
communication, code reviews, and unexpected blockers without falling
behind on the proposed timeline. I'm also willing to adjust my
schedule if needed to better sync with my mentor=E2=80=99s availability or
project needs.

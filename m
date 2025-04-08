Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D9D23E339
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 18:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744137801; cv=none; b=SD2kLuYMAPDqKpV9sRM0M9AR0Gclkrhc8A4VdMtNoalCLuyaKy9LPzS+3qSiJmsy3tMbJoZI40xgeePxhjrWmTfLT5EMtC/TjrowHoxzxNXy7+3+4dLD0ex6K1B0ZkCyYdcSSg7oQ0Yjcf2BNBXmPc/zbKY2B6jEvW0CbSLIXsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744137801; c=relaxed/simple;
	bh=yuRTfSWA5wmZKZfVHiigyf2kCX7soEc4dwZUNrd5K+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dNBvWRi+v0K4IS9jfJw9P9SpSkVH3UA133Q64wEA8C7/A4O3cqFNGeR5/+fxhjK+z9Zkz9nt0yX3TgsF5K3hHeyMlQUyYLZeydogYLdrp8rDM4cio3u1AOrj9y770GL3Ri+Gdtf2rDCfAbiGgIoxXpl7/TFhjxIAYK2Ep9Wr8yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YqUgfNfg; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YqUgfNfg"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2c769da02b0so3680038fac.3
        for <git@vger.kernel.org>; Tue, 08 Apr 2025 11:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744137798; x=1744742598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wa2k6HCKfG0noqaA6+xT90m2DZQqhs/GvD+B/Q0F0YQ=;
        b=YqUgfNfgbLY1jc6F7rRKyjrmVXXGJ/OQG6xcnu1jqJOD5W9mMQIePrPdWuDa9XbPhj
         zh7imqkotg2BUEPAjWgUdHpW1RcC0M8DP42aOMcxgM1Hrt8hEY2Y3gK0sDZ33P/gVRsN
         7e2hmxB8SQaWOByFGY07mH0TmyEAq41kbN5+CT8cpc1MZdYWRdbP292WsIUfTl+Yoxb/
         mA0F6ZaUrNcioWbThWnW0vOC7etSMGfmYaJuCjEJHoEeT1q5ehsqLgsFBRhlo9zVKNhy
         TbXgyJRLKqMspVxZWSFZAclZ7fqVJoBSr6rj8S0rDVN7LJvcNUam/ghUYkmL4kAAQXsO
         fB+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744137798; x=1744742598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wa2k6HCKfG0noqaA6+xT90m2DZQqhs/GvD+B/Q0F0YQ=;
        b=b1K4JqQ1TeN4l5NBM9UjGJWJMLfXdL8ag9JIiI4tn6UbwAJ2alK7uz59VU2vysGLKz
         e4F5wPjeRY9EwIbLOXsCKZoD2TK9qvCN0BF/SWotREiILjNVURcV+1DmrDwJlVshTTKO
         0JO1WheUURCBPCTh6e4iu78yEwbDepOK7RJkZ8hV3xvrcJ/dg+1NFQnaW5lb7APmEJzV
         CWIgfU+06MLiyCdhZhWIJNsmQl3rJd7MJL7oiWStojmOchoBwCMCTeDvaI0ZuNBhX6bq
         QIY/HNVT2KnwA3EASlI71qujTOlN5RrVKRZJUDtP2ZLtQTgotOPPByVVYCJahj0NQzXd
         CLMw==
X-Gm-Message-State: AOJu0Yzik3Gsa7XHgz4rRzybG2KX5dHhv0iL8rAqtULq78Hg3IAvwcg/
	guQLmOyuQULn8cNhq4NUVc9Vadou7jZz7JwLFE9GCfaZR+sO2+s5iFAUprnC4waZFoMTf0J+cNm
	lLjSsuNdN+1eiuBWAdXauJUU7+tPAW7e1
X-Gm-Gg: ASbGnct/V/jBkSBqGRPBtVLs8lUJqGKCIvl68ZG8O6/BWkrun8i4mpMhGlF9ZN98G8S
	YwKebWOi2gWqCxdGLxWQbDQ1zfuBQhGXq9sTO/WxaGZ4Wakje8X3yaKVPf4HoC28zGl4iOYb1TC
	rXxm+JvLu8O/GL6RAq8hUzbhEF3RlN/TwzM/VErApmt4eIpsvVU5qcq/qqaONsLjJQwA+O55M=
X-Google-Smtp-Source: AGHT+IGedA8TJ5FdJFxlsl8vTpLa+4fCE1XRbN5Y2Feh7/VXxQ3F4yUAdFfd4+YczwhI7klTNLVYHPl6+oVjEGxZ4NI=
X-Received: by 2002:a05:6870:bacc:b0:2c2:3e24:9b54 with SMTP id
 586e51a60fabf-2d08dd75c90mr90873fac.11.1744137798264; Tue, 08 Apr 2025
 11:43:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAF=ncLb0gD_b2GENsaMrXvWg8JvYtkWXyVQjb1CN9JOVgB7E3A@mail.gmail.com>
 <CAOLa=ZSMh+c8bnSrG4pkNrgQRGLcSiMQerZz2D28T2jrPN8uCg@mail.gmail.com>
In-Reply-To: <CAOLa=ZSMh+c8bnSrG4pkNrgQRGLcSiMQerZz2D28T2jrPN8uCg@mail.gmail.com>
From: MOUMITA DHAR <dhar61595@gmail.com>
Date: Wed, 9 Apr 2025 00:05:19 +0530
X-Gm-Features: ATxdqUGdylB0o3hnJXR-1QDqT5Vu_sVu1GgUU68ObSE2St2jqJVubsnQ3rrsiHk
Message-ID: <CAF=ncLaCKv4uQYQUZH7Z1yq+AeVz68PRjoe700DHT0kQmMTD9Q@mail.gmail.com>
Subject: Re: [GSOC PROPOSAL 2025] Machine-Readable Repository Information
 Query Tool
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, shejialuo@gmail.com, 
	christian.couder@gmail.com, Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 8 Apr 2025 at 19:28, Karthik Nayak <karthik.188@gmail.com> wrote:
>
> MOUMITA DHAR <dhar61595@gmail.com> writes:
>
> Hello Moumita,
>
> > Hello ,
> > This is my GSOC proposal
> > The doc version -
> > https://docs.google.com/document/d/1f1npZ7Ye-FOZENkfaR4SR2TrgSXnNlI8hvC=
2T0hJA_Y/edit?usp=3Dsharing
> >
> > # Proposal for GSOC 2025
> >
> > ## Project \- Machine-Readable Repository Information Query Tool
> >
> > ## Personal information
> >
> > Name \- Moumita Dhar
> > Email \- [dhar61595@gmail.com](mailto:dhar61595@gmail.com)
> > Github \- [https://github.com/Mou887](https://github.com/Mou887)
> > LinkedIn \- [https://www.linkedin.com/in/moumita-dhar-234940253/](https=
://www.linkedin.com/in/moumita-dhar-234940253/)
> >
> > ## About me
> >
> > I=E2=80=99m a self-taught programmer who began my coding journey in 202=
2\. I
> > got started by taking [CS50: Introduction to Computer
> > Science](https://cs50.harvard.edu/x/) by Harvard University on edX,
> > which sparked my curiosity about how software really works. Since
> > then, I=E2=80=99ve been learning independently, completing several foll=
ow-up
> > CS50 courses like **CS50=E2=80=99s Web Programming**, and **CS50=E2=80=
=99s
> > Understanding Technology**, to build a strong foundation in computer
> > science and software development.
> >
> > While I hold a university degree, my academic background is **not in
> > computer science**. However, I have consistently dedicated my time and
> > energy to learning programming concepts, tools, and real-world
> > development workflows on my own. I=E2=80=99m passionate about systems
> > programming, developer tools, and contributing to meaningful
> > open-source projects.
> >
>
> The rules [1] don't mention anything about requiring a *computer
> science*, so all participants are welcome!
>
Thank you! As someone coming from a non-traditional CS background,
that=E2=80=99s really reassuring. I=E2=80=99m looking forward to contributi=
ng and
learning as much as I can during the program!

> > I=E2=80=99m participating in GSoC under the **Open Source Beginner** ca=
tegory.
> > Even though I=E2=80=99m not currently a student, GSoC represents a uniq=
ue
> > opportunity for me to gain valuable mentorship and experience in
> > large-scale software collaboration, while contributing to a project I
> > deeply care about.
> >
> > Outside of coursework and learning, I=E2=80=99ve also explored Git=E2=
=80=99s internals
> > through personal projects and patches, and I=E2=80=99m excited to take =
this
> > further through GSoC.
> >
> > ## Microproject
> >
> > Status \- Under discussion
> >
> > Mail thread \- [https://lore.kernel.org/git/20250330134018.9662-2-dhar6=
1595@gmail.com/](https://lore.kernel.org/git/20250330134018.9662-2-dhar6159=
5@gmail.com/)
> >
> > Description \-  I contributed to Git=E2=80=99s `userdiff` system by enh=
ancing
> > syntax detection for shell scripts. I focused on improving how Git
> > highlights and navigates function definitions and words in Bash
> > scripts during diffs. I have iterated over four patch versions based
> > on reviewer feedback.
> >
> > ## Project Overview: Decluttering `git rev-parse`
> >
> > The core purpose of the command was to \-
> > **Parse revision identifiers** like `HEAD`, `master~2`, `origin/HEAD`, =
or tags.
> >
> > **Convert symbolic references** into full 40-character commit hashes.
> >
> > **Resolve user input** into unambiguous commit IDs for internal use.
> >
> > Over time, developers began adding utility options to `git rev-parse`
> > that had **nothing to do with parsing revisions**, such as:
> >
> > * `--is-bare-repository`
> >
> > * `--git-dir`
> >
> > * `--show-toplevel`
> >
> > * `--is-inside-work-tree`
> >
> > This project aims to:
> >
> > 1. **Extract non-revision-parsing functionality from `git rev-parse`.**
> >
> >       2\.    **Create a new structured command** (e.g., `git
> > repo-info`) dedicated to:
> >
> > *   Repository paths and environment
> > *   Status checks
> > *   Format queries
> > *  Superproject relationships
> > * Git environment variables
> >
>
> Makes sense, like I mentioned on another proposal [2], it would be nice
> to mention that everything under 'Options for Files' section of the 'git
> rev-parse' manpage probably needs a new home.

> Yes , I understand I will do that.


> I also think you should elaborate on how the new command would look
> like, will we simply copy over the options? Will there be better
> consistent naming? What would the default output for 'git repo-info' be?
> Also how do you justify the name? Is it consistent with the command
> names in Git? Is it self-explanatory?

> Yes  I will elaborate on those details in my proposal .I'm currently prop=
osing git repo-info, The name repo-info is self-explanatory and clearly ind=
icates that the command is focused on querying structured metadata and conf=
iguration details of a Git repository.I suppose the default output should b=
e plain strings NUL terminated like other plumbing commands .

> It would also be nice to write a brief about how you plan to tackle
> this, not from a timeline perspective but from a technical perspective.

>Sure , I will a technical details section in my proposal

> > ## Project Timeline
> >
> > ### Community Bonding Period(Before June 2\)
> >
> > * Finalize the scope and confirm overall design with mentors.
> >
> > * Settle on command name (e.g., `git-info`, `git-meta`) and structure.
> >
>
> I would suggest involving the mailing list as soon as possible, as you'd
> get some good feedback around the early design.
>
Thank you =E2=80=94 that=E2=80=99s a great point. I absolutely plan to invo=
lve the
mailing list early in the process. During the Community Bonding
Period, I=E2=80=99ll draft an initial design proposal outlining the command
name, subcommand structure, and output format conventions (especially
for JSON output), and share it on the mailing list for feedback.

> > * Review how `git-rev-parse` implements the related options.
> >
> > * Draft the expected JSON output format for each functionality area.
> >
> > ### Week 1 (June 2=E2=80=938): Repository Path Information
> >
> > * .Implement logic to report on repository layout and paths:
> >
> >    `.git` directory, common directory, top-level path, relative and
> > absolute paths, etc.
> >
> >     Related options: `--git-dir`, `--git-common-dir`, `--git-path`,
> > `--show-toplevel`,       `--show-cdup`, `--show-prefix`,
> > `--absolute-git-dir`
> >
>
> Nice, I like that the project is broken down into smaller modules.
>
> > *     Introduce new command skeleton and first subcommand infrastructur=
e.
> >
> > * Output structured data (e.g., JSON).
>
> How do you plan to tackle this? Have you taken a look at json-writer.[c,h=
]?
>
Yes, I=E2=80=99ve taken a look at json-writer.[c,h] and plan to use Git=E2=
=80=99s
built-in struct json_writer API to produce structured JSON output.
This utility provides a convenient and standardized way to emit JSON
data across various commands in Git (e.g., git ls-remote --format=3Djson
and git for-each-ref --format=3Djson use this approach).
> >
> > * Write an initial test suite and begin documentation.
> >
> > ### Week 2 (June 9=E2=80=9315): Git Environment Context
> >
> > *  Handle environment reporting:-
> >
> >       List Git-relevant environment variables (e.g., `GIT_DIR`,
> > `GIT_WORK_TREE`, etc.)
> >
> >       Related option: `--local-env-vars`
> >
> > *  Ensure the output is shell-safe and informative for scripting use.
> >
> > * Write tests covering multiple shell environments.
> >
> > * Finalize docs and polish previous week=E2=80=99s code based on mentor=
 feedback.
> >
>
> I think this is a good point. Generally things take long, since we need
> to sync with the mailing list and ensure it is upto a good standard.
> Then the topic will slowly move from seen -> next -> master.
>
> > ### **Week 3 (June 16=E2=80=9322): Repository State and Status**
> >
> > * Implement checks for current repo state:-
> >
> >
> >                If the repo is a bare repo, shallow clone,  inside
> > `.git` or working tree.
> >
> >    Related options: `--is-bare-repository`, `--is-shallow-repository`,
> >    `--is-inside-git-dir`, `--is-inside-work-tree`
> >
> > * Add structured output with booleans for each status.
> >
> > * Test across various repo types (bare, shallow, normal).
> >
> > * Document usage and update test coverage.
> >
> > ### Week 4 (June 23=E2=80=9329): Object and Ref Format Reporting
> >
> > * Report the object format and reference storage format used:-
> >
> >        SHA-1/SHA-256, loose or reftable, etc.
> >
> >        Related options: `--show-object-format`, `--show-ref-format.`
> >
> > *  Ensure fallback behavior works for older Git versions or partial
> > configurations.
> >
> > *  Add comprehensive tests and documentation for this area.
> >
> > ### Week 5 (June 30=E2=80=93July 6): Review & Midterm Prep
> >
> > * Integrate feedback on the previous four areas.
> >
> > * Finalize documentation and tests.
> >
> > * Clean up patch series.
> >
> > * Run full test suite and verify output consistency.
> >
> > * Prepare for **midterm submission**.
> >
> > ### Week 6 (July 7=E2=80=9313): Superproject Awareness
> >
> > *  Implement logic to determine whether the current repo is inside a
> > superproject:-
> >
> >
> >                 Show the outer working tree if present.
> >
> >                 Related option: `--show-superproject-working-tree`
> >
> > *     Handle edge cases where repo is not a submodule.
> >
> > *     Write test coverage and update documentation accordingly.
> >
> > ### Week 7 (July 14=E2=80=9320): Path Resolution Logic
> >
> > * Add functionality to resolve Git-related paths:
> >
> >
> >                 Handle symlinks, relative paths, and `.git` indirection=
.
> >
> >                  Related option: `--resolve-git-dir`
> >
> > * Focus on correctness and compatibility.
> >
> > * Add comprehensive tests (symlinks, embedded repos, relative vs absolu=
te).
> >
> > * Document clearly.
> >
> > ### Week 8 (July 21=E2=80=9327): Code Review & Integration
> >
> >
> >
> > * Submit patch series for areas from Weeks 6=E2=80=937.
> >
> > * Begin integrating all subcommands into a consistent command structure=
.
> >
>
> Could you expand on what you mean here?
>
As more subcommands are developed, I will begin consolidating shared
functionality=E2=80=94such as repository initialization, option parsing, an=
d
JSON output helpers=E2=80=94into a unified structure. This will ensure that
repo-info behaves like a well-integrated built-in command, with a
consistent CLI interface, code style, and behavior across all its
subcommands.
> > * Ensure consistent JSON schema and error handling.
> >
>
> And here.
To support machine-readable output, I will define a consistent JSON
schema for each subcommand=E2=80=99s output early in the project. As I
implement new features, I=E2=80=99ll ensure they adhere to this schema. Err=
ors
will also be reported in a structured way when JSON mode is enabled,
using a format like {"error": "descriptive message"}. I will also use
Git=E2=80=99s standard mechanisms (die(), error(), return codes) for handli=
ng
and reporting errors in non-JSON mode.By JSON mode I mean the default
output will in plain text and the JSON output wll be with the flag
like --format-json.
>
> > * Begin polish and unification.
> >
> > ### Week 9 (July 28=E2=80=93Aug 3): Unified Output and CLI Polish
> >
> > * Implement a top-level dispatcher for all functionality areas.
> >
>
> This too, what is a dispatcher in context to our codebase?

> I  meant I=E2=80=99ll implement a subcommand dispatcher similar to how ot=
her built-ins do (like builtin/remote.c, which has subcommand dispatching l=
ogic). This helps organize the code cleanly and allows users to call git re=
po-info path, git repo-info env, etc.

> > * Add `--format=3Djson` or similar flags for consistent CLI interface.
> >
> > * Write integration tests across all supported repo states.
> >
>
> Aren't tests covered as part of each batch of work? What extra do these
> tests add, why aren't they part of the initial tests?
>
You're right =E2=80=94 unit and functional tests should be written during e=
ach
feature=E2=80=99s development (as part of the patch series). What I meant h=
ere
was that Week 9 will focus on cross-subcommand integration tests =E2=80=94 =
to
ensure they all work together consistently in various repository
states
> > * Run  full test suite in clean and dirty trees.
> >
>
> This should be part of each batch no?
Yes , This should me a part of each patch series, I will not include
this as a separate point in the proposal
>
> > ### Week 10 (Aug 4=E2=80=9310): Final Documentation and Usability
> >
> > *  Write a complete manpage for the new command.
> >
>
> I would say each patch should hold corresponding documentation, it is
> not something we want to work on at the end. We don't want a project
> left midway without _any_ documentation. it'd be better if there is
> sufficient documentation added for each new block of changes, that way
> the state of the project is not lacking at any point. So code, tests,
> documentation should all be part of each block of work you do.
>
Yes I understand it will be a part of each patch series , I will
mentiion clearly about this in the proposal.
> > * Add real-world examples and shell usage patterns.
> >
> > * Run `check-docs`, validate formatting and help output.
> >
> >
> > ### Week 11 (Aug 11=E2=80=9317): Final Mentor Review and Bugfixes
> >
> > * Submit a full final patch series.
> >
> > * Incorporate the last round of mentor feedback.
> >
>
> I think this too, is part of each step of the process.
 Yes , I have included many unnecessary points in the proposal I will
rectify this.
>
> > * Clean up commit messages and inline comments.
> >
> > * Final CI runs and Git project best practices review.
> >
> > ###  Week 12 (Aug 18=E2=80=9324): Submission and Wrap-Up
> >
> > * Submit final work to Git mailing list (if not already).
> >
> > * Complete final report, blog post, and GSoC submission.
> >
> > * Add final tests or polish based on review feedback.
> >
> > ### Final Week
> >
> > * Reserved for unforeseen delays or last-minute polish.
> >
>
> Overall, it seems like we're building up to the end for a big patch
> series in the end. The recommended route would be to split the work into
> small chunks and get each chunk through one at a time. Each chunk would
> contain necessary code, tests, documentation and should be in a state
> where it can be merged to the maintree.

>Yes , I understand and I will mention this clearly in the proposal.

> > ### Time period from April 9 to  May 6
> >
> > During this period, I plan to work on a **practice patch** based on my
> > current understanding of the project. This will help me evaluate how
> > well I can implement the ideas outlined in my proposal and whether the
> > timeline I=E2=80=99ve suggested is realistic.
> >
> > This preparatory work will allow me to:
> >
> > * Explore the relevant parts of the codebase in more depth
> >
> > * Validate my implementation approach with a small, isolated prototype
> >
> > * Build confidence in handling Git=E2=80=99s development workflow
> > (compilation, testing, patch submission, etc.)
> >
> > I understand that official coding for GSoC begins in June, and I will
> > reserve actual patch submissions for that period, in accordance with
> > GSoC guidelines. The goal of this exercise is solely to prepare myself
> > to contribute effectively and responsibly from day one.
> >
> > ## Blogging
> >
> > I will maintain a blog  to document my progress, challenges, and
> > learnings throughout the program. This will serve both as a personal
> > reflection and a way to give back to the community by helping future
> > contributors understand the development process within Git. I will
> > post regular updates=E2=80=94starting from the community bonding period
> > through to the final evaluation=E2=80=94covering details like subcomman=
d
> > implementation, testing strategies, mailing list interactions, and
> > reviews.
> > My blog :- [https://hashnode.com/@Moumita](https://hashnode.com/@Moumit=
a)
> >
> > ## Post GSOC
> >
> > My involvement with Git will not end with the GSoC coding period. I
> > intend to continue contributing to the Git project even after GSoC
> > concludes by following up on any remaining feedback related to my
> > project, further refining and expanding the new command as needed, and
> > actively participating in the community through patch reviews and
> > mailing list discussions. I also plan to explore and work on other
> > issues or features in the Git codebase that align with my interests.
> > Through GSoC, I hope to establish myself as a long-term contributor to
> > Git. I see this project not just as a summer commitment, but as the
> > start of a deeper and ongoing engagement with the Git project and the
> > broader open source community.
> >
> > ## Availability
> >
> > I am fully available for GSoC and can dedicate **approximately 8 hours
> > per day, 7 days a week**, which totals to **about 50=E2=80=9356 hours p=
er
> > week**. I do not have any academic or job commitments during the GSoC
> > period and can devote my full attention to the project.
> >
> > This flexibility allows me to accommodate feedback, mentor
> > communication, code reviews, and unexpected blockers without falling
> > behind on the proposed timeline. I'm also willing to adjust my
> > schedule if needed to better sync with my mentor=E2=80=99s availability=
 or
> > project needs.
>
> Thanks for the proposal!
>
> - Karthik
> Thank you for the feedback! I will make sure I clarify the things that I =
wrote vaguely in this proposal
>
> [1]: https://summerofcode.withgoogle.com/rules
> [2]: https://lore.kernel.org/git/CAOLa=3DZQSnwSPw1U_-2YZzjK5z_jUEB3vGy=3D=
So5e+gpOa87Ei=3Dw@mail.gmail.com/T/#mc4c5c87594cd2e0ea795259a6868b3494781cf=
86

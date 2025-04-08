Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C6D3BBF2
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 13:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744120694; cv=none; b=gKr3NjzQZ5WI7KL7mXJqqTJnF8Sxgn6kGefWJ7qmEwEUDFserLXASLwZ43r5RzFRwnVz3pAegQwVJtTMV6y94dFC+pD5S/K4SSdW1h/fBxJ5D7ntIleEKlTnSav7soXvgVbg3vrbpQsMd4Zs9sX5lrfxHmsnz/oma3GHb2utNDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744120694; c=relaxed/simple;
	bh=9AKij+yumogTZTaZS4hmqMkGvcnnsXWFlcsfnSO99H0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aD1KiStyGek1d1LzSZbp2kvxUDorWyBUWRRQ7IpIoiVXSY87htNr7LGPErFFeth4yOmHt9uES+NAIRfDT8VrJDHogc9H2y2RuVPSyJUpW3wMyh9iNpmbFMbv5My3RP6lhKpBb7JBSUwbEADjlb57lvyUO9XMRxqqM5mz1YDDZDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yrs3ZVEp; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yrs3ZVEp"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5259327a937so2347112e0c.0
        for <git@vger.kernel.org>; Tue, 08 Apr 2025 06:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744120691; x=1744725491; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wz3tb7rqdWH6mzXPrG67+Ci1JWMzX14eewBkb2DNWrk=;
        b=Yrs3ZVEpHpVylE01wdepY1P/3E90l3ZnK7D330+eI9efh0ER1bTwlJRLfRZeIgiIG5
         YG2l+G4zD6oWObBuCc+AudI3CKpWpBbwWr8ypYdb8mmy1/Am+EMxeBcC3tDr9zPd3Efq
         XlFZK96hcJxp6mD8Q/4DLINcdBZRf2vMb+Yf3dUWwTJaF0EwL11Whr2HE1CIJfG9LkcL
         oYSyM4pFbeeK5YjOW/nEbquZuZuVC88GJyUPM/eMQhkzjyoc0W9uoyYzRGXMVu3EK98P
         4lJIJF/WzsKRE7XFp/YhauAHyoh2WSXAIqwSgLaxfu9RDFrrml6iXYWMPuXV8Xwwi6pW
         Cthg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744120691; x=1744725491;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wz3tb7rqdWH6mzXPrG67+Ci1JWMzX14eewBkb2DNWrk=;
        b=eAx5EVCGQaTnWjDKzJu9+SPpuS6HD70Htpz3S7N4PRPijJZ3Sorj5lq7EAIznrlYoP
         QSM8OdPe2IYew8LB3HRbeI6bWpFK1gqeCL9lvc0xHn9TZQaI/akQwppZJJnUbyCz3GET
         WMEIS0f4IlurG0ZWasGHp4XnCtyd5KVsYdI/e6GUOAbxu+WyesWsW1GeOuYfCDMlv3AQ
         Rd+6sDXMm61iFFyF8FH8XCKdfxy8zqkhL6ByEZnTQQ7MQa0rr3eaLCkI5SpqHwx5vdp6
         2HwGWa3R0KbyeANQ6RylgHGaS8k47T4jwqljNsQSSaGkCpWXsPJTj4ubRiGjCVlK3Z7Y
         JM5A==
X-Forwarded-Encrypted: i=1; AJvYcCXFvhN5iL3qWjJfC3h5MILsVnt7rZZeyWKM+c1uExjtjUXlqLlfXCvms5wmPlmK0HwGvBc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjj6drFRxTk93c+ryLRuD+zIly4vjC5lJi52dGELis3HiWkDbv
	er+2rNcXM4nGdCAczO6ImOAQpzmhAhNjffpkK/QHu5AO34syyafQgmOf+tBuq97IZTAwF2xrkxS
	2RPvTw/lk+sX6USBdQXweoQjOepQ=
X-Gm-Gg: ASbGncuKTCS6eAaJpRIm0z/sBjwoBwHB/zceSl+xyBVFqgzvuexV8uPVGMgefAthaso
	8NoAP6+Ptd4JH4O/C5VG7oSGaVh+sZIERa9U2OQusniwzC8t41Er/9G8oKlHfP9UMHBUHcpebaD
	38/m7VPNRw3ja3/Y45UBhfPEoS
X-Google-Smtp-Source: AGHT+IE+e+OJR7CgLZOJhYYyMiDZfxXNLhZnxpBRyUa6TfR/jNTwfyEYRigUJoWd+8iLpKy4Jd93XMgp8H0+YgbpwFk=
X-Received: by 2002:a05:6102:3f0d:b0:4b6:d108:cac1 with SMTP id
 ada2fe7eead31-4c8636608d8mr9494254137.9.1744120690516; Tue, 08 Apr 2025
 06:58:10 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 8 Apr 2025 13:58:09 +0000
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 8 Apr 2025 13:58:09 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <CAF=ncLb0gD_b2GENsaMrXvWg8JvYtkWXyVQjb1CN9JOVgB7E3A@mail.gmail.com>
References: <CAF=ncLb0gD_b2GENsaMrXvWg8JvYtkWXyVQjb1CN9JOVgB7E3A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 8 Apr 2025 13:58:09 +0000
X-Gm-Features: ATxdqUHu2mI12vRDBfQmoU9d_SYAZDFihPzIehdl4fSEps_KeA0wTVZIaP_Ko_A
Message-ID: <CAOLa=ZSMh+c8bnSrG4pkNrgQRGLcSiMQerZz2D28T2jrPN8uCg@mail.gmail.com>
Subject: Re: [GSOC PROPOSAL 2025] Machine-Readable Repository Information
 Query Tool
To: MOUMITA DHAR <dhar61595@gmail.com>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, shejialuo@gmail.com, christian.couder@gmail.com, 
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000003443c0063244beeb"

--0000000000003443c0063244beeb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

MOUMITA DHAR <dhar61595@gmail.com> writes:

Hello Moumita,

> Hello ,
> This is my GSOC proposal
> The doc version -
> https://docs.google.com/document/d/1f1npZ7Ye-FOZENkfaR4SR2TrgSXnNlI8hvC2T=
0hJA_Y/edit?usp=3Dsharing
>
> # Proposal for GSOC 2025
>
> ## Project \- Machine-Readable Repository Information Query Tool
>
> ## Personal information
>
> Name \- Moumita Dhar
> Email \- [dhar61595@gmail.com](mailto:dhar61595@gmail.com)
> Github \- [https://github.com/Mou887](https://github.com/Mou887)
> LinkedIn \- [https://www.linkedin.com/in/moumita-dhar-234940253/](https:/=
/www.linkedin.com/in/moumita-dhar-234940253/)
>
> ## About me
>
> I=E2=80=99m a self-taught programmer who began my coding journey in 2022\=
. I
> got started by taking [CS50: Introduction to Computer
> Science](https://cs50.harvard.edu/x/) by Harvard University on edX,
> which sparked my curiosity about how software really works. Since
> then, I=E2=80=99ve been learning independently, completing several follow=
-up
> CS50 courses like **CS50=E2=80=99s Web Programming**, and **CS50=E2=80=99=
s
> Understanding Technology**, to build a strong foundation in computer
> science and software development.
>
> While I hold a university degree, my academic background is **not in
> computer science**. However, I have consistently dedicated my time and
> energy to learning programming concepts, tools, and real-world
> development workflows on my own. I=E2=80=99m passionate about systems
> programming, developer tools, and contributing to meaningful
> open-source projects.
>

The rules [1] don't mention anything about requiring a *computer
science*, so all participants are welcome!

> I=E2=80=99m participating in GSoC under the **Open Source Beginner** cate=
gory.
> Even though I=E2=80=99m not currently a student, GSoC represents a unique
> opportunity for me to gain valuable mentorship and experience in
> large-scale software collaboration, while contributing to a project I
> deeply care about.
>
> Outside of coursework and learning, I=E2=80=99ve also explored Git=E2=80=
=99s internals
> through personal projects and patches, and I=E2=80=99m excited to take th=
is
> further through GSoC.
>
> ## Microproject
>
> Status \- Under discussion
>
> Mail thread \- [https://lore.kernel.org/git/20250330134018.9662-2-dhar615=
95@gmail.com/](https://lore.kernel.org/git/20250330134018.9662-2-dhar61595@=
gmail.com/)
>
> Description \-  I contributed to Git=E2=80=99s `userdiff` system by enhan=
cing
> syntax detection for shell scripts. I focused on improving how Git
> highlights and navigates function definitions and words in Bash
> scripts during diffs. I have iterated over four patch versions based
> on reviewer feedback.
>
> ## Project Overview: Decluttering `git rev-parse`
>
> The core purpose of the command was to \-
> **Parse revision identifiers** like `HEAD`, `master~2`, `origin/HEAD`, or=
 tags.
>
> **Convert symbolic references** into full 40-character commit hashes.
>
> **Resolve user input** into unambiguous commit IDs for internal use.
>
> Over time, developers began adding utility options to `git rev-parse`
> that had **nothing to do with parsing revisions**, such as:
>
> * `--is-bare-repository`
>
> * `--git-dir`
>
> * `--show-toplevel`
>
> * `--is-inside-work-tree`
>
> This project aims to:
>
> 1. **Extract non-revision-parsing functionality from `git rev-parse`.**
>
>       2\.    **Create a new structured command** (e.g., `git
> repo-info`) dedicated to:
>
> *   Repository paths and environment
> *   Status checks
> *   Format queries
> *  Superproject relationships
> * Git environment variables
>

Makes sense, like I mentioned on another proposal [2], it would be nice
to mention that everything under 'Options for Files' section of the 'git
rev-parse' manpage probably needs a new home.

I also think you should elaborate on how the new command would look
like, will we simply copy over the options? Will there be better
consistent naming? What would the default output for 'git repo-info' be?
Also how do you justify the name? Is it consistent with the command
names in Git? Is it self-explanatory?

It would also be nice to write a brief about how you plan to tackle
this, not from a timeline perspective but from a technical perspective.

> ## Project Timeline
>
> ### Community Bonding Period(Before June 2\)
>
> * Finalize the scope and confirm overall design with mentors.
>
> * Settle on command name (e.g., `git-info`, `git-meta`) and structure.
>

I would suggest involving the mailing list as soon as possible, as you'd
get some good feedback around the early design.

> * Review how `git-rev-parse` implements the related options.
>
> * Draft the expected JSON output format for each functionality area.
>
> ### Week 1 (June 2=E2=80=938): Repository Path Information
>
> * .Implement logic to report on repository layout and paths:
>
>    `.git` directory, common directory, top-level path, relative and
> absolute paths, etc.
>
>     Related options: `--git-dir`, `--git-common-dir`, `--git-path`,
> `--show-toplevel`,       `--show-cdup`, `--show-prefix`,
> `--absolute-git-dir`
>

Nice, I like that the project is broken down into smaller modules.

> *     Introduce new command skeleton and first subcommand infrastructure.
>
> * Output structured data (e.g., JSON).

How do you plan to tackle this? Have you taken a look at json-writer.[c,h]?

>
> * Write an initial test suite and begin documentation.
>
> ### Week 2 (June 9=E2=80=9315): Git Environment Context
>
> *  Handle environment reporting:-
>
>       List Git-relevant environment variables (e.g., `GIT_DIR`,
> `GIT_WORK_TREE`, etc.)
>
>       Related option: `--local-env-vars`
>
> *  Ensure the output is shell-safe and informative for scripting use.
>
> * Write tests covering multiple shell environments.
>
> * Finalize docs and polish previous week=E2=80=99s code based on mentor f=
eedback.
>

I think this is a good point. Generally things take long, since we need
to sync with the mailing list and ensure it is upto a good standard.
Then the topic will slowly move from seen -> next -> master.

> ### **Week 3 (June 16=E2=80=9322): Repository State and Status**
>
> * Implement checks for current repo state:-
>
>
>                If the repo is a bare repo, shallow clone,  inside
> `.git` or working tree.
>
>    Related options: `--is-bare-repository`, `--is-shallow-repository`,
>    `--is-inside-git-dir`, `--is-inside-work-tree`
>
> * Add structured output with booleans for each status.
>
> * Test across various repo types (bare, shallow, normal).
>
> * Document usage and update test coverage.
>
> ### Week 4 (June 23=E2=80=9329): Object and Ref Format Reporting
>
> * Report the object format and reference storage format used:-
>
>        SHA-1/SHA-256, loose or reftable, etc.
>
>        Related options: `--show-object-format`, `--show-ref-format.`
>
> *  Ensure fallback behavior works for older Git versions or partial
> configurations.
>
> *  Add comprehensive tests and documentation for this area.
>
> ### Week 5 (June 30=E2=80=93July 6): Review & Midterm Prep
>
> * Integrate feedback on the previous four areas.
>
> * Finalize documentation and tests.
>
> * Clean up patch series.
>
> * Run full test suite and verify output consistency.
>
> * Prepare for **midterm submission**.
>
> ### Week 6 (July 7=E2=80=9313): Superproject Awareness
>
> *  Implement logic to determine whether the current repo is inside a
> superproject:-
>
>
>                 Show the outer working tree if present.
>
>                 Related option: `--show-superproject-working-tree`
>
> *     Handle edge cases where repo is not a submodule.
>
> *     Write test coverage and update documentation accordingly.
>
> ### Week 7 (July 14=E2=80=9320): Path Resolution Logic
>
> * Add functionality to resolve Git-related paths:
>
>
>                 Handle symlinks, relative paths, and `.git` indirection.
>
>                  Related option: `--resolve-git-dir`
>
> * Focus on correctness and compatibility.
>
> * Add comprehensive tests (symlinks, embedded repos, relative vs absolute=
).
>
> * Document clearly.
>
> ### Week 8 (July 21=E2=80=9327): Code Review & Integration
>
>
>
> * Submit patch series for areas from Weeks 6=E2=80=937.
>
> * Begin integrating all subcommands into a consistent command structure.
>

Could you expand on what you mean here?

> * Ensure consistent JSON schema and error handling.
>

And here.

> * Begin polish and unification.
>
> ### Week 9 (July 28=E2=80=93Aug 3): Unified Output and CLI Polish
>
> * Implement a top-level dispatcher for all functionality areas.
>

This too, what is a dispatcher in context to our codebase?

> * Add `--format=3Djson` or similar flags for consistent CLI interface.
>
> * Write integration tests across all supported repo states.
>

Aren't tests covered as part of each batch of work? What extra do these
tests add, why aren't they part of the initial tests?

> * Run  full test suite in clean and dirty trees.
>

This should be part of each batch no?

> ### Week 10 (Aug 4=E2=80=9310): Final Documentation and Usability
>
> *  Write a complete manpage for the new command.
>

I would say each patch should hold corresponding documentation, it is
not something we want to work on at the end. We don't want a project
left midway without _any_ documentation. it'd be better if there is
sufficient documentation added for each new block of changes, that way
the state of the project is not lacking at any point. So code, tests,
documentation should all be part of each block of work you do.

> * Add real-world examples and shell usage patterns.
>
> * Run `check-docs`, validate formatting and help output.
>
>
> ### Week 11 (Aug 11=E2=80=9317): Final Mentor Review and Bugfixes
>
> * Submit a full final patch series.
>
> * Incorporate the last round of mentor feedback.
>

I think this too, is part of each step of the process.

> * Clean up commit messages and inline comments.
>
> * Final CI runs and Git project best practices review.
>
> ###  Week 12 (Aug 18=E2=80=9324): Submission and Wrap-Up
>
> * Submit final work to Git mailing list (if not already).
>
> * Complete final report, blog post, and GSoC submission.
>
> * Add final tests or polish based on review feedback.
>
> ### Final Week
>
> * Reserved for unforeseen delays or last-minute polish.
>

Overall, it seems like we're building up to the end for a big patch
series in the end. The recommended route would be to split the work into
small chunks and get each chunk through one at a time. Each chunk would
contain necessary code, tests, documentation and should be in a state
where it can be merged to the maintree.

> ### Time period from April 9 to  May 6
>
> During this period, I plan to work on a **practice patch** based on my
> current understanding of the project. This will help me evaluate how
> well I can implement the ideas outlined in my proposal and whether the
> timeline I=E2=80=99ve suggested is realistic.
>
> This preparatory work will allow me to:
>
> * Explore the relevant parts of the codebase in more depth
>
> * Validate my implementation approach with a small, isolated prototype
>
> * Build confidence in handling Git=E2=80=99s development workflow
> (compilation, testing, patch submission, etc.)
>
> I understand that official coding for GSoC begins in June, and I will
> reserve actual patch submissions for that period, in accordance with
> GSoC guidelines. The goal of this exercise is solely to prepare myself
> to contribute effectively and responsibly from day one.
>
> ## Blogging
>
> I will maintain a blog  to document my progress, challenges, and
> learnings throughout the program. This will serve both as a personal
> reflection and a way to give back to the community by helping future
> contributors understand the development process within Git. I will
> post regular updates=E2=80=94starting from the community bonding period
> through to the final evaluation=E2=80=94covering details like subcommand
> implementation, testing strategies, mailing list interactions, and
> reviews.
> My blog :- [https://hashnode.com/@Moumita](https://hashnode.com/@Moumita)
>
> ## Post GSOC
>
> My involvement with Git will not end with the GSoC coding period. I
> intend to continue contributing to the Git project even after GSoC
> concludes by following up on any remaining feedback related to my
> project, further refining and expanding the new command as needed, and
> actively participating in the community through patch reviews and
> mailing list discussions. I also plan to explore and work on other
> issues or features in the Git codebase that align with my interests.
> Through GSoC, I hope to establish myself as a long-term contributor to
> Git. I see this project not just as a summer commitment, but as the
> start of a deeper and ongoing engagement with the Git project and the
> broader open source community.
>
> ## Availability
>
> I am fully available for GSoC and can dedicate **approximately 8 hours
> per day, 7 days a week**, which totals to **about 50=E2=80=9356 hours per
> week**. I do not have any academic or job commitments during the GSoC
> period and can devote my full attention to the project.
>
> This flexibility allows me to accommodate feedback, mentor
> communication, code reviews, and unexpected blockers without falling
> behind on the proposed timeline. I'm also willing to adjust my
> schedule if needed to better sync with my mentor=E2=80=99s availability o=
r
> project needs.

Thanks for the proposal!

- Karthik


[1]: https://summerofcode.withgoogle.com/rules
[2]: https://lore.kernel.org/git/CAOLa=3DZQSnwSPw1U_-2YZzjK5z_jUEB3vGy=3DSo=
5e+gpOa87Ei=3Dw@mail.gmail.com/T/#mc4c5c87594cd2e0ea795259a6868b3494781cf86

--0000000000003443c0063244beeb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 3b122bc53493268d_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mMUszQVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meER3Qy85RXBhOTZmZWgzbW0vZ01RMm8vUjBsMmFlTApuVnZURG5RNDFT
TFo1TXZjdjZxYXhsdUY2MHNvUCtUaFRwWjBkVDNMUzRjUUtnMWdGRWdZcG1BUCtXdVdNSWROCnkv
ZVg0T3RwWFdqdUI1U1d2dkR5dks2UHorSGhIMk5JVCtWTDRXc2JOeGRZM2FacUJSbmgyWG9ic3V5
QWV5Y0IKTkUyamFVL0VrNWwwWlB1bGh1eUR2S2t6NUVhUUdlRVNSZFBLTVhlZ2JaLzQyNTJUQjVU
K2VmVXdubW9ZaDMzSwp5SzYzLy9JRFV5RmlwcWh0bkN3ZmJCNGpwNFo0VHhKYU5JS1RGUHU3MVRY
bGliYTd1RTlKb0tpazVPNGR3Z20zCm1pQkZ0VzJPY1g3RSs1ejFkbzRZOS9yc1VCU0F2WHF6ZjVr
MW44SnFFbS9yandqT0s5OVhXVkR4Y1VENkhCMUYKbURlZ2JPQ1dIdWdPNk1nQU56TmFkbGtYb3Ro
czZ3Rnl5VUp1NElaanJHV2w0YW5oUU9kV2xUV2hzNHlKeEFCNgpSOWFjZ1FoUFY2MzM3Q0Irbnd4
MVZYdHpFTVFSWmFyei9OMEFtdXlZOGpYbUV3VUN0bXoyL3Vvc2xJSXRZTTR0Clg4MFg1STNXdmRp
dTdzQlNJTnlhMEcvQ2RtRkh3Y3k3cURlRElYbz0KPXIzdEgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000003443c0063244beeb--

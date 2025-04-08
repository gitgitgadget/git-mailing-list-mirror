Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8F022257E
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 11:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744112240; cv=none; b=aAmQu/dxoTNGpONxFogq8Bm37dBiBxGSMWzVIhZssctXLrusvPfbPTlJgAhqqoDhOL0OIyN0XMl4Cp1HFwk4+KIHrVLQ8NMSt1f3rAhOG+YicPTNNBjtNSVuFa+MMB25RasT5DFliGt5oF74aml/DdDgPGimPicC0yG23LUNhtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744112240; c=relaxed/simple;
	bh=qq/WyGSEeJ6KWpncT52GhXJzbXEcy/lklduXoUB+hgY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rVIAOnULXkfVLRp1kXE3sGFtQ8bo3sL7ql25qw1dg+lbaZ7FJvYfiCnWKQyWuAEP/wVy0m5dcTDrtk8yIp55kGB/tsWcUgV9erDN4rxpvgsn7Y5rWfOWsPDPBtAnnfEA/GWEyWqENlRN2rkAiq8RU+Kk3exiCnGpkavNQ9s9wIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nM8pfFDR; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nM8pfFDR"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-86715793b1fso2330629241.0
        for <git@vger.kernel.org>; Tue, 08 Apr 2025 04:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744112236; x=1744717036; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=eLlXFbMs+wLkNqs9Wn/peAvwwWyP86KL/JPfgLn3YkI=;
        b=nM8pfFDRG9c6/7HPWEeE206TnosKx/sbFWAC1qr61m/XBOtu9xTcT0hE99u5WoIdAr
         u+/Bz4hcmXnsi5+yskoR0Nvv4Ggc26m6wTjazTJKD5ezd4Mp5n2Wbg46maOVweTQuq7S
         mxYTXiO5xpeBE+ggdpNOfjYux0cYmqFKwInq01K1U95QgFzCLrUSx1pLb8XcAusK1v8s
         FmZUpgALREWpFRJ6KNdibFWrPWT+ZrbZOGMuGPz3nVgtTsobpauIqFuNW26iWmPo1jT+
         8pd5HwznbMgq6Dj+aptt5GgJkeTua17jj/WINeW3J1Pmp7cZ/kUvw2kMjzi6V2X1UiYj
         5kXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744112236; x=1744717036;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eLlXFbMs+wLkNqs9Wn/peAvwwWyP86KL/JPfgLn3YkI=;
        b=rdf1Moek0UAe4kd9AQBWtvdaiFd+HPfynaS5V/HkLUf7dw0yF5d5Nv/bcddepwQUlq
         iXLcqtgoFJfs4lhFJH7LarUozq4Cw9XUP92x3XrHXZpMBTCNfpoCyPFScnbvGKXE4SBB
         ZtmZDzPq8IDzBLpZ0Aq1mSfFigCOc8tp4Kr57+kz4E7vCvziULJRGaDOiFf6SfkkWVsS
         DluN+l+q6ptzsC37rNJpCKiH/1G28YqfMe6TiHeXR6oRV+Mi+x28JRpdFrOaUWKA6MJ3
         7ibwMaB0KIOo8P7QZ8UeJt2YfkQYgwAU7tkLmA7Dv+ou/hmwFD0CpLI8+9F7HIzLCtuP
         s9Jw==
X-Forwarded-Encrypted: i=1; AJvYcCWXpWsLcw6ZwWHFinCVTw8okxT8jJuGQlQYWJdcbzVborIPKTQdMbx6qPg6a8CJB5Y3v60=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFISj8mDwtTZ4cjMF+A/x2tta+ntk8Q4Ms5ptQfbCSE7hxDl41
	zn0Lg69GCbVtCSRR4pU4qz+A3WRCBjtFpNEBcbO5Bgb/bRfs+OfRwqbrZPDuao2qP4Jz7zXvW/i
	XL4nKv41DXD2EfdVmLXiDE1tmGXk=
X-Gm-Gg: ASbGnct/vbN2kUacNLtPTmpeOX3+XdVjUIl+oozvmJ5MbEo5LP3F0xEJiHTgTy5FUys
	fZMxFS5p8xJeFM4Te6phjXieX3oOTjxqQ9NNuGp1QaIPXULPy+xVq7qBWWr2TpqAxiNiOktOfZw
	E0cStbEMjgksgmqmzJceRLniV43KmGyfdFWEY=
X-Google-Smtp-Source: AGHT+IF+FjOu0LOY0vx98sMN6TyRvrdhPjgwjwDIQST7/UpYTl6+a+ZMRPoA7dJAwFNRc/X2r4EGF/ddf0fUCSS8ww0=
X-Received: by 2002:a05:6102:f86:b0:4bb:eb4a:f9f2 with SMTP id
 ada2fe7eead31-4c8553aea85mr13162851137.9.1744112236190; Tue, 08 Apr 2025
 04:37:16 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 8 Apr 2025 11:37:15 +0000
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 8 Apr 2025 11:37:15 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <2E36129F-71FC-4053-A20C-D41C4B3103A4@gmail.com>
References: <2E36129F-71FC-4053-A20C-D41C4B3103A4@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 8 Apr 2025 11:37:15 +0000
X-Gm-Features: ATxdqUEBwW-7oRjS1KTXAKufnvhsOcvYxqRryHU60om5fo01ma5nURHwGS-K6vs
Message-ID: <CAOLa=ZQSnwSPw1U_-2YZzjK5z_jUEB3vGy=So5e+gpOa87Ei=w@mail.gmail.com>
Subject: Re: [GSoC v3] Project Proposal: Machine-Readable Repository
 Information Query Tool
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, git@vger.kernel.org
Cc: ps@pks.im, shyamthakkar001@gmail.com
Content-Type: multipart/mixed; boundary="000000000000498293063242c69b"

--000000000000498293063242c69b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

> Hello again!
>
> I'm sending this v3 which is basically the v2 with some polishments.
> You can skip the v2 and review this directly. So, the changes compared
> to v1 are:

Thanks Lucas, for your proposal. I would recommend in-lining new
versions in the same thread, it makes it easier to review and also to
note what comments were left in previous versions. That said, I just
went through v1 and skipped v2 as you suggested. Reading on.

>
> - Detailing the status of my patches;
> - Focusing in `rev-parse` features, listing all that Patrick suggested an=
d
>   searching for a few more that may be useful;
> - Given it is more focused on rev-parse, the parts about surveying users
>   and projects for features was reduced but not entirely suppressed, as I=
'll
>   need to find __where__ and __why__ this new command will be important. =
But
>   now this will not be as important I as thought it would be;
> - Changed the expected output, which becomes very smaller compared to wha=
t I
>   thought it would be;
> - Making the name of the new command explicit;
> - Making it clear that the JSON-related functionality will be placed in a
>   separated file;
> - Detailing a little bit more some examples of functions that I expect to=
 use
>   for retrieving data to populate the JSON that will be outputted;
> - Breaking the schedule into 6 steps, bringing part the development of th=
e
>   JSON serializer to the beginning.
>
> ---
>
> # Machine-Readable Repository Information Query Tool
>
> ## Contact info
>
> - Name: Lucas Seiki Oshiro
> - Timezone: GMT-3 (America/S=C3=A3o Paulo)
> - IRC: lucasoshiro
> - Personal page: https://lucasoshiro.github.io/en/
> - GitHub: https://github.com/lucasoshiro
> - LinkedIn: https://www.linkedin.com/in/lucasseikioshiro/
>
> ## About me
>
> My name is Lucas Oshiro, I'm a developer and CS bachelor from S=C3=A3o Pa=
ulo,
> Brazil. Currently I'm pursuing a master degree in CS at University of S=
=C3=A3o
> Paulo. My interest in Git dates from years ago and I even submitted a
> patch to its codebase in the past, though I couldn't complete it due to
> scheduling conflicts with my capstone project.
>
> Having experience in the academia, industry and FLOSS, I highly value
> code quality, code legibility, well-maintained Git histories, unit tests
> and documentation.
>
> ### Previous experience with Git
>
> Before this year, I haven't been involved directly with Git community,
> however, I kept my interest in Git alive by:
>
> - Translating the "Git Internals" chapter of Pro Git to Brazilian
>   Portuguese: https://github.com/progit/progit2-pt-br/pull/81;
>
> - Writing some blog posts about Git, for example:
>   - one explaining how Git can be used as a debugging tool:
>     https://lucasoshiro.github.io/posts-en/2023-02-13-git-debug/;
>

This was a good read! Really nice!

>   - other explaining how Git merge submodules:
>   https://lucasoshiro.github.io/posts-en/2022-03-12-merge-submodule/;
>
> - Writing a compatible subset of Git in Haskell from scratch:
>  https://github.com/lucasoshiro/oshit;
>
> - Helping organizing a Git Introductory Workshop at my University:
>   https://flusp.ime.usp.br/events/git-introductory-workshop/;
>
> - Presenting some lectures about Git in a company that I worked some
>   years ago, covering the Git internals (objects, references, packfile)
>   and debugging and archaeology related Git tools (blame, bisect,
>   pickaxe, ls-files, etc).
>
> ### Previous experience with C and open-source
>
> I also have experience with C and some C++. During my CS
> course, C was one of the primary languages that I used. I also
> worked with C/C++, for example, in:
>
> - Writing an AMQP message broker from scratch:
>   https://github.com/lucasoshiro/amqp_broker;
>
> - Contributing with simple patches to the IIO subsystem of the Linux
>   kernel: https://lucasoshiro.github.io/floss-en/2020-06-06-kernel_linux/=
;
>
> - Contributing to the Marlin firmware for 3D printers:
>   https://lucasoshiro.github.io/floss-en/2020-06-30-Marlin/;
>
> - Writing a module for the ns-3 network simulator, dealing with both C
>   and C++ codebases (currently under development, I plan to write a
>   paper and make the code available soon);
>
> During my CS course I also was member of FLUSP
> (https://flusp.ime.usp.br), a group in my university focused on FLOSS
> contributions and from Hardware Livre USP
> (https://hardwarelivreusp.org), another group that was focused on
> working with open-source hardware.
>
> As a master's student, I'm one of the Open Science Ambassadors of my
> University (https://cienciaaberta.usp.br/sobre-o-projeto/, in
> Portuguese), promoting the Open Science principles, which include
> open-source software, in the unit where I study.
>
> I also contributed to some other free/open-source software, which I list
> here: https://lucasoshiro.github.io/floss-en/
>
> ### Activity in the Git community in 2025
>
> Since when I decided to submit a proposal for GSoC, I sent some patches
> to the Git codebase and git.github.io:
>
> - My microproject, replacing some `test -f` by `test_path_is_file`:
>   https://lore.kernel.org/git/20250208165731.78804-1-lucasseikioshiro@gma=
il.com/,
>   merged to master;
>
> - Adding a paragraph to the merge-strategies documentation describing how
>   Git merges submodules (based on the blog post that I mentioned
>   before):
>   https://lore.kernel.org/git/20250227014406.20527-1-lucasseikioshiro@gma=
il.com/,
>   merge to master;
>
> - A patchset adding a new `--subject-extra-prefix` flag for `git format-p=
atch`,
>   allowing the user to quickly prepend tags like [GSoC], [Newbie] or [Out=
reachy]
>   to the beginning of the subject:
>   https://lore.kernel.org/git/20250303220029.10716-1-lucasseikioshiro@gma=
il.com/.
>   This patchset was rejected in favor of just using `--subject-prefix=3D'=
GSoC
>   PATCH'` or similar;
>
> - Given the feedback on the previous rejected patchset, I opened a Pull
>   Request on git.github.io replacing the occurrences of `[GSoC][PATCH]`
>   by `[GSoC PATCH]`, merged to master;
>
> - Adding a new userdiff driver for INI files, initially target for
>   gitconfig files:
>   https://lore.kernel.org/git/20250331031309.94682-1-lucasseikioshiro@gma=
il.com/.
>   Currently it is still under revision.
>
> Beyond contributions, I also helped people on the mailing list that
> needed assistance on Git features and documentation.
>
> ## Project Proposal
>
> Based on the information provided in
> https://git.github.io/SoC-2025-Ideas/, the goal of this project is to
> create a new Git command for querying information from a repository and
> returning it as a semi-structured data format as a JSON output.
>
> A first idea on how this command would be named is `git metadata`.

One thing to keep in mind is we already have:
- git status
- git describe

Both of them are used to provide summary about the repository in some
sense. How do we differentiate between these two and the new command.
Rhetorical:
- Does 'git metadata' differentiate itself enough to imply what it does?
- Does it convey that it should be used to retrieve repository
  information?
- Should we consider 'git repo-info', 'git info', 'git context', 'git
  repo-query'?

It would be nice to add some thought here, perhaps justifying why the
chosen name is chosen.

>
> In the scope of this project, the JSON output will only include data
> that can currently be retrieved through existing Git commands. The main
> idea is to centralize data from `git rev-parse`, which currently is
> overloaded with features that doesn't fit its main purpose.
>

We know that 'git rev-parse' outputs in a human readable, would that be
the default here too?

> Some of the data that we expect to retrieve and centralize are:
>

There are a lot more options under the 'Options for Files' section of
the 'git rev-parse' manpage, it would nice to highlight that this is
mostly what we're looking at.

> - The hashing algorithm (i.e. `sha1` or `sha256`), which currently can
>   be retrieved using `git rev-parse --show-object-format`;
>
> - The Git directory of the repository, currently retrieved by running
>   `git rev-parse --git-dir`;
>
> - The common Git directory, currently retrieved by running
>   `--git-common-dir`;
>
> - The top level directory of the repository, currently retrieved by using
>   `git rev-parse --show-toplevel`;
>
> - The reference database format (i.e. currently, `files` or `reftable`),
>   currently retrieved by running `git rev-parse --show-ref-format`;
>
> - The absolute path of the superproject, currently retrieved by running
>   `git rev-parse --show-superproject-working-tree`;
>
> - Whether this is a bare repository, currently retrieved by running
>   `git --is-bare-repository`;
>
> - Whether this is a shallow repository, currently retrieved by running
>   `git --is-shallow-repository`.
>
> Given that the information that we want to compile are currently
> accessible with different sets of flags, the user that wants to read
> them needs to have an advanced knowledge on Git. Once having the
> repository details consolidated in a single command, the user will be
> able to quickly retrieve what it desires without navigating a complex
> combination of commands and flags.
>
> A side effect is decreasing the reponsibility of `rev-parse`, like
> `git switch` and `git restore` did for `git checkout`.
>
> ### Use cases
>
> Some use cases that will be benefited of `git metadata` will be:
>
> - CLI tools that display formatted information about a Git repository,
>   for example, OneFetch (https://github.com/o2sh/onefetch);
>
> - Text editors, IDEs and plugins that have front-ends for Git, such as
>   Magit (https://magit.vc) or GitLens
>   (https://www.gitkraken.com/gitlens);
>
> - FLOSS repository tracking software, for example,
>   kworkflow (https://github.com/kworkflow),
>   ctracker (https://github.com/quic/contribution-tracker);
>
> - Any other tool that integrates with Git and currently relies on
>   `rev-parse` to get information about the repository;
>
> ### Planned features
>
> `git metadata` consists of one big feature: produce the JSON with
> repository metadata. At first, this should be populated with the data
> that currently can only be retrieved through `git rev-parse`, like the
> ones listed before.
>
> Other data may be added depending on the demands of the Git community
> and the user base.
>
> By now, it's not possible to decide precisely how this command would
> work without it being more discussed. But a first draft on how it would
> be invoked and the output that it will produce is:
>
> ~~~
> $ git metadata
>
> {
>     "object-format": "sha1",
>     "git-dir": ".git",
>     "common-dir": ".",
>     "toplevel": "/home/user/my_repo",
>     "ref-format": "files",
>     "superproject-working-tree": "/home/user/my_super_repo",
>     "bare-repository": true,
>     "shallow-repository": false
> }

It would be nice to add subsections maybe:
  '{"refs": {...}, ..., "objects": {...}}'

> ~~~
>
> This first draft will be sent to the mailing list in order to get
> feedback from the Git community.
>
> ### Development plan
>
> Since this is a new command that is not directly related to any specific
> existent command, its main code will probably be placed in a new file
> `builtin/metadata.c`.
>
> Given that this project will give JSON-related functionality to Git, a
> new `json.c` file in the top level directory of the codebase will be
> created and it will be available for being used by `git metadata` and
> any other command that want to reuse the JSON features introduced here.
>
> The functionality `git metadata` can be divided into two categories:
>
> 1. **Data gathering**: retrieving data from different sources, calling
>    existent functions and reading data structures declared in other
>    files;
>
> 2. **Data serialization**: formatting the gathered data in a JSON
>    format. This represents two challenges: generating the JSON itself
>    and designing the schema for how the desired data will be presented.
>
> Since the exported data is already provided by other Git commands, it
> won't be difficult to implement this side of the functionality. The main
> task for gathering data will be inspect the existing codebase and find
> the functions and data structures that will feed our output. For
> example, the already mentioned data:
>
> - Hashing algorithm: `git rev-parse` reads from the field
>   `the_repository->hash_algo->name` (aka `the_hash_algo->name`);
>
> - The Git directory, the common Git directory and top level directory:
>   `git rev-parse` formats those paths using `print_path`, based on the
>   `prefix` parameter and the fields `commondir` and from
>   `the_repository`;
>
> - Reference database format: `git rev-parse` retrieves it from
>   `ref_storage_format_to_name`;
>
> - Absolute path of the superproject: `git rev-parse` retrieves it from
>   the function `get_superproject_working_tree`;
>
> - Whether the repository is bare: `git rev-parse` retrieves it from the
>   function `is_bare_repository`;
> - Whether the repository is shallow: `git rev-parse` retrieves it from
>   the function `is_repository_shallow`.
>
> Designing the schema, however, requires special planning, as the
> flexibility of semi-structured data like JSON may lead to early
> bad decisions. A solution may emerge by analysing other software that
> export JSON as metadata.
>
> ### Schedule
>
> 1. **Now -- May 5th**: Requirements gathering
>    - Present to the Git community the proposal, asking what are the
>      features that it demands;

Nice, an RFC before adding the command would go a long way!

>    - Inspect codebases that uses Git (specially `rev-parse`) as data
>      source;
>    - Studying more deeply the codebase, specially the `rev-parse` source
>      code;
>
> 2. **May 6th -- June 1st**: Community bonding
>    - Getting in touch with the mentors;
>    - Present to the community a first proposal of the JSON schema;
>    - Receive feedback from the community about the schema;
>    - Present a first proposal on the command line interface;
>    - Receive feedback from the community about the command line
>      interface;
>
> 3. **June 2nd -- June 31th**: First coding round
>    - Decide how the CLI should behave, that is, what should be exported
>      by default, what should be outputted only by using flags and what
>      should not be outputted by using disabling flags;
>    - Write a minimal JSON serializer, focusing on export only the
>      top-level object with only string values;
>    - Define a simple data structure that holds only one field of the
>      data that we want to export;
>    - Introduce a first version of the command, outputting the first data
>      structure using the first JSON serializer;
>    - Write test cases in different scenarios comparing the output of the
>      new command with the outputs of the existing commands;
>    - Write a minimal documentation file for the new command, making it
>      explicitly that the command is experimental and it's still under
>      development;
>
> 4. **July 1st -- July 14th**: Second coding round
>    - Fill the data structure with all other string fields that should be
>      exported;
>    - Add flags for filtering the data output;
>    - Write tests for each one of the new fields and flags;
>    - Improve the documentation file, explaining what the command does,
>      its output format and what the flags that were implemented so far
>      do;
>
> 5. **July 15th -- August 15th**: Third coding round
>    - Improve the JSON serializer, allowing other data types: array,
>      number, boolean, null and nested objects;
>    - Fill the data structure with the remaining non-string fields;
>    - Write flags, tests and documentation for the types that were
>      implemented in this round;
>
> 6. **August 16th -- August 25th**: Fourth coding round
>    - Polish the documentation, providing examples on how to use it and
>      notes on why this command was created;
>    - Finish remaining work from the previous rounds that still need to
>      be concluded;
>
> ### Availability
>
> 2025 is my last year in my master's degree. Currently, I'm not attending
> any classes and I am more focused on developing the software of my
> research, performing experiments and writing scientific articles and my
> thesis. Since my advisor is aware that I'm proposing a GSoC project, it
> will be possible to work on Git while working on my master's tasks.
>

One thing I found missing is the project size and what you think about
it.

Thanks
- Karthik

--000000000000498293063242c69b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: ed646e7b2f34fc97_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mMUNtb1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOVFUQy93TXd1QzFKRThyTUluOXUrK3FsNnFML1BGOQpENlhCeDVmN3dD
aEsyc3ZLemJQMENJMDFFN0dTL2tLUHNEdXFobFdHQTFJajBxbW1OTXBHUUhiQWdvVkRNajErCisw
Rk5tZHdZV2dOWHBzZUVkNE42T0NubXRNZXBVY1N5Q3pXcHZzYkRZMmNudDdQTkQzbFdiWDZRSlR4
Tm1UR3YKWVZZTjRqdW1PQmg4RzJPcEFhbTdpUUxXaVAvK0h5SGlpSnd3aThGYTBJaFNrZU9JUzMv
cWRkeGNWYTVyUG82Lwp5ZFBQcHVwcXN3SjlvY3Y1V2gvTzBxWWV6aXFNSUdUajRuM3g3TDVveGFz
QmNVU0t0akFGMWdsWEwrbktDN3ZyCjcyRENhbmU3SGJxbUtWSi9kVTNBVFdtclNYKzJOcVFDZEEz
OTRBVnhQdmljcmVUYjNxbURhL1lzQldYelZhWW8KRE5jVGNrWGdDRU5PU0UyeFdJNG9CZzNwTHhW
T3ErUCttT3NXTktTdk9JdUJJSXlWMmJ4cDhwUWNXdUdyRGRENQpMaW8xK3RLVm5VelZhcmZsRVZj
T2dWVHlRT3I2T04yMUhDczVNaWpWTjN4N1lNNkdMdHFwK2ZZb2V0QnVERXJLCmN4OXR6RWVrSXhC
ZEY4MVlHdVhmMUhSU2tBdndEYTE3aHlhd1dIdz0KPUNnbkYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000498293063242c69b--

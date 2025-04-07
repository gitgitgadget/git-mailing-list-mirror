Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78703222594
	for <git@vger.kernel.org>; Mon,  7 Apr 2025 19:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744053519; cv=none; b=tFXWt6ARIlA+oJnVNMlcko9XDjLKN1tBbnVwc1ZcS20+27Hsrv/hpZcWEToIYNf2gxSikIrkPAeF76d2jXxv7A36j14sRnkjFOo+0HhKj+r8nqgzanYDXpZsZZVpgSQZCRn4/Bw+01MHyVD925/AIu2c/04ULBfyk7Km5EKPNuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744053519; c=relaxed/simple;
	bh=5TrkPXOy8vuwL5uFklEtwQOBXwxXkaNohbH0hHLYFow=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=c3OEcf11Ol5jDhHl2x2kzyqtrqpImJjn2cVFEkJ4cb9CyqR4g8dnuCEnHCW8FiKDRrvEBvW+x+zX2Us+Bzn1x5bye/UjCl/UaO4psF9C9A/XKOi/gB0AodCt5P5Y++XIWSOMIX6PBrsAcc1LPlb0mK0/6CWw35qmSLiBmoCPRsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ChQe5DtA; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ChQe5DtA"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-736e52948ebso5489995b3a.1
        for <git@vger.kernel.org>; Mon, 07 Apr 2025 12:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744053514; x=1744658314; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a1/31ctQYutSROtyjAnE420P98soCT7NtnnplYm37rI=;
        b=ChQe5DtAvA2whh4hwxW3OUquAPZ8J++0iTEk2AUVyl3JboAtNGZSinkVNVpV6Kxi9R
         zbcWyNnO9CuHYImxBA4urvcjwgYLxulIyJEfKTiEFvyYNrSWoSvRu9JQLTI6DRJZZ/lt
         /kNc/yEh3PrNnHFiNkftNbxTq5Sq2AZBkLbNuAaR6tkGrF76ySWTw6cDox7XOHScBOFH
         UrNHRlwZjPhmjNwLfFMLPNY+Ucw4uQj93aSU5s7RmfuA72yzhhTV3PIXv/AhVh7Tl+7y
         kaXiewoFUhi/n9vGlKKOpRE6VWESGD/fIqiCxK8dE9rf9pPYlqZelfqyaB1Ip8YANd7m
         XaRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744053514; x=1744658314;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a1/31ctQYutSROtyjAnE420P98soCT7NtnnplYm37rI=;
        b=mlHuPJXSSLyluZvPxFUcPB4pMmxD1xQzObx74EUjow+Qeifj+coNuPxZ/1+yN/aLiK
         YKQE0DxCNZJ6Ojq5zmHXLuyL+6BjjmHapVzWSKfLaL2x8IPgf5qixbJIVFFyu6yLTIsS
         v6sNeYyCquEUuba8796Gk3N4/IK8Fujf3nhzkHvJC/7G5h84zL5sdtRECQL/Owi3ZVDf
         sVBn4BMRnBnL0y8sgDNTWmWRtgqDa/DTXuw6a4RYSPfrAjWnu05ijnnJHhYmfBu484Uu
         B7sJDLoNGwkeFL89O84oIV5rSQdLLhAv3VPArQ0FZbzUqsISKkFdgJZnGJSb27mSFiXH
         pJKA==
X-Gm-Message-State: AOJu0YwtQD+eDjRD0GQ41eZUyOwb1Z8ycw79SJgvSK5SQljZFrtUjKFA
	Dsvxmd2CyGvBqqlXWnJ8EzqfahJw3FmVoZriN5f9vAtknbROxx30TJqS+w==
X-Gm-Gg: ASbGncv/k/Tv+o8x2fM71GBEot9/FVKosS1pqY3xK1QeSbngYLDIKfrW+8vC5t5Rxmh
	gm9F9KMC3YULYYYSBYIsv5VveOlMS/s1QjjZ7BPQjKfnjBpsa49rq9djlFzKsWarJBZZGoLNB4p
	vm+/wRFuc4HuWYAKw9sAVS/zSFpK7DJ9tM5UQXs6YM/NyyqEmUirgKATWM/XsDJ59M9Nyl6o1uO
	Qpm4PoZT6X0uU9yobZw6EdK+Cdm+Zmiy59d3viLGhPIYI7rQeU2KgLM6TAj2KHlmSSt6K6aD5zC
	sgZVrTcrfjwJkjZI0sI0HaE+xnhp/N0JP5/UIFX2X2vaL8V98DBX5wZnGop7Wg3kJa+RrKvtlec
	NXOf9
X-Google-Smtp-Source: AGHT+IEyBK330tNFcvn9aBQute57vGRcbhhdQkJxMX6EGD2FDcg12oUy5vO/j4DqeRvj5tnpPY53PQ==
X-Received: by 2002:a05:6a00:390c:b0:736:a8db:93b4 with SMTP id d2e1a72fcca58-739e6fbf7damr17026867b3a.2.1744053513634;
        Mon, 07 Apr 2025 12:18:33 -0700 (PDT)
Received: from smtpclient.apple ([2804:214:8123:72ef:4400:ca7:138e:9bd7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739da0b3009sm8895208b3a.123.2025.04.07.12.18.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Apr 2025 12:18:32 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: [GSoC v3] Project Proposal: Machine-Readable Repository Information
 Query Tool
Message-Id: <2E36129F-71FC-4053-A20C-D41C4B3103A4@gmail.com>
Date: Mon, 7 Apr 2025 16:18:18 -0300
Cc: ps@pks.im,
 karthik.188@gmail.com,
 shyamthakkar001@gmail.com
To: git@vger.kernel.org
X-Mailer: Apple Mail (2.3826.500.181.1.5)

Hello again!

I'm sending this v3 which is basically the v2 with some polishments.
You can skip the v2 and review this directly. So, the changes compared
to v1 are:

- Detailing the status of my patches;
- Focusing in `rev-parse` features, listing all that Patrick suggested =
and
  searching for a few more that may be useful;
- Given it is more focused on rev-parse, the parts about surveying users
  and projects for features was reduced but not entirely suppressed, as =
I'll
  need to find __where__ and __why__ this new command will be important. =
But
  now this will not be as important I as thought it would be;
- Changed the expected output, which becomes very smaller compared to =
what I
  thought it would be;
- Making the name of the new command explicit;
- Making it clear that the JSON-related functionality will be placed in =
a=20
  separated file;
- Detailing a little bit more some examples of functions that I expect =
to use
  for retrieving data to populate the JSON that will be outputted;
- Breaking the schedule into 6 steps, bringing part the development of =
the
  JSON serializer to the beginning.

---

# Machine-Readable Repository Information Query Tool

## Contact info

- Name: Lucas Seiki Oshiro
- Timezone: GMT-3 (America/S=C3=A3o Paulo)
- IRC: lucasoshiro
- Personal page: https://lucasoshiro.github.io/en/
- GitHub: https://github.com/lucasoshiro
- LinkedIn: https://www.linkedin.com/in/lucasseikioshiro/

## About me

My name is Lucas Oshiro, I'm a developer and CS bachelor from S=C3=A3o =
Paulo,
Brazil. Currently I'm pursuing a master degree in CS at University of =
S=C3=A3o
Paulo. My interest in Git dates from years ago and I even submitted a
patch to its codebase in the past, though I couldn't complete it due to
scheduling conflicts with my capstone project.

Having experience in the academia, industry and FLOSS, I highly value
code quality, code legibility, well-maintained Git histories, unit tests
and documentation.

### Previous experience with Git

Before this year, I haven't been involved directly with Git community,
however, I kept my interest in Git alive by:

- Translating the "Git Internals" chapter of Pro Git to Brazilian
  Portuguese: https://github.com/progit/progit2-pt-br/pull/81;

- Writing some blog posts about Git, for example:
  - one explaining how Git can be used as a debugging tool:
    https://lucasoshiro.github.io/posts-en/2023-02-13-git-debug/;

  - other explaining how Git merge submodules:
  https://lucasoshiro.github.io/posts-en/2022-03-12-merge-submodule/;

- Writing a compatible subset of Git in Haskell from scratch:
 https://github.com/lucasoshiro/oshit;

- Helping organizing a Git Introductory Workshop at my University:
  https://flusp.ime.usp.br/events/git-introductory-workshop/;

- Presenting some lectures about Git in a company that I worked some
  years ago, covering the Git internals (objects, references, packfile)
  and debugging and archaeology related Git tools (blame, bisect,
  pickaxe, ls-files, etc).

### Previous experience with C and open-source

I also have experience with C and some C++. During my CS
course, C was one of the primary languages that I used. I also
worked with C/C++, for example, in:

- Writing an AMQP message broker from scratch:
  https://github.com/lucasoshiro/amqp_broker;

- Contributing with simple patches to the IIO subsystem of the Linux
  kernel: =
https://lucasoshiro.github.io/floss-en/2020-06-06-kernel_linux/;

- Contributing to the Marlin firmware for 3D printers:
  https://lucasoshiro.github.io/floss-en/2020-06-30-Marlin/;

- Writing a module for the ns-3 network simulator, dealing with both C
  and C++ codebases (currently under development, I plan to write a
  paper and make the code available soon);

During my CS course I also was member of FLUSP
(https://flusp.ime.usp.br), a group in my university focused on FLOSS
contributions and from Hardware Livre USP
(https://hardwarelivreusp.org), another group that was focused on
working with open-source hardware.

As a master's student, I'm one of the Open Science Ambassadors of my
University (https://cienciaaberta.usp.br/sobre-o-projeto/, in
Portuguese), promoting the Open Science principles, which include
open-source software, in the unit where I study.

I also contributed to some other free/open-source software, which I list
here: https://lucasoshiro.github.io/floss-en/

### Activity in the Git community in 2025

Since when I decided to submit a proposal for GSoC, I sent some patches
to the Git codebase and git.github.io:

- My microproject, replacing some `test -f` by `test_path_is_file`:
  =
https://lore.kernel.org/git/20250208165731.78804-1-lucasseikioshiro@gmail.=
com/,
  merged to master;

- Adding a paragraph to the merge-strategies documentation describing =
how
  Git merges submodules (based on the blog post that I mentioned
  before):
  =
https://lore.kernel.org/git/20250227014406.20527-1-lucasseikioshiro@gmail.=
com/,
  merge to master;

- A patchset adding a new `--subject-extra-prefix` flag for `git =
format-patch`,
  allowing the user to quickly prepend tags like [GSoC], [Newbie] or =
[Outreachy]
  to the beginning of the subject:
  =
https://lore.kernel.org/git/20250303220029.10716-1-lucasseikioshiro@gmail.=
com/.
  This patchset was rejected in favor of just using =
`--subject-prefix=3D'GSoC
  PATCH'` or similar;

- Given the feedback on the previous rejected patchset, I opened a Pull
  Request on git.github.io replacing the occurrences of `[GSoC][PATCH]`
  by `[GSoC PATCH]`, merged to master;

- Adding a new userdiff driver for INI files, initially target for
  gitconfig files:
  =
https://lore.kernel.org/git/20250331031309.94682-1-lucasseikioshiro@gmail.=
com/.
  Currently it is still under revision.

Beyond contributions, I also helped people on the mailing list that
needed assistance on Git features and documentation.

## Project Proposal

Based on the information provided in
https://git.github.io/SoC-2025-Ideas/, the goal of this project is to
create a new Git command for querying information from a repository and
returning it as a semi-structured data format as a JSON output.

A first idea on how this command would be named is `git metadata`.

In the scope of this project, the JSON output will only include data
that can currently be retrieved through existing Git commands. The main
idea is to centralize data from `git rev-parse`, which currently is
overloaded with features that doesn't fit its main purpose.

Some of the data that we expect to retrieve and centralize are:

- The hashing algorithm (i.e. `sha1` or `sha256`), which currently can
  be retrieved using `git rev-parse --show-object-format`;

- The Git directory of the repository, currently retrieved by running
  `git rev-parse --git-dir`;

- The common Git directory, currently retrieved by running
  `--git-common-dir`;

- The top level directory of the repository, currently retrieved by =
using
  `git rev-parse --show-toplevel`;

- The reference database format (i.e. currently, `files` or `reftable`),
  currently retrieved by running `git rev-parse --show-ref-format`;

- The absolute path of the superproject, currently retrieved by running
  `git rev-parse --show-superproject-working-tree`;

- Whether this is a bare repository, currently retrieved by running
  `git --is-bare-repository`;

- Whether this is a shallow repository, currently retrieved by running
  `git --is-shallow-repository`.

Given that the information that we want to compile are currently
accessible with different sets of flags, the user that wants to read
them needs to have an advanced knowledge on Git. Once having the
repository details consolidated in a single command, the user will be
able to quickly retrieve what it desires without navigating a complex
combination of commands and flags.

A side effect is decreasing the reponsibility of `rev-parse`, like
`git switch` and `git restore` did for `git checkout`.

### Use cases

Some use cases that will be benefited of `git metadata` will be:

- CLI tools that display formatted information about a Git repository,
  for example, OneFetch (https://github.com/o2sh/onefetch);

- Text editors, IDEs and plugins that have front-ends for Git, such as
  Magit (https://magit.vc) or GitLens
  (https://www.gitkraken.com/gitlens);

- FLOSS repository tracking software, for example,
  kworkflow (https://github.com/kworkflow),
  ctracker (https://github.com/quic/contribution-tracker);

- Any other tool that integrates with Git and currently relies on
  `rev-parse` to get information about the repository;

### Planned features

`git metadata` consists of one big feature: produce the JSON with
repository metadata. At first, this should be populated with the data
that currently can only be retrieved through `git rev-parse`, like the
ones listed before.

Other data may be added depending on the demands of the Git community
and the user base.

By now, it's not possible to decide precisely how this command would
work without it being more discussed. But a first draft on how it would
be invoked and the output that it will produce is:

~~~
$ git metadata

{
    "object-format": "sha1",
    "git-dir": ".git",
    "common-dir": ".",
    "toplevel": "/home/user/my_repo",
    "ref-format": "files",
    "superproject-working-tree": "/home/user/my_super_repo",
    "bare-repository": true,
    "shallow-repository": false
}
~~~

This first draft will be sent to the mailing list in order to get
feedback from the Git community.

### Development plan

Since this is a new command that is not directly related to any specific
existent command, its main code will probably be placed in a new file
`builtin/metadata.c`.

Given that this project will give JSON-related functionality to Git, a
new `json.c` file in the top level directory of the codebase will be
created and it will be available for being used by `git metadata` and
any other command that want to reuse the JSON features introduced here.

The functionality `git metadata` can be divided into two categories:

1. **Data gathering**: retrieving data from different sources, calling
   existent functions and reading data structures declared in other
   files;

2. **Data serialization**: formatting the gathered data in a JSON
   format. This represents two challenges: generating the JSON itself
   and designing the schema for how the desired data will be presented.

Since the exported data is already provided by other Git commands, it
won't be difficult to implement this side of the functionality. The main
task for gathering data will be inspect the existing codebase and find
the functions and data structures that will feed our output. For
example, the already mentioned data:

- Hashing algorithm: `git rev-parse` reads from the field
  `the_repository->hash_algo->name` (aka `the_hash_algo->name`);

- The Git directory, the common Git directory and top level directory:
  `git rev-parse` formats those paths using `print_path`, based on the
  `prefix` parameter and the fields `commondir` and from
  `the_repository`;

- Reference database format: `git rev-parse` retrieves it from
  `ref_storage_format_to_name`;

- Absolute path of the superproject: `git rev-parse` retrieves it from
  the function `get_superproject_working_tree`;

- Whether the repository is bare: `git rev-parse` retrieves it from the
  function `is_bare_repository`;
- Whether the repository is shallow: `git rev-parse` retrieves it from
  the function `is_repository_shallow`.

Designing the schema, however, requires special planning, as the
flexibility of semi-structured data like JSON may lead to early
bad decisions. A solution may emerge by analysing other software that
export JSON as metadata.

### Schedule

1. **Now -- May 5th**: Requirements gathering
   - Present to the Git community the proposal, asking what are the
     features that it demands;
   - Inspect codebases that uses Git (specially `rev-parse`) as data
     source;
   - Studying more deeply the codebase, specially the `rev-parse` source
     code;

2. **May 6th -- June 1st**: Community bonding
   - Getting in touch with the mentors;
   - Present to the community a first proposal of the JSON schema;
   - Receive feedback from the community about the schema;
   - Present a first proposal on the command line interface;
   - Receive feedback from the community about the command line
     interface;

3. **June 2nd -- June 31th**: First coding round
   - Decide how the CLI should behave, that is, what should be exported
     by default, what should be outputted only by using flags and what
     should not be outputted by using disabling flags;
   - Write a minimal JSON serializer, focusing on export only the
     top-level object with only string values;
   - Define a simple data structure that holds only one field of the
     data that we want to export;
   - Introduce a first version of the command, outputting the first data
     structure using the first JSON serializer;
   - Write test cases in different scenarios comparing the output of the
     new command with the outputs of the existing commands;
   - Write a minimal documentation file for the new command, making it
     explicitly that the command is experimental and it's still under
     development;

4. **July 1st -- July 14th**: Second coding round
   - Fill the data structure with all other string fields that should be
     exported;
   - Add flags for filtering the data output;
   - Write tests for each one of the new fields and flags;
   - Improve the documentation file, explaining what the command does,
     its output format and what the flags that were implemented so far
     do;

5. **July 15th -- August 15th**: Third coding round
   - Improve the JSON serializer, allowing other data types: array,
     number, boolean, null and nested objects;
   - Fill the data structure with the remaining non-string fields;
   - Write flags, tests and documentation for the types that were
     implemented in this round;

6. **August 16th -- August 25th**: Fourth coding round
   - Polish the documentation, providing examples on how to use it and
     notes on why this command was created;
   - Finish remaining work from the previous rounds that still need to
     be concluded;

### Availability

2025 is my last year in my master's degree. Currently, I'm not attending
any classes and I am more focused on developing the software of my
research, performing experiments and writing scientific articles and my
thesis. Since my advisor is aware that I'm proposing a GSoC project, it
will be possible to work on Git while working on my master's tasks.


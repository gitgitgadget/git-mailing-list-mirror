Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9630B17F7
	for <git@vger.kernel.org>; Sun,  6 Apr 2025 05:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743918048; cv=none; b=F3iFO2eseKlFdC9ucq5PjrmHqHvD8tZbkm4WAxWK2XybKPjN6B487eAGc7L8kU4hxqeMUjN2nCSUpa+phwFzxzOauKos2IQzSRgKVSMl513J7d/Ij1/E50BMqeMpXan37rpvM9QMMp7bGxn1zPGWaCrKueMCrxBwh/S0szZQfQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743918048; c=relaxed/simple;
	bh=IuDhxTB63U7enXTN4Lho1Op8i+QsRugtBns8FplthCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bzFuib8F4M9b47gMy94Ff9gU1LQoB2le7s3WKHnzRDvknb/3tJvdDCt8z2B2HKpP5rISuXmhWtzS4gedtblB4ICeiJEPAen3WMA+Lb4RB1fvoWP+2S2z7Ga9sEClESy0MzsfAWrmMNfEdI50Lgd7WpLTj+d+aCa5G9I+FWUJ0nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EfWLZbXo; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EfWLZbXo"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-477282401b3so35620571cf.1
        for <git@vger.kernel.org>; Sat, 05 Apr 2025 22:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743918045; x=1744522845; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OhYwCc013yN5iNwE+MfsmDCzJTc1nYqIcHAqBl41r58=;
        b=EfWLZbXoJckoytyiVjgeSW3rycWwnkQbrO5kkcBOq4PZEIdoLBpSAV3hS77/0D8tj+
         eFM0okg8KFnAikBpRDqnmWtkb7aDO0Im37wFmhnqQDKW1MFKJMMFrEl9esgu2xRxG7tB
         Zi8vUfQTpVlWoSnNmaEgFcnjS2CGjcCzvUxuUhLde3Qz+DiKWcnoNM/eUKmIoA9Q/Xiy
         7E8Fw4VLCOSqIFzyidOpQC+gjjEv1Vs9FAHkd8yGokjo7WHa0nE9rYLVMYNSGYpwpfQZ
         bzHgPF2DJfmfAw8WhnZT/JglmP4op7nHBU/isI1mpXJyS4oWIRPkVG5NsXknSlLio4C4
         t7xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743918045; x=1744522845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OhYwCc013yN5iNwE+MfsmDCzJTc1nYqIcHAqBl41r58=;
        b=SDVvakGDIFq7STQedGDjRzwqtWdvAJPsS8+3sKFIDxgAgwEPhYdV0Zra/EMdjcs3z0
         Wbc2yaCr73tLJo1j18yFV/EOXMRpcnRu99y1h0eZ1kBtAylX+Wo2ScQEu6maUbAOSlhF
         3ZgU6CltBulu5XCkv1RT9z5x587iQgLWiiYsT0svw3vBFJy7ENOrzW2oA+Rl6BpLsiYt
         Ox/KDoxs/bGmW/Cs6e4e1GjsnyIiBfRYfgfLId0klHFfYhZpDnp/es5bDqCD91VARBoI
         EMXYRp9qNfNhPw/W7lX5b10Uq4+yj6MGr+TFUhjfIDS/pMO6FKHAQr3zdDRQcwLLR1cW
         cXAg==
X-Forwarded-Encrypted: i=1; AJvYcCXO9unVd5Lp+GC5k319WnzfWqTS+ic6nWvckX3ISdw7xdyPzZk88Fs0vVNTrSd8lEHee+I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz95mLmocvALV2mSvIULaTHy3DJnwsA2TcWpMUm86EZGkw9NVl
	aLZPqYuv9ow9pVk/yHz/qljUlnh2Ta13a7GxAu06qwIDziZYhLebuB458qQ9f72HGXgOmbxUgfF
	UI0vyhxCs8g6LHBC1nlVOa3wqZ1o=
X-Gm-Gg: ASbGncuR6Jql+eORJvnTdMBUXwX36DNuQPWwDKvaCDCr+MIKAbTzH1I/Q4GgTiRya2E
	ymgpTeZAXNFBgII01xvGYFv+Ji1sJVb4AntziqvzeO4Z3HDJl/tefSr/TMJwbUm/K32UzOzujdI
	7owv6Q0bwvP01lJbKTfGDxI9iZuI1YunOq6i/FNOW3czKRS6S2Lz3Dzuf5YdM=
X-Google-Smtp-Source: AGHT+IFqPL2yh1q3GPs80UttlPnxKyU08PfSb2kbrSAp7k4yQfcc7C7OMaK8U4UKDCdnzDpAcHX1Iu+k0fUcIX3L4MQ=
X-Received: by 2002:a05:622a:1211:b0:476:7018:9ae4 with SMTP id
 d75a77b69052e-47930fc2e7dmr78150621cf.16.1743918044760; Sat, 05 Apr 2025
 22:40:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+rGoLfxZHdns=7FwQuYS=JANrR9zDP-dOpV2AxM1hC1Lc9wiw@mail.gmail.com>
 <Z-5hlL1Gk0oi4fX2@pks.im> <CA+rGoLfCTzNTcGXG5py6oHQazeE8Vj0fLsR4KUTJ6rSRFnT_Vw@mail.gmail.com>
 <CA+rGoLeRXUQu8ZbDtaLp2_YbVGA5D1DeA2vSEcLf74qXjB5U2A@mail.gmail.com> <CAOLa=ZQCTJLSWV-y-=nKf9J4xKr5miAo+35RktmbGmHPL4Sp-w@mail.gmail.com>
In-Reply-To: <CAOLa=ZQCTJLSWV-y-=nKf9J4xKr5miAo+35RktmbGmHPL4Sp-w@mail.gmail.com>
From: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Date: Sun, 6 Apr 2025 11:10:33 +0530
X-Gm-Features: ATxdqUFcM39BpkoHPO0i3eHBnnNc4lZ3c_H6i-S8yPm0CGLCS5iAg5yvKJ9GC9k
Message-ID: <CA+rGoLcDt0r0mDBk44SY0NcnG3mNBy5vSNBLzeggsGwJ4d-Cwg@mail.gmail.com>
Subject: Re: [GSOC] [Proposal v1] Machine-Readable Repository Information
 Query Tool
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, 
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 6, 2025 at 1:12=E2=80=AFAM Karthik Nayak <karthik.188@gmail.com=
> wrote:
>
> JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com> writes:
>
> > # Proposal for GSOC 2025 to Git
> > **Refactoring `git rev-parse`: A Dedicated Command for Repository Infor=
mation**
> >
> > ## Contact Details
> > * **Name**: K Jayatheerth
> > * **Email**: jayatheerthkulkarni2005@gmail.com
> > * **Blog**: [Blog](https://jayatheerthkulkarni.github.io/gsoc_blog/inde=
x.html)
> > * **GitHub**: [GitHub](https://github.com/jayatheerthkulkarni)
> >
> > ## Prerequisites & Experience
> >
> >
> > As part of the GSoC application prerequisites, I have engaged with the
> > Git community with a microproject involving documentation changes.
> > This provided valuable experience with Git's codebase, contribution
> > workflow (patch submission, feedback cycles), and communication via
> > the mailing list.
> >
> > * **Microproject Patch Series:** [Main mail
> > thread](https://lore.kernel.org/git/xmqqa59evffd.fsf@gitster.g/T/#t)
> > (Link to the most relevant thread demonstrating interaction and
> > successful patch refinement)
> > * **Initial Patch:** [First
> > Patch](https://lore.kernel.org/git/20250312081534.75536-1-jayatheerthku=
lkarni2005@gmail.com/t/#u)
> > * **Mailing List Introduction:** [First
> > Mail](https://lore.kernel.org/git/CA+rGoLc69R8qgbkYQiKoc2uweDwD10mxZXYF=
SY8xFs5eKSRVkA@mail.gmail.com/t/#u)
> > * **Blog:** My GSoC blog details these interactions:
> > [Blog](https://jayatheerthkulkarni.github.io/gsoc_blog/index.html)
> >
>
> It would be nice to give a small brief about your microproject here and
> perhaps its current status.
>

Sure I will add that.

> > ## **Synopsis**
> >
> > This project focuses on **refactoring Git by creating a dedicated
> > command (tentatively named `git repo-info`) to house the low-level
>
> I wonder if 'git info' itself would be a good name, we could default the
> command to list all prominent information about a repository. This would
> be useful instead of scripts invoking 'git rev-parse

Yeah even git info doesn't overlap with any builtin/third
party(popular commands) as far as I can search.

> --is-bare-repository' followed by a 'git rev-parse --is-inside-git-dir'
> and so on. But we can discuss this later.
>

True, but for the proposal I listed some commands in detail and
technical details with batch wise division of timeline as required.

> > repository, path, and format-related query options currently misplaced
> > under the "OPTIONS FOR FILES" section of `git-rev-parse(1)`**. This
> > new command will provide a more logical and maintainable location for
> > this functionality, allowing `git rev-parse` to better focus on its
> > core purpose of parsing revisions, thus improving Git's internal
> > organization and command structure clarity.
> >
> > ## **Benefits to the Community**
> >
> > ### **1. Improves `git rev-parse` Clarity and Maintainability**
> > - `git rev-parse` has accumulated various options unrelated to its
> > primary purpose of parsing revisions, particularly those for querying
> > low-level repository state and paths.
> > - This project **directly addresses this issue** by migrating these
> > options to a dedicated command, making `git rev-parse` cleaner and
> > easier to understand and maintain.
> > - Provides a **clearer separation of concerns** within Git's command su=
ite.
> >
> > ### **2. Provides Reliable Access for Automation and Scripting**
> > - Scripts often need fundamental repository information like the
> > top-level directory path (`--show-toplevel`), the `.git` directory
> > location (`--git-dir`), or repository state (`--is-bare-repository`).
> > - Currently, scripts rely on `git rev-parse` for this, mixing
> > low-level repo queries with revision parsing calls.
> > - The new `git repo-info` command will offer a **stable, dedicated
> > interface** for retrieving this specific low-level information, making
> > scripts **cleaner and more robust** by calling the command designed
> > explicitly for these tasks.
> > - The default output will mimic the **existing, simple text format**
> > of the `rev-parse` options, ensuring compatibility for scripts
> > migrating to the new command.
> >
> > ### **3. Enhances CI/CD Pipeline Foundations**
> > - CI/CD pipelines frequently need to establish context by determining
> > the repository root or `.git` directory location early in their
> > execution.
> > - Using the dedicated `git repo-info` command for these foundational
> > queries **simplifies the initial setup steps** in pipeline scripts
> > compared to using the overloaded `git rev-parse`.
> >
>
> We must note that using 'git rev-parse' isn't sub-optimal. Matter of
> fact, if you look at 'builtin/rev-parse.c', you'll see that each of
> these flags are under an if..else clause. The goal of this project is
> more to provide a clean interface and a home for such information
> queries.
>

I've gone through the code in rev-parse.c and yes I found the if blocks,
I'm taking that you mean that git rev-parse is not meant to do these
tasks, but it is good at what it does.
If this is the case I think it makes the project easier, because we
have to port similar code and test and document it carefully.

> As such the main goals of the project, are very design oriented, as
> you've also mentioned, I would say:
> 1. What should the command be called?
> 2. What sub-commands should it support?
> 3. What options from 'git-rev-parse(1)' do we need to port, do they need
>    to be renamed?
> 4. What other options can we possibly provide?
>

Yup, I think I've not explored the 3 -> do they need to be renamed?
Maybe, that's also because the list of commands to port is still a bit
ambiguous, we can discuss the internal names once we create a detailed
list of commands that we need to port into the `git info` command.

> > ## Deliverables
> >
> > Acknowledging the needs that the project scope is focused on
> > refactoring `git rev-parse`, this project will introduce a new Git
> > command, tentatively named `git repo-info`, serving as the designated
> > home for specific low-level query options.
> >
> > The key deliverables for this GSoC project include:
> >
> > 1. **New Core Command: `git repo-info`**
> > * A new `builtin/repo-info.c` command integrated into the Git source co=
de.
> > * Implementation primarily in C, leveraging existing internal Git APIs
> > and logic currently within `rev-parse.c` to implement the relocated
> > options.
> >
> > 2. **Relocated `rev-parse` Options:**
> > * Implementation of the core functionality behind the following
> > options from `git-rev-parse(1)`'s "OPTIONS FOR FILES" section within
> > the new `git repo-info` command:
> > * **Path Queries:** `--show-cdup`, `--show-prefix`, `--show-toplevel`,
> > `--show-superproject-working-tree`
> > * **Directory Queries:** `--git-dir`, `--git-common-dir`,
> > `--resolve-git-dir <path>`
> > * **State/Format Queries:** `--is-inside-git-dir`,
> > `--is-inside-work-tree`, `--is-bare-repository`,
> > `--is-shallow-repository`
> > * **Index File Query:** `--shared-index-path`
> >
>
> Perhaps we want to breakdown so we can have:
>
> git info path [--cdup | --prefix | --toplevel ... ]
> git info repo [--is-bare | --is-shallow]
>
> and so on...

Ok I will separate these with respect to their usage.

>
> > 3. **Default Output Format (Text-Based):**
> > * The command's default output for each implemented option will
> > **match the current plain text output** produced by `git rev-parse`
> > for that same option, ensuring backward compatibility for scripts
> > migrating to the new command. Output will primarily be via standard C
> > functions like `printf` or `puts`.
>
> Since we'll keep the existing options within 'git-rev-parse(1)', we'll
> stay backwards compatible. Scripts which want to move to the new
> command, would anyway need to change the command, so there is no
> backward compatibility there. But, having the default to be human
> readable like the current implementation does make sense.
>

Ok this raises a new question, if we are not looking towards backward
compatibility and also looking towards machine readability, I think
using JSON from the start would make things flexible, do correct me on
this.

Because once people start to make things compatible with human
readable text they probably won't use JSON again, and JSON might
mitigate some errors. So I think I need some feedback on this.

> >
> > 4. **Comprehensive Documentation:**
> > * A clear man page (`git-repo-info.adoc`) explaining the new command's
> > purpose and detailing the usage and output of each implemented option.
> > * Updates to `git-rev-parse.adoc` to clearly **deprecate** the
> > relocated options (or mark them as aliases for compatibility) and
> > point users to the new `git repo-info` command.
> >
> > 5. **Robust Test Suite:**
> > * A new test script (`t/tXXXX-repo-info.sh`) using Git's test
> > framework (`test-lib.sh`).
> > * Tests specifically validating the output of `git repo-info --option`
> > against the output of `git rev-parse --option` across various
> > repository states (standard repo, bare repo, inside `.git`, inside
> > worktree, submodules, shallow clone etc.) to ensure functional parity.
> >
> > 6. **(Stretch Goal / Potential Future Work): Structured Output**
> > * If time permits after successfully implementing, documenting, and
> > testing the core text-based functionality, investigate adding a
> > `--format=3Djson` option to provide a structured JSON output containing
> > the results of the requested queries. This is explicitly a secondary
> > goal, contingent on completing the primary refactoring task.
>
> Many of the plumbing commands in Git provide NUL-terminated output, I'm
> curious whether we should consider that over JSON.
>

I think we can use a flag to define what type of output we want in the
long term.
I think both of these have their own pros and cons. As I said I think
I need some feedback on the format.

> > **Out of Scope for GSoC (Based on Refined Goal):**
> > * Querying high-level metadata like current branch name, HEAD commit
> > details (beyond `--is-shallow-repository`), remote URLs, tags, or
> > arbitrary configuration values.
>
> We should make sure that we don't overload this new command too.
>

Agreed, I think for this GSOC I will largely focus on porting existing
flags in rev-parse to a new command.

> > * Complex status reporting (worktree dirtiness).
> > * Real-time monitoring or comparing metadata between revisions.
> > * Implementing JSON output as the *primary* feature.
> >

Even with revisioning, I think the above part comes up, I think I will
remove this from the proposal too, I think even this make the command
cluttered.

> > ## Technical Details
> >
> > This section outlines the proposed technical approach for implementing
> > the `git repo-info` command and relocating the specified options:
> >
> > 1. **Core `git repo-info` Command Implementation:**
> > * **Entry Point:** Create `builtin/repo-info.c` with
> > `cmd_repo_info(...)` function. Parse options using Git's
> > `parse-options` API.
> > * **Repository Context:** Utilize the standard `repo` structure and
> > `startup_info` provided by Git's infrastructure. Setup the repository
> > context similar to how `cmd_rev_parse` does it if needed (e.g., using
> > `setup_git_directory_gently`).
> > * **Reusing Logic:** Analyze the implementation of the target options
> > within `builtin/rev-parse.c`. Extract and adapt the relevant C
> > functions and logic (related to path manipulation using `prefix_path`,
> > `real_pathcmp`; repository state checks using
> > `is_bare_repository_cfg`, `is_inside_git_dir`, `is_inside_work_tree`;
> > accessing `startup_info`, `git_path`, etc.) into `builtin/repo-info.c`
> > or potentially shared helper functions if appropriate.
> > * **Specific Option Implementation:**
> > * `--show-toplevel`, `--show-cdup`, `--show-prefix`: Rely on the
> > `prefix` calculated during setup and path manipulation functions.
> > * `--git-dir`, `--git-common-dir`: Access `repo->gitdir`,
> > `repo->commondir` or use functions like `get_git_dir()`,
> > `get_common_dir()`. `--resolve-git-dir` will involve path resolution
> > relative to the provided argument.
> > * `--is-*` flags: Call existing helper functions like
> > `is_bare_repository_cfg()`, `is_inside_git_dir()`,
> > `is_inside_work_tree()`. `--is-shallow-repository` involves checking
> > `repo->is_shallow`.
> > * `--shared-index-path`: Access path information related to split
> > indexes if enabled.
> > * **Output Generation:** Use standard C `printf("%s\n", ...)` or
> > `puts(...)` to print the resulting string (path, "true"/"false", etc.)
> > to standard output, matching `rev-parse`'s current behavior. Boolean
> > flags typically exit `0` for true and `1` for false without output,
> > this behavior should be preserved.
> >
> > 2. **Documentation:**
> > * Create `Documentation/git-repo-info.adoc` using AsciiDoc format,
> > modeling it after existing man pages. Detail each option, its purpose,
> > and expected output.
> > * Modify `Documentation/git-rev-parse.adoc`, adding notes to the
> > relevant options indicating they are better handled by `git repo-info`
> > and potentially marking them for deprecation in a future Git version.
> >
> > 3. **Testing:**
> > * Create `t/tXXXX-repo-info.sh` using `test-lib.sh`.
> > * Structure tests using `test_expect_success` blocks.
> > * Utilize helper functions like `test_create_repo`, `cd repo`,
> > `test_cmp` to compare the output of `git repo-info --option` directly
> > against `git rev-parse --option` (for options producing output) or
> > against expected exit codes (for boolean flags).
> > * Cover edge cases like running outside a repository, in a bare
> > repository, deep within a worktree, within the `.git` directory, and
> > in repositories with submodules or worktrees.
> >
> > 4. **(Stretch Goal) JSON Output Implementation:**
> > * If attempted, add a `--format=3Djson` option using `parse-options`.
> > * Collect results from the requested options internally.
> > * Use either an approved embedded C JSON library or Git's `strbuf` API
> > (with helpers like `strbuf_add_json_string`) to construct a JSON
> > object mapping option names (or descriptive keys) to their
> > corresponding values. Print the final JSON string to standard output.
> > Add specific tests for JSON output validation.
> >
> > ## Detailed Project Timeline
> >
> > **Phase 0: Pre-Acceptance Preparation (April 9 - May 7, 2025)**
> >
> > * **Focus:** Demonstrate continued interest and deepen understanding
> > *specifically of `rev-parse`'s internals* while awaiting results.
> > * **Activities:**
> > * **(April 9 - April 21):** Deep dive into `builtin/rev-parse.c`,
> > identifying the exact code blocks implementing the "OPTIONS FOR
> > FILES". Trace how they use `startup_info`, `prefix`, path functions,
> > and repository flags.
> > * **(April 22 - May 7):** Continue monitoring the mailing list. Refine
> > understanding of Git's testing framework, specifically focusing on
> > tests for `rev-parse` options (e.g., `t1006-cat-file.sh`,
> > `t5601-clone.sh` might use some flags). Review contribution
> > guidelines.
> >
> > **Phase 1: Final Planning (May 8 - May 26, 2025 Approx.)**
> >
> > * **Focus:** Formal introductions, confirm final scope & plan, setup.
> > * **Activities:**
> > * **(Week 1: May 8 - May 12):** Introduction with mentor(s). Confirm
> > the exact list of `rev-parse` options to be migrated. Discuss the
> > preferred approach for handling deprecation in `rev-parse` docs/code.
> > Discuss potential for shared helper functions vs. direct code
> > migration.
> > * **(Week 2: May 13 - May 19):** Set up dev environment. Deep dive
> > into the agreed-upon functions/code blocks within `rev-parse.c`.
> > Outline the basic structure for `builtin/repo-info.c` and the test
> > script `t/tXXXX-repo-info.sh`.
> > * **(Week 3: May 20 - May 26):** Implement the basic `cmd_repo_info`
> > skeleton, option parsing setup, and repository setup boilerplate.
> > Write initial "no-op" tests. Post first blog update.
> >
> > **Phase 2: Implementation in Batches (Coding Weeks 1-8: May 27 - July
> > 21, 2025 Approx.)**
> >
> > * **Focus:** Implement options in logical groups, test thoroughly,
> > submit patches early and often.
> > * **GSoC Milestone:** Midterm Evaluations occur around Week 8.
> > * **Activities:**
> > * **(Batch 1 / Weeks 1-2: May 27 - June 9):** Implement basic path
> > queries: `--show-toplevel`, `--show-prefix`, `--show-cdup`. Add tests
> > comparing output with `rev-parse`. **Submit Patch Series 1**.
> > * **(Batch 2 / Weeks 3-4: June 10 - June 23):** Implement directory
> > queries: `--git-dir`, `--git-common-dir`, `--resolve-git-dir <path>`.
> > Add tests. **Submit Patch Series 2**. Write blog post update.
> > * **(Batch 3 / Weeks 5-6: June 24 - July 7):** Implement boolean state
> > queries: `--is-bare-repository`, `--is-inside-git-dir`,
> > `--is-inside-work-tree`. Add tests checking exit codes and behavior in
> > various locations. **Submit Patch Series 3**.
> > * **(Batch 4 / Weeks 7-8: July 8 - July 21):** Implement remaining
> > queries: `--is-shallow-repository`, `--shared-index-path`,
> > `--show-superproject-working-tree`. Add comprehensive tests covering
> > interactions (e.g., in submodules, shallow clones). **Submit Patch
> > Series 4**. Prepare for Midterm evaluation; ensure submitted batches
> > demonstrate core progress. Write blog post update.
> >
>
> It is nice to see breakdown in batches.
>

Thank you.

> > **Phase 3: Documentation & Final Polish (Coding Weeks 9-12: July 22 -
> > Aug 18, 2025 Approx.)**
> >
> > * **Focus:** Create documentation, address feedback on all patches,
> > refine implementation, potentially attempt stretch goal.
>
> I would say documentation should go hand-in-hand with each patch series
> that you send. Ideally every patch series should leave the code base in
> a usable state. Pushing documentation to the end, would mean that if the
> project is stopped midway, we'd have a running command in Git with no
> documentation about what it does.
>

Ok I think I will add them parallel to the batches above, nice point.

> > * **Activities:**
> > * **(Week 9: July 22 - July 28):** Write the first complete draft of
> > the man page for `git-repo-info`. Draft the necessary updates for
> > `git-rev-parse.adoc` (deprecation notices). **Submit Patch Series 5
> > (Documentation)**.
> > * **(Week 10: July 29 - Aug 4):** Focus on addressing review comments
> > on **all** previous patch series. Refactor code based on feedback.
> > Ensure test suite is robust and covers feedback points.
> > * **(Week 11: Aug 5 - Aug 11):** *Stretch Goal (Conditional):* If core
> > functionality and docs are stable and reviewed positively, begin
> > investigating/implementing `--format=3Djson`. Add specific JSON tests i=
f
> > implemented. Otherwise, focus on further code cleanup and test
> > hardening.
> > * **(Week 12: Aug 12 - Aug 18):** Prepare and submit final versions of
> > all patch series, incorporating all feedback. Final testing pass.
> > Write blog post update summarizing progress and final state. Code
> > freeze for final evaluation.
> >
> > **Phase 4: Final Evaluation & Wrap-up (Aug 19 - Nov 19, 2025)**
> >
> > * **Focus:** Final submissions, respond to late feedback, ensure
> > project completion.
> > * **Official GSoC Milestone:** November 19, 2025 - Program End Date.
> > * **Activities:**
> > * **(Late Aug - Sept):** Submit final GSoC evaluations. Actively
> > respond to any further comments on submitted patches from the
> > community/maintainers, aiming for merge readiness.
> > * **(Oct - Nov 19):** Monitor mailing list for patch status. Write
> > final GSoC project summary blog post. Continue engaging with the
> > community if interested in further contributions beyond GSoC.
> >
> >
> >
> > Thank You,
> > Jayatheerth
>
> Thanks for your proposal!
>
> - Karthik

Thank you again Karthik, will send the updated proposal in this thread soon=
.

-Jayatheerth

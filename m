Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D0CBE65
	for <git@vger.kernel.org>; Sun,  6 Apr 2025 06:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743919788; cv=none; b=J95zWOik6grH+RiYha5XukbH0hceWtlYcQekhUxLogb2hzpz0+lgG1hBlnfRXsQrky0L03i+G7xQQTjElGD0U1o9ApLp/HF9+3YlAHWkoy241Oo31BQFepXj0zl6+PmUmBGMExoY1kuZ4ptRw6C7PFDjk/WV5lb2fChemBJL/Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743919788; c=relaxed/simple;
	bh=iGWfUrXefWkaw3hDtabzw7/d/IsxQY7NrkEf8GwtX4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UxEwf2MAy7w4Sv8Cial10doQJHebO90Xcg09KQwhWiVmmc1tmTodIS5c8OMF6TQqtEY21FLqGZS561HASwXPB0nftewtytX0TzWDlyBAaKEaNSO9lI8crB/Sa+sLPImuInPdOjbwcUW3DDxT1924ibiL0q3mcCxLTDRJScsREkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PKRLgVUQ; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PKRLgVUQ"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c56a3def84so320428385a.0
        for <git@vger.kernel.org>; Sat, 05 Apr 2025 23:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743919784; x=1744524584; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iGWfUrXefWkaw3hDtabzw7/d/IsxQY7NrkEf8GwtX4k=;
        b=PKRLgVUQiarh7mJ1U3QF/FEI/T61uhzMqkLEncIZtL3ngyQANOdhaAUP2hT4cLxAFP
         MtFazihOBx/akXj7r9udgLEp+7AEeWRYmL6VPnpjkS3GfV9/ex8JwDnZGHAhJKkQKlPj
         0aPH59e7eU4r8Q+D5PCcXryHdJkRBEXlnVTfxEjiJuK3TPahPhjOq1NsUqnp1YIRuTJX
         3kjcvhB5Xeiii2EmWV7tMN5aeJJJpqkyq2Eb6X3/KS1dqvv7f8Ld/E5vlOARbEXGFOoo
         yMZtC+U+8q+GEqjYxX0DnEAvx2K9yQaGtAe5YeYGOMddzFyjLFa5Qiq7KhzicA/FNXDS
         CFWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743919784; x=1744524584;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iGWfUrXefWkaw3hDtabzw7/d/IsxQY7NrkEf8GwtX4k=;
        b=MwLefnaoI1hTq+V0Uy0y76GMGI6CM4l/84nhjYkCKne3xbeEv820XtCgktaGiNb0YJ
         LFlhcIqlDKJOY2eKgcLPLsWWtV52biBJt8DtEjUiPErCQ1p8XZ53jBIcUQP5UqFg4JJf
         A+7PImkeY3LY7x8GJe64FcYTtc4RoT/pK88WvMENCp7XEyJGVsVHUXMJ9/yfaYss19Nu
         WY+oTeJhTFNAlH5PIxHVjoP2sQZ9kF5wgxAQDQ0GvyfD70EMZQt7adRECqR9i6CeHWb/
         Q8VR0iOQISWa4a8MqSM+PYdX47l7ntISNPiZ7+aQKG3HpP43CtuhiP2o9qEFTCABgU2c
         s/pQ==
X-Forwarded-Encrypted: i=1; AJvYcCUA/2wJKqQh9p8krD58diBpBk+E260CYO0u1mplhwgHH7e3iOFoC+eZPqe3BTq+WlGpfbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrEydNYS0OPfYdOGt3B0Ra4BlZgFWA2B8enukQoZhnda2eoUAK
	RRfk2NSWdOEo4g5XV8VGKInO+c5YVkmx3t9PLnZJP/r8+qudwmUXWE7y/bAsvPnIop7nQXCUKXC
	zaxWKugoognBOYImnR+Gv+tkf2cvK29v3
X-Gm-Gg: ASbGncuFUHQbydtyrOJdf6JbM0VWTJNvRAS/Ww7QVAClD4D6rtfinMAExn+LsfnrSlg
	5OxRUT5rtpzXDevqK9+cFwKik2/vZs3HJHYd3xsvtcy0M8vAxrsBSeFL07eOhkg08cXS/wlMDff
	3M05dUO7l6g5bls4RIkcb08jg0MzaEkKRRQ1BRYjrqZ+DpTp38mJ1r71rzIQ8=
X-Google-Smtp-Source: AGHT+IG9GND7sjLk1SF6DRMv3VLQQxdi2tqXKgfWEplQMIyx0b/Z2tBYuHe3FJTSIGkyFefVRV4Sz3jn0XHXVUSopAE=
X-Received: by 2002:a05:620a:2456:b0:7c5:a542:10f with SMTP id
 af79cd13be357-7c77ddeb4efmr765821585a.35.1743919783754; Sat, 05 Apr 2025
 23:09:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+rGoLfxZHdns=7FwQuYS=JANrR9zDP-dOpV2AxM1hC1Lc9wiw@mail.gmail.com>
 <Z-5hlL1Gk0oi4fX2@pks.im> <CA+rGoLfCTzNTcGXG5py6oHQazeE8Vj0fLsR4KUTJ6rSRFnT_Vw@mail.gmail.com>
 <CA+rGoLeRXUQu8ZbDtaLp2_YbVGA5D1DeA2vSEcLf74qXjB5U2A@mail.gmail.com>
 <CAOLa=ZQCTJLSWV-y-=nKf9J4xKr5miAo+35RktmbGmHPL4Sp-w@mail.gmail.com> <CA+rGoLcDt0r0mDBk44SY0NcnG3mNBy5vSNBLzeggsGwJ4d-Cwg@mail.gmail.com>
In-Reply-To: <CA+rGoLcDt0r0mDBk44SY0NcnG3mNBy5vSNBLzeggsGwJ4d-Cwg@mail.gmail.com>
From: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Date: Sun, 6 Apr 2025 11:39:32 +0530
X-Gm-Features: ATxdqUE8BTKHLW7tN2NGUWTITGL0h5NxZQ5zec3KSr8SLE2caFW9wI6WOIjDXaM
Message-ID: <CA+rGoLc9g4werz-k4_ZzfNLLGHjzHoOcFYSmV5V-Krq04drgZA@mail.gmail.com>
Subject: Re: [GSOC] [Proposal v1] Machine-Readable Repository Information
 Query Tool
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, 
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Content-Type: text/plain; charset="UTF-8"

# Proposal for GSOC 2025 to Git
**Machine-Readable Repository Information Query Tool**

## Contact Details
* **Name**: K Jayatheerth
* **Email**: jayatheerthkulkarni2005@gmail.com
* **Blog**: [Blog](https://jayatheerthkulkarni.github.io/gsoc_blog/index.html)
* **GitHub**: [GitHub](https://github.com/jayatheerthkulkarni)

## Prerequisites & Experience


As part of the GSoC application prerequisites, I have engaged with the
Git community and initiated a microproject. This involved **updating
documentation for `MyFirstContribution.adoc` and update it with modern
codebase**, providing valuable experience with Git's codebase
structure (documentation files), the contribution workflow (patch
submission using `git send-email`, addressing feedback across
versions), and communication via the mailing list.

* **Microproject Status:** v4 submitted, incorporating feedback,
awaiting further review.
* **Microproject Patch Series:** [Main mail
thread](https://lore.kernel.org/git/xmqqa59evffd.fsf@gitster.g/T/#t)
(Link to the most relevant thread demonstrating interaction and
successful patch refinement)
* **Initial Patch:** [First
Patch](https://lore.kernel.org/git/20250312081534.75536-1-jayatheerthkulkarni2005@gmail.com/t/#u)
* **Mailing List Introduction:** [First
Mail](https://lore.kernel.org/git/CA+rGoLc69R8qgbkYQiKoc2uweDwD10mxZXYFSY8xFs5eKSRVkA@mail.gmail.com/t/#u)
* **Blog:** My GSoC blog details these interactions:
[Blog](https://jayatheerthkulkarni.github.io/gsoc_blog/index.html)

## **Synopsis**

This project focuses on **refactoring Git by creating a dedicated
command (tentatively named `git info`, subject to further discussion)
to house the low-level repository, path, and format-related query
options currently misplaced under the "OPTIONS FOR FILES" section of
`git-rev-parse(1)`**. This new command, potentially using a subcommand
structure (e.g., `git info path`, `git info repo`), will provide a
more logical and maintainable location for this functionality. This
allows `git rev-parse` to better focus on its core purpose of parsing
revisions, ultimately improving Git's internal organization and
command structure clarity by offering a **cleaner interface** for
these specific queries.

## **Benefits to the Community**

### **1. Improves `git rev-parse` Clarity and Maintainability**
- `git rev-parse` has accumulated various options unrelated to its
primary purpose of parsing revisions, particularly those for querying
low-level repository state and paths.
- This project **directly addresses this issue** by migrating these
options to a dedicated, purpose-built command, making `git rev-parse`
cleaner and easier to understand and maintain.
- Provides a **clearer separation of concerns** within Git's command suite.

### **2. Provides Reliable Access for Automation and Scripting**
- Scripts often need fundamental repository information like the
top-level directory path, the `.git` directory location, or repository
state.
- Currently, scripts rely on `git rev-parse` for this, invoking it for
tasks outside its core revision-parsing role.
- The new `git info` command will offer a **stable, dedicated, and
cleaner interface** for retrieving this specific low-level
information, making scripts **more robust and readable** by calling
the command designed explicitly for these tasks.



## Deliverables

This project will introduce a new Git command, **tentatively named
`git info`**, serving as the designated home for specific low-level
query options migrated from `git rev-parse`. The implementation will
likely adopt a **subcommand structure**.

The key deliverables for this GSoC project include:

1. **New Core Command: `git info` with Subcommands**
* A new `builtin/info.c` command integrated into the Git source code.
* Implementation primarily in C, using `parse-options` to handle
**subcommands** (e.g., `path`, `repo`, `misc`) and their specific
options.
* Leverages existing internal Git APIs and logic currently within `rev-parse.c`.

2. **Relocated `rev-parse` Options under Subcommands:**
* Implementation of the core functionality behind selected options
from `git-rev-parse(1)`'s "OPTIONS FOR FILES" section, organized under
appropriate subcommands within `git info`. *(Specific options and
subcommand grouping subject to final confirmation with mentor)*:
* **`git info path ...` (Example Grouping):**
* `--show-cdup` -> `git info path --cdup` (or similar)
* `--show-prefix` -> `git info path --prefix`
* `--show-toplevel` -> `git info path --toplevel`
* `--show-superproject-working-tree` -> `git info path --superproject-worktree`
* **`git info repo ...` (Example Grouping):**
* `--git-dir` -> `git info repo --git-dir`
* `--git-common-dir` -> `git info repo --common-dir`
* `--resolve-git-dir <path>` -> `git info repo --resolve-dir <path>`
* `--is-bare-repository` -> `git info repo --is-bare`
* `--is-shallow-repository` -> `git info repo --is-shallow`
* **`git info misc ...` (Example Grouping for others):**
* `--is-inside-git-dir` -> `git info misc --inside-gitdir`
* `--is-inside-work-tree` -> `git info misc --inside-worktree`
* `--shared-index-path` -> `git info misc --shared-index-path`
* *(Design Consideration):* Option names within subcommands might be
slightly adjusted for clarity/consistency (e.g., dropping "show-").

3. **Multiple Output Formats:**
* **Default Text Output:** The default output for each implemented
option will be simple, human-readable text, **matching the semantics
and format** produced by the corresponding `git rev-parse` option
(e.g., printing a path string, "true"/"false", or exiting with status
0/1 for boolean checks).
* **NUL Termination (`-z`):** Implement a `-z` option (standard across
many Git plumbing commands) for unambiguous, newline-safe output
suitable for scripting, particularly for path-related options.
* **JSON Output (`--json`):** Implement a `--json` option to provide
structured output, mapping query keys (derived from options) to their
values. This offers maximum flexibility for tools consuming the
information. *(The relative priority and implementation details of
`-z` vs `--json` to be discussed with mentor, but both are considered
core deliverables)*.

4. **Comprehensive Documentation (Incremental):**
* A clear man page (`git-info.adoc`) explaining the new command's
purpose, the subcommand structure, and detailing the usage, options
(including `-z`, `--json`), and output formats for each implemented
feature. **Relevant sections of the man page will be added or updated
within each patch series submitted.**
* Updates to `git-rev-parse.adoc` to clearly **document the
relationship** with `git info` for the migrated options (e.g., noting
that `git info` is the preferred command) and potentially marking them
for deprecation. **These updates will also be included incrementally
with relevant patch series.**

5. **Robust Test Suite (Incremental):**
* A new test script (`t/tXXXX-info.sh`) using Git's test framework
(`test-lib.sh`).
* Tests covering the subcommand structure, each implemented option,
and **all output formats** (`text`, `-z`, `--json`).
* Tests validating behavior across various repository states
(standard, bare, inside `.git`, inside worktree, submodules, shallow
clone etc.). **New tests will be added within each patch series for
the features implemented.**


## Technical Details


1. **Core `git info` Command Implementation:**
* **Entry Point:** Create `builtin/info.c` with `cmd_info(...)`. Use
`parse-options` to parse the **subcommand** first. Based on the
subcommand, invoke a specific helper function (e.g.,
`cmd_info_path()`, `cmd_info_repo()`) which then uses `parse-options`
again to handle the options specific to that subcommand.
* **Repository Context:** Standard setup using `repo` structure,
`startup_info`, and potentially `setup_git_directory_gently`.
* **Reusing Logic:** Adapt logic from `builtin/rev-parse.c` for the
core functionality of each option. This might involve direct code
migration or creating shared helper functions where appropriate.
* **Subcommand Implementation:** Implement helper functions for each
subcommand (`path`, `repo`, `misc`) containing the `parse_options`
calls and logic for the options within that group.
* **Output Generation:**
* **Text (Default):** Use `printf("%s\n", ...)` / `puts(...)` for
string output; print "true"/"false" or use `exit(0)` / `exit(1)` for
boolean checks, mimicking `rev-parse`.
* **NUL (`-z`):** Use `putchar('\0')` or `fwrite(..., 1, 1, stdout)`
instead of newline for string output when `-z` is active. Boolean
checks likely remain exit-code based.
* **JSON (`--json`):** Collect results internally. Use Git's `strbuf`
API (with `strbuf_add_json_string` etc.) or potentially an approved C
JSON library to construct and print a JSON object mapping keys to
values. All requested info within a single invocation should ideally
be combined into one JSON object.

2. **Documentation:**
* Create `Documentation/git-info.adoc`. Structure based on
subcommands. Detail each subcommand and its options, including `-z`
and `--json` behavior.
* Modify `Documentation/git-rev-parse.adoc` to add cross-references
for relevant options.
* **Documentation updates will accompany the code changes in each
patch series.**

3. **Testing:**
* Create `t/tXXXX-info.sh`.
* Use `test_expect_success` with helpers like `test_create_repo`,
`test_cmp`, `test_must_fail`.
* Add tests for:
* Correct subcommand parsing and error handling.
* Each option under its subcommand, comparing **text output** against
`rev-parse` (where applicable) or expected values/exit codes.
* **`-z` output** using appropriate comparison methods (e.g., piping
to `tr '\\0' '\\n'`).
* **`--json` output** using tools like `jq` (if available in test env)
or careful `grep`/`sed` checks for structure and values.
* **Tests will be added incrementally with the features in each patch series.**

## Detailed Project Timeline


**Phase 0: Pre-Acceptance Preparation (April 9 - May 7, 2025)**
*

**Phase 1: Community Bonding & Final Planning (May 8 - May 26, 2025 Approx.)**
* **Focus:** Formal introductions, finalize scope, agree on command
structure, setup.
* **Activities:**
* **(Week 1: May 8 - May 12):** Discuss proposal with mentor(s). Finalize:
* Command name (`git info` or alternative).
* Subcommand structure and grouping of options.
* Exact list of options to port, and any necessary renaming within subcommands.
* Approach for handling relationship with `rev-parse` (deprecation vs.
aliasing vs. simple documentation cross-link).
* Prioritization/approach for implementing `-z` and `--json`.
* **(Week 2: May 13 - May 19):** Set up dev environment. Deep dive
into agreed-upon code blocks in `rev-parse.c`. Outline
`builtin/info.c` structure including subcommand handlers. Outline
initial test script `t/tXXXX-info.sh`.
* **(Week 3: May 20 - May 26):** Implement basic `cmd_info` skeleton,
top-level subcommand parsing, repository setup. Implement one simple
subcommand handler (e.g., `cmd_info_path`) with basic option parsing
structure. Write initial "no-op" / basic structure tests. Post first
blog update.

**Phase 2: Implementation in Batches (Coding Weeks 1-8: May 27 - July
21, 2025 Approx.)**
* **Focus:** Implement options within subcommands, including
documentation and tests for text output first, then potentially add
machine-readable formats. Submit patches early and often.
* **GSoC Milestone:** Midterm Evaluations occur around Week 8.
* **Activities:** *(Structure assumes implementing text output first,
then `-z`/`--json` later in the phase)*
* **(Batch 1 / Weeks 1-2: May 27 - June 9):** Implement `path`
subcommand options (`--toplevel`, `--prefix`, `--cdup`). Implement
**text output**. Add corresponding **tests** and **documentation**
snippets (for `git-info.adoc` and `git-rev-parse.adoc`). **Submit
Patch Series 1**.
* **(Batch 2 / Weeks 3-4: June 10 - June 23):** Implement `repo`
subcommand options (`--git-dir`, `--common-dir`, `--resolve-dir`,
`--is-bare`). Implement **text output**. Add **tests** and
**documentation** snippets. **Submit Patch Series 2**. Write blog post
update.
* **(Batch 3 / Weeks 5-6: June 24 - July 7):** Implement remaining
`repo` (`--is-shallow`) and `misc` subcommand options
(`--inside-gitdir`, `--inside-worktree`, `--shared-index-path`,
`--superproject-worktree` - *adjust subcommand grouping based on final
plan*). Implement **text output**. Add **tests** and
**documentation**. **Submit Patch Series 3**.
* **(Batch 4 / Weeks 7-8: July 8 - July 21):** Implement **`-z` and
`--json` output formats** for all options added in Batches 1-3. Add
comprehensive **tests** for these formats. Update **documentation** to
fully describe `-z` and `--json` behavior. **Submit Patch Series 4**.
Prepare for Midterm evaluation; ensure submitted batches show
substantial progress on core functionality and formats. Write blog
post update.

**Phase 3: Refinement & Final Polish (Coding Weeks 9-12: July 22 - Aug
18, 2025 Approx.)**
* **Focus:** Address feedback on all patches, ensure robustness,
finalize documentation consistency.
* **Activities:**
* **(Week 9: July 22 - July 28):** Focus on addressing review comments
on **all** previous patch series (Code, Tests, Docs). Refactor based
on feedback.
* **(Week 10: July 29 - Aug 4):** Continue addressing feedback. Ensure
the test suite is robust, covers edge cases identified in reviews.
Perform thorough documentation review for consistency and clarity
across the entire man page.
* **(Week 11: Aug 5 - Aug 11):** Final code cleanup. Final pass on
test coverage. *(Stretch Goal Idea):* If all core work is stable and
time permits, potentially explore adding one or two *new*, simple,
agreed-upon repo info queries (not from `rev-parse`) that fit the
command's purpose.
* **(Week 12: Aug 12 - Aug 18):** Prepare and submit final versions of
all patch series, incorporating all feedback. Final self-testing.
Write blog post update summarizing progress and final state. Code
freeze for final evaluation.

**Phase 4: Final Evaluation & Wrap-up (Aug 19 - Nov 19, 2025)**
* Write final GSoC project summary blog post. Continue engaging with
the community in further contributions beyond GSoC.
Thank You,
Jayatheerth

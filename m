Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C32F21420E
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 14:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743432701; cv=none; b=QMcVTgV2vIer23HGai8M6Oxqg04qNVO6Do/wTrma3lQ16RHM2F7pF6C6u8lZi6CZCdVqQfVRoCsxubNpAV7lOkPekkp9dg7G8LXXihSpZOomIcXXz/QomKA7oNmvXzDsEK9LUGdi8wVu0QTdKmW2/yGVKRSYUpsOEUlYWqYGd/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743432701; c=relaxed/simple;
	bh=pPnybMd/IfxpsQ46BwotV2Ej9hWkr4JSwvZbPUYH18A=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=PFtj3qQWNDVetNCc6W0hTxzYVT74HNsR5MZZqr28zptECkDxZabRqvRLeEcMG7qoPAmRl0yZq32dQBJWWmozZc+mRGlNScH4oDMl5+NFtc0+dIzQpNpQ1rUVvzhbOmvd8kli42lmYAJTChrsUzwyOP8H8qRFdKIh3EVXsYpiRo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d807Q4N5; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d807Q4N5"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4769b16d4fbso25196041cf.2
        for <git@vger.kernel.org>; Mon, 31 Mar 2025 07:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743432698; x=1744037498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pPnybMd/IfxpsQ46BwotV2Ej9hWkr4JSwvZbPUYH18A=;
        b=d807Q4N50j3GZNcWZ02WPvXvtRGnkIY6ONZljimBZtpu98l62/XE1KX8qIxvafirdi
         J7sOXEyjG899kcGbB+0HmNnRw5mq4z0coIDmF8NjQO7bDSD/hX12Z0VnfoiDtrEbcqvn
         IVWYmQ2vKsb6K2sZl7jfLSG55k109F9xBemeCe4uG5sLkgDmKw1oTotDhmaxEwN/lkq8
         puu/PlijBkNvb/u3AnthL3YA2KX1gaVgI82xASgJ62Q9vl6z15tfFpnRlhuZMDG0BGyS
         BHxGuUaphQNiiyH9hx5wOU6MOIVRaqCu9zKPRlC9Sd4dQY8RbzdaIEOt+EJsIz9XfwY9
         yJsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743432698; x=1744037498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pPnybMd/IfxpsQ46BwotV2Ej9hWkr4JSwvZbPUYH18A=;
        b=VG8L+F7mExhQ4fu7SxsHVUKcmLZPySwQZMX5jAL7Wa6XRrfSw9id8XI7JbkXgF+32w
         UUi4NEAzVLlckoLBREqOj1w7XstuMoxr32QhQcf5V1uJeMWv6i0kXuy0DwSyATyrFcT/
         1V7PYFN1JZlwvlV7LCEMTHozMhmc4Z1GzgocHCopd5EkbigF3GKyZd3pGLrqN0V2AOZw
         Hyus69SRgQpa2flyDTSQqhvslx3OixVTlp9kIt0MWu6n9jJKAV5hNdgZ+IrYniRrhMWu
         tLSz8dyUFZ6hAQp1L2vpHg7f9hhS05OjOyGiVDDWT1j2BLeAACkQVltlP/9lH1v/xkuK
         P4IA==
X-Gm-Message-State: AOJu0YzAmLKFuH+vMaLfffjNzWQt2wk1Cu1TNVrUOcOOQnXTXLKrfTMn
	0EuTyDLUoyA4YDPZ+77ZgyWiqQU5QTtmzQa6glsvEcJ+JxtvmAQw0ZNjlfyTLG3J9Ch4MTuZFys
	h1p9Ncq6N0EwfzhvYYjrTObpfwwavES8G
X-Gm-Gg: ASbGncvcKG0/BhX4KRwUTg9U5vhnu8Kep1mHRc6VaOaw00Uywh4+BTAUDu2p/ARjwmq
	jrPuVoqrETfv7x/GRL8UPvvRMDHe5Ntptzm0BMKrah4F//m0aVXaDf2zNE5ChqFmy7+Zt3oAwEU
	sglQiG8gK8SUI5jtZ2xiP3fvAlTyScJzEDRtYv8BsHDK7FAK0vLxgXWmFqMjwzHLFDJhf4Wg==
X-Google-Smtp-Source: AGHT+IHzyG+JYMWU9oNKUtm7xPkjuqU4Pk6FlALGon2i4j+yXvFX4AAzlVhVwWEkiX3ioSnuf8b3NmKRxUBE60ONQKs=
X-Received: by 2002:a05:622a:5c6:b0:476:639e:ede0 with SMTP id
 d75a77b69052e-477ed7fce88mr120428421cf.26.1743432698113; Mon, 31 Mar 2025
 07:51:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Date: Mon, 31 Mar 2025 20:21:27 +0530
X-Gm-Features: AQ5f1JrjZbYD4p2n6rYnpRWAPP5WaPSXicA-MPw883hYGltlGXRfckIxSxyISks
Message-ID: <CA+rGoLfxZHdns=7FwQuYS=JANrR9zDP-dOpV2AxM1hC1Lc9wiw@mail.gmail.com>
Subject: [GSOC] [Proposal v1] Machine-Readable Repository Information Query Tool
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, karthik nayak <karthik.188@gmail.com>, 
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>, 
	JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

# Proposal for GSOC 2025 to Git
**Machine-Readable Repository Information Query Tool**

## Contact Details
* **Name**: K Jayatheerth
* **Email**: jayatheerthkulkarni2005@gmail.com
* **Blog**: [Blog](https://jayatheerthkulkarni.github.io/gsoc_blog/index.ht=
ml)
* **GitHub**: [GitHub](https://github.com/jayatheerthkulkarni)

## **Synopsis**
This project aims to develop a dedicated Git command that interfaces
with Git=E2=80=99s internal APIs to produce structured JSON output,
particularly for repository metadata. By offering a clean,
machine-readable format, this tool will improve automation, scripting,
and integration with other developer tools.

## **Benefits to the Community**
### **1. Simplifies Automation and Scripting**
- Many Git commands output **human-readable text**, making automation
**error-prone** and **dependent on fragile parsing**.
- This project introduces **structured JSON output**, allowing scripts
and tools to consume repository metadata **directly and reliably**.
- No more **awkward text parsing**, `grep` hacks, or brittle `awk/sed`
pipelines=E2=80=94just **clean, structured data**.

### **2. Eliminates the Overuse of `git rev-parse`**
- `git rev-parse` is widely misused for extracting metadata, despite
being intended primarily for **parsing revisions**.
- Developers often **repurpose** it because there=E2=80=99s **no dedicated
alternative** for metadata queries.
- This project **corrects that gap** by introducing a **purpose-built
command** that is **cleaner, more intuitive, and extensible**.

### **3. Optimizes CI/CD Pipelines**
- CI/CD systems currently need **multiple Git commands** and
associated parsing logic to fetch basic metadata:

```bash
# Example: Gathering just a few common pieces of info
BRANCH=3D$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "DETACHED")
COMMIT=3D$(git rev-parse HEAD)
REMOTE_URL=3D$(git remote get-url origin 2>/dev/null || echo "no-origin")
# ... often requiring more commands and error handling logic.
```
- The proposed command aims to **replace these multiple calls** with a
**single, efficient query** returning comprehensive, structured JSON
data.
- This **simplifies pipeline scripts**, reduces process overhead, and
makes CI/CD configurations **cleaner and more robust**.

## Deliverables

This project will introduce a new Git command, tentatively named `git
metadata`, to provide reliable, machine-readable repository
information.

The key deliverables for this GSoC project include:

1. **Core `git metadata` Command:**
* A new `builtin/metadata.c` command integrated into the Git source code.
* Implementation primarily in C, utilizing existing internal Git APIs
for retrieving repository information efficiently and accurately.

2. **Default JSON Output:**
* The command will output a structured JSON object by default.
* **Initial Core Fields:**
* `repository`: Path to `.git` directory, worktree root, `is_bare` status.
* `head`: Current commit SHA (full), current reference
(`refs/heads/main`, `refs/tags/v1.0`, or detached HEAD commit), short
symbolic name (`main`, `v1.0`, or `DETACHED`).
* `remotes`: A map of remote names to their fetch and push URLs.
* *(Stretch Goal):* Basic `is_dirty` flag based on a quick index/HEAD
check (not full worktree scan).

3. **Basic Output Control:**
* *(If time permits / Stretch Goal)* Implement simple flags to control
output, e.g.:
* `--remotes-only`: Output only the `remotes` section of the JSON.
* `--head-only`: Output only the `head` section.
* `--json-errors`: Ensure that errors encountered during execution
(e.g., not in a Git repository) are reported in a structured JSON
format.

4. **Extensible Design:**
* The internal structure and JSON schema will be designed with future
extensions in mind (e.g., adding submodule info, specific config
values, tags later).

5. **Comprehensive Documentation:**
* A clear man page (`git-metadata.txt`) explaining the command's
purpose, usage, options, and JSON output format.
* Comments within the code explaining implementation details.

6. **Robust Test Suite:**
* A new test script (`t/tXXXX-metadata.sh`) using Git's test framework.
* Tests covering various repository states: standard repo, bare repo,
detached HEAD, unborn branch, repo with no remotes, etc.
* Tests validating the JSON output structure and content.

**Out of Scope for GSoC (Potential Future Work):**
* Complex status reporting (full `git status` equivalent, detailed
submodule status).
* Real-time monitoring (`--watch`).
* Comparing metadata between revisions (`--diff`).
* Alternative output formats (`--format=3Dshell`).
* Querying arbitrary configuration values or extensive commit details
beyond HEAD.

## Technical Details

This section outlines the proposed technical approach for implementing
the core deliverables:

1. **Core `git metadata` Command & Default JSON Output:**
* **Entry Point:** Implement the command logic within a new
`builtin/metadata.c` file, defining the `cmd_metadata(...)` function
as the entry point, following Git's builtin command structure.
* **Repository Access:** The `cmd_metadata` function will operate on
the `struct repository*` provided by the command invocation
infrastructure.
* **Repository Info:**
* Retrieve the path to the `.git` directory using `repo->gitdir` (or
`get_git_dir()` if needed).
* Determine if the repository is bare using `repo->is_bare`.
* **HEAD Info:**
* Resolve the `HEAD` reference using `refs_resolve_ref_unsafe("HEAD",
RESOLVE_REF_READING, &head_oid, &head_ref_name, &head_flags)`. This
will provide the full commit OID (`head_oid`) and the full reference
name (`head_ref_name`, e.g., `"refs/heads/main"`).
* Determine the conventional short symbolic name (e.g., `"main"`,
`"v1.0"`, or `"(HEAD detached at <sha>)"`) by investigating and
utilizing existing Git functions like `refs_shorten_unambiguous_ref()`
or similar logic found in commands like `git status` or `git branch`.
Using low-level string functions like `strchr` will be avoided for
robustness.
* **Remotes Info:**
* Utilize functions from `remote.h`/`remote.c` (e.g., `remote_get`,
iterate through configured remotes) to get the list of remote names.
* For each remote, query its fetch and push URLs using Git's
configuration API (e.g., `git_config_get_string` for keys like
`remote.<name>.url` and `remote.<name>.pushurl`). Handle cases where
push URL is not explicitly set.
* **JSON Generation:**
* *(Primary Strategy):* Investigate integrating a minimal,
dependency-free, GPLv2-compatible C JSON library (e.g., cJSON, subject
to community approval) for robust JSON construction and escaping.
* *(Fallback Strategy):* If a library is not feasible, manually
construct the JSON string using Git's `strbuf` API (`strbuf_addf`,
`strbuf_addch`, `strbuf_add_json_string`, etc.), paying careful
attention to correct JSON syntax and proper escaping of string values.

2. **Documentation:**
* Create `Documentation/git-metadata.txt` following the structure and
style of existing Git man pages (e.g., `git-rev-parse.txt`,
`git-branch.txt`).
* Clearly document the command's purpose, all options (including
stretch goals if implemented), and provide a detailed description of
the default JSON output schema with examples.

3. **Testing:**
* Create a new test script `t/tXXXX-metadata.sh` using Git's
shell-based test framework (`test-lib.sh`).
* Include test cases covering:
* Standard repositories.
* Bare repositories.
* Repositories with detached HEAD state.
* Repositories on an unborn branch.
* Repositories with no remotes, one remote, multiple remotes.
* Remotes with different fetch/push URL configurations.
* Validation of the JSON output structure and specific field values
using tools like `jq` or simple `grep` checks within the tests.
* Testing of error conditions and the `--json-errors` flag output (if
implemented).

## Detailed Project Timeline


**Phase 0: Pre-Acceptance Preparation (April 9 - May 7, 2025)**

* **Focus:** Demonstrate continued interest and deepen understanding
while awaiting results.
* **Official GSoC Milestone:** April 8, 2025 - Proposal Deadline.
* **Activities:**
* **(April 9 - April 21):** Deep dive into Git's source code
structure, focusing specifically on areas identified in the proposal's
Technical Details:
* `builtin/` directory structure and command handling.
* `repository.h`, `refs.h`, `remote.h`, `config.c`, `strbuf.h`.
* How existing commands like `git status`, `git branch`, `git
rev-parse`, `git remote -v` access underlying data.
* **(April 22 - May 7):**
* Monitor the Git mailing list for discussions related to repository
information, command output formats, or JSON usage.
* Refine understanding of Git's testing framework as I've not done a
deep dive into tests(`t/test-lib.sh`). Try running and understanding
existing tests relevant to refs, remotes, or configuration.
* Review Git's contribution guidelines (`SubmittingPatches`, coding
style) again since most of my microproject time was related to
documentation.
* Try to start some more microprojects or actively converse in other patche=
s.

**Phase 1: Finalize the requirements (May 8 - May 26, 2025 Approx.)**

* **Focus:** Finalize plans with mentors, setup, deep dive into specifics.
* **Official GSoC Milestone:** May 8, 2025 - Accepted Projects Announced.
* **Activities:**
* **(Week 1: May 8 - May 12):**
* Discuss the project proposal in detail, clarifying scope,
priorities, and mentor expectations.
* Finalize the decision on the JSON generation strategy (library vs.
`strbuf`) based on mentor feedback and feasibility assessment.
* Confirm the initial target JSON schema.
* **(Week 2: May 13 - May 19):**
* Perform a deep dive into the *specific* functions identified for use
(e.g., `resolve_ref_unsafe`, `shorten_unambiguous_ref`, remote access
functions, config API, chosen JSON method).
* Start outlining the structure of `builtin/metadata.c`.
* **(Week 3: May 20 - May 26):**
* Begin writing the basic skeleton of `builtin/metadata.c` and the
initial test file `t/tXXXX-metadata.sh`.
* Post first blog update summarizing Initial plan.

**Phase 2: Core Implementation & Setup (Coding Weeks 1-4: May 27 -
June 23, 2025 Approx.)**

* **Focus:** Implement the basic command structure and retrieve core
repository/HEAD information.
* **Activities:**
* **(Week 1: May 27 - June 2):** Implement `cmd_metadata` skeleton,
argument parsing (if any initially), repository struct access.
Implement retrieval of `.git` path and `is_bare` status. Integrate
chosen JSON generation approach (setup library or `strbuf` helpers).
* **(Week 2: June 3 - June 9):** Implement HEAD resolution (commit
SHA, full ref name). Implement logic for determining the short
symbolic name using appropriate Git functions. Integrate HEAD info
into JSON output.
* **(Week 3: June 10 - June 16):** Write initial test cases in
`t/tXXXX-metadata.sh` covering basic invocation, bare repos, and
detached HEAD states. Refine JSON output structure.
* **(Week 4: June 17 - June 23):** Prepare and submit the first set of
patches covering core repo/HEAD functionality to the mailing list.
Address initial feedback. Write blog post update.

**Phase 3: Adding Remotes & Refinement (Coding Weeks 5-8: June 24 -
July 21, 2025 Approx.)**

* **Focus:** Add remote information retrieval and expand testing
significantly. Aim for demonstrable core functionality by Midterm.
* **GSoC Milestone:** Midterm Evaluations.
* **Activities:**
* **(Week 5: June 24 - June 30):** Research and implement logic to
list remote names. Implement logic to query fetch/push URLs for each
remote using the config API.
* **(Week 6: July 1 - July 7):** Integrate remote information into the
JSON output structure. Handle edge cases (no remotes, missing push
URL).
* **(Week 7: July 8 - July 14):** Significantly expand the test suite:
add tests for various remote configurations, unborn branches. Refine
existing tests based on feedback. Start drafting the man page
(`Documentation/git-metadata.txt`).
* **(Week 8: July 15 - July 21):** Prepare and submit patches for
remote functionality. Ensure core command (`repo`, `head`, `remotes`
info) is stable and well-tested for Midterm Evaluation. Code cleanup
based on reviews. Write blog post update and prepare Midterm
Evaluation submission.

**Phase 4: Documentation, Polish & Stretch Goals (Coding Weeks 9-12:
July 22 - Aug 18, 2025 Approx.)**

* **Focus:** Finalize documentation, implement error handling, address
feedback, attempt stretch goals if feasible.
* **Activities:**
* **(Week 9: July 22 - July 28):** Complete the first draft of the man
page, detailing usage, JSON schema, and options. Implement the
`--json-errors` functionality for structured error reporting. Add
tests for error cases.
* **(Week 10: July 29 - Aug 4):** *Begin Stretch Goals (Conditional):*
If core work is stable and time permits, start implementing
`--head-only` / `--remotes-only` flags or the basic `is_dirty` check.
Add tests for any implemented stretch goals.
* **(Week 11: Aug 5 - Aug 11):** Thorough code cleanup, address all
outstanding review comments on submitted patches. Ensure documentation
is comprehensive and accurate. Final pass on test suite coverage.
* **(Week 12: Aug 12 - Aug 18):** Prepare and submit final patches
incorporating documentation, error handling, and any completed stretch
goals. Final code freeze for GSoC evaluation purposes. Write blog post
update summarizing final phase.

**Phase 5: Final Evaluation & Wrap-up (Aug 19 - Nov 19, 2025)**

* **Focus:** Final submissions, respond to late feedback, ensure
project completion.
* **GSoC Milestone:** Final Evaluations likely occur early in this period.
* **Official GSoC Milestone:** November 19, 2025 - Program End Date.
* **Activities:**
* **(Late Aug - Sept):** continue for any incompletions and follow up
for next set of projects(Stretch goals)
* **(Oct - Nov 19):** Monitor mailing list for patch status. Write
final GSoC project summary blog post. Continue engaging with the
community if interested in further contributions beyond GSoC.

## Past Communication and Microproject
* **Blog**: [Blog](https://jayatheerthkulkarni.github.io/gsoc_blog/index.ht=
ml)
This blog contains a detailed communication description and blog of my
microproject experience.
* First Introduction to the Git Mailing list: [first
Mail](https://lore.kernel.org/git/CA+rGoLc69R8qgbkYQiKoc2uweDwD10mxZXYFSY8x=
Fs5eKSRVkA@mail.gmail.com/t/#u)
* First patch to the git mailing list: [First
Patch](https://lore.kernel.org/git/20250312081534.75536-1-jayatheerthkulkar=
ni2005@gmail.com/t/#u)
* Most recent series of patches and back and forth with feedbacks:
[Main mail thread](https://lore.kernel.org/git/xmqqa59evffd.fsf@gitster.g/T=
/#t)

I've been maintaing the blog and will maintain the blogs of all the
communication of mine to the git mailing list.


Thank You,
Jayatheerth

Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C94C259CA5
	for <git@vger.kernel.org>; Mon, 13 Oct 2025 18:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760380407; cv=none; b=lEFXDZH7p7STrhIaVON3/APsA/OmUEAsD+VRQgx64+brXjtN7ikkjMGL5Q/hhw/0JTkz/h1vw7IVs1ItitykjrMH3LXzGxzMEoNY11NzeDr0SeJCPVF0u/+bW9d8HqmDVEz+4RhY8y2Cuc12XA5nWdNBMnxiRa6cvw32SkwFDTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760380407; c=relaxed/simple;
	bh=S9ZaUVvxXQCNOjGfjF/bgr7LMJcQKJZRv7XuolKO9Qw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Epl1op76KMRmZGYf/3hLWqdwH2PDlcJ3sPISSp2Pk2NMYP2+GEJ8eaGD008q550mhCM1eWZP55eYcehlzlC8I5Fh4y+kQhyvJJEGxblS06qHqfcVBETwl5cmJ81i9kvOh/HMqskzeT5nBI1Xu5pSSqQOk4ohAhMzNhnzopnhmWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hs+SNKul; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hs+SNKul"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-27eed7bdfeeso49821395ad.0
        for <git@vger.kernel.org>; Mon, 13 Oct 2025 11:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760380402; x=1760985202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6AVJZHNCEGsicO+yhdzjiF/LSjseLC+h6jYJYCszFKo=;
        b=hs+SNKulxVhzVNRs6ySc8aIVVinTcUaU5LueGNb0QMETGF+9DUCmPoOc/TcLhZrVeo
         nxllp6evSND3Lqy5c7djGosISJ5W0qWh7NVkDx9RLcnw+BGBpIj7fA3V0qYnGzO28ZJd
         Dh1rvhXtai9LdrkY3A2faxG/hhOVq/PHjDSoSrJrBNUf5JQwIUa0EuWpe9EnIbknjqhD
         jqWJ90MsELqAFkdBg0Whi6RjwnZkCqVzDrHCZ9vdQk8K1Ks0krgfg6dKoyW4wv1Ph7wj
         F8rMaBdQM6yxzDmq0EW1X3icDwLJHE8oP7AoXLsHU5txKI9XacOOuT8dDo79Yyd2rKpC
         b+Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760380402; x=1760985202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6AVJZHNCEGsicO+yhdzjiF/LSjseLC+h6jYJYCszFKo=;
        b=ZI+5mnlV1twrXkcEOCZ+pgVMpgQKH6y7lnalVLLYZa9GnrRoO3E2JLS+dT5gBlg96r
         qgWSU5ZwPSQzbgfeVYNLSvjUy0ySodhPNG7AmgFIUjLZupeT9C2U7SfLzET5ce1eS6Gk
         xOIBPaIXt3nMox3RwpR7gUS7WewchyktJ+gsBfHnIbLBIF9d+ndnJBE0GnebCY/GA19C
         fVn1C2M2A2LqL5sQFSjHQHIMzviM0NEQhkEscH4KgnODQqOyBJdXQJ8iMT5ZFJqXUiz1
         zHOffaBAChmsEMpJkhnHP1JAfLwSJ4z45pJfPX0r4cLzGLO6r1qjA0G4HaBYz6klb31D
         SN4w==
X-Gm-Message-State: AOJu0YzM2UnJ/Gps91kjQgZZk6lXtTBKGQOmw2lIibHMMn/ulZVipTNC
	2CCCrIPnjhEcKxjM9EZBldaGF73plV8559V9I3T9vawnvRS72YT16IZvlHFLsn4f09g=
X-Gm-Gg: ASbGncteTSxBIpZJm8Kj1CPapEwIwD6+8TTJOndw9deHYxSy2hjMhfyfeXebAUGyl5l
	HIckW72I4RjlNfJrFUcdV6aScQU06B9JBRqmWnu3XKiedRU5ayfp/mld+hBbThzOs1CM6lCtTn5
	j1u376brSvaOahbMs84yKmOwys3nOokQ9PE4GkSZsnbraK3yyDA/4FXPGxK8P5Y6EOpPzz7Ok33
	Fo0fhA241mGEFPCXGl/tpUoMUfncV1pVifKb5WxNnM9yMO/uxK5IkrsZWedrAJkHsZ9SjOfwbJx
	yke2Mh1/dAa3we6A2s1gFdHuWsbqMKhdki3Vm7ZQ60P5JBft5EHao6IksxLla//X8I9JKFHkK1H
	+cPCBQLMq9BxGJukjm1qGEHXhzCL55afWXr/JzkT4DCGvGZsu5h7Yg3gJ8c0vJmx40M2/7hnF2k
	qoOPM902jrsd6Tr0HjU+kfyVIuvSRKQ1OtLzclFANMltVbgXShJ3ZHIvBJsuAJ1dBPDGhE7Bj6o
	7o8nqdd
X-Google-Smtp-Source: AGHT+IFuu9qEGDITceQqQOYV3OT3J5Po+wUNLBTLXz4E/C5u25wR5ech0vzllBU1FSyShMd1AHixXQ==
X-Received: by 2002:a17:903:19e3:b0:273:ef4c:60f3 with SMTP id d9443c01a7336-28ec9c0c3e5mr326108915ad.4.1760380401445;
        Mon, 13 Oct 2025 11:33:21 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:56:dc83:edd1:7853:510f:d37e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034de6c70sm140019905ad.13.2025.10.13.11.33.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Oct 2025 11:33:20 -0700 (PDT)
From: Siddharth Asthana <siddharthasthana31@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	phillip.wood123@gmail.com,
	phillip.wood@dunelm.org.uk,
	newren@gmail.com,
	gitster@pobox.com,
	ps@pks.im,
	karthik.188@gmail.com,
	code@khaugsbakk.name,
	rybak.a.v@gmail.com,
	jltobler@gmail.com,
	toon@iotcl.com,
	johncai86@gmail.com,
	johannes.schindelin@gmx.de,
	Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH v3 0/3] replay: make atomic ref updates the default
Date: Tue, 14 Oct 2025 00:03:08 +0530
Message-ID: <20251013183311.33329-1-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250926230838.35870-1-siddharthasthana31@gmail.com>
References: <20250926230838.35870-1-siddharthasthana31@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is v3 of the git-replay atomic updates series.

Based on feedback from v2, this version simplifies the API and improves
extensibility. Thanks to Elijah, Phillip, Christian, Junio, and Karthik
for the detailed reviews that shaped this version.

## Changes Since v2

**Removed --allow-partial option**

After discussion with Elijah and Junio, we couldn't identify a concrete
use case for partial failure tolerance. The traditional pipeline with
git-update-ref already provides partial update capabilities when needed
through its transaction commands. Removing this option simplifies the API
and avoids committing to behavior without clear real-world use cases.

**Changed to --update-refs=<mode> for extensibility**

Phillip suggested that separate boolean flags (--output-commands,
--allow-partial) were limiting for future expansion. The --update-refs=<mode>
design allows future modes without option proliferation:
  - --update-refs=yes (default): atomic ref updates
  - --update-refs=print: pipeline output
  - Future modes can be added as additional values

This API pattern prevents the need for multiple incompatible flags and
provides a cleaner interface for users.

**Added replay.defaultAction configuration option**

Junio recommended a config option for users preferring traditional behavior.
The implementation uses enum string values for extensibility:
  - replay.defaultAction = update-refs (default)
  - replay.defaultAction = show-commands (pipeline output)

The command-line --update-refs option overrides the config, allowing users
to set a preference while maintaining per-invocation control. The enum
design (versus a boolean) allows future expansion to additional modes
without requiring new config variables.

**Improved commit messages and patch organization**

Christian and Elijah provided detailed feedback on commit message structure.
Patch 2 now uses Elijah's suggested format that explains the trade-offs of
the current design before proposing changes. The commit messages now focus
on the changes themselves rather than v1→v2 evolution. Added Helped-by
trailers to acknowledge specific contributions.

**Enhanced test suite with proper isolation**

Following Elijah's suggestions:
  - Existing tests use --update-refs=print to preserve their behavior
  - New tests use test_when_finished for proper cleanup
  - Added real atomicity test using lock files to verify all-or-nothing
  - Fixed bare repository tests to rebuild expectations independently
  - Removed weak tests that didn't actually verify atomicity

**Extracted helper function to reduce duplication**

Per Phillip's feedback, added handle_ref_update() helper to eliminate
code duplication between print and atomic modes. This function takes a
mode parameter and handles both cases, making the code more maintainable
and ensuring both paths stay consistent.

## Technical Implementation

The atomic ref updates use Git's ref transaction API:
  - ref_store_transaction_begin() with default atomic behavior
  - ref_transaction_update() to stage each update
  - ref_transaction_commit() for atomic application

The handle_ref_update() helper encapsulates the mode-specific logic,
either printing update commands or staging them into the transaction.

Config reading uses repo_config_get_string_tmp() with validation for
'update-refs' and 'show-commands' values, mapping them to internal
modes 'yes' and 'print' respectively.

Range-diff against v2:
-:  ---------- > 1:  de9cc3fbee replay: use die_for_incompatible_opt2() for option validation
1:  e3c1a57375 ! 2:  3f4c69d612 replay: make atomic ref updates the default behavior
    @@ Metadata
      ## Commit message ##
         replay: make atomic ref updates the default behavior
     
    -    The git replay command currently outputs update commands that must be
    -    piped to git update-ref --stdin to actually update references:
    +    The git replay command currently outputs update commands that can be
    +    piped to update-ref to achieve a rebase, e.g.
     
    -        git replay --onto main topic1..topic2 | git update-ref --stdin
    +      git replay --onto main topic1..topic2 | git update-ref --stdin
     
    -    This design has significant limitations for server-side operations. The
    -    two-command pipeline creates coordination complexity, provides no atomic
    -    transaction guarantees by default, and complicates automation in bare
    -    repository environments where git replay is primarily used.
    +    This separation had advantages for three special cases:
    +      * it made testing easy (when state isn't modified from one step to
    +        the next, you don't need to make temporary branches or have undo
    +        commands, or try to track the changes)
    +      * it provided a natural can-it-rebase-cleanly (and what would it
    +        rebase to) capability without automatically updating refs, similar
    +        to a --dry-run
    +      * it provided a natural low-level tool for the suite of hash-object,
    +        mktree, commit-tree, mktag, merge-tree, and update-ref, allowing
    +        users to have another building block for experimentation and making
    +        new tools
     
    -    During extensive mailing list discussion, multiple maintainers identified
    -    that the current approach forces users to opt-in to atomic behavior rather
    -    than defaulting to the safer, more reliable option. Elijah Newren noted
    -    that the experimental status explicitly allows such behavior changes, while
    -    Patrick Steinhardt highlighted performance concerns with individual ref
    -    updates in the reftable backend.
    +    However, it should be noted that all three of these are somewhat
    +    special cases; users, whether on the client or server side, would
    +    almost certainly find it more ergonomical to simply have the updating
    +    of refs be the default.
     
    -    The core issue is that git replay was designed around command output rather
    -    than direct action. This made sense for a plumbing tool, but creates barriers
    -    for the primary use case: server-side operations that need reliable, atomic
    -    ref updates without pipeline complexity.
    +    For server-side operations in particular, the pipeline architecture
    +    creates process coordination overhead. Server implementations that need
    +    to perform rebases atomically must maintain additional code to:
     
    -    This patch changes the default behavior to update refs directly using Git's
    -    ref transaction API:
    +      1. Spawn and manage a pipeline between git-replay and git-update-ref
    +      2. Coordinate stdout/stderr streams across the pipe boundary
    +      3. Handle partial failure states if the pipeline breaks mid-execution
    +      4. Parse and validate the update-ref command output
     
    -        git replay --onto main topic1..topic2
    -        # No output; all refs updated atomically or none
    +    Change the default behavior to update refs directly, and atomically (at
    +    least to the extent supported by the refs backend in use). This
    +    eliminates the process coordination overhead for the common case.
     
    -    The implementation uses ref_store_transaction_begin() with atomic mode by
    -    default, ensuring all ref updates succeed or all fail as a single operation.
    -    This leverages git replay's existing server-side strengths (in-memory operation,
    -    no work tree requirement) while adding the atomic guarantees that server
    -    operations require.
    +    For users needing the traditional pipeline workflow, add a new
    +    `--update-refs=<mode>` option that preserves the original behavior:
     
    -    For users needing the traditional pipeline workflow, --output-commands
    -    preserves the original behavior:
    +      git replay --update-refs=print --onto main topic1..topic2 | git update-ref --stdin
     
    -        git replay --output-commands --onto main topic1..topic2 | git update-ref --stdin
    -
    -    The --allow-partial option enables partial failure tolerance. However, following
    -    maintainer feedback, it implements a "strict success" model: the command exits
    -    with code 0 only if ALL ref updates succeed, and exits with code 1 if ANY
    -    updates fail. This ensures that --allow-partial changes error reporting style
    -    (warnings vs hard errors) but not success criteria, handling edge cases like
    -    "no updates needed" cleanly.
    +    The mode can be:
    +      * `yes` (default): Update refs directly using an atomic transaction
    +      * `print`: Output update-ref commands for pipeline use
     
         Implementation details:
    -    - Empty commit ranges now return success (exit code 0) rather than failure,
    -      as no commits to replay is a valid successful operation
    -    - Added comprehensive test coverage with 12 new tests covering atomic behavior,
    -      option validation, bare repository support, and edge cases
    -    - Fixed test isolation issues to prevent branch state contamination between tests
    -    - Maintains C89 compliance and follows Git's established coding conventions
    -    - Refactored option validation to use die_for_incompatible_opt2() for both
    -      --advance/--contained and --allow-partial/--output-commands conflicts,
    -      providing consistent error reporting
    -    - Fixed --allow-partial exit code behavior to implement "strict success" model
    -      where any ref update failures result in exit code 1, even with partial tolerance
    -    - Updated documentation with proper line wrapping, consistent terminology using
    -      "old default behavior", performance context, and reorganized examples for clarity
    -    - Eliminates individual ref updates (refs_update_ref calls) that perform
    -      poorly with reftable backend
    -    - Uses only batched ref transactions for optimal performance across all
    -      ref backends
    -    - Avoids naming collision with git rebase --update-refs by using distinct
    -      option names
    -    - Defaults to atomic behavior while preserving pipeline compatibility
     
    -    The result is a command that works better for its primary use case (server-side
    -    operations) while maintaining full backward compatibility for existing workflows.
    +    The atomic ref updates are implemented using Git's ref transaction API.
    +    In cmd_replay(), when not in 'print' mode, we initialize a transaction
    +    using ref_store_transaction_begin() with the default atomic behavior.
    +    As commits are replayed, ref updates are staged into the transaction
    +    using ref_transaction_update(). Finally, ref_transaction_commit()
    +    applies all updates atomically—either all updates succeed or none do.
    +
    +    To avoid code duplication between the 'print' and 'yes' modes, this
    +    commit extracts a handle_ref_update() helper function. This function
    +    takes the mode and either prints the update command or stages it into
    +    the transaction. This keeps both code paths consistent and makes future
    +    maintenance easier.
    +
    +    The helper function signature:
    +
    +      static int handle_ref_update(const char *mode,
    +                                    struct ref_transaction *transaction,
    +                                    const char *refname,
    +                                    const struct object_id *new_oid,
    +                                    const struct object_id *old_oid,
    +                                    struct strbuf *err)
    +
    +    When mode is 'print', it prints the update-ref command. When mode is
    +    'yes', it calls ref_transaction_update() to stage the update. This
    +    eliminates the duplication that would otherwise exist at each ref update
    +    call site.
    +
    +    Test suite changes:
     
    +    All existing tests that expected command output now use
    +    `--update-refs=print` to preserve their original behavior. This keeps
    +    the tests valid while allowing them to verify that the pipeline workflow
    +    still works correctly.
    +
    +    New tests were added to verify:
    +      - Default atomic behavior (no output, refs updated directly)
    +      - Bare repository support (server-side use case)
    +      - Equivalence between traditional pipeline and atomic updates
    +      - Real atomicity using a lock file to verify all-or-nothing guarantee
    +      - Test isolation using test_when_finished to clean up state
    +
    +    The bare repository tests were fixed to rebuild their expectations
    +    independently rather than comparing to previous test output, improving
    +    test reliability and isolation.
    +
    +    A following commit will add a `replay.defaultAction` configuration
    +    option for users who prefer the traditional pipeline output as their
    +    default behavior.
    +
    +    Helped-by: Elijah Newren <newren@gmail.com>
    +    Helped-by: Patrick Steinhardt <ps@pks.im>
    +    Helped-by: Christian Couder <christian.couder@gmail.com>
    +    Helped-by: Phillip Wood <phillip.wood123@gmail.com>
         Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
     
      ## Documentation/git-replay.adoc ##
    @@ Documentation/git-replay.adoc: git-replay - EXPERIMENTAL: Replay commits on a ne
      --------
      [verse]
     -(EXPERIMENTAL!) 'git replay' ([--contained] --onto <newbase> | --advance <branch>) <revision-range>...
    -+(EXPERIMENTAL!) 'git replay' ([--contained] --onto <newbase> | --advance <branch>) [--output-commands | --allow-partial] <revision-range>...
    ++(EXPERIMENTAL!) 'git replay' ([--contained] --onto <newbase> | --advance <branch>)
    ++		[--update-refs[=<mode>]] <revision-range>...
      
      DESCRIPTION
      -----------
    @@ Documentation/git-replay.adoc: git-replay - EXPERIMENTAL: Replay commits on a ne
     -the working tree and the index untouched, and updates no references.
     -The output of this command is meant to be used as input to
     -`git update-ref --stdin`, which would update the relevant branches
    --(see the OUTPUT section below).
    -+the working tree and the index untouched, and by default updates the
    -+relevant references using atomic transactions. Use `--output-commands`
    -+to get the old default behavior where update commands that can be piped
    -+to `git update-ref --stdin` are emitted (see the OUTPUT section below).
    ++the working tree and the index untouched. By default, updates the
    ++relevant references using an atomic transaction (all refs update or
    ++none). Use `--update-refs=print` to avoid automatic ref updates and
    ++instead get update commands that can be piped to `git update-ref --stdin`
    + (see the OUTPUT section below).
      
      THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
    +@@ Documentation/git-replay.adoc: OPTIONS
    + 	Starting point at which to create the new commits.  May be any
    + 	valid commit, and not just an existing branch name.
    + +
    +-When `--onto` is specified, the update-ref command(s) in the output will
    +-update the branch(es) in the revision range to point at the new
    +-commits, similar to the way how `git rebase --update-refs` updates
    +-multiple branches in the affected range.
    ++When `--onto` is specified, the branch(es) in the revision range will be
    ++updated to point at the new commits (or update commands will be printed
    ++if `--update-refs=print` is used), similar to the way how
    ++`git rebase --update-refs` updates multiple branches in the affected range.
    + 
    + --advance <branch>::
    + 	Starting point at which to create the new commits; must be a
    + 	branch name.
    + +
    +-When `--advance` is specified, the update-ref command(s) in the output
    +-will update the branch passed as an argument to `--advance` to point at
    +-the new commits (in other words, this mimics a cherry-pick operation).
    ++When `--advance` is specified, the branch passed as an argument will be
    ++updated to point at the new commits (or an update command will be printed
    ++if `--update-refs=print` is used). This mimics a cherry-pick operation.
    ++
    ++--update-refs[=<mode>]::
    ++	Control how references are updated. The mode can be:
    +++
    ++--
    ++* `yes` (default): Update refs directly using an atomic transaction.
    ++  All ref updates succeed or all fail.
    ++* `print`: Output update-ref commands instead of updating refs.
    ++  The output can be piped as-is to `git update-ref --stdin`.
    ++--
      
    -@@ Documentation/git-replay.adoc: When `--advance` is specified, the update-ref command(s) in the output
    - will update the branch passed as an argument to `--advance` to point at
    - the new commits (in other words, this mimics a cherry-pick operation).
    - 
    -+--output-commands::
    -+	Output update-ref commands instead of updating refs directly.
    -+	When this option is used, the output can be piped to `git update-ref --stdin`
    -+	for successive, relatively slow, ref updates. This is equivalent to the
    -+	old default behavior.
    -+
    -+--allow-partial::
    -+	Allow some ref updates to succeed even if others fail. By default,
    -+	ref updates are atomic (all succeed or all fail). With this option,
    -+	failed updates are reported as warnings rather than causing the entire
    -+	command to fail. The command exits with code 0 only if all updates
    -+	succeed; any failures result in exit code 1. Cannot be used with
    -+	`--output-commands`.
    -+
      <revision-range>::
      	Range of commits to replay. More than one <revision-range> can
    - 	be passed, but in `--advance <branch>` mode, they should have
     @@ Documentation/git-replay.adoc: include::rev-list-options.adoc[]
      OUTPUT
      ------
    @@ Documentation/git-replay.adoc: include::rev-list-options.adoc[]
     -When there are no conflicts, the output of this command is usable as
     -input to `git update-ref --stdin`.  It is of the form:
     +By default, when there are no conflicts, this command updates the relevant
    -+references using atomic transactions and produces no output. All ref updates
    -+succeed or all fail (atomic behavior). Use `--allow-partial` to allow some
    -+updates to succeed while others fail.
    ++references using an atomic transaction and produces no output. All ref
    ++updates succeed or all fail.
     +
    -+When `--output-commands` is used, the output is usable as input to
    ++When `--update-refs=print` is used, the output is usable as input to
     +`git update-ref --stdin`. It is of the form:
      
      	update refs/heads/branch1 ${NEW_branch1_HASH} ${OLD_branch1_HASH}
    @@ Documentation/git-replay.adoc: is something other than 0 or 1.
     +updates mybranch to point at the new commits and the second updates
     +target to point at them.
     +
    -+To get the old default behavior where update commands are emitted:
    ++To get the traditional pipeline output:
     +
     +------------
    -+$ git replay --output-commands --onto target origin/main..mybranch
    ++$ git replay --update-refs=print --onto target origin/main..mybranch
     +update refs/heads/mybranch ${NEW_mybranch_HASH} ${OLD_mybranch_HASH}
    -+------------
    -+
    -+To rebase multiple branches with partial failure tolerance:
    -+
    -+------------
    -+$ git replay --allow-partial --contained --onto origin/main origin/main..tipbranch
     +------------
      
      What if you have a stack of branches, one depending upon another, and
    @@ Documentation/git-replay.adoc: is something other than 0 or 1.
      
      ------------
      $ git replay --contained --onto origin/main origin/main..tipbranch
    -+------------
    -+
    +-update refs/heads/branch1 ${NEW_branch1_HASH} ${OLD_branch1_HASH}
    +-update refs/heads/branch2 ${NEW_branch2_HASH} ${OLD_branch2_HASH}
    +-update refs/heads/tipbranch ${NEW_tipbranch_HASH} ${OLD_tipbranch_HASH}
    + ------------
    + 
     +This automatically finds and rebases all branches contained within the
     +`origin/main..tipbranch` range.
     +
    -+Or if you want to see the old default behavior where update commands are emitted:
    -+
    -+------------
    -+$ git replay --output-commands --contained --onto origin/main origin/main..tipbranch
    - update refs/heads/branch1 ${NEW_branch1_HASH} ${OLD_branch1_HASH}
    - update refs/heads/branch2 ${NEW_branch2_HASH} ${OLD_branch2_HASH}
    - update refs/heads/tipbranch ${NEW_tipbranch_HASH} ${OLD_tipbranch_HASH}
    -@@ Documentation/git-replay.adoc: update refs/heads/tipbranch ${NEW_tipbranch_HASH} ${OLD_tipbranch_HASH}
    - 
      When calling `git replay`, one does not need to specify a range of
    - commits to replay using the syntax `A..B`; any range expression will
    +-commits to replay using the syntax `A..B`; any range expression will
     -do:
    -+do. Here's an example where you explicitly specify which branches to rebase:
    ++commits to replay using the syntax `A..B`; any range expression will do:
      
      ------------
      $ git replay --onto origin/main ^base branch1 branch2 branch3
    -+------------
    -+
    -+This gives you explicit control over exactly which branches are rebased,
    -+unlike the previous `--contained` example which automatically discovers them.
    -+
    -+To see the update commands that would be executed:
    -+
    -+------------
    -+$ git replay --output-commands --onto origin/main ^base branch1 branch2 branch3
    - update refs/heads/branch1 ${NEW_branch1_HASH} ${OLD_branch1_HASH}
    - update refs/heads/branch2 ${NEW_branch2_HASH} ${OLD_branch2_HASH}
    - update refs/heads/branch3 ${NEW_branch3_HASH} ${OLD_branch3_HASH}
    +-update refs/heads/branch1 ${NEW_branch1_HASH} ${OLD_branch1_HASH}
    +-update refs/heads/branch2 ${NEW_branch2_HASH} ${OLD_branch2_HASH}
    +-update refs/heads/branch3 ${NEW_branch3_HASH} ${OLD_branch3_HASH}
    + ------------
    + 
    + This will simultaneously rebase `branch1`, `branch2`, and `branch3`,
     
      ## builtin/replay.c ##
     @@ builtin/replay.c: static struct commit *pick_regular_commit(struct repository *repo,
      	return create_commit(repo, result->tree, pickme, replayed_base);
      }
      
    -+static int add_ref_to_transaction(struct ref_transaction *transaction,
    -+				  const char *refname,
    -+				  const struct object_id *new_oid,
    -+				  const struct object_id *old_oid,
    -+				  struct strbuf *err)
    ++static int handle_ref_update(const char *mode,
    ++			     struct ref_transaction *transaction,
    ++			     const char *refname,
    ++			     const struct object_id *new_oid,
    ++			     const struct object_id *old_oid,
    ++			     struct strbuf *err)
     +{
    ++	if (!strcmp(mode, "print")) {
    ++		printf("update %s %s %s\n",
    ++		       refname,
    ++		       oid_to_hex(new_oid),
    ++		       oid_to_hex(old_oid));
    ++		return 0;
    ++	}
    ++
    ++	/* mode == "yes" - update refs directly */
     +	return ref_transaction_update(transaction, refname, new_oid, old_oid,
     +				      NULL, NULL, 0, "git replay", err);
     +}
    -+
    -+static void print_rejected_update(const char *refname,
    -+				  const struct object_id *old_oid UNUSED,
    -+				  const struct object_id *new_oid UNUSED,
    -+				  const char *old_target UNUSED,
    -+				  const char *new_target UNUSED,
    -+				  enum ref_transaction_error err,
    -+				  void *cb_data UNUSED)
    -+{
    -+	const char *reason = ref_transaction_error_msg(err);
    -+	warning(_("failed to update %s: %s"), refname, reason);
    -+}
     +
      int cmd_replay(int argc,
      	       const char **argv,
    @@ builtin/replay.c: int cmd_replay(int argc,
      	struct commit *onto = NULL;
      	const char *onto_name = NULL;
      	int contained = 0;
    -+	int output_commands = 0;
    -+	int allow_partial = 0;
    ++	const char *update_refs_mode = NULL;
      
      	struct rev_info revs;
      	struct commit *last_commit = NULL;
    @@ builtin/replay.c: int cmd_replay(int argc,
      	kh_oid_map_t *replayed_commits;
     +	struct ref_transaction *transaction = NULL;
     +	struct strbuf transaction_err = STRBUF_INIT;
    -+	int commits_processed = 0;
      	int ret = 0;
      
     -	const char * const replay_usage[] = {
    @@ builtin/replay.c: int cmd_replay(int argc,
      		N_("(EXPERIMENTAL!) git replay "
      		   "([--contained] --onto <newbase> | --advance <branch>) "
     -		   "<revision-range>..."),
    -+		   "[--output-commands | --allow-partial] <revision-range>..."),
    ++		   "[--update-refs[=<mode>]] <revision-range>..."),
      		NULL
      	};
      	struct option replay_options[] = {
    @@ builtin/replay.c: int cmd_replay(int argc,
      			   N_("replay onto given commit")),
      		OPT_BOOL(0, "contained", &contained,
      			 N_("advance all branches contained in revision-range")),
    -+		OPT_BOOL(0, "output-commands", &output_commands,
    -+			 N_("output update commands instead of updating refs")),
    -+		OPT_BOOL(0, "allow-partial", &allow_partial,
    -+			 N_("allow some ref updates to succeed even if others fail")),
    ++		OPT_STRING(0, "update-refs", &update_refs_mode,
    ++			   N_("mode"),
    ++			   N_("control ref update behavior (yes|print)")),
      		OPT_END()
      	};
      
     @@ builtin/replay.c: int cmd_replay(int argc,
    - 		usage_with_options(replay_usage, replay_options);
    - 	}
    + 	die_for_incompatible_opt2(!!advance_name_opt, "--advance",
    + 				  contained, "--contained");
      
    --	if (advance_name_opt && contained)
    --		die(_("options '%s' and '%s' cannot be used together"),
    --		    "--advance", "--contained");
    -+	die_for_incompatible_opt2(!!advance_name_opt, "--advance",
    -+				  contained, "--contained");
    ++	/* Set default mode if not specified */
    ++	if (!update_refs_mode)
    ++		update_refs_mode = "yes";
     +
    -+	die_for_incompatible_opt2(allow_partial, "--allow-partial",
    -+				  output_commands, "--output-commands");
    ++	/* Validate update-refs mode */
    ++	if (strcmp(update_refs_mode, "yes") && strcmp(update_refs_mode, "print"))
    ++		die(_("invalid value for --update-refs: '%s' (expected 'yes' or 'print')"),
    ++		    update_refs_mode);
     +
      	advance_name = xstrdup_or_null(advance_name_opt);
      
    @@ builtin/replay.c: int cmd_replay(int argc,
      	determine_replay_mode(repo, &revs.cmdline, onto_name, &advance_name,
      			      &onto, &update_refs);
      
    -+	if (!output_commands) {
    -+		unsigned int transaction_flags = allow_partial ? REF_TRANSACTION_ALLOW_FAILURE : 0;
    ++	/* Initialize ref transaction if we're updating refs directly */
    ++	if (!strcmp(update_refs_mode, "yes")) {
     +		transaction = ref_store_transaction_begin(get_main_ref_store(repo),
    -+							  transaction_flags,
    -+							  &transaction_err);
    ++							  0, &transaction_err);
     +		if (!transaction) {
    -+			ret = error(_("failed to begin ref transaction: %s"), transaction_err.buf);
    ++			ret = error(_("failed to begin ref transaction: %s"),
    ++				    transaction_err.buf);
     +			goto cleanup;
     +		}
     +	}
    @@ builtin/replay.c: int cmd_replay(int argc,
      	if (!onto) /* FIXME: Should handle replaying down to root commit */
      		die("Replaying down to root commit is not supported yet!");
      
    -@@ builtin/replay.c: int cmd_replay(int argc,
    - 		khint_t pos;
    - 		int hr;
    - 
    -+		commits_processed = 1;
    -+
    - 		if (!commit->parents)
    - 			die(_("replaying down to root commit is not supported yet!"));
    - 		if (commit->parents->next)
     @@ builtin/replay.c: int cmd_replay(int argc,
      			if (decoration->type == DECORATION_REF_LOCAL &&
      			    (contained || strset_contains(update_refs,
    @@ builtin/replay.c: int cmd_replay(int argc,
     -				       decoration->name,
     -				       oid_to_hex(&last_commit->object.oid),
     -				       oid_to_hex(&commit->object.oid));
    -+				if (output_commands) {
    -+					printf("update %s %s %s\n",
    -+					       decoration->name,
    -+					       oid_to_hex(&last_commit->object.oid),
    -+					       oid_to_hex(&commit->object.oid));
    -+				} else if (add_ref_to_transaction(transaction, decoration->name,
    -+								  &last_commit->object.oid,
    -+								  &commit->object.oid,
    -+								  &transaction_err) < 0) {
    -+					ret = error(_("failed to add ref update to transaction: %s"), transaction_err.buf);
    ++				if (handle_ref_update(update_refs_mode, transaction,
    ++						      decoration->name,
    ++						      &last_commit->object.oid,
    ++						      &commit->object.oid,
    ++						      &transaction_err) < 0) {
    ++					ret = error(_("failed to update ref '%s': %s"),
    ++						    decoration->name, transaction_err.buf);
     +					goto cleanup;
     +				}
      			}
    @@ builtin/replay.c: int cmd_replay(int argc,
     -		       advance_name,
     -		       oid_to_hex(&last_commit->object.oid),
     -		       oid_to_hex(&onto->object.oid));
    -+		if (output_commands) {
    -+			printf("update %s %s %s\n",
    -+			       advance_name,
    -+			       oid_to_hex(&last_commit->object.oid),
    -+			       oid_to_hex(&onto->object.oid));
    -+		} else if (add_ref_to_transaction(transaction, advance_name,
    -+						  &last_commit->object.oid,
    -+						  &onto->object.oid,
    -+						  &transaction_err) < 0) {
    -+			ret = error(_("failed to add ref update to transaction: %s"), transaction_err.buf);
    ++		if (handle_ref_update(update_refs_mode, transaction,
    ++				      advance_name,
    ++				      &last_commit->object.oid,
    ++				      &onto->object.oid,
    ++				      &transaction_err) < 0) {
    ++			ret = error(_("failed to update ref '%s': %s"),
    ++				    advance_name, transaction_err.buf);
     +			goto cleanup;
     +		}
     +	}
    @@ builtin/replay.c: int cmd_replay(int argc,
     +	/* Commit the ref transaction if we have one */
     +	if (transaction && result.clean == 1) {
     +		if (ref_transaction_commit(transaction, &transaction_err)) {
    -+			if (allow_partial) {
    -+				warning(_("some ref updates failed: %s"), transaction_err.buf);
    -+				ref_transaction_for_each_rejected_update(transaction,
    -+									 print_rejected_update, NULL);
    -+				ret = 0; /* Set failure even with allow_partial */
    -+			} else {
    -+				ret = error(_("failed to update refs: %s"), transaction_err.buf);
    -+				goto cleanup;
    -+			}
    ++			ret = error(_("failed to commit ref transaction: %s"),
    ++				    transaction_err.buf);
    ++			goto cleanup;
     +		}
      	}
      
      	merge_finalize(&merge_opt, &result);
     @@ builtin/replay.c: int cmd_replay(int argc,
    - 		strset_clear(update_refs);
    - 		free(update_refs);
    - 	}
    --	ret = result.clean;
    -+
    -+	/* Handle empty ranges: if no commits were processed, treat as success */
    -+	if (!commits_processed)
    -+		ret = 1; /* Success - no commits to replay is not an error */
    -+	else
    -+		ret = result.clean;
    + 	ret = result.clean;
      
      cleanup:
     +	if (transaction)
    @@ t/t3650-replay-basics.sh: test_expect_success 'setup bare' '
      
      test_expect_success 'using replay to rebase two branches, one on top of other' '
     -	git replay --onto main topic1..topic2 >result &&
    -+	git replay --output-commands --onto main topic1..topic2 >result &&
    ++	git replay --update-refs=print --onto main topic1..topic2 >result &&
      
      	test_line_count = 1 result &&
      
    @@ t/t3650-replay-basics.sh: test_expect_success 'using replay to rebase two branch
      '
      
     +test_expect_success 'using replay with default atomic behavior (no output)' '
    -+	# Create a test branch that wont interfere with others
    -+	git branch atomic-test topic2 &&
    -+	git rev-parse atomic-test >atomic-test-old &&
    ++	# Store the original state
    ++	START=$(git rev-parse topic2) &&
    ++	test_when_finished "git branch -f topic2 $START" &&
     +
     +	# Default behavior: atomic ref updates (no output)
    -+	git replay --onto main topic1..atomic-test >output &&
    ++	git replay --onto main topic1..topic2 >output &&
     +	test_must_be_empty output &&
     +
    -+	# Verify the branch was updated
    -+	git rev-parse atomic-test >atomic-test-new &&
    -+	! test_cmp atomic-test-old atomic-test-new &&
    -+
     +	# Verify the history is correct
    -+	git log --format=%s atomic-test >actual &&
    ++	git log --format=%s topic2 >actual &&
     +	test_write_lines E D M L B A >expect &&
     +	test_cmp expect actual
     +'
     +
      test_expect_success 'using replay on bare repo to rebase two branches, one on top of other' '
     -	git -C bare replay --onto main topic1..topic2 >result-bare &&
    --	test_cmp expect result-bare
    -+	git -C bare replay --output-commands --onto main topic1..topic2 >result-bare &&
    ++	git -C bare replay --update-refs=print --onto main topic1..topic2 >result-bare &&
    ++
    ++	test_line_count = 1 result-bare &&
    ++
    ++	git log --format=%s $(cut -f 3 -d " " result-bare) >actual &&
    ++	test_write_lines E D M L B A >expect &&
    ++	test_cmp expect actual &&
    ++
    ++	printf "update refs/heads/topic2 " >expect &&
    ++	printf "%s " $(cut -f 3 -d " " result-bare) >>expect &&
    ++	git -C bare rev-parse topic2 >>expect &&
     +
    -+	# The result should match what we got from the regular repo
    -+	test_cmp result result-bare
    + 	test_cmp expect result-bare
      '
      
    - test_expect_success 'using replay to rebase with a conflict' '
     @@ t/t3650-replay-basics.sh: test_expect_success 'using replay to perform basic cherry-pick' '
      	# 2nd field of result is refs/heads/main vs. refs/heads/topic2
      	# 4th field of result is hash for main instead of hash for topic2
      
     -	git replay --advance main topic1..topic2 >result &&
    -+	git replay --output-commands --advance main topic1..topic2 >result &&
    ++	git replay --update-refs=print --advance main topic1..topic2 >result &&
      
      	test_line_count = 1 result &&
      
    @@ t/t3650-replay-basics.sh: test_expect_success 'using replay to perform basic che
      
      test_expect_success 'using replay on bare repo to perform basic cherry-pick' '
     -	git -C bare replay --advance main topic1..topic2 >result-bare &&
    -+	git -C bare replay --output-commands --advance main topic1..topic2 >result-bare &&
    ++	git -C bare replay --update-refs=print --advance main topic1..topic2 >result-bare &&
    ++
    ++	test_line_count = 1 result-bare &&
    ++
    ++	git log --format=%s $(cut -f 3 -d " " result-bare) >actual &&
    ++	test_write_lines E D M L B A >expect &&
    ++	test_cmp expect actual &&
    ++
    ++	printf "update refs/heads/main " >expect &&
    ++	printf "%s " $(cut -f 3 -d " " result-bare) >>expect &&
    ++	git -C bare rev-parse main >>expect &&
    ++
      	test_cmp expect result-bare
      '
      
    @@ t/t3650-replay-basics.sh: test_expect_success 'replay fails when both --advance
      
      test_expect_success 'using replay to also rebase a contained branch' '
     -	git replay --contained --onto main main..topic3 >result &&
    -+	git replay --output-commands --contained --onto main main..topic3 >result &&
    ++	git replay --update-refs=print --contained --onto main main..topic3 >result &&
      
      	test_line_count = 2 result &&
      	cut -f 3 -d " " result >new-branch-tips &&
    @@ t/t3650-replay-basics.sh: test_expect_success 'using replay to also rebase a con
      
      test_expect_success 'using replay on bare repo to also rebase a contained branch' '
     -	git -C bare replay --contained --onto main main..topic3 >result-bare &&
    -+	git -C bare replay --output-commands --contained --onto main main..topic3 >result-bare &&
    ++	git -C bare replay --update-refs=print --contained --onto main main..topic3 >result-bare &&
    ++
    ++	test_line_count = 2 result-bare &&
    ++	cut -f 3 -d " " result-bare >new-branch-tips &&
    ++
    ++	git log --format=%s $(head -n 1 new-branch-tips) >actual &&
    ++	test_write_lines F C M L B A >expect &&
    ++	test_cmp expect actual &&
    ++
    ++	git log --format=%s $(tail -n 1 new-branch-tips) >actual &&
    ++	test_write_lines H G F C M L B A >expect &&
    ++	test_cmp expect actual &&
    ++
    ++	printf "update refs/heads/topic1 " >expect &&
    ++	printf "%s " $(head -n 1 new-branch-tips) >>expect &&
    ++	git -C bare rev-parse topic1 >>expect &&
    ++	printf "update refs/heads/topic3 " >>expect &&
    ++	printf "%s " $(tail -n 1 new-branch-tips) >>expect &&
    ++	git -C bare rev-parse topic3 >>expect &&
    ++
      	test_cmp expect result-bare
      '
      
      test_expect_success 'using replay to rebase multiple divergent branches' '
     -	git replay --onto main ^topic1 topic2 topic4 >result &&
    -+	git replay --output-commands --onto main ^topic1 topic2 topic4 >result &&
    ++	git replay --update-refs=print --onto main ^topic1 topic2 topic4 >result &&
      
      	test_line_count = 2 result &&
      	cut -f 3 -d " " result >new-branch-tips &&
    @@ t/t3650-replay-basics.sh: test_expect_success 'using replay to rebase multiple d
      
      test_expect_success 'using replay on bare repo to rebase multiple divergent branches, including contained ones' '
     -	git -C bare replay --contained --onto main ^main topic2 topic3 topic4 >result &&
    -+	git -C bare replay --output-commands --contained --onto main ^main topic2 topic3 topic4 >result &&
    ++	git -C bare replay --update-refs=print --contained --onto main ^main topic2 topic3 topic4 >result &&
      
      	test_line_count = 4 result &&
      	cut -f 3 -d " " result >new-branch-tips &&
    @@ t/t3650-replay-basics.sh: test_expect_success 'merge.directoryRenames=false' '
      		--onto rename-onto rename-onto..rename-from
      '
      
    -+# Tests for new default atomic behavior and options
    -+
    -+test_expect_success 'replay default behavior should not produce output when successful' '
    -+	git replay --onto main topic1..topic3 >output &&
    -+	test_must_be_empty output
    -+'
    -+
    -+test_expect_success 'replay with --output-commands produces traditional output' '
    -+	git replay --output-commands --onto main topic1..topic3 >output &&
    -+	test_line_count = 1 output &&
    -+	grep "^update refs/heads/topic3 " output
    -+'
    -+
    -+test_expect_success 'replay with --allow-partial should not produce output when successful' '
    -+	git replay --allow-partial --onto main topic1..topic3 >output &&
    -+	test_must_be_empty output
    -+'
    -+
    -+test_expect_success 'replay fails when --output-commands and --allow-partial are used together' '
    -+	test_must_fail git replay --output-commands --allow-partial --onto main topic1..topic2 2>error &&
    -+	grep "cannot be used together" error
    -+'
    ++# Tests for atomic ref update behavior
     +
     +test_expect_success 'replay with --contained updates multiple branches atomically' '
    -+	# Create fresh test branches based on the original structure
    -+	# contained-topic1 should be contained within the range to contained-topic3
    -+	git branch contained-base main &&
    -+	git checkout -b contained-topic1 contained-base &&
    -+	test_commit ContainedC &&
    -+	git checkout -b contained-topic3 contained-topic1 &&
    -+	test_commit ContainedG &&
    -+	test_commit ContainedH &&
    -+	git checkout main &&
    -+
     +	# Store original states
    -+	git rev-parse contained-topic1 >contained-topic1-old &&
    -+	git rev-parse contained-topic3 >contained-topic3-old &&
    -+
    -+	# Use --contained to update multiple branches - this should update both
    -+	git replay --contained --onto main contained-base..contained-topic3 &&
    -+
    -+	# Verify both branches were updated
    -+	git rev-parse contained-topic1 >contained-topic1-new &&
    -+	git rev-parse contained-topic3 >contained-topic3-new &&
    -+	! test_cmp contained-topic1-old contained-topic1-new &&
    -+	! test_cmp contained-topic3-old contained-topic3-new
    -+'
    ++	START_TOPIC1=$(git rev-parse topic1) &&
    ++	START_TOPIC3=$(git rev-parse topic3) &&
    ++	test_when_finished "git branch -f topic1 $START_TOPIC1 && git branch -f topic3 $START_TOPIC3" &&
     +
    -+test_expect_success 'replay atomic behavior: all refs updated or none' '
    -+	# Store original state
    -+	git rev-parse topic4 >topic4-old &&
    -+
    -+	# Default atomic behavior
    -+	git replay --onto main main..topic4 &&
    ++	# Use --contained to update multiple branches
    ++	git replay --contained --onto main main..topic3 >output &&
    ++	test_must_be_empty output &&
     +
    -+	# Verify ref was updated
    -+	git rev-parse topic4 >topic4-new &&
    -+	! test_cmp topic4-old topic4-new &&
    ++	# Verify both branches were updated with correct commit sequences
    ++	git log --format=%s topic1 >actual &&
    ++	test_write_lines F C M L B A >expect &&
    ++	test_cmp expect actual &&
     +
    -+	# Verify no partial state
    -+	git log --format=%s topic4 >actual &&
    -+	test_write_lines J I M L B A >expect &&
    ++	git log --format=%s topic3 >actual &&
    ++	test_write_lines H G F C M L B A >expect &&
     +	test_cmp expect actual
     +'
     +
    -+test_expect_success 'replay works correctly with bare repositories' '
    -+	# Test atomic behavior in bare repo (important for Gitaly)
    -+	git checkout -b bare-test topic1 &&
    -+	test_commit BareTest &&
    ++test_expect_success 'replay atomic guarantee: all refs updated or none' '
    ++	# Store original states
    ++	START_TOPIC1=$(git rev-parse topic1) &&
    ++	START_TOPIC3=$(git rev-parse topic3) &&
    ++	test_when_finished "git branch -f topic1 $START_TOPIC1 && git branch -f topic3 $START_TOPIC3 && rm -f .git/refs/heads/topic1.lock" &&
     +
    -+	# Test with bare repo - replay the commits from main..bare-test to get the full history
    -+	git -C bare fetch .. bare-test:bare-test &&
    -+	git -C bare replay --onto main main..bare-test &&
    ++	# Create a lock on topic1 to simulate a concurrent update
    ++	>.git/refs/heads/topic1.lock &&
     +
    -+	# Verify the bare repo was updated correctly (no output)
    -+	git -C bare log --format=%s bare-test >actual &&
    -+	test_write_lines BareTest F C M L B A >expect &&
    -+	test_cmp expect actual
    -+'
    ++	# Try to update multiple branches with --contained
    ++	# This should fail atomically - neither branch should be updated
    ++	test_must_fail git replay --contained --onto main main..topic3 2>error &&
     +
    -+test_expect_success 'replay --allow-partial with no failures produces no output' '
    -+	git checkout -b partial-test topic1 &&
    -+	test_commit PartialTest &&
    ++	# Verify the transaction failed
    ++	grep "failed to commit ref transaction" error &&
     +
    -+	# Should succeed silently even with partial mode
    -+	git replay --allow-partial --onto main topic1..partial-test >output &&
    -+	test_must_be_empty output
    ++	# Verify NEITHER branch was updated (all-or-nothing guarantee)
    ++	test_cmp_rev $START_TOPIC1 topic1 &&
    ++	test_cmp_rev $START_TOPIC3 topic3
     +'
     +
    -+test_expect_success 'replay maintains ref update consistency' '
    -+	# Test that traditional vs atomic produce equivalent results
    -+	git checkout -b method1-test topic2 &&
    -+	git checkout -b method2-test topic2 &&
    ++test_expect_success 'traditional pipeline and atomic update produce equivalent results' '
    ++	# Store original states
    ++	START_TOPIC2=$(git rev-parse topic2) &&
    ++	test_when_finished "git branch -f topic2 $START_TOPIC2" &&
     +
    -+	# Both methods should update refs to point to the same replayed commits
    -+	git replay --output-commands --onto main topic1..method1-test >update-commands &&
    ++	# Traditional method: output commands and pipe to update-ref
    ++	git replay --update-refs=print --onto main topic1..topic2 >update-commands &&
     +	git update-ref --stdin <update-commands &&
    -+	git log --format=%s method1-test >traditional-result &&
    ++	git log --format=%s topic2 >traditional-result &&
    ++
    ++	# Reset topic2
    ++	git branch -f topic2 $START_TOPIC2 &&
     +
    -+	# Direct atomic method should produce same commit history
    -+	git replay --onto main topic1..method2-test &&
    -+	git log --format=%s method2-test >atomic-result &&
    ++	# Atomic method: direct ref updates
    ++	git replay --onto main topic1..topic2 &&
    ++	git log --format=%s topic2 >atomic-result &&
     +
     +	# Both methods should produce identical commit histories
     +	test_cmp traditional-result atomic-result
     +'
     +
    -+test_expect_success 'replay error messages are helpful and clear' '
    -+	# Test that error messages are clear
    -+	test_must_fail git replay --output-commands --allow-partial --onto main topic1..topic2 2>error &&
    -+	grep "cannot be used together" error
    -+'
    -+
    -+test_expect_success 'replay with empty range produces no output and no changes' '
    -+	# Create a test branch for empty range testing
    -+	git checkout -b empty-test topic1 &&
    -+	git rev-parse empty-test >empty-test-before &&
    -+
    -+	# Empty range should succeed but do nothing
    -+	git replay --onto main empty-test..empty-test >output &&
    ++test_expect_success 'replay works correctly with bare repositories' '
    ++	# Test atomic behavior in bare repo
    ++	git -C bare fetch .. topic1:bare-test-branch &&
    ++	git -C bare replay --onto main main..bare-test-branch >output &&
     +	test_must_be_empty output &&
     +
    -+	# Branch should be unchanged
    -+	git rev-parse empty-test >empty-test-after &&
    -+	test_cmp empty-test-before empty-test-after
    ++	# Verify the bare repo was updated correctly
    ++	git -C bare log --format=%s bare-test-branch >actual &&
    ++	test_write_lines F C M L B A >expect &&
    ++	test_cmp expect actual
    ++'
    ++
    ++test_expect_success 'replay validates --update-refs mode values' '
    ++	test_must_fail git replay --update-refs=invalid --onto main topic1..topic2 2>error &&
    ++	grep "invalid value for --update-refs" error
     +'
     +
      test_done
-:  ---------- > 3:  710ab27ae3 replay: add replay.defaultAction config option
-- 
2.51.0


Siddharth Asthana (3):
  replay: use die_for_incompatible_opt2() for option validation
  replay: make atomic ref updates the default behavior
  replay: add replay.defaultAction config option

 Documentation/config/replay.adoc |  14 +++
 Documentation/git-replay.adoc    |  71 ++++++-----
 builtin/replay.c                 | 108 +++++++++++++++--
 t/t3650-replay-basics.sh         | 198 +++++++++++++++++++++++++++++--
 4 files changed, 343 insertions(+), 48 deletions(-)
 create mode 100644 Documentation/config/replay.adoc

base-commit: 4b71b294773cc4f7fe48ec3a70079aa8783f373d

Thanks
- Siddharth

Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CFE2D94A4
	for <git@vger.kernel.org>; Thu,  6 Nov 2025 19:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762457559; cv=none; b=FUdB1g6bNnN62MhVblrXYVHuO8xo9S9peWdPJJWqZH0HX3/1Hg4WkqV/p2IiS6pBvlfvj1xGapu+I/rgpBCpdC7aPXZV7AZq06nPDndpRBlVo4bsMdqORxV9OCBaZsBZPIFY3u/tM3/e8ISx61z9+6zLAR0q/brLRB3rUCOJl4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762457559; c=relaxed/simple;
	bh=0nT+o/mIkuLPSSCNFYT1Q5rTcvafw0exBcc1pUBf9iM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VZqW7dUq3p0Jgxpwm24ZOYQU8g6r19Ms0ppxDzLIDYoWk4kQarqFYX8NT0FrOO2CEB4PS+IJiMsl6YqoyyMtiuh9058ahrQfknXO/A/J4w2KIDVHsleQWVKJ8vy4JGjoA7PqBn0NfCPcQjR/Ju7M6bO3go+oF7ERFI1/TmnQE2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IoD0eU9z; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IoD0eU9z"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-4332acf24e2so6275215ab.1
        for <git@vger.kernel.org>; Thu, 06 Nov 2025 11:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762457556; x=1763062356; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XFI58f0XoXMWWBlqwh/KPda+qP4QcMRK+3Q0MhfXpXw=;
        b=IoD0eU9z0k4gDzI3AuZSxnuxKyO3wdHYnSZrPZH5nmYhxvfy6j7elA1ePf3JCsE4rQ
         jUttH4sp6n+hFdANUM2BIoPeuqNYbkzo2T8fhzZGMUllm0ntLvl2dukRV//oZos040Xr
         cl16AaSzBLY9Hj8OkmXbbcnCdmSIuYRXtTeZ03Jo3dqE8kTyFlx4pSOwytNjUlM3fb+6
         zxDfagJTkkZCSlf9WP4z0oQWKSl62hq0eJikOavqbZMl7RkutHJwbDiP0Of5/j9Yx1Pq
         Cn7H+eVsrj/meR2AbsNkRMpSRV1K+uZaMd2qg3SoaixucWFxejb1TqeKlFe+mzGRVQUv
         NNrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762457556; x=1763062356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XFI58f0XoXMWWBlqwh/KPda+qP4QcMRK+3Q0MhfXpXw=;
        b=gIRwWq167cZlxlTTia1h/xgOlbrU7XODUvWpA45eh+1QPH/N8FroFYGu4WHNDZA88m
         gyBrRN+8oOhZWBOPy1QPkKm1SbfU66xOXy+P4vA7YA3RQ2LES64yb3szWxPVtlcfhggr
         v35cKa9wRvf6E5sTE56pfh5icQZv9cNnO33q0tmvbkR/WFzR0HCMQXWhY5EeO7TUrS+Q
         EiNmtbNeZfLZAU4ZK8o6Q+FGN2C7bin/to4IapXBwYC0eC5VAkEqSmIXA7NIztW7vtOa
         K1YNbGjJXCL+4SzgnoMQnaLrQ10mnVncBLn5ipUAABgMig8fOgbpMwNQVvlagsqVchWY
         csiA==
X-Gm-Message-State: AOJu0YxaSPoeVdeoE2NhWmbOo2VSH+iLbQiME1TKeEqwBWg5GvHJ01RC
	75Vw7XkaSSybrqYmuxI1RL8PR8CcOjBpPHNUb6xIgz0btREmLAqFE8Sn0dLcRUEgTi6wG52+HlL
	qH3y4zvzCyojOQLn4qqU0qRxAjJJ9zX28ZA==
X-Gm-Gg: ASbGncvzed5uo7+vFv8hRYd+/f95dy4N+LEjwooWSNwJp31vpHmfO2JyXVEcM0dNTJ4
	erNnTE723anDMuVmrC8LLEua/bW1ubktvCrxkYErjxPArv8F99g8AYMqI0kjVxtOy10Kfl5XdT3
	ZRryVJivThRbodT4loQ1JXWjSa5sMikqB8EG7nfQnF+gdWGqLBECIX5PWKr8p70znphdSlOo6f/
	mKY1ABnj5AQJwj9LehF26mGMvqK+hwgffabudVCJF4+m3OnGRr5JUOVowh8H7Y1U4E6VprbRH0=
X-Google-Smtp-Source: AGHT+IF2z0uDWR/lo80BN8bQjagXP5Kx/IjKnOVv/IcVgi3Pba5RjupNMbxvZ9IiLGNUdEiKx0qwB4a6VV+tBuBa9WY=
X-Received: by 2002:a05:6e02:1d91:b0:433:2b83:33ed with SMTP id
 e9e14a558f8ab-4335f3d0a0dmr10354245ab.9.1762457555612; Thu, 06 Nov 2025
 11:32:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030191931.30837-1-siddharthasthana31@gmail.com> <20251105191650.89975-1-siddharthasthana31@gmail.com>
In-Reply-To: <20251105191650.89975-1-siddharthasthana31@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 6 Nov 2025 11:32:23 -0800
X-Gm-Features: AWmQ_bnB8twNi-YvdpB_xeCqblFp4jz7v_XG7GVMBAICy2tGjPQv1jnvN7yF4MA
Message-ID: <CABPp-BE+-EvQhRBQy22kt9+p8Zw2fOS4oR+UBRZAgcxRhaxS9A@mail.gmail.com>
Subject: Re: [PATCH v7 0/3] replay: make atomic ref updates the default
To: Siddharth Asthana <siddharthasthana31@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, phillip.wood123@gmail.com, 
	phillip.wood@dunelm.org.uk, gitster@pobox.com, ps@pks.im, 
	karthik.188@gmail.com, code@khaugsbakk.name, rybak.a.v@gmail.com, 
	jltobler@gmail.com, toon@iotcl.com, johncai86@gmail.com, 
	johannes.schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 11:17=E2=80=AFAM Siddharth Asthana
<siddharthasthana31@gmail.com> wrote:
>
> This is v7 of the git-replay atomic updates series.
>
> This version addresses all feedback from v6 reviews. Thanks to Elijah,
> Christian, and Phillip for the thorough reviews that helped refine the
> implementation to Git standards.
>
> ## Changes in v7
>
> **Improved commit message clarity**
>
> Per Elijah's feedback, simplified commit messages by removing redundant
> sections:
>   - Removed "Implementation details" section (details visible in diff)
>   - Shortened "Test suite changes" to focus on what's tested
>   - Removed command-line precedence paragraph (obvious from code)
>   - Removed "Examples" and configuration precedence sections
>
> **Fixed test cleanup and isolation**
>
> Following Elijah's suggestions:
>   - Used test_when_finished with proper state restoration in atomic tests
>   - Created separate test-atomic branch to avoid contaminating topic2
>   - Fixed bare repository test to use START variable for cleanup
>   - Improved test reliability by rebuilding expectations independently
>
> **Extracted parse_ref_action_mode() to appropriate commit**
>
> Per Christian's observation, moved the parse_ref_action_mode() helper
> function from Commit 3 to Commit 2 where it's first used. This makes
> the patch progression more logical.
>
> **Fixed parameter naming consistency**
>
> Following Christian's feedback, used consistent naming throughout:
>   - ref_action (string parameter for command-line/config value)
>   - ref_mode (enum variable for internal mode)
> This eliminates confusion and improves code readability.
>
> **Moved config reference to correct commit**
>
> Per Elijah's note, moved the sentence about replay.refAction config
> from Commit 2's documentation to Commit 3 where the config is actually
> introduced.
>
> **Enhanced reflog messages**
>
> Following Phillip's suggestions for better user experience:
>   - --advance mode: "replay --advance <branch-name>" (uses user input)
>   - --onto mode: "replay --onto <commit-sha>" (precise commit reference)
> Added comprehensive reflog testing to verify messages.
>
> **Fixed indentation in Commit 3**
>
> Corrected indentation within the while (decoration) loop per CI
> feedback, adding proper tabs to nested if statements.
>
> **Fixed coding style**
>
> Per CI check-style feedback, removed braces from single-statement
> if-else blocks following Git's CodingGuidelines.
>
> **Split config tests for clarity**
>
> Separated the replay.refAction config test into two distinct tests:
>   - replay.refAction=3Dprint config option
>   - replay.refAction=3Dupdate config option
> This improves test clarity and makes failures easier to diagnose.
>
> ## Technical Implementation
>
> The atomic ref updates leverage Git's ref transaction API:
>   - ref_store_transaction_begin() with default atomic behavior
>   - ref_transaction_update() to stage each update
>   - ref_transaction_commit() for atomic application
>
> The helper functions provide clean separation:
>   - parse_ref_action_mode(): Validates strings and converts to enum
>   - get_ref_action_mode(): Implements command-line > config > default pre=
cedence
>   - handle_ref_update(): Uses type-safe enum with switch statement
>
> Reflog messages are constructed dynamically based on replay mode and
> include either the branch name (--advance) or commit SHA (--onto) for
> clear audit trails.
>
> ## Testing
>
> All tests pass:
>   - t3650-replay-basics.sh (22 tests pass)
>   - Config tests verify proper precedence and error handling
>   - Atomic behavior tests verify direct ref updates
>   - Reflog tests verify descriptive messages
>   - Backward compatibility maintained for pipeline workflow
>
> CI results: https://gitlab.com/gitlab-org/git/-/pipelines/2140425748
>
> Siddharth Asthana (3):
>   replay: use die_for_incompatible_opt2() for option validation
>   replay: make atomic ref updates the default behavior
>   replay: add replay.refAction config option
>
>  Documentation/config/replay.adoc |  11 +++
>  Documentation/git-replay.adoc    |  63 ++++++++++-----
>  builtin/replay.c                 | 133 ++++++++++++++++++++++++++++---
>  t/t3650-replay-basics.sh         | 113 ++++++++++++++++++++++++--
>  4 files changed, 277 insertions(+), 43 deletions(-)
>  create mode 100644 Documentation/config/replay.adoc
>
> Range-diff against v6:
> 1:  1f0fad0cac =3D 1:  9e4eab2df2 replay: use die_for_incompatible_opt2()=
 for option validation
> 2:  bfc6188234 ! 2:  1602f6097e replay: make atomic ref updates the defau=
lt behavior
>     @@ Commit message
>           * update (default): Update refs directly using an atomic transa=
ction
>           * print: Output update-ref commands for pipeline use
>
>     -    Implementation details:
>     -
>     -    The atomic ref updates are implemented using Git's ref transacti=
on API.
>     -    In cmd_replay(), when not in `print` mode, we initialize a trans=
action
>     -    using ref_store_transaction_begin() with the default atomic beha=
vior.
>     -    As commits are replayed, ref updates are staged into the transac=
tion
>     -    using ref_transaction_update(). Finally, ref_transaction_commit(=
)
>     -    applies all updates atomically=E2=80=94either all updates succee=
d or none do.
>     -
>     -    To avoid code duplication between the 'print' and 'update' modes=
, this
>     -    commit extracts a handle_ref_update() helper function. This func=
tion
>     -    takes the mode (as an enum) and either prints the update command=
 or
>     -    stages it into the transaction. Using an enum rather than passin=
g the
>     -    string around provides type safety and allows the compiler to ca=
tch
>     -    typos. The switch statement makes it easy to add future modes.
>     -
>     -    The helper function signature:
>     -
>     -      static int handle_ref_update(enum ref_action_mode mode,
>     -                                    struct ref_transaction *transact=
ion,
>     -                                    const char *refname,
>     -                                    const struct object_id *new_oid,
>     -                                    const struct object_id *old_oid,
>     -                                    struct strbuf *err)
>     -
>     -    The enum is defined as:
>     -
>     -      enum ref_action_mode {
>     -          REF_ACTION_UPDATE,
>     -          REF_ACTION_PRINT
>     -      };
>     -
>     -    The mode string is converted to enum immediately after parse_opt=
ions()
>     -    to avoid string comparisons throughout the codebase and provide =
compiler
>     -    protection against typos.
>     -
>          Test suite changes:
>
>          All existing tests that expected command output now use
>     @@ Commit message
>           - Equivalence between traditional pipeline and atomic updates
>           - Real atomicity using a lock file to verify all-or-nothing gua=
rantee
>           - Test isolation using test_when_finished to clean up state
>     -
>     -    The bare repository tests were fixed to rebuild their expectatio=
ns
>     -    independently rather than comparing to previous test output, imp=
roving
>     -    test reliability and isolation.
>     +      - Reflog messages include replay mode and target
>
>          A following commit will add a replay.refAction configuration
>          option for users who prefer the traditional pipeline output as t=
heir
>     @@ Documentation/git-replay.adoc: OPTIONS
>      -commits, similar to the way how `git rebase --update-refs` updates
>      -multiple branches in the affected range.
>      +When `--onto` is specified, the branch(es) in the revision range wi=
ll be
>     -+updated to point at the new commits (or update commands will be pri=
nted
>     -+if `--ref-action=3Dprint` is used), similar to the way `git rebase =
--update-refs`
>     ++updated to point at the new commits, similar to the way `git rebase=
 --update-refs`
>      +updates multiple branches in the affected range.
>
>       --advance <branch>::
>     @@ Documentation/git-replay.adoc: OPTIONS
>      -will update the branch passed as an argument to `--advance` to poin=
t at
>      -the new commits (in other words, this mimics a cherry-pick operatio=
n).
>      +The history is replayed on top of the <branch> and <branch> is upda=
ted to
>     -+point at the tip of the resulting history (or an update command wil=
l be
>     -+printed if `--ref-action=3Dprint` is used). This is different from =
`--onto`,
>     ++point at the tip of the resulting history. This is different from `=
--onto`,
>      +which uses the target only as a starting point without updating it.
>      +
>      +--ref-action[=3D<mode>]::
>     @@ Documentation/git-replay.adoc: OPTIONS
>      +  * `print`: Output update-ref commands for pipeline use. This is t=
he
>      +    traditional behavior where output can be piped to `git update-r=
ef --stdin`.
>      +--
>     -++
>     -+The default mode can be configured via the `replay.refAction` confi=
guration variable.
>
>       <revision-range>::
>         Range of commits to replay. More than one <revision-range> can
>     @@ builtin/replay.c: static struct commit *pick_regular_commit(struct=
 repository *r
>         return create_commit(repo, result->tree, pickme, replayed_base);
>       }
>
>     ++static enum ref_action_mode parse_ref_action_mode(const char *ref_a=
ction, const char *source)
>     ++{
>     ++  if (!ref_action || !strcmp(ref_action, "update"))
>     ++          return REF_ACTION_UPDATE;
>     ++  if (!strcmp(ref_action, "print"))
>     ++          return REF_ACTION_PRINT;
>     ++  die(_("invalid %s value: '%s'"), source, ref_action);
>     ++}
>     ++
>      +static int handle_ref_update(enum ref_action_mode mode,
>      +                       struct ref_transaction *transaction,
>      +                       const char *refname,
>      +                       const struct object_id *new_oid,
>      +                       const struct object_id *old_oid,
>     ++                       const char *reflog_msg,
>      +                       struct strbuf *err)
>      +{
>      +  switch (mode) {
>     @@ builtin/replay.c: static struct commit *pick_regular_commit(struct=
 repository *r
>      +          return 0;
>      +  case REF_ACTION_UPDATE:
>      +          return ref_transaction_update(transaction, refname, new_o=
id, old_oid,
>     -+                                        NULL, NULL, 0, "git replay"=
, err);
>     ++                                        NULL, NULL, 0, reflog_msg, =
err);
>      +  default:
>      +          BUG("unknown ref_action_mode %d", mode);
>      +  }
>     @@ builtin/replay.c: int cmd_replay(int argc,
>         struct commit *onto =3D NULL;
>         const char *onto_name =3D NULL;
>         int contained =3D 0;
>     -+  const char *ref_action_str =3D NULL;
>     -+  enum ref_action_mode ref_action =3D REF_ACTION_UPDATE;
>     ++  const char *ref_action =3D NULL;
>     ++  enum ref_action_mode ref_mode =3D REF_ACTION_UPDATE;
>
>         struct rev_info revs;
>         struct commit *last_commit =3D NULL;
>     @@ builtin/replay.c: int cmd_replay(int argc,
>         kh_oid_map_t *replayed_commits;
>      +  struct ref_transaction *transaction =3D NULL;
>      +  struct strbuf transaction_err =3D STRBUF_INIT;
>     ++  struct strbuf reflog_msg =3D STRBUF_INIT;
>         int ret =3D 0;
>
>      -  const char * const replay_usage[] =3D {
>     @@ builtin/replay.c: int cmd_replay(int argc,
>                            N_("replay onto given commit")),
>                 OPT_BOOL(0, "contained", &contained,
>                          N_("advance all branches contained in revision-r=
ange")),
>     -+          OPT_STRING(0, "ref-action", &ref_action_str,
>     ++          OPT_STRING(0, "ref-action", &ref_action,
>      +                     N_("mode"),
>      +                     N_("control ref update behavior (update|print)=
")),
>                 OPT_END()
>     @@ builtin/replay.c: int cmd_replay(int argc,
>         die_for_incompatible_opt2(!!advance_name_opt, "--advance",
>                                   contained, "--contained");
>
>     -+  /* Default to update mode if not specified */
>     -+  if (!ref_action_str)
>     -+          ref_action_str =3D "update";
>     -+
>     -+  /* Validate ref-action mode */
>     -+  if (!strcmp(ref_action_str, "update"))
>     -+          ref_action =3D REF_ACTION_UPDATE;
>     -+  else if (!strcmp(ref_action_str, "print"))
>     -+          ref_action =3D REF_ACTION_PRINT;
>     -+  else
>     -+          die(_("unknown --ref-action mode '%s'"), ref_action_str);
>     ++  /* Parse ref action mode */
>     ++  if (ref_action)
>     ++          ref_mode =3D parse_ref_action_mode(ref_action, "--ref-act=
ion");
>      +
>         advance_name =3D xstrdup_or_null(advance_name_opt);
>
>     @@ builtin/replay.c: int cmd_replay(int argc,
>         determine_replay_mode(repo, &revs.cmdline, onto_name, &advance_na=
me,
>                               &onto, &update_refs);
>
>     ++  /* Build reflog message */
>     ++  if (advance_name_opt)
>     ++          strbuf_addf(&reflog_msg, "replay --advance %s", advance_n=
ame_opt);
>     ++  else
>     ++          strbuf_addf(&reflog_msg, "replay --onto %s",
>     ++                      oid_to_hex(&onto->object.oid));
>     ++
>      +  /* Initialize ref transaction if using update mode */
>     -+  if (ref_action =3D=3D REF_ACTION_UPDATE) {
>     ++  if (ref_mode =3D=3D REF_ACTION_UPDATE) {
>      +          transaction =3D ref_store_transaction_begin(get_main_ref_=
store(repo),
>      +                                                    0, &transaction=
_err);
>      +          if (!transaction) {
>     @@ builtin/replay.c: int cmd_replay(int argc,
>      -                                 decoration->name,
>      -                                 oid_to_hex(&last_commit->object.oi=
d),
>      -                                 oid_to_hex(&commit->object.oid));
>     -+                          if (handle_ref_update(ref_action, transac=
tion,
>     ++                          if (handle_ref_update(ref_mode, transacti=
on,
>      +                                                decoration->name,
>      +                                                &last_commit->objec=
t.oid,
>      +                                                &commit->object.oid=
,
>     ++                                                reflog_msg.buf,
>      +                                                &transaction_err) <=
 0) {
>      +                                  ret =3D error(_("failed to update=
 ref '%s': %s"),
>      +                                              decoration->name, tra=
nsaction_err.buf);
>     @@ builtin/replay.c: int cmd_replay(int argc,
>      -                 advance_name,
>      -                 oid_to_hex(&last_commit->object.oid),
>      -                 oid_to_hex(&onto->object.oid));
>     -+          if (handle_ref_update(ref_action, transaction, advance_na=
me,
>     ++          if (handle_ref_update(ref_mode, transaction, advance_name=
,
>      +                                &last_commit->object.oid,
>      +                                &onto->object.oid,
>     ++                                reflog_msg.buf,
>      +                                &transaction_err) < 0) {
>      +                  ret =3D error(_("failed to update ref '%s': %s"),
>      +                              advance_name, transaction_err.buf);
>     @@ builtin/replay.c: int cmd_replay(int argc,
>      +  if (transaction)
>      +          ref_transaction_free(transaction);
>      +  strbuf_release(&transaction_err);
>     ++  strbuf_release(&reflog_msg);
>         release_revisions(&revs);
>         free(advance_name);
>
>     @@ t/t3650-replay-basics.sh: test_expect_success 'merge.directoryRena=
mes=3Dfalse' '
>       '
>
>      +test_expect_success 'default atomic behavior updates refs directly'=
 '
>     -+  # Store original state for cleanup
>     -+  test_when_finished "git branch -f topic2 topic1" &&
>     ++  # Use a separate branch to avoid contaminating topic2 for later t=
ests
>     ++  git branch test-atomic topic2 &&
>     ++  test_when_finished "git branch -D test-atomic" &&

I'm curious why you created an extra branch for this test, while...

>      +
>      +  # Test default atomic behavior (no output, refs updated)
>     -+  git replay --onto main topic1..topic2 >output &&
>     ++  git replay --onto main topic1..test-atomic >output &&
>      +  test_must_be_empty output &&
>      +
>      +  # Verify ref was updated
>     -+  git log --format=3D%s topic2 >actual &&
>     ++  git log --format=3D%s test-atomic >actual &&
>      +  test_write_lines E D M L B A >expect &&
>     -+  test_cmp expect actual
>     ++  test_cmp expect actual &&
>     ++
>     ++  # Verify reflog message includes SHA of onto commit
>     ++  git reflog test-atomic -1 --format=3D%gs >reflog-msg &&
>     ++  ONTO_SHA=3D$(git rev-parse main) &&
>     ++  echo "replay --onto $ONTO_SHA" >expect-reflog &&
>     ++  test_cmp expect-reflog reflog-msg
>      +'
>      +
>      +test_expect_success 'atomic behavior in bare repository' '
>     ++  # Store original state for cleanup
>     ++  START=3D$(git -C bare rev-parse topic2) &&
>     ++  test_when_finished "git -C bare update-ref refs/heads/topic2 $STA=
RT" &&

...just saving the location for topic2 in this test (and similarly
just saving the location for main in the next test).  It appears you
weren't doing anything special with the test-atomic branch, so I'm
curious why you didn't just use the same idiom for all three tests.

>     ++
>      +  # Test atomic updates work in bare repo
>      +  git -C bare replay --onto main topic1..topic2 >output &&
>      +  test_must_be_empty output &&
>     @@ t/t3650-replay-basics.sh: test_expect_success 'merge.directoryRena=
mes=3Dfalse' '
>      +  # Verify ref was updated in bare repo
>      +  git -C bare log --format=3D%s topic2 >actual &&
>      +  test_write_lines E D M L B A >expect &&
>     -+  test_cmp expect actual &&
>     ++  test_cmp expect actual
>     ++'
>     ++
>     ++test_expect_success 'reflog message for --advance mode' '
>     ++  # Store original state
>     ++  START=3D$(git rev-parse main) &&
>     ++  test_when_finished "git update-ref refs/heads/main $START" &&
>     ++
>     ++  # Test --advance mode reflog message
>     ++  git replay --advance main topic1..topic2 >output &&
>     ++  test_must_be_empty output &&
>      +
>     -+  # Reset for other tests
>     -+  git -C bare update-ref refs/heads/topic2 $(git -C bare rev-parse =
topic1)
>     ++  # Verify reflog message includes --advance and branch name
>     ++  git reflog main -1 --format=3D%gs >reflog-msg &&
>     ++  echo "replay --advance main" >expect-reflog &&
>     ++  test_cmp expect-reflog reflog-msg
>      +'
>      +
>       test_done
> -:  ---------- > 3:  b7ebe1f534 replay: add replay.refAction config optio=
n

There was a third patch in v6, but it doesn't show up in your
range-diff?  Did you specify the range incorrectly by chance when you
generated this?

Anyway, I looked over the patches as well as the range-diff.  There is
the slight surprise I had in your lack of consistency with idiom
choice in the tests, but that's pretty minor and probably doesn't
merit a re-roll.  This version looks good to me; thanks for working on
it!

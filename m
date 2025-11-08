Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02572AD51
	for <git@vger.kernel.org>; Sat,  8 Nov 2025 13:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762608159; cv=none; b=f0FMh3qBYbedb1f496ddhfabY0coVMQY4xTdP4f5/Q7S4vOYasnHEtLwFh9GoQXh33SYhYmFZTY/IdNMH1T3rji1gIq24oaRiQt+ZjDN00eZu5zXCN8InmQ5pEkCH6wUQSMp2SxZpUCA7fXInvU4booygg7EB611xnTLXmMOyHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762608159; c=relaxed/simple;
	bh=MPkdZ5Zy5l6Mvn2iyF54ux3x58K/FeLwLFO+i2G+Eio=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n6E9MC2RaJTOanS3hZlEgeHu5s6dFxk8kgaCcbQvBjpKQvWNDAbSauWXnJnYz3kZS4rcWT4az8+JFBwt3eMNkv1OP8Wl4EcJ3lXzwQuXOjAkBY4GIwvNV3HCLpIl5xpxIZ0xwSDLad/7szb3JX6OuXi6B7GGK2S0Oghd2JdqXZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XNs2IE8i; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNs2IE8i"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b98a619f020so1447525a12.2
        for <git@vger.kernel.org>; Sat, 08 Nov 2025 05:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762608156; x=1763212956; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m3BadVEkP/oS+17pv99NXQD+sFP9hvEUYka2MF4mZzE=;
        b=XNs2IE8i+X2xfSDXNZynQ4Y0J2iOwXq5zGRHEIOArzhGSd6aOYnpuIQl5NSg/x+93J
         0R6tHqw6KbMvGawMUYg/uQheQdcAcU1nwB++Ejyw7WAOf5OzzQZH2kdvPN4YN6nUlIcr
         RdJCDI+7z3GHUvBqHvSLkq1BfwkWLGCy9TAV80FPAsyQ+GJzNxF5d/KHLfX38pSk3RrY
         0neEXsElctYRtrY48ABFAco5vdGetrDKxJp3x9I8Qy+P/CfxGESjM1yudo8gXQuuK3Cl
         wGUlI8l+eIV9jaCNeOuE/Q8aggl/fT2NIxVxaIXMVTSgIU+CLEr3NjsJTPk6C1uJEcDO
         PMNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762608156; x=1763212956;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m3BadVEkP/oS+17pv99NXQD+sFP9hvEUYka2MF4mZzE=;
        b=cPFvjfDal41skH/mJvHVLx5WiZiAFq/txXFjb47OUJZvWXGeieW7yKEmnLaugEqWdS
         +X7zlV38L5gEfuNvD133cpAhHpSdM7m/o8kuXlZGSd6q4ldN3VK1rdibqrIZXgF2VaCi
         yEMKeFGl2NRP+Rs8FFhjelFJCJtUnonoqDGbmpXdXO9cTmSpeCYplqkmkbfFOBDgrQNV
         5yv/28/VPhFSL13bOHoqJ5te79DpsdJjF08sKRTzwrL9nCovypfkAJNYsAn1jZ0OxUxK
         gyfyo6fs/68I+7SRf1xrTFt/YbqNwTdizKdPq42ePZuEE1DugB6MVyk2UGEbqdSToUt/
         toyQ==
X-Gm-Message-State: AOJu0YxpzUka8sunXWsM3jlKeSUbqFRdjeODiZDCQbYluv+Sqv4hCPO3
	Lh1SexiyzWXXhj5yXMp5CiiuISkwalNvO3GXIVAWWqOEWDjVxsPox/fK
X-Gm-Gg: ASbGnct5O7zogMKodedfcLfmvvDk9nTcGgwpWANYfNnlxy0TI8/KjYFFoCMOnokhCyX
	KsGrgIfgWU4Z4m0A6kKRSTq8MBBs+Yq63KKSQk+hSg3avzu/1YDNJFxkCvVmk3ITWvs24H1O0GW
	B11+/dc3IrhJcsWx/+y8108gCP8D8RqcMmqvwKRDrDTi2On7hL2CSu4FkRbgMb5ZB9Qp6GG5Gnd
	V/AQlnFSPYcYEdD0WCgzOmFF6T87VdG9qMDr3zSdiPcw7//qQCpZuNsx2HTzYjlCeF35sWJV82B
	S7i1sKDSWesN9XJ9wLRS1xYLjyWeAqoHBFvS4Syxn5RpT7QxWY/ZsJ5UMMYNPeb3ly+7LFEpGUl
	bTQqjtNCAoMf9pDKd7dLLnlYsmjbxxL1IKTRehbe81QwTMvbIYdh0KGWIoz3YVXTH9yjOipBACD
	LHLdacEyovehL/k3wQHnO5K0vBM4jzNX1/PF1Slz+NIq4Erhh9HkJ8cUdkXpTrpOfjtBjoKma04
	fmPzEa0dH8F84bTJnVRmD997WwAmDgGZZ3xRVOd2HmydMN6a4pEAwp0qn8nITVoUg==
X-Google-Smtp-Source: AGHT+IFhLMFAW4KzzPOwNgPgvTzP7p/Rh309xP9zxxlDTxuw0BCANZtQ9JvQ5r8hqtaLggg9ohmkSQ==
X-Received: by 2002:a17:902:f54e:b0:277:3488:787e with SMTP id d9443c01a7336-297e53e7704mr33242365ad.12.1762608156037;
        Sat, 08 Nov 2025 05:22:36 -0800 (PST)
Received: from ?IPV6:2409:40e3:177:42ef:1944:c2f8:4a03:72f7? ([2409:40e3:177:42ef:1944:c2f8:4a03:72f7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650c5c71dsm89344185ad.31.2025.11.08.05.22.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Nov 2025 05:22:35 -0800 (PST)
Message-ID: <0545bc77-8d69-4cf5-8d1c-ba59035eb556@gmail.com>
Date: Sat, 8 Nov 2025 18:52:28 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/3] replay: make atomic ref updates the default
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com,
 phillip.wood123@gmail.com, phillip.wood@dunelm.org.uk, gitster@pobox.com,
 ps@pks.im, karthik.188@gmail.com, code@khaugsbakk.name, rybak.a.v@gmail.com,
 jltobler@gmail.com, toon@iotcl.com, johncai86@gmail.com,
 johannes.schindelin@gmx.de
References: <20251030191931.30837-1-siddharthasthana31@gmail.com>
 <20251105191650.89975-1-siddharthasthana31@gmail.com>
 <CABPp-BE+-EvQhRBQy22kt9+p8Zw2fOS4oR+UBRZAgcxRhaxS9A@mail.gmail.com>
Content-Language: en-GB
From: Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <CABPp-BE+-EvQhRBQy22kt9+p8Zw2fOS4oR+UBRZAgcxRhaxS9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 07/11/25 01:02, Elijah Newren wrote:
> On Wed, Nov 5, 2025 at 11:17 AM Siddharth Asthana
> <siddharthasthana31@gmail.com> wrote:
>> This is v7 of the git-replay atomic updates series.
>>
>> This version addresses all feedback from v6 reviews. Thanks to Elijah,
>> Christian, and Phillip for the thorough reviews that helped refine the
>> implementation to Git standards.
>>
>> ## Changes in v7
>>
>> **Improved commit message clarity**
>>
>> Per Elijah's feedback, simplified commit messages by removing redundant
>> sections:
>>    - Removed "Implementation details" section (details visible in diff)
>>    - Shortened "Test suite changes" to focus on what's tested
>>    - Removed command-line precedence paragraph (obvious from code)
>>    - Removed "Examples" and configuration precedence sections
>>
>> **Fixed test cleanup and isolation**
>>
>> Following Elijah's suggestions:
>>    - Used test_when_finished with proper state restoration in atomic tests
>>    - Created separate test-atomic branch to avoid contaminating topic2
>>    - Fixed bare repository test to use START variable for cleanup
>>    - Improved test reliability by rebuilding expectations independently
>>
>> **Extracted parse_ref_action_mode() to appropriate commit**
>>
>> Per Christian's observation, moved the parse_ref_action_mode() helper
>> function from Commit 3 to Commit 2 where it's first used. This makes
>> the patch progression more logical.
>>
>> **Fixed parameter naming consistency**
>>
>> Following Christian's feedback, used consistent naming throughout:
>>    - ref_action (string parameter for command-line/config value)
>>    - ref_mode (enum variable for internal mode)
>> This eliminates confusion and improves code readability.
>>
>> **Moved config reference to correct commit**
>>
>> Per Elijah's note, moved the sentence about replay.refAction config
>> from Commit 2's documentation to Commit 3 where the config is actually
>> introduced.
>>
>> **Enhanced reflog messages**
>>
>> Following Phillip's suggestions for better user experience:
>>    - --advance mode: "replay --advance <branch-name>" (uses user input)
>>    - --onto mode: "replay --onto <commit-sha>" (precise commit reference)
>> Added comprehensive reflog testing to verify messages.
>>
>> **Fixed indentation in Commit 3**
>>
>> Corrected indentation within the while (decoration) loop per CI
>> feedback, adding proper tabs to nested if statements.
>>
>> **Fixed coding style**
>>
>> Per CI check-style feedback, removed braces from single-statement
>> if-else blocks following Git's CodingGuidelines.
>>
>> **Split config tests for clarity**
>>
>> Separated the replay.refAction config test into two distinct tests:
>>    - replay.refAction=print config option
>>    - replay.refAction=update config option
>> This improves test clarity and makes failures easier to diagnose.
>>
>> ## Technical Implementation
>>
>> The atomic ref updates leverage Git's ref transaction API:
>>    - ref_store_transaction_begin() with default atomic behavior
>>    - ref_transaction_update() to stage each update
>>    - ref_transaction_commit() for atomic application
>>
>> The helper functions provide clean separation:
>>    - parse_ref_action_mode(): Validates strings and converts to enum
>>    - get_ref_action_mode(): Implements command-line > config > default precedence
>>    - handle_ref_update(): Uses type-safe enum with switch statement
>>
>> Reflog messages are constructed dynamically based on replay mode and
>> include either the branch name (--advance) or commit SHA (--onto) for
>> clear audit trails.
>>
>> ## Testing
>>
>> All tests pass:
>>    - t3650-replay-basics.sh (22 tests pass)
>>    - Config tests verify proper precedence and error handling
>>    - Atomic behavior tests verify direct ref updates
>>    - Reflog tests verify descriptive messages
>>    - Backward compatibility maintained for pipeline workflow
>>
>> CI results: https://gitlab.com/gitlab-org/git/-/pipelines/2140425748
>>
>> Siddharth Asthana (3):
>>    replay: use die_for_incompatible_opt2() for option validation
>>    replay: make atomic ref updates the default behavior
>>    replay: add replay.refAction config option
>>
>>   Documentation/config/replay.adoc |  11 +++
>>   Documentation/git-replay.adoc    |  63 ++++++++++-----
>>   builtin/replay.c                 | 133 ++++++++++++++++++++++++++++---
>>   t/t3650-replay-basics.sh         | 113 ++++++++++++++++++++++++--
>>   4 files changed, 277 insertions(+), 43 deletions(-)
>>   create mode 100644 Documentation/config/replay.adoc
>>
>> Range-diff against v6:
>> 1:  1f0fad0cac = 1:  9e4eab2df2 replay: use die_for_incompatible_opt2() for option validation
>> 2:  bfc6188234 ! 2:  1602f6097e replay: make atomic ref updates the default behavior
>>      @@ Commit message
>>            * update (default): Update refs directly using an atomic transaction
>>            * print: Output update-ref commands for pipeline use
>>
>>      -    Implementation details:
>>      -
>>      -    The atomic ref updates are implemented using Git's ref transaction API.
>>      -    In cmd_replay(), when not in `print` mode, we initialize a transaction
>>      -    using ref_store_transaction_begin() with the default atomic behavior.
>>      -    As commits are replayed, ref updates are staged into the transaction
>>      -    using ref_transaction_update(). Finally, ref_transaction_commit()
>>      -    applies all updates atomically—either all updates succeed or none do.
>>      -
>>      -    To avoid code duplication between the 'print' and 'update' modes, this
>>      -    commit extracts a handle_ref_update() helper function. This function
>>      -    takes the mode (as an enum) and either prints the update command or
>>      -    stages it into the transaction. Using an enum rather than passing the
>>      -    string around provides type safety and allows the compiler to catch
>>      -    typos. The switch statement makes it easy to add future modes.
>>      -
>>      -    The helper function signature:
>>      -
>>      -      static int handle_ref_update(enum ref_action_mode mode,
>>      -                                    struct ref_transaction *transaction,
>>      -                                    const char *refname,
>>      -                                    const struct object_id *new_oid,
>>      -                                    const struct object_id *old_oid,
>>      -                                    struct strbuf *err)
>>      -
>>      -    The enum is defined as:
>>      -
>>      -      enum ref_action_mode {
>>      -          REF_ACTION_UPDATE,
>>      -          REF_ACTION_PRINT
>>      -      };
>>      -
>>      -    The mode string is converted to enum immediately after parse_options()
>>      -    to avoid string comparisons throughout the codebase and provide compiler
>>      -    protection against typos.
>>      -
>>           Test suite changes:
>>
>>           All existing tests that expected command output now use
>>      @@ Commit message
>>            - Equivalence between traditional pipeline and atomic updates
>>            - Real atomicity using a lock file to verify all-or-nothing guarantee
>>            - Test isolation using test_when_finished to clean up state
>>      -
>>      -    The bare repository tests were fixed to rebuild their expectations
>>      -    independently rather than comparing to previous test output, improving
>>      -    test reliability and isolation.
>>      +      - Reflog messages include replay mode and target
>>
>>           A following commit will add a replay.refAction configuration
>>           option for users who prefer the traditional pipeline output as their
>>      @@ Documentation/git-replay.adoc: OPTIONS
>>       -commits, similar to the way how `git rebase --update-refs` updates
>>       -multiple branches in the affected range.
>>       +When `--onto` is specified, the branch(es) in the revision range will be
>>      -+updated to point at the new commits (or update commands will be printed
>>      -+if `--ref-action=print` is used), similar to the way `git rebase --update-refs`
>>      ++updated to point at the new commits, similar to the way `git rebase --update-refs`
>>       +updates multiple branches in the affected range.
>>
>>        --advance <branch>::
>>      @@ Documentation/git-replay.adoc: OPTIONS
>>       -will update the branch passed as an argument to `--advance` to point at
>>       -the new commits (in other words, this mimics a cherry-pick operation).
>>       +The history is replayed on top of the <branch> and <branch> is updated to
>>      -+point at the tip of the resulting history (or an update command will be
>>      -+printed if `--ref-action=print` is used). This is different from `--onto`,
>>      ++point at the tip of the resulting history. This is different from `--onto`,
>>       +which uses the target only as a starting point without updating it.
>>       +
>>       +--ref-action[=<mode>]::
>>      @@ Documentation/git-replay.adoc: OPTIONS
>>       +  * `print`: Output update-ref commands for pipeline use. This is the
>>       +    traditional behavior where output can be piped to `git update-ref --stdin`.
>>       +--
>>      -++
>>      -+The default mode can be configured via the `replay.refAction` configuration variable.
>>
>>        <revision-range>::
>>          Range of commits to replay. More than one <revision-range> can
>>      @@ builtin/replay.c: static struct commit *pick_regular_commit(struct repository *r
>>          return create_commit(repo, result->tree, pickme, replayed_base);
>>        }
>>
>>      ++static enum ref_action_mode parse_ref_action_mode(const char *ref_action, const char *source)
>>      ++{
>>      ++  if (!ref_action || !strcmp(ref_action, "update"))
>>      ++          return REF_ACTION_UPDATE;
>>      ++  if (!strcmp(ref_action, "print"))
>>      ++          return REF_ACTION_PRINT;
>>      ++  die(_("invalid %s value: '%s'"), source, ref_action);
>>      ++}
>>      ++
>>       +static int handle_ref_update(enum ref_action_mode mode,
>>       +                       struct ref_transaction *transaction,
>>       +                       const char *refname,
>>       +                       const struct object_id *new_oid,
>>       +                       const struct object_id *old_oid,
>>      ++                       const char *reflog_msg,
>>       +                       struct strbuf *err)
>>       +{
>>       +  switch (mode) {
>>      @@ builtin/replay.c: static struct commit *pick_regular_commit(struct repository *r
>>       +          return 0;
>>       +  case REF_ACTION_UPDATE:
>>       +          return ref_transaction_update(transaction, refname, new_oid, old_oid,
>>      -+                                        NULL, NULL, 0, "git replay", err);
>>      ++                                        NULL, NULL, 0, reflog_msg, err);
>>       +  default:
>>       +          BUG("unknown ref_action_mode %d", mode);
>>       +  }
>>      @@ builtin/replay.c: int cmd_replay(int argc,
>>          struct commit *onto = NULL;
>>          const char *onto_name = NULL;
>>          int contained = 0;
>>      -+  const char *ref_action_str = NULL;
>>      -+  enum ref_action_mode ref_action = REF_ACTION_UPDATE;
>>      ++  const char *ref_action = NULL;
>>      ++  enum ref_action_mode ref_mode = REF_ACTION_UPDATE;
>>
>>          struct rev_info revs;
>>          struct commit *last_commit = NULL;
>>      @@ builtin/replay.c: int cmd_replay(int argc,
>>          kh_oid_map_t *replayed_commits;
>>       +  struct ref_transaction *transaction = NULL;
>>       +  struct strbuf transaction_err = STRBUF_INIT;
>>      ++  struct strbuf reflog_msg = STRBUF_INIT;
>>          int ret = 0;
>>
>>       -  const char * const replay_usage[] = {
>>      @@ builtin/replay.c: int cmd_replay(int argc,
>>                             N_("replay onto given commit")),
>>                  OPT_BOOL(0, "contained", &contained,
>>                           N_("advance all branches contained in revision-range")),
>>      -+          OPT_STRING(0, "ref-action", &ref_action_str,
>>      ++          OPT_STRING(0, "ref-action", &ref_action,
>>       +                     N_("mode"),
>>       +                     N_("control ref update behavior (update|print)")),
>>                  OPT_END()
>>      @@ builtin/replay.c: int cmd_replay(int argc,
>>          die_for_incompatible_opt2(!!advance_name_opt, "--advance",
>>                                    contained, "--contained");
>>
>>      -+  /* Default to update mode if not specified */
>>      -+  if (!ref_action_str)
>>      -+          ref_action_str = "update";
>>      -+
>>      -+  /* Validate ref-action mode */
>>      -+  if (!strcmp(ref_action_str, "update"))
>>      -+          ref_action = REF_ACTION_UPDATE;
>>      -+  else if (!strcmp(ref_action_str, "print"))
>>      -+          ref_action = REF_ACTION_PRINT;
>>      -+  else
>>      -+          die(_("unknown --ref-action mode '%s'"), ref_action_str);
>>      ++  /* Parse ref action mode */
>>      ++  if (ref_action)
>>      ++          ref_mode = parse_ref_action_mode(ref_action, "--ref-action");
>>       +
>>          advance_name = xstrdup_or_null(advance_name_opt);
>>
>>      @@ builtin/replay.c: int cmd_replay(int argc,
>>          determine_replay_mode(repo, &revs.cmdline, onto_name, &advance_name,
>>                                &onto, &update_refs);
>>
>>      ++  /* Build reflog message */
>>      ++  if (advance_name_opt)
>>      ++          strbuf_addf(&reflog_msg, "replay --advance %s", advance_name_opt);
>>      ++  else
>>      ++          strbuf_addf(&reflog_msg, "replay --onto %s",
>>      ++                      oid_to_hex(&onto->object.oid));
>>      ++
>>       +  /* Initialize ref transaction if using update mode */
>>      -+  if (ref_action == REF_ACTION_UPDATE) {
>>      ++  if (ref_mode == REF_ACTION_UPDATE) {
>>       +          transaction = ref_store_transaction_begin(get_main_ref_store(repo),
>>       +                                                    0, &transaction_err);
>>       +          if (!transaction) {
>>      @@ builtin/replay.c: int cmd_replay(int argc,
>>       -                                 decoration->name,
>>       -                                 oid_to_hex(&last_commit->object.oid),
>>       -                                 oid_to_hex(&commit->object.oid));
>>      -+                          if (handle_ref_update(ref_action, transaction,
>>      ++                          if (handle_ref_update(ref_mode, transaction,
>>       +                                                decoration->name,
>>       +                                                &last_commit->object.oid,
>>       +                                                &commit->object.oid,
>>      ++                                                reflog_msg.buf,
>>       +                                                &transaction_err) < 0) {
>>       +                                  ret = error(_("failed to update ref '%s': %s"),
>>       +                                              decoration->name, transaction_err.buf);
>>      @@ builtin/replay.c: int cmd_replay(int argc,
>>       -                 advance_name,
>>       -                 oid_to_hex(&last_commit->object.oid),
>>       -                 oid_to_hex(&onto->object.oid));
>>      -+          if (handle_ref_update(ref_action, transaction, advance_name,
>>      ++          if (handle_ref_update(ref_mode, transaction, advance_name,
>>       +                                &last_commit->object.oid,
>>       +                                &onto->object.oid,
>>      ++                                reflog_msg.buf,
>>       +                                &transaction_err) < 0) {
>>       +                  ret = error(_("failed to update ref '%s': %s"),
>>       +                              advance_name, transaction_err.buf);
>>      @@ builtin/replay.c: int cmd_replay(int argc,
>>       +  if (transaction)
>>       +          ref_transaction_free(transaction);
>>       +  strbuf_release(&transaction_err);
>>      ++  strbuf_release(&reflog_msg);
>>          release_revisions(&revs);
>>          free(advance_name);
>>
>>      @@ t/t3650-replay-basics.sh: test_expect_success 'merge.directoryRenames=false' '
>>        '
>>
>>       +test_expect_success 'default atomic behavior updates refs directly' '
>>      -+  # Store original state for cleanup
>>      -+  test_when_finished "git branch -f topic2 topic1" &&
>>      ++  # Use a separate branch to avoid contaminating topic2 for later tests
>>      ++  git branch test-atomic topic2 &&
>>      ++  test_when_finished "git branch -D test-atomic" &&


Hi Elijah,

Thanks for the review and approval!


> I'm curious why you created an extra branch for this test, while...


Good catch on the inconsistency. The separate `test-atomic` branch was 
to avoid any potential contamination of `topic2` since multiple tests 
use it throughout the file. But you are right that the other tests just 
save/restore state directly.

For consistency, I could have used the same pattern everywhere. The 
current approach works but mixing idioms isn't ideal - I will keep this 
in mind for future patches.


>
>>       +
>>       +  # Test default atomic behavior (no output, refs updated)
>>      -+  git replay --onto main topic1..topic2 >output &&
>>      ++  git replay --onto main topic1..test-atomic >output &&
>>       +  test_must_be_empty output &&
>>       +
>>       +  # Verify ref was updated
>>      -+  git log --format=%s topic2 >actual &&
>>      ++  git log --format=%s test-atomic >actual &&
>>       +  test_write_lines E D M L B A >expect &&
>>      -+  test_cmp expect actual
>>      ++  test_cmp expect actual &&
>>      ++
>>      ++  # Verify reflog message includes SHA of onto commit
>>      ++  git reflog test-atomic -1 --format=%gs >reflog-msg &&
>>      ++  ONTO_SHA=$(git rev-parse main) &&
>>      ++  echo "replay --onto $ONTO_SHA" >expect-reflog &&
>>      ++  test_cmp expect-reflog reflog-msg
>>       +'
>>       +
>>       +test_expect_success 'atomic behavior in bare repository' '
>>      ++  # Store original state for cleanup
>>      ++  START=$(git -C bare rev-parse topic2) &&
>>      ++  test_when_finished "git -C bare update-ref refs/heads/topic2 $START" &&
> ...just saving the location for topic2 in this test (and similarly
> just saving the location for main in the next test).  It appears you
> weren't doing anything special with the test-atomic branch, so I'm
> curious why you didn't just use the same idiom for all three tests.
>
>>      ++
>>       +  # Test atomic updates work in bare repo
>>       +  git -C bare replay --onto main topic1..topic2 >output &&
>>       +  test_must_be_empty output &&
>>      @@ t/t3650-replay-basics.sh: test_expect_success 'merge.directoryRenames=false' '
>>       +  # Verify ref was updated in bare repo
>>       +  git -C bare log --format=%s topic2 >actual &&
>>       +  test_write_lines E D M L B A >expect &&
>>      -+  test_cmp expect actual &&
>>      ++  test_cmp expect actual
>>      ++'
>>      ++
>>      ++test_expect_success 'reflog message for --advance mode' '
>>      ++  # Store original state
>>      ++  START=$(git rev-parse main) &&
>>      ++  test_when_finished "git update-ref refs/heads/main $START" &&
>>      ++
>>      ++  # Test --advance mode reflog message
>>      ++  git replay --advance main topic1..topic2 >output &&
>>      ++  test_must_be_empty output &&
>>       +
>>      -+  # Reset for other tests
>>      -+  git -C bare update-ref refs/heads/topic2 $(git -C bare rev-parse topic1)
>>      ++  # Verify reflog message includes --advance and branch name
>>      ++  git reflog main -1 --format=%gs >reflog-msg &&
>>      ++  echo "replay --advance main" >expect-reflog &&
>>      ++  test_cmp expect-reflog reflog-msg
>>       +'
>>       +
>>        test_done
>> -:  ---------- > 3:  b7ebe1f534 replay: add replay.refAction config option
> There was a third patch in v6, but it doesn't show up in your
> range-diff?  Did you specify the range incorrectly by chance when you
> generated this?


The range-diff shows all three patches (1:1, 2:2, 3:3), but the third 
one appears as a new addition (-: → 3:) because it underwent significant 
restructuring between v6 and v7. The config-related changes were moved 
around between commits, making git see it as essentially new rather than 
modified.

Thanks for the thorough review throughout this series!

Siddharth


>
> Anyway, I looked over the patches as well as the range-diff.  There is
> the slight surprise I had in your lack of consistency with idiom
> choice in the tests, but that's pretty minor and probably doesn't
> merit a re-roll.  This version looks good to me; thanks for working on
> it!

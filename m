Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MSGID_YAHOO,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 197751F461
	for <e@80x24.org>; Sat,  7 Sep 2019 23:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393329AbfIGXob (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Sep 2019 19:44:31 -0400
Received: from mail-oi1-f180.google.com ([209.85.167.180]:44574 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbfIGXoa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Sep 2019 19:44:30 -0400
Received: by mail-oi1-f180.google.com with SMTP id w6so7893838oie.11
        for <git@vger.kernel.org>; Sat, 07 Sep 2019 16:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zMuy3kfRQhiYvtGu0LMM/RS5Eowd2kC0YE1sM/bzngU=;
        b=VeQho/AFweL26eIQC4SlegAr5eXJ5vBn+lG7yfUNCXF6NqKuYyPDpJfnvp2bkqyy3h
         STSQACUVN2inJma9HIkzNXMYWSl34IsmljVDOxMtKtd9+0FazU2RoOL3YEucEDB98AJN
         qoMNs1gSB0QZAFA+meiP5bYv+GkfO+O98Tyj/7AjVNkwdNDPXHtQYQSO0q5aZ5qTHejG
         73PnQkdlc5rPcB/QyYDK/DOUM/AZ4+/fCU8TuTBtcw/MVqv2o1hfJbB958xDVz8Co9my
         pWb4Y6keVcNW1cwYky7kUJB0faqAQiELIPH/Fdh3zilqk3E54dEtHDKmbiNmBzcF7GxZ
         7IHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zMuy3kfRQhiYvtGu0LMM/RS5Eowd2kC0YE1sM/bzngU=;
        b=qwwUctmhKjZmP6WDMLshW5b3JGKC6oX/JA7j4Nz6EGx82Z0EfOm/yZPrQuy1OsPV8P
         TPcH+Uu6fpvh7XF0+PlHleKG066IHqFjOVIl0IbjJ2YKPKDLJwN/Uz9oawkFsbX0gDSW
         3LCWu4ssx0uvfMyHjOxzrJNKICTJFWnYRzzjPq2BJTJ5J9hynXFV6UdGBSj7HT0KdV3B
         cUnGczRjgZkNZehfnitraFkVBXZRu+OH0bE8A88gJXxr4LmtyZGUAjvhEAOfCeS2mGeu
         SMhjnPYG1WyGjLqBpln7yVDvV9dmYwIUjbFnbZ/EdUS1kA3gSvtn6JCUNuYFOHnWzR59
         BEGg==
X-Gm-Message-State: APjAAAXxeTA9oPnZx636lcxfFAE6k1LYDiJ/+qVAgFYAh/Z84/0An/+D
        5dDG1K6v1yA7UEHio75V3o0=
X-Google-Smtp-Source: APXvYqy5TJdte556H2jPD4snN7K37AGjWkkI0zQX5j+mH1OIwHLzcJE7t+A2CTqGvQGhOph8Hblkkg==
X-Received: by 2002:aca:de55:: with SMTP id v82mr12549907oig.56.1567899869316;
        Sat, 07 Sep 2019 16:44:29 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:8a10:1290:ccab:112b:24b3:bd34])
        by smtp.gmail.com with ESMTPSA id 13sm3912081otv.14.2019.09.07.16.44.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Sep 2019 16:44:28 -0700 (PDT)
From:   Warren He <pickydaemon@gmail.com>
X-Google-Original-From: Warren He <wh109@yahoo.com>
To:     johannes.schindelin@gmx.de
Cc:     git@vger.kernel.org, pickydaemon@gmail.com, wh109@yahoo.com
Subject: [PATCH v2] rebase: introduce --update-branches option
Date:   Sat,  7 Sep 2019 16:44:12 -0700
Message-Id: <20190907234413.1591-1-wh109@yahoo.com>
X-Mailer: git-send-email 2.23.0.windows.1
In-Reply-To: <nycvar.QRO.7.76.6.1909031345330.46@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.1909031345330.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Everyone in this thread, thanks for your support and encouragement.

Johannes, thanks for reviewing.

> Maybe `s/reapplied/rebased/`?

Ok. I've changed most occurrences, except in Documentation/git-rebase.txt, where
the term 'reapplied' is already in use.

> drop this hunk and only keep the next one.

I didn't know that. (Actually, assume this for most of these responses.)
Dropped, thanks.

> It should not really imply `--interactive`, but `--rebase-merges`.

`imply_interactive` doesn't fully switch on `--interactive`, i.e., causing the
editor to open. It only selects the backend, which I think we're saying is the
right thing. I've dropped the `-i` from the test description.

And we don't really have to imply --rebase-merges, in case someone would prefer
to linearize things, which who knows? Running that non-rebase-merges command in
the example scenario from my original post should give something like this:

```
 A - B              (master)
       \
         F          (feat-f)
           \ 
             E      (feat-e)
               \
                 H  (my-dev)
```

So for now I haven't moved the implementation into `make_script_with_merges`.

> This loads also tags, correct? I am fairly certain that we don't want to
> update tags here, but maybe the check for `DECORATION_REF_LOCAL` later
> on already ensures that?

Right on both points. This isn't as efficient as possible, since we're wasting
the work of loading tags and remote refs. Currently I don't know if the
performance is worth the maintainability cost of replicating most of the
`load_ref_decorations` and `get_name_decoration` family of functions and global
variables though.

> How about using `is_pick_or_similar()` instead?

That's the function I need. Although I'm not aware of anything that generates
`edit` or `reword` commands before we'll call `todo_list_add_branch_updates`. I
ended up not needing further logic with `is_fixup`. See below for the new
handling of fixup chains.

> Please use C-style /* ... */ comments, Git insists on not using
> C++-style // comments.

Thanks for pointing that out. Changed.

> your code is careful to take care of the scenario where
> multiple local branches point to the pre-rebase `HEAD`. Good. Maybe you
> want to test for that in the regression test, too?

Ah, yes I do. It is added, with `my-hotfixes` = `HEAD` -> `my-dev` in the test.

> However, you have two `if` conditions that both guard the same
> operation: `continue`. How about combining the combinations? It's like
> saying: under these circumstances, we skip adding a command.

Ok. Combined.

> [several ways to simplify how we build todo items]

I had only looked at how `todo_list_add_exec_commands` works. Let's try doing it
with a full `struct todo_list` and `parse_insn_line`. Thanks for posting these
suggestions.

> [handling `fixup`/`squash` chains]

I've moved `todo_list_add_branch_updates` to run before
`todo_list_rearrange_squash`. The rearranging pulls fixups out, causing the
branch update to "fall" onto the items before, and reinserts them between a
commit and its branch update, casing them to be included in the updated branch.
which is my opinion of the right thing to do. I've added a test about this with
the following scenario:

```
 A - B  (master)
   \
     I - J - fixup! I                 (fixup-early)
		      \
			K - fixup! J  (fixup-late)
```

which results in the following todo list with `--autosquash`:

```
pick 9eadc32 I
fixup 265fa32 fixup! I
pick a0754fc J
fixup e7d1999 fixup! J
exec git branch -f fixup-early
pick c8bc4af K
```

> I'd like to suggest [`test_cmp_rev`] instead

I've updated the test to use `test_cmp_rev`. It's not with your suggested
invocation though. We don't update the `C` tag. I've referred to the rebased `C`
with `test_cmp_rev linear-early HEAD^` and similar for the other checks.

* * *

And then there's the discussion about using `exec git branch -f`. To summarize
the issues collected from the entire thread:

1. the changes aren't atomically applied at the end of the rebase
2. it fails when the branch is checked out in a worktree
3. it clobbers the branch if anything else updates it during the rebase
4. the way we prepare the unprefixed branch doesn't work right some exotic cases
5. the reflog message it leaves is uninformative

For #4, I think we've lucked out actually. The `load_ref_decorations` routine we
use determines that a ref is `DECORATION_REF_LOCAL` under the condition
`starts_with(refname, "refs/heads/")` (log-tree.c:114, add_ref_decoration), so
`prettify_refname` will find the prefix and skip it. But that's an invariant
maintained by two pieces of code pretty far away from each other.

For #5, for the convenience of readers, the reflog entry it leaves looks like this:

```
00873f2 feat-e@{0}: branch: Reset to HEAD
```

Not great.

I haven't made any changes to this yet, but I've thought about what I want. My
favorite so far is to add a new todo command that just does everything right. It
would make a temparary ref `refs/rewritten-heads/xxx` (or something), and update
`refs/heads/xxx` at the end.

I agree that requiring a separate update-ref step at the end of the todo list is
unfriendly. Manually putting in some branch update commands and then realizing
that they weren't applied would be extremely frustrating. I don't see the option
of using existing tools as the easiest-to-use solution.

I'm reluctant to combine this with the existing `label` command. So far it
sounds like we generally want to be more willing to skip branch updates while
performing the rebase, with aforementioned scenarios where something else
updates the branch before we do, or if the branch becomes checked out in a
worktree. We don't want to mess up the structure of a `rebase -r` as a result of
skipping some branch updates. I think it would be conceptually simpler and
implementation-wise less tricky if we didn't combine it with the `label` and
`reset` system.

Warren He (1):
  rebase: introduce --update-branches option

 Documentation/git-rebase.txt      |  9 ++++
 builtin/rebase.c                  | 11 ++++-
 sequencer.c                       | 58 +++++++++++++++++++++++-
 sequencer.h                       |  6 ++-
 t/t3431-rebase-update-branches.sh | 94 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 173 insertions(+), 5 deletions(-)
 create mode 100755 t/t3431-rebase-update-branches.sh

-- 
2.7.4


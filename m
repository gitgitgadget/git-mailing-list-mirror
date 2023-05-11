Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C131C77B7C
	for <git@archiver.kernel.org>; Thu, 11 May 2023 03:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjEKDOy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 May 2023 23:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbjEKDOo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2023 23:14:44 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274B8171C
        for <git@vger.kernel.org>; Wed, 10 May 2023 20:14:43 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6aafdeab6b0so3322833a34.0
        for <git@vger.kernel.org>; Wed, 10 May 2023 20:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683774882; x=1686366882;
        h=content-transfer-encoding:mime-version:subject:message-id:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ACVd2WZMx0FUe9LxrftFmrk1zPYqLHkRQJY3wKdaphU=;
        b=BcWzHvRrH3aAbAzs4PHxwgPabbAQY0wYfof/wKKiKr9qeWVMPr7JcmpsPLEeXkENY7
         G1eajWk9E4JujttJC/kEF6+fTavGyJXk4rQTcVfRVcWSFT7UcJ8K5yQ2nBEj2YZoJ3wd
         tNPCiB/F6XikQ5eh+nFcG7KzjMNsrS1A4CPyLTUbn+LBzknZug1jIQpjVvTKEb91QKZ4
         3NIoEb7ABMw1aV0kOHq1ynDfQLgzd9Bdwl6g0W5rmdbuQXzJKNxIDzS063Y9IDMUtO+E
         0u/tvz4UJWzKjLZMw6oqcKP0rreIs/tv95pLUVQmXRSLg8/A1r2YTEmFzy5cgECBepvU
         1R6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683774882; x=1686366882;
        h=content-transfer-encoding:mime-version:subject:message-id:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ACVd2WZMx0FUe9LxrftFmrk1zPYqLHkRQJY3wKdaphU=;
        b=i6U0r9FL8uet7uK/Tn7yhmt773Xn3L73SCFupp5Yhf4c16i20FL9aoXqDlFV3CXuEo
         bmAdXjTBLdhvvXe1rjZbNx1XQfPj2n7m8YG6hFnKytvcCvUW3sJdCUEMz4MGrxeXZPDU
         2a4Nv+xGmSg/wUbv0fMOeT4zU4xplwbIJxKsanozLYNp5YIu36b9Ux2+cwlMXBlSwGO/
         hCu5cjOjVZrvOQatFOrMMZXMLR3qLCVwKkvUBeoPGwGQEBqfR2kOrXobLM89N7RXUy4T
         mCsTNUonfzZrlaP05ndRJ4S4txgYZ5vXPcq+BV/Q5s+LvkTPCV79bclkHbukka+5LCuO
         o4sg==
X-Gm-Message-State: AC+VfDzGwKV43aRY51sJFopVFev2SshXWdZCeR2xBsylQV7i4RGBxztg
        0YDrzqoft74EdRNCpYy1Yj7/dHyVea0=
X-Google-Smtp-Source: ACHHUZ7TCSrkK0o1hD7+k5WUnbefZB5jBb1iNONRAnCG9Bhqy45OA8kkNKlqE2P0yW+XLFDwnP9eEw==
X-Received: by 2002:a05:6808:3cd:b0:394:4825:fa7 with SMTP id o13-20020a05680803cd00b0039448250fa7mr898093oie.2.1683774882148;
        Wed, 10 May 2023 20:14:42 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:e8a3:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id j126-20020acab984000000b0039425b542d9sm1801910oif.5.2023.05.10.20.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 20:14:41 -0700 (PDT)
Date:   Wed, 10 May 2023 21:14:40 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Sergey Organov <sorganov@gmail.com>,
        Matthieu Moy <matthieu.moy@univ-lyon1.fr>
Message-ID: <645c5da0981c1_16961a29455@chronos.notmuch>
Subject: Can we clarify the purpose of `git diff -s`?
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A recent discussion about a bug in the diff machinery [1] made me dig
the history of the `-s` option, and turned out to be quite an
archeological endeavor.

The first indication of such flag comes from e2e5e98a40 ([PATCH] Silent
flag for show-diff, 2005-04-13), only 54 commits after the initial
commit.

Not much later after, a `-z` option was added for some machine-readable
output in d94c6128e6 ([PATCH] show-diff -z option for machine readable
output., 2005-04-16).

Linus Torvalds wanted to make the machine-readable output the only one
and wrote 0a7668e99f (show-diff: match diff-tree and diff-cache output,
2005-04-26), but Junio Hamano disagreed and added a `-p` option for
a human-readable patch in 4a6bf9e18a ([PATCH] Reactivate show-diff patch
generation, 2005-04-27).

  You'll need "diff-tree-helper" to show the full diff, but Junio is
  dead set on adding a "-p" argument to all three to avoid it. That's
  next..

Right after that, Junio Hamano deprecated the `-s` flag, since
`git-show-diff` didn't show the patch by default, so `-s` became a
no-op. I presume at that point in time they didn't think of the
possibility of doing `-p -s` together.

The first introduction of DIFF_FORMAT_NO_OUTPUT was in a corner case of
6b14d7faf0 ([PATCH] Diffcore updates., 2005-05-22), but later on it was
used explicitly to replace a global variable of `git-diff-tree -s` in
d0309355c9 ([PATCH] Use DIFF_FORMAT_NO_OUTPUT to implement diff-tree -s
option., 2005-05-24).

When the equivalent of the modern `git diff` was added, the `-p` option
was included by default: 940c1bb018 (Add "git diff" script, 2005-06-13).
So later on when it was converted to C, DIFF_FORMAT_PATCH was the
default 65056021f2 (built-in diff., 2006-04-28).

But not for all commands, for example the default of `git diff-tree` is
DIFF_FORMAT_RAW, and it remains the case to this day.

So at this point it seems pretty clear that `-s` means `silent`, and
whatever the default format of a diff command is (`--patch` or `--raw`),
`-s` is meant to silence that format.

Later on in c6744349df (Merge with_raw, with_stat and summary variables
to output_format, 2006-06-24), the output format changed from an enum to
a bit field, so now it was possible to do for example
`DIFF_FORMAT_PATCH | DIFF_FORMAT_RAW`.

This is when things become complicated, because now what is `-s`
supposed to do? Is it supposed to silence only the default format? Or is
it supposed to silence all formats?

For example, these two commands are equivalent:

  git diff-tree @~ @
  git diff-tree --raw @~ @

That's because the default format of `git diff-tree` is DIFF_FORMAT_RAW.

But what happens if we do:

  git diff-tree -s --patch @~ @

Shall we silence only the RAW part, or the PATCH part as well?

And then, should these two be different?

  git diff-tree --patch -s @~ @
  git diff-tree -s --patch @~ @

This is something that wasn't discussed or explored at the time, so it
is unclear.

And then, finally, we have d09cd15d19 (diff: allow --no-patch as synonym
for -s, 2013-07-16), which very clearly says:

  This follows the usual convention of having a --no-foo option to
  negate --foo.

So, obviously the intention of `--no-patch` is to negate `--patch`, but
it is linked to `-s`, which was linked to DIFF_FORMAT_NO_OUTPUT, which
means `--no-patch` negates *all* output, not just the output of
`--patch`.

So what should the output of this command be:

  git diff-tree --patch --no-patch --raw @~ @

I think it very clearly should output the same as:

  git diff-tree @~ @

And the ordering does not matter, as this should output the same:

  git diff-tree --raw --patch --no-patch @~ @

If we can combine two formats, for example:

  git diff --patch --raw @~

Then we should be able to negate a single format, for example:

  git diff --patch --raw --no-patch @~

Which in my mind should be different from:

  git diff --patch --raw --silent @~

So, in short: I don't think `-s` and `--no-patch` are the same thing at
all, and it was a mistake to link them together.

If anybody thinks the intention behind `-s` and `--no-patch` is
obviously clear, I think it would be helpful to explicitly say so for
the record.

Cheers.

[1] https://lore.kernel.org/git/20230503134118.73504-1-sorganov@gmail.com/

-- 
Felipe Contreras

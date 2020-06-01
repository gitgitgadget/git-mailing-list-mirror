Return-Path: <SRS0=PU/F=7O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74327C433E0
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 17:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FFF0206E2
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 17:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2daBkTz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgFARIT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Jun 2020 13:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgFARIT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jun 2020 13:08:19 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE72C05BD43;
        Mon,  1 Jun 2020 10:08:18 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id n31so783959ooi.10;
        Mon, 01 Jun 2020 10:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IuNX0RBOyq9ZMZHylOoUGOnRUxtAySELbUZxdQWAGnE=;
        b=e2daBkTzwE7ZsjVzAHRtk4RLjPTRbd0XFDleV5g5ijfbgfFd+dEzdLKl+8vksRW0Hm
         BDX6cm3YKV6Lrc/jLSxDv7xB1jpWkXCeo0KL9NTfpKLgKtIlZQAZPEqSO9KYmFmTQaOR
         8OyZNsEzhXvWX9A4Uv1uxhxjS2o/mA8FkRZ+iwSY0n8NazYMlfICP3EPQ5JAcqZ5k7ht
         M/O/HD9ipnw+c8/Xa4BGJnvA9EPOeNzfx2J9cl9W9j8MEPkc5w1l4LglO9C38iB8svj7
         rRoFTg9gRVk45UDaV4RO03mA9jv3z/wdvwzdMs4lO0R89fcAU8GDquZVJ+xPOlMaseoN
         Gr8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IuNX0RBOyq9ZMZHylOoUGOnRUxtAySELbUZxdQWAGnE=;
        b=gUR54q+qkhhpyUwKJFn1s113HBNoqXe58nrQJBr1DJYNzWxZfUQ5rtp6/CqczWjvki
         9otKCpRyqW+EzMW9JpNUYvCNHRwwVbPK2EPWLnElSa8yMQ4Y+YmxWcHfTVoPcxmwKNja
         CuQyp3Tw5ahci4AL16r8UTrC4SYfg4+YRVl1w2ALgy/6bIrqvXZeyBUl2Ji36GjY7Bgb
         iLbv/hJklYeNvNEEAAQ4JRhqw+NPLSYaJwSRkxI8dL0lP43xbqBOemnea2mVxV42KtPd
         TjCoalDn5Qe5ykra22eOx2FX3rIvO7rYXeOuuem5xJ0m9nTDtd5+kSLTDSUY4MvYwAiQ
         XYfQ==
X-Gm-Message-State: AOAM5326dj/WTci5l2lBK+kzxAeIGntxDMAXmn/i0YL0bShZcz1GtBgs
        XrQU6ktOeJ6daenRWGNZ71usUFZSF8Rl/BAjmK0y9fdflEQ=
X-Google-Smtp-Source: ABdhPJwnlJTyc++OYB32+ItAiDcmLobzOA8nwNegzqr1Lrg6XsfjhESMBgV4Ea8bOFtAdVCiiJH+hQIbXpHKTeRziQg=
X-Received: by 2002:a4a:91c2:: with SMTP id e2mr17601384ooh.45.1591031297817;
 Mon, 01 Jun 2020 10:08:17 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqzh9mu4my.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqzh9mu4my.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 1 Jun 2020 10:08:06 -0700
Message-ID: <CABPp-BF+xvzroi5QU8zPp-7KoSS16v1CsM43vWx1WO5NjyU0BQ@mail.gmail.com>
Subject: [ANNOUNCE] git-filter-repo v2.27.0 (Was: Re: [ANNOUNCE] Git v2.27.0)
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, Jun 1, 2020 at 9:37 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> The latest feature release Git v2.27.0 is now available at the
> usual places.  It is comprised of 537 non-merge commits since
> v2.26.0, contributed by 71 people, 19 of which are new faces.

The latest release of git-filter-repo, v2.27.0, is also now available.
It is comprised of 26 non-merge commits since v2.26.0, including two
changes from new contributors.

If you have been holding off on trying filter-repo because you didn't
want to figure out how to convert your filter-branch or BFG commands,
there are now cheat sheets for converting any example from the manual of
either of those tools into equivalent filter-repo commands; see the last
two links here:

    https://github.com/newren/git-filter-repo#how-do-i-use-it


The public repo of filter-repo is at

    https://github.com/newren/git-filter-repo

The tarballs can be found at:

    https://github.com/newren/git-filter-repo/releases

git-filter-repo can also be installed via a variety of package managers
across Windows, Mac OS, or Linux (and maybe others)[1].

New contributors whose contributions weren't in v2.26.0 are as follows.
Welcome to the git-filter-repo development community!

  * Kate F
  * Marius Renner

[1] https://github.com/newren/git-filter-repo/blob/master/INSTALL.md

----------------------------------------------------------------

git-filter-repo 2.27 Release Notes
==================================

(Note: Additional information is available for many release notes at
    https://github.com/newren/git-filter-repo/issues/<NUMBER>)

* Fixes:
  * fix ugly bug with mixing path filtering and renaming (#96)
  * suggest --no-local when cloning local repos (discourage use of --force)
  * fix possible deadlock in sanity_check_args (#86)
  * fix --prune-degenerate=never with path filtering (#92)
  * throw an error if user specifies any path starting with a slash (#73)
  * ensure we write final newline after final progress update (#84)
  * repack with --source or --target (#66)
  * make --version more robust against modified shebangs
  * make git version requirement error message more direct (#94)
  * allow removing .git directories from history

* Documentation:
  * fix typo in example (#69)
  * add more detailed explanation of safety checks and --force
  * add guides & cheat sheets for people converting from filter-branch or BFG
  * add examples for --subdirectory-filter and --to-subdirectory-filter
  * add missing documentation for --no-ff option (#92)
  * add more --paths-from-file examples with large filtering lists
  * clarify usage of --use-base-name
  * streamline install instructions a bit
  * and various other miscellaneous improvements and fixes

* contrib scripts:
  * fix special character handling in filter-lamely (#71)

* Miscellaneous:
  * add sanity checks around release script


Changes since v2.26.0 are as follows:

Elijah Newren (24):
      Makefile: a few sanity checks for releasing
      filter-repo: fix bitrotted documentation links
      filter-repo: suggest --no-local when cloning local repos
      filter-repo: ensure we write final newline after final progress update
      filter-repo: make --version more robust against modified shebangs
      filter-repo: clarify usage of --use-base-name
      git-filter-repo.txt: add examples for --[to-]subdirectory-filter
      filter-repo: throw an error if user specifies any path starting
with a slash
      git-filter-repo.txt: add documentation of --no-ff option
      filter-repo: allow removing .git directories from history
      Documentation: add guides for people converting from filter-branch or BFG
      git-filter-repo.txt: add more --paths-from-file examples with
large filtering lists
      INSTALL: streamline a bit and guide folks to package managers
      filter-repo: fix --no-local error when there is no remote
      Documentation: add more detailed explanation of safety checks and --force
      filter-repo: make git version requirement error message more direct
      filter-repo: fix possible deadlock in sanity_check_args
      filter-repo: fix ugly bug with mixing path filtering and renaming
      filter-repo: fix --prune-degenerate=never with path filtering
      git-filter-repo.txt: fix extraneous space
      filter-repo: repack with --source or --target
      filter-repo (README): link cheat sheets from usage section too
      filter-repo (README): separate sections for different tools
      git-filter-repo.txt: connect --no-local and fresh clones more thoroughly

Kate F (1):
      git-filter-repo.txt: Fix typo for example

Marius Renner (1):
      contrib: fix special character handling in filter-lamely

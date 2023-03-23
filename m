Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A68C74A5B
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 17:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbjCWRMg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 13:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjCWRMe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 13:12:34 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F8323A47
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 10:12:33 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-536a4eba107so227986967b3.19
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 10:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679591553;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cQI8EUGwJNK7IwSyYwTSJrKNqsAGUa+AQ6eCeg8kgAU=;
        b=Ys/9RK4ODeHySq1yN/fnJKQgDD6S7hvFgWGat9j0jHiGUXR353bdBhUEHw6rhhL5Up
         E6bu2Is1e9s0FHu3aayZ4VpxLZkSqGW/O/tP3ZXhjk8vIgyuYAS5zZG19ucIsbYkzXZC
         7nKEy2Uedk2s7OL2rguaHBnPY7ZZU97XzW32gbfR78E3AUjI/WUqgK8Sg3EiX9ppGQ3D
         VH759JugYG4psLJ7Q7N1K9a3j4804MCr3Nl69r3b+ew3VmoHoz7fOcxgu2c3sllhqrs+
         /5flJx5wWMneI8GDXche07Lhu9QwKmhwgIln8o0j1xhWGvFw9V/xi0OaHEoav6+Hg8sx
         ynsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679591553;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cQI8EUGwJNK7IwSyYwTSJrKNqsAGUa+AQ6eCeg8kgAU=;
        b=KOOUZ0C4xh9c5mrUlN9j9s1WOFGNUNhOkupI1d4bRSS6qsPIEnbqyyYBTiXmw3q5zt
         JOgGliOM8bUNfAKT0KblBDblvbpIewWcAdjkL6ZJpZY+kY0ejTZMRqGIaqtX4IzZITYM
         Bkpe7TYy9sy95fxQa4jV1Xd0ElAuc50P0QJAk31m+fmHiSnR54uN47L/QHNYBvXpqUvJ
         BUF30yrsQ8ajrqxsE7vsTQka0kSjPe2hPoAnCIv3zYXduIu9NLC4Q4OoJpcqeOMNGoyj
         eZHkvofXRRWVmnstq2TkMBkFC7s1fmd836Pj+AbbE4n+yq4AgwEPDYSQj6dtQx8smmN7
         nOoQ==
X-Gm-Message-State: AAQBX9f0rsFQ4fzK6cPY0QNAQ9SVBDDL1hSm8WKEMxgn61yT6Oi21Z8Q
        zx1xhm6NpYZDqU0r9F2Ef9SFksvTH+NFew==
X-Google-Smtp-Source: AKy350a+tJrfzydnkHvQ9Lr0b63WP56vAzQby6OUsTtZjnMstV+4ZjOSyImldnngOnDkHZhhpy3tg+opW6+PJg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a05:6902:1896:b0:a02:a3a6:78fa with SMTP
 id cj22-20020a056902189600b00a02a3a678famr2401806ybb.12.1679591553004; Thu,
 23 Mar 2023 10:12:33 -0700 (PDT)
Date:   Thu, 23 Mar 2023 10:12:24 -0700
In-Reply-To: <xmqqcz50bau4.fsf@gitster.g>
Mime-Version: 1.0
References: <xmqqcz50bau4.fsf@gitster.g>
Message-ID: <kl6l355ve6iv.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: ab/remove-implicit-use-of-the-repository (was Re: What's cooking in
 git.git (Mar 2023, #05; Wed, 22))
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> * ab/remove-implicit-use-of-the-repository (2023-03-17) 17 commits
>  - libs: use "struct repository *" argument, not "the_repository"
>  - post-cocci: adjust comments for recent repo_* migration
>  - cocci: apply the "revision.h" part of "the_repository.pending"
>  - cocci: apply the "rerere.h" part of "the_repository.pending"
>  - cocci: apply the "refs.h" part of "the_repository.pending"
>  - cocci: apply the "promisor-remote.h" part of "the_repository.pending"
>  - cocci: apply the "packfile.h" part of "the_repository.pending"
>  - cocci: apply the "pretty.h" part of "the_repository.pending"
>  - cocci: apply the "object-store.h" part of "the_repository.pending"
>  - cocci: apply the "diff.h" part of "the_repository.pending"
>  - cocci: apply the "commit.h" part of "the_repository.pending"
>  - cocci: apply the "commit-reach.h" part of "the_repository.pending"
>  - cocci: apply the "cache.h" part of "the_repository.pending"
>  - cocci: add missing "the_repository" macros to "pending"
>  - cocci: sort "the_repository" rules by header
>  - cocci: fix incorrect & verbose "the_repository" rules
>  - cocci: remove dead rule from "the_repository.pending.cocci"
>
>  Code clean-up around the use of the_repository.
>
>  Needs review.
>  source: <cover-00.17-00000000000-20230317T152724Z-avarab@gmail.com>

My opinion (which I think is shared by Elijah [1]) is that

a) the code changes look great, and are a very welcome cleanup
b) I don't know how to review cocci changes, so I'm not 100% confident
   in giving Reviewed-by

[1] https://lore.kernel.org/git/CABPp-BEdpTO=DRjLq_p+dgX68M0HUVB--3yQR4Sdp8rnFYeyfA@mail.gmail.com/

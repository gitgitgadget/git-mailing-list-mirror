Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86538C433F5
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 16:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6683C60EE5
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 16:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239367AbhJFQ2y (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 12:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbhJFQ2x (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 12:28:53 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ABE9C061746
        for <git@vger.kernel.org>; Wed,  6 Oct 2021 09:27:01 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id r18so12026097edv.12
        for <git@vger.kernel.org>; Wed, 06 Oct 2021 09:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wAHmRjSwPSN/PAi9ZmiW7XyMkq3NYJILCePBYEfro6s=;
        b=WvPGxu41xxQgDmDy+MSNUZDvkLoR87j1cBsVH6ltGTMthruFEq1Aimfvd1oK1/EFQ+
         8GJA7z2/vP9dkJJPLlFKcLII7DVGSpCbh442F22KsKj1CWapmIIUgQpCzkwP9MZ8ycj3
         TCxP00yTEwISZBfw0wFyb8WY7980znvfOap3m2+VxooTIL83RgLno+eBs7Lh9zy0nYVJ
         kdswJnLQu1SQOJS/TwUOGEtefKeKjC/bLzgPTJjxCIhqPXNPlcuvLmZ6g5N09BJDTpXr
         OW1FzujXDyQ3hLJLmlF6snJ75hW+a8S2KmdUI2wDdRSQLeF9qY6nd3eJLQ27i0gcEzc3
         rdmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wAHmRjSwPSN/PAi9ZmiW7XyMkq3NYJILCePBYEfro6s=;
        b=PV+ZSegphlaxgeu3NaTwyGLEoxqEwFZONZBkG0grCj/WGSHiygaHU1s4WUdaizVfYH
         +j3h1VfT4R3+YoGHq3xPSTBkBw/iMEeC8YTVJnVg0+kBavsq+mopFE7zX6ap5GcjbiP6
         0iacsMhXRLvPOhJ6phEv3aWhfn6x1SOh4MGneZzVnK/EOk6gTq+IamHwm+oG4QWOZere
         XUe5YSgf8UE9Y4ZxuTQGV5aoG9YJGlWa/qK0zXnbm0ivTZn/sWG/+YWe2DbpjU1I6BD0
         ndxdBZXHuh3A2azqDqlCkEOx/Q0mC4fZIDYo00JpW19BaYgRuMNjB0+VzfYSPeSLvS0S
         rXXw==
X-Gm-Message-State: AOAM531OCY1Fh08ZZpmsgHyANGAplpn5kzth0IWvzP73ZwbPSaJSXQCH
        dq7oPwYmr/KbEtPbbAMMi4BoxxyPvrVwoUZaEOE=
X-Google-Smtp-Source: ABdhPJwImjYXpoY5xpYA4Gqkd+kH5Qy9MPJuxGaFaMXdRvS3ZAvGIc+fXA5+iSQpi2EgcsFLRnsdO/nJlIzleQRUH48=
X-Received: by 2002:a17:906:544f:: with SMTP id d15mr33704889ejp.520.1633537619862;
 Wed, 06 Oct 2021 09:26:59 -0700 (PDT)
MIME-Version: 1.0
References: <cover-00.10-00000000000-20211006T094705Z-avarab@gmail.com>
In-Reply-To: <cover-00.10-00000000000-20211006T094705Z-avarab@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 6 Oct 2021 09:26:48 -0700
Message-ID: <CABPp-BEpCa7dxYqe2R82N_eVzx5e17C2w+d1zD9XWzyEXCDbPw@mail.gmail.com>
Subject: Re: [PATCH 00/10] leak tests: mark more tests as passing
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 6, 2021 at 2:50 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
> This goes on top of ab/sanitize-leak-ci, in that topic I introduced a
> "linux-leaks" job that runs in CI and checks that we don't have
> SANITIZE=3Dleak regressions, but it just marked one test file as passing
> under that mode.
>
> That was out of an abundance of caution, and to not conflate any
> potential failures with the mode itself.
>
> This series marks up a lot of tests as passing, ensuring that they
> won't regress when it comes to memory leaks.

I like the series.  It does have the potential to annoy folks who want
to add additional tests which make use of git commands outside the
area they are modifying and which happen to have pre-existing leaks.
But, I think in such cases, they could just remove the
TEST_PASSES_SANITIZE_LEAK=3Dtrue and mention it in their commit message.
And when the checks fail because of a git command someone is
modifying, then we get useful early signal and the author can address
the problem.

>
> I did a "git rebase -i --exec" of each of these commits where I merged
> with origin/seen, ran all tests under
> GIT_TEST_PASSING_SANITIZE_LEAK=3Dtrue. They all pass, so hopefully these
> won't cause any disruption. I was careful to leave out any areas that
> are actively being worked on (e.g. I had to eject a test in the
> "sparse" area, since it would pass on master+ab/sanitize-leak-ci, but
> has a regression in "seen". I didn't look into why).
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (10):
>   leak tests: run various built-in tests in t00*.sh SANITIZE=3Dleak
>   leak tests: run various "test-tool" tests in t00*.sh SANITIZE=3Dleak
>   leak tests: mark t0000-init.sh as passing with SANITIZE=3Dleak
>   leak tests: mark all ls-tree tests as passing with SANITIZE=3Dleak
>   leak tests: mark all trace2 tests as passing with SANITIZE=3Dleak
>   leak tests: mark all checkout-index tests as passing with
>     SANITIZE=3Dleak
>   leak tests: mark some ls-files tests as passing with SANITIZE=3Dleak
>   leak tests: mark some read-tree tests as passing with SANITIZE=3Dleak
>   leak tests: mark various "generic" tests as passing with SANITIZE=3Dlea=
k
>   leak tests: mark some misc tests as passing with SANITIZE=3Dleak
>
>  t/t0001-init.sh                         | 1 +
>  t/t0002-gitfile.sh                      | 1 +
>  t/t0003-attributes.sh                   | 1 +
>  t/t0005-signals.sh                      | 2 ++
>  t/t0007-git-var.sh                      | 2 ++
>  t/t0008-ignores.sh                      | 1 +
>  t/t0010-racy-git.sh                     | 1 +
>  t/t0013-sha1dc.sh                       | 2 ++
>  t/t0022-crlf-rename.sh                  | 1 +
>  t/t0024-crlf-archive.sh                 | 1 +
>  t/t0025-crlf-renormalize.sh             | 1 +
>  t/t0026-eol-config.sh                   | 1 +
>  t/t0029-core-unsetenvvars.sh            | 1 +
>  t/t0052-simple-ipc.sh                   | 1 +
>  t/t0055-beyond-symlinks.sh              | 1 +
>  t/t0061-run-command.sh                  | 1 +
>  t/t0065-strcmp-offset.sh                | 1 +
>  t/t0066-dir-iterator.sh                 | 1 +
>  t/t0067-parse_pathspec_file.sh          | 1 +
>  t/t0210-trace2-normal.sh                | 2 ++
>  t/t0211-trace2-perf.sh                  | 2 ++
>  t/t0212-trace2-event.sh                 | 2 ++
>  t/t1000-read-tree-m-3way.sh             | 2 ++
>  t/t1003-read-tree-prefix.sh             | 1 +
>  t/t1009-read-tree-new-index.sh          | 1 +
>  t/t1010-mktree.sh                       | 1 +
>  t/t1012-read-tree-df.sh                 | 1 +
>  t/t1014-read-tree-confusing.sh          | 2 ++
>  t/t1100-commit-tree-options.sh          | 1 +
>  t/t1430-bad-ref-name.sh                 | 1 +
>  t/t1504-ceiling-dirs.sh                 | 2 ++
>  t/t1510-repo-setup.sh                   | 1 +
>  t/t2002-checkout-cache-u.sh             | 1 +
>  t/t2003-checkout-cache-mkdir.sh         | 1 +
>  t/t2004-checkout-cache-temp.sh          | 1 +
>  t/t2005-checkout-index-symlinks.sh      | 1 +
>  t/t2050-git-dir-relative.sh             | 1 +
>  t/t2081-parallel-checkout-collisions.sh | 1 +
>  t/t2300-cd-to-toplevel.sh               | 1 +
>  t/t3000-ls-files-others.sh              | 2 ++
>  t/t3002-ls-files-dashpath.sh            | 2 ++
>  t/t3003-ls-files-exclude.sh             | 2 ++
>  t/t3004-ls-files-basic.sh               | 1 +
>  t/t3006-ls-files-long.sh                | 2 ++
>  t/t3008-ls-files-lazy-init-name-hash.sh | 1 +
>  t/t3070-wildmatch.sh                    | 1 +
>  t/t3100-ls-tree-restrict.sh             | 2 ++
>  t/t3101-ls-tree-dirname.sh              | 2 ++
>  t/t3102-ls-tree-wildcards.sh            | 1 +
>  t/t3103-ls-tree-misc.sh                 | 1 +
>  t/t3205-branch-color.sh                 | 1 +
>  t/t3211-peel-ref.sh                     | 1 +
>  t/t3300-funny-names.sh                  | 1 +
>  t/t3601-rm-pathspec-file.sh             | 1 +
>  t/t3902-quoted.sh                       | 1 +
>  t/t4002-diff-basic.sh                   | 2 ++
>  t/t4016-diff-quote.sh                   | 1 +
>  t/t4019-diff-wserror.sh                 | 1 +
>  t/t4025-hunk-header.sh                  | 1 +
>  t/t4026-color.sh                        | 2 ++
>  t/t4300-merge-tree.sh                   | 2 ++
>  t/t5580-unc-paths.sh                    | 1 +
>  t/t5615-alternate-env.sh                | 2 ++
>  t/t7518-ident-corner-cases.sh           | 2 ++
>  t/t7812-grep-icase-non-ascii.sh         | 1 +
>  t/t7813-grep-icase-iso.sh               | 1 +
>  t/t7816-grep-binary-pattern.sh          | 1 +
>  67 files changed, 87 insertions(+)
>
> --
> 2.33.0.1441.gbbcdb4c3c66

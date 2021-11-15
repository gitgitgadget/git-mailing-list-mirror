Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD6CC433F5
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 23:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59F9061414
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 23:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351853AbhKOXOa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 18:14:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346042AbhKOXMV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 18:12:21 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B66AC04EF9B
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 14:14:45 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id z5so18535858edd.3
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 14:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=t6NYTkBLKsr97HekJTbfZWniW3VDIGUBfia7W4hJIIw=;
        b=ViZLxMS7qYvmAOw/VhylsTVJGslF3aGlrhT7ZnW0qbQtAl84vVApn/5d/ZG/6gaKdo
         y3yiAX6RtLVe5xm7vkj86fo15stBmS/rhKIqwUvUkB8vXkN9WRocZtIZ73WU+Aj90G1G
         KUMQIMB1Kwo9JB16KTJUic43CKLfP57HjCxJAAgQRyOCFB5EYcsrwJREtUgc1IIqdhrI
         ByP08S1Aj86HcaAGZwOozLugj0lhzyVwiGUJpDFBuwCJI1xTJOZsqaHsD0t7zmGkMYsJ
         7x3PN2E3F9cp5CjYEWvZTt+HU9DjhLOo+x60tzjiaaHTO3UjvDNXs8NrTXeWhYx97P+Q
         6oFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=t6NYTkBLKsr97HekJTbfZWniW3VDIGUBfia7W4hJIIw=;
        b=tNK1G6vs6T1XM1We9TeT6wL0xRLqCfN4nwoVphNZoMRe4B2RYGDZMkXa8tDGHH1QMc
         zOICKWQ+TmB2YmXjlROwgAYfJ5j/ndlE+vdOX9MEfB487yuiQkAKByH7F5CLWqP3wF0v
         1RRHVCGmpqYR9h/lAkFrcN8OWQda83SMEZxZ3r8mIBhE+mHZZ1+4ii636fSSmVSlK2ja
         6FPN5XDa+QQBz5jzxA8ykrTTv7wheMErMlLFDavbDxH4kxrRRsdPvDZkeLy+oTOMlOin
         JrGyXdkj9svnF7TjhwoTrxLF4KEz+6P6Pg0Vo55VWp80rWKH5nG6nqCEyjCSM/dOb43j
         cOrA==
X-Gm-Message-State: AOAM532jyk1fwavx8fT5FDrt3rrEU3CPF3hqqXjKVOCsc0SumYO3LBTG
        6vHNcANLzCMq11Lt9th7LcUhY04Dk5i1tEJk2rE=
X-Google-Smtp-Source: ABdhPJz18Qp35K+Fo+/aFoiv8P5vdmhsfqL6o4iuAWG0L5IgygymOIwDHiQ9KNgT/5Y0HAErmD7VP7JnVFWNq7qipY8=
X-Received: by 2002:a17:906:2f10:: with SMTP id v16mr3042769eji.434.1637014484024;
 Mon, 15 Nov 2021 14:14:44 -0800 (PST)
MIME-Version: 1.0
References: <cover-00.15-00000000000-20211030T221945Z-avarab@gmail.com>
In-Reply-To: <cover-00.15-00000000000-20211030T221945Z-avarab@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 15 Nov 2021 14:14:32 -0800
Message-ID: <CABPp-BEokunZkv2zZ6UGBDouNwjPpWhha7gdwW0OqV8N+f1yPA@mail.gmail.com>
Subject: Re: [PATCH 00/15] leak tests: remaining non-svn non-p4 tests as passing
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

On Sat, Oct 30, 2021 at 3:24 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> A follow-up to the now-landed series[1] to mark various tests as
> passing under SANITIZE=3Dleak.
>
> Existing passing tests were found with:
>
>     rm .prove; GIT_SKIP_TESTS=3Dt0027 prove -j8 --state=3Dsave t[0-9]*.sh=
 :: --immediate
>     GIT_TEST_PASSING_SANITIZE_LEAK=3Dtrue prove -j8 --state=3Dpassed
>
> These are all the tests that aren't "git-svn", "git-p4",
> Windows-specific, or icase, need to write to / etc.
>
> As before I've merged this to "seen" and all tests pass with whatever
> we've got in-flight at the moment, so this should cause minimal
> disruption. Passing CI run on top of "master" at [2].
>
> 1. https://lore.kernel.org/git/cover-v2-0.9-00000000000-20211012T135343Z-=
avarab@gmail.com/
> 2. https://github.com/avar/git/actions/runs/1403093377
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (15):
>   leak tests: mark a read-tree test as passing SANITIZE=3Dleak
>   leak tests: mark "sort" test as passing SANITIZE=3Dleak
>   leak tests: mark most gettext tests as passing with SANITIZE=3Dleak
>   leak tests: mark some misc tests as passing with SANITIZE=3Dleak
>   leak tests: mark some rev-list tests as passing with SANITIZE=3Dleak
>   leak tests: mark some rev-parse tests as passing with SANITIZE=3Dleak
>   leak tests: mark some update-index tests as passing with SANITIZE=3Dlea=
k
>   leak tests: mark some notes tests as passing with SANITIZE=3Dleak
>   leak tests: mark some apply tests as passing with SANITIZE=3Dleak
>   leak tests: mark some diff tests as passing with SANITIZE=3Dleak
>   leak tests: mark some add tests as passing with SANITIZE=3Dleak
>   leak tests: mark some clone tests as passing with SANITIZE=3Dleak
>   leak tests: mark some status tests as passing with SANITIZE=3Dleak
>   leak tests: mark some config tests as passing with SANITIZE=3Dleak
>   leak tests: mark some fast-import tests as passing with SANITIZE=3Dleak
>
>  t/t0071-sort.sh                             | 1 +
>  t/t0200-gettext-basic.sh                    | 1 +
>  t/t0201-gettext-fallbacks.sh                | 1 +
>  t/t0202-gettext-perl.sh                     | 1 +
>  t/t0204-gettext-reencode-sanity.sh          | 1 +
>  t/t1002-read-tree-m-u-2way.sh               | 2 ++
>  t/t1300-config.sh                           | 1 +
>  t/t1303-wacky-config.sh                     | 2 ++
>  t/t1307-config-blob.sh                      | 2 ++
>  t/t1308-config-set.sh                       | 1 +
>  t/t1309-early-config.sh                     | 1 +
>  t/t1310-config-default.sh                   | 1 +
>  t/t1420-lost-found.sh                       | 2 ++
>  t/t1503-rev-parse-verify.sh                 | 1 +
>  t/t1506-rev-parse-diagnosis.sh              | 1 +
>  t/t1513-rev-parse-prefix.sh                 | 1 +
>  t/t1515-rev-parse-outside-repo.sh           | 2 ++
>  t/t1600-index.sh                            | 1 +
>  t/t2000-conflict-when-checking-files-out.sh | 1 +
>  t/t2100-update-cache-badpath.sh             | 1 +
>  t/t2101-update-index-reupdate.sh            | 1 +
>  t/t2102-update-index-symlinks.sh            | 1 +
>  t/t2103-update-index-ignore-missing.sh      | 1 +
>  t/t2104-update-index-skip-worktree.sh       | 1 +
>  t/t2105-update-index-gitfile.sh             | 1 +
>  t/t2200-add-update.sh                       | 1 +
>  t/t2201-add-update-typechange.sh            | 1 +
>  t/t2202-add-addremove.sh                    | 1 +
>  t/t2204-add-ignored.sh                      | 1 +
>  t/t2404-worktree-config.sh                  | 1 +
>  t/t3302-notes-index-expensive.sh            | 1 +
>  t/t3303-notes-subtrees.sh                   | 1 +
>  t/t3320-notes-merge-worktrees.sh            | 1 +
>  t/t3702-add-edit.sh                         | 2 ++
>  t/t3703-add-magic-pathspec.sh               | 1 +
>  t/t3704-add-pathspec-file.sh                | 1 +
>  t/t3908-stash-in-worktree.sh                | 1 +
>  t/t4000-diff-format.sh                      | 2 ++
>  t/t4003-diff-rename-1.sh                    | 2 ++
>  t/t4004-diff-rename-symlink.sh              | 2 ++
>  t/t4005-diff-rename-2.sh                    | 2 ++
>  t/t4006-diff-mode.sh                        | 2 ++
>  t/t4007-rename-3.sh                         | 2 ++
>  t/t4009-diff-rename-4.sh                    | 2 ++
>  t/t4010-diff-pathspec.sh                    | 2 ++
>  t/t4011-diff-symlink.sh                     | 2 ++
>  t/t4012-diff-binary.sh                      | 1 +
>  t/t4020-diff-external.sh                    | 1 +
>  t/t4024-diff-optimize-common.sh             | 1 +
>  t/t4027-diff-submodule.sh                   | 1 +
>  t/t4029-diff-trailing-space.sh              | 1 +
>  t/t4032-diff-inter-hunk-context.sh          | 1 +
>  t/t4033-diff-patience.sh                    | 1 +
>  t/t4034-diff-words.sh                       | 1 +
>  t/t4035-diff-quiet.sh                       | 1 +
>  t/t4037-diff-r-t-dirs.sh                    | 1 +
>  t/t4040-whitespace-status.sh                | 2 ++
>  t/t4046-diff-unmerged.sh                    | 2 ++
>  t/t4049-diff-stat-count.sh                  | 2 ++
>  t/t4050-diff-histogram.sh                   | 1 +
>  t/t4054-diff-bogus-tree.sh                  | 2 ++
>  t/t4062-diff-pickaxe.sh                     | 1 +
>  t/t4063-diff-blobs.sh                       | 2 ++
>  t/t4100-apply-stat.sh                       | 2 ++
>  t/t4101-apply-nonl.sh                       | 2 ++
>  t/t4102-apply-rename.sh                     | 2 ++
>  t/t4105-apply-fuzz.sh                       | 2 ++
>  t/t4106-apply-stdin.sh                      | 2 ++
>  t/t4109-apply-multifrag.sh                  | 2 ++
>  t/t4110-apply-scan.sh                       | 2 ++
>  t/t4112-apply-renames.sh                    | 2 ++
>  t/t4116-apply-reverse.sh                    | 2 ++
>  t/t4118-apply-empty-context.sh              | 2 ++
>  t/t4119-apply-config.sh                     | 2 ++
>  t/t4123-apply-shrink.sh                     | 2 ++
>  t/t4126-apply-empty.sh                      | 2 ++
>  t/t4127-apply-same-fn.sh                    | 2 ++
>  t/t4128-apply-root.sh                       | 2 ++
>  t/t4129-apply-samemode.sh                   | 2 ++
>  t/t4130-apply-criss-cross-rename.sh         | 2 ++
>  t/t4132-apply-removal.sh                    | 2 ++
>  t/t4133-apply-filenames.sh                  | 2 ++
>  t/t4134-apply-submodule.sh                  | 2 ++
>  t/t4136-apply-check.sh                      | 2 ++
>  t/t4139-apply-escape.sh                     | 2 ++
>  t/t5002-archive-attr-pattern.sh             | 1 +
>  t/t5200-update-server-info.sh               | 1 +
>  t/t5307-pack-missing-commit.sh              | 1 +
>  t/t5555-http-smart-common.sh                | 1 +
>  t/t5602-clone-remote-exec.sh                | 1 +
>  t/t5603-clone-dirname.sh                    | 2 ++
>  t/t5701-git-serve.sh                        | 1 +
>  t/t5704-protocol-violations.sh              | 2 ++
>  t/t6005-rev-list-count.sh                   | 1 +
>  t/t6102-rev-list-unexpected-objects.sh      | 1 +
>  t/t6136-pathspec-in-bare.sh                 | 1 +
>  t/t7101-reset-empty-subdirs.sh              | 2 ++
>  t/t7103-reset-bare.sh                       | 2 ++
>  t/t7511-status-index.sh                     | 1 +
>  t/t7515-status-symlinks.sh                  | 1 +
>  t/t7525-status-rename.sh                    | 1 +
>  t/t7526-commit-pathspec-file.sh             | 1 +
>  t/t9302-fast-import-unpack-limit.sh         | 2 ++
>  t/t9303-fast-import-compression.sh          | 2 ++
>  104 files changed, 152 insertions(+)
>
> --
> 2.33.1.1570.g069344fdd45

Sorry for not responding earlier; you sent this on the day of our big
migration (consolidating Git servers, reworking CI pipelines, etc.) at
$DAYJOB.  Anyway, I've now read through this series.  It's simple and
straightforward, helps us on our journey to clean up leaks and
ensuring they stay clean (nice to see that this covers almost 5k
tests), and I couldn't spot any problems.  Thanks for working on this!

Reviewed-by: Elijah Newren <newren@gmail.com>

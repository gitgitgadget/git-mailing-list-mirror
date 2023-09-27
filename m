Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C732EE80AB8
	for <git@archiver.kernel.org>; Wed, 27 Sep 2023 14:38:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbjI0Oid (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Sep 2023 10:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232214AbjI0Oia (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2023 10:38:30 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AAB8191
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 07:38:27 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-530c9980556so13575034a12.2
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 07:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695825506; x=1696430306; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lsmc206zC/6HQk2OxLQ8brLJFr1PCDRnMW5ADjcqZvc=;
        b=lZNRMQf3A1hZ+RgnBh0/eR9AXd4a8r17Aos4bh6t2Ae1jTDMmRQ3vmuB8wNHH1gimm
         lyvTCDRF7oXBnuF61qhu0y1o5elBJlRKRsVfJdE1dxodroZ0tyLqPlAGK7mcNgzwkgHE
         JojEpXhXcTZBTyQmGAAwhgBF+DGhMR8ys+6hu/fPwWv5rDPSYWdRv+xjGU6B7f8w4OFF
         rDDHxu/FVTmvun1YDvvIjXJ0NjB8OPRjuikQsE4v2fWH/A6H4uJfJfkMB26TBMR/MnLX
         sDEw38z+FtQUaQdIpdZwCehZdIiWGgzFDOD7IhtzlqmjqKk7TIQuf/d82M5DaEqU0S20
         LfhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695825506; x=1696430306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lsmc206zC/6HQk2OxLQ8brLJFr1PCDRnMW5ADjcqZvc=;
        b=waXIf+jBIys99WSnhHC/TVHElbY6axIMWMjf+09nGK6kPnVEJceKw1hE2ACWwH7xc7
         yXVxiHKas3hBHuvtPfs7hJlcVO6257BXATyYf45vjPqaKVl2Prlxm1nXT6ZMdLK0aFHo
         nud2bEbZZSLfNKenRJle827ViME3k4ieU5JXmL+fDBKMs7vd39bg2hT3ZRKqN2S14toi
         zmSaZrTgwCSLLHAgvkfIJ31qNpDYafQsbcUsb8BM6Xnu6SH77iaV9m50Qwd8alMPKW3e
         gti4KQUSKUnkcFiqSxX5Y4ruWx4AuQVtCKhG95lnSMw2STgP4cHGkAApK6zLUUu5AtLz
         X7pA==
X-Gm-Message-State: AOJu0Ywktd8hCQdVq6fglpjubLWG7yo0d2IPQkMa1+nIjYRMI3VfmZ1J
        MY6UYVjaWd8joJotCfWIOLkfhK/lb9x89HVmE/rbv+3M
X-Google-Smtp-Source: AGHT+IGxPc0ofIwK3Liro3W97m755DXhwqYkucFrYaXnRlE91CAb3yEx+PtGO7Vk0chJzaiXJikkV4SKbVMimYfy1aM=
X-Received: by 2002:a05:6402:292:b0:52c:84c4:a0bf with SMTP id
 l18-20020a056402029200b0052c84c4a0bfmr1971081edv.30.1695825505670; Wed, 27
 Sep 2023 07:38:25 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqpm25pxkh.fsf@gitster.g>
In-Reply-To: <xmqqpm25pxkh.fsf@gitster.g>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 27 Sep 2023 16:38:13 +0200
Message-ID: <CAP8UFD2YbYH5aZEG5NX8HLe9VeEQ+NhBfiZ9Mhy3UXTUrab3ug@mail.gmail.com>
Subject: Re: What's cooking in git.git (Sep 2023, #08; Mon, 25)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 26, 2023 at 4:25=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:

> * ks/ref-filter-mailmap (2023-09-25) 3 commits
>  - ref-filter: add mailmap support
>  - t/t6300: introduce test_bad_atom
>  - t/t6300: cleanup test_atom
>
>  "git for-each-ref" and friends learn to apply mailmap to authorname
>  and other fields.
>
>  Will merge to 'next'.
>  source: <20230925175050.3498-1-five231003@gmail.com>

Great!

> * ps/revision-cmdline-stdin-not (2023-09-25) 1 commit
>  - revision: make pseudo-opt flags read via stdin behave consistently
>
>  "git rev-list --stdin" learned to take non-revisions (like "--not")
>  recently from the standard input, but the way such a "--not" was
>  handled was quite confusing, which has been rethought.  This is
>  potentially a change that breaks backward compatibility.
>
>  Will merge to 'next'?
>  source: <6221acd2796853144f8e84081655fbc79fdc6634.1695646898.git.ps@pks.=
im>

The patch LGTM too.

> * cc/repack-sift-filtered-objects-to-separate-pack (2023-09-25) 10 commit=
s
>  - SQUASH??? t0080 is already taken

Yeah, it's taken by js/doc-unit-tests. I am Ok with using t0081 or
something else if someone has a better suggestion. Not sure if I
should resend a v8 or if you would be Ok with just squashing this
yourself when merging.

>  - gc: add `gc.repackFilterTo` config option
>  - repack: implement `--filter-to` for storing filtered out objects
>  - gc: add `gc.repackFilter` config option
>  - repack: add `--filter=3D<filter-spec>` option
>  - pack-bitmap-write: rebuild using new bitmap when remapping
>  - repack: refactor finding pack prefix
>  - repack: refactor finishing pack-objects command
>  - t/helper: add 'find-pack' test-tool
>  - pack-objects: allow `--filter` without `--stdout`
>
>  "git repack" machinery learns to pay attention to the "--filter=3D"
>  option.
>
>  Looking better.
>  source: <20230925152517.803579-1-christian.couder@gmail.com>

> * cc/git-replay (2023-09-07) 15 commits
>  - replay: stop assuming replayed branches do not diverge
>  - replay: add --contained to rebase contained branches
>  - replay: add --advance or 'cherry-pick' mode
>  - replay: disallow revision specific options and pathspecs
>  - replay: use standard revision ranges
>  - replay: make it a minimal server side command
>  - replay: remove HEAD related sanity check
>  - replay: remove progress and info output
>  - replay: add an important FIXME comment about gpg signing
>  - replay: don't simplify history
>  - replay: introduce pick_regular_commit()
>  - replay: die() instead of failing assert()
>  - replay: start using parse_options API
>  - replay: introduce new builtin
>  - t6429: remove switching aspects of fast-rebase
>
>  Waiting for review response.
>  cf. <52277471-4ddd-b2e0-62ca-c2a5b59ae418@gmx.de>
>  cf. <58daa706-7efb-51dd-9061-202ef650b96a@gmx.de>
>  cf. <f0e75d47-c277-9fbb-7bcd-53e4e5686f3c@gmx.de>

As no one replied to Dscho and Derrick seems to not be working on Git
anymore, I think I will just send a new version implementing Dscho's
suggestions.

>  May want to wait until tb/repack-existing-packs-cleanup stabilizes.
>  source: <20230907092521.733746-1-christian.couder@gmail.com>

Not sure I understand this. Did you mistake the "replay" series with
the "repack --filter" series? In any case
tb/repack-existing-packs-cleanup was merged to master.

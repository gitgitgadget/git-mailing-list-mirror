Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCE9C433EF
	for <git@archiver.kernel.org>; Mon, 17 Jan 2022 02:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236811AbiAQCWI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Jan 2022 21:22:08 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52259 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236802AbiAQCWH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jan 2022 21:22:07 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1241D1092B3;
        Sun, 16 Jan 2022 21:22:07 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=dAlNzsZDv2w7Z71G2PmDJ33iaoEQNfcAojkcr6RetjE=; b=HaSc
        75ZCb7H/uj1wR22bHlT+ffkUJuykp2+JDChI4m8P9FAnCcprqX2Fd3Xh1jgKliov
        jw0AowlxgXEYXkwUw2U2Tly3hGY53vM+PBRIm5lU2f7ukuIN0+Fs32cZC0KIJHYa
        +inCCkEkCwo3CqAAtJtJH64xRAGyXtj6HDFxAGY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 02A961092B2;
        Sun, 16 Jan 2022 21:22:07 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 168791092B1;
        Sun, 16 Jan 2022 21:22:05 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Joel Holdsworth <jholdsworth@nvidia.com>
Cc:     git@vger.kernel.org, Luke Diamand <luke@diamand.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>
Subject: Re: [PATCH v3 00/21] git-p4: Various code tidy-ups
References: <20220116160550.514637-1-jholdsworth@nvidia.com>
Date:   Sun, 16 Jan 2022 18:22:04 -0800
Message-ID: <xmqq4k63xfsj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 43375462-773C-11EC-A87E-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Between CI runs https://github.com/git/git/actions/runs/1705530485
and https://github.com/git/git/actions/runs/1705883104 the only
difference is that the former has this topic merged while the latter
does not.

> Patches to correct these items may be provided later.

 cf. https://github.com/git/git/runs/4834693492?check_suite_focus=true#step:5:1586
 cf. https://github.com/git/git/runs/4834693517?check_suite_focus=true#step:5:1643

That is another thing to correct.

> This third version of the patch-set is rebased on top of the next
> branch.

By the way, to try it out, I pretended that you followed the advice
in the SubmittingPatches document, namely:

    cf. Documentation/SubmittingPatches::[[base-branch]]

    * A new feature should be based on `master` in general. If the new
      feature depends on other topics that are in `next`, but not in
      `master`, fork a branch from the tip of `master`, merge these topics
      to the branch, and work on that branch.  You can remind yourself of
      how you prepared the base with `git log --first-parent master..`.

So, the patches are queued like so:

    $ git log --oneline --first-parent master..jh/p4-various-fixups
    818dd3982a git-p4: seperate multiple statements onto seperate lines
    0742a3fb0f git-p4: move inline comments to line above
    e34dcdaa6d git-p4: only seperate code blocks by a single empty line
    5d2c48612b git-p4: compare to singletons with "is" and "is not"
    cc2572b455 git-p4: normalize indentation of lines in conditionals
    3ae33c2d87 git-p4: ensure there is a single space around all operators
    6f4806cc58 git-p4: ensure every comment has a single #
    34f7c77da5 git-p4: remove spaces between dictionary keys and colons
    8c59479063 git-p4: remove redundant backslash-continuations inside brackets
    26c76f8db0 git-p4: remove extraneous spaces before function arguments
    eb7c7a9975 git-p4: place a single space after every comma
    d33eccbd7b git-p4: removed brackets when assigning multiple return values
    3465b01a94 git-p4: remove spaces around default arguments
    f806563768 git-p4: remove padding from lists, tuples and function arguments
    555e0c358a git-p4: sort and de-duplcate pylint disable list
    882a0dfd22 git-p4: remove commented code
    6483f061f7 git-p4: convert descriptive class and function comments into docstrings
    85c22c0c22 git-p4: improve consistency of docstring formatting
    bab9c087e7 git-p4: indent with 4-spaces
    fb8c71c28b git-p4: remove unneeded semicolons from statements
    b66e36e374 git-p4: add blank lines between functions and class definitions
    d8d4f440a5 Merge branch 'jh/p4-spawning-external-commands-cleanup' into jh/p4-...
    f3e99f0e9c Merge branch 'jh/p4-fix-use-of-process-error-exception' into jh/p4-...

which was created by

    $ git checkout -B jh/p4-various-fixups v2.35.0-rc1
    $ git merge --no-edit jh/p4-fix-use-of-process-error-exception
    $ git merge --no-edit jh/p4-spawning-external-commands-cleanup
    $ git am -s ./+jh21-v3-p4-various-fixups

where ./+jh21-v3-p4-various-fixups is the mbox file with these 21
patches, and jh/p4-* are the two topic branches form you that are
still in 'next'.  This way, you still have to wait for these two
topics to graduage before this new series can go in, but you won't
be taken hostage by other unrelated topics in 'next'.

It probably is a good idea to do the same when you prepare the next
round of this series.

I've ejected this topic from 'seen', but the topic itself should
still be there in https://github.com/gitster/git/ repository.

Thanks.

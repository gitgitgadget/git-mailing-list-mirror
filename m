Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35153EB64DD
	for <git@archiver.kernel.org>; Thu, 27 Jul 2023 20:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbjG0UIt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jul 2023 16:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbjG0UIs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jul 2023 16:08:48 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB4DE47
        for <git@vger.kernel.org>; Thu, 27 Jul 2023 13:08:47 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 04B7119EF03;
        Thu, 27 Jul 2023 16:08:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ymD7z13ljMZTwN4VBzlAyTsvH8Y4mcEYgdAfQp
        efrwI=; b=hSjPRAPojaIv1r1gmLC40YBJ4A72mksaYdbqru+nY+duwiEd5xhdJV
        WylijT0uIwmOi4VCcQ/AoWuiP5aZxc2QN6IMw3SlT7x6ssdj8iXUdO/hXuL6rux6
        TMSa3dsOSH7+fezcLAIxea9//DhO8OccgSQkvwwNn+GibZNWkMQww=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F01AC19EF02;
        Thu, 27 Jul 2023 16:08:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2056619EF01;
        Thu, 27 Jul 2023 16:08:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Arver <linusa@google.com>
Cc:     Linus Arver via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 8/5] SubmittingPatches: use of older maintenance tracks
 is an exception
References: <pull.1556.v2.git.1689314493.gitgitgadget@gmail.com>
        <pull.1556.v3.git.1690340701.gitgitgadget@gmail.com>
        <xmqq351bfdtj.fsf_-_@gitster.g> <owlyila5f8qp.fsf@fine.c.googlers.com>
Date:   Thu, 27 Jul 2023 13:08:44 -0700
In-Reply-To: <owlyila5f8qp.fsf@fine.c.googlers.com> (Linus Arver's message of
        "Thu, 27 Jul 2023 12:35:26 -0700")
Message-ID: <xmqqedktazhv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 647CBBE2-2CB9-11EE-B392-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Arver <linusa@google.com> writes:

> I just have small wording nits (see below), but otherwise LGTM.

Thanks.  Rolled typo/format fixes in.

1:  e3386ce69d ! 1:  f835de52d7 SubmittingPatches: explain why 'next' and above are inappropriate base
    @@ Documentation/SubmittingPatches: latest HEAD commit of `maint` or `master` based
     +flight work well together. This is why both `next` and `seen` are
     +frequently re-integrated with incoming patches on the mailing list and
     +force-pushed to replace previous versions of themselves. A topic that is
    -+literally built on top of `next` cannot be merged to 'master' without
    ++literally built on top of `next` cannot be merged to `master` without
     +dragging in all the other topics in `next`, some of which may not be
     +ready.
      
2:  6b2650d32f ! 2:  369998df83 SubmittingPatches: use of older maintenance tracks is an exception
    @@ Documentation/SubmittingPatches: latest HEAD commit of `maint` or `master` based
      * Otherwise (such as if you are adding new features) use `master`.
      
     +
    -+NOTE: In an exceptional case, a bug that was introduced in an old
    ++NOTE: In exceptional cases, a bug that was introduced in an old
     +version may have to be fixed for users of releases that are much older
     +than the recent releases.  `git describe --contains X` may describe
     +`X` as `v2.30.0-rc2-gXXXXXX` for the commit `X` that introduced the
     +bug, and the bug may be so high-impact that we may need to issue a new
     +maintenance release for Git 2.30.x series, when "Git 2.41.0" is the
     +current release.  In such a case, you may want to use the tip of the
    -+maintenance branch for the 2.30.x series, which may be available as
    ++maintenance branch for the 2.30.x series, which may be available in the
     +`maint-2.30` branch in https://github.com/gitster/git[the maintainer's
     +"broken out" repo].
     +

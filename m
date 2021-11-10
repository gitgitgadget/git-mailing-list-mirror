Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97530C433EF
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 04:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D85B6117A
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 04:03:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbhKJEGE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Nov 2021 23:06:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbhKJEGD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Nov 2021 23:06:03 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBE6C061764
        for <git@vger.kernel.org>; Tue,  9 Nov 2021 20:03:16 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id r12so5081559edt.6
        for <git@vger.kernel.org>; Tue, 09 Nov 2021 20:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=oOqWtfGcQnsrIIG0NFEalHu9uXGgrSBNCy4kChTrvdc=;
        b=QQLGCHKLuoe/kF4nQFxC9pofg7nxGf+ERPwgUFOSGVXURkBrj/vJNZB4ezH5SNYDHd
         iYsuB4DV2G7HXekQv7J2D0IDF5OPLw9dQIQdZ52b+EXS2Gi19kId+TutPGrA2MY3EweF
         QGt61ujYIlfWzT9B9phJYtbxyQnl8rXndGKaOMNL9m7YfCUr3iF4FkV9MfyIMqosO1+n
         1aJtckEb69n5fFLHoASSL5zaKe4SlG1WQM2ydzmb8AXjLzyjJXhMHHzeZNNFZN7uiWX0
         bhx68v4Vf4s5YjKn8X8uTB3F238m1dK92+ZJ6h0D4uYtOJAIF0skzFMRAagNoR3RxwNO
         SDMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=oOqWtfGcQnsrIIG0NFEalHu9uXGgrSBNCy4kChTrvdc=;
        b=ol1dNz+y1iin1xxx4OkjmuiTbkTTiihulTeg7iyLdo/RLQFxW9dITeOBb3DVRWZRJq
         kTDzAcReO6qgLZU6CadquXm/o8Or0Nhp7xLgxW+FBtVY8/MABllPXs74uQ2s4p4xG2Kn
         2WHlkzS9+AtbdFAoshzRhyZFVOhJLfzx2uqBrKxu8tGRJo1VFNMk95qgiW9ap11GbVxW
         ebeTMDXwJp3vuwgqahGEv+OfaPzzoG2hmxIwELESfLZMYrO91675BOmU4e3zxq7DE+W7
         ToEJ3qvZU6IMqwhWqlzvE8zKIQERQztWOhaAYeECXpypezn8RP86qvZs8bjVEUK4vWU2
         CsHA==
X-Gm-Message-State: AOAM531Fgg5auEpJVqzDIK2c/4PEE2IyoGeapG8BklmZN0dbNMz+qDUG
        SB3mXVrnJk3RKCQ6diRivRI=
X-Google-Smtp-Source: ABdhPJzHC9NIIajtQ+R+C5Hst0wjRUau+p0VdD5FTIeySKyL5YE3KgJhm5fEGnBbebNnaKCEW0OoyQ==
X-Received: by 2002:a17:907:160c:: with SMTP id hb12mr16487750ejc.460.1636516995012;
        Tue, 09 Nov 2021 20:03:15 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id s2sm10693206ejn.96.2021.11.09.20.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 20:03:14 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mkepO-000nay-4R;
        Wed, 10 Nov 2021 05:03:14 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Anders Kaseorg <andersk@mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Andreas Heiduk <andreas.heiduk@mathema.de>
Subject: Re: [PATCH v5 3/4] receive-pack: Protect current branch for bare
 repository worktree
Date:   Wed, 10 Nov 2021 05:00:20 +0100
References: <2f983e36-532f-ac87-9ade-fba4c6b9d276@mit.edu>
 <20211109230941.2518143-1-andersk@mit.edu>
 <20211109230941.2518143-3-andersk@mit.edu>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <20211109230941.2518143-3-andersk@mit.edu>
Message-ID: <211110.86tugkirnh.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 09 2021, Anders Kaseorg wrote:

> +test_expect_success 'denyCurrentBranch and bare repository worktrees' '
> +	test_when_finished "rm -fr bare.git" &&
> +	git clone --bare . bare.git &&
> +	git -C bare.git worktree add wt &&
> +	test_commit grape &&
> +	test_config -C bare.git receive.denyCurrentBranch refuse &&
> +	test_must_fail git push bare.git HEAD:wt &&
> +	test_config -C bare.git receive.denyCurrentBranch updateInstead &&
> +	git push bare.git HEAD:wt &&
> +	test_path_exists bare.git/wt/grape.t &&
> +	test_must_fail git push --delete bare.git wt
> +'
> +
>  test_expect_success 'refuse fetch to current branch of worktree' '
>  	test_when_finished "git worktree remove --force wt && git branch -D wt" &&
>  	git worktree add wt &&

Nit: Pick either a "git init sub-repo" or "rm -rf when-done.git" pattern
as you're doing here, or test_config. It doesn't make sense to combine
the two.

We don't need to run around in test_when_finished and unset config for
something we're about to "rm -rf" anyway.

I think it's good practice to avoid test_config whenever possible,
i.e. it's made redundant by using a sturdier test pattern of not
needlessly sharing state.

But when that's needed, i.e. you need one persistent repo you're
modifying, is when it should be used.

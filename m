Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 968C1C433EF
	for <git@archiver.kernel.org>; Sat, 16 Oct 2021 18:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71D1460F46
	for <git@archiver.kernel.org>; Sat, 16 Oct 2021 18:11:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244516AbhJPSNk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Oct 2021 14:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235317AbhJPSNi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Oct 2021 14:13:38 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF4FC061765
        for <git@vger.kernel.org>; Sat, 16 Oct 2021 11:11:30 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id g10so52004368edj.1
        for <git@vger.kernel.org>; Sat, 16 Oct 2021 11:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Xv75YmReyXzGCY90tqV+PLwQW8qvhyLHCx+AwOGM6+k=;
        b=P9gTQJYbKDeOP11l4VKiIlm0lo4vDx6tto3nVBreY980tl4Kd9o9YyLSyDEFND4qTN
         6iTLnDOobAn0HsMUFvPWyLb7O9aBEG8cqGbse6TPHNNuL0tV6Hbk9RqKYKHKpeYcl2sc
         3VbMkI6l2Rew3MMbr06rnUz4TD25YJNizWmfsw3MKeXRD+6ZSjKTjbdpatCstXtg0KBn
         dRXdnbWnP7fbYSmWAh9bl1pohGgqcGPGCTkeKttXUMvOV5Ik1dQWOlS6TgzXoOMprnpu
         Da/KFKwhZgMuiQdpYixU7Ftztnv8WPWH2HybZsbKPukRBqssbk9u6EPoDjQ+HykAXMUh
         3IYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Xv75YmReyXzGCY90tqV+PLwQW8qvhyLHCx+AwOGM6+k=;
        b=A4P9s5DU4lHLJ+623TcOhBXBYNQq3BLrsB4JQJNwJ/RVCSKWasG2hVta7ysqXCsLLt
         HQRkoYEL8XD3EuLYL28lfEH9L4zQVXZUtlark51z7Ouh9AIz6kVESfRIlZgzOJOQFnLy
         R412QHhHqElzx3METXbDDONyUGxiLksYRu9orMp1cXOftNa1a2fQY6xOae4Chm6ljuzC
         OLCada+XNUrNIx4mVmR8lKLWZk6H+a4t/v4IQww+KwrNvCTcu+3/TwckF4yBZUr5pErj
         lxZPbWr7yx+YoRhtrJl0h85nvwzj4yjCmecSIbGXwUO1cgvsjiC08hxK73+SJGn5AAwL
         i8eg==
X-Gm-Message-State: AOAM532fGIhSRBM1KXm5CWoxe91Xkxn0e2pTs1Jh4Y6eI96zAV720b51
        Ib9htZJiZv7Zlo3KTCjchh8=
X-Google-Smtp-Source: ABdhPJzSN2ct6+boubgmzeU4syx5zTX95IeEgufl4FvhI+lYYbU7+XAeALWTA4WWJUqt7+JdZNFHWQ==
X-Received: by 2002:a17:907:e8a:: with SMTP id ho10mr3147360ejc.440.1634407887395;
        Sat, 16 Oct 2021 11:11:27 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id u6sm6888238edt.30.2021.10.16.11.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 11:11:27 -0700 (PDT)
Received: from avar by evledraar with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mbo9W-0007o6-IQ;
        Sat, 16 Oct 2021 20:11:26 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v2 00/13] hook.[ch]: new library to run hooks + simple
 hook conversion
Date:   Sat, 16 Oct 2021 20:10:07 +0200
References: <cover-v2-00.13-00000000000-20211015T093918Z-avarab@gmail.com>
 <xmqqbl3p4wgz.fsf@gitster.g> <874k9hecro.fsf@evledraar.gmail.com>
 <xmqqwnmc3kz0.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <xmqqwnmc3kz0.fsf@gitster.g>
Message-ID: <87v91wdelt.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Oct 16 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> I haven't looked into worktree-add.sh failure (and from what Eric says
>> it seems unrelated), but all the rest is due to a mismerge of
>> reset.c. The diff here at the end on top of "seen" fixes it[1].
>
> Ahh, of course.
>
> The "update_refs()" call is what replaces the
> big block that had a bit of conflict in the way how a hook is run,
> where the original made a call to run_hook_le() now we set up an
> opt structure and make a call to run_hooks_oneshot().  Dropping the
> call to it would of course mean no hooks would be run from there X-<.
>
> Thanks.

I was thinking of re-rolling that series soon, hopefully with "last
nits", would you prefer to just have the reset.c part of it ejected for
now?

It's really nothing that needs to happen right now, we can do it in some
subsequent round when activity in that area has hopefully quieted.

It also means dropping the "remove old run_hook_{le,ve}() hook API", but
that can similarly come later...

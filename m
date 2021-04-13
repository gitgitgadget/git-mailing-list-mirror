Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E35C433ED
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 10:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26FED613C4
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 10:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244880AbhDMKu7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 06:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237097AbhDMKu6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 06:50:58 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18849C061574
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 03:50:39 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id s75so3043564vkb.6
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 03:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4BUN4J5E6Bz7cZQaG5nO0lgK+0H2xFl3M8KSMLQOKzg=;
        b=helFDEg1RqZ4TATn98II4qNkAmDxZo8jp1CbMb2riwrjSurc9xgSFGIy0rVWGKxD5X
         YVOyUwZXzBpRf9/IW7feELsVUbSptfbtXIGBRyCAhCPZWArNP3UG1iA2eoP6P3BdM5zy
         0R1mBuk642B6o43GuS7kEIqJjFlTyiMXEx0zz4Mk4w9UsR+PfS3GshQNrMSY6Qves8Uv
         HDFHy12yPRkA4Od3lUPTjlLFZbVKNJ4DO+3xPIGo2Y69GvuI5o9zOP3jf2DGmy+LzvlE
         BPnXMl1QZ+SWRyuQDEhGoTp8OxzyFT4JrIPljoEQET5q2SkWu/E/iBuHZuzU0yZ4Xm3s
         8NIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4BUN4J5E6Bz7cZQaG5nO0lgK+0H2xFl3M8KSMLQOKzg=;
        b=CvuRAH4pdrOLq2U1r19Q3XeSip/wTJ5lpCmP0li2ow1JX3ikbylmWHVGdXJAknWo4l
         KRKZymRDDBG4/9I35k4fkbtQGa1q1UWKFrffL4VVP91hXlEMwLHOD1FAV7g2yXL9sy0N
         RDMI5KO1MYSEL3cRSZQ6H5RMOnd6hHRctC00jJ0Y6lAjM0aAN88MQs39qAK5QJcNZ7aa
         tplHGy2ZD1uvVVk+4sz3R9dM8FgLhqEO+wXqOtAlE3GPpBm/szX8sGKcEmLwRzE68ew5
         bbmQEM65Q9HCStauEcp1A+OIDdYRZZBBDe5OC+WyjSMQ0p8KKg9463KxL+lVZmkDhFXG
         2tvw==
X-Gm-Message-State: AOAM533dNTjY89jde9oEASBZFfOl6MIOl//ro/mzhKvB198JWytqa8BG
        DK9s1Q3NGLJbVE1JPjgPZOYtlk4PgOC72TFWb63FxyyzfwoCLw==
X-Google-Smtp-Source: ABdhPJxb8zqbu2p5ZBObPWpQKqE5g5n4BXp5Hcy48c9RQE/HT0KRF2Fs/jc0yTchmrY7TzvFSW4QjJGjfT+6g0s4+ww=
X-Received: by 2002:a1f:2516:: with SMTP id l22mr5008947vkl.25.1618311038067;
 Tue, 13 Apr 2021 03:50:38 -0700 (PDT)
MIME-Version: 1.0
References: <pull.847.v5.git.git.1615580397.gitgitgadget@gmail.com>
 <pull.847.v6.git.git.1618255552.gitgitgadget@gmail.com> <02bd1f40fa4e281f878d0b9ba4a8b5f8eb21c8ff.1618255552.git.gitgitgadget@gmail.com>
 <87fszuej8y.fsf@evledraar.gmail.com>
In-Reply-To: <87fszuej8y.fsf@evledraar.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 13 Apr 2021 12:50:26 +0200
Message-ID: <CAFQ2z_MQp99uPpdai9Hbh76h-PO3JUHmY-pasSXONjeRp8dTzA@mail.gmail.com>
Subject: Re: [PATCH v6 02/20] reftable: add LICENSE
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Patrick Steinhardt <ps@pks.im>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 13, 2021 at 9:28 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>     > However, it is fundamentally blocked on someone willing to spend
>     > some time reviewing the series; this seems to be out of my
>     > control.
>
> I for one find it hard to follow re-rolls of this when past discussion
> isn't clarified/updated in commit messages/CLs.
>
> So in particular in v3[2] there was a whole discussion about what what
> this licence & external hosting of this codebase meant in practical
> terms.
>
> I vaguely recall that that was clarified in some way by you, but didn't
> find the relevant E-Mail. Something like Google's lawyers said something
> to the effect that this could just be added to git.git, no? Maybe that's
> incorrect, I don't remember.

You're right, I didn't update the thread. The outcome is that the
library for now lives in https://github.com/hanwen/reftable while it's
not integrated in git.git. In this repo I can accept contributions
(including fixup changes posted to the git list) without requiring
CLAs.

> I.e. if it's meant to be 100% externally maintained and "code-dumped"
> into git.git like we do with sha1collisiondetection/ that raises one set
> of concerns, but if it's meant to be "eaten" by git.git that poses
> another set of questions for the code review here. I.e. much of what
> you're doing in later patches in this series is introducing things that
> are redundant/odd if viewed if we're supposing that this code is meant
> to live in git.git.

The code is meant to be eaten by git.git, but be amenable to being
used by libgit2 with minimal modifications. To that end, it tries to
use just functionality offered by git-compat-util.

If you could point out specific oddities, that would be helpful.

As said earlier, the BSD license here is the most liberal I could
find, but I'm open to something else, if that makes integration in
both git and libgit2 possible. This was not discussed further, and
hence the "TODO: relicense?" comment.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado

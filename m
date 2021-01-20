Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8ED4C433E0
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 11:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADA1823159
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 11:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbhATLdW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 06:33:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387641AbhATKla (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 05:41:30 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76DB0C061575
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 02:40:43 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id d14so24792499qkc.13
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 02:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gitlab.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UX1Yl2TqZdoPxqBMzSTjJXG1P2fQ9PZwI2vgX6qdoAc=;
        b=d7BYe+SdDO/2kZ8jOfV5cnRA/o98rfcS4Z3yNAlos9/hNflZKa0BsxZEV1hV+E7cPj
         zlFOdyiL0fmcueZ7ERY+0v45FIhOzmjhEJy+xN1Dfjaf6hfdsTlWBoO9dqQPYzFZWNcC
         3OMZ+NngW0K9N96G1/5YlkpKe5AWPopdLLahk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UX1Yl2TqZdoPxqBMzSTjJXG1P2fQ9PZwI2vgX6qdoAc=;
        b=EEjDZ8mIjfpcLsSlJzIeSXcVQjzwn8QsEJcP/ZHnp/a9ORfKZkyy2N6xtb38Ao1dEa
         fqlTPYnKtEIDrXtVQLhL/HnZQ0aS+Ef90etrIYTJmwkVAKDYopj8jElGvyR+8aOISNfy
         sdW1NiUYkKJ1T6LZ45h2Xd+pO/259jP7kfTVRzv2Yz1qyb2W8ekzQHZGEQAW+MeiOjHo
         Zu4ik9yoZrFBDK0M86FFkaWLfbuwN+WILX233fdeg58d9sdpefJis7tp/rJtMJyNfKwf
         LNjtL/F6ojKBKP3ok//zpx5LIR0CXQzhr9zAg1pXjl918MCiF+PkCK3eiA6VyRyzZKUP
         89Ow==
X-Gm-Message-State: AOAM530gl+r+ZCUQN5iuSO5WFq67KwpLzZd2ZZEFsBjrDiznPSWiJoNk
        tLuXBLis3twyARep0Ob6PIh1GmVVAe9urksNBPvdQNSRbGbrKtmO
X-Google-Smtp-Source: ABdhPJzMI9/+3+boto9UdjH51jRdnE6ikgNOKQzviqonb6dQpSjJoPTNBvekxHwXKX24tI0rXC7UUN87bBkwe9tkvMw=
X-Received: by 2002:a05:620a:673:: with SMTP id a19mr8574633qkh.353.1611139242365;
 Wed, 20 Jan 2021 02:40:42 -0800 (PST)
MIME-Version: 1.0
References: <20210119144251.27924-1-jacob@gitlab.com> <20210119144251.27924-2-jacob@gitlab.com>
 <YAdjBC7z2eE1Z0uk@coredump.intra.peff.net> <YAdkg7ZijzfB8eMc@nand.local> <YAdnB3Qy46qQ2to4@coredump.intra.peff.net>
In-Reply-To: <YAdnB3Qy46qQ2to4@coredump.intra.peff.net>
From:   Jacob Vosmaer <jacob@gitlab.com>
Date:   Wed, 20 Jan 2021 11:40:31 +0100
Message-ID: <CADMWQoOzD0xF4PSAUo2qXp62-tTJX4DhquFZxFjfdQmy+7j+6g@mail.gmail.com>
Subject: Re: [PATCH 1/1] ls-refs.c: minimize number of refs visited
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 20, 2021 at 12:11 AM Jeff King <peff@peff.net> wrote:
> It's not a _huge_ deal to me, but I think it is slightly nicer as a
> separate patch. Plus it can easily be credited to Jacob, so at least he
> gets some authorship credit out of this. :)

Thanks, I'm fine either way. Just remember that the other changes in
ls-refs.c depend on that strvec_init, so if we split it out, we need
to remember / maintain that (order) dependency.

> Having now looked carefully at the ls-refs code, it's a pure
> prefix-match, too. So I think we _could_ rely on for_each_fullref_in()
> returning us the correct full results, and not checking it further in
> send_ref().

I also think we could. But as I alluded to in my original commit
message, I don't like how complicated that gets. I find it easier to
convince myself in the current form that the longest prefix code
selects _enough_ prefixes, which is a weaker property than "selects
exactly the right prefixes".

Jacob

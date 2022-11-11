Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3746C4321E
	for <git@archiver.kernel.org>; Fri, 11 Nov 2022 18:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234137AbiKKS3i (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Nov 2022 13:29:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234136AbiKKS3Z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2022 13:29:25 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B115CD05
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 10:29:25 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id i19-20020a63e913000000b004705d1506a6so2956879pgh.13
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 10:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6LxRTl8W3LcQ0pJXZpvadEcZWdM+ODhwQ1PJs5VxFmM=;
        b=drookIX0ukV7R8Zay4BOcx6t1MhuPuEPRanliSTjVZa9A5jGj3uWKHDJivOaopUqcr
         X2/L+xz7+QlCYWAeefWu48Fb1GO4QDd3FC0Ha6uWWiEesQN3gVuIfRIL/GLYPHikvfRd
         2nT0X4XknF4h0P96eQjBL8gw7HEBh+O1yAZ0XAEvHcJm/+Ivzhej9UFgiKnYHrK1b+uT
         1d6GiRgwSpTl9is5ax2EFgwb8TMe8VIwCK2W5uEz9Hg48zsPGw5KbnrbNJybmYsa6EMt
         bHMZjVC1Uqh46i6cIaDJZ07u6yHYjyyvfVIv2FGKy4fJXe9rK4wqc+YwXiF+RWc/q2T/
         s1Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6LxRTl8W3LcQ0pJXZpvadEcZWdM+ODhwQ1PJs5VxFmM=;
        b=k/NGcMZM2S1EEofSgBOq6K40QZtnzOKpjvbSZSB+X4y2fzJ47iz4JPXbEt8OB0YAlD
         FzXCaUCJPjM/n93XELqJt8GZKdgJOepvQIygWi8k23P/0pv2E7w0G+0WLC9kUTYRX3kI
         6Mk4QGBFKP1yDKvqRWa/2r1q5Z9mi8y9V+PJhssmAGXf5l/fLFN8x5+E85QXfVJzf3ci
         dw/ZwpD/DsZK1fKT1OCtNSSs/p9/7G3Mi0QdqVKmmfjuJfRqv2HjXmSHRs8rEmkA4DkH
         JxQFyIpV/0rDwuLJsgz9bwTc9+nCQDoQhmefeSlzdWJtSWcDKuKN2vxZWjHKLGmGHMCv
         vHyg==
X-Gm-Message-State: ANoB5pnaA7Ge0/qLqQWThw1WDpMfeh0hUHK0BMa+AyPhJXYKT6CJTVu0
        qrxGMKazNRYvuxio8UZ6ROQ9DzoMsU5UwA==
X-Google-Smtp-Source: AA0mqf5TRq3jzFI4nXDVy+7qpTRIuWpxfUbHO9iITUJkHeHFeUG99nWV/ROoI2zVNk2djV0nb8QEMhu6+6jgQA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:80d:b0:53e:6656:d829 with SMTP
 id m13-20020a056a00080d00b0053e6656d829mr3848997pfk.63.1668191364791; Fri, 11
 Nov 2022 10:29:24 -0800 (PST)
Date:   Fri, 11 Nov 2022 10:29:22 -0800
In-Reply-To: <kl6l5yfm2taf.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20221109004708.97668-1-chooglen@google.com> <RFC-cover-0.8-00000000000-20221109T192315Z-avarab@gmail.com>
 <kl6ltu373ae5.fsf@chooglen-macbookpro.roam.corp.google.com>
 <221110.86zgcznjah.gmgdl@evledraar.gmail.com> <kl6l5yfm2taf.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-ID: <kl6lv8nl1h19.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [RFC PATCH 0/8] Get rid of "git --super-prefix"
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> Rereading this series and thinking about this some more, let's go with
> your approach, primarily because it avoids global state.
>
> From this series, it seems that it's not that hard to make this change
> and support whatever use cases we currently have.
>
> This does make it more tedious to add more "--super-prefix" in the
> future, but that's a good push for us to do more things in-process
> and/or be more principled about passing context objects through the call
> stack instead of relying on globals.
>
> Let me know what I can add to this effort besides reviewing :)

Specifically, if you have other things on your plate, I'd be happy to
pick up where where this RFC has left off.

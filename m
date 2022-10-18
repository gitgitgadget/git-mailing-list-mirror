Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F709C4332F
	for <git@archiver.kernel.org>; Tue, 18 Oct 2022 17:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiJRRDH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Oct 2022 13:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiJRRDF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2022 13:03:05 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06BCEE0A9
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 10:03:03 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id n56-20020a056a000d7800b00562b27194d1so8087621pfv.19
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 10:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7MvOdKrNwE/c3q/MlPlx5KkV3GKJP9V/9Xn3RU24Df8=;
        b=JlNtP9q/hgSi/wczXHwo0kDMQYB3V5l/j7kyjbm/mkrYqzI0YHQ0jQOV8eGG3XHXYx
         P0FISh8BG8n0v/6LX0xj77oM1koBJN5iE3LpxxgsctBD6owoHAKVidobVYVvY4IsgRaD
         E0PDthJ7eAUJxKC7IKimlwFnbJ1OP01IaKMucSlY1H7UsydkJp8jnQAqHOETTtsn6jk/
         YFVjqqxDWhfR/W9KJxjiVmd4nfnspklPZt5kE5tYB6gBqeXhdq5yli9pAVygsqit1Kql
         TJaL/IFfKa9Nz6m3EgznQvWvWP3ce1euuk+VHM2FKtDOzR1vUd6RrUogQDuVa83nMfPz
         Fgdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7MvOdKrNwE/c3q/MlPlx5KkV3GKJP9V/9Xn3RU24Df8=;
        b=4tIoiJ9vrHT5yso4JpiDvzRgGpk/VzWSfz379npvl2GHhE1XR7FEdc8SOp4aU6EXlj
         jXy5fsL3okWxG4Y6tr/KxIJaJiJbFj+U1ff4sEtBskGzW9CTjWwb9My6Rowg4/3zZB0z
         e27o4L39bt3g+dkpn7szIfOfURZMSYC5IYkDtFfo5aWxZK+Yhs5YY1YaLBEZthotFexk
         BZoHzjMxIDbAWHo2yN51G8o4CdHzKf9JxfiPRzNciFv6jgUP4mPoAWRAw1dyueIpf53J
         mX3/NpWNUjToPiWjZ09h2pciq27XAPlnTVZwkkon7Vwklx2VFLxiQeXSmeFs8xjWwbDY
         YyRA==
X-Gm-Message-State: ACrzQf1XIU+oHPU+3RBlZTmlQtzRF9hjlKkk7NH4qLv9A7webBz3t15g
        FRb5X747koDWYW26T+tW2jaOS9tjeFhKhQ==
X-Google-Smtp-Source: AMsMyM52XP2/htokS4HrlsONEkdS1uG9IauexY6o3AFcUXGP7Uzl97+dmlb9nxWjv7+oBtAaPY2SY6ncTdANcQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:a04:b0:534:d8a6:40ce with SMTP
 id p4-20020a056a000a0400b00534d8a640cemr4289509pfh.15.1666112583118; Tue, 18
 Oct 2022 10:03:03 -0700 (PDT)
Date:   Tue, 18 Oct 2022 10:03:01 -0700
In-Reply-To: <xmqqo7u9wyt7.fsf@gitster.g>
Mime-Version: 1.0
References: <pull.1352.git.git.1665326258.gitgitgadget@gmail.com>
 <pull.1352.v2.git.git.1665783944.gitgitgadget@gmail.com> <kl6l7d0yyu6r.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqqo7u9wyt7.fsf@gitster.g>
Message-ID: <kl6l4jw1yshm.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v2 00/12] fsmonitor: Implement fsmonitor for Linux
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        Eric DeCosta <edecosta@mathworks.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Cc-ed Johannes, who would know a lot more about CI than I do.

Junio C Hamano <gitster@pobox.com> writes:

> Glen Choo <chooglen@google.com> writes:
>
>> At $DAYJOB, we observed that this topic breaks MacOS builds with sha1dc:
>
> Thanks for a report.
>
> How dissapointing.  The thing is that the topic has been in 'next'
> since the 11th (i.e. early last week), and I know that you guys rely
> on the tip of 'next' in working order to cut your internal releases,
> but we did not hear about this until now.

Yes. Unfortunately, we (Google's Git team) release on a weekly cadence;
we merge on Fridays and build on Mondays (PST), which makes this timing
extremely unfortunate.

> Possible action items:
>
>  * See what configurations our two macOS jobs are using.  If neither
>    is using sha1dc, I would say that is criminal [*] and at least
>    one of them should be updated to do so right away.

I'm not too familiar with the CI, but I took a quick peek at ci/lib.sh
and noticed that none of the jobs build with sha1dc, not even the Linux
or Windows ones, so..

>  * The "two macOS CI jobs sharing too many configuration knobs" may
>    not be limited to just SHA-1 implementation, but unlike Linux
>    builds and tests, we may have similar "monoculture" issue in our
>    macOS CI builds.  Those users, who depend on macOS port being
>    healthy, should help identify unnecessary overlaps between the
>    two, and more importantly, make sure we have CI builds with
>    configuration similar to what they actually use.

I don't think this is a macOS-specific issue; our CI just doesn't do a
good job with testing various build configurations.

>  * Adding a few build-only-without-tests CI jobs also might help.

This sounds like the way to go IMO. It might be too expensive to run the
full test suite on every build configuration, but build-without-test
might be ok.

>  * Those who depend on working macOS port, especially those with
>    corporate backing who choose to use configurations that are
>    different from what we have CI builds for, are requested to
>    arrange a more frequent build test to catch a problem like this
>    much earlier.

I wished we had caught it sooner too. The folks here generally agree
that our weekly release cycle is not ideal for reasons such as this.
Hopefully this is good motivation to move that work forward, though I
can't promise anything right now.

> Anything else I forgot that we can do to improve the situation?  I
> personally do not use macOS, I am not interested in using one, but
> I do value those who choose to use macOS have happy git working on
> their platform, so the stakeholders need to chip in.

There's nothing else I can think of at the moment. Thanks for your
patience and for moving the conversation along.

>
> Thanks.
>
>
> [Footnote]
>
>  * Until the world migrates over to SHA-256, the collision detecting
>    SHA-1 implementation is what we must use unless there is a strong
>    reason not to.  If we are not testing something that ought to be
>    the default, we are not doing a very good job.

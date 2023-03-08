Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AEA7C64EC4
	for <git@archiver.kernel.org>; Wed,  8 Mar 2023 18:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjCHSA6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Mar 2023 13:00:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjCHSA5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2023 13:00:57 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13D8C561B
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 10:00:53 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id in10-20020a17090b438a00b002376d8554eeso6909047pjb.1
        for <git@vger.kernel.org>; Wed, 08 Mar 2023 10:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678298453;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bKutCFHTphQGyR0zJ2js1qZdALh8uurKupsRMSeuEu0=;
        b=sWibEQpgLSUvQNukzk8rFgrdmc17otq6uM81qH1NN9tqXJywgitGgn2Ss4P0AyIeKq
         ZLKXgdYqFNc8esOcmxbJ1TWeRU/G+F5jxyPakJAxA9LZGyEAcHpnSQl/s3MX7YI+AH6a
         robg0KRugmdn8A85VILqSaZqlMoO3ItUUerPdyoQaSH8e5RiWkhWvT8n1BDatsEoYkta
         Z5BG2vNH8yuj5Qn1bVllI9NMkK+75M4jaScwaF5rxOrJRkMn5ezAhNLeHEnqHmCzSk0c
         uilGKLPE6E3phdETpXKjYHqoon1oRtSrDzS+zYmS6kwBF8EpSZyR8UmzIizpDgrQ8evy
         /lmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678298453;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bKutCFHTphQGyR0zJ2js1qZdALh8uurKupsRMSeuEu0=;
        b=m/QmcsWcPj9GEKj1g4oW534nMuqL8rftbc75Y4mBgbXad3TO1eZut4G40/iC4Yj911
         SBgNJ657tfGkSetUo41AigByG8Wr1s2rtOHsWM1LFurtS6gi3lblkqr/Uw7EKaiZcLaw
         0LyZwbAtUXp2/Bxq8Hw2JHvV35uo69ff5/EPya8EKe3s8X/YqPZwqJFW5MKO9fsHQA7N
         pFs0ptCnMuAfr7tMn7NT4D9idpjxfn9SXVe9UkC5nsCQTl2HrY1XyAt6Jce92vz/Bnt/
         tPbjhHs9E6jQHWjftpQI5hzG1UmBFcY1tzOKoT65Fz/tkjLz/bwdV7IqPCDeo2Z6GnO/
         6WkA==
X-Gm-Message-State: AO0yUKWt8Ucgf96/Y1D6yxfPkCPvyOVlWcAos+T+r3Rkaohg0ZZseNvz
        NP6t8NCqXvzXRqUIFrf7rIr0X95tk/Sr4Q==
X-Google-Smtp-Source: AK7set+sf00uWCRWcsKGDdwE5qVjNskuiN2T8y3VxKNdOXdQDirxz4wNoXZMg0TL2LHgiYFIt4QjXS43Aa99VQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a63:b55e:0:b0:502:e1c4:d37b with SMTP id
 u30-20020a63b55e000000b00502e1c4d37bmr6583009pgo.12.1678298453429; Wed, 08
 Mar 2023 10:00:53 -0800 (PST)
Date:   Wed, 08 Mar 2023 10:00:51 -0800
In-Reply-To: <230308.86356fzhbd.gmgdl@evledraar.gmail.com>
Mime-Version: 1.0
References: <pull.1463.git.git.1677631097.gitgitgadget@gmail.com>
 <74a63fed7054da8049d4a32ecdb582726368c5a8.1677631097.git.gitgitgadget@gmail.com>
 <230308.86356fzhbd.gmgdl@evledraar.gmail.com>
Message-ID: <kl6lttyvgm24.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH 4/6] config.c: plumb the_reader through callbacks
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Emily Shaffer <nasamuffin@google.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> So, there's a lot of churn in this topic from renaming "cf" to "cs" all
> over the place, I really wish that could be avoided for the size of the
> overall diff, but haven't looked into in detail how easy that is, but...

Yeah, I think it can be avoided by taking Junio's suggestion to rename
the global "cf" to "cf_global" or something, then accepting a "cf"
parameter.

  https://lore.kernel.org/git/xmqqh6v1g1d3.fsf@gitster.g

>> -static int configset_add_value(struct config_set *cs, const char *key, =
const char *value)
>> +static int configset_add_value(struct config_reader *reader,
>> +			       struct config_set *cs, const char *key,
>> +			       const char *value)
>
> ...this is an existing name just seen in the context, but could we in
> this topic at least avoid having a "cs" refer to both a "struct
> config_set" and a "struct config_source" in the end-state?

Fair. This also irked me when I first saw it.

As an aside, I found "struct config_source cf" to be a bit of an eyesore
too. It's an unfortunate holdover from before 4d8dd1494e (config: make
parsing stack struct independent from actual data source, 2013-07-12)
when the struct was called "config_file". Unfortunately, "cs" is already
taken by at least one parameter, so maybe we'll never be able to
properly rename it...

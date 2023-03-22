Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F7F3C6FD1C
	for <git@archiver.kernel.org>; Wed, 22 Mar 2023 23:54:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjCVXyC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Mar 2023 19:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjCVXyA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2023 19:54:00 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906016595
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 16:53:59 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-541942bfdccso204412367b3.14
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 16:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679529239;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0UjVfJebSzhDHlJnK+hZCnK+Y1hUGdU21v1ipv1Ns20=;
        b=gGI5W87z9yJSLwEZrG/9PQ1Y6W6hF4BEju4B00A69f+a7rJu8vS4uDpdIYC0WVLLXq
         jCAuvZ5BFq0pJAGVWA6lAx5pzwDZEBUvx/Rd/OSSs2KgAXU473N5rdVcC2vSsg4IGMmU
         /fuS5u8YBeQc/OIVj7yZ2mmqVObhXU6m4HyvbswNG3j1fWiOROEBmfsDwxst5J4cNiLP
         Zi84hj3Hhc5IUEiMPeXQd0anWHYwwq5RyFye/N76D7Rfhk7+YO/ncmZkQnmqXZZ8flj2
         wY1Bby4oin4Zrsr0tbGEGZADd3Qu3qRxE68oICndhCL2JjnRa4OlGxcxtGQLVACxU45r
         vpGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679529239;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0UjVfJebSzhDHlJnK+hZCnK+Y1hUGdU21v1ipv1Ns20=;
        b=ZXZ3vOVh/KoLVDaFBqOp1luk4eOjCjGiVuT3m5d9tXDU3b1dEhTeIKYhMfR7yMnSsO
         EX+Uw9zzyCkYc8gN8MEv5KXDcXZs3+8lX1gXFg80t7Z7IxSlHg6Ntsg3cB8BhfIoHJv4
         tqmizkKchNa63DgOGdRus6mjUapqyTb8tAqrNbPM+1OtD+6j7t+iq7JSmRfuY4WelfVw
         pyt6rA6UzOO8pOBEtOlIU9WFTNJVWdAEOgYuJ99jM03/9F9yXClbhM+P/dih5tsKKcsr
         hcOFRMJFaLZ9yQvmC9Pmqa0YJJgN8TW7A0hyQ2Ln2pZH8eZDQiyg7RtVVSQo05d3Yr2M
         8TDw==
X-Gm-Message-State: AAQBX9eS3tmyu+AHKwJ0/4QXfqNGhNOf1w6G2haBuYRZrXt8wJPRSRSu
        EW/Wu9Wu7c5zBJBeIHgRFc5ZyKZeDoSF5A==
X-Google-Smtp-Source: AKy350alJOMCdYR9aqaFcCWzsgEE1/qN5a2Pkl8OM0xSTfbzXZtc50OBQdg0tnKghuErh1ZCA+gk9p5MqwlVdg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a25:1c1:0:b0:b6e:1ff3:e168 with SMTP id
 184-20020a2501c1000000b00b6e1ff3e168mr844855ybb.4.1679529238758; Wed, 22 Mar
 2023 16:53:58 -0700 (PDT)
Date:   Wed, 22 Mar 2023 16:53:57 -0700
In-Reply-To: <kl6l8rfoe4qr.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <cover-00.17-00000000000-20230317T152724Z-avarab@gmail.com>
 <patch-15.17-c8ff241844a-20230317T152725Z-avarab@gmail.com> <kl6l8rfoe4qr.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-ID: <kl6l5yase416.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH 15/17] cocci: apply the "revision.h" part of "the_repository.pending"
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason         <avarab@gmail.com> writes:
>
>> diff --git a/contrib/coccinelle/the_repository.pending.cocci b/contrib/c=
occinelle/the_repository.pending.cocci
>> deleted file mode 100644
>> index 1190a3312bd..00000000000
>> --- a/contrib/coccinelle/the_repository.pending.cocci
>> +++ /dev/null
>> @@ -1,14 +0,0 @@
>> -// This file is used for the ongoing refactoring of
>> -// bringing the index or repository struct in all of
>> -// our code base.
> We can't go so far as to say that we've removed all implicit references
> to "the_repository", though, since we still have functions that
> reference "the_repository" in their implementations. But, I don't think
> this ".cocci" file would help us with those cases anyway, since this was
> targeted specifically at functions/macros that were passing
> "the_repository" to functions that accepted a "struct repository" arg.

For these implicitly-the_repository functions, (e.g. git_path) we'd
presumably refactor them into repo_* versions and then apply the same
sorts of changes we did in this series? I guess we'd make those changes
in contrib/coccinelle/the_repository.cocci, so we don't need the
*.pending* one.

On that note, I'm curious what contrib/coccinelle/the_repository.cocci
is doing for us after this series. By definition, all of the macros have
been fully migrated, so they're all a noop. Would this slow down `make
coccicheck`?

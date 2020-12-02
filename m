Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D0AC83012
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 17:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44AA7221FA
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 17:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387628AbgLBRUo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Dec 2020 12:20:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387524AbgLBRUo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Dec 2020 12:20:44 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1A6C0613D4
        for <git@vger.kernel.org>; Wed,  2 Dec 2020 09:20:04 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id q22so1948233qkq.6
        for <git@vger.kernel.org>; Wed, 02 Dec 2020 09:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=GNaAFRWQNhbcb1z4DAhiB0ZWcbZ4xfzUokwd2IZPZ54=;
        b=CtnN7exp63JrbdrK2ZssSN/keKnLbEpJitvQAsdbLISXKyrf4D7Gjgnv5gQHHpuM/9
         Ke6OpxjwohsmkjP/KCfkJIXCz0easN/IyZNx5zorV5JkSJU64KzrdzZck3Uwj4CPCV8e
         i4r6BEKqrz5+VhBFlEWWuWyGhforvCnhpE1McDlcU9JDQ8QtfdemP9gUTE0PKyWrISXZ
         BGUTLnuj2lKxte1Fexwt0jDBxCru0Om/hwzffTfpuJmrYM+fuk2zdOPhNNxxx/iAonTB
         IB/suLeFqSlqautbHhqA2F8hrlT/JVE2RKt/rl9YCIUCi+q2vGN5gqJCsSwJjtLgVkke
         DX7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=GNaAFRWQNhbcb1z4DAhiB0ZWcbZ4xfzUokwd2IZPZ54=;
        b=lAQF9sg+3gVIvml690ib4iyNySifjUzl6lmTwZFBftMnAP9nBLaZ8aBhIHXMSN1td+
         AfLKDF4oK2Ei4J/CzyL1lr7JdAbDjdqWqci/7V3nq36vfIwjFmH5j4t7ZKhwm5dwjFku
         IovQck2Mrg4pJx84xfvtIUKFmZxT5zg/rtJPWkQySwSOhJCP6QQMSFHYR60HLRWg9T8i
         kk+UPbtur7qzrCivJcrU2zRyMEHAWGC95HY7bHgNwn81jjp3qWiss1x1sNF2nXsWpIQ0
         Ix8Zq75oRO7RfdyPUOCsetslJarLLZK43I0ecP9xkxCh/fwm0dfpg/WPZXSiWFmCNHwz
         SwwA==
X-Gm-Message-State: AOAM530lW10mzDRbbf+LtI6R+qrNk8q8qSD5kH/RCEv4+7m65OJ3TSML
        QfsILTOBc+UF8x+jtc8OPiM=
X-Google-Smtp-Source: ABdhPJxdFaz3LQc8uPQBToKNSPrsGDVORu1iaoAqGzF7L4I+uWsbo/HlGOxG6q339+qjNOQ6faRrzg==
X-Received: by 2002:a37:5103:: with SMTP id f3mr3491112qkb.460.1606929603450;
        Wed, 02 Dec 2020 09:20:03 -0800 (PST)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id f129sm2364837qkb.22.2020.12.02.09.20.02
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 02 Dec 2020 09:20:02 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: BUG in fetching non-checked out submodule
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <CAN0XMOLiS_8JZKF_wW70BvRRxkDHyUoa=Z3ODtB_Bd6f5Y=7JQ@mail.gmail.com>
Date:   Wed, 2 Dec 2020 12:19:59 -0500
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, peter.kaestle@nokia.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <CC0FA973-E37A-4BD3-B5A2-1436DD8DF16F@gmail.com>
References: <CAN0XMOLiS_8JZKF_wW70BvRRxkDHyUoa=Z3ODtB_Bd6f5Y=7JQ@mail.gmail.com>
To:     Ralf Thielow <ralf.thielow@gmail.com>
X-Mailer: Apple Mail (2.3124)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ralf,

> Le 2 d=C3=A9c. 2020 =C3=A0 10:56, Ralf Thielow =
<ralf.thielow@gmail.com> a =C3=A9crit :
>=20
> Hi,
>=20
> I have the current 'master' branch of git installed and get
> the following error when fetching a submodule that is not
> checked out.
>=20
> I've bisected this error down to commit
> 1b7ac4e6d4 (submodules: fix of regression on fetching of
> non-init subsub-repo, 2020-11-12)

Thanks for bisecting it. That commit wanted to fix a different bug
related to nested submodules, and the route taken was simply
reverting an earlier commit (a62387b (submodule.c: fetch in
submodules git directory instead of in worktree, 2018-11-28).

As you discovered, it breaks other scenarios.

>=20
> $ git version
> git version 2.29.2.435.g72ffeb997e
>=20
> $ git config --get submodule.recurse
> true

Yeah, I think the test suite could make more efforts
to run more tests with that setting turned 'on', but
it would require significants efforts since it changes=20
the behaviour of several commands.

Meta question: is there an easy way to run the whole test
suite with specific config options turned on ?

>=20
> $ git submodule status
> -855827c583bc30645ba427885caa40c5b81764d2 sha1collisiondetection
>=20
> $ git fetch
> Fetching submodule sha1collisiondetection
> Fetching submodule sha1collisiondetection/sha1collisiondetection
> Fetching submodule
> sha1collisiondetection/sha1collisiondetection/sha1collisiondetection
> Fetching submodule
> =
sha1collisiondetection/sha1collisiondetection/sha1collisiondetection/sha1c=
ollisiondetection
> ...
>=20
> $ git submodule update --checkout
> Submodule path 'sha1collisiondetection': checked out
> '855827c583bc30645ba427885caa40c5b81764d2'

Ok, you don't add '--init' but the submodule gets checked out,
so it looks like you have 'submodule.active' set to a pathspec=20
that matches 'sha1collisiondetection'. Did you clone the git repo
with '--recurse-submodules', which would add '.' as the value of
'submodule.active' ? Or maybe you manually configured that value
in your global gitconfig ?

Thanks for the report,

Philippe.


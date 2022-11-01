Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77610C4332F
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 22:12:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbiKAWMH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 18:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiKAWMF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 18:12:05 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB89E13D6E
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 15:12:04 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id x2so23800285edd.2
        for <git@vger.kernel.org>; Tue, 01 Nov 2022 15:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SOTgL0pCF74bJ5pUaMG3hDmHCm2WkkRr6kxzVGvoFbg=;
        b=MWbkZA4O0P9yZu/wG/h+vG6XEtMTxjRqi1fyTIHktTrumCUJNYbP02DS8WX7i/9JlE
         btKNOWhe+zu5Vlgi9wKFyEcZclzl7b4S9MYENEU4TC44TVaL0j2HXXDtzs0m+u7o63Zc
         aGM4Ku9Njo5Y0kEd4x5g2u/K3eDKVyoalBXapESi/qT18AdaDrw8Ax1Gv/K8D3CkeJR/
         wUlVnAa9vU2e1FurAVrLNJptwLruqwdYW2ktZCyiNI6F+cnIdZk3WtmKZc9EK0nmjhCV
         rbWue5XU0XQ7qttLwI/bCC47jwX9FAk79tVm0sZAyv1nlGcRfYUlO3VYzH9UrvDzwcuF
         89nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SOTgL0pCF74bJ5pUaMG3hDmHCm2WkkRr6kxzVGvoFbg=;
        b=g0AGiuFkRCX8rE1ogXqGwrmhoLJmuknjWpLt3CE+qOFv+9x+BCrFtq4BJoo/4CEMzj
         F3CbKFN6d5Od2fQy1csWJM8uq7aNgW8Eum9F6lUqDKM+9rkV0z1TYv0JPbolZSRzTJKH
         lzh//ulMquEby+4qCZjwqYtRl9TYYDbgrhPd6Oc4v+92ZiIzkxZnHN7fMUEsAwUyeVsr
         AcJ9NpA9DDurJumLqMwkra4y912Uz34MBM1/26Qa+lElXcSb7j21piW9wkYr4B+9nrsM
         MLzaDC/0vN4F3xY1uFmh3rOxhqRWIWldFtx7bFJ41hvKKPxeyRHMkWpArZt2VVFGzWfS
         scXg==
X-Gm-Message-State: ACrzQf09qojkd1OkDW41zuNoOQZEMjFUXZd/U9BIt+7WtqO8RM+pdzAz
        DHqNSmoOA3spoUgXGHWpy68=
X-Google-Smtp-Source: AMsMyM42dByh52/RUcKiohCbDmquKFFtIqmrmfHd/Iu5rOFhPphPJjDKHcVFg7ubUjzpM8BWfMUyvQ==
X-Received: by 2002:aa7:da42:0:b0:461:9465:b019 with SMTP id w2-20020aa7da42000000b004619465b019mr21923630eds.144.1667340723142;
        Tue, 01 Nov 2022 15:12:03 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id gw18-20020a170906f15200b0078d3a075525sm4671219ejb.56.2022.11.01.15.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 15:12:02 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1opzUI-00Bal1-0H;
        Tue, 01 Nov 2022 23:12:02 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [RFC PATCH] fetch: stop emitting duplicate
 transfer.credentialsInUrl=warn warnings
Date:   Tue, 01 Nov 2022 22:57:46 +0100
References: <pull.1399.git.1667245638.gitgitgadget@gmail.com>
        <RFC-patch-1.1-0266485bc6c-20221031T204149Z-avarab@gmail.com>
        <Y2CFRJLFRXvGwFBC@coredump.intra.peff.net>
        <Y2Doe0ZGb3Zmmmen@coredump.intra.peff.net>
        <221101.86o7tq4vsn.gmgdl@evledraar.gmail.com>
        <Y2GI0R6pJmdZNgHn@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <Y2GI0R6pJmdZNgHn@nand.local>
Message-ID: <221101.8635b24959.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 01 2022, Taylor Blau wrote:

> On Tue, Nov 01, 2022 at 02:07:39PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> > You can also put it lower in the function, when we actually warn, which
>> > saves adding to the environment when there is nothing to warn about
>> > (though this way, we avoid doing the redundant work).
>> >
>> > Compared to munging the config, this seems shorter and simpler, and
>> > there's no chance of us ever getting confused between the fake
>> > "suppress" value and something the user actually asked for.
>>
>> Sure, we can do it with an environment variable, in the end that's all
>> git_config_push_parameter() is doing too. It's just setting things in
>> "GIT_CONFIG_PARAMETERS".
>>
>> And yes, we can set this in the low-level function instead of with
>> git_config_push_parameter() in builtin/*.c as I did. I was aiming for
>> something demonstrably narrow, at the cost of some verbosity.
>>
>> But I don't get how other things being equal you think sticking this in
>> "GIT_CHECKED_CREDENTIALS_IN_URL" instead of "GIT_CONFIG_PARAMETERS"
>> helps.
>
> I vaguely prefer calling this GIT_CHECKED_CREDENTIALS_IN_URL instead of
> stuffing it in the configuration.[...]

To be clear, I'm asking if there's cases where we think one method or
the other produces different results, which I understood Jeff hinting
at.

> Instead, we're saying: "regardless of what value the user assigned
> transfer.credentialsInUrl, we can avoid looking at it because we have
> already checked for the presence of credentials in the URL".[...] All
> other things *aren't* equal here, since we're not lying to
> sub-processes about configuration values set by the user.

The user is asking us to warn about storing certain things in config, we
know we already warned, so we're looking to flip that value to the
"quiet" setting.

If you consider that overriding I don't get how doing so via a different
environment variable changes anything. It would be doing the same thing,
just making it less obvious.

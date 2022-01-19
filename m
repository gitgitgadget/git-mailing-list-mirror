Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E810AC433EF
	for <git@archiver.kernel.org>; Wed, 19 Jan 2022 15:31:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355727AbiASPba (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jan 2022 10:31:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355832AbiASPbX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jan 2022 10:31:23 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287E2C061759
        for <git@vger.kernel.org>; Wed, 19 Jan 2022 07:31:10 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id c24so11421897edy.4
        for <git@vger.kernel.org>; Wed, 19 Jan 2022 07:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=x4vfMNZ4FWZIfmsst23pH2dxrMSq3+vbpGNgaW17Qy0=;
        b=CHO0uQt5T2bOSeQK0VI7xMjw4ZePgi3nKteGGynGZ/NDiArJ9sf79zI8mD/g1LlDUP
         p14ZgJjkFLc79aKq4QJdnwOHj4FmTK9ixUmZsw1v4apgzzMECUpEubu5sV9iVRMmMpmb
         7pcB0igipWYg5JrFk5qcDc66WphDJL6j7M6m3gk0Dkl1Jrk4eP6cz4UkahJ6/ptPChgm
         KnDF9CJsr76nyB0k/C1tzpcQB8YBxSXRqoEwwWASsLjAh/F0mYjp9EwhK0T3FCjiirAD
         cVRDajxNqQsuq/zKY3shp+qiSP82eaAThlsExmU8fkwBKZRo68etTCpURYVA7/XTN9W2
         6hXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=x4vfMNZ4FWZIfmsst23pH2dxrMSq3+vbpGNgaW17Qy0=;
        b=RhN5kP2FruCISoXv/ozVKxapky+RirXtI8Gp7VcTpbpa2wCuTFP8bsv1c8y2hoz+iP
         3m/vlsrQIW3Jw7SPLQ1eR2FY7kRdMkClyKi4KdtvToH5S8iVqVgjvR5aP6SlYvPyF8IN
         pO1DlH5BrMqF+pvYsHJ21Y3dKRNcPi+ap97GPNWnOrsAVQa64QrSxUKYN+R3lUxbffF/
         Za8GJaj/+ioc+f+c11LXn4M4zh0RXtSePcxfd6HdJi5GAe3ENRMS0l128ycY2qz0KGcx
         DzeAqc5xWgxtErK19uvoEV8cJKkPTQHZ5z2QvMLkGtxL2Rr03XG9UmYIJDIIzA0orCIj
         BWgg==
X-Gm-Message-State: AOAM530cAeLtcrw3L/+bnPpF8YE6cwUct5vD5JEMpzI0qFvNqzxE/jNR
        tKquwh8UBf4jTxLTkg5mWljFuNps2MKJrg==
X-Google-Smtp-Source: ABdhPJxtjIlVoIPNX829QL2GuDyM+DCe4h4duqwBd3mJ6vdINwVy67Klhme5N5pI50dn72IpyYpd5A==
X-Received: by 2002:a17:907:160f:: with SMTP id hb15mr24573025ejc.166.1642606268497;
        Wed, 19 Jan 2022 07:31:08 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id i6sm38108edf.20.2022.01.19.07.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 07:31:07 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nACvT-001nG0-Cr;
        Wed, 19 Jan 2022 16:31:07 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Neeraj Singh <nksingh85@gmail.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Neeraj Singh <neerajsi@microsoft.com>
Subject: Re: [PATCH v2 2/3] core.fsync: introduce granular fsync control
Date:   Wed, 19 Jan 2022 16:28:04 +0100
References: <pull.1093.git.1638588503.gitgitgadget@gmail.com>
        <pull.1093.v2.git.1638845211.gitgitgadget@gmail.com>
        <ff80a94bf9add8a6fabcd5146e5177edf5e35e49.1638845211.git.gitgitgadget@gmail.com>
        <211207.86wnkgo9fv.gmgdl@evledraar.gmail.com>
        <CANQDOdfX2KaosPwLM4hS4rp+FH9V7VUxUh_md43FfZ9NG4iroQ@mail.gmail.com>
        <211208.86ee6nmme5.gmgdl@evledraar.gmail.com>
        <CANQDOddkKbUC-g97JOf40nS28Yv1KACvbjW9gtQZemfBMutPCw@mail.gmail.com>
        <211209.86bl1ql718.gmgdl@evledraar.gmail.com>
        <CANQDOdchh3mfC8S6ouWAQbtWzZUkmTzF1p5D9dg4muoBu4N1Fg@mail.gmail.com>
        <CANQDOdf97WK7kWZHM7xr_fMS1aep5hYYcwC2Pfr_7w4h_8ybfw@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <CANQDOdf97WK7kWZHM7xr_fMS1aep5hYYcwC2Pfr_7w4h_8ybfw@mail.gmail.com>
Message-ID: <220119.86y23bn3no.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jan 18 2022, Neeraj Singh wrote:

> Hi =C3=86var,
> Could you please respond to the parent message?

I did just now in
https://lore.kernel.org/git/220119.8635ljoidt.gmgdl@evledraar.gmail.com/;
sorry about the delay. This thread fell off my radar.

> To summarize the main points and questions:
> 1) The current patch series design of core.fsync favors ease of
> modification of the complete configuration as a single atomic config
> step, at the cost of making it somewhat harder to derive a new
> configuration from an existing one. See [1] where this facility is
> used.
>
> 2) Is there any existing configuration that uses the multi-value
> schema you proposed? The diff.wsErrorHighlight setting is actually
> comma-separated.

I replied to that. To add a bit to that the comma-delimited thing isn't
any sort of a "blocker" or whatever in my mind.

I just wanted to point out that you could get the same with multi-value
with some better integration, and we might have our cake & eat it too.

But at the end of the day if you disagree you're doing the work, and
that's ultimately bikeshedding of the config interface. I'm fine with it
either way.

> 3) Is there any system you can point at or any support in the POSIX
> spec for requiring fsync for anything other than durability of data
> across system crash?

Some examples in the linked...

> 4) I think string_list_split_in_place is not valid for splitting a
> comma-separated list in the config code, since the value coming from
> the configset code is in some global data structure that might be used
> again. It seems like we could have subtle problems down the line if we
> mutate it.

Replied to that too, hope it's all useful. Thanks again for working on
this, it's really nice to have someone move the state of data integrity
in git forward.

> [1] https://github.com/neerajsi-msft/git/commit/7e9749a7e94d26c8878945958=
8997329c5130792#diff-ee0307657f5a76b723c8973db0dbd5a2ca62e14b02711b897418b3=
5d78fc6023R1327

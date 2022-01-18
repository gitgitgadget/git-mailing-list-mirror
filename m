Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E76AC433F5
	for <git@archiver.kernel.org>; Tue, 18 Jan 2022 23:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346581AbiARXuh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 18:50:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233354AbiARXug (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 18:50:36 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58610C061574
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 15:50:36 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id o12so1796704lfu.12
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 15:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FalQWDcElN6BA414L+e1nS2wj1kMhnIHaX8RMH8TB8Q=;
        b=Ew5+6m+xrcrA9eOjql8PdlMtJSds/h12SxmzVGr8yUkNXRiCWsjxGadr8Pj6ZgitQK
         UG7IyjCJuMNE4BfGUAcviggiinjoaWvroJyHwU+3b2sFNlAcdgAaD3HeuxDyYp72Aek/
         Kk9xZIA/hodQG/pGXGnB0bx7Yesx3hYGbdopxMtyiohTgez46giPwK9ejcgxVKt1Dr3b
         eCT7ugtcI1yoN67zvdSRRemtfYEn3WZnqeRpkudX4OgINJcsisJ/MiadHmdRBKPrHogL
         GcjVw7BYAgmSM3AxjdF0kHJe9Yye2/8wOu74Smnt1GBTyT66cuG/fwJ1k72NfPfT7kMY
         4u2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FalQWDcElN6BA414L+e1nS2wj1kMhnIHaX8RMH8TB8Q=;
        b=NWdY5OeA+ECKFwaoVUDpWDXPgGNJsE9xo4Dz7s2qsmd7R9j/N7p/LNVmQmk0THCQWO
         H1n6BbVZde5/OGT2IKkDgjYPHTsvzeQbLvoFlpwWOSxFmsOd7lfNF4pYg5j1J6q/AS6T
         j43ki1FcBPRTS5qewt6EKxS2Blxgr7WWZEc7BbPB1cfOHpbeL7+DAPw8VbxfVO0FKsFw
         l4mkr8aD8Fsdod7L5cI2Xret0ZWtCdALJ+4UKRCKf2D2kaI8AOj0VKAKJVpTSLNCZJKP
         V2jUMokVe029aYhjsq9Qnkup9fEm4ZmWvTC94Riu6XZYJup9IzcG4QumsBj6BOga56Zp
         8KTQ==
X-Gm-Message-State: AOAM531OhSPrKdpNQyAqeHE22ftULPrvXn6JgzPg+c7mHOUuhGlhRDgN
        OxS8k6oBIAj4MfNjcGODlfl2CNo9eJd6yEpJZoE=
X-Google-Smtp-Source: ABdhPJy0f43sl6wHcd4QNtSxi70b8lEYcmUMyUlqVmF7oxtO2EjsL4rgH5KfKcb1RnWL8Hu6ji3O8Dcj1g4gZIH34dk=
X-Received: by 2002:a2e:1658:: with SMTP id 24mr2220192ljw.131.1642549834677;
 Tue, 18 Jan 2022 15:50:34 -0800 (PST)
MIME-Version: 1.0
References: <pull.1093.git.1638588503.gitgitgadget@gmail.com>
 <pull.1093.v2.git.1638845211.gitgitgadget@gmail.com> <ff80a94bf9add8a6fabcd5146e5177edf5e35e49.1638845211.git.gitgitgadget@gmail.com>
 <211207.86wnkgo9fv.gmgdl@evledraar.gmail.com> <CANQDOdfX2KaosPwLM4hS4rp+FH9V7VUxUh_md43FfZ9NG4iroQ@mail.gmail.com>
 <211208.86ee6nmme5.gmgdl@evledraar.gmail.com> <CANQDOddkKbUC-g97JOf40nS28Yv1KACvbjW9gtQZemfBMutPCw@mail.gmail.com>
 <211209.86bl1ql718.gmgdl@evledraar.gmail.com> <CANQDOdchh3mfC8S6ouWAQbtWzZUkmTzF1p5D9dg4muoBu4N1Fg@mail.gmail.com>
In-Reply-To: <CANQDOdchh3mfC8S6ouWAQbtWzZUkmTzF1p5D9dg4muoBu4N1Fg@mail.gmail.com>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Tue, 18 Jan 2022 15:50:23 -0800
Message-ID: <CANQDOdf97WK7kWZHM7xr_fMS1aep5hYYcwC2Pfr_7w4h_8ybfw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] core.fsync: introduce granular fsync control
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Neeraj Singh <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi =C3=86var,
Could you please respond to the parent message?
To summarize the main points and questions:
1) The current patch series design of core.fsync favors ease of
modification of the complete configuration as a single atomic config
step, at the cost of making it somewhat harder to derive a new
configuration from an existing one. See [1] where this facility is
used.

2) Is there any existing configuration that uses the multi-value
schema you proposed? The diff.wsErrorHighlight setting is actually
comma-separated.

3) Is there any system you can point at or any support in the POSIX
spec for requiring fsync for anything other than durability of data
across system crash?

4) I think string_list_split_in_place is not valid for splitting a
comma-separated list in the config code, since the value coming from
the configset code is in some global data structure that might be used
again. It seems like we could have subtle problems down the line if we
mutate it.

[1] https://github.com/neerajsi-msft/git/commit/7e9749a7e94d26c887894595889=
97329c5130792#diff-ee0307657f5a76b723c8973db0dbd5a2ca62e14b02711b897418b35d=
78fc6023R1327

Thanks,
Neeraj

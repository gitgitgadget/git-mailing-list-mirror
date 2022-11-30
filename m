Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB705C4167B
	for <git@archiver.kernel.org>; Wed, 30 Nov 2022 00:52:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbiK3AwB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Nov 2022 19:52:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232037AbiK3Av7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2022 19:51:59 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BF571F22
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 16:51:56 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id 7so19688261ybp.13
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 16:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OdV+Q1z1cjWxcima2Jut4CusdXT/73AXyM8wkN/7PA0=;
        b=AS7l+ZlQerskhYB6KGLGVf/YlXXzwwiK1YkEUXl0bOXnHD6ne6LMLGufwUmqYXZZRx
         06zapPv2bNETfiug7Yt6cv6cYQgZCc3QFE0XbDzfQwB8AK6uaA+RWR2m/iwoM3+R0nbT
         MZgICY0zyUOTFqxAJHReJPgmmqYQioWgs0wRTe6zu700YEAqTMCDYLIwEYo4M4En+Znq
         12C2DFJxa8dt23a62yw3bmffRTP/AAXBvyvLcOC04erh5KDL8WfXtvasp/ecJXmyvYxs
         kACYIA+kzbBbONIsHQNCd/OOlpHFh51hAAQy9HWfxpwC2NzL15w7DkiHGepGq49e7d7x
         Cq1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OdV+Q1z1cjWxcima2Jut4CusdXT/73AXyM8wkN/7PA0=;
        b=boMHSEbqq1i5WvJDzD5kmjBGEFed2mrgbN1xwP9ar6KK95NhqzXrSJjwwvPMz7IAcZ
         XPOfkdpMJ3ZFZCr+IxFGurYq8IyUegm0j6N+ILyu5lfTuZLZAzjc5/4sAk8CBByZU8wD
         Forv7HCfLAi8DcvbswYdaOKtFX6iQu4vrUV81P65WdOHnlFMSSbb9fakuk7m3dRrg2f8
         p3JGlbILVPP+605eANH9Rtm+LwQEBjC4GAZBvdbxdQFJgNb6AGueJ7/z7CYQO6WDYvnd
         21/LtcElY1x4+keo4s18sqxjTfgkhEf155T7i4xkphBlsVPIsxJ/0JXdVbDu8zVnwG3S
         zDrQ==
X-Gm-Message-State: ANoB5pnk9S1bLR/B7tvXbS+4jq28XSA2OeB9/p6Q+r8df3ALvlo6EG4q
        k4JV8/MiUig56jg3woRhDzwZZzQpjlpBT9LFlwC/trtV7IQ=
X-Google-Smtp-Source: AA0mqf4cSEdA+h1ADm+CNhL4IO9kmrsiqPej6oDnzavyhA6duyMP0l1LeNWnjOJAUd/DtQHY+k14RR7z9JJvFg6mB1A=
X-Received: by 2002:a25:da50:0:b0:6f4:3d4b:73c3 with SMTP id
 n77-20020a25da50000000b006f43d4b73c3mr19242920ybf.316.1669769496909; Tue, 29
 Nov 2022 16:51:36 -0800 (PST)
MIME-Version: 1.0
References: <pull.1384.v7.git.1669136378754.gitgitgadget@gmail.com>
 <pull.1384.v8.git.1669154823035.gitgitgadget@gmail.com> <xmqq5yf3fx4s.fsf@gitster.g>
 <CANaDLW+ukK2GU7NzkCvXVNc9DX3_93Pp+PHq-WcLpRJizPidVA@mail.gmail.com>
In-Reply-To: <CANaDLW+ukK2GU7NzkCvXVNc9DX3_93Pp+PHq-WcLpRJizPidVA@mail.gmail.com>
From:   Rudy Rigot <rudy.rigot@gmail.com>
Date:   Tue, 29 Nov 2022 18:51:25 -0600
Message-ID: <CANaDLW+Zuwpk_7jTO5LmWTXDT8LRPPcGARkNtaV6ORioWyZ0tg@mail.gmail.com>
Subject: Re: [PATCH v8] status: modernize git-status "slow untracked files" advice
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Rudy Rigot via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alright, I tried the "status.enumerateUntrackedDelayMS" approach, but
I couldn't pull it off and now I am stumped.


This is somewhat frustrating, so I'd welcome guidance if anyone has
time and is interested. Since this doesn't actually work, I don't
think I should create an actual patch for it on the mailing list, so
here are two other ways to show what I've got, I hope they're
acceptable:

- in Gist form:
https://gist.github.com/rudyrigot/aa3e8e5ddb4f71fdc7fc0e92d9b7a4b8
- in GitHub compare form:
https://github.com/git/git/compare/master...rudyrigot:git:status_enumerateUntrackedDelayMS

The issues I'm seeing:

- No matter how I set the config from the test, it doesn't seem to
have any effect. I'm thinking I might be doing something wrong in how
I set the value, which I've done in git_status_config in
builtin/commit.c, which very well may be the wrong place.
- Therefore, I've been testing things by changing the default value in
wt_status_prepare in wt-status.c. Setting it at 0 and making the
operator <= instead of < makes the advice display, which tells me that
the logic is sound. Setting at its intended value of 2000 doesn't
display the advice message, as expected. But setting it at -1 also
doesn't display it. I'm a bit puzzled about why that would be, and I'm
wondering: maybe the int is unsigned? It doesn't look like it based on
how the structure field is declared in wt-status.h, but I know my own
limits in C so I could be wrong.


Now, I'm also well aware that Junio raised that advice leaving the
door wide open to not actually solve this as part of this patch; and I
did express in my previous reply that I am not intuitively convinced
there is much value to it for users, although I could be wrong of
course. So with that, if it's better to let it go, that is fine by me
too.

With that in mind, I implemented the alternative that Junio was
proposing instead (assigning the value of `s->untracked_in_ms`), and
it seems to work all good. It just passed CI, so I'm about to submit
that as a patch, with every other piece of feedback also addressed.


Unrelated note: I noticed that the first 2 bits of feedback applied to
docs that were part of past patches, but were removed in the last
patch. The rest of the doc feedback was current, so I was able to
implement them, but obviously I couldn't implement the first 2 ones,
since the issues they're about are gone.

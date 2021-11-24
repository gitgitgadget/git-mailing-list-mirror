Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B0BC433FE
	for <git@archiver.kernel.org>; Wed, 24 Nov 2021 01:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233351AbhKXBWZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 20:22:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233183AbhKXBWX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 20:22:23 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58FFBC061574
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 17:19:14 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id l25so2652329eda.11
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 17:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=9tg68rrNxZ2e6fO48ostyAxfQBmJdZlqq95lEgcjM2U=;
        b=g8QPHLCIKVnVHrRHJ1wBgfaEbV4UqysoNBTfsyiCJCNIOQKDzkFnJjY17fXHV+o/Ov
         l+qiymkGBu+g7iD++TML/zu8fSnOWGPoGeJDESSTJ3QApZJIV4pDo4yiOWPjIiLI99fO
         ++5Otc16jNJNrnFFigeuxmhL1NIeMSdJXBNm5ji826ZyyWyvENA8ovX+suZsGrgoAeTB
         MsYHJ1LT2J1OSLWO0d6y4i0yemxV/5Elw5j3RQ9OaoSJAclgtP4RC8Mo3HHlEEELuTB4
         5+4bpbwRCG7mO5Ly8eUGOpS/55Upp+7GWr+n4lC+Ezfpn4QMYlDBN3/5q180f1EKPtyt
         iGHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=9tg68rrNxZ2e6fO48ostyAxfQBmJdZlqq95lEgcjM2U=;
        b=SZcwuJQyiTBm5HeXgU9R0TI77uCGW4YCjtdTSter9Var1pLP5QoqEwxqDt2yKiRIy+
         JszM4hCl2a0wGFzxzDUg0d7aULbduyJ+vf9xS4JCIkURJ8aB+zn6LhqHP9VOUphdfDB/
         rgPZA4T/zWvxQAJPWGKZlTnbD2DTjuZNG9UEViJzaMM/3GNavMqT/chkS/uL1rVLBnBc
         DqpO7P826P8fT1FfapRtGiSv/RtR2mbo/XfexJeuhAaWxd41zkPv2m1oojoL4DnFeOiU
         HndLY4/iRMapZX5ehBiXMxnCH4deHygFVdPd2Lr7MU0VO863ySIvdTXvgFVeMZTEVFmW
         f19g==
X-Gm-Message-State: AOAM530AXpZZ3ItpyeJ7fA5sjnrixf/jAdjBqSs0gd8ruenFOuv8XY3J
        z3SmTQTeoOr94KHJCKyVI2fVlPuJPQbZrQ==
X-Google-Smtp-Source: ABdhPJwBf8tUMDzkzH0Dh5vdruA8SH9LGCkeCmuYlOxC1/zPUoJYoZBTJhUzOa1DsxfUjJC4zlx9Qw==
X-Received: by 2002:a17:906:c112:: with SMTP id do18mr14538927ejc.103.1637716752870;
        Tue, 23 Nov 2021 17:19:12 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id e7sm6896525edk.3.2021.11.23.17.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 17:19:12 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mpgwJ-0007GQ-0u;
        Wed, 24 Nov 2021 02:19:11 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Glen Choo <chooglen@google.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 8/8] dir: avoid removing the current working directory
Date:   Wed, 24 Nov 2021 02:10:04 +0100
References: <a5528cbb14ddbbf26cde873e3f3e95744d59b950.1637455620.git.gitgitgadget@gmail.com>
        <20211123003958.3978-1-chooglen@google.com>
        <CABPp-BE0Bcimwr1wwcnnh+6apx7r114Oqnu=QDgKEn6VAHAtFg@mail.gmail.com>
        <kl6lmtluka55.fsf@chooglen-macbookpro.roam.corp.google.com>
        <CABPp-BGr9PDTE0q5zev4Ffx19g+hG083zdNShoSdH47VqzT8mw@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <CABPp-BGr9PDTE0q5zev4Ffx19g+hG083zdNShoSdH47VqzT8mw@mail.gmail.com>
Message-ID: <211124.86ee76e4fl.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 23 2021, Elijah Newren wrote:

> On Tue, Nov 23, 2021 at 10:19 AM Glen Choo <chooglen@google.com> wrote:
>>
>> Elijah Newren <newren@gmail.com> writes:
>> [...]
>> I'm not going to say that we'll *definitely* need remove_path()
>> in its current form, but mixing concerns like this is an invitation to
>> unexpected behavior. An (imperfect) example that demonstrates this
>> principle is https://lore.kernel.org/git/24bffdab139435173712101aaf72f7277298c99d.1632497954.git.gitgitgadget@gmail.com/,
>> where we made a change to a generic path matching function in order to
>> speed up unpack_trees(), but accidentally ended up breaking gitignore.
>
> There's no mixture of concerns; my patch is correcting this library
> function to more fully match its documented intent; from dir.h:
>
>     /* tries to remove the path with empty directories along it,
> ignores ENOENT */
>     int remove_path(const char *path);
>
> Since the parent process's current working directory is still likely
> parked in that directory, there is a good reason to treat it as
> non-empty.  Thus the cwd should not be one of those directories
> removed along with the specified path.  No need to die, just stop
> removing the leading directories once it hits the cwd (much like it'd
> stop once it hit a directory that had files left in it).

I can buy that we'd pick this new behavior as a worthwhile trade-off,
but not that anyone intended for this to be the behavior all along.

I don't think "a process is sitting in it" has ever been anyone's idea
of a "non-empty directory". Rather it's what rmdir() returning EEXIST or
ENOTEMPTY maps to.

Doesn't this series also change the behavior of e.g.:

    cd contrib/subtree
    git rm -r ../subtree

If so then re the "spidey sense" comment I had earlier: There's no rm
codepaths or tests changed by this series, so the implementation of
doing it at this lower level might be casting too wide a net. Wouldn't
e.g. changing callers that use "remove_dir_recursively()" to use a
"remove_dir_recursively_not_cwd()" (or whatever) be a gentler way of
introducing this, and make sure that each step of the way we grok what's
being changed, that there's test coverage etc.

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03395C76196
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 21:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjC1VYq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 17:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjC1VYp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 17:24:45 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64681999
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 14:24:42 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d2-20020a170902cec200b001a1e8390831so8254192plg.5
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 14:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680038682;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=l9Jd7kTyuQDwCjSd5cMF/DvRh2yYzkYJazavLZaD/S8=;
        b=QGCWdx0LsneGc8YDdUnzgC/ICtQEOdB9WI3VoM78JNpHJ/aEvoDq3qshAJfV3QRm9q
         HEvXf4NMwCWZkCLj0+Ay3HByfaEspNSAnByYA5ZRRS4COKmdQIHVfEK5ncjqEWMcDlNv
         w6xuqul47r/NTR77d3ROYaexnw8DIn5i6jhvr9ULVU5Ddh2+eCKRlDw4kSPqcYD93lm5
         04r5EZ21qVP07B/R04WMNTD/f2J0HNRsRdp6pOxyEQ+KQlxrQEUsIpHCQO13L0WYragw
         1gH9okEFi4ASjqI1WSA67EyvU1I0xvpAYhFsgnJEVpBX0JyZwnTlKcRhQsiD/eZSZbSQ
         7jmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680038682;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l9Jd7kTyuQDwCjSd5cMF/DvRh2yYzkYJazavLZaD/S8=;
        b=gLqVUgo/JGy6eQps1jA6MSxV6uo9smB0oNvzqtou50M4i7zxYnk1NUODW+ZG1/3zMY
         lrfS/GmIK44lBiW1fcCvoSnZ04f3ULw5Cwalr1Y9z8uX7uTs9FBoW5oTpy4YEobu1/Uv
         XiAKQiLVsrGb54X6jediJJKXX2OEAKhRJAAdpwWxkmmYxk16UgQJBxoRbJlk49bzzcd1
         1HicWEK2rKIPDHL3FNt/JAllbWYxurcgVmrbnQaFfunhkCvTryGyCk54d+22zhAMfPlS
         blYum5pb7Fv4IcjY2WstECtDjfOwjM+3LDpUeL5SdFTQiqWOJYMS3MahHiRPHKz2dY+u
         E0NQ==
X-Gm-Message-State: AAQBX9dmGCjO22YFNA7hCTsbu1YGsDWTqi7kvFUqAssX0+WxEibk64jb
        3T6pDAvCansSPuNq3QFMl6j9HJDpzKOOpQ==
X-Google-Smtp-Source: AKy350YZHuWrBU98e0bF9Mx0Hqi1wBg4vRz6x5TMtY/27fFHsBF6gTm8cwzSatzmZa649mj4zl0LDBYhm8UPWw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:23d3:b0:62a:424b:2af0 with SMTP
 id g19-20020a056a0023d300b0062a424b2af0mr8310935pfc.0.1680038682450; Tue, 28
 Mar 2023 14:24:42 -0700 (PDT)
Date:   Tue, 28 Mar 2023 14:24:33 -0700
In-Reply-To: <xmqqsfdoeiqu.fsf@gitster.g>
Mime-Version: 1.0
References: <pull.1463.v2.git.git.1678925506.gitgitgadget@gmail.com>
 <pull.1463.v3.git.git.1680025914.gitgitgadget@gmail.com> <kl6llejgdacq.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqqsfdoeiqu.fsf@gitster.g>
Message-ID: <kl6lilekd0xa.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v3 0/8] config.c: use struct for config reading state
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Emily Shaffer <nasamuffin@google.com>,
        Calvin Wan <calvinwan@google.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Glen Choo <chooglen@google.com> writes:
>
>> "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>>> Note to Junio: 8/8 (which renames "cs" -> "set") conflicts with
>>> ab/config-multi-and-nonbool. I previously said that I'd rebase this, but
>>> presumably a remerge-diff is more ergonomic + flexible (let me know if I'm
>>> mistaken), so I'll send a remerge-diff in a reply (I don't trust GGG not to
>>> mangle the patch :/).
>
> A patch that is indented by two places would not be mechanically
> applicable anyway and even without such indentation, the hunk-side
> markers like c000d91638, gitster/ab/config-multi-and-nonbool, etc.
> you have in the patch would be different from conflicts I would see,
> so it wouldn't be very useful.  There should probably be a mode
> where remerge-diff would omit these labels to help mechanical
> application of such a "patch".

Ah, bummer :(

I was thinking about that as well. remerge-diff actually outputs
left and right in "--format=reference", which I then manually modified
to reflect the conflicted version in the working tree, giving the final
result here. I wonder what remerge-diff or "git apply" could do instead.

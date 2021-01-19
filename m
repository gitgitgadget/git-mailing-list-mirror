Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC5F1C432C3
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 18:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A9D023132
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 18:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389612AbhASQpT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 11:45:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389356AbhASQpD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 11:45:03 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966CCC061573
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 08:44:23 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id bx12so8308347edb.8
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 08:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
         :date:mime-version;
        bh=JWRE+u0MRvr+ZnUx2o25tLdg5Kd12+/a687fij1+tUo=;
        b=RepCMgbn0DDEpv2UxnTv3ucL/F2P8mpiLyxQtbaSqOqRiBN0Qir3KcecwYpmg6WZf8
         GqdPS5JKhB+vXKPi6muBHHPivA+vhtlPjJccV5kofqYq90VP2J80qL2V+7r6G3Nb7CeT
         UMDQpb5MjJq8A03rC6a0mUpvoShSmW9R/Qxq8uDC1jOPLLvszCanJJ+TOPNaIfvnYyaT
         xdc2qpJm3ou+wADNoEv/dZstIIV/zw3TEYINI3yVK/G/E9zirvixhATiA7cghprUIwBi
         RIazyguVc7lHajkX7Xgkb7nHFWz7QuZcsbllVRdOfyd+d/i2wWwjocVm2jRgAiNRcd/P
         giUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=JWRE+u0MRvr+ZnUx2o25tLdg5Kd12+/a687fij1+tUo=;
        b=ev5LrPzWXTJ9rin9TMKnvEZEvmCwZzGzch1cfnhmMxr3UlLgQ7rso+TeQdHV3DEnIf
         3sUA6XqXRnMKyaikwnya/nUqLX50k51moh0sKi+fbRFro94/IYuMScSg6Uz/IvaCEmOb
         UZsXcQZmbJqtaWTvMluJeTQaFzCHjpKecrkNKRiWWlCpiM8DMlHzXWB9vuh2gaw7AQil
         0F4e2I/8aMwDVUp2zBrTT0Jm6UI7A8WW8kTT2Ban2/4yNJ3L5gZ4MntL38pHX8zADHTU
         8afAzTOZKj6xLoCp5NSUJ/+E1rXzEtNhMQGjBtJAWBAp3XBKIg9MnxcUDh/tLC5xU5ZH
         ArHw==
X-Gm-Message-State: AOAM533xfx0toQ2AE2RafeaZRCbrKHMyu9dp2Msfgo+T5LbdvhXdDPhB
        Ecn7qieVWV57sGSVu2cxl1/3Neje9MY=
X-Google-Smtp-Source: ABdhPJxMNZfAKD0ZXeFIajieNCPcEham2sHNKZCHuHhIHEuPzh6PDLuHaElRmAELr3EO2qvTKurUAg==
X-Received: by 2002:aa7:ccc6:: with SMTP id y6mr4061580edt.226.1611074662275;
        Tue, 19 Jan 2021 08:44:22 -0800 (PST)
Received: from cpm12071.local ([212.86.35.161])
        by smtp.gmail.com with ESMTPSA id gb14sm10628315ejc.61.2021.01.19.08.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 08:44:21 -0800 (PST)
References: <20210104162128.95281-1-rafaeloliveira.cs@gmail.com>
 <20210117234244.95106-1-rafaeloliveira.cs@gmail.com>
 <CAPig+cTGxOwUN20JmeR0bBwVMM78eA3Bnaqei5GEAs2XFM2_gg@mail.gmail.com>
User-agent: mu4e 1.4.13; emacs 27.1
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 0/6] teach `worktree list` verbose mode and prunable
 annotations
In-reply-to: <CAPig+cTGxOwUN20JmeR0bBwVMM78eA3Bnaqei5GEAs2XFM2_gg@mail.gmail.com>
Message-ID: <gohp6klfco6fmk.fsf@gmail.com>
Date:   Tue, 19 Jan 2021 17:44:20 +0100
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Eric Sunshine writes:

> On Sun, Jan 17, 2021 at 6:43 PM Rafael Silva
> <rafaeloliveira.cs@gmail.com> wrote:
>> This patch series addresses some of these changes by teaching
>> `worktree list` to show "prunable" annotation, adding verbose mode and
>> extending the --porcelain format with prunable and locked annotation as
>> follow up from [1]. Additionally, it addresses one shortcoming for porcelain
>> format to escape any newline characters (LF or CRLF) for the lock reason
>> to prevent breaking the format that is mentioned in [4] and [1] during the
>> review cycle.
>
> Thanks for continuing to work on this. I'm pleased to see these
> enhancements coming together so nicely.
>
>> The patch series is organizes as:
>
> The new organization is a nice improvement over v1.
>
> As mentioned in my review of [5/6], there may be some value in
> swapping [5/6] and [6/6] to make it easier for readers to digest the
> changes, but it's not a hard requirement.
>
> To avoid being mysterious, there's also a change in [5/6] which
> probably belongs in [3/6], as explained in my review of [5/6].
>
> My review of patch [4/6] suggests optionally splitting out a bug fix
> into its own patch, but that's a very minor issue. Use your best
> judgment whether or not to do so.
>
>> 4. The fourth patch adds the "locked" attribute for the porcelain format
>>    in order to make both default and --porcelain format consistent.
>
> This patch does need a re-roll, and it's entirely my fault. In my
> review of the previous round, I said that if the lock reason contained
> special characters, we'd want to escape those characters and quote the
> string, but then I gave you a code suggestion which did the opposite
> of that. My [4/6] review goes into more detail.
>

I kindly disagree and I actually think is my fault :).

> Aside from the one important fix in [4/6], and the possible minor
> re-organizations suggested above, all my other review comments were
> very minor and probably subjective, thus nothing to sweat over.
>
> Nicely done.
>
> [1]: https://lore.kernel.org/git/CAPig+cSH6PKt8YvDJhMBvzvePYLqbf70uVV8TERoMj+kfxJRHQ@mail.gmail.com/

Thank you for reviewing this series and all the helpful suggestions. I
will send another revision taking all of them into account.

--
Thanks
Rafael

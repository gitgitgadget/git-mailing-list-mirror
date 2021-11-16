Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26225C433F5
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 04:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E72B761C12
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 04:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239833AbhKPEpH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 23:45:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238487AbhKPEow (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 23:44:52 -0500
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E24C2248EC
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 17:44:06 -0800 (PST)
Received: by mail-vk1-xa33.google.com with SMTP id s17so3182285vka.5
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 17:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bHjeWRkj74ZG6YNRiWcUS0JCM7jNsbQf/htrHI4UpOs=;
        b=YZNPQlMkbYnvTxe0ViKa9Q0q9R+ykuLUFufkiwWwGt7VGIrXCnIiBCeuq9U23l1Jkb
         N72GMAyMw0gFZy+Z1QfQOVsDdAtBIiA5j6T+cV+DLO3nixA47zEK4X/zH5DzIAtecS9X
         qzJRxu2KF16Lyq2Bj+/DMAtVSyNAA0RtYwkHc+cBURbhkWj5wfWgSi65FvxuEADoYTin
         SOTX+mX6HEoxla8kHBmn3uQhstHUaxs9NAPgA1qHIA5an8tH6JY9JtqMIps1571JHF+D
         urmyQwC6xxHWT/kI9+4u/8F6ITV0u+mq7bHm4P+evXE8dJfsSgufDIWNm0c+cWgQaQ3x
         uycw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bHjeWRkj74ZG6YNRiWcUS0JCM7jNsbQf/htrHI4UpOs=;
        b=k0wuJMnXvuFTwfoT0/75Q9+whdj20OkB2k7vzwMkjTFu0ZubD55O9REE4mtot0wbYy
         dB+5s75TzXf9JJvrCSFyebrFM2GFW8j4ouuVTWdd+C1QioTB2Skkq7Nm9Fm0v7/IOp/1
         RJYY7Dn/8K39AN0rnaxmgLFIGmg/o/0Fzb6cw1br15MROB/CR2rP/Q33wXdjYhWgHLks
         5Vz7ON1MkthvLXKeX07P67wiJd+mgOblRFiYRy5s24yNMtVhnd1ZiCHk1CC+Q9j9Z7Xa
         DfNmFwOmnVBhmGDuvtps+7ViLzLESQdwZescREsyMFgvGYBU16So2XwOA0nmwN3JoWdU
         72MA==
X-Gm-Message-State: AOAM5313to3hVUlD4sxhe3qE8yOmTwjxN7NyM4EIJO6zCKL75P/9ru9X
        QFLzZOeE1bgaIkyDt32o0ky/dJ8yet+8/d2CynPrs86f
X-Google-Smtp-Source: ABdhPJwVsIoJvSvs6/51SwckktVaq2ALgzALRsGKOJsN8BeaULXaPq566c/fytkLe4wcQ+Rkc7Nld+2UXG/SijPZiJU=
X-Received: by 2002:a05:6122:130d:: with SMTP id e13mr66918466vkp.6.1637027045566;
 Mon, 15 Nov 2021 17:44:05 -0800 (PST)
MIME-Version: 1.0
References: <CADL96rvRX2R_4Wm23tz88hDUztcpK531RU+Ops2UVoiOW0bCHw@mail.gmail.com>
 <xmqqfsrxdufe.fsf@gitster.g> <CADL96rsnUCXchnrTa1rZ7WgJz2kDA-3TzeOiCy4AXNFdXtTmng@mail.gmail.com>
In-Reply-To: <CADL96rsnUCXchnrTa1rZ7WgJz2kDA-3TzeOiCy4AXNFdXtTmng@mail.gmail.com>
From:   Erwin Villejo <erwinvillejo@gmail.com>
Date:   Tue, 16 Nov 2021 08:43:54 +0700
Message-ID: <CADL96rt0ye6KkkoZqzBCgnZyRxRhQSYktkrdP3DtAj8uEZFwMw@mail.gmail.com>
Subject: Re: git pull bug report
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Please check PR: https://github.com/gitgitgadget/git/pull/1078

Thanks.


On Tue, Nov 16, 2021 at 7:23 AM Erwin Villejo <erwinvillejo@gmail.com> wrote:
>
> 361cb523 fixes only the --ff-only case.
>
> It's still broken for unspecified/unset fast-forward flag and config (pull.ff and pull.rebase).
>
> Br, Erwin
>
>
> On Tue, Nov 16, 2021, 3:40 AM Junio C Hamano, <gitster@pobox.com> wrote:
>>
>> Erwin Villejo <erwinvillejo@gmail.com> writes:
>>
>> > $ git pull
>> > hint: You have divergent branches and need to specify how to reconcile them.
>> > ...
>> > hint: invocation.
>> > fatal: Need to specify how to reconcile divergent branches.
>> > ```
>> >
>> >> What's different between what you expected and what actually happened?
>> > I expected no failure and no-op since local is ahead of upstream.
>> > Instead, `git pull`
>> > fails because it thinks the branches have diverged.
>>
>> I think this was fixed at 361cb523 (pull: --ff-only should make it a
>> noop when already-up-to-date, 2021-10-20); it was broken between Git
>> 2.33 and Git 2.33.1, IIRC.
>>
>> Thanks.

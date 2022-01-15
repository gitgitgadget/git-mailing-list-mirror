Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F75C433EF
	for <git@archiver.kernel.org>; Sat, 15 Jan 2022 16:45:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbiAOQpl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Jan 2022 11:45:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiAOQpk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Jan 2022 11:45:40 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A1FC061574
        for <git@vger.kernel.org>; Sat, 15 Jan 2022 08:45:40 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id u21so46314939edd.5
        for <git@vger.kernel.org>; Sat, 15 Jan 2022 08:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TAmeMryMys8vmO2QM/VFKsDXJyNzwGSQ4lgGho3Dozg=;
        b=hQtWgf/9jiwQVfui2EFSg4uRVtLO5ujwfe/ZneQPwHW3Lk+uZZWdXZwOY5S2Dc3mO6
         DCdNdB7rgLTwV8DOj9jkamc+PWUlJy4pyA9AiLaXbt0Y7VNPDURW4Vq0StjBDAC8Ocrl
         cvRaEdsDrpzNAaLdRr0LJH5tWuRuL+03opVrl34jBbSn97vZOpwIvd1vD0VVgUY3GyCD
         uA8cqb77zgbAU9iXLR6jt/QSO2SFXilzy/alKNC8WYmng1eh6ENuVpTpm3vRyNOP5bRz
         4ZLraNtdj2kuwocE+jjCzPIzYnOy0dc0gxQ6TZhupxhElLliql0k5lYHqPLF7vruLj86
         Bw8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TAmeMryMys8vmO2QM/VFKsDXJyNzwGSQ4lgGho3Dozg=;
        b=ByEFF347r5v6jSdDXtbpHfFeDUsnpsv6O+s9oMGj/eCymWcvcQQVNt0wMqtQE569m4
         HD/kp3i5RfwQj9srpjeQ6qHWAWzFTWwV58TC5/GAXgEOFcr9GBnZPV0OohRDNiDTxTDv
         otfONWIDk1DaT2t+3lqxweDN9GjwFzQZh03shUSF4RO8n7VdG0ACrJ766NAXjs66/Zsa
         2zPNwf2nBpoEIK1nNurzgERUA9NIHivl/HE5NXt0DkS55N7NiEVu5zpntJfOe6OGXeVb
         /CG0kEVmwTjgl1TttnokqHmT9Rp6ctEkbiRF+mYswxAxUCRxVzl6be7KhCuy8HOY0uXS
         d41A==
X-Gm-Message-State: AOAM532bmAE5d89nAFxTShJG58ORR/2Tp9LzH96F5m82z+Eo5GF4/Of+
        FgOjHexO+rqQ/+m9JBVwpRzz3uEzS07t3NyiRjEzT5C8
X-Google-Smtp-Source: ABdhPJyPyNWw0fvttE3YYTx5LiDsWzpaepLZqJjyLwRYHUutpAlmCypf1wUYpSYTm6ZfJfsdViBD4g/l7vmRK/vaj/k=
X-Received: by 2002:a17:906:1f51:: with SMTP id d17mr11113655ejk.759.1642265138555;
 Sat, 15 Jan 2022 08:45:38 -0800 (PST)
MIME-Version: 1.0
References: <xmqq35lrf8g4.fsf@gitster.g>
In-Reply-To: <xmqq35lrf8g4.fsf@gitster.g>
From:   David Aguilar <davvid@gmail.com>
Date:   Sat, 15 Jan 2022 08:45:02 -0800
Message-ID: <CAJDDKr7bYP7JNmY7XML0rkxv8uCKAbO-LdAAn0KkyTq3UX4hkg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jan 2022, #03; Thu, 13)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 14, 2022 at 7:16 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> There are a few "oops, what we merged recently is broken" topics
> that still are not in 'master', but otherwise what we have should
> be pretty much what we'll have in the final one.
>
>  - I am reasonably happy with ab/refs-errno-cleanup (just one patch)
>    that fixes the incorrect state of the code left by the earlier
>    parts of the topic that have already been merged during this
>    cycle.
>
>  - I am also OK with ab/reftable-build-fixes (two patches), one for
>    general type correctness fix, the other for helping older sub-C99
>    compilers.

I ran into the c99 test balloon. I get the (expected?) c99 build
errors and an uncompress2 build error with RHEL7.9's stock gcc 4.8.5.

Are we dropping support for RHEL7.9?

Using NO_UNCOMPRESS2=YesPlease and CFLAGS += -std=c99 in config.mak
works but I'm not sure if we actually expect users to deal with those
details themselves.

Sorry for being out of the loop on the plan for older toolchains, but
I wasn't sure if we should be expecting a patch that configures the
default flags so that things build out of the box again or if this is
considered the new status quo and we're okay regressing?

$ rpm -q zlib-devel
zlib-devel-1.2.7-19.el7_9.x86_64

$ gcc -v
...
gcc version 4.8.5 20150623 (Red Hat 4.8.5-44) (GCC)

Was part of the intention of the test balloon to get reports of this
nature? I checked the commit logs and related discussion but that
didn't really clarify things.

It seems like that was the intention based on the note of, "any
warnings will eventually surface." in the commit message for
5f46385309 (config.mak.dev: specify -std=gnu99 for gcc/clang, 2021-12-08).

I'll keep an eye out for any patches that I should test in this area.

cheers,
--
David

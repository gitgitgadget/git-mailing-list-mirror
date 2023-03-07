Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC625C678D5
	for <git@archiver.kernel.org>; Tue,  7 Mar 2023 10:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjCGKCe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Mar 2023 05:02:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjCGKCc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2023 05:02:32 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DD03A856
        for <git@vger.kernel.org>; Tue,  7 Mar 2023 02:02:31 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id i9so16342066lfc.6
        for <git@vger.kernel.org>; Tue, 07 Mar 2023 02:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678183349;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aeQVIxt+SWc2v4UNacHeXDcmTdW+RxRKXCMpKM+YDf4=;
        b=QH8OwYm/1MQxg6CTUutg5zLnvFx1qjTnl3A9yeK0fpeO9hlFNvoLKFvxgG4xdmRrVS
         zOarwhn3xmEOXaNqN2nd7djSI9deF4Vzs5FEX8ZV+5YrhZJg+Xjm5H7Wtf6nN15Zy5SZ
         FH4bD3K6snJ2ZsuiAHgoeqer+6HH7NsA0bWIv3ARfOUdpp4A/J/FU+oIXsifcdYKKXw2
         +GF06y2SCrRKgm9pBltySr5/NKFtlFYKeOJL+ZxX12caYTdHQfXZY8O7TJDrSsCyL/Ju
         yxBaQNoFEKxjPz92iobHFvbdf48/TKGLxCTR6U36fSMHKd5fIV/2jIfe5Mpa0O/nu0gM
         r3wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678183349;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aeQVIxt+SWc2v4UNacHeXDcmTdW+RxRKXCMpKM+YDf4=;
        b=4TWz2N0gF5yiWPhTvTBC9BVQFNNjoiBFqh8ctu5+b7aS8Sgp0dG6mkSK+sy66EJv4w
         wVE1LzpWCuUmQzBOWxTVzQoAi4K7wdYTzXmIYMIVPd5MqDkGkpmv6B3fJ4GnlJ2JQvz4
         t1Lxz8pnUJFtsSQUUun/ZjboLVA0dLAH/8O8yVvPS9aCVf5jBfUhD1CqD7kJoeAIxjZY
         AUl708zKw8cHEJVdVsYeV8T12n7A9XlG5G+yqQyWrAdLMLI8sbC5MOvKztKFNcLWoCAc
         1hfiLqIrcIdRKK6F5HYxPdNnCRp8TIyM1XMbDcQtTTVGWePSiZB4MFD7vsNSVjoLMg3+
         vUfQ==
X-Gm-Message-State: AO0yUKUkhn0tbZzw5gSILtqLCM60mj2BAJch4K3C5GpMopNan3zofXaz
        m8REPOOVRf6mRdiRYX5hBm1/v0frF2E=
X-Google-Smtp-Source: AK7set/Ce0kZO3pv6mH623QtVshlo83nQWALdqBKnBU2v92GWbrWsvYWTDYXWws8eXtGpuzjq55ECQ==
X-Received: by 2002:a19:7002:0:b0:4b4:e4a1:2fc6 with SMTP id h2-20020a197002000000b004b4e4a12fc6mr3384207lfc.68.1678183349210;
        Tue, 07 Mar 2023 02:02:29 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id i19-20020ac25233000000b004d5a6dcb94fsm1961158lfl.33.2023.03.07.02.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 02:02:28 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: so/diff-merges-more (was Re: What's cooking in git.git (Feb
 2023, #01; Thu, 2))
References: <xmqqr0v7o0pp.fsf@gitster.g> <871qn5pyez.fsf@osv.gnss.ru>
        <kl6lr0v2i0gn.fsf@chooglen-macbookpro.roam.corp.google.com>
        <87wn4tej2f.fsf@osv.gnss.ru>
        <kl6lh6v43s4g.fsf@chooglen-macbookpro.roam.corp.google.com>
        <xmqqr0u7ku3j.fsf@gitster.g> <87wn3zqefx.fsf@osv.gnss.ru>
        <kl6lzg8pcygl.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Tue, 07 Mar 2023 13:02:27 +0300
In-Reply-To: <kl6lzg8pcygl.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Mon, 06 Mar 2023 14:22:02 -0800")
Message-ID: <878rg8j2vg.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>>> but I have been under the impression that the remainder were OK
>>> clean-ups.  Perhaps it is mostly because I read them so long ago and
>>> forgot the details X-<.
>>
>> It's not a cleanup, it's rather adding missed feature that allows to get
>> precise '-m' behavior with --diff-merges.
>> ...
>> However, by making such decision we lost ability to provide exact
>> behavior of -m using --diff-merges= set of options. This has been
>> pointed out later to me in the list, and felt obliged to finish
>> implementation by providing the feature.
>>
>>   --diff-merges=hide
>>
>> is exactly that.
>
> This is exactly the "immortaliz[ing] a mistake" that I mentioned
> upthread, by turning a UX wart (-m doesn't imply -p) that neither of us
> likes into a feature. I'd be in favor of getting rid of the wart
> altogether (i.e. let's find a path that lets us make -m imply -p in the
> future), but not rebranding it as a feature.

We are walking in rounds here. Let me try to find at least some common
ground. Could we try to agree on *one* of these 2 mutually exclusive
statements, please:

1. Current -m behavior is useful

2. Current -m behavior is useless

To me it looks like Junio thinks 1 is the case, and you, Glen, think
it's 2 that is the case, and you both somewhat oppose to my patch
series, believing you agree with each other, that in fact does not seem
to be the case from my POV, effectively leaving me no way to adopt the
series so that they are actually accepted.

Thanks,
-- Sergey Organov


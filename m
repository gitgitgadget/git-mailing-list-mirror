Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B19EC6FD1D
	for <git@archiver.kernel.org>; Sat, 18 Mar 2023 00:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjCRAI0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Mar 2023 20:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjCRAIZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2023 20:08:25 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4BFD779A6
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 17:08:22 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id i5so7011287pla.2
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 17:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679098102;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=/0uUg6AVpxCsnI9Ng5vuTDvjyUwDK1VKAag4Ab7WAhw=;
        b=MYdOcS/C9xmsTGPWTJqgk6p2sCl3g/ZCGqiDPOzPPM/tb/OPTHTy3BUZx8FsG3LGe7
         3vFw520O46xJkVl+UJnPSgCz9IX7q13AzXw9s9fsyHq3zn3WlY+ETtGMmvlorQloOGRt
         Acem/39gdUkYpGGj4eD1Nb7PMeaqX5sa6rWxpMoggMVkmggICsVrp61BM95ZUW37H9vY
         fvaERcEFaX1UJ1qerBrfFqfBXZJGRcvzWe6q/mn9liyvvmMhkm9Xi8ZlKQ4NWgZCeWIw
         8F9hQZ74b80/X2Q5mhwWT5uUeFS1asMIiws6KmSVff1pDLjG7SjbIUis7G271rC0uKnx
         2Ayw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679098102;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/0uUg6AVpxCsnI9Ng5vuTDvjyUwDK1VKAag4Ab7WAhw=;
        b=Fw1SOJ/W1h7AGG9tXzeuORerJ8Y7PQ0/ePCFeK0vJDWz22EGX6Ba/+Z3vE0Y+kUvFY
         gzI/ziQ+5qyPRuCcrLFJX2ub45Qc8C0hZlBecgV0zh/6EAXqZYvpHRZlM+NfCTsDtMPO
         TQt92vUQHRrzpBCkixFerrTv8980r2N5Ojsh3oMyc/OjfHcZRbH1CYHc8yri6GRKiNHo
         DR7wREDVJ6pp6R79JiZv0BmKhqgyFUbbBhpD0OwSltqJiTq8b+4b7AhtgYH7V50m+FbG
         fF2yBbqUqlaJ/Jovn5qqNcYS+kcV6uasCT2lrjAUnMWU+am8wTfaCiUaFijBz6PUdj7q
         amkA==
X-Gm-Message-State: AO0yUKV7igH8pCdjIG1CvHPG2rYLQjEv7g6eo0T9HqBYab2aarq4I713
        WCho0e4/N1cRjeCiEVsORJMcwtJ41Ts=
X-Google-Smtp-Source: AK7set9iESqDxV0qqZSXw+sSCYIlAK8PPSy3hWpIVzdwTmRXv62CzkJI5SRg4HOX4IOdXRmg3xS7Hw==
X-Received: by 2002:a05:6a20:7a04:b0:d5:5b78:685c with SMTP id t4-20020a056a207a0400b000d55b78685cmr7775730pzh.49.1679098102178;
        Fri, 17 Mar 2023 17:08:22 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id e4-20020aa78244000000b00625544bb33csm2075515pfn.81.2023.03.17.17.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 17:08:21 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Glen Choo <chooglen@google.com>, git@vger.kernel.org
Subject: Re: so/diff-merges-more (was Re: What's cooking in git.git (Feb
 2023, #01; Thu, 2))
References: <xmqqr0v7o0pp.fsf@gitster.g> <871qn5pyez.fsf@osv.gnss.ru>
        <kl6lr0v2i0gn.fsf@chooglen-macbookpro.roam.corp.google.com>
        <87wn4tej2f.fsf@osv.gnss.ru>
        <kl6lh6v43s4g.fsf@chooglen-macbookpro.roam.corp.google.com>
        <xmqqr0u7ku3j.fsf@gitster.g> <87wn3zqefx.fsf@osv.gnss.ru>
        <kl6lzg8pcygl.fsf@chooglen-macbookpro.roam.corp.google.com>
        <878rg8j2vg.fsf@osv.gnss.ru> <xmqqzg8ozbuh.fsf@gitster.g>
        <87jzzqzy20.fsf@osv.gnss.ru> <xmqqzg8mrgc8.fsf@gitster.g>
        <874jquxc67.fsf@osv.gnss.ru>
        <kl6lh6uthlc3.fsf@chooglen-macbookpro.roam.corp.google.com>
        <878rg5vgvc.fsf@osv.gnss.ru> <xmqqjzzo46tv.fsf@gitster.g>
        <874jqj31gv.fsf@osv.gnss.ru>
Date:   Fri, 17 Mar 2023 17:08:21 -0700
Message-ID: <xmqq8rfugbuy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

>> I do not quite understand the last one (#4),
>
> Well, -m does not imply -p, whereas the rest of diff-merges options
> (-c/--cc/--remerge-diff) do imply -p. This is what half of this
> lengthy discussion was about.
>
>> own 4., it would be that introducing --diff-merges={kind} may have
>> been a mistake.  It would have been fine and better to just let
>> users choose from whatever set of options we support, i.e. (-c,
>> --cc, --remerge-diff, -m -p, -m --raw, ...).

> It's fine with me that --cc is everything you need, but what I need is
> rather diff to the first parent, ...

I think "show --first-parent" should give that already.  One problem
with "-m implies -p" is that it is unclear what should be done to
things like "-m --raw".  Yes, we can declare an arbitrary choice
(like "-m implies -p unless --raw, --stat, etc. are given") but that
is just replacing an arbitrary rule (i.e. "comparison with parents
are not given for merges, unless things like --cc, --first-parent,
etc. that are specifically designed for showing merges are given;
you can give -m to force pairwise behaviour.") with another one.




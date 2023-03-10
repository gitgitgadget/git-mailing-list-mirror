Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E32C6FA99
	for <git@archiver.kernel.org>; Fri, 10 Mar 2023 21:19:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbjCJVTX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Mar 2023 16:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbjCJVTT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2023 16:19:19 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CD812970D
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 13:19:15 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id n66-20020a634045000000b004e8c27fa528so1597966pga.17
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 13:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678483155;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1CEcXzQ6yDontDVGm5KWeSbZ+nVzv6hCvSaRLDZ4HCk=;
        b=gQfLiQ8mLjPTQuKaE4Fqw/JIaaKu4spBcmRtLXxSMRYy+cGu6Q+nMh49Ktxs6LrNfd
         oYWuz4ZM/gLEGSuG3JiAQZmNwB8uufp/oE1nYi2wXaB2StrsUUkV2hAYDn/DtRrO4OMI
         QA0yVcpEDKeBnUS4NGM8jc8yhjxH/DdAytMTWZDf7P3ttrZtDsNSDW0Pplv11pU5rZZy
         ZaND4jFEFuNCgeu0NVhuSH5Tlc+7Ps/s2dVc44ZND3UxWXVAuj3DNLx7OH+JhJvmmal1
         rIdkWP+Q8TuTzSOPc+t4eZj4OpGAc0RTCgz+1lLNcsJqMXvS4fS7TzpkQaeReNWNEVMa
         Yz1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678483155;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1CEcXzQ6yDontDVGm5KWeSbZ+nVzv6hCvSaRLDZ4HCk=;
        b=luuzLb6+MbxEjjMwENvE0ITyeANyKyYZTE2tDu5thEAslA7uBR5/nCXvAJKgRpQ12m
         C/cVe4BTErWXgP5VCzhuLGuIcrRVi2evn/jvhyvF+uHMaredkrUDNgAGY3qjfHgsruzK
         3n9qbgRG/wUszOpxfySVJOmVmCpERO/Hps7bGRrZV21whILSr31u1AzIsVl0qB8V74qu
         4QLcbu+KpBwiushMfwBu1DY3OY64oD09VkhRwq86Y6fr1KFUYynDHO6ys+KEf1wJ/wt3
         PxpgdjQyLHIMpNqaRf0/kmfQLw+eAMK4DSNRUVbo8psWPkIZpOdYztLRqNLHAHM5+RAN
         jgFw==
X-Gm-Message-State: AO0yUKUB0c5YLXPvr8q5jWqEI4r1NugpXemHYiyEP38Iln/dwv0WEHg4
        EnCeJMWLZBP0fATfsII6gUR6EmoO+BTNwQ==
X-Google-Smtp-Source: AK7set8C8viHKR3DAFejJGdyeswdoGvJNR7obh6Ua7/lNP5z1uAFYEC8yA1iKNIm5dXBwaTZlYlcYA9vuR+B5w==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a63:3c52:0:b0:502:f4c6:3992 with SMTP id
 i18-20020a633c52000000b00502f4c63992mr9756368pgn.4.1678483154905; Fri, 10 Mar
 2023 13:19:14 -0800 (PST)
Date:   Fri, 10 Mar 2023 13:19:06 -0800
In-Reply-To: <878rg5vgvc.fsf@osv.gnss.ru>
Mime-Version: 1.0
References: <xmqqr0v7o0pp.fsf@gitster.g> <871qn5pyez.fsf@osv.gnss.ru>
 <kl6lr0v2i0gn.fsf@chooglen-macbookpro.roam.corp.google.com>
 <87wn4tej2f.fsf@osv.gnss.ru> <kl6lh6v43s4g.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqqr0u7ku3j.fsf@gitster.g> <87wn3zqefx.fsf@osv.gnss.ru> <kl6lzg8pcygl.fsf@chooglen-macbookpro.roam.corp.google.com>
 <878rg8j2vg.fsf@osv.gnss.ru> <xmqqzg8ozbuh.fsf@gitster.g> <87jzzqzy20.fsf@osv.gnss.ru>
 <xmqqzg8mrgc8.fsf@gitster.g> <874jquxc67.fsf@osv.gnss.ru> <kl6lh6uthlc3.fsf@chooglen-macbookpro.roam.corp.google.com>
 <878rg5vgvc.fsf@osv.gnss.ru>
Message-ID: <kl6la60kqp85.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: so/diff-merges-more (was Re: What's cooking in git.git (Feb 2023,
 #01; Thu, 2))
From:   Glen Choo <chooglen@google.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> Glen Choo <chooglen@google.com> writes:
>
>> Sergey Organov <sorganov@gmail.com> writes:
>>
>>> I already agreed long ago that to be on the safe side we shouldn't
>>> simply change -m nowadays, and addressed that concern by putting -m
>>> behavior change under configuration option in the current series. So
>>> what's the reason of rejection?
>>
>> Before we start talking in circles again, I think the responses
>> elsewhere in the thread still accurately capture mine and Junio's
>> views, e.g.:
>>
>>   https://lore.kernel.org/git/xmqqedr28wwb.fsf@gitster.g
>> https://lore.kernel.org/git/kl6lr0v2i0gn.fsf@chooglen-macbookpro.roam.corp.google.com/
>
> There were no any response from you to my recent very direct question
> (that Junio did somewhat address), but what I figured from your and
> Junio explanation so far looks like:

Yes, thank you for summarizing the discussion. I think the following
sums up my position quite accurately, and I found this very helpful.

> 1. The fact that -m does not imply -p is a mistake. There is no any
>    reasons this exact behavior could be useful. As such, it does not
>    make sense to support this exact behavior in --diff-merges. So the
>    reject of --diff-merges=[no-]hide.

Yes.

> 2. This mistake is too dangerous to fix due to subtle compatibility
>    problems, so we can't just fix -m behavior. Thus the reject of my
>    earlier patch "let -m imply -p".

Yes, unfortunately. If we didn't have compatibility problems, "-m imply
-p" would be very good IMO. I am not that hopeful, but perhaps there are
ways to get users to move off this compatibility problem. It would be
something we would have to learn as a project though, it is not a
problem unique to this series.

> 3. Moving behavior change under option is not worth it, as nobody
>    presumably needs this fixed -m behavior anyway (at least among 2
>    persons that are actually opposing the changes). So the reject
>    of "add diffMerges-m-imply-p configuration option" patch.

Yes, given how specific the option is (I think it would be the only
config option that exists to change the behavior of a CLI option) I
don't think the option is worth it in light of alternatives like a new
"-d" flag or supporting "-mp".

> 4. Staring in the face inconsistency between -m and the rest
>    of short diff-merge options is not significant enough to reconsider
>    any of the above rejects.

Yes. Git carries many such inconsistencies.

> Did I outline your positions correctly and to the full extent? Anything
> else I forgot?

I cannot think of anything else. Thank you.

> I want to make sure I got it exactly right, as I'd still like to tweak
> my proposals, and I'd like to avoid the troubles I got into as much as
> possible.

Thanks. I hope that there is a good way forward for your proposals.

>
> Thanks,
> -- Sergey Organov

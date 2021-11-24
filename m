Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B43C433F5
	for <git@archiver.kernel.org>; Wed, 24 Nov 2021 00:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbhKXAnG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 19:43:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbhKXAnF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 19:43:05 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7817FC061574
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 16:39:56 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id m20-20020a63ed54000000b003213f4670c0so126972pgk.2
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 16:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=11gklu2XHSbYLHAmqH1Plb04zCbHlAAdWYLXyrNCYeU=;
        b=DVpWkNrGj58yH8Gngcd3CbCa4ocFQJIv6UN1Mdzkgm5TutYPeJKLtRmDUwoLMaWHZA
         r/wM5us5fLFyBt1ujxYA2yiZ69+evN/KYM/bJ2pE2msfyIAmEArll9O98A0nyhmVK4rY
         9ori2PxeFXzr8k2Q4mivevhAyle9m5mcP+hB8nT5KCIlxtCy/PkcWV0JAnQBf+Zggq8K
         qmRNcQMs90TcKcKSBK4Ok7wH5BAu2CrnWmbc0aDjtA720A1jCyt1GYujBnqtwAvoAsU9
         gjOMV12t6nb052rN/yNupj/I0la6dg7nGto0PKYcsPwLkRk24RAgGwluGYdOphooD7Na
         lCxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=11gklu2XHSbYLHAmqH1Plb04zCbHlAAdWYLXyrNCYeU=;
        b=oFvWWKd7d5msQ9TCf07EqwEqNthvVcdWZ5zCfrt57zkmHAqXM6fhRNsSxOkyE6oANp
         F6hZjOdN9NdbgRb9FPfEYgGDryVDUpIQY6bkjw+J5KmoihXCceBxr6zEuX6apAktXLUi
         uOsEvw93lswKWjAB6e1YQtwU26YurO6q6zbFEdzImBenXYBIU4Qq43xSC65FMiluhRdG
         vsZ+ahyxBTRy7S/RXhwYmlm6WR4HYqyjWIOS2+XoM4S6FbGriifMMR/+EpvYOQvKo3wa
         wa2SGzLL4YtJy2nDe0g9YzuwAXRZuIJDNV2KDIV0JFkQpJ2fujRUcGGQ4jDPTyFk5FZU
         DfQw==
X-Gm-Message-State: AOAM531mIZbMMPevENuPJ9+9MZ/eijR336KM5MeapnKbsHkorQ9T1ASv
        PQEm9bicrC+oJ1I3NfqMlsBKfnYqoAAL+g==
X-Google-Smtp-Source: ABdhPJy85Ie6zB+xssZLKB0mXgxBatdB4CHEzujdsWdpzwVUogtmptp6ysv4iZnqk+eNQ2gUEdzCyKz0c2eczg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:2296:b0:49f:feb4:6457 with SMTP
 id f22-20020a056a00229600b0049ffeb46457mr1725824pfe.58.1637714395937; Tue, 23
 Nov 2021 16:39:55 -0800 (PST)
Date:   Tue, 23 Nov 2021 16:39:53 -0800
In-Reply-To: <CABPp-BHn0bE4ZSx25+28GD58sae=FVs63eQW-Fp8zwFAALcKFA@mail.gmail.com>
Message-Id: <kl6ltug2tmhy.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <a5528cbb14ddbbf26cde873e3f3e95744d59b950.1637455620.git.gitgitgadget@gmail.com>
 <20211123003958.3978-1-chooglen@google.com> <CABPp-BE0Bcimwr1wwcnnh+6apx7r114Oqnu=QDgKEn6VAHAtFg@mail.gmail.com>
 <kl6lmtluka55.fsf@chooglen-macbookpro.roam.corp.google.com>
 <CABPp-BGr9PDTE0q5zev4Ffx19g+hG083zdNShoSdH47VqzT8mw@mail.gmail.com>
 <kl6lzgputxxw.fsf@chooglen-macbookpro.roam.corp.google.com> <CABPp-BHn0bE4ZSx25+28GD58sae=FVs63eQW-Fp8zwFAALcKFA@mail.gmail.com>
Subject: Re: [PATCH 8/8] dir: avoid removing the current working directory
From:   Glen Choo <chooglen@google.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> >> I agree that most, possibly all, of our commands should prefer to die
>> >> than to remove the cwd, but that doesn't justify adding
>> >> application-level concerns to a general-purpose utility function. Even
>> >> if it sounds overly defensive, having an obviously correct utility
>> >> function makes it easier for future authors to know exactly what their
>> >> code is doing and why. And surely if we're imaginative enough, we can
>> >> definitely dream up some possible use cases for remove_path() that don't
>> >> want this dying behavior e.g. other applications that link to our
>> >> libraries, or some new merge strategy that may need to remove + restore
>> >> the cwd.
>> >
>> > Sounds like your objections here are based on a misunderstanding.  I
>> > totally agree with you that adding dying behavior to these functions
>> > would be wrong.
>> >
>> > My patch doesn't do that.
>>
>> Ah my mistake, that should be s/die/'stop gently'. Even so, that is not
>> at the core of my objection, mixing of concerns is.
>
> If I were to introduce a new function, say remove_path_not_cwd(), to
> avoid this claimed mixing of concerns, what would that buy us?
> I've looked at every single caller of remove_path() in the git
> codebase.  If I did introduce a new function, as you seem to want, my
> series would include two more commits: one that would replace _every_
> call of remove_path() in the codebase with a call to the new function,
> and one that would delete the remove_path() declaration and definition
> in dir.[ch] since they would be unused.

There is at least one other possible outcome, which is that
remove_path() is replaced with remove_path_not_cwd() in all callers that
obviously want it e.g. builtins, but not replaced in other callers. My
mental model of this is that the two functions serve two different use
cases:

1) remove_path(): Remove a path and all empty directories
2) remove_path_not_cwd(): Remove a path and all empty directories,
   except cwd

> I haven't yet found or heard of any potential callers, even
> hypothetical, that would be harmed by the modified behavior.  Every
> case suggested so far actually sounds like a good candidate for the
> modified behavior.

I trust that you have considered this change carefully, so I will
downgrade my objection to a nitpick. remove_path() seems nice to have as
a low-level function but I certainly can't imagine any non-contrived
use cases that *wouldn't* benefit.

To me, a more compelling argument is that protecting cwd is important
in order to ensure correctness, and user experience is an incidental
benefit. AFAICT that is not the argument you are making, but perhaps
there is some correctness benefit as well?


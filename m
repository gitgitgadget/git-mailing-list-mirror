Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8139C4332F
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 22:21:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbiJKWVb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Oct 2022 18:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiJKWVJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2022 18:21:09 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48EAD131
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 15:21:00 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id y15-20020aa78f2f000000b00562674456afso7845638pfr.9
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 15:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=q3d1elOaMZhvFLJ9Thf5XcvRFPAii8ZC8N2jedIpw68=;
        b=Dp9kxj8EBCpYEwgZ27owVHWBjNbzrX/rUI4HnKdOOsIo66ZFLNgigZUmTOh8we9aol
         aEGKio6oMTkMNTv7awj0wKy9zkrYuBvZ9cMgdjRWqPM0E22EVBymA+B4/NPjdK1Hvs+I
         R6syYdNkk4lS0LOpWOINDNVklypCnV9WOp8Lj5KJD7XM98pYp/lcsHmcNCgDBbIrbliz
         CFyj3i4zE0fObDqMCYDCkv+wSGaJdxSGUz1kTB6ZLdXTOamBAd1LBMT0NK4Y/70+co8l
         6xMezsBlBqXonbj9aIEp+p7V8h1Cw4Wux3dxCWAMYTxIWt3hR6dscJh2fvUiu65MOJ6M
         tK+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q3d1elOaMZhvFLJ9Thf5XcvRFPAii8ZC8N2jedIpw68=;
        b=mC3G2p36W2HfhxV12pOgwya+5rgzspgcrZOZveAyqIxrlVYJOgJDKduDzuyUP36GOk
         7W7VcA8QrMjxPOQtvQIWLJqXmZePTYzo/eU+Vb20b0gb5t8NYLEwIvjS6VXI9y8B2vWG
         PwSD8YIK5U6ZG5zgn97GRWEVy8rlRiFLHtbEKR2LkbCjIyK6716+Asvp/qj3kVWP8p6U
         zZCP4NLzHEkecDU9BEbvy2vZZ0MWBiwOo+Ceamc/rYPZImlXWkeLVOVmuPYW0LZ4P4CA
         4PFDjqHzDkI2t3GzsKW1GG7LAYaW3EJuI1GDllWj8ntwYesgoB1Op2Kos7flnyB0hU65
         OYiA==
X-Gm-Message-State: ACrzQf3vqfneGZPcrWcE1MsKNuKThpp3H1KRROQuxpbp1A6qbZbBo18F
        jxpN+Txv5MKXLm2eOTw6MzjWOB83wNIS0A==
X-Google-Smtp-Source: AMsMyM7Lg0biey9VOKJIdwVcLVQdXmquFvBuRToo/7TG8Lp4+8dz6epdP03juxZZUQZV53jlO7CqlTAWGgsvJg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a63:4426:0:b0:464:4e1d:80e3 with SMTP id
 r38-20020a634426000000b004644e1d80e3mr5225881pga.106.1665526834451; Tue, 11
 Oct 2022 15:20:34 -0700 (PDT)
Date:   Tue, 11 Oct 2022 15:20:32 -0700
In-Reply-To: <CA+P7+xq3NGGTq2U2Di9ZTBO3buqeEMb2smC=v78V9Subt2cDMw@mail.gmail.com>
Mime-Version: 1.0
References: <CA+P7+xrnAXceHJbBYV8Z9Ay9xbkzpiX3P0wXLwN7jfnifW2OBQ@mail.gmail.com>
 <kl6lzgeblap2.fsf@chooglen-macbookpro.roam.corp.google.com> <CA+P7+xq3NGGTq2U2Di9ZTBO3buqeEMb2smC=v78V9Subt2cDMw@mail.gmail.com>
Message-ID: <kl6lilkq0zpr.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: issue with submodules using origin remote unexpectadly
From:   Glen Choo <chooglen@google.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

> On Tue, Oct 4, 2022 at 11:12 AM Glen Choo <chooglen@google.com> wrote:
>>
>> Hi Jacob! Thanks for the report!
>>
>
> Thanks for responding!

:) 

>> Or, if you could include a reproduction script, that would be really
>> helpful :)
>>
>
> I'm not sure how to do this, because it is only an intermittent
> failure. I suspect it has to do with when the submodule actually needs
> to update.
>
> Perhaps I can come up with something though. If I can, I'll send it as
> a new test.

That would be greatly appreciated, thanks!

If you find code pointers useful,

- builtin/submodule--helper.c:fetch_in_submodule() contains the logic
  for fetching during "git submodule update"

- submodule.c:fetch_submodules() contains the logic for fetching during
  "git fetch --recurse-submodules" (which is invoked by "git pull
  --recurse-submodules").


>> >
>> > remote: Enumerating objects: 210, done.
>> > remote: Counting objects: 100% (207/207), done.
>> > remote: Compressing objects: 100% (54/54), done.
>> > remote: Total 210 (delta 123), reused 197 (delta 119), pack-reused 3
>> > Receiving objects: 100% (210/210), 107.20 KiB | 4.29 MiB/s, done.
>> > Resolving deltas: 100% (123/123), completed with 48 local objects.
>> > From <redacted>
>> > ...
>> > Fetching submodule submodule
>> > From <redacted>
>> >    85e0da7533d9..80cc886f1187  <redacted>
>> > Fetching submodule submodule2
>> > fatal: 'origin' does not appear to be a git repository
>> > fatal: Could not read from remote repository.
>> >
>> > Please make sure you have the correct access rights
>> > and the repository exists.
>> > Errors during submodule fetch:
>> >         submodule2
>>
>> I assume this is `git fetch` running in the superproject?
>>
>
> Its git pull --rebase, but I suppose as part of this it will run
> something equivalent to git fetch?

Unfortunately, this doesn't narrow it down much because "git pull
--recurse-submodules" runs _both_ "git fetch --recurse-submodules" _and_
"git submodule update [--rebase]" ;) Without more context, it's not
clear which of those is failing.

>> When fetching with `git fetch`, submodules are fetched without
>> specifying the remote name, which means Git guesses which remote you
>> want to fetch from, which is documented at
>> https://git-scm.com/docs/git-fetch. I believe (I haven't reread this
>> very closely) this is, in order:
>>
>> - The remote of your branch, i.e. the value of the config value
>>   `branch.<name>.remote`
>
> So basically if its checked out to a branch it will fetch from the
> remote of that branch, but...
>
>> - origin
>>
>
> It defaults to origin, so if you have the usual "checked out as a
> detached head" style of submodule, it can't find the remote branch.

Yes, this sounds about right. I was quite certain that we only default
to "origin", but I observe that "git fetch" doesn't fail if there is
only one remote and it is not named "origin". Perhaps I'm mistaken, or I
simply couldn't track down that logic.

>> But... I'll mention another wrinkle for completeness' sake (though I
>> don't think it applies to you). If you fetch using `git submodule
>> update`, the submodule is fetched using a _named_ remote, specifically:
>>
>> - If the superproject has a branch checked out, it uses the name of the
>>   superproject branch's remote.
>
> Right, so that explains why I can re-run git submodule update after a
> git pull --rebase and it works.
>
> In theory wouldn't it make more sense to use the remote based on the
> URL of the .gitmodules file?

Ah, yes that's one possibility we (the folks working on an improved
Submodules UX) have considered. Another would be to teach submodules to
actually use branches correctly and to use the remotes of the branches.

In general, the project tries not to respect config coming directly from
.gitmodules (c.f. [1]), but I agree that there's a lot of room for
improvement.

[1] https://lore.kernel.org/git/xmqq35bze3rr.fsf@gitster.g

>> - If the superproject does not have a branch checked out, it uses
>>   "origin".
>>
>
> I suppose one option would be to make this configurable. I started
> using "upstream" as the default remote name for most of my
> repositories when I began working with forks a lot more.

My hope is that the work I mentioned earlier makes this code obsolete
and nobody ever has to configure this ;)

>
>> >
>> > Thanks,
>> > Jake

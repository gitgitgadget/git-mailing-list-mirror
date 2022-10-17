Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE6B1C4332F
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 16:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiJQQ7Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 12:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiJQQ7O (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 12:59:14 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F225FF73
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 09:59:14 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id p16so9584557iod.6
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 09:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1tlPSaO8reEdl/h+SmI+KXy+xfGGGqwzRLRIf4M+SVk=;
        b=DepUTd9uleQbEQLtiH06YI+hAeUGYHE3o2cD2QC+mIkuUODlhjnuTr/phU2Kd/3yXr
         ZyXc12ygGt4Fof9NOlU5glFHc8U4XBLRK9csMkfJmC/pdOK9KbjPwxY/J5jmJuAyxj+G
         CScVJZMIhY2+YAq13Fbk7ZN3isNHQWr8YOf91ZbX4UUAc24058x//CN8H6XpyncKhtyX
         8GfOqZivkg8inc4jkGu84QFEaYSoBypmfrYzl7mRGFucKxkyW/zti1273/Ie+i7Vsu/a
         JGalDjkLGHzYPXM6MbsY9m5Mq31G5xQ2w3s1hyxNDGFsTxb227arHVXGYRSypeLDnquT
         vRAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1tlPSaO8reEdl/h+SmI+KXy+xfGGGqwzRLRIf4M+SVk=;
        b=tzor/wZg6L3OLysq58QrriHkk8W+XQmmVaoixy0H703p1yDVImuwsQ8zp34c0296S8
         B3nFovHAqx2FXMGZdQgDdKqJiEr5Hq1pNj7Xi++MbdBoNa2seNNTJiPjp2Itqzikx/dQ
         DRLiuUnFAvJsqwMKvv5L9WbCvKH95vWJ9ZYUlVgSjWS1vzZAWvTLdWrV4zGQdAP+ckFa
         VQPTzTZ79JW+Oe7ldfNeUhM32AjP0fB/RdeT7IIbbDhrIx0rFjJPBmkTpM0xjnqQm5U6
         ZHFAkmUIHOF8rirBqKuj/GjLn0chJIPiuJYJl/HcZysSaRvOonsB/9g6FVCu8gkrporL
         O0IQ==
X-Gm-Message-State: ACrzQf3A1PXKJxYY8xDa11vphh+3mWZOa7f5Elq/j1mGecni0ZgkQMjE
        6YGbvAOnsKvEhib4jo6BIDoI9xbUY0OXKK5stVHFe6LO
X-Google-Smtp-Source: AMsMyM7b5KBw5SgAX/rRwY+P6cIFFIZeOT69VGdGS1Vy0iqw7gMB+Uk4kaa+BdTuR7AYADHNKGeUVMH2rnJq0zhVjj8=
X-Received: by 2002:a02:cabb:0:b0:363:5b16:c871 with SMTP id
 e27-20020a02cabb000000b003635b16c871mr6004851jap.6.1666025953260; Mon, 17 Oct
 2022 09:59:13 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1384.git.1665839050813.gitgitgadget@gmail.com> <087d3fca-d01e-f36a-85f5-7e861e4d11ca@jeffhostetler.com>
In-Reply-To: <087d3fca-d01e-f36a-85f5-7e861e4d11ca@jeffhostetler.com>
From:   Rudy Rigot <rudy.rigot@gmail.com>
Date:   Mon, 17 Oct 2022 11:59:02 -0500
Message-ID: <CANaDLWKcF07=FQgT7ZTKmcgworH45YdNy8hy2faMBg3CGYEf+w@mail.gmail.com>
Subject: Re: [PATCH] fsmonitor: long status advice adapted to the fsmonitor
 use case
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Rudy Rigot via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> We should be careful here, FSMonitor only helps with untracked
files if the untracked cache (UC) is also turned on.  They do work
well together and they greatly speed up things, but if either is
turned off, `git status` will still need to scan.

Oh, thanks, I didn't realize! With that, I agree that the messaging I'm
proposing is not technically correct, and needs to be fixed.

I agree with your advice about the message when FSMonitor and
untracked cache are both turned off. I'm also trying to think about
what advice to give when they are turned on, and git status was
slow because the update-index was building the cache on that call.

Importantly, I'm trying to think of ways to keep the messaging
accessible even when the user is not familiar with those concepts.
I'm thinking a user may not even know what is currently enabled or
not in their environment, so there's probably value in detecting their
situation, and best adapting the messaging to it.

For context, in our case, we set core.fsmonitor and core.untrackedCache
as part of our dev environment setup script, because we don't expect
our least advanced developers to ramp up on what they are. And yet,
it is useful to all of them to have them enabled, our git status is about
30 seconds long without FSMonitor and UC.

As a result, we have been receiving negative feedback that git status is
slow, but when we inform the user that it is cached, they run it again and
confirm that it is fine like this. The problem being about educating
users and not a technical issue, of course we're adding the info to our
setup doc, but I figured other large repos may hit this usability issue, so
here I am.

What do you think of those phrasings?

- If neither FSMonitor nor the untracked cache are turned on, changing
the current advice to: "It took %.2f seconds to enumerate untracked files.
You may want to skip that part with 'status -uno' but you have to be
careful not to forget to add new files yourself (see 'git help status').
Otherwise, you can enable the core.untrackedCache config to have
it be cached, and potentially the core.fsmonitor config to further improve
the cache's performance."

- If only the untracked cache is turned on, since you said it could already
improve some: "It took %.2f seconds to enumerate untracked files.
Your untracked cache is enabled, but you may want to enable the
core.fsmonitor config to further improve the cache's performance.
Otherwise, you may want to skip that part with 'status -uno' but you have
to be careful not to forget to add new files yourself (see 'git help status')."

- If they're both turned on: "It took %.2f seconds to enumerate untracked
files. Your untracked cache is enabled and fsmonitor is on,
so your next calls may be faster. Otherwise, you may want to skip that part
with 'status -uno' but you have to be careful not to forget to add new
files yourself (see 'git help status')."

I intentionally phrased it all in a way that manages expectations, "may be
faster", since you said the state of the FSM token could be impacted by a
variety of things, so we can't exactly commit to anything for sure about the
next call.

Let me know what you think, I definitely want to do this right.


> WRT testing

Oh, I didn't realize I could do this! Alright, I need time to look into it.
With that, it means I can test the existing advice message use case,
which I don't believe is currently tested, so I'm double-glad!


Thanks a lot for all the insight.

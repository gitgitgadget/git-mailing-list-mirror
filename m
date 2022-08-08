Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D7DC25B0C
	for <git@archiver.kernel.org>; Mon,  8 Aug 2022 18:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243697AbiHHShr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Aug 2022 14:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233914AbiHHShq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Aug 2022 14:37:46 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1134DEE
        for <git@vger.kernel.org>; Mon,  8 Aug 2022 11:37:45 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id p132so11297907oif.9
        for <git@vger.kernel.org>; Mon, 08 Aug 2022 11:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=AdebdzW6i1SyHqnrTYUwp25Zh7doQyfnmMxk0OFKsf0=;
        b=RRp1fTN4a+swR2EUwGNTT6qu1iZ/1o6GFQB/EuzSGY2odxZi4oJWxTXUEF1Kq+sw0o
         rB4haBt+6y6YqW5gXc6ec/+iDEZ3qD2PFrOqAdqmBs5+hsyk0gmHmHbpH5BDvyYkUmAB
         NTSs0CR786wwKE4p6tlsHkA0UHiKk9xbiq8FaWWpIuAbPidxO+v2bv3Xx3fv6Cc8AoGF
         Fwl5hP6rFD8ro1l/tKP67rKgFWA+tnObCnQPnZXkr91HiNJUPbrqO49+h2VCWq0KrgnG
         eD3eKgoLKRjH/g+auAI6D/FvQvncd1r6QW6qmyi4q/2b2dc1bdZCC4OvO73Qb+LBbPl+
         bFSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=AdebdzW6i1SyHqnrTYUwp25Zh7doQyfnmMxk0OFKsf0=;
        b=zHirqxI+tYlpgw7UWJar22a93O4vYK2TNCBb8IADDYfXpOj4q6F/0l26eSRbAMj16N
         8IQbaaDjyxs+zmP1z2zebX4ht5tEtMW/a6KoyNR2QHlGUgQfRwdPN3iOJ4huetPkjnJA
         lEw59Aisjwr1+I5xMA8HuW3ch6kf7QaAb3o7bGWXEMCZtfu79kxTgyV+XmERPy0Pjw+m
         4LSJp2Ukcu5Z5QP9iRX5+a1hzPvgCzcvjJcHIzvELvzido05RDpiSSgpdohTUQmaAz+e
         IvpGab4kuj0LCDfjLU4LDjbEow67aEl4CiBJyusAk+XorghAIwIOK7KvE3zIpt1P9IdP
         KSpw==
X-Gm-Message-State: ACgBeo1iLfM1AfKbiXU8jdmJfjahpDDfCtcoQYxZNc9jyiyp80ONsx0c
        kom8TTesEnj7c73C1109tI8M+5UaD+YIlPnwp4ieMw==
X-Google-Smtp-Source: AA6agR7RSSI/QjmJiJVrfrQb8e9Sz2FGmcIIbZ3Xlw03QXGVRy/fMcYszey52fhIWppngzrlFI+9wnnm0jj4TdkoRtI=
X-Received: by 2002:a05:6808:10d4:b0:33a:baf0:338c with SMTP id
 s20-20020a05680810d400b0033abaf0338cmr8413514ois.4.1659983865173; Mon, 08 Aug
 2022 11:37:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220502170904.2770649-1-calvinwan@google.com>
 <20220728230210.2952731-7-calvinwan@google.com> <xmqq1qu37pbf.fsf@gitster.g>
In-Reply-To: <xmqq1qu37pbf.fsf@gitster.g>
From:   Calvin Wan <calvinwan@google.com>
Date:   Mon, 8 Aug 2022 11:37:34 -0700
Message-ID: <CAFySSZAKibH3dcHLFz=1csKwfa3-Ebkou_-soQS3h_+ewoZfUw@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] cat-file: add remote-object-info to batch-command
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        philipoakley@iee.email, johncai86@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > While `info` takes object ids one at a time, this creates overhead when
> > making requests to a server so `remote-object-info` instead can take
> > multiple object ids at once.
>
> I am not sure if the above is desirable---doesn't it make the
> protocol (i.e. the requests the invoker of "cat-file" needs to
> prepare) unnecessarily complex?  If we have "buffered" mode, the
> implementation can collect and batch requests and talk with the
> other side in a single communication with the other end, no?

I'm a little bit confused as to what you are suggesting here, in
terms of how a user would want to call this command. Are you
saying this functionality should only work in "buffered" mode?
Or are you saying that `remote-object-info` should only take
one object id at a time, and in buffer mode, those requests are
batched together?

>
> > In --buffer mode, this changes to:
> >
> >  - Receive and parse input from user
> >  - Store respective function attached to command in a queue
> >  - After flush, loop through commands in queue
> >     - Call respective function attached to command
> >     - Set batch mode state, get object info, print object info
>
> So, the existing buffered mode is poorly designed, in other words.
> Isn't this something we can fix for performance without affecting
> the existing callers?

Much of the existing cat-file code seems to be designed around
taking in one object/command at a time, and --buffer can be
thought of as a wrapper around that preexisting code that simply
stores a queue of commands rather than running them immediately.
I think the existing buffered mode is well designed -- this part of the
commit message is to explain why at some point I need to preprocess
what is in the buffer

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18EB5C433ED
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 18:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD7E96144E
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 18:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244624AbhDUSyn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 14:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235329AbhDUSym (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 14:54:42 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EF8C06174A
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 11:54:09 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id n127so10958581wmb.5
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 11:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
         :date:mime-version;
        bh=mxqPwwg+pyHoJaRm7CHY1Q8in8a2zh+ee3FXOSaAO14=;
        b=efdp0FYzdvp+Z/CwaL88Gnx0luGfDHivcFm9JdfrLrCx5coXcH0Y1O6I+5FqyvLJWs
         Y0KeAesoMaOM9Ggk0R3LjW7kIC5rLyuFHHVmKwBXqmeA2ZoVmJJiJqEERPq/EUXQ1qdF
         R0AvWQ+3iBZ79krHHCq7ywoP86+mRv1YIVp1ywZBCACQWRPboOLkWwyqKHT0cDMDIDU7
         HJDyltjHADTHmGuYo6m501WVXqewFhFnVI76V5xcNSyBrkw4EX9CHVMmL5VCPU7Lkq3T
         CmN35KL3PwHuTPecLAaIhjQFZo/ANDF7CvWs5cmzZ0v/1yn3JZFYRAtWf4ewhXXQQMeM
         IN/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=mxqPwwg+pyHoJaRm7CHY1Q8in8a2zh+ee3FXOSaAO14=;
        b=LK5z1wNsnxw7LxCgZ/nGwrv7GO4/VyjBAeU97+NwHTj9t5V5ZeBLCwmnsGQIpiDw7m
         n8eDUmuMYTr6p5tKgkLY2xH8N2ZP7zX7qJ+WK0Y1vm4pHaL60wVFgIxosWOoMiCVrxQp
         3m8daMahIKVkuOm3zylXamJlqBw8PqxHI4yOD2f4alKqGG996jYDArE7BRZewCS8YssI
         io2saOKu2x/G6KcHOS8+DSYMZ7n1P7Q3wwrSs4N310joNumLY3rIxIJ4R+KllaPco891
         tPFzVcq/R16lHmYlM6WIbC5k7clGZLYq328/XUmwcHsMIr5/yVGJX+EfIo9gw7pcenN0
         3TLw==
X-Gm-Message-State: AOAM533fiDYJZOEJ7Q0yFfTuUsBRq3ljpORdKz3EY5C4DIAi71yqAesD
        KRWpzY/XzfY3720MmYafhBQ=
X-Google-Smtp-Source: ABdhPJwdxSP18/b+ZTgh6rMd34jPT9p/uL34UpY7N8FR5Oj4gIRY57DgPOh8QuHxLL02VJZgKZ+Upw==
X-Received: by 2002:a7b:c2fa:: with SMTP id e26mr11372093wmk.118.1619031247935;
        Wed, 21 Apr 2021 11:54:07 -0700 (PDT)
Received: from cpm12071.local ([79.140.123.236])
        by smtp.gmail.com with ESMTPSA id o17sm308399wrv.16.2021.04.21.11.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 11:54:07 -0700 (PDT)
References: <20210418135749.27152-2-rafaeloliveira.cs@gmail.com>
 <20210419191553.581877-1-jonathantanmy@google.com>
User-agent: mu4e 1.4.15; emacs 27.2
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, szeder.dev@gmail.com,
        gitster@pobox.com
Subject: Re: [PATCH v2 1/1] repack: avoid loosening promisor objects in
 partial clones
In-reply-to: <20210419191553.581877-1-jonathantanmy@google.com>
Message-ID: <gohp6kfszjmptg.fsf@gmail.com>
Date:   Wed, 21 Apr 2021 20:54:06 +0200
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Jonathan Tan <jonathantanmy@google.com> writes:

>> When `git repack -A -d` is run in a partial clone, `pack-objects`
>> is invoked twice: once to repack all promisor objects, and once to
>> repack all non-promisor objects. The latter `pack-objects` invocation
>> is with --exclude-promisor-objects and --unpack-unreachable, which
>> loosens all unused objects. Unfortunately, this includes promisor
>> objects.
>
> s/loosens all unused objects/loosens all objects unused during this invocation/
>

Thanks, will include this change in v3.

>> [snip] The --keep-pack option takes only a packfile name, but we
>> concatenate both the path and the name in a single string. Instead,
>> let's split them into separate string in order to easily pass the
>> packfile name later.
>
> I think mentioning this part is unnecessary in the commit message.
>

make sense. I'll remove then to reduce the commit message.

> With or without these changes, this patch looks good to me.

Thanks for the review.

-- 
Thanks
Rafael

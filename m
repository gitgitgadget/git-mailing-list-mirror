Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20154C07E96
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 16:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0ADEC6128D
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 16:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233575AbhGOQpU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 12:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233390AbhGOQpP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 12:45:15 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10751C06175F
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 09:42:22 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id p186so7186110iod.13
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 09:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=jC2NH7f09XHDuXibyi425gtYjF7sfYKQ6u8Zl5oQy2E=;
        b=u9wx8abogLi0+S15J3vy/nv1cilp5Ux5hdrG+VLWbAFpfmQm+aUvaaT3FzC1lvw8jl
         zo/ua0g+3BO+3USRJna8TpTfsArSih8/fgEH+Qx3PDXqt1Db5nZ8R4/6EwjMKKkuoFQd
         cavWnrfujYJ+DNOaSZQfDmYwJkbB+9eG9ypRt4AnPDBUucAciY20eTxO5XOaVxImIpfF
         jb41J2SaS0AVN1cuNVF/hnX3W9XqYaTaWBWjYKKY04t1oIrmDjPPH4It6hV6ltV1ZqwR
         WbzXQSVE83QjfolSSH7Q+x2aCuUHNwPmSJQhCAAyIcKhFSgbfDZsyOm+YVWwZYNfaSBI
         BBeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=jC2NH7f09XHDuXibyi425gtYjF7sfYKQ6u8Zl5oQy2E=;
        b=R4u92fi9xzBYgZQseS4bpcohj5Qph5UnkhUNbXbwiwsiW6BHMhFQz8WDxYbnOhry4S
         tgCTelP7HooOi7ehnZbnRuGj5p+JV9lmTWT6xlv0flvGxEiy+9zH7GGzqLTytyf/O+QJ
         A5+jjdbFnxdiL6EyLgnayuWv1UDCyyz6G4y/G/VBvqdouLQqyRUtGsEnqoRtgukUcMl/
         5DCVY/amjCH+Cx3zfYj6q2YHNjxVMYIaSO0fYXIZknH/3atHXZa093JOqL4gWIn7u7aQ
         hOQ7xB5gqSznCLv5R+h130UiiFlsadELbEThsRNtvDAyC6uZOTpS3Ka69vHix2+3q9LM
         58+g==
X-Gm-Message-State: AOAM531TAMAY2oM2SjF4IYKsGNJwUncFeHoJfecgaMztIEFlyvVZU1yX
        Pu8DN6CsfHJ9WY3/Bm0UOWGEDQ==
X-Google-Smtp-Source: ABdhPJwkpZFAWzypxih1sCaMZChjeZVlKG/3ez9+N7b5MZrnBMoh3MixVnSS5mqvpwipRfKPQkCMfQ==
X-Received: by 2002:a5d:914a:: with SMTP id y10mr3893303ioq.140.1626367341543;
        Thu, 15 Jul 2021 09:42:21 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:d40c:332:312b:8a8c])
        by smtp.gmail.com with ESMTPSA id h13sm2848532ila.44.2021.07.15.09.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 09:42:21 -0700 (PDT)
Date:   Thu, 15 Jul 2021 12:42:20 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Sun Chao <16657101987@163.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Sun Chao via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2] packfile: freshen the mtime of packfile by
 configuration
Message-ID: <YPBlbNRoupMtT2dg@nand.local>
References: <pull.1043.git.git.1625943685565.gitgitgadget@gmail.com>
 <pull.1043.v2.git.git.1626226114067.gitgitgadget@gmail.com>
 <87wnpt1wwc.fsf@evledraar.gmail.com>
 <YO5RZ0Wix/K5q53Z@nand.local>
 <ACE7ECBE-0D7A-4FB8-B4F9-F9E32BE2234C@163.com>
 <YO8XrOChAtxhpuxS@nand.local>
 <ACFA1FCF-3F24-470D-A3AE-DBAA269E9E2C@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ACFA1FCF-3F24-470D-A3AE-DBAA269E9E2C@163.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 16, 2021 at 12:30:18AM +0800, Sun Chao wrote:
> I'm sorry to reply so late, I work long hours during the day, and the
> company network can not send external mail, so I can only go home late
> at night to reply to you.

There's no need to apologize :-).

> Thanks for your reply again, My explaination for 'why the mtime is so
> important' lost some informations and it is not clear enough, I will
> tell the details here:

Let me see if I can summarize here. Basically:

  - You have a number of servers that have NFS mounts which hold large
    repositories with packs in excess of 10 GB in size.
  - You have a lot of clients that are fetching, and a smaller number of
    clients that are pushing, some of which happen to freshen the mtimes
    of the packs.

...and the mtimes being updated cause the disk cache to be invalidated?

It's the last part that is so surprising to me. Ævar and I discussed
earlier in the thread that their understanding was that you had a backup
system which had to resynchronize an unchanged file because its metadata
had changed.

But this is different than that. If I understand what you're saying
correctly, then you're saying that the disk caches themselves are
invalidated by changing the mtime.

That is highly surprising to me, since the block cache should only be
invalidated if the *blocks* change, not metadata in the inode. It would
be good to confirm that this is actually what's happening.

Thanks,
Taylor

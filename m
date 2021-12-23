Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C26CC433F5
	for <git@archiver.kernel.org>; Thu, 23 Dec 2021 06:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242357AbhLWGII (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Dec 2021 01:08:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233648AbhLWGII (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Dec 2021 01:08:08 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39FB3C061401
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 22:08:08 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id v25so4057060pge.2
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 22:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R3+ghByBvLeZQBTNfh1YOaaQyzY3BKgT5sH+VPNoB8I=;
        b=IIDyGe7E0atQusdMMD8Bf3dDdUqhc87jEYXc6CaWZ0KhRb4pWR/xXuG775GC6k2JvK
         h5FkcNFla5j9mFkf98bvQ0kJCF0VtGFWYvmTmycGLPOGCbl7AwMi1lyBsLCyhHn57pH0
         l9pXiU9BtMT263UXsBTNBWS8nfOhrE0UJuTYDKJ3S1Fy7KMrHo6Z5GtZ6ZIX6TlW1OJI
         oKxggiG/WhHcpQXrYPtq98859JvnPkdP2V9rtTMVpTij/DHB9F4qouKM5sHcdZ7aS4it
         30L6W2tqv+wkT9+MpAJGV981rJOzxh8LOalOEj2zrQiVLmT8k3Wf2i/vJP5nRUKmCbqf
         iXoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R3+ghByBvLeZQBTNfh1YOaaQyzY3BKgT5sH+VPNoB8I=;
        b=sNzJrepQ4ELHkYzY8jMEUdDgci+/K2tc1/fEi6twReKuFRfZ95seIc+bYwWf4QFKoU
         zQuyUHGN42ZEHt5brX8QlH4iXhXziwzkxZvA7ICxVme3A3FrvjY2QzmLX1IxjfaYp2VF
         Rdlj9VpRQ0tZ+LtIlyk87Wd08aPSlPwPb1+4ycgnLQA8qTGZH2iykRp61d26BIV2Ybrn
         CaJZA586p593OEYBWVpWc3oTWj71FzCHdbzqRL7WIiho8BZZPHZLUz1OJzhz+hVWRvLy
         ZEUCAFr9fPSQqRUIMttke9FVbKFTZ2mPn709XSU+nLRjFgSX0oHqbEUT+MAsbKS5Sm4Q
         sRUw==
X-Gm-Message-State: AOAM532cuU3fWc1+/2tLTDL9U82BlxTUT4YXUmgsvcqm5gZk4My83HLU
        IJFU5THkdt6KL9D8whxlctpnRYz6EvmcBhpoR+Q=
X-Google-Smtp-Source: ABdhPJxUrQfL3atB/WrLIUkkZqA9ghP/OGVbmUMlKf6zribSGRHZNhwYrBh+sAWatKKD++s2xJ8J/96m/TlkKIV75Vw=
X-Received: by 2002:a05:6a00:b49:b0:4bb:5708:ea12 with SMTP id
 p9-20020a056a000b4900b004bb5708ea12mr1113494pfo.57.1640239687645; Wed, 22 Dec
 2021 22:08:07 -0800 (PST)
MIME-Version: 1.0
References: <CALRdAfcyfesNqfLhhe2GW_5V9s2hf++i6mZS1Lw5hqQYTca85w@mail.gmail.com>
 <CAFOYHZC0r35mfOVUExHsBP5=URKFAt_wDTZ51pTc=XkXyogqKQ@mail.gmail.com>
In-Reply-To: <CAFOYHZC0r35mfOVUExHsBP5=URKFAt_wDTZ51pTc=XkXyogqKQ@mail.gmail.com>
From:   Daniel Vicarel <shundra8820@gmail.com>
Date:   Thu, 23 Dec 2021 01:07:56 -0500
Message-ID: <CALRdAfcKSsct1gD87Pkjugttr3pFbXnh0W=kVa95G+9ZpNtLnA@mail.gmail.com>
Subject: Re: Why does "merge --continue" expect no arguments?
To:     Chris Packham <judge.packham@gmail.com>
Cc:     GIT <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the input, all.

Junio C Hamano <gitster@pobox.com> writes:
> perhaps the doc update would be the quickest one that offers the most to learn from

Sounds good! Now by "doc update" do you mean updating docs in the
Documentation/ folder, or adding a warning to the CLI output of `git
merge --continue`?

Junio C Hamano <gitster@pobox.com> writes:
> coming up with a sensible list of allowed options and arguments [to `git merge --continue`] would be quite hard.

Chris Packham <judge.packham@gmail.com> writes:
> I think it'd be a good idea to allow [--no-edit on `git merge --continue`] as long as it's the only other option allowed with --continue.

Based on these two pieces of feedback, it sounds like adding _just_
the `--no-edit` option at this point to `git merge --continue` is
worthwhile, and hopefully approachable for a newb. For now I'll put a
pin in it though, and focus on the documentation task above.


On Wed, Dec 22, 2021 at 2:46 AM Chris Packham <judge.packham@gmail.com> wrote:
>
> Hi Daniel,
>
> On Wed, 22 Dec 2021, 2:54 PM Daniel Vicarel, <shundra8820@gmail.com> wrote:
>>
>> There are several git commands that take a "--continue"
>> option...`merge`, `rebase`, `cherry-pick`, etc. From looking through
>> the source though, only `merge --continue` seems to expect no other
>> arguments. Suppose that you have just resolved some merge conflicts,
>> and then want to run `git merge --continue --no-edit` to accept the
>> default merge commit message. Having to open/close the configured text
>> editor still is mildly annoying. I'm interested in submitting a patch
>> to "fix" this `merge` behavior, but I wanted to check if this was
>> really the intended behavior first, and if so why.
>
>
> I added the --continue option to merge and I can tell you there was no reason --no-edit was omitted, I just didn't think of it at the time. I think it'd be a good idea to allow it as long as it's the only other option allowed with --continue.
>>
>>
>> Thanks,
>> Dan Vicarel (he/him)



-- 

Dan Vicarel

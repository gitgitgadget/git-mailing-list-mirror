Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54391C46467
	for <git@archiver.kernel.org>; Tue, 10 Jan 2023 09:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbjAJJOX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Jan 2023 04:14:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238167AbjAJJNk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2023 04:13:40 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB21F4FD7B
        for <git@vger.kernel.org>; Tue, 10 Jan 2023 01:13:38 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id t15so11171159ybq.4
        for <git@vger.kernel.org>; Tue, 10 Jan 2023 01:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QWvmFff1uVMakyO561r3489p8Yeu+RljpVCkrP4q8Mc=;
        b=MxAw2/5GL1gdrpYykGxdWz0SNVIs5g4tYLoKRmVUjPUkIYL365/XmUB7V8B4E4axhb
         hvoTUon+hRnzLovbA5amULR6qF6S2IaPPZ8F55QZZ5j7AmrSxnMZczDfygyi2aRfpWld
         /jbcEECdfibbVM00gJJY/PAUfn3ka5G1Xt6jbDrCyW085CVN/adpNC/lnEuzzNyKTnIy
         a2KOqXQodtIGamFgYADpJmfqVE3swYwMRqiONfrLvBJjvW4fznUr2lqK2p3MbzO3nG2x
         HSTacF8OW57PVV3V8JZT88kaO3f1zGx11PczNvW+Yr8qch+kP3UMdWJ1ouoIf93X0zgl
         liJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QWvmFff1uVMakyO561r3489p8Yeu+RljpVCkrP4q8Mc=;
        b=4ZzbhMkKslaBg0F4TUoARfT8A29cEu0XlKx5FdLFPSl+0Vu0D8E59iC8a6G5zBmkCG
         kZyUgHW7GCQASHCaRn2k3UPBdb5iu0oxjyQZ0O2BnDbBPnzAp+udNjIuNU8qk7d7pC9+
         3z1Cn3jKQbMBov9i9tK4KTA3UG6AInp9tDinWP4C/DhWhebIm+X5XIGfQxlyaYWgKF9C
         tq78d3bI+N1fzfL6YqcBtmo8I8H9Dx9rXE+ax9fmUHMSY/COkKUvLEm3r1jOMArw/s1m
         T9pBuytX12zSQhV3mUD6w7xT1YHP7YZys4spHEOG1f9CgyWvsFOXDngSKHTK2LvUxdhY
         Ygog==
X-Gm-Message-State: AFqh2kqECSpp8CcnHUm5Ic69xh7MCjJWdY9VbkTPki/5+EKRn0/3VUGL
        wSkJUEbmqOEGu2Ob4Hx3cMuMMWlZxqlu4/pV6pbvmJROonA=
X-Google-Smtp-Source: AMrXdXtxU5yOUKboLWda4I8aKFTFZ1EDQRWqczYJ5UdrOAYQ1DLM/yWsdlHHP4mdilOD7KE7fKHfHvqHTVrU1/bRvVk=
X-Received: by 2002:a25:7414:0:b0:701:6660:4386 with SMTP id
 p20-20020a257414000000b0070166604386mr5116075ybc.366.1673342017971; Tue, 10
 Jan 2023 01:13:37 -0800 (PST)
MIME-Version: 1.0
References: <pull.1452.git.1672102523902.gitgitgadget@gmail.com> <20230110005251.10539-1-nsengiyumvawilberforce@gmail.com>
In-Reply-To: <20230110005251.10539-1-nsengiyumvawilberforce@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 10 Jan 2023 10:13:26 +0100
Message-ID: <CAP8UFD1A8BofxHZP5cJ-xcQA8rbfoLN50hMc-dfUYUOGKqA65A@mail.gmail.com>
Subject: Re: [PATCH v3 0/1] ref-filter: add new "signature" atom
To:     Nsengiyumva Wilberforce <nsengiyumvawilberforce@gmail.com>
Cc:     git@vger.kernel.org, Hariom Verma <hariom18599@gmail.com>,
        Jaydeep Das <jaydeepjd.8914@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 10, 2023 at 1:53 AM Nsengiyumva Wilberforce
<nsengiyumvawilberforce@gmail.com> wrote:

>  Documentation/git-for-each-ref.txt |  27 +++++++
>  ref-filter.c                       | 101 +++++++++++++++++++++++++
>  t/t6300-for-each-ref.sh            | 116 +++++++++++++++++++++++++++++
>  3 files changed, 244 insertions(+)
>
> Range-diff against v2:
> 1:  ce51d8e79e = 1:  ce51d8e79e ref-filter: add new "signature" atom

It's strange that it's saying nothing changed compared to v2. I guess
the v2 it's talking about is not actually the v2 you sent to the list,
right?

Anyway it's better if you can describe a bit with your own words in
the cover letter what changed, and sometimes even what didn't change,
since the previous version you sent.

For example, here you can say that you decided to actually remove the
test that checked the %(signature) format and explain a bit the reason
why you did that.

You can also send links in the cover letter to the branch(es) (on
GitHub, GitLab or other such platforms) that you used for this and
previous versions of the patch (or patch series). It can help people
try it and look at the changes on their own system.

Thanks.

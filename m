Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C36DAC6FA8E
	for <git@archiver.kernel.org>; Sat, 25 Feb 2023 18:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjBYSJ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Feb 2023 13:09:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjBYSJ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2023 13:09:57 -0500
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F59014E81
        for <git@vger.kernel.org>; Sat, 25 Feb 2023 10:09:56 -0800 (PST)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1720600a5f0so3210702fac.11
        for <git@vger.kernel.org>; Sat, 25 Feb 2023 10:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8+mEiR96bsnZMk6vPShFlH7sSgYnwe0oXmuHumqt+g4=;
        b=G9JDTVmmq2wyueByFBVLbj0n/wKfb7+Ti4oa1xtpq796SfOf70F77bi++mFeRePgK+
         3qNBvfby6QpWK7OVEUdlrQmKpGZxi7WnyF4+jVuAA1TyZbtkTiGUUqm0Qv+apetj4LF0
         4SHA8RblfcMMrH8SNmid7rgM5OCQUCC661aZfB3jvl2hcLHp1dyxLLt6vFHI3SFkOAa7
         llcttiEhWdmtkHTbK6SJV+Qt2Wz5Npjz2rDUwcJ1K8tGRbQSjVYFTSjzu18kWIyKPXCi
         Du5W+A6K3kSq/ZMHESXZatq/9u6VVOSqd4+Dt7qYcQgEw14+2BVuqYjcBAR7kXeFglDR
         ZSaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8+mEiR96bsnZMk6vPShFlH7sSgYnwe0oXmuHumqt+g4=;
        b=wESn7wuudflWFLf8KO6U/WqzxSECenOaZPjs1qa8kU2LyPeGzgy9WznJ9kPmY/Jj+m
         qxLb0S0wL54AatHX8OqPkAIUcMxl7RS289iQ62Ejsv87iAfHUhGhkK2Uou+gEOwO7NQ3
         nhCXA1FBbU0LdShpvlzP02QSYJ0hTbT3VxHpKQF7Rj+2zOC6P+iZB3J6UiL5rfC0ndYR
         0vtRaUS5+g3v1VHfEMA5ejHMzlSfGbnvhBFVGMSd+DODYAhuSVmGAFAFK5r/X0pShIr4
         2PtL/QXl8L5zSlIehOfSXe4lP826T07N4HZdUu8LWsV9xjK+zXpePULQYQmM3t9wZjnV
         wJ2Q==
X-Gm-Message-State: AO0yUKXkFctre7OeRSLePgv6oOk4lg9qmckPipVr7Ito1fhtysxzvwyC
        pLJcXcu3uPE4wt8V7SVIMNabGpFvNqE5kvjRrp8=
X-Google-Smtp-Source: AK7set/Xu2sEpRqdTIvgnrCty27h5TANxU+ARZw7mYnc4AS1S9dJb/Jp2l3clMsevU3rcsqgEsfPY+TBHmyk3ctFm4o=
X-Received: by 2002:a05:6870:f80e:b0:169:ce1c:d7c2 with SMTP id
 fr14-20020a056870f80e00b00169ce1cd7c2mr1706148oab.5.1677348595915; Sat, 25
 Feb 2023 10:09:55 -0800 (PST)
MIME-Version: 1.0
References: <20230223053410.644503-1-alexhenrie24@gmail.com>
 <xmqqh6vc9tqy.fsf@gitster.g> <f1e8b718-c54e-b228-860c-54d7defd9e7d@gmx.de>
In-Reply-To: <f1e8b718-c54e-b228-860c-54d7defd9e7d@gmx.de>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Sat, 25 Feb 2023 11:09:39 -0700
Message-ID: <CAMMLpeTWsuEpC878BRh7zNZF_7pVZcaxw9A-bOwEOAPbH-rnOA@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] rebase: add documentation and test for --no-rebase-merges
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        tao@klerks.biz, newren@gmail.com, phillip.wood123@gmail.com,
        sorganov@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 24, 2023 at 6:58 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:

> On Thu, 23 Feb 2023, Junio C Hamano wrote:
>
> > No cover letter to summarize the changes?

> A range-diff would have been nice, too, as well as replying-to the
> previous iteration so that they're all within the same email thread.
>
> And if you want cover letters and range-diffs and correct In-Reply-To
> headers, I can think of a splendid way to encourage that: promote tools
> that do that. That's much better than to require contributors to know all
> the customs and conventions of the project and send mails in the exact
> desired format...

It would also help if those expectations were mentioned in
Documentation/SubmittingPatches. There's nothing in there about
range-diff or In-Reply-To.

I think I followed all of the customs of the Git mailing list for v5.
Please let me know if I missed something.

-Alex

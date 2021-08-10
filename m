Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F4E1C4338F
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 17:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34EC160E78
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 17:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbhHJREN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Aug 2021 13:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbhHJREM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Aug 2021 13:04:12 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31354C0613C1
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 10:03:50 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 61-20020a9d0d430000b02903eabfc221a9so22817609oti.0
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 10:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=00OSGQ3ls5Q5os2LcaKPQAUKvSOcBZFA5NZJchhWdc4=;
        b=firy+a63k6Ayu8BaEYrbl70fsfIIKK19bq5Iwy6cSdaa3oJIHQYrzMyYNnDartA4uf
         obhPL8SM5V6rWRMQUG+jLupbV5mnPced38/ZeQ3fWsvEdbfcLYaq+HuLdkSoA8r+SaL1
         ytobTD9adTeYo++Yk6cvke6dueXPSetTml1CW+/QH1o8eXMLAqTwv3SIgeBFpZYOhBEY
         zvcNI3P/pY5HsmZA5MxL/QiI8ewUvjJ3nNni/wT+hjyogfNGzKtMr0jfSUcRgjTzeU53
         m8F2ed7C1Ny6oK7HQwyf4QSjZFRQjNZvETpI0KF3qF7lJAmwXz4uD9Z70kH5wI5wgI0t
         qGnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=00OSGQ3ls5Q5os2LcaKPQAUKvSOcBZFA5NZJchhWdc4=;
        b=YKc2VZ+qSxoO35jMP/vs9nZvmWGecsuiK14Ox7EMCLiaBfmP/mwfSHLyPsf/90prz4
         AY7VCH5xWL1lq+vgy9bplwxBY7cR4A3KolEBMAztjrVr84U56aFdKsWbYSuVf17yj5+f
         4ZEEFZ/4+ucrqsjimfPAMnm/tGmE5mkfTq7yatWpCq6rs7cOaDWgQ4jAraD2Rzg7EsUt
         20SNisIsWYAKwcleyIOmDaYY23gLhzya6kjlD9HcmW0T31J5LlJnDK/rOSHzN+0TZ1w/
         kAWEgQ4JSSva/pVf9YzljjpbYnNYd/OMZFCunn9zJe8OTcdQLVdue5gGVNUShgUqSuyt
         aYHQ==
X-Gm-Message-State: AOAM532Xr4fBE/e8Qfgt4l400JcqvLecDmLrNdzSVVLu67s7QkhTUZMm
        vA8MqwdVfKCOjZwzF76qZ01gGkZpjinrTSIsFDA=
X-Google-Smtp-Source: ABdhPJyCwZWeeb2jnBe3tRACBK4WGONEHtOA04VK9wFslExdP9g4OtetcTF514r9wlHYeFWrsfcpQJzfEdMntwlqLFM=
X-Received: by 2002:a9d:630e:: with SMTP id q14mr6292458otk.316.1628615029594;
 Tue, 10 Aug 2021 10:03:49 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1013.git.1628587917.gitgitgadget@gmail.com>
In-Reply-To: <pull.1013.git.1628587917.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 10 Aug 2021 10:03:38 -0700
Message-ID: <CABPp-BHh5nEjhDFewCwJgNtTCPpODN7dAAKGHYz91PyFwT4rdg@mail.gmail.com>
Subject: Re: [PATCH 0/3] rebase --continue: remove .git/MERGE_MSG
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Victor Gambier <vgambier@excilys.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 10, 2021 at 2:32 AM Phillip Wood via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> If the user removes all the changes from the worktree without running git
> reset then it rebase --continue leaves behind .git/MERGE_MSG which will then

s/then it/then/

> seed the message of the next commit. While working on this I noticed a
> couple of fixups for the test files I was adding to, I've cc'd Elijah in
> case my reasoning for patch 2 is off. Thanks to Victor for the bug report.

I had a couple small comments on the first two patches.  Otherwise,
the whole series looks good to me.

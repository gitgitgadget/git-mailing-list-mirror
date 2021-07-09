Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A0EC07E99
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 15:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59394613AF
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 15:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbhGIPjC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Jul 2021 11:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbhGIPjB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jul 2021 11:39:01 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7CCC0613DD
        for <git@vger.kernel.org>; Fri,  9 Jul 2021 08:36:18 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id e85-20020a4a55580000b02902579a1a1393so2358315oob.6
        for <git@vger.kernel.org>; Fri, 09 Jul 2021 08:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RtzvHRrVhs+1s5y9gpT8tWY+lXKAGoAS4ngB9tsCqaI=;
        b=OHcwEW5PxiSCv93nodiMT1FbkdV8S4XuVwY9AvQtCJKu6cdfyDeODIRcf05R1Md2aL
         51Vunn/gMiASIbk6c/pfMixjMX6pBRN8YbUvSsCcQdHHy+WpZFMvJZcG+sGetDiV4K+b
         btTlNVJHhOuDsm7Qlb5ZSdY7hIXHmypnIQLDSmuKj6RKca7Z5cqc/UNOwzKwrknJ3ygs
         hNq1TkRIY9Sfwy+Hcq3ukJj2a6a4BYMVbrOrlQCkEHgrkIy6ylSZW/23dkT3mShqbXj4
         NdoaJ1PZPc0decqWJpcV4Vz5Q7j5LcBI9mZIk+6TTui3vo1y5QFNpmd4EcW2ZnzaZojr
         OBdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RtzvHRrVhs+1s5y9gpT8tWY+lXKAGoAS4ngB9tsCqaI=;
        b=gbdH3b529PTN8mqUg0yO61MW5ZK8aStoeP4xmscaTbG2+rjGNC5ynKI6q38C+hVJMJ
         cfjdlldt/BZCO22crt2wnnI6CC0RqFjEfwqQ7IzHI8fM6/Y16SmWZ0bdMBz7/5ExIL75
         s1uqfURKGeHKJk9hiU6waAS0nhdDOmYBhLWP6/CVil/Beq26mAlmVlaCM/K/qCMtruBQ
         wQ3w/PCriltwrK9lCpnVSYHr4qcCLQThRiC6bnAlqewvXwEY301Xe9hoY8F1pbkZSXjF
         zFRl7NFMeKQ+1fo1W6aLnovpX9WERJ8rmHHcgxRvW7+bPZGkUOKZOtZlcw0HN0RCP5g5
         k4JQ==
X-Gm-Message-State: AOAM53249+30LCyeodJxvlvE81I//zObZrmUtEHvROhXqBqqeWbX77FX
        jSV8iSR6ZNgOF5/2l1ChdClXCrXSNk1vwi3WkyQ=
X-Google-Smtp-Source: ABdhPJyUQbz2Tu5QgyYYS6MmPt6Xh+oBExPM4Ht73QzsKetIcWyuVl9umLDWnw4qJ26Is9joExzuipk7zSpv1Y5o3Yc=
X-Received: by 2002:a4a:d631:: with SMTP id n17mr15367521oon.32.1625844977840;
 Fri, 09 Jul 2021 08:36:17 -0700 (PDT)
MIME-Version: 1.0
References: <pull.981.git.1623675888.gitgitgadget@gmail.com> <41cdedd60907b966dffa6cf0c9825ffb448f4971.1623675889.git.gitgitgadget@gmail.com>
In-Reply-To: <41cdedd60907b966dffa6cf0c9825ffb448f4971.1623675889.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 9 Jul 2021 08:36:06 -0700
Message-ID: <CABPp-BEYT+uobXqBB2JZsZCtCm-5XcwqEWUYCf54sgB6hZX4DA@mail.gmail.com>
Subject: Re: [PATCH 09/10] diff --color-moved-ws=allow-indentation-change:
 improve hash lookups
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 14, 2021 at 6:06 AM Phillip Wood via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> As libxdiff does not have a whitespace flag to ignore the indentation
> the code for --color-moved-ws=allow-indentation-change uses
> XDF_IGNORE_WHITESPACE and then filters out any hash lookups where
> there are non-indentation changes. This is filtering is inefficient as

s/This is filtering is/This filtering is/

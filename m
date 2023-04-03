Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A50DC76188
	for <git@archiver.kernel.org>; Mon,  3 Apr 2023 16:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbjDCQYD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Apr 2023 12:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232725AbjDCQYA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2023 12:24:00 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC4D2122
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 09:23:59 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id y20so38861312lfj.2
        for <git@vger.kernel.org>; Mon, 03 Apr 2023 09:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680539038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oA6Vb2kWkvkRnnsElbA6+Wu8g/vg6hVyEhjd28zBCz8=;
        b=Hu/El885yHa3t25G7BUy7Hk51jBs9REBqMsecAH8GVfQtdCLwR89YvfOdR7k9VohIh
         YO62xL3l47aHGJo3aZAJ6dvcjkgcJAqe383jtc1pOC71+U1GizLB4UyICxJkvfkrRxOM
         Uh8J/lIh1DC8MJugg8513W6FA5M3BRcJJEz6JYheqC10qq+6CTAO/9gKU5rgfeFtFIWD
         g18UvtaBH2Q323V0zzRVqsOurp2dNyB2Aw+LiSRZ+l8AaNlkHZm2c7GVK2/6VPo30fDw
         EcztR2kvIN8Fq/bn2O45MB3qijXFMeszm6RGx3/3ywPRMTGH8tzHuGI9Jrt6QV7wb+H9
         l2PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680539038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oA6Vb2kWkvkRnnsElbA6+Wu8g/vg6hVyEhjd28zBCz8=;
        b=b4MdC/ak5L0mek36aYCVmF0Pt3TIq5jRUOma9MMEPdBDRrSTVxQnukiqEQYcH9M0lv
         E9PLt4IShPBRm69bepsQnBDZMc4Hf71aOAwwPvytjHG2t/jGbN/c+d/JMPzA5bpgGqim
         fmbDVtrRVSilfmAD4RGinA+VbYOomuB6El6P9InQS3LoIBXQ1zw9k2XVgxKbqnQbynnG
         owMXKQyKRTBwP4964rYvF9w9AEWWAC4nT5EV1SunYiNvq8lCCmXl/IumrG6jg9tFiWrd
         8Z7GhChgLwF1oh5E5pqsFimFrtx9DwKCHAyv2Wr5lTIPcY34/sh57y9e5KEjziFNgQfd
         AQ5Q==
X-Gm-Message-State: AAQBX9dtqSx5qP7iuIVw26WTPBauiAPZt3JiE+NYZCl6/LYGH/wXuKLN
        1aX1t2UZkUyh5aNaJRm6juiv2IPG+RM5PcYDwgOfoQwXdV0=
X-Google-Smtp-Source: AKy350a8EoNvmo4qb7+vi1YTARIWesjkODAu4jLfZgTpjNCIXx3OUha93wfhEq9FNQ9vKYDEHgSx2jq0v3pLr5JfS+I=
X-Received: by 2002:ac2:5310:0:b0:4eb:1606:48d5 with SMTP id
 c16-20020ac25310000000b004eb160648d5mr7045144lfh.7.1680539037781; Mon, 03 Apr
 2023 09:23:57 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1509.git.1680361837.gitgitgadget@gmail.com>
In-Reply-To: <pull.1509.git.1680361837.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 3 Apr 2023 09:23:44 -0700
Message-ID: <CABPp-BE9QSOmHuZanmi5igfhaD8UGJWqv2CwV50Fa2eCQD0gRg@mail.gmail.com>
Subject: Re: [PATCH 00/24] Header cleanups (splitting up cache.h)
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 1, 2023 at 8:10=E2=80=AFAM Elijah Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
[...]
> This series builds on en/header-cleanup
> (https://lore.kernel.org/git/pull.1485.v2.git.1677197376.gitgitgadget@gma=
il.com/)
> and en/header-split-cleanup
> (https://lore.kernel.org/git/pull.1493.v2.git.1679379968.gitgitgadget@gma=
il.com/),
> and continues to focus on splitting declarations from cache.h to separate
> headers.
[...]
>
> There are more changes I plan to make after this series graduates (still
> focused around splitting up cache.h), but this series was long enough.

While preparing some of those additional splits of cache.h, I found a
few small tweaks that make more sense being squashed into this series.
I'll send out a re-roll tonight.

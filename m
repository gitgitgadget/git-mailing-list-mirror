Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E04BC433EF
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 21:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A1C6603E9
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 21:43:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbhJ2Vpm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 17:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbhJ2Vpl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 17:45:41 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA885C061570
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 14:43:12 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id ay21so118149uab.12
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 14:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HsE9HD8abya3XpesgeM9jqEQKzy5OE9NItvNOj1wVJY=;
        b=H9v4J2s/7890V83Ib4jCU533cd/r2bzNwsdmQt29Ku1IDqLfzhC0eQQ9fZkZ02uJMy
         QmFYaPed/eFgsg9zB1cR3sYMebeys2h7qJdB8dYTvejJOsIq4zwcipRErNFtgDd2wLQX
         ABA5iO8q3MAdAkUapjipOvpF+jzgJCq6rf3c5VUl06+zr7gCW56t2u/hevkEgmJ9yoer
         KISMnqr4YOWDIMlLLKTyzq6FITnUge/SoWanJI3XS/rxvmXe50A4iKH3fs5S+baQ7W7s
         XzVwOAS08WDVHM+ohpxXpFkrLWqUIOlxVQtr2w3oBIyfVHqN7hGLeBEe834nd0+6bP8R
         7SrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HsE9HD8abya3XpesgeM9jqEQKzy5OE9NItvNOj1wVJY=;
        b=2n6MUFYYAtCzyeFeBtUlyh8MT669SG3mnoloDciBjoKCBrDlxaPRu/6gZxJ+pLCFeS
         walfGJzWRanPk9zC9nfJFMkKSlWgzcjmie6mY5QwsjE8x98ksVJ9vyOs1T2m8rkcfcti
         ZSVF6pXys8w3dU5X0fpDORF00DxUUm9CGmJbLgu4ZI0LYma6JS/QfQUrWM/AdBCz1WQH
         49ay2OHXt2PoEzn2Lxp4IE+L9awIGI9Rg7Io7i2jA8H/YGW+yRks2yRG6sEYYOXOettu
         LsdlYdHKFbzvMT4hUVkkOk/M8/5lrpW8RRrj6sIExsnQFd5GYlBv8WoV3G56aivQ33Or
         kzmw==
X-Gm-Message-State: AOAM532eqKjtJMLcsHjyEIhgYcMg36rKacY6Po0LV0lfEMmpz/s0dPr6
        sC2tr4ifj1LIAgayCfA2IFuFN8ny5vnzy9mWqDA=
X-Google-Smtp-Source: ABdhPJwRuPJAXF2Kw6hQZNL+CypsZEmNrWw2JFcYwg8prVdd5fzbJ7UGb3nfZwCk7zNjhY+z7OmQ9r6I0A4CdcUz0Ho=
X-Received: by 2002:ab0:1447:: with SMTP id c7mr15281783uae.2.1635543791943;
 Fri, 29 Oct 2021 14:43:11 -0700 (PDT)
MIME-Version: 1.0
References: <20211029212705.31721-1-carenas@gmail.com> <014301d7cd0d$3019b8e0$904d2aa0$@nexbridge.com>
In-Reply-To: <014301d7cd0d$3019b8e0$904d2aa0$@nexbridge.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Fri, 29 Oct 2021 14:43:00 -0700
Message-ID: <CAPUEspht5wFnsLMxzaq5JNJV2eh_YRB5PZ4UWXNMTJpG3gOf8w@mail.gmail.com>
Subject: Re: [PATCH] wrapper: remove xunsetenv()
To:     rsbecker@nexbridge.com
Cc:     git@vger.kernel.org, avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 29, 2021 at 2:37 PM <rsbecker@nexbridge.com> wrote:
>
> I will be submitting a separate patch to turn off NO_SETENV and NO_UNSETENV for the NonStop x86 platform, where the calls have been supported since October 2020. The ia64 platform will have to continue to use the compat layer.

The right place to add that logic is most likely in config.mak.uname;
see all the other conditions that match based on version as a
guideline.

Carlo

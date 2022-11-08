Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCE4C433FE
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 14:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234048AbiKHOYb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 09:24:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234212AbiKHOYI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 09:24:08 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDCD5C74C
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 06:23:09 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id v27so22726640eda.1
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 06:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o4BoqUm+lL6JHgePg047V+3/+DuJbzxzbl3M4HafnK4=;
        b=EEbzQ7WFDjcGQhkK/fTnyWhlyUguK7aFShy5c54EVF8FMQYmKKZ/0l6NaJyZYwf3Z5
         HDyRGbYRSjvuEtxdk3dttSyKcgGYVoPAkuTjs7tqvAQV6Ls5p9J86W61aDCWzXYrh2aG
         yO+TF+KQpuT8d7DnNjXzQ91bzOcSQmvjW6DMS9a1KE0+Mvk+SsQJE0eku3JyvQcsNvf6
         cGZWjyCoy63ocxsxdqXVPTzBbVMMZiBNqsvHgYIG6XvVWEqZZvYcvqDk9/U6OgjIVGri
         49MLY+vKwzhA3ym36K/lYAPjlCj467bLUXfPWewsGq3b92ZZ2ov/6YkIhtWBK9aYEV06
         w+Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o4BoqUm+lL6JHgePg047V+3/+DuJbzxzbl3M4HafnK4=;
        b=2rmyFz1dL7YQ/EnzoexS3FNNkEDD7mtSgsvZOzU2+adqnTtwpJKy3vs/ZNtMh/d/iS
         LKLSRLmOCHDeGFDD7bfdnI4WJiSb8K7cn+9DmIM3vfa5TPXVl7TtLCnqH0WgvQean9wh
         kDvkg2CN8xCjaDlaU97oJInnAHUMF1I/UzvMFbDii9y47pIhjEIMkeH853mpmkox8zdI
         bIowpswqYo7IgHO9xXKqmeuYlnM1nCylmPvrbSShWXJEmqxSbed+lBO22TQCfA1VLxqP
         estnChtwPuVLLoKhcHWkfJZ/MWD43sRhdQ/PNIdG/vwPKlOCa5QNFQPKAcbXir7FG+FF
         qahA==
X-Gm-Message-State: ACrzQf1f3l6citlzcSjTn/vbBcP1kxYc1Xrm+J3IDr9uUx1iTqhPislm
        X4ykN7/MFB4zXIASMLLY4+krOPosBCKTdA==
X-Google-Smtp-Source: AMsMyM73rc6N2ZI0ZN7bI8jG3YE2Eqwf7XdDoV84UNQJTud7xoJe0bE2Iuv8pqJhIGXAe+SQLEhKlQ==
X-Received: by 2002:a50:c21a:0:b0:463:c2ac:95f6 with SMTP id n26-20020a50c21a000000b00463c2ac95f6mr38257747edf.398.1667917388013;
        Tue, 08 Nov 2022 06:23:08 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id qq18-20020a17090720d200b007ad98918743sm4739712ejb.1.2022.11.08.06.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 06:23:07 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1osPVK-000Zv0-3B;
        Tue, 08 Nov 2022 15:23:06 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: ab/misc-hook-submodule-run-command (was: What's cooking in git.git
 (Nov 2022, #01; Thu, 3))
Date:   Tue, 08 Nov 2022 15:22:12 +0100
References: <Y2RldUHTwNzmez73@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <Y2RldUHTwNzmez73@nand.local>
Message-ID: <221108.868rklseyd.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 03 2022, Taylor Blau wrote:

> * ab/misc-hook-submodule-run-command (2022-10-31) 3 commits
>   (merged to 'next' on 2022-11-03 at 0f01b25561)
>  + run-command tests: test stdout of run_command_parallel()
>  + submodule tests: reset "trace.out" between "grep" invocations
>  + hook tests: fix redirection logic error in 96e7225b310
>
>  Various test updates.
>
>  Waiting for review.
>  source: <cover-0.3-00000000000-20221029T025520Z-avarab@gmail.com>

Per [1] that's a stale comment, and you'd decided on a "let's merge this
down".

1. https://lore.kernel.org/git/Y2Kn5MVQojz33cta@nand.local/

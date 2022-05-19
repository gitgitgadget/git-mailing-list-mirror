Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7C7C433EF
	for <git@archiver.kernel.org>; Thu, 19 May 2022 19:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244577AbiESTcv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 15:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244569AbiESTcr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 15:32:47 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A562E5FF29
        for <git@vger.kernel.org>; Thu, 19 May 2022 12:32:45 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id i19so11771876eja.11
        for <git@vger.kernel.org>; Thu, 19 May 2022 12:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=Wwk+Gi0GPLESXmn7ImU5an1ZtL6yl6PlL4D4RFOoYAw=;
        b=gv8v74KNATiVf6sZ3I3QppTowxHN4GqZ0atEnJCrNWaDXev1G2MCq3hXAj8YidwFOs
         t+rbMceX+DK21/GC2hLd0iyO/mf8alZ0TNVe2B0yofM1dWKzLNe9WQjRokdlwUJ1e1V5
         V0V8NdI4ihmrBrYVHvZ2sqF7/jN6iWB3yfGQOWILYWclyLbLOq3NU/j8tVgfHiXvVffJ
         8fSekP/+BCYQRjTIT4XtJxquBbC6jeiyIItcjyKNHllT6icKZn2VXonkXG/aBN7vmlnI
         CU5md2NwO4cN3gv567jrBlGCj3OWhTgVmWAQTSmOTJIHNU79puy0h7u4Y81xgs4uZnGE
         97Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=Wwk+Gi0GPLESXmn7ImU5an1ZtL6yl6PlL4D4RFOoYAw=;
        b=TreKdYVADEyC/icUbgHANCQjYpqaBM0eLEH18JqkyCT2zqClrImIsMOvhOeCM6nEmE
         ji2wx36cHX2KvzuWon3wlxMv7dUk02DDIIbAC9dX0t5/1vTzGLbfXsSAtcnp/ZmQq2lW
         K/NTyTpQE+x8My9wtW8wwf+18DV5QmYOtzjPDYOvt8pxR/qb8+kBj6Ehfu0+0pzqurZn
         4I73Lgi5tFnEZQxsp1mI3CKZCe2IUFhqPQ7k82+oPuJOdJCTKupd+5cE1jEqYd4omqJ0
         NZwgWhaI4r84oHC9gxt2hDRJnR5JBxg/fzPoLSiuCb6LRgWw/RafIDwR5oVYcUrOmxRE
         F9Uw==
X-Gm-Message-State: AOAM53314jZETxo2/zuDR4m2FZa0b8DPBIQkR+PAz4Vde8xy2Pg+B1Wi
        BoA4i2UNsn5kb3/+BnQQY1oWsvhoUkbBiw==
X-Google-Smtp-Source: ABdhPJyXZOGAaC3BnNnQ8WPkh/J5USTzWKLBCR+ta6IituVyXRU4r8aPA/5+PrFRCHi3u6gze7UlGw==
X-Received: by 2002:a17:906:7d5:b0:6f3:a6a5:28c6 with SMTP id m21-20020a17090607d500b006f3a6a528c6mr5872394ejc.11.1652988764122;
        Thu, 19 May 2022 12:32:44 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id qx16-20020a170907b59000b006f3ef214db2sm2388993ejc.24.2022.05.19.12.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 12:32:43 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nrlt4-002IIA-Da;
        Thu, 19 May 2022 21:32:42 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: ab/env-array (was: What's cooking in git.git (May 2022, #05; Mon, 16))
Date:   Thu, 19 May 2022 21:28:58 +0200
References: <xmqq5ym4zpmn.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqq5ym4zpmn.fsf@gitster.g>
Message-ID: <220519.86sfp52u91.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, May 16 2022, Junio C Hamano wrote:

> * ab/env-array (2022-04-06) 3 commits
>  - run-command API users: use "env" not "env_array" in comments & names
>  - run-command API: rename "env_array" to "env"
>  - cocci: add a rename of "struct child_process"'s "env_array" to "env"
>
>  Rename .env_array member to .env in the child_process structure.
>
>  On hold.
>  source: <cover-0.3-00000000000-20220406T104134Z-avarab@gmail.com>

I'm not sure if the "on hold" status is wanted here, or a holdover from
around the release time (per
https://lore.kernel.org/git/?q=ab%2Fenv-array); but in this case I think
it would be very nice if we could advance this sooner than later.

I'm aware of a couple of topics that would semantically conflict with it
if re-submitted (IIRC the rest of submodule-in-C is one). So if we're
going to do the s/env_array/env/g at all it seems better to do it sooner
than later.

Thanks.

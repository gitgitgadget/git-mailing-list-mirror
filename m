Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25FE8C47088
	for <git@archiver.kernel.org>; Wed, 26 May 2021 18:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2E4B613BA
	for <git@archiver.kernel.org>; Wed, 26 May 2021 18:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234194AbhEZSej (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 14:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233227AbhEZSej (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 14:34:39 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4025C061574
        for <git@vger.kernel.org>; Wed, 26 May 2021 11:33:06 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id gb17so3984853ejc.8
        for <git@vger.kernel.org>; Wed, 26 May 2021 11:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=ss+Tb4+r2ztXohI55tFPWT6NjxeDnMfjS31DjNgErOE=;
        b=oAl8RjlSnUvx8lxY8TyGIFO02CCnznswxa4YPxthN1GElyUL4P80YBkIcYHhiezLHU
         87N3iVzdE26x2tbUkB0q+GiPtyUfuXKxUPWDW7S1xYJl2//NUevaad7Gv5USHZXULESm
         MarB/ku+ekcUPvzaCn0puW2q4tf+TgdsI1PQdq9+iYxKImICvMg2D3XLiDWmXWV/2Ngt
         Q70LwTgFj3wnrF4OHBz3b9jvPg/WK+l4j0quQ1fkT2O91MgA1nFRG73FOM4/3FVozUlr
         SOdCuPZ1fCdGYTUqZumjBgsyxo76lMhZNWJR+KX312H8WdaqB6To437++9Casa3UhsKN
         kVog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=ss+Tb4+r2ztXohI55tFPWT6NjxeDnMfjS31DjNgErOE=;
        b=YObUuYjaEpX38k9t/blwqjwxynuC1427+lRQXoNb6NkbPz8zJkljiQIg2/SHC/Ffmv
         4updndGZqxvBAYxlQAcT/u7DmxRHAlh71qLcW6TnZeGCHrsgZvCEx+YVTKh2r3fKytx4
         wTZKLrxu3b50iDRQ9RZ4PQ0QnOUgZJUvQqLWSuXa12ijn0LuiuEwUl3nA4KZ3fhbCYYw
         VtNgfaLuTWNkCXc9m5+dc9olgXSs1VRrKOW+j2BgtdU1O+lgSZz7V/VxoXp2Cz0bGbIK
         OPIpBSxtobp3UFFafippDoH4C9lsgLk/w37GDPDKioZnZzAvO0HxdQeUWoioyMi+dZDE
         rq2A==
X-Gm-Message-State: AOAM53100yWA8Lm1QXm/xPc58BSVEetGXWpk3eiv+zsveFtoZeFSHKVt
        BlGjE8YzHdlcb8Jl8K1FMZs=
X-Google-Smtp-Source: ABdhPJyqqkznzmARKyOolMUvfB72yFw1vOsTdaAswcd4NUG78IaFizj9aM7rzb8gdebA7gO1P5ry9A==
X-Received: by 2002:a17:907:76e8:: with SMTP id kg8mr32931419ejc.130.1622053985302;
        Wed, 26 May 2021 11:33:05 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id qx18sm11670ejb.113.2021.05.26.11.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 11:33:04 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net
Subject: SunCC doesn't compile v2.32.0-rc* anymore (was "Re: [PATCH 2/3]
 t/helper/test-bitmap.c: initial commit")
Date:   Wed, 26 May 2021 20:30:49 +0200
References: <cover.1617240723.git.me@ttaylorr.com>
 <ec974bb0c85bcde00d45e983d701c538488550a6.1617240723.git.me@ttaylorr.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <ec974bb0c85bcde00d45e983d701c538488550a6.1617240723.git.me@ttaylorr.com>
Message-ID: <87h7ipmjkw.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 31 2021, Taylor Blau wrote:

> Add a new 'bitmap' test-tool which can be used to list the commits that
> have received bitmaps.
> [...]
> @@ -0,0 +1,24 @@
> +#include "test-tool.h"
> +#include "cache.h"
> +#include "pack-bitmap.h"

Since this commit SunCC (on Solaris) refuses to compile git, a new bug
in v2.32.0-rc*.

It's because it can't find the oe_get_size_slow symbol, you include
pack-bitmap.h, which in turn includes pack-objects.h. That file
references oe_get_size_slow, but it's only defined in
builtin/pack-objects.c.

That looseness of definitions far pre-dates v2.32.0, but I suspect we
got away with it due to builtins including everything (or something)
anyway, and that this is the first test-tool usage.

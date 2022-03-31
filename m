Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B63A6C433F5
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 09:46:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234279AbiCaJso (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Mar 2022 05:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232496AbiCaJsn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Mar 2022 05:48:43 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731523E0C7
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 02:46:56 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id w25so27472973edi.11
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 02:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=pcAuM33B/aD5j4CdghaIJyTdjztXpgSlf0wVW4FIFYM=;
        b=Jt6ubwtg6NsWcz+D5Jn1XC1LHRQhYXoTXnwpfAul9oiUdEsKJ0/kKuo1kYruIM1yRV
         U8Cw2AC9Wm2d49AGN0wF5iJaJRkZE7l/Fx6IQBSzgfGC/ATECz4dXcqF2r8JB0uqwJHa
         TGDVxqkwtOiOsUiJuNukfXrekUfkOBQ3e32d86jx2/p/GoebrtXTHQcsI27EE60K42hT
         9fk2OTBqZhnNLOMAD+HNFrvRiO0hqFCAX9if0P/PRJ3/0ocBAi1uojCL88zNipxHuvub
         akXbe9V3opPiSBmOh8FN157QDkMyD6MnOsD1hr6LuUrdi8sFc+fygI6A4ole4X8vEDKH
         lFrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=pcAuM33B/aD5j4CdghaIJyTdjztXpgSlf0wVW4FIFYM=;
        b=G5ScocFOWM4NONyYOhGseliPegU8wVLqo9s5ZHfGonOXtwjMKwQO8T6YLhcgDUddAq
         b9drgblPPDGKVY68VqpzMDbY9Cp07QY2WVREc1ZloRajYcj1LCWtTripq20t5du9vckQ
         fKtA7BlRVrlzvdLSLTWTaCVyorx5e2vFW11KtNQOBWLtU1aBRqQ7bAAsvR02VeT+Xu26
         lcRjjUugai5ke5nvFSwPOi+Z2qypD3chjNKR5OFJr9R/dcOjWvXwYAkrK4xxySLgBrml
         99Z0A3wqtVrJ6KqYImFcnXOnMtS7vlZDg8tCJ8G2DqcIVm1P/0tWjQnUhF2bBdWCrYCk
         ckvw==
X-Gm-Message-State: AOAM5302q7FhkYK5EYzeKbf2nE+4jhXPZfrMibwMBDoChRfgkoB8SJNu
        KcrevTBv9gc2s0CUVgSTQrYN6Lz4CZsaBQ==
X-Google-Smtp-Source: ABdhPJwp42RuwvsQY6d9md472L42dCyIoI8b99MvB4XSvVDNK7VMAno2SpgzRVuI5I8WNpIy/tleXA==
X-Received: by 2002:a05:6402:492:b0:404:c4bf:8b7e with SMTP id k18-20020a056402049200b00404c4bf8b7emr15184702edv.318.1648720014840;
        Thu, 31 Mar 2022 02:46:54 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id f5-20020a17090624c500b006cee6661b6esm9297741ejb.10.2022.03.31.02.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 02:46:54 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nZrOH-000Kaz-Uu;
        Thu, 31 Mar 2022 11:46:53 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: ab/commit-plug-leaks (was: What's cooking in git.git (Mar 2022,
 #07; Wed, 30))
Date:   Thu, 31 Mar 2022 11:45:58 +0200
References: <xmqqee2i50h9.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqee2i50h9.fsf@gitster.g>
Message-ID: <220331.868rsqsbci.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 30 2022, Junio C Hamano wrote:

> There are a handful topics that are marked to be expecting updates,
> some of them more than a month old.  Do authors lost interest?  I'd
> look at them myself to see if they are interesting enough (in which
> case I may try to finish the last mile for them) when I find time,
> but no promises.  Help is appreciated.
> [...]
> * ab/commit-plug-leaks (2022-02-16) 2 commits
>  - commit: use strbuf_release() instead of UNLEAK()
>  - commit: fix "author_ident" leak
>
>  Leakfixes in the top-level called-once function.
>
>  Expecting a reroll.
>  I think UNLEAK->strbuf_release() is a regression.
>  source: <cover-0.2-00000000000-20220216T081844Z-avarab@gmail.com>

This is one of those old topics, which I sent a status update about in
https://lore.kernel.org/git/220325.86v8w2kurx.gmgdl@evledraar.gmail.com/

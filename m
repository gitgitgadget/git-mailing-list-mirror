Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86035C433EF
	for <git@archiver.kernel.org>; Sun, 12 Dec 2021 22:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhLLWrv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Dec 2021 17:47:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbhLLWrv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Dec 2021 17:47:51 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F49C06173F
        for <git@vger.kernel.org>; Sun, 12 Dec 2021 14:47:51 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id y12so45772366eda.12
        for <git@vger.kernel.org>; Sun, 12 Dec 2021 14:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=1BiCrllPwJe+LOrNsLyfeB63dcXl6XXUZstVf01ezhk=;
        b=IQJlCoGzxPYPt+zyMHETgv4IJ73Dxo7zrVSjQHT/j+vvsMAxOomk9DbRNGtt4R74i5
         /186hJXxxQH2dNwY1ZstWpAVd/JYOhKaXrUf+qolNzqxHu8OlUuuO9XKAYfp56HIH01Z
         3NaU/VWkxfPi/3azq+L3BEIoeZecpBCCX0lTBSa+Osg6JcWvvC92CPoESDlD6Q27+lYR
         AfzydJfZtN5yw6RdnEijeE33rOOfzPMxVTkaobj6oz2wZtOBQVWTfltKvj838rD7vt2r
         OTxm/AWjcAhfQdHd0RAn6psZr9KKj6oBNFaGDsZ+TnCX6gRM4QRGhzv1gfB9TK2RtujT
         eP6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=1BiCrllPwJe+LOrNsLyfeB63dcXl6XXUZstVf01ezhk=;
        b=FE9oU7gEbG5XX38mBoqHiJO1wFHgJSvNzm2fTOy51blfDwPLRGXbUtEHN1IhVomWx+
         i1b2k9YiJW19xecelu0h0kNJ1H8AELDGUsNK92qFx8wp+5sGlVkh6rpoyIdEqkXtyOX4
         47WTuG19iXWIN45lCTPNoMFnsBY7odfhiyj7FIPaNqHtThKgUJEaIRZcjMXXMRPNJRAj
         0lihJUD8v3mDAqWQrU78jgx/ljw7G/PbepIQDew/eRwMpALXU4Nml0gEd+/dqIRaejLI
         9n+ZMkJEo1ejhgVUtE7pzVktAXvXnWCeEXixIGiKuK9q5npPdOZaoSGlLnoOQRPGj1lC
         I3Sw==
X-Gm-Message-State: AOAM531C86S55yIJrp9QVKjP7ifAxYZO9bsSNDU/C3naemqMavQ+eimq
        /Pc3MCQ5hWJwSEu/1yDcZzXl2yJ+OMJSiw==
X-Google-Smtp-Source: ABdhPJzdM4MVmtRRve+pdxa2dpOKZoWxbz+7iuOuZo1BPTYMqXdcZzN15sovXN3FTMdBVOxIfjXuDQ==
X-Received: by 2002:a17:907:3f19:: with SMTP id hq25mr38197402ejc.225.1639349269528;
        Sun, 12 Dec 2021 14:47:49 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id w22sm5425423edd.49.2021.12.12.14.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 14:47:48 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mwXdD-000g03-NX;
        Sun, 12 Dec 2021 23:47:47 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Maksym Sobolyev <sobomax@sippysoft.com>
Subject: ms/customizable-ident-expansion (was: What's cooking in git.git
 (Dec 2021, #03; Fri, 10))
Date:   Sun, 12 Dec 2021 23:42:00 +0100
References: <xmqqilvvluoa.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqilvvluoa.fsf@gitster.g>
Message-ID: <211212.86fsqxa19o.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 10 2021, Junio C Hamano wrote:

[CC-ing Maksym, the topic author]

> * ms/customizable-ident-expansion (2021-09-01) 1 commit
>  - keyword expansion: make "$Id$" string configurable
>
>  Instead of "$Id$", user-specified string (like $FreeBSD$) can be
>  used as an in-blob placeholder for keyword expansion.
>
>  Will discard.
>  Stalled for too long.
>  cf. <xmqqfsuosvrh.fsf@gitster.g>
>  cf. <211101.86fssf3bn3.gmgdl@evledraar.gmail.com>
>  source: <pull.1074.v3.git.git.1630462385587.gitgitgadget@gmail.com>

I'd like to see this go in, not because I'd personally find it useful,
but mainly because I didn't find anything wrong with it (per my review
id [1] linked above), and more importantly because the saga ending here
seems rather unfriendly to a first-time contributor.

Wasn't the "stalled for too long" mainly a victim of timing? I.e. that
it happened to be submitted/discussed around the end of the last release
cycle?

Maksym: Are you interested in pursuing this still?

I think per Junio's[2] an updated commit message describing some of the
use-case (and in particular how/why .gitattributes v.s. a git config
setting is needed) might be enough to help move this forward.

1. https://lore.kernel.org/git/211101.86fssf3bn3.gmgdl@evledraar.gmail.com/
2. https://lore.kernel.org/git/xmqqwnlito0b.fsf@gitster.g/

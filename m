Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B20FC433EF
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 13:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DFF06109E
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 13:48:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbhJMNu0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 09:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbhJMNuZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 09:50:25 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7113EC061570
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 06:48:22 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id g10so10625141edj.1
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 06:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=IYdq0KexmHmuHggD8lCpArPJJ5IpOubngK2svWx02lQ=;
        b=NusluYm4aFQ1b6N/XUlUlBK+Hw1cLtcD1vLj5N1NKoHonMLZAGR3DgpmaPIEtgENIo
         DRKoMuW4gyWpU/xo4oZYHtu0aCLSwyY6hbcWGoSfnBblZArSGb+UkN27NHX+PbChFZBx
         VZoV6ZLcowXDQxerEk6lwXW/UkP8uMQIdIlME4L7FglP6DdHdgd8gTBQ0emvsak10fjS
         vxMyt8cHNjqiMmA54MLZ5mhIrsWi1xc2UJR/dUo5N5I8IjGryRDrjvJA3ZddW7GCJddc
         gqGD6a6ROIIOL5Ps7jvrOVSNkOQ/MgVTmKJDKybnJZEAyOi+hwPoVjrXri1soHrX15J2
         OXWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=IYdq0KexmHmuHggD8lCpArPJJ5IpOubngK2svWx02lQ=;
        b=8B1cAmbFgSCVlrR7L97wgyPWfraAwCcl94uoCohLf9VaZGjm45r9xaHMNOB+0lJKVs
         KN1qIHPo603brzm2Qfrx6Je9vQ8fCe1kLiulJaCFH3+lCbpXlg1IUH9vrBTlL27R9x0B
         gW78JGDRjogBIxBiFyOjOH7dBslaEDJquZrWT5ceBoRu0vLpsl+okxZDQjIgfXbXdOPT
         VZ/NnDd6AqGMspwm7/y9LnkabB3AhJgxL3qbnxQkLDCxMecPjU9N1AaPfrbcUmBt5rTS
         kPFoBivru0reqGTOMM63lrA8DbETE8tgtnfeGw+buinLneESDBBhu9LY5yeLs+srdMWd
         aNug==
X-Gm-Message-State: AOAM531BidQxWtNZhWc6PX9kmnZSX2UAtTirnI7pYiZtAu5SUw8y7UGo
        KwjTgpOGWUq8HIvrbvXhFrA=
X-Google-Smtp-Source: ABdhPJw7TpbkoJjjIzuf9JRLMOfAFG7IT/pJsuGvBTt/+ytwkt1aAscraFP3VwvG1npKfFYLTGlL0A==
X-Received: by 2002:a17:906:114f:: with SMTP id i15mr34995716eja.136.1634132899435;
        Wed, 13 Oct 2021 06:48:19 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id r3sm7830270edo.59.2021.10.13.06.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 06:48:19 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: ab/parse-options-cleanup
Date:   Wed, 13 Oct 2021 15:47:00 +0200
References: <xmqqv9239k15.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <xmqqv9239k15.fsf@gitster.g>
Message-ID: <87tuhlghnh.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 11 2021, Junio C Hamano wrote:

> * ab/parse-options-cleanup (2021-10-08) 10 commits
>  - parse-options: change OPT_{SHORT,UNSET} to an enum
>  - parse-options tests: test optname() output
>  - parse-options.[ch]: make opt{bug,name}() "static"
>  - commit-graph: stop using optname()
>  - parse-options.c: move optname() earlier in the file
>  - parse-options.h: make the "flags" in "struct option" an enum
>  - parse-options.c: use exhaustive "case" arms for "enum parse_opt_result"
>  - parse-options.[ch]: consistently use "enum parse_opt_result"
>  - parse-options.[ch]: consistently use "enum parse_opt_flags"
>  - parse-options.h: move PARSE_OPT_SHELL_EVAL between enums
>
>  Random changes to parse-options implementation.
>
>  Will merge to 'next'?

Yes, I think the v3 re-roll I've got addressed your concerns about enum
patterns, and I've got some meaningful (with a very negative diffstat)
changes waiting on it.

https://lore.kernel.org/git/cover-v3-00.10-00000000000-20211008T190536Z-avarab@gmail.com/

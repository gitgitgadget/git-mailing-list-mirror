Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F85C433EF
	for <git@archiver.kernel.org>; Sat, 26 Mar 2022 16:10:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233778AbiCZQML (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Mar 2022 12:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbiCZQMK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Mar 2022 12:12:10 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6026B224521
        for <git@vger.kernel.org>; Sat, 26 Mar 2022 09:10:33 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id bi12so20782333ejb.3
        for <git@vger.kernel.org>; Sat, 26 Mar 2022 09:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=f7GkXpsRYFjwApDUIr8VSAol8UtBNzybUF7KNC3GwMw=;
        b=i7XtydFbYeWHfVUV9ZOc/dVFdxd6ZBzZ/3vvjP1Dtu3G3fRLXuPZ+x5PO9X/EdJ9Kw
         PtjQfGkG2PdK1sNO0cj0BJc9ugBM6yMmKVnPl/a0A0jc5WRv1nticGwNJM24JVi6/GDB
         2eAPv5zwYACf/rItahYGUbAhe43KxEfiFjlzDZAqF7U5r0y+I8tnxE6ZXKpxEIRsfE9A
         xBPErCGd3+mE0JnGtvnffUYaYUZDXdsurZKfUa6C+rpKE0rE7ypA0nMj0eMIzJyDzWxw
         GQx2w+TJF7JhdSJclKZvWagEAy6BEiwjgxRk03+5dYx9V8N4rVXBolKlSqnsi+BTr9wB
         V8PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=f7GkXpsRYFjwApDUIr8VSAol8UtBNzybUF7KNC3GwMw=;
        b=fdwBuKIs0SpkJQOihxCIQxMRAdGDeBbDzOghgdX6T4nLW35akEdVOT1lhifsCtz6rZ
         83wHzlCK1V4YC7r3meDQWEyOfHdopqEPltIXbY+vt5GN2I3ExJfN0p2TjVZI6XHvbk+W
         wKywhIEh/Dm77otW91ilHauy1jxUWiTo+31DHprC7nMoLyNOgTgKEYEuw6qsKc0sZSDc
         joxP7rE249m5Covx4htmRGP2txHVEaoL7qX4kuw7AtZO3PYZpycqMCa8HmPtM+EqbWaI
         W9eeqb1Ad4PgZ2vT6xKgTwNiU9KA/PnRcRqYRZybY/RL6nRzFLXYWtonhZJUh2DxPATw
         BmpQ==
X-Gm-Message-State: AOAM5325OJBg3ags9d7Ax5SOqLnLB2hbm7O81sEVpAHCF4mJGluD441R
        ZehdRUGxuRiL04ca3si3fB7JGYeF3yAxeQ==
X-Google-Smtp-Source: ABdhPJxa+gtUsHnywTULN8JLIMd86j+M6/sLoaMxTJicH0iIUkQ/ISc6VoKbKzGlOqc08l8tbgNPOw==
X-Received: by 2002:a17:906:7307:b0:6da:92e1:9c83 with SMTP id di7-20020a170906730700b006da92e19c83mr18124072ejc.459.1648311031744;
        Sat, 26 Mar 2022 09:10:31 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id w14-20020a170906d20e00b006cee22553f7sm3706239ejz.213.2022.03.26.09.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Mar 2022 09:10:31 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nY8zm-002Uok-8F;
        Sat, 26 Mar 2022 17:10:30 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Fernando Ramos <greenfoo@u92.eu>
Subject: fr/vimdiff-layout (was: What's cooking in git.git (Mar 2022, #05;
 Wed, 23))
Date:   Sat, 26 Mar 2022 17:05:58 +0100
References: <xmqqwngkm4am.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.10
In-reply-to: <xmqqwngkm4am.fsf@gitster.g>
Message-ID: <220326.86k0cgk83t.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 23 2022, Junio C Hamano wrote:

> * fr/vimdiff-layout (2022-03-23) 3 commits
>  - vimdiff: integrate layout tests in the unit tests framework ('t' folder)
>  - vimdiff: add tool documentation
>  - vimdiff: new implementation with layout support
>
>  Reimplement "vimdiff[123]" mergetool drivers with a more generic
>  layout mechanism.
>
>  Will merge to 'next'?
>  source: <20220319091141.4911-1-greenfoo@u92.eu>

It looks like it's emitting a new warning from the "Makefile" in
check-docs:
	
	$ (make clean && make check-docs) >/dev/null 2>&1; make check-docs
	make -C Documentation lint-docs
	make[1]: Entering directory '/home/avar/g/git/Documentation'
	make[1]: Nothing to be done for 'lint-docs'.
	make[1]: Leaving directory '/home/avar/g/git/Documentation'
	removed but documented: git-difftool--vimdiff
	removed but documented: git-mergetool--vimdiff
	removed but documented: git-version

Re https://lore.kernel.org/git/87o88i2keu.fsf@evledraar.gmail.com/ I
haven't checked if this is the same case of a thing we should just
ignore, or if it's raising an actual issue this time.

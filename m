Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 501CEC00140
	for <git@archiver.kernel.org>; Sun, 21 Aug 2022 13:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiHUNcN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Aug 2022 09:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiHUNcM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Aug 2022 09:32:12 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A5F20BFE
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 06:32:11 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id w19so16678192ejc.7
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 06:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc;
        bh=iTu+sikzN3rmzIaMbRVyT8yLSNNYuQzNFoevkhbzfug=;
        b=nXVurVrbjyrDRr6y5iRhb7mhQyCRrRfvDTsokl+kcYZnqC3h5V+5LjgRgHDpOWLchR
         y9RcSZ5kN9FbiUp0QHKzrGxu4hWJUkJNNhKM3cCAnWGErn7NCo8QYkjpEPHhqJuRzjd5
         cbpWb/4dvKFRHGadxmaBfFBAwM3aEnU2rrEX0bKhJyILLAfU8XMmxdMZ0RPF2EEHqUwS
         3q2GY+g0n/4wPJL23kFqlZDobh3DOkKEGbJR6df9oCdwVUZ2hGAHUyRVTQVi6jGCZmbp
         7HOkLxEMsvshAZ4VZUVGOfN7/sgqpuzCRQj4tzu6QtzBR52/0Vbz6WK+WFTkUKtQHXi5
         cMFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=iTu+sikzN3rmzIaMbRVyT8yLSNNYuQzNFoevkhbzfug=;
        b=DUX4n0rAR1tXrX1uNOJA4teLb9Nl6rvpihMek4SK2G+GHdpFPZM8ohrvwg0d2wncVl
         ZalQa6xpBIb0/pQfx5z7emdBWbzzsW05wCG/tWRcr+8QEXD+4hHJf0GqS7tRAexFuaHU
         XPNonR1yZRq7MPKxpSikwiOHQneRYAxmKEmAbYJSCIjWS+ZU7PQ0ICvEJnTSNC522JfZ
         eeUDLON3d+BrpXCF9OpLMZfgga5KWaUkMXPihdKnWVPvZf+n11xJRpBJLtMu7AhsPUt3
         aBy4GW4wjih+oyy7U6vUcq8dbSFTdqm2I7Viu0AyU8Zf6ofQhESMTQ6Jv0odHOd/TsBo
         +LqQ==
X-Gm-Message-State: ACgBeo1bSBlloPA+fKES+6C/tGlNhuSXCqz8o4RvbA+pqpjNGU2ZLdwo
        xmpxiWvGnkYVJnB3SsjsJwE=
X-Google-Smtp-Source: AA6agR67kO/y8JDDT6/2bIdb6WmZ5LFrTvTPQ4ZO1MEwTw0waBiVqpwgiW3haNZNxCufc9ozW1G5Lg==
X-Received: by 2002:a17:906:ef90:b0:730:9cd8:56d7 with SMTP id ze16-20020a170906ef9000b007309cd856d7mr9548810ejb.94.1661088730165;
        Sun, 21 Aug 2022 06:32:10 -0700 (PDT)
Received: from gmgdl ([213.220.124.15])
        by smtp.gmail.com with ESMTPSA id r1-20020aa7cb81000000b0043bd2a79311sm6447558edt.37.2022.08.21.06.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 06:32:09 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oPl3Z-0018hD-20;
        Sun, 21 Aug 2022 15:32:01 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Teng Long <dyroneteng@gmail.com>
Subject: tl/trace2-config-scope (was: What's cooking in git.git (Aug 2022,
 #07; Fri, 19))
Date:   Sun, 21 Aug 2022 15:30:56 +0200
References: <xmqqbksfirfm.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqbksfirfm.fsf@gitster.g>
Message-ID: <220821.86mtbx4t9s.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Aug 19 2022, Junio C Hamano wrote:

> * tl/trace2-config-scope (2022-08-11) 2 commits
>  - tr2: shows scope unconditionally in addition to key-value pair
>  - api-trace2.txt: print config key-value pair
>
>  Tweak trace2 output about configuration variables.
>
>  Will merge to 'next'?
>  source: <cover.1660272404.git.dyroneteng@gmail.com>

This looks good to me, sorry about the late ack. I see the v2 has been
hanging on my comment on whether the v1 responded to my feedback or not,
sorry.

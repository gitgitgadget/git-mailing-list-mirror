Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2306BC6FA82
	for <git@archiver.kernel.org>; Fri,  2 Sep 2022 18:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbiIBSpI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Sep 2022 14:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbiIBSpE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2022 14:45:04 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D320E48EA0
        for <git@vger.kernel.org>; Fri,  2 Sep 2022 11:45:00 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id h188so2648845pgc.12
        for <git@vger.kernel.org>; Fri, 02 Sep 2022 11:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=45tyYYEtPQoCJuCMrEDzlEcrJcMqpzGk28Zex2uda5c=;
        b=PmGWfTCVOgfZYwoWU/GYEAGEQJ2TpJb3hb+5ydToEOsVzAWRezZ1xQ+fJb/fIwsgxY
         IKW6IVSrfMAMVLlRTc2aiQB/XSCidFovfPoSVj9wlrvVEbQ9esS3fJXG20UsjsITqQNP
         v5lAez6Pvf7RuCEwjnl2y8qkrcskZf6+XY66+hCVGgsVXtWvH2iFkQuQ/7PiSDJeAIUd
         l8PMooKcG8CWszAgI5aaratrWsHwxgsIVzhLTWJhcoqWfeI36BaczlJT12L0HZYOLZQd
         h/m+3v4/qJZfDIlVliGmTyIzNcEzmqBL/6233J04BwNdKbTEPmGgUQJva1l5qyF5Ouxg
         mNOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date;
        bh=45tyYYEtPQoCJuCMrEDzlEcrJcMqpzGk28Zex2uda5c=;
        b=MpSXOvOBqF2j8it7igP49416jwKQ5QxjjAERmB/ghkK65Dui62vPRPJtCieAAZJH9w
         Qj1H/lzgYKlB1EsZDFEluxPSBWQEdwgfyvw0jCq3KfjQN6+Cla9seL7CbA6TLJgdK0JY
         nEQML5/xkc2cblZtlCmit+sAPgpZ9NA4lon//BUIvgd5tkp3QaRwJud0a1H14eVD0/pl
         a0BF3eFjU8cuZcTXMKEPiSIrK3uNsgig1ACJLmH0+z44oTabW7FkIR25cAovYehhY78A
         LIJrD9yIDZZDtbE1LZ8UwQOq5jeFEFWPsBD8D0fepaAHrrV8khpTk51KaqiWAT2FcstZ
         HVSA==
X-Gm-Message-State: ACgBeo3LOlt6hFXI5gfY03r9rJjRDuyNh05DtnBuoPiBEV5I+yLM65B3
        LsJHFQ4r9/aMC2YXCfuzY0M=
X-Google-Smtp-Source: AA6agR5ME3gHisAeoIc9jQc2ka0IbZHvntzD6SN0KngE6gKLjBNGpgLsW7N3ePaROVXdnuK+LxF+2Q==
X-Received: by 2002:a63:334f:0:b0:42b:15a6:826a with SMTP id z76-20020a63334f000000b0042b15a6826amr31255488pgz.14.1662144300223;
        Fri, 02 Sep 2022 11:45:00 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id p129-20020a622987000000b0052e6d5ee183sm2158790pfp.129.2022.09.02.11.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 11:44:59 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>
Subject: Re: several messages
References: <pull.1322.git.git.1661992197.gitgitgadget@gmail.com>
        <f5dbcbf78db127d738c11a1aca416201298426cf.1661992197.git.gitgitgadget@gmail.com>
        <9on60586-rr40-onn0-907s-53816r61qn07@tzk.qr>
        <CAPig+cRCME=SYyV2bDNoAJjdnHUAWUqSP00aO_v-KWdNvasKpA@mail.gmail.com>
        <YxJMzMyjGCyp/b4w@coredump.intra.peff.net>
Date:   Fri, 02 Sep 2022 11:44:59 -0700
In-Reply-To: <YxJMzMyjGCyp/b4w@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 2 Sep 2022 14:34:52 -0400")
Message-ID: <xmqq5yi58vkk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Thanks for this response and especially the links. My initial gut
> response was similar to Dscho's. Which is not surprising, because it
> apparently was also my initial response to chainlint.sed back then. ;)
>
> But I do think that chainlint.sed has proven itself to be both useful
> and not much of a maintenance burden. My only real complaint was the
> additional runtime in a few corner cases, and that is exactly what
> you're addressing here.

I have nothing to add to the above ;-)  Thanks all (including Dscho
who made us be more explicit in pros-and-cons).



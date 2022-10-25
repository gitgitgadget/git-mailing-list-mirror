Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 180FCC38A2D
	for <git@archiver.kernel.org>; Tue, 25 Oct 2022 09:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbiJYJrn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Oct 2022 05:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbiJYJrl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2022 05:47:41 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC3611F4BF
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 02:47:39 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id n12so5674741eja.11
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 02:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xLCdIqxUq5w9AnmU0W4IHnCBNxtP3N8dL4F2s93KWqM=;
        b=LB29BcuaCbFZYmEONSpJ+NaA6L0xubVvEoTm91aboMKJN4gkKKYt5L2jsJbWNDubvO
         mPbtWJp9ZnWaBRiEyXWi0siREVyGSBQ97Q/TkLvUKkg7brA/t2r2GHXcErJkR3JmcxO9
         ql4nojt9UYLcMCm++gSM6/18ejnzTBftLOXoMP5xaZAkQuIhW/I7RQpQrG5ZLeT5W00C
         sVGuh/9YdoJ7hw48uAE59yT8hgdbudP38GITZHbB9HPGHLtekXFKp2Siuwc5gjsuRw/6
         TiYQKhLHEdas1Ne+3b5uy8deuvVsUz4pumLCQnVt+1orc7hwlF8zJImDjWQd2J/9WSfx
         u0Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xLCdIqxUq5w9AnmU0W4IHnCBNxtP3N8dL4F2s93KWqM=;
        b=qiBAjDduSVFw5+CcHctmxPxHzuG4O5SXl+BXwTynMvCuJ5GaJM295zhZhDqxCTdkfi
         B3l327NPTmPotrh/MgZ51clXAGXdD6CU9nUT7k97qspeTdyTh+eI5gU0CnFko9Lrjguu
         Er6v0z/wBqd2oWmr5RnzlrBrEwTx3do2Feb6ygnwzrwqduxblkEpQfd9nngTgV3Pxe2k
         3uSMsZuojO3KHn6glUfFXCAOIWLeJ0A5LkVIGMJgAVpj/aeRlro+kuGxHAb06Va+Ap9l
         edOXN1ip6kvWH4bjxmTMXmMILx/40etE/aSfkqdlYvnOSCiFy0mmQVgVtQNjUudU+s3x
         KRvw==
X-Gm-Message-State: ACrzQf2hRtJ3oAZ0+J6MmTqv028R77YucqCqa86MoS317PD0J9Dm81eR
        FTS9ImlajQ/qBu62gvwXkdj5jwtbxc8=
X-Google-Smtp-Source: AMsMyM51r1Bwm09ARRsMMBd/UXo0Q4gG/DCpMx4YUfg3CoCCJnLqBOBPizIy7IJ9rQCyyabiqi8F+Q==
X-Received: by 2002:a17:907:6d23:b0:78d:8f0f:1266 with SMTP id sa35-20020a1709076d2300b0078d8f0f1266mr32169926ejc.762.1666691258313;
        Tue, 25 Oct 2022 02:47:38 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id lb12-20020a170907784c00b0078246b1360fsm1095675ejc.131.2022.10.25.02.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 02:47:37 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1onGX2-007uCU-2J;
        Tue, 25 Oct 2022 11:47:36 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 2/2] fsck: document msg-id
Date:   Tue, 25 Oct 2022 11:41:50 +0200
References: <pull.1369.git.git.1666623639.gitgitgadget@gmail.com>
 <3aec3d2c9ca65a37a367c3a7c9081bbd4cd44ae0.1666623639.git.gitgitgadget@gmail.com>
 <xmqq8rl5t9ca.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <xmqq8rl5t9ca.fsf@gitster.g>
Message-ID: <221025.86wn8ock07.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 24 2022, Junio C Hamano wrote:

> "John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> I almost suggested to extend the FOREACH_FSCK_MSG_ID() definition in
> fsck.h so that fsck-msgids.txt gets auto-generated (what is missing
> in fsck.h that prevents us from doing so is the textual explanation
> you added in the new file in your patch---they could come from
> comments on the same line, for example, and can be extracted via a
> Perl or sed script at build time).

I think this is the best eventual approach, whether we want it now is
another matter...

> I do not know if it is a good
> idea, especially if we forsee a future in which we may be
> translating the documentation, so decided against making such a
> suggestion.

...I just wanted to point out that difficulty of translating such a
thing should not be a reason to hold that back, because it's not hard to
translate such an arrangement.

We'd just point the po-doc extraction at the generated *.txt, we'd need
to re-arrange the Makefile dependencies a bit, but it shouldn't be a
problem.

The *.pot-file generation is a step that only the translation
coordinator *needs* to run, so even if it's a manual procedure, or
requires first building the sources...

> But at least, we could _lint_ the manually curated fsck-msgids.txt
> using what is in fsck.h to see if a new MSG_ID added to fsck.h is
> missing from the doc, or a MSG_ID whose default severity is updated
> in fsck.h is stale in the doc, etc.  That can be left for the future
> updates, but we should at least instruct developers to keep them in
> sync in fsck.h by adding a comment.

Yeah, that's a good step.

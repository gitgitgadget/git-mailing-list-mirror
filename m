Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82CABC433ED
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 11:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30DC0611CD
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 11:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbhDOLlU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Apr 2021 07:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbhDOLlT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Apr 2021 07:41:19 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6616DC061574
        for <git@vger.kernel.org>; Thu, 15 Apr 2021 04:40:56 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id j12so2625321edy.3
        for <git@vger.kernel.org>; Thu, 15 Apr 2021 04:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=0L80m1Z1Q/v64C6SW4on0wSBzm0Qf1mnNW6IuAVnFZQ=;
        b=OxJPywHtuKQzvROEcRPWR47h4RTYWcNYK47ZsdIeh85Uq6/Y6b3TW+Cd+PsADH3deq
         0yc5KhJdzP2z/KthAixW35742ueeOlHExlrPk2KC8/hELcaKEmQ/JqXxjLwcQU7ONcvk
         HttJagUPGBQhcN0tjQPxi3V9EKc9qJP8FDB5mhuT/9XdBAmUt492XZzZ7MSY4nAYqN5B
         9j/yfVde02+4sHsjgtOFhRAXDLvySRUfiuz85Qp9rEi6lj5J6eiNIEju8xtKrAKNQeFv
         zs8bQbu8XvJ3Tfz585RT80wFu0h+7+4PhZBxf4PBmlCtOzQBfdSh0gIJmsjG2icZEv1m
         8XiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=0L80m1Z1Q/v64C6SW4on0wSBzm0Qf1mnNW6IuAVnFZQ=;
        b=Fzc4CE7CN+SLpiddq2+9HnQta5HBZ5p/CSv4uoAEjxPiPfSDk2vkBuhtAjYpXlDNfx
         u3knbYlIkFE6FykYSSMgTkctO6gdFBLlYUbnvM18+v0sKab/c9Bg0pwpiZjKuePCXuZR
         Kb+62i16VGfK5jkFxh1EbwqJc+0UF9mrLiJwFV+RuVbUb/dblAAU1mADPoks5jTgDxzb
         SMGVH7EhyE3ECa7s9eA5cwWNfGjuH5Lr114BqM0i2tit2mNr0hnl0hEy1UrxVEM47+c+
         n6inRqP+MwpcgK+ym/5QEKhORHJH4fjkK6/elmy9bou57XRQLSe5EpAzfzXZ98uN2YkV
         +udA==
X-Gm-Message-State: AOAM531M6uJsVS9pDMTBPJBSNf3hwVkB1zGW6WjUoOn+uIynshen+72a
        TDXaFWrXnquFBwhdGn+Fcaq9cqFdyv4=
X-Google-Smtp-Source: ABdhPJyJwJRkadHgM/5COBtkeOo7lqKru/5cWXvGTTxZrj4WycQZL6YTVAYo4yVx6Mv1+sfliQZhWg==
X-Received: by 2002:aa7:da46:: with SMTP id w6mr3766907eds.30.1618486854576;
        Thu, 15 Apr 2021 04:40:54 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id b8sm2313491edu.41.2021.04.15.04.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 04:40:53 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 12/16] test-lib: modernize test_create_repo() function
References: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com>
 <patch-12.16-424caad189f-20210412T110456Z-avarab@gmail.com>
 <xmqqk0p7cnhv.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <xmqqk0p7cnhv.fsf@gitster.g>
Date:   Thu, 15 Apr 2021 13:40:53 +0200
Message-ID: <875z0nvkqi.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Apr 12 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>>  4. We don't need to move .git/hooks out of the way.
>
> It might be unsafe to assume that we'd never have an
> 'enabled-by-default' hook in blt/ template directory forever,
> though.

I would think that if we injected run-by-default hooks into the
top-level repo creation any such breakage in the test suite would be a
feature, i.e. we'd want to see and adjust for the breakage, because
surely the same sort of breakage would occur in the wild.

FWIW I've got some WIP local patches for the "just ship a README in
hooks/":
https://lore.kernel.org/git/20180601070609.GC15578@sigill.intra.peff.net/

From memory the cumultive footprint of foot a -d run on the whole test
suite is on the order of ~1GB, and ~100MB is just the hooks over and
over again...

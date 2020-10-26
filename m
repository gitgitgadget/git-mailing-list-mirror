Return-Path: <SRS0=PD7l=EB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7054C4363A
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 22:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E8D320706
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 22:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SdGa602f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391717AbgJZWCl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 18:02:41 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41228 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391677AbgJZWCl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 18:02:41 -0400
Received: by mail-oi1-f193.google.com with SMTP id k65so11517319oih.8
        for <git@vger.kernel.org>; Mon, 26 Oct 2020 15:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BlgQXWrHNLSDJHDOn9MlKKnjyPdLBjtkPv7aHzNlhdQ=;
        b=SdGa602fm41kvIzp3WHokCth3dCp4Fj8biwykKKN8uLbNtKP2586xCQ8J2rShakcj3
         FbVxNmLWpy4NeUDrv7R2pYz/twn86xkcr1/uQJiK4vjoOKxhhZJ7VP0sKOyh29KbTvlx
         MnV/lJxciPYqSJ3kkzi9bIt9dcGUM8ivpVtDhUOGHEObucbn30w/Q60vakkvoiBp+sJQ
         ABtIjVsMu361CUbB4gG7zxsRNwCaxnXjgqNP0pNCWgghxNr2tibAZ72v20+wRyZe9GsE
         XOM31TwqjpEXu9yJ54NdeK9HfdA75J3gBJ1mOZIJQBzdtN1fVxUuXzdcCTEdM31Jvjp5
         STQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BlgQXWrHNLSDJHDOn9MlKKnjyPdLBjtkPv7aHzNlhdQ=;
        b=W7zaMyVSXI9lhD8TjduUTKvETBrKWFSGkjJXPixviPEYRbrQx2PEz/bQiTB0CtBRq6
         L/b1ugL0EJrQgQYfqUjDnYqKABAea2jUbu0vuXRGccKYPJWIRqFyVC6NDEabjej61bh0
         YSlPgWWQjnIVcDa5Vw3OhBLwyxwpYqi8DmDtYAvLn3Ndaveg+uXJgCFW3t4LaTJZmHuo
         U4Np6vCvy7GTa6DgdHRUVtxEeIItw2RVAeHj5f9melL278mYC4CnbH3TfyF4NLVHePZ/
         al/Bnoui1UPokhYNEldP0TZ4K+s2IAGYgM6sZBzQiNIDQ1VR5/JPbN2s1hwMaD4//jj1
         7Jvw==
X-Gm-Message-State: AOAM533PQFq9exlqtbFD6TUV1hVhFuFD/Iiefmx73Vqjagtbdtsr+3RQ
        v+L15uduSRId1FydMo6S3IU7kIxhtPxuZWS6sqo=
X-Google-Smtp-Source: ABdhPJzx/G3mWb4bNkoLV/95q6KWoL25gZd9bZofvlInnRLdNLVCRzn01aFtoWPJVJ3dsarX7YBsCRZ+xdb2MUryp0s=
X-Received: by 2002:aca:d444:: with SMTP id l65mr11842236oig.29.1603749760258;
 Mon, 26 Oct 2020 15:02:40 -0700 (PDT)
MIME-Version: 1.0
References: <pull.772.git.1603740773.gitgitgadget@gmail.com>
 <79cc61f56adf7769521d2e2ba4c27c1a3bbc1d76.1603740773.git.gitgitgadget@gmail.com>
 <xmqq1rhkellz.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq1rhkellz.fsf@gitster.c.googlers.com>
From:   Nipunn Koorapati <nipunn1313@gmail.com>
Date:   Mon, 26 Oct 2020 22:02:29 +0000
Message-ID: <CAN8Z4-UXzPueBEyqt=uw1Y-Cd-eguq+8CW5HgqUAkFYtFX3B+g@mail.gmail.com>
Subject: Re: [PATCH 03/10] t/perf/fsmonitor: improve error message if typoing
 hook name
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Nipunn Koorapati via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Nipunn Koorapati <nipunn@dropbox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I usually do not review or write t/perf/, but is test_must_be_empty
> available to you at this point?

Everything in test-lib should be available - so yes! I can try it out
and switch to it in the next roll of this patch series. I did not
realize this helper was available. Thank you.
--Nipunn

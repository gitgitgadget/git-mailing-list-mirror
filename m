Return-Path: <SRS0=aR3Y=3R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A093C33C9E
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 10:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0E782467E
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 10:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAaLRWjo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbgA1KlD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jan 2020 05:41:03 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44077 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbgA1KlD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jan 2020 05:41:03 -0500
Received: by mail-ed1-f66.google.com with SMTP id g19so9875997eds.11
        for <git@vger.kernel.org>; Tue, 28 Jan 2020 02:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pddv2JzaIZpfZjjhKuygN8aAmvyW5rnR4K5ppApHkIM=;
        b=TAaLRWjojk9oBRt1YOqvjGCHdZ+3xVQzCmS2PUvfjagQIFPgdxnJw3xp9rwVepSTBM
         VGZQmgyuUNW5H9nRN+aD4H0HuRf0g42TVokFgDPgXE7+1HDLeof/tUaOPtS8Z2cbaF7Z
         07D+ey8/fvRCqDXsKJ5aDjZJvUNlLB2PXMhCyI22wNn1yuRqOeMkZfJNYacvQqRuIsgO
         Aefd8a9wY8c83kCfmpDXGlMvNAxDCWUnxxvRufhi/fHi74y4HJPUkXWVVYNMzQuoy+F+
         18tBjZi3D3Vn2pK9ScNF1kFR94JccN9nWShr6SvfxRDqpb8Yl4qpPhyDx29squvaCzjw
         VP3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pddv2JzaIZpfZjjhKuygN8aAmvyW5rnR4K5ppApHkIM=;
        b=GAcs6bhRMc4Nop0k5QAPctijkDXlKTkh5ZjBXmoKocRtDh5wZc85ZyxFZA5uwF5w3s
         /x/H6YEaY30xAIEOTWWUp5bYuWCT83WtaDVqyVQI2+EHQ09/SoK5ePJVLQavONmI6C9N
         UY1dsfzGVbxDl2wy6lhR87Dxihd6Dni0cdqzWYa2XdUGNEL6/ArPRqqFgBJzBtGVQha0
         7OafZbIeqh5DClFKItzPxGR68m1ZtdicDkMHdlfenbDZHcaChrNS/uwir2cHAX2zRsmC
         vRroBaUP6pd+G5YXEeKj3HrYJDDPCSAi2Z0p89eAKErlUMJVnNB8YOBYVcbCGoQeTnN4
         wHog==
X-Gm-Message-State: APjAAAVew41rg3aSHkQ2NJShM6IX4Jv40XdgTSw34lL/FJkQwvgiKtIY
        1340Dl85r/x+4zHkvYXVv1DBZfycImEjXqdWBLA=
X-Google-Smtp-Source: APXvYqwfPRio9mTTGPnmLACmhgMBh4Yl36+P175asB3uFbLsIrGJbfavhUcHZomhxPkkV53mB14Wi43jTLR7pbfwC/U=
X-Received: by 2002:a50:ce56:: with SMTP id k22mr2788969edj.34.1580208061355;
 Tue, 28 Jan 2020 02:41:01 -0800 (PST)
MIME-Version: 1.0
References: <pull.537.git.1579745811615.gitgitgadget@gmail.com>
 <pull.537.v2.git.1580091855792.gitgitgadget@gmail.com> <b494114d-02ef-599f-4fa0-d7614974a130@kdbg.org>
 <CACg5j24TNczbZZ3u0UR_MYQgeWk8HRY-cxc3N8HX=v-Tx0vi3A@mail.gmail.com> <20200128073340.GA564804@coredump.intra.peff.net>
In-Reply-To: <20200128073340.GA564804@coredump.intra.peff.net>
From:   Heba Waly <heba.waly@gmail.com>
Date:   Tue, 28 Jan 2020 23:40:50 +1300
Message-ID: <CACg5j27fEEwL0yHhYcX=UB-W-iWkd587OCkSE1vvbcfSurxGXA@mail.gmail.com>
Subject: Re: [PATCH v2] git: update documentation for --git-dir
To:     Jeff King <peff@peff.net>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 28, 2020 at 8:33 PM Jeff King <peff@peff.net> wrote:
>
> One tool that might help as you do documentation patches: there's a
> doc-diff script that shows the rendered differences.
>
> Try:
>
>   cd Documentation
>   ./doc-diff HEAD^ HEAD
>
> (on a branch with your patch at the tip). It was originally written to
> investigate changes to the markup, etc, but I find it's useful just for
> looking at any documentation patch, because it takes you right to the
> part that changed. :)
>

Nice, thank you for the tip :)

Heba

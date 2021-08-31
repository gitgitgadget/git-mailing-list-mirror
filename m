Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5838C432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 18:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BAF860FD8
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 18:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235551AbhHaSCV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 14:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbhHaSCV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 14:02:21 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037C6C061575
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 11:01:25 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id a66so188784qkc.1
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 11:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M0uXDDogYrwBOHbxXnGyqB7fGc90bb2o4EvKmHkpDXg=;
        b=fwWnySR91QAeT6Gevcl55Fmu6c8IdGI9Gfff72Mv8AqAR61+bkKqAe1dBJoegXxsRk
         hQEJBhpdFeu/0DORaPE2m9/x7zETz4SG5JBzcIBoHlyCGqnERr6VvokjQFAkulpySNOM
         TxRuiM9UDDqtqPh0tImesOUn9A6OievHUGmZbUvY6qbBDbguWOkPYmdCHl2MKg/9kJqM
         hN5MRJB6CijgsKUGiKR6Df44gbuwgN935KOOP/PkNOremPZm2zgCbWdNL0rVdBUGec+S
         5vsFcaTUDH46s18T6HYtbPZ8SWqMTPTPU3OAFCQrTp27eRAu5L8nC43JKS9UpalJSORr
         kLrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M0uXDDogYrwBOHbxXnGyqB7fGc90bb2o4EvKmHkpDXg=;
        b=A1HLLZU882hCsGYA1GR5mR84+qKpaj3pELYyTWw/LO57riLy3GYxJ9ae1qW8RJM2sU
         AaG2TlJDpwVyIguRUD1oa3VVvEtwY0xg2u0nqHSGQgchhxbaNTyk0psOcTq89OSSl+vJ
         4T2M/pvVW67IlOJSnoqEu8TMH5SuuPOsreUTPLJk5r153r/TkLup08MsvSxxcRLEXeHS
         SbQO7P7iQa6FgSJM3uwmk9evgbG2ACLYuoLv2sBs06g7byJTcxzBBn69bzM1Azh0WHqt
         9SD5qisHp70g0vtKHyzwkHI+Hs+ihU2RorvdgkuFFeYKMQWCycLhanJeXGFtja0yp02Z
         HcBw==
X-Gm-Message-State: AOAM530KzFDl4CC91oh3HXsH7aTB6Dtv1pKTrFVqVK7xY7lgpdX+YAqU
        G4e4sWd19xg8rF1UP4oyZs8zSJoFA76uhpSXarZzY79hQKs=
X-Google-Smtp-Source: ABdhPJwUKt8lX1G49pNjr91hLutW13uxLbXcTHXXHInS2u/6ybM3Ke7QCbPsPHvq30tsHl4H7RSHP/eL0wtHUTw363Y=
X-Received: by 2002:a37:8a86:: with SMTP id m128mr4259122qkd.319.1630432885115;
 Tue, 31 Aug 2021 11:01:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAHBARKezrkKAs0ACbJ_fnxR-qWacQ5KKuVLwn0WyT7aR+4++pQ@mail.gmail.com>
 <xmqq4kb5v6p1.fsf@gitster.g>
In-Reply-To: <xmqq4kb5v6p1.fsf@gitster.g>
From:   Andrew Thorp <andrew.thorp.dev@gmail.com>
Date:   Tue, 31 Aug 2021 14:01:14 -0400
Message-ID: <CAHBARKfLC0ie4p=xWk+xDbEH72fSF6qeWCf=9oOTH6M9V1Qh=A@mail.gmail.com>
Subject: Re: BUG: `git commit` adding unstaged chunks of files to commits on 2.33.0
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> How was the last "commit the changes" done exactly?

So far I have confirmed this error occurs when running `git commit -m "foo"`,
`git commit`, and `git commit --amend`.

Return-Path: <SRS0=DNff=2R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E92E1C2D0C6
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 15:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B097220882
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 15:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VIjqeM4+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfL0Pwd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Dec 2019 10:52:33 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35464 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbfL0Pwd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Dec 2019 10:52:33 -0500
Received: by mail-ot1-f68.google.com with SMTP id k16so32219227otb.2
        for <git@vger.kernel.org>; Fri, 27 Dec 2019 07:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B6pY3M4fVoA36hhXjYBTU2qpkVjTjJ9zkC6Vm5mB1g0=;
        b=VIjqeM4+q+juGPocIm9ulOnOev+jDUEdZ857koaa/xd58MVFCGsqQb2FgEvKi40nYk
         T9VFUQU82XVEecaDGMRV10Q0fH/D2ba16m1ACJURzGVMTHrxrp83UWx5eptdn5eneTUe
         ZpOuYSPu/A6uW1pLB9yCBLgteNF88dhNh8hiW2B0mNoLFMpcdtGt/JAWneK614qqVDnO
         69k2raO9D0XnIIxBNBaBfG64M41rv1kAZWaABuHxFRyNdkhQBzUMW85PkLSZypQEQxWp
         Gg50u+XsKlB2R4aCS76mb57wYEemtobDl1npvd/6SXvCS+3io02U19P8R28e4c4afrCz
         nP6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B6pY3M4fVoA36hhXjYBTU2qpkVjTjJ9zkC6Vm5mB1g0=;
        b=J/Sds9VIYrc953wVjiIMccUfFeSGI2U//hlHrp0oBiuaEKML4cIlURcyJY9BQKp1oL
         cFejzDXHhtQdjou8I6PQEV0/ksDQN+x8HKsGmC09L5BQWfYdrOcd6BhL/w5YZUE++Xct
         uquFHMLwfQGfn8P9O2Wdj2X6GAFyxH84Ut4FZR1IXuJhB35RG+WBLCARMQLoRnT8Frlk
         ZwEC0a7AoJ08Xm9DO//t2OYeHt+dk3oBYSkutOebUhJmLVulXN87k4X4v/HX7MLMUQvZ
         2T9rJWLHGXGdSKAQijXTarba8YdsZwkCDtBCsbRLnSBUWsCzGMykJlXKwdKM8FDqscKQ
         BrRw==
X-Gm-Message-State: APjAAAVsAo63Blc7YLCfFd7CwGg0icDJW0wHazyAW144F5qobv++q1Bf
        svtNhByeglsI4r6UJl3q/sXhL1rVhKu+biBsh+E=
X-Google-Smtp-Source: APXvYqw7j0kkJ2VhTlKT/ldifatYYBPmRhnyte5if0T/GXkfiflu2IRvGPS6CC4E07vTcBL2YZa/DEZgXLbZFhSM9Xw=
X-Received: by 2002:a9d:7d81:: with SMTP id j1mr52705098otn.267.1577461952226;
 Fri, 27 Dec 2019 07:52:32 -0800 (PST)
MIME-Version: 1.0
References: <pull.500.git.1577393347.gitgitgadget@gmail.com> <07be7b8dda679d79ac9b218b2a9b08e47d7762fd.1577393347.git.gitgitgadget@gmail.com>
In-Reply-To: <07be7b8dda679d79ac9b218b2a9b08e47d7762fd.1577393347.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 27 Dec 2019 07:52:25 -0800
Message-ID: <CABPp-BHWOtQxhX-QrEYsPiPfKShAXKbe51D=L96JF=g2pZvjmQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] sparse-checkout: list folders in cone mode
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        jon@jonsimons.org, Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 26, 2019 at 12:49 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> When core.sparseCheckoutCone is enabled, the 'git sparse-checkout set'
> command taks a list of folders as input, then creates an ordered
> list of sparse-checkout patterns such that those folders are
> recursively included and all sibling blobs along the parent folders
> are also included. Listing the patterns is less user-friendly than the
> folders themselves.

I didn't spot anything that Junio hasn't already mentioned, but I'm
just chiming in to say that this sounds good and thanks so much for
working on the sparse-checkout command.  :-)

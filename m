Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9483C433E0
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 15:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 957D0206C3
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 15:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YXC8GpKU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731645AbgGAPNn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 11:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730883AbgGAPNn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 11:13:43 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05008C08C5C1
        for <git@vger.kernel.org>; Wed,  1 Jul 2020 08:13:43 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id a6so24349067wrm.4
        for <git@vger.kernel.org>; Wed, 01 Jul 2020 08:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TvIFJfErkFonFdTHsjktGtj9rjIT5e8UW8TIalg1els=;
        b=YXC8GpKUyvzI423oQqYkcvUqegFOgxBCZB4CZJV2mgMBn1THNtw44Jn9nr/zvQm4Ve
         YERS8WFCyN1qAuhmYtFp6Ookb3V3kH3g8FqAvZLXDPrPNMtxeltitZDUhDBlhawhe8zv
         aO67rGq3lBxRHrp43L5bjIETsCejv0PisxkzTFQmfqKHg8luQwwheshzhFcypv0Y2HHU
         9YsUBaGML5rbGyiAEwCb9ON9iCUvE0QkFEvyvUG6awtQGDOjbg2NTk0gy9Dvh1hahH4I
         ix76C4Lg9AZuSFzGuWnSqpXXbpJGSyqNRd3VeTkHqDReMd6A9W155IP+nR9J458sP01J
         UE+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TvIFJfErkFonFdTHsjktGtj9rjIT5e8UW8TIalg1els=;
        b=Bm8Y85lnRIQILqdc4bOcayByU4J/Y3QHPU7+4B5/Pwul1rbKR6EWMFSOawRvVIBQUi
         kzwGRxRrrTxqCPhYGkZP3K1MImvElw/ijjyBdSjBbrfFiSVq1MahEIo3esytJjhwU7yV
         QxxrZ7GV24cT2zNnMcprs6p/hKlIwucGSjpeJ2yKfaKVTsCd3zt8R3i0vZvc9+5g1aft
         IzKo/ked8JC6Xgo9gHdI0IfIZS8DhEXpUmwgDYBnkgzYh5eapHldkcsSfcVYug+4n0Bj
         HAw47EiOA/UDBLGlMVqutWQOObMxInv6HivCS4kdYCbA7eCL4CTttQ8lwXq2CjhV0xJ9
         W2fQ==
X-Gm-Message-State: AOAM5312CDsrKXFdfYPPIpLnJJxIQ6bVfb1Q3EgRu39BgP2iB5vKMhgu
        fKkZlGr9sLj6yRj+A1Rc7Dcsy0XOglAeoBzuzpA=
X-Google-Smtp-Source: ABdhPJwoZzrmGLu9nfzDgX8EjZk8nw+wgswMurfverldmeyuHAErNurTgFYGr73HP52brH3dQYrOzO/SHoNhTn5g88I=
X-Received: by 2002:adf:f74f:: with SMTP id z15mr25890681wrp.233.1593616421740;
 Wed, 01 Jul 2020 08:13:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAH8yC8m1=0n8zzoW--g_XLebJFqFSXpBpTr+1S58z7snLTt-0Q@mail.gmail.com>
 <87tuyrd0ng.fsf@igel.home> <CAH8yC8kxY5mV0p-98W0uDN7PLxmNR4LkNcz9vbKsq21aTd-qQg@mail.gmail.com>
In-Reply-To: <CAH8yC8kxY5mV0p-98W0uDN7PLxmNR4LkNcz9vbKsq21aTd-qQg@mail.gmail.com>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Wed, 1 Jul 2020 08:13:30 -0700
Message-ID: <CAPx1Gvc+pWe6UwRREHMkUCViYjzQgfg1jfbWy2pyFQCjhwV+Bg@mail.gmail.com>
Subject: Re: Why won't git checkout a branch?
To:     noloader@gmail.com
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 1, 2020 at 3:10 AM Jeffrey Walton <noloader@gmail.com> wrote:
> This does not look normal, either. I don't want to create a new
> branch. I want to work on the existing branch.

Technically, you *have to* create a new branch here: you do
not have an `m4` branch (yet). Your local repository's branches
are independent of the branches in the repository you cloned.

(You could work in detached HEAD state to avoid the technical
requirement here but that's not practical for normal humans. :-) )

The suffix-`--` trick works in old versions of Git, creating the `m4`
branch from the `origin/m4` name.  If you upgrade to Git 2.23 or
later and use `git switch`, I think you will find that it's generally
more user friendly.

Chris

Return-Path: <SRS0=GLOD=BA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E2AC433E0
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 15:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01CA320702
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 15:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="mI/yOl8k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbgGUPj2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jul 2020 11:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbgGUPj1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jul 2020 11:39:27 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035A5C0619DA
        for <git@vger.kernel.org>; Tue, 21 Jul 2020 08:39:26 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id h19so24531108ljg.13
        for <git@vger.kernel.org>; Tue, 21 Jul 2020 08:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=exVRs0CkXOe2b6isLWnz00A1UafDvREkO1ABjg3BoNs=;
        b=mI/yOl8kbky+QHCW3XxJv+cKCIVewBDTUVVez8gyg42e0COsJFS2XSqb5rDODWY2ao
         cwkXd+B+/IbBB7BKmaDjaXofyFYMJkS8fxyjoZzxln2u2W+HO/E4yVn+U3IMbcyJdekG
         yx5iO4nfo6yKco/V2lKiMJPTXRmHoh8eZoKHQRr9wnhnEE9n6QZDps2MSGgp4HkCYZ0D
         UIMN6Kaz+2+nqbgmNpNtI7kCsWjmYkbBUsMcqj3QtlxB0ZsVMklGpy0aifWQfUXYGJp9
         eUFFuTt11rlSMoyUtNsuOckAMyn2UaG+cMNExEqWsZUejFsb5HiuSWWudhmfR/2b1hsi
         N6Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=exVRs0CkXOe2b6isLWnz00A1UafDvREkO1ABjg3BoNs=;
        b=Gvu8+CyC233y0pjF9K3ozTDWolrGQkLFVZWL9uZrUiTPtdyNNLDMrGNIlB2LYP0A8u
         aHjADvk9W0p3Cl6Ph3GoBXjmufXe8/xRlng5PU2FXbDdhXzFtfl4jp935HZIfs/iKotP
         CEMFUMWjiGIE0c/ZbjnURQWqvAho71Dd5nswPBr+XZsUEpzZe3H0MZDGqAt7W71NtbIG
         bcHOvvOsjeAWw0jMOHng8T/cBYcDMbzaBygAE+q/2xmgzSKkc91IP3pT2ai5U4yjGbR9
         Q+XLgMbrPNgT8tjVWdOMnxXbi7STp0gzQvIUZ9EwikR0BjBiiptTwQ0A0IRefSChotXg
         ZMrQ==
X-Gm-Message-State: AOAM530RF7A3y91iUUDUliM92RVNuOJTvqz6kczCwTTGIahsu/DzZ9Sw
        fDEeGnIuVVEcztuznF3gC04nnhOSXRzNFRxbZzYjUnu+NOA=
X-Google-Smtp-Source: ABdhPJwysUqpwlu9/Dcv3Sd5WfuN3lYFv26q1R8JsHOg0J/QCKKgu4RZphJcA5+BGKi/uVnEGEnsV/9OpQyo4OvTW5o=
X-Received: by 2002:a05:651c:2006:: with SMTP id s6mr12063199ljo.74.1595345964988;
 Tue, 21 Jul 2020 08:39:24 -0700 (PDT)
MIME-Version: 1.0
References: <fbde5e1c9042ea06b448bc759cea9d45e300961f.1594260597.git.matheus.bernardino@usp.br>
In-Reply-To: <fbde5e1c9042ea06b448bc759cea9d45e300961f.1594260597.git.matheus.bernardino@usp.br>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Tue, 21 Jul 2020 12:39:13 -0300
Message-ID: <CAHd-oW4_A7JRmdTqCMrDU7b6-PqBSpNVD-csm3y9Bype6Vn9rA@mail.gmail.com>
Subject: Re: [PATCH] entry: check for fstat() errors after checkout
To:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Junio and Stolee

I was looking further at this code and noticed that the conditions
under which we fstat() (or lstat()) an entry are slightly different
throughout entry.c:

- In write_entry()'s footer, we call lstat() iff stat->refresh_cache.
- In write_entry()'s `write_file_entry` label, we call fstat_output()
when !to_tempfile.
- In streaming_write_entry() we call fstat_output() without checking
if !to_tempfile.
- And, finally, in fstat_output() itself, we check
`state->refresh_cache && !state->base_dir_len`.

I understand we always check state->refresh_cache to avoid getting
stat information we won't really need later, as we are not updating
the index. But why do we check !to_tempfile and !state->base_dir_len?
Doesn't writing to a tempfile or using a checkout prefix already imply
!state->refresh_cache?

Thanks,
Matheus

Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 031BBC4363A
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 19:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 528852085B
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 19:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="CwtzbNRD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391240AbgJTTh1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Oct 2020 15:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391097AbgJTTh1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Oct 2020 15:37:27 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7630C0613CE
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 12:37:26 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id r127so3546067lff.12
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 12:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6fA/S/gjrVxkbhHyby9uf2Og6+VdJaLghf8WhkU/Clg=;
        b=CwtzbNRDGc0mfXUw6JL6Yi1X0cg7Ji9qb+kwf7wcQ4HsSDyQQPJToIMQcKeBPzV0W9
         yrzkd8xmzzKco/4Ee8FMcBiUcabuNUagM3+Yo0x+OqVt6/SsQPIDX0AZoMsR5eY2VaIs
         G3ZFwJFZjQgJc2tlZOhezDKabtILRnhXGy7T/I6M9gtUw4kDfh0byWAlxKuUoRy5Oshy
         o1onKEZBf9fWLEIZW5h0ayN/AGxq1kFkBrDsEKH4CWz5il5UViIYEpQ4Px7Ib7vyG3t0
         e98YWPTQq9UH+CIwGTjz6pVIAd/F7UWe9u/hQo4lNNgZny+fSX1gmQwJwPBE3C01uaCN
         H19A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6fA/S/gjrVxkbhHyby9uf2Og6+VdJaLghf8WhkU/Clg=;
        b=LAbOtuAlrFwt0ctYKO8R66RUhgQ/kamFZ404cfqSdpsU0xMRFnz9uld43L2YOCMVS+
         LG/WAKF/OPraymcx7QS2l0HZDNOcJR99KoVBNcqAJ4qpzDmrhlJ4UCZB+m1ztR6eheI8
         cuOCb6idy+RPgXhaNuEeAibQ4T/WMT9OKSi9Src2RICH3alsvafWupuYkvzMhbm4GpZu
         rIB7Iie2sDfT8XcldcrKr3NsxV3QtslQNh7in3M/0xzoq+n9inQzu30EeEYvea+mOyqa
         cGt1f2fXvPK1+YUFCVqe7Crtz3pnOMIfkyLQ3F0Fbe2EmW9WF9JWsQsu12b/ngW3Gf9H
         lu9A==
X-Gm-Message-State: AOAM532vkC/djFXwB4MW0JTqHspxlbvPUuYGGnnnHtC4hOknaTXl4d2H
        fBFvOV96N4QV6jaRoKdvxYuC+UamSWLijtVelsjImFQ+rtc=
X-Google-Smtp-Source: ABdhPJy+k3i5GGWNLwvWkzVDRmsL6qaMp0fi0BtXxzDGq/e/jNcCea0Ylw0MhfTqDZVz8qpd/JEoIuEUxsXV2wlu5Dg=
X-Received: by 2002:a19:83c1:: with SMTP id f184mr1394411lfd.97.1603222645162;
 Tue, 20 Oct 2020 12:37:25 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqr1put77h.fsf@gitster.c.googlers.com> <xmqqtuuobtc4.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqtuuobtc4.fsf@gitster.c.googlers.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Tue, 20 Oct 2020 16:37:13 -0300
Message-ID: <CAHd-oW568aNLYYMBDPJiUsWzh2xxtm8gnqLEiX_RTDa81BL_yw@mail.gmail.com>
Subject: Re: Preparing to rewind 'next'
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Junio

On Tue, Oct 20, 2020 at 4:17 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Please nominate topics that should be kicked out of 'next', either
> tentatively to give them a fresh chance to apply minor clean-ups [...]
>
>  + mt/parallel-checkout-part-1                                  10-05/10-05   #20

Please kick this one out of 'next'. I'll send a new version with some
fixes. (And thanks for the suggestion on another thread.)

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA4911F404
	for <e@80x24.org>; Sat,  8 Sep 2018 13:35:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbeIHSUt (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Sep 2018 14:20:49 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:36676 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbeIHSUt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Sep 2018 14:20:49 -0400
Received: by mail-it0-f68.google.com with SMTP id u13-v6so23297823iti.1
        for <git@vger.kernel.org>; Sat, 08 Sep 2018 06:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M7Z+GF3sXoZGk+n6nQ0jcUZ31e5h7jOyy1pM1dUnUrY=;
        b=j1KKwBzH4sv4crlLS4dYMLMDAc6bUmdgS+kC9fWh+kKywx8CqqA4vAnyOdM8w0pfVw
         VrNWEAUBVoNE5nrUCWBww3kLnXIe7ZevOuYMyORNjHTreYMHLYOapRYQrH0EOROXQnaO
         HjSxxlbdtLJdzEp5KbYoSYSkjjbK1R/hRSRwvEWKEzdVLyvcpt18ykE4yrCLMkMzjlcQ
         brYQ1UowURRvgK6sWlTOpCGPRiXOossvPrWANs5YI9robi+gRoG+JN4pVtNGtetVzR4w
         ycdpHS8296Eh154CU/E5gDbH0lO+c2R2QtCVIhAXcxqIx3L5cLIHc9akXGCLwC5WE1wl
         86jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M7Z+GF3sXoZGk+n6nQ0jcUZ31e5h7jOyy1pM1dUnUrY=;
        b=DKIgQMqMpLbLZ4bF9qkKEWZYDYUNW+ZP8n1kEIBsqVUHjDsH5w/khZSmQaFDspO2Ew
         560lN7JE3Z3HfXdaktgj62ywDfKlmUJu2k7WFs3LFcSNMDw1wS4VDQgKI0U7rMRskKlA
         wh2UDzsOHuxAsyc5sQig+nStBj3NjoOOyXTdv9aXcZKoQBtftb6xeb3bjQVg0AMd7XWa
         nqkJHr1ZTj/tJX5X+PYxD1GJRto8us7qKQzdGZxzH6p9O7dtkkUqF1bAyZatb+zbbHbz
         qZrTdi1hjPdu1AQdxM8RWZFH0achmDrwC82BeYFApc52ZASZh/XfWkKtDVj11N0amwMO
         3zxQ==
X-Gm-Message-State: APzg51ADB90jlEXqlw3dI4ACD1DaXnpnjB3WrabUqZOlNN+5DQ2PySU+
        jNbRWjBVC3R2v8PZCEfahZ5vHpAPVxI6tEyKDeA=
X-Google-Smtp-Source: ANB0VdZWnZGiUwowKC4lmAjraHxKkWFRBy/I4aH+JDx97vfmd7xih2u2gvHCJ2SqgiyqWgQhTrMW4/kcrxeuVLoHMBo=
X-Received: by 2002:a24:144:: with SMTP id 65-v6mr10283030itk.62.1536413700538;
 Sat, 08 Sep 2018 06:35:00 -0700 (PDT)
MIME-Version: 1.0
References: <20180905085427.4099-1-timschumi@gmx.de> <20180907224430.23859-1-timschumi@gmx.de>
 <20180907224430.23859-2-timschumi@gmx.de>
In-Reply-To: <20180907224430.23859-2-timschumi@gmx.de>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 8 Sep 2018 15:34:34 +0200
Message-ID: <CACsJy8C+VPGyu1D6yeFU3eqzwusv_Q=tobZgvXOtZ=5gYak5dg@mail.gmail.com>
Subject: Re: [RFC PATCH v4 2/3] Show the call history when an alias is looping
To:     timschumi@gmx.de
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 8, 2018 at 12:44 AM Tim Schumacher <timschumi@gmx.de> wrote:
>
> Just printing the command that the user entered is not particularly
> helpful when trying to find the alias that causes the loop.
>
> Print the history of substituted commands to help the user find the
> offending alias. Mark the entrypoint of the loop with "<==" and the
> last command (which looped back to the entrypoint) with "==>".

An even simpler way to give this information is simply suggest the
user tries again with GIT_TRACE=1. All alias expansion is shown there
and we teach the user about GIT_TRACE. But your approach is probably
more user friendly.
-- 
Duy

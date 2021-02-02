Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC3EC433E0
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 09:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08C2F64F5F
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 09:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbhBBJD6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 04:03:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232917AbhBBJDr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 04:03:47 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0280C061573
        for <git@vger.kernel.org>; Tue,  2 Feb 2021 01:03:06 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id h12so26825717lfp.9
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 01:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1AlaCCuciqSXIr6RqnfHfVCgADA3mK49LjQbiRSGfjo=;
        b=ICZYMAKB4/xTJBO/AUsEm1undZizpk0os0uQVSZLJvR+ZeefMEMwueXOY2vyqcWg/o
         ojDjJI5oZKIl5D9sLIVVOJRMreNhYGJGsxMmgsTNRZhM9AvNYuqLdXmlPx+Vf35jTWvp
         msFPmB7GOJ2qCbpVISpdqpigEAyYmK0Z/FXlKbVbhxR2700ApohGnzJdPb89EhgQDfjt
         LfBdUdYwiu7TsovM/R8ol7en8zs8WBuRR+fCQUwA1JFXVY4sDXMm9b+v+Jh6l6inmizF
         I0Gaa1SHBDAbxFTmIC8ZLWZ8x9lRetIgna6psINqdbxUuwd3YfLXdCKCHidqHMBXNz05
         cIHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1AlaCCuciqSXIr6RqnfHfVCgADA3mK49LjQbiRSGfjo=;
        b=lBNBGFZUkB/A3fLD7Jooyq+JYygFla2fBq2OO8xGLo2Tt7mhTM5WONS/86cTu0ZKoN
         u7yAofluleeboaDA6F/JMRqoNg6aM2bjl/k0rGIVMFhyw2xCu1J4R7mm0pDx1R05+dNn
         v0lJkytY/KifTEpAvT4P56uuIYFy6z8/+rlXx2G6Ln2FPMR1TZ5A88TARNUUW6oikzYW
         +7fJfYOaHJmkcrDntsC9KuMK7tM7Y2MErCYnnXw8ybJun9DIxLq7jcUJ852UWTemXWug
         nWzAZ/XeFa8cUnqxmdj7JcfW3vIF/HVAjQsa42qd/yRspI9K4NeK69my7vB1ghHwNN+Z
         cogw==
X-Gm-Message-State: AOAM531KrtxY2wPQ6lMDS1J0VA5SJga3ilD13ExN9AtCe+KYucsYXS/9
        6xB8lUbe4spZ4sJ3jXwMJ+v9fHdIbfBuO1M9r5I=
X-Google-Smtp-Source: ABdhPJyZo1WMXnaFPAlVMxnEyqXffrWyj1vk/8SRnK/PG/MTgpvhu7ImST1TH6DxKtWEAZNzP8uwQNc7eUK22+6M/RU=
X-Received: by 2002:a19:6d07:: with SMTP id i7mr11269818lfc.75.1612256585479;
 Tue, 02 Feb 2021 01:03:05 -0800 (PST)
MIME-Version: 1.0
References: <CAGP6POK1s5fdzY74HyE9=0CV_B+HpbM9gU2qKuYtQAaPuc7XgQ@mail.gmail.com>
 <CAPc5daUtOMQB9YqOTQL4mrHpfyATe=FM01cW9Ngd1iy8aWwMmg@mail.gmail.com>
 <CAGP6POJ62-HG88uRv7yHHGy3Uu+T57APQ6GiNU3nQDW2eT4cXw@mail.gmail.com> <YBkUJP2u4NcldpOp@coredump.intra.peff.net>
In-Reply-To: <YBkUJP2u4NcldpOp@coredump.intra.peff.net>
From:   Hongyi Zhao <hongyi.zhao@gmail.com>
Date:   Tue, 2 Feb 2021 17:02:53 +0800
Message-ID: <CAGP6POKxr6k5KaC0xNaFGt=mBoEMkObNGHhDpUHQdEbsokrHhQ@mail.gmail.com>
Subject: Re: Only receive the topics I participated in or initiated on this
 mailing list.
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 2, 2021 at 4:58 PM Jeff King <peff@peff.net> wrote:
>
> On Tue, Feb 02, 2021 at 04:31:59PM +0800, Hongyi Zhao wrote:
>
> > On Tue, Feb 2, 2021 at 1:41 PM Junio C Hamano <gitster@pobox.com> wrote:
> > >
> > > You can,  on _your_ end, filter incoming messages that are sent via
> > > vger.kernel.org and do not have your address on To or Cc.
> >
> > I'm not sure if this can be done by Gmail.
>
> If you only care about topics that you have participated in, the easiest
> thing is to simply unsubscribe from the list.

Do you mean I still can post to this list without subscription to it?

> The usual convention on this list is to keep recipients in the to/cc fields intact, so you'll
> continue to receive those emails directly from their senders.
>
> -Peff



-- 
Assoc. Prof. Hongyi Zhao <hongyi.zhao@gmail.com>
Theory and Simulation of Materials
Hebei Polytechnic University of Science and Technology engineering
NO. 552 North Gangtie Road, Xingtai, China

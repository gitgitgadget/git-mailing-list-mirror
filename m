Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E74F1F404
	for <e@80x24.org>; Mon, 13 Aug 2018 11:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728610AbeHMOXW (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 10:23:22 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36888 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728370AbeHMOXV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 10:23:21 -0400
Received: by mail-lj1-f196.google.com with SMTP id v9-v6so12304982ljk.4
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 04:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ajlVQVGOQonzwjsrf81TbOioUfUyK6P3Vj3lX77g+HI=;
        b=XXNaGVZgP873C3Jut8BsDy9NocsJ4fvIghM77kzcMAhPE4UDCwOm4sH9CqopYDcJ7+
         kmKCdBtOzk/Wl6ViOHdwBUto0VHfzUw5gy7PbBWreG8Q7ABoCCalCt+OwjuRmeqHpH4d
         tYgaK0ZO4/XI3BzfymBU4m5BSPI54SO6OnD0/JZYDCRiAkPKqSYhstF/bKY5xcWHRhNU
         CdzE5fc4WVKn98VgOmjXIRBUkW8PittAgO7PBT+F8KLGjjvuOmDxon9bBs8jFWAz2R1W
         QMojiXWN5XkJMgIG7UozcnFHP7wh8a9irQXIW+h6lsPsRSaRaRmGQgnrNIiP8q/4aOBX
         4yoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ajlVQVGOQonzwjsrf81TbOioUfUyK6P3Vj3lX77g+HI=;
        b=dsaum3pqRhX40uwXxxmq6lXi+SmAwavVPOyvdPQL8KYcFBPWxIKCfK7cfeS+jWX6dW
         SugzydhdaV4TK607/deoR0I2e80zgmzbgNUYIfkTEMpvVJlBzEPudRHjXDhJjMz99rSh
         UovncXs9164p+4u0cdY9+MolVAT6/5pQ/BaKOuxIpej2DQ6L1PejKK2z6LIfrrwoGG98
         pT+ak7FnJMU0/S4mY1Z1GTETfP4/9mVr60ek4fPhf1hBjriBKiOpq6fMmKfbV85w+Ht0
         AqgTLK/xNT11SIFhyNgXNlG0ildYZgcEsS5IW/tbyKo80hI9/UzFJe0DUbylVMtjR6yp
         v2XA==
X-Gm-Message-State: AOUpUlG2a2ONUAFAYqzN/VxqZ/RbVFkwmKGHqUf/vABNFL2KKBAzMFH3
        MSCheCANVBL662NfPAYHCTMeFx6M1lW8l8FntMA=
X-Google-Smtp-Source: AA+uWPwIo+PcRp1BgfG19WL7QGGhtTA/E0Vq8BZHYF+jDveXovGBlS2yllSGt7Z782RbHVb/W20auDqSxBLyrFaGP9Y=
X-Received: by 2002:a2e:534e:: with SMTP id t14-v6mr2884009ljd.26.1534160485902;
 Mon, 13 Aug 2018 04:41:25 -0700 (PDT)
MIME-Version: 1.0
References: <20180627132447.142473-22-dstolee@microsoft.com>
 <20180812201845.2923-1-szeder.dev@gmail.com> <f07a0a8f-bf19-0895-e48c-4daa9246df98@gmail.com>
In-Reply-To: <f07a0a8f-bf19-0895-e48c-4daa9246df98@gmail.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Mon, 13 Aug 2018 13:41:14 +0200
Message-ID: <CAM0VKjmhnMfND8HwAvLChgZ6iFYuHUpD=C=3sqjkF9GUsLjpVQ@mail.gmail.com>
Subject: Re: [PATCH] t5318: use 'test_cmp_bin' to compare commit-graph files
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 13, 2018 at 1:24 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 8/12/2018 4:18 PM, SZEDER G=C3=A1bor wrote:
> > The commit-graph files are binary files, so they should not be
> > compared with 'test_cmp', because that might cause issues on Windows,
> > where 'test_cmp' is a shell function to deal with random LF-CRLF
> > conversions.
> >
> > Use 'test_cmp_bin' instead.

Hang on a minute, this is not the commit message I wanted to send
out...

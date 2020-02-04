Return-Path: <SRS0=lL1X=3Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B377DC35247
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 16:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85FF52087E
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 16:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TarybR6G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbgBDQNX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Feb 2020 11:13:23 -0500
Received: from mail-ed1-f54.google.com ([209.85.208.54]:41320 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbgBDQNX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Feb 2020 11:13:23 -0500
Received: by mail-ed1-f54.google.com with SMTP id c26so20312168eds.8
        for <git@vger.kernel.org>; Tue, 04 Feb 2020 08:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4hOI1JNQRkoN9+FNzRAJANLOtD8EKvsBGjTkEFvzqks=;
        b=TarybR6Gfxvfw4Ml/AMBJl+G/wPSzEcvwaEY7VpDeUfxn9rrscQ0IWv3ZREbEkTEqs
         lR+oZ0IHQA4hVF8q+F5u+8ekz9Y7fW0dloDU053mRSALW1yI8F1xezYxo4i23DjyJFzy
         CxiIFfAfdy8v4vEHqBLdhP9ZjndOkXNI0oHytAq/yS18upx5oZPUaWzrAZ1SX0Srd9YT
         h6REqPH8dD/UHm9gAZu5uCfvAyQn4y5nKa3UHmIrZLazjFTVOcZtrUwWHJFVQgwCB81g
         oQlW3ZwLlmCzi9zNe0iEQ92p8V+wKShvmFOWcxYelWnIrQGncKY30vLLYfno5buH8AXD
         8c/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4hOI1JNQRkoN9+FNzRAJANLOtD8EKvsBGjTkEFvzqks=;
        b=sK7gNAPPbzmO+lBueGzZgDfQsfUyA36NvutFfa3kFDgo8NhZ+Cpyi8QYR9NyaOJdiP
         fGxYB3ev4DGCTHft2odfvZnQMgR+ZKMAxp8vs0NzkQjP28tQ1y103Ds+KOMeDYIqxRty
         g2all1xFNKae6wpZyHcXrJGNwePMrltFF4E+j0twcEoTblKS9E3DZiUNhCh1CSIEUdlz
         ZwviIv8qeKxuPFwazGJNZutaHQEcw5BYS/qphwuKrYtZIGTLEKbM7odoCpBhmxSXdnid
         ZIrIjwqTLnN2esbuWSbVV3kWZ5rvPjQQP27XqUTxY29YEj2dkLa60EGypZH7TB4RgwBr
         9Tlw==
X-Gm-Message-State: APjAAAUdsp5R49k/AwxN0S/c7e629yd7FBA4etdT23Y04HDeeahpdeHX
        zX5UqvIhoVkzyQVVN8p1m46vksLSNJW2AB43OQU=
X-Google-Smtp-Source: APXvYqwODOsk5eo9lofu5uJwEmxqmv9EooTejUnIqJTQnVA5VsXPOYARc6deYTRwFE8S53ZhDTFmNTyO4Kiiv+TQEok=
X-Received: by 2002:a05:6402:b47:: with SMTP id bx7mr914448edb.362.1580832802064;
 Tue, 04 Feb 2020 08:13:22 -0800 (PST)
MIME-Version: 1.0
References: <20200122053455.GA51054@coredump.intra.peff.net>
 <CAP8UFD1-cswU0gSX3a2KqiExhYgY_qMZ6Sz7FHdxs7mrb_hh-w@mail.gmail.com> <CAP8UFD2_qmB1q9vhz=BJo3XG4jnLWDPhCVVb4gAh_pfKoGnZJQ@mail.gmail.com>
In-Reply-To: <CAP8UFD2_qmB1q9vhz=BJo3XG4jnLWDPhCVVb4gAh_pfKoGnZJQ@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 4 Feb 2020 17:13:11 +0100
Message-ID: <CAP8UFD1VvpEV_ASO7VQOviq3pne-Vfvx3Pph6MHZMbYyjLvRww@mail.gmail.com>
Subject: Re: GSoC and Outreachy Summer 2020?
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 4, 2020 at 5:11 PM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Tue, Feb 4, 2020 at 12:55 PM Christian Couder
> <christian.couder@gmail.com> wrote:

> While at it, I just applied on behalf of Git to the GSoC 2020 and I
> sent invite to possible Organization Administrators. I am one of the
> admins already but we need another person to accept the invite before
> tomorrow as they require at least 2 admins. This is the only thing
> left we need to apply.

By the way if you have not received an invite but would like to be an
org admin (which requires very little work if any) please let me know.

Thanks,
Christian.

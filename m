Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76607C433E0
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 05:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C7B223AC2
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 05:17:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbhAWFRR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 00:17:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbhAWFRL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 00:17:11 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F04AC0613D6
        for <git@vger.kernel.org>; Fri, 22 Jan 2021 21:16:30 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id p5so3762866qvs.7
        for <git@vger.kernel.org>; Fri, 22 Jan 2021 21:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=D8GJ4UWHUR+iimIfJ0+44kp8IKhaXR/u6SCIVRJNROQ=;
        b=YBpHvkiDVE7puP3prt7xX20SYSwS86LZdsSeVFuRKyqefHJy8noGLVVCfFWbcmTIby
         YuGETDtZN5anHkxSk+T+OA7ta1O9P4qguYJNWLX1QoM73LGqiNMztO1zGGtVpLXn9ssR
         In6MgVm/LzTyjpqmHCWGaTFpORD6NN/ewRn9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=D8GJ4UWHUR+iimIfJ0+44kp8IKhaXR/u6SCIVRJNROQ=;
        b=Vj2riAKiVpX18eaAP0nu6PmXyjgg7f0zLDsp8HT+Y0hh5zaPZfW5Ld5ntBZcySXsD+
         vN3ZI1Yd8F2fBNAdH/A2n41yO6u6wFWb6Dn/EhlV9SBErJJMtNW/w4LXi8sEv6qahz7v
         eRD/h7mV6Ltqu19/gVUyoAV35Pp2rok9MENkASke3NEku7w34RQS/xo3/ubxIK6dV5Tt
         LQ9cnp9WA5RhBcm5SczHAagIGBnOMnwUYabsTV7WG+AGFeNkMJSqh+UBbnvv11u+D0jY
         CzuY7R9vKlDWSeqdWokzM+i5b4G4ag+Dj38WUQg3IXd0qzGrO9V2OvzHjz1qdxkDtrJa
         CnlQ==
X-Gm-Message-State: AOAM531zhWps4TxzzqmeBdUh/p22RYOIRiGhvP4dA5p91JauOJhqogRS
        TJsDO1M++srkbZA/96+VYVERAwTjfi4gg8Fw
X-Google-Smtp-Source: ABdhPJwyY0WayqmGqCu6Yxkro4Mz9Dfenpu7u7qnKL+jWtS6U1uo99w5hWNyXNLKhpQNATei4KMnJA==
X-Received: by 2002:a0c:c688:: with SMTP id d8mr7885086qvj.8.1611378989119;
        Fri, 22 Jan 2021 21:16:29 -0800 (PST)
Received: from chatter.i7.local ([89.36.78.230])
        by smtp.gmail.com with ESMTPSA id e185sm6705164qkb.127.2021.01.22.21.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 21:16:28 -0800 (PST)
Date:   Sat, 23 Jan 2021 00:16:26 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Jason Pyeron <jpyeron@pdinc.us>, git@vger.kernel.org
Subject: Re: git archive setting user and group
Message-ID: <20210123051626.7hubdcda74gq3oxo@chatter.i7.local>
Mail-Followup-To: Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Jason Pyeron <jpyeron@pdinc.us>, git@vger.kernel.org
References: <043f01d6f0fe$d6ad7660$84086320$@pdinc.us>
 <cef51cd3-c6b5-ed24-f695-83be3a6743b4@web.de>
 <20210122213954.7dlnnpngjoay3oia@chatter.i7.local>
 <YAt2PPM4HRcKva9a@camp.crustytoothpaste.net>
 <YAus63jWBP1fIAhf@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YAus63jWBP1fIAhf@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 22, 2021 at 11:58:19PM -0500, Jeff King wrote:
> We also rely on system gzip. That's pretty stable, but I have heard tell
> that even `gzip -n` may differ on platforms.

The signatures are made against uncompressed .tar output, so this is not a
consideration.

> Another fun one I saw recently: using export-subst with $Format:%h$ will
> produce different results depending on how many objects are present in
> the repository running git-archive.

As long as the output is the same with thhe flags we specified in the
comment, we're still okay. E.g.:

    -----BEGIN PGP SIGNATURE-----
    Comment: This signature is for the .tar version of the archive
    Comment: git archive --format tar --prefix=linux-5.10.9/ v5.10.9
    Comment: git version 2.30.0

If running "git archive --format tar --prefix=linux-5.10.9/ v5.10.9" becomes
non-deterministic within the same version of git, *then* I'm in trouble. It's
been remarkably stable within the past 8 years, so I don't expect there's a
dramatic reason why "--format tar" output would need to change -- it's not
like the tar spec is much of a moving target.

-K

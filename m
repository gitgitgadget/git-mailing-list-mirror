Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE95E2023D
	for <e@80x24.org>; Fri,  3 Mar 2017 10:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751530AbdCCKHs (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 05:07:48 -0500
Received: from mail-oi0-f53.google.com ([209.85.218.53]:36142 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751474AbdCCKHq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 05:07:46 -0500
Received: by mail-oi0-f53.google.com with SMTP id 126so1604798oig.3
        for <git@vger.kernel.org>; Fri, 03 Mar 2017 02:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=V3h5r9Qi61x3cohkRPrFTPhiGBYNJbL6Fxm+b+E3CMw=;
        b=gQkYwJ3y3/Jy/AQ6XVLgUJOMv+bGyuJfh1Bp0y91kS3UXI7PK99YjnP+dL6CTEJOFn
         sjQUuLx5kl3MflEG8m4Wzaw/d32leHjGEKCbFLllzndVMtpVLW1aDMJXEN8S0tLepsRO
         X+bABXCglBYHIcR4qwTB3HCXkkBBuP/K4fzHsAxcCWi7xIAEqsAJy/WIPiyxYWF2P7l+
         G7z1ptRbMGt8ImlyMR64oP+9w11dHv+4W24cvwqRuLlXny+dlq1o2zrZu9EKqT5STAdu
         W4WSoI685UgmehSUvRqOLInmbSTaYBe8er4lomoFXRcfKCGlodyyXwTrZB5+a2DJaUtB
         Ssmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=V3h5r9Qi61x3cohkRPrFTPhiGBYNJbL6Fxm+b+E3CMw=;
        b=SAFr+4BMWE8Ged/gUJ0wyHi0mLDzCWXi+I6tw5PuADDw2DIbYkF9ZvOzcOLDRs0Z9f
         VVmGp9iLiQRNtUfNivkfXHFUwlrZIi95gPGczBpxgbyi/4Tq89laxAopZN/kkC4SRhma
         Z0P9Qlp8I+zbWpo8AQtZ81KG5O3vTYcrH9b5pl0GI5HW3GBRIw0ewbk2U7s8baKrWT8s
         IgrOWx+xilo0gNB/ix2Czjqm+FnD/OzVG9CgKUDZvvAcX0TDLV8aOv4r222wUNBvMDxq
         N1xqnwd6QQ6duWW/YQUMTdDYy0i4RF6QYoBlFevOrIWw4Z/8CLgtjqO4xaaPBJ249JZP
         H+3w==
X-Gm-Message-State: AMke39lAafz6/87EY/6zVJHL58Zdv6LkI2sm0jGlPwsCBUPAgUar29xJ+YsMc5MJ+6xFRMFRQSfB+iVcsP/4bQ==
X-Received: by 10.202.72.10 with SMTP id v10mr811055oia.169.1488535647910;
 Fri, 03 Mar 2017 02:07:27 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.158.84 with HTTP; Fri, 3 Mar 2017 02:06:57 -0800 (PST)
In-Reply-To: <20170303095351.rgifjpfuvafx33jy@sigill.intra.peff.net>
References: <20170303094252.11706-1-pclouds@gmail.com> <20170303094252.11706-2-pclouds@gmail.com>
 <20170303095351.rgifjpfuvafx33jy@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 3 Mar 2017 17:06:57 +0700
Message-ID: <CACsJy8DU7-o06mfuw1L02CFFR2wmoNa0MQJ8KqsV79ULzjRaRQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] config: check if config path is a file before parsing it
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 3, 2017 at 4:53 PM, Jeff King <peff@peff.net> wrote:
> I'm mildly negative on this approach for two reasons:
>
>   1. It requires doing an _extra_ check anywhere we want to care about
>      this. So if we care about file/directory confusion, we're going to
>      sprinkle these is_not_file() checks all over the code base.
>
>      I think we're much better to just do the thing we want to do (like
>      open the file), and deal with the error results. I'm on the fence
>      on whether we want to care about the fopen behavior on Linux here
>      (where reading a directory essentially behaves like an empty file,
>      because the first read() gives an error and we don't distinguish
>      between error and EOF).

I can't fix problems of my series on Windows because I don't use
Windows (because I will not be able to verify it). So I'm definitely
on the side that makes behavior consistent across platforms. Then I
can at least verify some (assuming that the consistent behavior is the
right one).

I didn't go with yours because I would have to handle two separate
code paths (fopen returns NULL and read returns EISDIR). But yeah it
should be that way even if it takes more time and effort. At least
we're now back on the mailing list and I didn't have to hurry to get
something out, to get off github.

> But if we do, I think we'd either want to:
>
>        a. actually check ferror() after getting EOF and report the read
>           error. That catches EISDIR, along with any other unexpected
>           errors.
>
>        b. use an fopen wrapper that checks fstat(fileno(fh)) after the
>           open, and turns fopen(some_dir) into an error.

If you don't like extra check, I guess you're negative on b as well
since it is an extra check on Windows. That leaves us with option a.

>   2. It doesn't address the root problem for git_config_from_file(),
>      which is that it is quiet when fopen fails, even if the reason is
>      something interesting besides ENOENT. The caller can't check errno
>      because it doesn't know if fopen() failed, or if the config
>      callback returned an error.
>
>      There's an attempt to protect the call to git_config_from_file() by
>      checking access(), but that breaks down when access() and fopen()
>      have two different results (which is exactly what happens on
>      Windows in this case).
>
> -Peff
-- 
Duy

Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55764C433E0
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 15:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F3C720825
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 15:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDcnP2kb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbgHCPzI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 11:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgHCPzH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 11:55:07 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2525EC06174A
        for <git@vger.kernel.org>; Mon,  3 Aug 2020 08:55:07 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f18so295726wmc.0
        for <git@vger.kernel.org>; Mon, 03 Aug 2020 08:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JrvZOHQXHVrHLwjkiykKprtmSSG/L0pSq3J88Mkfn90=;
        b=MDcnP2kbJaaXB9wbbJB7qJYMOe9kHUlA3A6BCotwmgGaGjzW5DqxAU9kn0WcHq7UHZ
         Vxw7YCf2Bod24VhmyoOcpWmHtQmlYC73X5mK4bax07G+Lj778mY+NcIwseGi3lR3w8SD
         uu0w6887uFxCILReaAOk95KlCFpTQsypd5kQRblRg2IlJhLFGSzHpdT3lryRCXR/+ZKl
         HSi9HIhGMcPar36plLBeEnYLahETOjb/6hV+MPSaYUlXPcCONKIqRqZ7gAnNKsfzEWt8
         L3Pf2FAOU3JHlzY7hEOxTLv6VtVvkNPZV5HCEHDyz+JhAc4s6CxiHTwvdSUJRj6mcvqz
         PxiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JrvZOHQXHVrHLwjkiykKprtmSSG/L0pSq3J88Mkfn90=;
        b=VE7Wr5Hzysie9BdCL5DuDb/qoIBsUYBKoA/Clnl0ohFNI4L3xN2Y/BK/l6vVaE6+Xm
         zZa4Q2R3uabo7OujsSBM4xtBQLtrjnJ2i5oOfyiUKi5UyNJxkvhEM5ahkLFouTqCZUUj
         jMi8YHJ4t0wpR9j549eqLeRF16UQxzfBy87qpLaSCT8yZHS8paO5gokfQiaGorOajY+5
         +xMK1TE3raOx0H5eAlWO3HJve6thnT1m8US1GfoxHbG3u1KDKl3lY/JsR5zbf08iWbWu
         TLJSZu88yIfff/TvUrJbiYbn8BPPLU3NI7MRdAlbfFVl6UhgYhyG4lLEEFPDexansUsp
         eIYA==
X-Gm-Message-State: AOAM530ZWp18UWmSa+SkZrh/KbXPT83y9seZX+zuByWXSwjR8oYgu0fT
        KpOsdaGY+2GaMXRh+InZz/OY6ZSB9lv/bXb5rIE=
X-Google-Smtp-Source: ABdhPJxF2aTehj+iLXHitJmBgnkLdkEFMC1HuOkVoigmaIqUe9bXzgvLKKZvkZUyL3m0TX/bm1WrjQ7WR0P4vmSML7Q=
X-Received: by 2002:a1c:41c5:: with SMTP id o188mr566022wma.187.1596470105824;
 Mon, 03 Aug 2020 08:55:05 -0700 (PDT)
MIME-Version: 1.0
References: <6722ade6-971e-7ecc-e8f0-7f595ca0b0ff@web.de> <CAPx1GvdJ-4Yyf7Vm1OdhaW2TZp77HOfGxoGw0R2fKfEuHQkqOg@mail.gmail.com>
 <87c4ab84-8db5-bd62-af66-fd88f788827b@web.de>
In-Reply-To: <87c4ab84-8db5-bd62-af66-fd88f788827b@web.de>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Mon, 3 Aug 2020 08:54:55 -0700
Message-ID: <CAPx1Gvd7rULr-Z-mLDc2FCxyoepdMhK2t=j23-mr_6pvvHWynw@mail.gmail.com>
Subject: Re: [PATCH] upload-pack: use buffered I/O to talk to rev-list
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 3, 2020 at 7:00 AM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>
> Am 02.08.20 um 18:03 schrieb Chris Torek:
> > The fclose() call doesn't necessarily check ferror().  (The
> > FreeBSD stdio in particular definitely does not.)
>
> Thanks, didn't know that.  That's awful.  So the sentence "The fclose()
> and fdclose() functions may also fail and set errno for any of the
> errors specified for fflush(3)." from the FreeBSD manpage for fclose(3)
> actually means that while it will flush, it is free to ignore any
> flush errors?
>
> Or do you mean that fflush() can succeed on a stream that has its error
> indicator set?

The latter.  You have to get particularly (un?)lucky here: say the
buffer size is n, and the *last* write operation (fprintf, whatever)
filled the buffer mod n and called fflush internally and that failed.
Then at the time you call fclose() the buffer is empty.  There is
nothing to flush, so we just get the result of the system's close()
call.

> In any case, we'd then better add a function that flushes the buffer,
> closes the stream and reports errors in its return code and errno --
> i.e. a sane fclose().

Unfortunately the global-variable nature of errno means it may be
clobbered by the time you inspect it here, again with the same sort
of issue above.  It might be nice if C's error conventions were more
like Go's, and stdio retained an earlier error, but this stuff all dates
back to 16-bit "int" and 512-byte buffers and no room for nice stuff. :-)

Chris

Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A2CBC54FD0
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 12:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECF27206BF
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 12:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LC0S0Vdn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgD0MF1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 08:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbgD0MF0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Apr 2020 08:05:26 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42107C0610D5
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 05:05:26 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id j1so20251555wrt.1
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 05:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=v91PTjTucWNhoNrytNKYDena3xOhEXYX0M6CnTA3pQA=;
        b=LC0S0VdnncgmkpxktDKdEtLkHxY9hX4YCsCQLmd1rURP2vGlOR5te2zO3MzMC48LSc
         HQNg/Tt2cWlqpvmKGwavqoyBIWRwSoiJKkBAzpEEOJIQD4FQt93dkjjQO0HNhMqDH0o+
         vNq7/ftvroUQIhKs0C+sbGa0Yaw04BjbYZhNHVCC6geKQ0/qn/wTX3n8SBO9/6ggMW68
         0b630ai3qLFJZ4pi9NRwyqdUhQzsUiE/6wAIWZtC2JMvlagBhiarTExtfY9itb7hCrRI
         LOUywMYpzNxdAcKkj4I47U+oE0C6fzn7Rrwhv0pu2WUFKkyPewnCTsYaN0ULjxKlzHLU
         U9HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=v91PTjTucWNhoNrytNKYDena3xOhEXYX0M6CnTA3pQA=;
        b=WHSz/qcjMPGk4/gxJPWrXQ88kQyN+tb1RRU+Z2bT3NYyGLQGeMWSLUEhoxuEOwhIMR
         xyRBEY/k7qr06YeDPciV0z/iy9q8wuNAZhSFGIH5r25k2jh+nzmbfCZaDV/p9MEaJFam
         zpszmtsQ+ZHfcCd0MD+4JLBBga32xpAfH3Cb2CWYVb7XDaLl5iuap6EWkF6Wka+r47lm
         4DwvSxMZGnSkh0FTWxhPUuCgQ/fYPp/qLQ0BBaJ4ot8L6j4psF9GYTY9oomYnw1wvEWw
         Ww0llNuuCCdaMnvyi6HUaXSslQyU7XAGL8o1spalNHyhKCErnXZ6pJBvQBbIHpl8lHmR
         V3VQ==
X-Gm-Message-State: AGi0PubJxAW/TtCWP8HtPGhIf582XLppl7HJBzN1m+vPTItkbknqW2AJ
        4Rckm9eh5Y4Ntc4EQkKLsIA/VRft7CX6CWYrN1LRzQ==
X-Google-Smtp-Source: APiQypJ4aKebr5GRd7vg/0l0l2p6rxAAJgX+C2r7FxD72BE82RvmViocBLo9Wr8V8PT9M7vhLbFgL+3uIPPLym2XBog=
X-Received: by 2002:a5d:4ed1:: with SMTP id s17mr26368537wrv.310.1587989124559;
 Mon, 27 Apr 2020 05:05:24 -0700 (PDT)
MIME-Version: 1.0
References: <575af27b-3823-2db5-ad3b-3c6cd7a95faa@web.de>
In-Reply-To: <575af27b-3823-2db5-ad3b-3c6cd7a95faa@web.de>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 27 Apr 2020 14:05:12 +0200
Message-ID: <CAFQ2z_O7z2prvnE+v-0nzC3=2mmUBHgFVF+iRqRn-7QyRQxOqg@mail.gmail.com>
Subject: Re: Compilation errors in git.pu/refs/reftable-backend.c
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 27, 2020 at 6:34 AM Torsten B=C3=B6gershausen <tboegi@web.de> w=
rote:
>
> Folks, after the integration of the reftable branch:
> Merge branch 'hn/reftable' into pu

thanks, I'll fix that.

I don't understand why Git doesn't enforce this, though.  Couldn't
-Wdeclaration-after-statement be added to the Makefile if the compiler
supported it?

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado

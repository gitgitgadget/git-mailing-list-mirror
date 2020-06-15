Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5413EC433E0
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 19:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AE07206F1
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 19:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o/F98VyX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730322AbgFOTrU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 15:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728773AbgFOTrT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 15:47:19 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11D7C061A0E
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 12:47:19 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id 205so16973309qkg.3
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 12:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/Ua2OR8cLStndYI9ed0ReUqeAt1XZvlu+HxiFWgjba8=;
        b=o/F98VyXwVC/WCBNUPKghkGq3GcoAZwpc9Uw5nbR9O0Cgswg/lY/nEqH2B+mKrouoX
         +CnE23pX5J1UxUSW6Uke8d8p/o5Pgi4uBldWkAJbjIWa2Ig1hQyrf4k+pkCUz80dFYOJ
         5dHK1E95jiTjxlxc7QocIrfP3Wgu26BDgm1jXdZKE4Wgb9ooAHVpvKDC2hiEtWWGC2mt
         jqX1GBazi+xI36qPWsC17OBphNnaMjX+LXOn5MxD+d3pfgIPdAfEPXpv6JQARJWtq0gN
         ivNNHJxR5p9dDCIsHMhwInZpe2Vdo1bJvJkid8DEt0kGpp9GnBWz8PyaluvcIE8ga+RV
         6Umg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/Ua2OR8cLStndYI9ed0ReUqeAt1XZvlu+HxiFWgjba8=;
        b=SBmXZNYzHdqVe9TdHcy08NobVqtUpAqCVJUbDnsQ4LlsojsdRWM6X+BLZPSioDyB+z
         t4nV0rMdZCtAwjenvuDJFTU4Q9n6lMBgVG4dyGbw5hg+aGyvgSg1xvmPVmNObFwPCkZC
         qETXpNmPe1zfsYUhKXgGfzyq3bpgrY8k+4a3J5Tv9s8QboS6QbHO30vzmHYi5/kB7r0k
         KmGMqdQXvkl2xFkidpALmtLJvK4GpgD2+cmwcvBTNJNy27dtIGnTXnyTave5pwFxy/wd
         7Xc2pGy3Q59pZNWCsMmAmK0IvmqfFbNkHZEJc6ajEgcy06WqIKBUea7Ccx4WhrXIA8/O
         EWfg==
X-Gm-Message-State: AOAM532caRyO0PQPyW1VBjxMwg4lQSzabZUQkiKzCH2Kjc9VD2d2Lq2Y
        JVDk4lCyJP66zPrjOt7hhcFGKbDr2aihNbNogBFQWQ==
X-Google-Smtp-Source: ABdhPJxkyjZtyKDyx/kQye+mVqw+Um4kdycphf8CrRsp4WVIM+m28S9kldnZiwngXHFU4u4Co002E8aOZUfwUID6bJk=
X-Received: by 2002:a37:a89:: with SMTP id 131mr16693106qkk.92.1592250438885;
 Mon, 15 Jun 2020 12:47:18 -0700 (PDT)
MIME-Version: 1.0
References: <549f0cd5fffef38e8d85246a9aa2593674aad68c.1591986566.git.gitgitgadget@gmail.com>
 <20200615140349.1783-1-oystwa@gmail.com>
In-Reply-To: <20200615140349.1783-1-oystwa@gmail.com>
From:   Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Date:   Tue, 16 Jun 2020 01:17:08 +0530
Message-ID: <CAKiG+9X66yf_F8F3XuYFdFyBWiFRZ_rf0Y1mE5LVCjsi-AzKbg@mail.gmail.com>
Subject: Re: [PATCH v4 6/8] cmake: support for building git on windows with mingw
To:     =?UTF-8?Q?=C3=98ystein_Walle?= <oystwa@gmail.com>
Cc:     Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 15, 2020 at 7:33 PM =C3=98ystein Walle <oystwa@gmail.com> wrote=
:
>
> > +if(WIN32)
> > +     set(EXE_EXTENSION .exe)
> > +else()
> > +     set(EXE_EXTENSION)
> > +endif()
>
> You can probably use CMAKE_EXECUTABLE_SUFFIX here. See:
> https://cmake.org/cmake/help/latest/variable/CMAKE_EXECUTABLE_SUFFIX.html
>

Could have done it that way, will try to change it once the patch
series gets merged with next or master.

> =C3=98sse
>

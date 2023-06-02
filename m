Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25FEAC77B7A
	for <git@archiver.kernel.org>; Fri,  2 Jun 2023 12:58:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234971AbjFBM6c (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 08:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbjFBM6a (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 08:58:30 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C869180
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 05:58:29 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b04949e4e9so9778485ad.3
        for <git@vger.kernel.org>; Fri, 02 Jun 2023 05:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685710709; x=1688302709;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3q1ZE4R3pBGXpsDWEM4poz+B5YrR9yu9KSckAjxRZ4E=;
        b=LKyqmt20j0if/u+wzsCWThhe36gQJLTd5Zi090532gsGH0xiwYCtQZ5Nty+5Ho5BkL
         u1e5z7YgKhwnpuI/WfNnkdRzCddpcuPgZP0LZzgeqHUPf3ZHejKc86qQcSndN3UX16Yc
         tpENHADDMy/4xePe+9zMVZWZN2hiM6dLfRyetyfnURLIWiG9ha3J6jKbwPQ7yHTOO0Mh
         wuKneyZOSTKD8YXtYJMbOp7084L0S2s+vKr6QZD0S93hAF2sTLg6xALEeFRNlkIt7w99
         cOi2VJPrv+3ygO+E3GbLARVVA8D73Lx15a5A3GynQevUiOyCnURvhHAL8QWamb9fCUMl
         Wbww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685710709; x=1688302709;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3q1ZE4R3pBGXpsDWEM4poz+B5YrR9yu9KSckAjxRZ4E=;
        b=RDzIR3i3uYx+dCMPem2qCmFEJbs6VOMfdwrCiNxdlyOIb+mgwhyDQJCZS7ayR56h6f
         nAj42uvAN9IHdD2+dGDHhGnwaz2SwSGzlQta7pe4OdDmcVpIx27oFNxXw2lWGMLKk4Ag
         tcvcfXGrgvB/+kpJ9PD0V5V2OlYPi52MfcK6zOIOhqfwpR6z5bZ0drzKixqrXDserPRc
         CRxKGEb1PgF03IvJie7H91HI+E5HxBgCByuCA5HNiJy7EgSehD9PhPyJegVRLuMwEcSj
         t2Hmqrw/Rud1eFN3IKHMqz0vA/DIXmy6FyI1+Z61N36IpcIvOK7KeLbdL1McmNrMT8aJ
         rAvQ==
X-Gm-Message-State: AC+VfDzpSKaADjnZkXI7OJG+pX1qLd7h7oPFKD3hxeNVlWumNPzxCQyu
        Mz22XQFki574guc178K7Mq8xI3DVJLmWKg==
X-Google-Smtp-Source: ACHHUZ78fTuAoXdVr2oMLhZBDXJyB4JIA5woxuKFOc9+oEXfA8kV+1fTKdYNziB/SfFKuPfbPhIukg==
X-Received: by 2002:a17:902:dac7:b0:1ac:8837:de9 with SMTP id q7-20020a170902dac700b001ac88370de9mr1424329plx.3.1685710708498;
        Fri, 02 Jun 2023 05:58:28 -0700 (PDT)
Received: from fivlite-virtual-machine ([49.37.144.109])
        by smtp.gmail.com with ESMTPSA id t21-20020a170902b21500b001ac45598b59sm1294272plr.163.2023.06.02.05.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 05:58:28 -0700 (PDT)
Date:   Fri, 2 Jun 2023 18:28:15 +0530
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] t/lib-gpg: introduce new prereq GPG2
Message-ID: <ZHnnZ_plMZ-wdO4M@fivlite-virtual-machine>
References: <20230529192209.17747-1-five231003@gmail.com>
 <20230602023105.17979-1-five231003@gmail.com>
 <20230602023105.17979-2-five231003@gmail.com>
 <CAP8UFD2wcnNaihGv=SQ_77OLQ5PN3DG73rnh2F_C_j+BFTcCyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD2wcnNaihGv=SQ_77OLQ5PN3DG73rnh2F_C_j+BFTcCyw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 02, 2023 at 08:50:18AM +0200, Christian Couder wrote:
> On Fri, Jun 2, 2023 at 4:31 AM Kousik Sanagavarapu <five231003@gmail.com> wrote:
> 
> > +test_lazy_prereq GPG2 '
> > +       gpg_version=$(gpg --version 2>&1)
> > +       test $? != 127 || exit 1
> > +
> > +       case "$gpg_version" in
> > +       "gpg (GnuPG) 0."* | "gpg (GnuPG) 1.*")
> 
> s/"gpg (GnuPG) 1.*"/"gpg (GnuPG) 1."*/
> 
> I am not sure if it changes anything, but for testing if we have v0
> here and v1.0.6 in the "test_lazy_prereq PGP", we put the '*'
> character outside the double quoted string.

It does seem that it changes things, thanks for catching. I'll reroll
with the necessary changes (there are also some style issues that
Oswald pointed out).

Thanks

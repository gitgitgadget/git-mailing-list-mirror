Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F73C4332F
	for <git@archiver.kernel.org>; Sun, 13 Nov 2022 05:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233069AbiKMFFj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Nov 2022 00:05:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiKMFFh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Nov 2022 00:05:37 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6109413EBA
        for <git@vger.kernel.org>; Sat, 12 Nov 2022 21:05:36 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id q21so6155600iod.4
        for <git@vger.kernel.org>; Sat, 12 Nov 2022 21:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EivkJWF9OhC5s+vyXKOS0h23kfAjvPFe8+Wj873ladA=;
        b=H3wWoL3UTLxE9cUDWO9NpDG2L4YOZFU9avNMilLwVR2fvptMuwPDvfNu3r6ghO6586
         Ji5+59S91m2D7P0muji8y8v0K054DetIpxDNenB9YE1+aiQImvm8tngE7yZpTJEaP8AT
         QxV7KV47E/bWnxueBplVT7SMTOvMQFPyfm4+cG9WmdlOkqSFNgJnbBLJMR0zLiyRBQQa
         erD8sCOhio6U2fTYGOz3UNWOlXlhzZnGhk7tm9mHDqqqi4pUNpWhlrxBfYzgiIXhYnVg
         omxH0kaRZWWWD7ncrroyy1kf8hCs/6CT3oo9Nlvl/rnrrPqwHHAi/qHRt5y87ghcgynk
         Nzaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EivkJWF9OhC5s+vyXKOS0h23kfAjvPFe8+Wj873ladA=;
        b=xJpmC5tffgJQSnGK2eLuc+V2/Lgm+vloyktkLh5ThacP91P50xEUmQFWGxwXLY2Kls
         ewj0LoO1TXlbFVGeyC3ocRajMoIexwdd70mifu6W1Hd+UELZNDpbBDJ4Mw+LfOhIiRAh
         6Qz8NhkMJwmtoQ7QEqpYdyXCuVacWXqQsl8SmJZWUfA3AR4Ad9/qa/hzRf3O9/zLUY0B
         Rc0GVFgjXA++Gx06Q//fBvfOHMltognLTcNUsixuk9qXYjlswIca3GrgMQ0IbXpFZFmK
         XvSCTp0g0zUIb8JlSFoBorrsLnTpg2gGUrkUsJ5tC7XG9Vv/baGQfCSbg+kR7h50GRXT
         4sOA==
X-Gm-Message-State: ANoB5pm12X5uuf1drDNJEs7+9abvHUAVID6t3BE/9T5TcMGe7w2bEFqL
        I4+UVJl8T0vGQRcZGefAUDI1Fw==
X-Google-Smtp-Source: AA0mqf5pbCxg4bgSHYmmA02cymDQtMlGYmHK0oJOVrcqt8xSyH8zPFT2sWkrbgp1cPH7Uk1biSdvyQ==
X-Received: by 2002:a02:9f0f:0:b0:363:79c4:b889 with SMTP id z15-20020a029f0f000000b0036379c4b889mr3574390jal.292.1668315935731;
        Sat, 12 Nov 2022 21:05:35 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z17-20020a92ced1000000b002f90ff8bcbbsm2528180ilq.37.2022.11.12.21.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 21:05:35 -0800 (PST)
Date:   Sun, 13 Nov 2022 00:05:33 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2022, #02; Tue, 8)
Message-ID: <Y3B7HYwAKpQgnZth@nand.local>
References: <Y2riRSL+NprJt278@nand.local>
 <1675f68d-d3ae-6004-e2b1-a3bcec862264@iee.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1675f68d-d3ae-6004-e2b1-a3bcec862264@iee.email>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 12, 2022 at 02:40:56PM +0000, Philip Oakley wrote:
> On 08/11/2022 23:12, Taylor Blau wrote:
> > --------------------------------------------------
> > [Cooking]
> > * po/pretty-hard-trunc (2022-11-02) 1 commit
> >  - pretty-formats: add hard truncation, without ellipsis, options
> >
> >  Add a new pretty format which truncates without ellipsis.
> >
> >  Missing test coverage.
> >  source: <20221102120853.2013-1-philipoakley@iee.email>
> >
>  The summary should have been updated after v3, and we were looking for
> a final review <Y2rPAGp96IwrLS1T@nand.local>.

Indeed, thanks for spotting.

> I spotted some left-over comments at the test locations that needed QZ
> space conversion in the here-docs, which have now been removed and a v4
> submitted.

Right. In this case only the WC report is out-of-date, since I picked up
v4 in po/pretty-hard-trunc and pushed that out. That matches what's in
'seen', too.

Thanks,
Taylor

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27D6020248
	for <e@80x24.org>; Mon,  4 Mar 2019 18:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbfCDSrZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 13:47:25 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38028 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbfCDSrY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Mar 2019 13:47:24 -0500
Received: by mail-lj1-f196.google.com with SMTP id 199so5254571ljj.5
        for <git@vger.kernel.org>; Mon, 04 Mar 2019 10:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mNzqu/wUJj1PEjxNTX+bRH5Hsz5zJ3K1KQBw4jTDGyg=;
        b=eMtDYfnH3pYnSO/GC17BGTeunJLozuzaBXP/+PmJjlwLnMmYKPuT9QZzS0YeCS1GnF
         KfzbW3p02sxfSV+i1hTc/qIOjAVOwGT78mzOgMe0prBplm1rXh/zMq65ffCcib6/jeHG
         fbdzbcCfFkPJW1vwgZK6ovFNBcmjvwGZBwwneHZ2Ary2LGrDctVr9nKRyGuJeurHHxcH
         EU7Eq2S36ZdSXCqwNouElqTTYrWYjX26L+aKdxsNzWbGJDuMQbysoTffxwgiksyL4ID/
         PKRCYkW3yNIGI0eXDYtqRSismEAfUIXaFzruezXaLu1Q/ctmyknTd3D6Vpwm0rr8uAkC
         5vZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mNzqu/wUJj1PEjxNTX+bRH5Hsz5zJ3K1KQBw4jTDGyg=;
        b=JUvm8TN2L/czuMcxz1c8loWhvu3T7/qh0UYayptJYWPQRxD2owubr5qCZzPiT1fOwY
         uHE/mjABP+ViFjitCk0nsPYMXdloynFsnF/jzSm5bVqgQeGs9yjwdGFoyrHnhXxtIvo4
         iIwv05bYRdCVeOLCSyNMjkxLHjNEMy+S+G9R1xUeqb/tDHf6NAMrXnboC+91PGTfgli+
         vZ0cAwe4lp4tuwF0ex+sFVOWDCZZxLuu2C4DEz0Tgbod7qhR4riJMGfI/fW8tKbUZBE4
         V+Yg3j1qvBH5+ao5ZtF1IQCosXE4IxHVZWLAKzGmCYA/yEn6ZzT7xu97yxuwffzJeZRH
         hp4Q==
X-Gm-Message-State: APjAAAVXInPsmJeAJZbG/+UAgAf/OcJz4gGmqD4U8iXt3FYk87qVjLq4
        qhWQZNp3x01rdmAzI2Pw3SjqGZmg//Q1v6Ma384=
X-Google-Smtp-Source: APXvYqx+rBvYj0RZUYRSsBa7Z4Y9ZXcx6/61mGZf2cY271fywoX4Gy3dSbU0/ltb+U2cRWjjU/RKRmsP5iEJYttDHn4=
X-Received: by 2002:a2e:3018:: with SMTP id w24mr11334580ljw.7.1551725241763;
 Mon, 04 Mar 2019 10:47:21 -0800 (PST)
MIME-Version: 1.0
References: <20190303200220.30009-1-brandon1024.br@gmail.com> <CACsJy8D60NXksKpYJeDJbYKP6JUmrHEJW8ubMeV12dij+jXKLg@mail.gmail.com>
In-Reply-To: <CACsJy8D60NXksKpYJeDJbYKP6JUmrHEJW8ubMeV12dij+jXKLg@mail.gmail.com>
From:   Brandon Richardson <brandon1024.br@gmail.com>
Date:   Mon, 4 Mar 2019 13:46:55 -0500
Message-ID: <CAETBDP5UOqpBvuY=YFq6AAK4eDUAd3MU89Xi-Tra3rJgesLuvg@mail.gmail.com>
Subject: Re: [PATCH v3] commit-tree: utilize parse-options api
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Andrei Rybak <rybak.a.v@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 4, 2019 at 7:18 AM Duy Nguyen <pclouds@gmail.com> wrote:
> You probably should mention about the extra _() too (e.g. "while at
> there, mark more strings for translation") just to be clear it's
> intentional.

Good call. Will update.

> > +#include "parse-options.h"
> > +#include "string-list.h"
>
> Everything looks good, except that I can't find where this
> string-list.h is needed. Maybe just try to remove it and build to be
> sure.

You're right, string-list.h was not used. Removed.

Brandon

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21569C433F5
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 17:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236687AbiDTRle (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 13:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiDTRlc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 13:41:32 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7839846B37
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 10:38:46 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id 1-20020a4a0901000000b003296ea2104eso406532ooa.13
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 10:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bQklWxARuFrlLA8VhZZncjm/d5zJDlbd6hzAKa9rVXQ=;
        b=L2Yj6b7y0Jg2n6pvkB4FPWJPPVAYeG1W2sL5XpUJavDmSzH6beXit9c7e/dl76uoMO
         YUJDYf1yJMB15q1NXvKlVDEtCFqvFq1YGNJ8ImNYDCHQtooVbVPKaI+629sYC1/Zc0Ir
         kCZg9d2scNF1M6F8i8JZ6bxnP0oyQydu39BVlPfGT5bfNTbOrgrIZUpjC8/j3MYSd/2h
         73gibglMnQI7BLNF3ATDiMcOB1y5y3vcUVCmQScjLwHZtebnlW9odz5RgHtsum1HZd23
         BNx3/GwyBKYY1vKUYMfReS5rjZoEuHSI9U3KdgrL2k9pH7MvEPtckrkVm5EGAgM6uWRL
         fGvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bQklWxARuFrlLA8VhZZncjm/d5zJDlbd6hzAKa9rVXQ=;
        b=Z3jMy9CqQf8e7dpuhruuqW7grVfIXdbZ44QphG8odzmau3f0eF9RK2L3tx8dq9MJTW
         +3hHKsZNdbyb/b2l5vL3ntTGVURcrv6FIz/FSRwNRibbV6WAtxJpCJBrTON3stTe3kPV
         RgYdShfKVB03/Ci7nnUCDLH+ebh1vCQoMPE5XbjIQCXfng7Ljby/pnbTNvDL02/dBIg4
         wLW4NwlDxnZHerhF/yD+pvB9Y6TYLCRCyy0I4zcWDPMBUIlCQO5OtgTS1HyYBFNfPYkj
         QBC/HJvTt7ipi49x+hQeLk1IDa1xMYerPSD56750TFoGJCfc1vhbq8sDgNipmmRfELdq
         jHIA==
X-Gm-Message-State: AOAM531JCqc+SDxWPE0hm0hYwq0Xo4dHd3n69zsBhpvzXBm7PSDREPtP
        4+DpVlEyJP72tvMq4gpoq+eYGdeKTo+rCoJncqpgOwf9
X-Google-Smtp-Source: ABdhPJw6STzuI/KAefhwa+MTsvqIt0ppC6PsoPZlIXNnygdWSbz8PWPKCbUrwlYCsanMm2nphMgVBGijkfsZ4ILU1WY=
X-Received: by 2002:a4a:7a41:0:b0:339:e757:ca7a with SMTP id
 a62-20020a4a7a41000000b00339e757ca7amr7124574ooc.88.1650476325675; Wed, 20
 Apr 2022 10:38:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCZ4U-9KYGK0jwnL1GyOYW-CMjV_Eo--g85CbexsV=aQnn7aw@mail.gmail.com>
 <CA+JQ7M8+FR+_t+Fafoggz47bT0joAZFEkjhjf72teZgdNEoNZQ@mail.gmail.com>
In-Reply-To: <CA+JQ7M8+FR+_t+Fafoggz47bT0joAZFEkjhjf72teZgdNEoNZQ@mail.gmail.com>
From:   Kevin Long <kevinlong206@gmail.com>
Date:   Wed, 20 Apr 2022 10:38:35 -0700
Message-ID: <CAJCZ4U-2mmkEGL98-Q-fizxfz0UEOv6GZJKJvNvzei=9xMja2Q@mail.gmail.com>
Subject: Re: help request: unable to merge UTF-16-LE "text" file
To:     Erik Cervin Edin <erik@cervined.in>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks, I actually did try that without success. I'm wondering if
there is an "ancestor" object that is still binary or something, deep
rooted in the tree.

Converting it once and for all to utf-8 would be great, as that will
work fine with Visual Studio.  Not sure why the original committer
chose UTF-16.

On Wed, Apr 20, 2022 at 10:26 AM Erik Cervin Edin <erik@cervined.in> wrote:
>
> On Wed, Apr 20, 2022 at 6:29 PM Kevin Long <kevinlong206@gmail.com> wrote:
> >
> > The problem file is a .sln file (Visual Studio "solution"). Edited in
> > both branches. It is a "text" file, but is encoded as such:
>
> Can you convert it to utf-8 in both branches and then merge?
>   iconv.exe -f utf-16le -t utf-8 foo.sln > tmp.sln && mv -f tmp.sln foo.sln

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D3CCC433EF
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 16:29:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359025AbiFVQ3b (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 12:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350478AbiFVQ31 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 12:29:27 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C302E2F67B
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 09:29:26 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 89so25939418qvc.0
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 09:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MWif2AZ79eYzHxyImoeC4suc9YUx2bvmOIKaBRX0q2E=;
        b=3duknH3JrL1Mc5x650Xa4w3XrzX2zcgql5+0TWROEwK0QqIg528F64Du1qDY0uZsqK
         Ie8GkigCftZRsUAZeELZd0eeXLrLM/gtsF+ZiUxzd4Jh8rI4sS8NXKAqInzbH8DlXQOR
         52dzBk7vbKQFQrr2WPGv7NrI7Cj3t2o8pv7ASP35F9/UcSquO/omGUtJQNNYLZpYKYd6
         J2IZtUz2KrAqExMqd4ttYBMKok+qiEl0+2MC+VX/3My9pWb1MT/IEmZX+PciR2m/3OpW
         mDCNtPXC+xgws39GQP20vp6Lleiqq3KUqBjm+UBeWFAT/ebsQluEDvFYdBMTrGEHAMO3
         h5Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MWif2AZ79eYzHxyImoeC4suc9YUx2bvmOIKaBRX0q2E=;
        b=7WTbXbL3ZfopSTX+kr8JnpghUL4+UTT6uVpeL2YTDkz3hDAjeGTX00b5Fy/enWSmr+
         gYIRhkigKNTF204v3C1ZY+IU1l7KCn3OejIgkoShCHn5G2vET6XYfJblZtkuz/kTNZQb
         zpElmmdKYWuZHMPh+7AyWnfcm6Otd09tjpnMpKLi51ducvfztXkSACxACfqGyyBIvKDP
         U7tBBJl0ZfMas9CHtWwMU6FYW9mUQdfDqG5x7Gvy+Eprx6K1wKa+k0wtt5cu9XO6J81v
         zUU9U3crx9f7943WTiHpHrd2ApwrKo7QE+4jWzthDr4hNDIjpw+QK7IEbU9T854BYI3a
         E5gg==
X-Gm-Message-State: AJIora/Z5x/qWHrqn6q0P59xCsAKNIhfPux+pKp8Vfwl5lB0JCYzAtCY
        JXYQJtuS9iD+4rmyoLI3DhmJXA==
X-Google-Smtp-Source: AGRyM1s7Djj1pOYomgsF4CFpSoyH4+m3GF6FCSQqH3+18/KI+1+RbMh2STrQ+VEbTyBuZi07tf0Btg==
X-Received: by 2002:ac8:5c48:0:b0:305:2ecf:927f with SMTP id j8-20020ac85c48000000b003052ecf927fmr3775564qtj.129.1655915365889;
        Wed, 22 Jun 2022 09:29:25 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id bq38-20020a05620a46a600b006a785ba0c25sm15832431qkb.77.2022.06.22.09.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 09:29:25 -0700 (PDT)
Date:   Wed, 22 Jun 2022 12:29:24 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Cc:     Git <git@vger.kernel.org>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 1/6] Documentation/technical: describe bitmap lookup
 table extension
Message-ID: <YrNDZMixyt8xNAvS@nand.local>
References: <YrCsricF+2rQXiBk@nand.local>
 <20220621092253.21667-1-chakrabortyabhradeep79@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220621092253.21667-1-chakrabortyabhradeep79@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 21, 2022 at 02:52:53PM +0530, Abhradeep Chakraborty wrote:
> Taylor Blau <me@ttaylorr.com> wrote:
> > I remember we had a brief off-list discussion about whether we should
> > store the full object IDs in the offset table, or whether we could store
> > their pack- or index-relative ordering. Is there a reason to prefer one
> > or the other?
> >
> > I don't think we need to explain the choice fully in the documentation
> > in this patch, but it may be worth thinking about separately
> > nonetheless. We can store either order and convert it to an object ID in
> > constant time.
> >
> > To figure out which is best, I would recommend trying a few different
> > choices here and seeing how they do or don't impact your performance
> > testing.
>
> I think at that time I thought it would add extra cost of computing
> the actual commit ids from those index position. So, I didn't go
> further here.

It should be negligible relative to everything else, I would imagine.
The function that converts an index position into an object ID is
`nth_packed_object_id()`.

> I still have a feeling that there is some way to get rid of this
> list of commit ids. But at the same time, I do not want to add
> extra computation to the code.

I'm hoping that the additional complexity is minor. And if we can save
some extra bytes that aren't necessary in the first place without
compromising on performance, I think that's worthwhile to do.

Thanks,
Taylor

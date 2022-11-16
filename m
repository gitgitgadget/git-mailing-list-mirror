Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B12BC433FE
	for <git@archiver.kernel.org>; Wed, 16 Nov 2022 20:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233273AbiKPUQg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Nov 2022 15:16:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbiKPUQe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2022 15:16:34 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2825984C
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 12:16:33 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id d3so9774234ils.1
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 12:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OdgDDYa/q/F2A/3eIwDeH+K9YjnzRaDyUE2nwXVmtHo=;
        b=0UbkLaj/VQUJlfA8x33MXqWz3RduVyQLn3Xg9PxB0FJEGRt6/U6+jwpioYQe2vR7dO
         4RAgqXb80cyY5K5qtNMQzC1QYB4nVG6/Oyz6RsCz4FYq2l9S6fKtpTvYDc7sbJUi6JAq
         JbghEmxqqfgEV67Pwz1/kGtOxGOwM3uNQq2B9s94HblsF7ZYxPICKy18lKIm6NdAw+yh
         XnQhE7GIUbwnTzC2f0DK6QQJD3u2hsr+5ZWYsvV3Zy+WlVU/LJqNp+T/HZq3a0BQfBSh
         ZnRjKyAvoFy4hbCziM9KGxufmAvsAiM0eYfdjSm+ma1h5e8zxODqHFV4tdyaQC+wxM3z
         njUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OdgDDYa/q/F2A/3eIwDeH+K9YjnzRaDyUE2nwXVmtHo=;
        b=bhWpBjpLTRAPOC6jKzvPEy+R/SFHBggu6dj78LmbErr6q9MBeuIU+t57y3/LFTRIE9
         +kT76IzBAe7CHrZ9vTj+IIyjTtJtDYtBoa+ZCzc6qVh32/r/sNlUApXDGJ2lutDe5T/0
         Wl9OFE500ybYd+sxW11IGPxLIhhMv1rkgQxbDF3WRzXT6kInsCyDwsW1ZAa/r5f1cRFY
         zqOblnQhZUUyvb+r7qqL59fr3YYfaDJ521huzy0hRHHeF749TjofhwBx7TJjlxO0OxsH
         iRpYd5gyQA97gAX1RRwaG724gYFRaEjzV9e6txPtq14H106O/QIxxC3kIZbqQP09eaOq
         9hGw==
X-Gm-Message-State: ANoB5plw9EK5YJxTMgcam6grwu3v8ojxcGkPehAY2zUUjq91xl/dp5kJ
        OJYIY1bJN4niwCis57QaN+V2yw==
X-Google-Smtp-Source: AA0mqf4EfSNPSah8QZvEk7poOCzimlrwea/Iv4oG6W9iPHJ+FDRUGqxTTvIcXw0u0E/qx9Sd/Wym6Q==
X-Received: by 2002:a92:d0d:0:b0:302:392a:8cae with SMTP id 13-20020a920d0d000000b00302392a8caemr11181288iln.48.1668629793135;
        Wed, 16 Nov 2022 12:16:33 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id ca9-20020a0566381c0900b003754394cc3bsm5983499jab.114.2022.11.16.12.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 12:16:32 -0800 (PST)
Date:   Wed, 16 Nov 2022 15:16:31 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: What's cooking in git.git (Nov 2022, #03; Mon, 14)
Message-ID: <Y3VFH/vupnRoE2zI@nand.local>
References: <Y3Mag8qG2D3qjlmg@nand.local>
 <CABPp-BFJDYpOyAz1XGjqu3p9NVwQjFLta6HCux2y26TvLw5kjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BFJDYpOyAz1XGjqu3p9NVwQjFLta6HCux2y26TvLw5kjQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 15, 2022 at 10:07:37PM -0800, Elijah Newren wrote:
> On Mon, Nov 14, 2022 at 9:26 PM Taylor Blau <me@ttaylorr.com> wrote:
> > * en/sparse-checkout-design (2022-11-07) 1 commit
> >   (merged to 'next' on 2022-11-08 at 42e164b490)
> >  + sparse-checkout.txt: new document with sparse-checkout directions
> >
> >  Design doc.
> >
> >  Needs review.
> >  source: <pull.1367.v4.git.1667714666810.gitgitgadget@gmail.com>
>
> Labelled as "Needs review", but you merged it to next...is the label stale?

Thank for noticing. Yes, the label is stale.

I intentionally merged this to next back in 42e164b490 (Merge branch
'en/sparse-checkout-design' into next, 2022-11-08), because it seemed
like the document was stable, and that any future substantial changes
would only happen after we started seeing some patches.

I'll make sure to update the label when I send out the next WC.

Thanks,
Taylor

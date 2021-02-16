Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32AD6C433DB
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 14:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04EC664E02
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 14:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbhBPO3i (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 09:29:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbhBPO3b (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 09:29:31 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9A9C061574
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 06:28:50 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id 81so9517903qkf.4
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 06:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=FeiFGbWXa4J/Hdnu9D3l6IdYCGEae85FJldj8NwBw2I=;
        b=ulPOpxnYK15dS1dCXFxTvBhVN9/GN/6ENBbbStGSbFAODiOgSZL7VcgMewi7klbdy/
         XU8h6tKoJcIKqS20qVu6/mZ4+XQN28G17TfE9+/YfRs3l60bymZp9JL4dqPryqagXB2w
         hLUjyThSoUg8tUFVJ9NblBceQ6PrEaNAccEjBBN0GbEG076xQpOJeMw+xppx2XH9Ej5q
         i28d6Z9WCtFTGPVtJafZclYtGNTkKMnZ4w6T2lsN9AtYAokXkQl0/OuOXVgx3AHyfXxu
         nnOyCUT73WtEqfOFcsdwNbZe2baQN4f1hiIGlXbvJ8sExwLf6nEffj1irlAWO5hu5nU6
         ApHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=FeiFGbWXa4J/Hdnu9D3l6IdYCGEae85FJldj8NwBw2I=;
        b=B2N0nEam8tBFXbwZYu+PVC4FeQuXddDbIWEjr0yBRU/yDQJxBhHL18uJ4tVJD4PARB
         AL1zH6rAvDvYfj1DGCAeYrQTmVqaDnIFBjJca3E6M+STP2fei0Jrg1/h20t5nu2C2au1
         K0QGmIsmJ3rfT5cV25dhkfAZlN67BiOatiBFw8V978phjaOehm0PKoyunlj6okg2h9Lg
         PFi6GWWlqPpicSy2HEuZwofrd0gxFoFVaBD/ASzdeki+sz5hT06YLb+qMACuVcV3QwDH
         u08N0rKih3j1sZgSWBkDRV12mnMsvqrBcs6C+CEfmgm7xX5QPpCyEeqMwzrgR9dDoumj
         DyLA==
X-Gm-Message-State: AOAM533Hzsm4e7PoPiE/qZX6jE2YrwOB4Zh33sg21cI/0tMHQxlimaVi
        uDvkcN3u7vC3tsVL8L5Umw4lKg==
X-Google-Smtp-Source: ABdhPJzPBMpbWtApbWzrtgIcqZcuXueYcq7WCDN7vwA2VI70MiYyO6RhilH1qRT/t3iCC9DO9biYSw==
X-Received: by 2002:ae9:e314:: with SMTP id v20mr19843718qkf.66.1613485729573;
        Tue, 16 Feb 2021 06:28:49 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:c1ff:146e:b5:8cba])
        by smtp.gmail.com with ESMTPSA id x49sm13708353qth.95.2021.02.16.06.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 06:28:49 -0800 (PST)
Date:   Tue, 16 Feb 2021 09:28:46 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        avarab@gmail.com, peff@peff.net, dstolee@microsoft.com,
        szeder.dev@gmail.com, gitster@pobox.com
Subject: Re: [PATCH v2 0/4] midx: split out sub-commands
Message-ID: <YCvWnt3a5X7eZBwm@nand.local>
References: <87r1lhb6z7.fsf@evledraar.gmail.com>
 <cover.1613422804.git.me@ttaylorr.com>
 <29d29633-ccbb-e534-24bc-c8b16c7df38d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <29d29633-ccbb-e534-24bc-c8b16c7df38d@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 16, 2021 at 06:50:13AM -0500, Derrick Stolee wrote:
> On 2/15/2021 4:01 PM, Taylor Blau wrote:
> > Here's a few patches that we could add to the beginning of this series,
> > or queue up separately.
> >
> > I think that these are all fairly straightforward, but it would be good
> > to have Ævar take a look and make sure I'm not doing anything wrong
> > here.
> >
> > I'll plan to send a v2 of the reverse index series in a few days with
> > these four new patches at the beginning.
>
> Thanks, both, for cleaning up a mess I made as a new contributor. These
> patches have been enlightening and definitely move the code into a
> cleaner and more extensible direction. Thanks!

There was hardly a mess to clean-up, and clearly this pattern is new to
me, too :).

I'm planning on resubmitting my tb/reverse-midx series as soon as it
gets another set of reviewer eyes with these four or five patches as new
at the beginning.

I do wonder about the merge conflicts caused between this and your
chunk-format API series. I'd rather not create such conflicts for Junio,
and last I recall there were still some outstanding comments on that
series. So long as you don't think that you resolving those comments
would cause new conflicts, I would assume that Junio's rerere cache
would make applying both easy enough.

If you do think it would cause new conflicts, it may make sense for you
to rebase your branch on mine, but I'm not sure if that's something
you'd want to do or not.

> -Stolee

Thanks,
Taylor

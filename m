Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38A8C433F5
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 21:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D86766140A
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 21:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbhKPVwx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 16:52:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbhKPVwv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 16:52:51 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9F1C061570
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 13:49:54 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id w15so666530ill.2
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 13:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Deac9Lic7vBwwzKZJRXIPAToWqyqpQ4rO9Y0VrEWEOE=;
        b=e/fUoA1/dzRjexhlftCqTqPaJuDnXOwgnVDRJLyTRBckZ9OUFYAAKdjjTBD5uBYxTu
         oSbQHOHp/iEn7SEKBdEYNJhpDhn+Uw1IQYRirXRU4xVzLMgyTOKyRWUrAjc6N02STQq3
         rhrPQoBuy6YIOtOB+Khd9VsAa1QwPZplEs9hlccwlrsJlLCw5v/xJjPO8VmDIP+TbQts
         7Vc5JKbgmyzBDqcc+9g8rtzsnVHjBMWaTYa38Yf2aVWM9LVWIMVSCj9skvJLchqHBUlk
         sovK5Zdo6BEWeASUsqMUq0gb7dTBJd4oS4Vo5tMZUk/g9pcx7j/qT+Zr12nczwzvSUr1
         0N1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Deac9Lic7vBwwzKZJRXIPAToWqyqpQ4rO9Y0VrEWEOE=;
        b=5ErexyAm2S3qZ9llmsPPmePF+eBwALbqZu7dDP1De7BBGpHokpUBWOsoakXp9yGVec
         YUakvMLEezPeIWyak0QyvSk/O5Mlz8/Y0QoK5cjZ75bpdWPvnJImup3nr7B/ZqnIPdtg
         v7WeyF/5cL9QmgW1xIn6vnUdGjgPYUZGcpB3gvxWm4trFu3R9IwWebTz9voKJTfqpq+H
         PKn7lul5UX39kSvqWvkNuHLQHzM6Psv8nhAAl06RnM8jC+8MuwR6is0uUs5LRLVUYllJ
         E+zrrggokg5eJqlEIJGowDq9gNgSVPIFGDomwS7X5yrWp/cEd8CZiwhC881KazZ4QBdh
         zUxQ==
X-Gm-Message-State: AOAM531Q1IUid/NFSPZ2hAm6Qh1Fgv1fWiRKIv778HXxBOoAYJBhSqfp
        j9DOvgFUJN14c2J52yHSR66mjg==
X-Google-Smtp-Source: ABdhPJzMt314TxE4YBUMJcVvl6EIm4m3G5papSVjJWF2WeSwtH1D/Ki88UWmNtdn+8sSlMoOEVFXzw==
X-Received: by 2002:a92:c56b:: with SMTP id b11mr6945928ilj.243.1637099393609;
        Tue, 16 Nov 2021 13:49:53 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f2sm13021898ilu.54.2021.11.16.13.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 13:49:53 -0800 (PST)
Date:   Tue, 16 Nov 2021 16:49:52 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Teng Long <dyroneteng@gmail.com>, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH] midx: fix a formatting issue in "multi-pack-index.txt"
Message-ID: <YZQngLFWlns9HyoW@nand.local>
References: <20211115063318.14426-1-dyroneteng@gmail.com>
 <4ad06bc6-4f11-d6ef-ec95-ab0e9db9c2c7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4ad06bc6-4f11-d6ef-ec95-ab0e9db9c2c7@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 15, 2021 at 11:25:56AM -0500, Derrick Stolee wrote:
> On 11/15/2021 1:33 AM, Teng Long wrote:
> > Signed-off-by: Teng Long <dyroneteng@gmail.com>
>
> Hi Teng,
>
> Could you spend some time in your commit message explaining what
> is wrong about the characters used for bullet points here?
>
> > -  - A value j referring to the jth packfile.
> > -  - An offset within the jth packfile for the object.
> > +  * A value j referring to the jth packfile.
> > +  * An offset within the jth packfile for the object.
> >  - If large offsets are required, we use another list of large
> >    offsets similar to version 2 pack-indexes.
>
> Is it that the indentation isn't enough to show a sublist?

That's it. ASCIIDoc doesn't treat an indented dash character as the
beginning of a sub-list. It will treat an indented asterisk as beginning
a sub-list, but only if the rest of the list items begin with a "-".

It might just be worth converting this whole thing to use what ASCIIDoc
would probably consider to be a more standard format, i.e.:

    * A list of packfile names.
    * A sorted list of object IDs.
    * A list of metadata for the ith object ID including:
    ** A value j referring to the jth packfile.
    ** An offset within the jth packfile for the object.
    * If large offsets are required, we use another list of large
      offsets similar to version 2 pack-indexes.

> I see that the HTML rendering on git-scm.com [1] does fail to show
> this sublist, and I could believe that this change would fix it (but I
> am not sure).
>
> [1] https://www.git-scm.com/docs/multi-pack-index

Yeah, Teng's fix works just fine. So I'd be happy to see that picked up
(with or without much additional explanation).

Thanks,
Taylor

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136C8C433F5
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 02:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5AE2611C3
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 02:29:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbhILCaS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 22:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbhILCaR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 22:30:17 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B60C061574
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 19:29:04 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id q14so6323697ils.5
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 19:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MOOXeZW9SHsmXwvyrCXcreqWwr/b9NT2jGb4O9JRL5o=;
        b=Vlz77uea8AqoP4LapIY/EndoTvL8JPzkQlw/xlo5SxdUIF0PhI8JFPP0uaZ5w03GY8
         bjL2WqEaq0nbHE9ETWdQFV8jmnKL/y41pMEWXSaHwPxMQBMkjoU9cAhBzvPOPHWBjshT
         9uGkX5rTldsKTqn7uZBlO2Jgrh8jjWRljEvHR1OOFe8cb1SYZc3Asp+Vof+Kdp6R3NYg
         9rabOHtFC5GXT8+eb4Rzt2Gae803HMCJyyqL/JX5WRchezRQZbQT/K+gCQGZU+T94mRK
         aHexXey3QHOzpuMOmC8iShpZTd0hyO5B02tJ8h1Ep00j7FbnT88DF309Rs0oY/MOyuno
         tUpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MOOXeZW9SHsmXwvyrCXcreqWwr/b9NT2jGb4O9JRL5o=;
        b=8PVDi2Xc31vbCGrJ6VYfAXCRuQHOx3TBiSIprMAB90+9GH8iADf21DsyqUeQvaItHm
         XdZWPRQ8ZFe9AnQVdJPHnRGpS/PhvbYVD7/X5UNPIZ4pq+t9cu/Ex6x8qnBdpzxTIbqJ
         oUKh8jZgAewNFg462/Rp1HX3bTL9ezqKP8PS97osA2mwWNowfw9zu3CxHF548Gnvn/H2
         203VBnEo88frtn9wE7cbW6IrgxGUg+fuDboBJOUzxIQyL/IJWPYWA2uMsQGQYYYOUxaB
         I5um2IDAGSvCBTCWhN2rYCb1AR9gmoUMw7uLPzNEvzXlsDvM4GsUCNP8AI2cGt5HzLf5
         sOew==
X-Gm-Message-State: AOAM530ICvR73D+Kb8vaIpuyobyZm9kAH4fLr3Kg0xobxrZiokIw7jYP
        rTHRGU16RysB7IFQC+Rz6nOHrw==
X-Google-Smtp-Source: ABdhPJzYg5PgSb9qq+BE9MkFBTHIiulBhYsjy5o++fzm3ydr8GwUC+5cHMcGSN6RMKG0M1pc8Fe15w==
X-Received: by 2002:a92:8743:: with SMTP id d3mr3269520ilm.237.1631413743975;
        Sat, 11 Sep 2021 19:29:03 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d8sm1933445ilv.55.2021.09.11.19.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 19:29:03 -0700 (PDT)
Date:   Sat, 11 Sep 2021 22:29:03 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/5] packfile: use oidset for bad objects
Message-ID: <YT1l75uQ50e2IaXM@nand.local>
References: <4a702bfe-afd0-669a-c893-0262289c24b8@web.de>
 <e50c1465-59de-7fe1-de01-800404c7640e@web.de>
 <9cdf54db-132e-d771-e177-6673f7ad02bf@gmail.com>
 <YT1dCAuCE7xIIIk/@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YT1dCAuCE7xIIIk/@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 11, 2021 at 09:51:04PM -0400, Taylor Blau wrote:
> On Sat, Sep 11, 2021 at 07:59:40PM -0400, Derrick Stolee wrote:
> > I initially hesitated to support the drop of
> > nth_midxed_pack_entry(), since it was designed with things
> > like midx bitmaps in mind (specifically, to also support
> > lex-order-to-stable-order conversions).
>
> I didn't know that nth_midxed_pack_entry was designed with either
> purpose in mind, since it predates midx bitmaps by quite a bit.

Thinking on it more, I can imagine that you wrote this function
aspirationally envisioning something like MIDX bitmaps. And since you
and I discussed the design together quite a bit, I imagine that that's
the case ;-).

But I agree that after reading this series again, that the inline-ing
suggested makes sense (and doesn't conflict with any series I have in
flight which don't add any new callers).

Thanks,
Taylor

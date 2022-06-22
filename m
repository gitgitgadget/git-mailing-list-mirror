Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C8B4C43334
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 16:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237166AbiFVQ0s (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 12:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358840AbiFVQ0h (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 12:26:37 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DB73FD80
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 09:26:20 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 89so25925904qvc.0
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 09:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tdHyp/cmKwA+7A6dHCBPDTihW0CsYcWSzNiWB7JOOfc=;
        b=GY5+1bQXCNnt3VrrQVFnZwzNlgJVA7E8WNV3u02fMtZz5XHqle3ZWHjfoMcIfLOhe6
         zynIhPIQAr2irMAq6xucNR+89B/tSWS9YtsLlm6fN4le25emnNenH/r+Xrh8JQilk1eA
         W+xzqThFj6IG4TZ8cFWQfCbXqWDXZBfwPMxN0ZCir6UalA+28KGOoWRffnvKKNycLfmB
         FPacb1Xs+8PYgyYpPUxM+1AzQAM2CzXLhTftL7/Z+BN8u80DVCzsOjwqvogJLqyM2msD
         usuwZ/VYYgmxk33cZRlSjLGJ72zcqr0RsfXfxM94r00tYZU70AExvdNzq69ukCkwlMLi
         vtAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tdHyp/cmKwA+7A6dHCBPDTihW0CsYcWSzNiWB7JOOfc=;
        b=XoxSk/KckLZOoyIE+yBrTrsfeEaR5hFsZROgALe57d3jpQrB0Zfn/fXKsM/LKqPYV5
         Rqdzd0S7NDH1Q0ZIZ6oRTePkeL9eV0TtdCS1AM6Dzls9iwy+Z7OYox1YVSEQ7wrMQHza
         TmpQE9HpC1qeIsc0u6msWAe0wIRnhMC7lBOefyKyAZvwJN95mOMP5+en4HPv9ig1SE0U
         oVXcDUou/5Ik7chCUQbYbVNDLEIBw0Uq1tak51Kzex9uiR5LhSjVcgvs3Yube7IrUAoU
         zbc9QPSZCyiCHqy/k4W9gygoNO2jd9BGPWhNd7ykkpIIbCgkoPajdxsoIm7Bhr3F13KS
         25BQ==
X-Gm-Message-State: AJIora/1CbCB2jwglU7F46wOdSWJJ4z5lmRL5AMBACkjgrPumSC860I4
        py52k2N8alR/4Yw1a0MaLw3x6A==
X-Google-Smtp-Source: AGRyM1viw29UWvcX02U768GR7h5xm6Qw1mI+cfZwLJ79EZ4EcvGE7/d1v55oRcwAwp8qcot9ZR7Psg==
X-Received: by 2002:ac8:5b50:0:b0:305:320d:c143 with SMTP id n16-20020ac85b50000000b00305320dc143mr3867170qtw.626.1655915179281;
        Wed, 22 Jun 2022 09:26:19 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y11-20020a05620a44cb00b006a768c699adsm18012469qkp.125.2022.06.22.09.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 09:26:18 -0700 (PDT)
Date:   Wed, 22 Jun 2022 12:26:17 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Cc:     Git <git@vger.kernel.org>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 1/6] Documentation/technical: describe bitmap lookup
 table extension
Message-ID: <YrNCqcU4onE43Vl7@nand.local>
References: <YrCpv3XEoB6lOlY4@nand.local>
 <20220621083114.21429-1-chakrabortyabhradeep79@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220621083114.21429-1-chakrabortyabhradeep79@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 21, 2022 at 02:01:14PM +0530, Abhradeep Chakraborty wrote:
> Taylor Blau <me@ttaylorr.com> wrote:
>
> > Abhradeep -- do you have any thoughts about what this might be used for?
> > I'll try to remember it myself, but I imagine that we could just as
> > easily remove this altogether and avoid the confusion.
>
> Honestly, I never understood the logic behind adding this flag option.
> I thought you have a reason to do that. Even I was thinking of curving
> it to 1 byte. I will remove it then.

I think removing it makes more sense. Since many of the other fields are
4-bytes wide, it's important for alignment purposes that those fields
have addresses which are a multiple of four (relative to the start of
the region, hence the 4-byte wide flags field).

But I'd just as soon get rid of it, so I think that makes sense to me.

Thanks,
Taylor

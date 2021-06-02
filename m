Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7854C47083
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 16:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACBBC61C83
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 16:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbhFBRBi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 13:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbhFBRBh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 13:01:37 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E733C061574
        for <git@vger.kernel.org>; Wed,  2 Jun 2021 09:59:41 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id h20so3035090qko.11
        for <git@vger.kernel.org>; Wed, 02 Jun 2021 09:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OaWdG4O7LISJrnXtg182nEmSoHEpq//sG/FP0eyAjSI=;
        b=kNd+nttwl025XKZgG2WcQJBqUWsHk0iSm6MgjhUXyCegndmmyTfQDo/v+GfxNDZFBO
         qEpkCG7LdhcY92dAfAH2BmO8K79LTgOZwOyOZv6AFkapji8m1vfBzx43y+m5c+xexT6I
         TiA0OR1NmDxjE/B0OCidbUp+iDn1Lr3gffKFkdE/HLcYLo3A4OuPxqt7+BD+y5B9ObJT
         0tVFjk+C833+av9Env96kf+XgZhzwWRXmFnf+I209BDPg+FqHPWdDC3gZ7bhEerNZ6tu
         86neiuDUnb98wpzoDTH+GrzwzwahPa5j5kwuRsHBqoLgO/edyEwjlzXv/oRMzNUj36of
         sHOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OaWdG4O7LISJrnXtg182nEmSoHEpq//sG/FP0eyAjSI=;
        b=JS6W9n0Lnr5HPWDurTtfPTlackS9TUTtoPIQUTP1nCspitkRpBcGSkTvKBlfgVNiCG
         6H94Ujv8vhA7MCtCmbO+dmdDSxptlsf+7Txon/LBcDFG+SLyq0cu+wRWYJ39Q8f4OFxj
         bFp8lT2fe+DP7AWH/PorgGUuOHvTxI9djCeNN+79GVo9X4Qge21YRQGRfJtCvNu53Tsa
         op/XLpXHg6kvMPoZM4jYkhZjqE4ljmu9aT3Z6CARPcvromhOUnitKy2tkKWOmOy8pepG
         olp6G94cxjwYuA/5o4pl4kVf/T7lCOkMnbJgKRUjzwrWXVg+GivIPmc4Lda9zUEb530f
         Djtg==
X-Gm-Message-State: AOAM533e4xT6nd11RAv7PtIpD374ANOvK5ce2uTv1sAbouSd0FA1nrA8
        Q/jjoBSZLSSo/rm/e2lzMKpCAg==
X-Google-Smtp-Source: ABdhPJyLjpcJ93vU8FV4PrCK0IvIj9Ov/6zfIU25GJI+/bzxNbfqGfFO5SSvLOJtfMlVwmx0rvJ5Ng==
X-Received: by 2002:a05:620a:1667:: with SMTP id d7mr28478021qko.462.1622653180661;
        Wed, 02 Jun 2021 09:59:40 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:28ad:8020:cfd7:7a23])
        by smtp.gmail.com with ESMTPSA id p199sm166066qka.128.2021.06.02.09.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 09:59:40 -0700 (PDT)
Date:   Wed, 2 Jun 2021 12:59:39 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Andrei Rybak <rybak.a.v@gmail.com>, git@vger.kernel.org,
        dstolee@microsoft.com
Subject: Re: [PATCH] config doc: indent descriptions of feature.* variables
Message-ID: <YLe4+2JKH1LYRTvv@nand.local>
References: <20210602001132.459705-1-rybak.a.v@gmail.com>
 <057126a2-81c4-41cf-e41a-52a24a0c9a52@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <057126a2-81c4-41cf-e41a-52a24a0c9a52@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 01, 2021 at 09:17:54PM -0400, Derrick Stolee wrote:
> On 6/1/2021 8:11 PM, Andrei Rybak wrote:
> > Config variables feature.experimental and feature.manyFiles are grouped
> > together under "feature.*".  However, this is not easily visible when
> > scanning the help page of git-config.
> >
> > Indent the descriptions of individual feature.* config variables to help
> > the reader distinguish this group of variables.
>
> I'm not sure how these extra tabs help in the rendered text, or in
> the formatted HTML output for the git-scm.com web page. I do believe
> that we would want to re-wrap the paragraphs to ensure we are not using
> too many characters per line.
>
> Is there precedence for a simple tabbing like this? I was able to find
> a similar grouping for advice.* in Documentation/config/advice.txt, but
> it uses a different kind of grouping. Perhaps reorganize the file to use
> that strategy instead?

AsciiDoc has a couple of ways to indent a subsection, one example (which
uses the same style '--' header as in these patches) can be found in
9218c6a40c (midx: allow marking a pack as preferred, 2021-03-30).

> Or, perhaps just point me to an existing use of this pattern.

git-scm.com doesn't have 9218c6a40c yet, since it won't be released
until 2.32, but grepping around for '^--' in Documentation shows some
other results.

Thanks,
Taylor

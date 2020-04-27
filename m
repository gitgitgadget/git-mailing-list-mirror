Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97522C4CECC
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 21:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 754742074F
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 21:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VAuwm3iG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgD0VDR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 17:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726853AbgD0VDP (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 27 Apr 2020 17:03:15 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB0DC0610D5
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 14:03:14 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id mq3so157611pjb.1
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 14:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jQMm7D2jwPtLSe4lmIDkLlnCcE8OgXTbRHiPJWkD+34=;
        b=VAuwm3iGW+2zikZEJaM1H+pChBjN32V3aqpE2vnhpka8PTeW1lk8ajeHVS1RK6pMvq
         QNg/5/0pxdm62SIknG8X96FBflssrcDIvqMb1OGW0Y5SzH53V73N0SK24zfaQUZhG9rd
         56SJXYl1lIX8jT7YbnK1RaiXegdAMsfXSJXx0jy3TQXkzR2DZ6BEO9py/jryu04fx2Lj
         0XXW4UK2nOBDSZJqCXSXPGaD8/5hZaia65CgjSMXSPv50EAGZqHj0VVPX76M4jwuooYm
         2nXRqhYJyd8z4aOPeEThGS8V9YeHHzNPveMF2EqdQhJBtZx2XVyBwipTBYttWRoiDZJE
         R/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jQMm7D2jwPtLSe4lmIDkLlnCcE8OgXTbRHiPJWkD+34=;
        b=cq+nuUjz9xh+nJi2wPtunMwgRYKdXBVB9ctxOKYX+DqW4H1rfAlFIEb+tt9OP6RfhS
         x7MdL3nKtJbN9oazP2k8DFgwrJm1sbxqb6AZlVLvDYB7R9ZODngqI6hV9BaDZ8ZeANdQ
         WNU+KW8Sqq3bZpxyrGzit4HSKP3Rnbz/PHpk3ZUTLctKEFuWHgVRWDnCdp1pOMFt67zh
         ZnZ6D+xNZkFHH/8K8IBB/8RV+RKfQi2ZF40V13mg1RjC0g20pSRALsYQzFbzR6H8BNfO
         +FD3IfWHQuDl6WWz4PhKp6TanhtBPvJqYD4uFnaDDQZytJJ60uUNP8M2GnOrAMyJcAv6
         tE7Q==
X-Gm-Message-State: AGi0PuYfUw9N0FCOAbwfaQWjBWS8kYAVATubXZc/pNPHHmPsVcU6FVoX
        xhICp7DM6DRijSjFKfuejvfmsLlv
X-Google-Smtp-Source: APiQypKcneUsdJ4BpCZSnFb508Pgm0qdupK9KymuYVHF3coq05BtXushhWD3rg6wM+ubzC3819RHRw==
X-Received: by 2002:a17:902:c382:: with SMTP id g2mr22491054plg.290.1588021394011;
        Mon, 27 Apr 2020 14:03:14 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id l8sm3481720pga.60.2020.04.27.14.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 14:03:13 -0700 (PDT)
Date:   Mon, 27 Apr 2020 14:03:11 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] bugreport: drop time.h include
Message-ID: <20200427210311.GB36078@google.com>
References: <20200425003002.GC17217@google.com>
 <20200427204859.171084-1-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427204859.171084-1-emilyshaffer@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer wrote:

> As pointed out in
> https://lore.kernel.org/git/20200425003002.GC17217@google.com,

This breadcrumb shouldn't be needed, since the rest of the commit
message already speaks for itself.  We can save the future "git log"
reader some time by leaing it out.

>                                                                we don't
> need to include time.h explicitly because it is included (and possibly
> managed for portability) by cache.h. Drop the include.
>
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
> Thanks for the observation, Jonathan.
>
>  - Emily
>
>  bugreport.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/bugreport.c b/bugreport.c
> index 089b939a87..e4a7ed3a23 100644
> --- a/bugreport.c
> +++ b/bugreport.c
> @@ -2,7 +2,6 @@
>  #include "parse-options.h"
>  #include "stdio.h"
>  #include "strbuf.h"
> -#include "time.h"

Same applies to stdio.h, I believe.  Forgive my laziness in not being
exhaustive before.

Thanks,
Jonathan

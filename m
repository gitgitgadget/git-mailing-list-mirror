Return-Path: <SRS0=3i0n=DJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72057C4363D
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 04:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FF4A20780
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 04:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Er5EsOPd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbgJBEMS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Oct 2020 00:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbgJBEMR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Oct 2020 00:12:17 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63F8C0613D0
        for <git@vger.kernel.org>; Thu,  1 Oct 2020 21:12:17 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id p21so94298pju.0
        for <git@vger.kernel.org>; Thu, 01 Oct 2020 21:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FJgEUUS1VJzEgCaILm1REodzYxCsyddn4MLxoN7o064=;
        b=Er5EsOPd7XlWDSU+Y/xWF4/uqzwqiq7SRC+WCWua/nCIltONwQnKjwh0VzGCgsRyhZ
         e7JXF4+al61MoX0HSghLuDA4UCCbkfF9B/pH0wNuRVREYc2Fat4a+G+NP7EW4Z7CKatl
         a6ZW8Dr1qUNSaGhmKDhiez9ccSx/TlhmvOwEAkNmPWWLdQDJjyT0+Sxow+pMEs4upLNO
         p3OQ+Y835qlSNThMK3ElKagOI9oCxzSr+/Rr3RUjSzShy2d1JvXPFmozDKx4cWPsCTuE
         hLBNvDHoHPUorT3HQUpeRwUR2UlIyevk5C9/ynwIk6INjj/H+X5pFoHO3QujNnjHUEFp
         dyOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FJgEUUS1VJzEgCaILm1REodzYxCsyddn4MLxoN7o064=;
        b=JoPh+bw2tXVPFG8Eg4y4/OzvBhTL/wYPBI/ICkKsGMr3OInDob4pQfH4r9ESFq4Gei
         ceoHFVdrX3HJQoJ21oRxCAYbQMfSZ08v2SieVXzUnUfvnS7SIbwn0Kz0mvT/Lvgz3QWi
         7LuQ1ftyM5ii4YJ6dNezMfHdos/dbjbnNcRi3vWY6Jo4LvkOEULo6KyoG2mfiGL6xtCw
         /UHhEL+OjLUhLlHsLEECoU0MCNzbYaEHJs8W24xu4rhP/6SYRNUWr55Wiyj/P6CIDjZ9
         56hvQ0svWvPSg7mGYJpRMaLSOm0D3PHQAb9RxtzlBbhSvJnT2m5CvtFzaHBq2Gne5BhR
         z9zQ==
X-Gm-Message-State: AOAM530gdxOGf6YrSUfSWkju2xyz0GokBFY+ywoX+5IWDfcCqCWWA1kH
        Am8qvxE64BhP+HPFdGTKm6k=
X-Google-Smtp-Source: ABdhPJzn4tOksE1ZAP8yLBn1mIY44EFObKihBt+7ckqwy9Y4twZqeD5rXPiullvIUWVrkQs9cbFYMQ==
X-Received: by 2002:a17:90b:11cb:: with SMTP id gv11mr677484pjb.64.1601611937275;
        Thu, 01 Oct 2020 21:12:17 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id c185sm149929pfb.123.2020.10.01.21.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 21:12:16 -0700 (PDT)
Date:   Thu, 1 Oct 2020 21:12:14 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Jeff King <peff@peff.net>, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2 05/13] reftable: utility functions
Message-ID: <20201002041214.GE3252492@google.com>
References: <pull.847.git.git.1600283416.gitgitgadget@gmail.com>
 <pull.847.v2.git.git.1601568663.gitgitgadget@gmail.com>
 <4190da597e65bce072fa3c37c9410a56def4b489.1601568663.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4190da597e65bce072fa3c37c9410a56def4b489.1601568663.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys wrote:

> --- /dev/null
> +++ b/reftable/basics.c
> @@ -0,0 +1,131 @@
> +/*
> +Copyright 2020 Google LLC
> +
> +Use of this source code is governed by a BSD-style
> +license that can be found in the LICENSE file or at
> +https://developers.google.com/open-source/licenses/bsd
> +*/
> +
> +#include "basics.h"

Git's source files start with #include-ing "git-compat-util.h"; how do
we approach that here?

E.g. would we pass -include on the command line, or could we #include
some kind of compat-util.h that #include-s "git-compat-util.h" in Git
and does the appropriate steps for enabling feature test macros and
including system headers when used outside?

[...]
> +int binsearch(size_t sz, int (*f)(size_t k, void *args), void *args)

How does this compare to stdlib's bsearch?

[...]
> +void free_names(char **a)
> +{
> +	char **p = a;
> +	if (p == NULL) {
> +		return;
> +	}
> +	while (*p) {
> +		reftable_free(*p);
> +		p++;
> +	}
> +	reftable_free(a);
> +}

Are there other callers that need custom free?

[...]
> +int names_length(char **names)
> +{
> +	int len = 0;
> +	char **p = names;
> +	while (*p) {
> +		p++;
> +		len++;
> +	}
> +	return len;
> +}

The rest are probably easier to evaluate when I look at the callers, and
it's time for me to go to sleep now.  I'll try to find some time soon to
pick the review back up.

Thanks for a thoughtfully put together library so far.

Jonathan

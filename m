Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9471C47094
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 01:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B002961130
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 01:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbhFHBrT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 21:47:19 -0400
Received: from mail-pg1-f179.google.com ([209.85.215.179]:46920 "EHLO
        mail-pg1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbhFHBrT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 21:47:19 -0400
Received: by mail-pg1-f179.google.com with SMTP id n12so15224371pgs.13
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 18:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TcYIJuxmc4Dxb1NtMM8DF3BygGgkwVqd2IMQ/pdQlFg=;
        b=jXT5Bl8rem1CO/ag1A4GsZrNpYTVq7Yv4/wFLqSp9hfWKE4wSgmyIEpKoPj4KufNfN
         JS9AKuczOqE17XxAF9n/wzRfviMrgCGdlP7iv6Rjs5H3mg78VZHYf6hI4AIudLFsYdBc
         9lNLsnQfauwqbWGP0+xhzAdNooN67oVqDm15LVTNUXdMT8eAb76OoUVIoqjWiPiqNNwl
         uYnRqn6sa7d3CTkAAqaYxwZyZiNjCCsZYpu2pvOaIYT2eJG0iag3cbF+pMg/ILUv5PXJ
         hDnR9x7mB612IeC/17PUPF0qIhgQhKbXfNXqtSDTS9/KdYhoc5/gsmOYpZ94vXxL0q9s
         kVvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TcYIJuxmc4Dxb1NtMM8DF3BygGgkwVqd2IMQ/pdQlFg=;
        b=V0EuJEqrxyndO30Ut1SCtiUNz5DAOIwhfO5XDrFtHeaWtRID/FNrTPQ12y06BqbBYC
         8ii8Z999UY93H5kJYery122/2ixTaIW1U+MPqPVjRjPO8zbkMYLbfr6d/JM2yXgZzJcs
         2BauATlPlVZhJanQLMggwtlDRSZBleYDjkDo7eAhingao4TpV6dyF8FIj5GfmDIlb00e
         nsDPwEuGckcdiQpSPm+4S2Nxu0xhoFRXHsU1w8ugjRcv+MA8VLZvr3CFjE6L1ux11j3W
         OtYz8zJHiuEFdodbq5np/0zIedmWSNdx5TqF5Tc/btR7o1DyYeibq9soQpWgmY2LRAVL
         pUaA==
X-Gm-Message-State: AOAM531qqHBfxcmgdAE3TNZ4+wZiPYvNug5dNBzgxsyvflGA0edNE5P7
        MLw4zu+MbCgg0lbalqqXLD1+jM8sbUnrlg==
X-Google-Smtp-Source: ABdhPJx9i9JhEYdllH3ErDqLF2ouE8psY4tWYWi4tluRHvZTjQL3GlopNVzNU5CVyU+hjXcssvTZKg==
X-Received: by 2002:a65:64c8:: with SMTP id t8mr20302894pgv.96.1623116651194;
        Mon, 07 Jun 2021 18:44:11 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:2096:9338:a9c3:81da])
        by smtp.gmail.com with ESMTPSA id y27sm9281841pff.202.2021.06.07.18.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 18:44:10 -0700 (PDT)
Date:   Mon, 7 Jun 2021 18:44:06 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/4] First steps towards partial clone submodules
Message-ID: <YL7LZtuEqE69OS3M@google.com>
References: <cover.1622580781.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1622580781.git.jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 01, 2021 at 02:34:15PM -0700, Jonathan Tan wrote:
> 
> This is a preliminary step towards supporting partial clone submodules
> (e.g., by cloning with --recurse-submodules and having the given filter
> propagate to submodules). Even with this patch set, we won't be there
> yet (notably, some code in Git access objects in submodules by adding
> them as alternates - so lazy-fetching missing objects in submodules
> wouldn't work here), but at least this is a first step.
> 
> This patch set would also be useful if Git needed to operate on
> other repositories (other than in the submodule case), but I can't think
> of such a situation right now.
> 
> As mentioned, there is still more work that needs to be done. Any help
> is appreciated, and as for me, I hope to get back to this in the 3rd
> quarter of the year.
> 

I see there's a v2 that came while I was still reviewing, oops. But
overall I like this series:

 - It's small
 - It does reasonable code cleanup which benefits the codebase on its
   own
 - It paves the way for a series later on without being part of that
   series, meaning that the later series will be slightly smaller
   because of it (a lesson I should learn for myself)

Thanks. I'll try and review v2 later in the week.

 - Emily

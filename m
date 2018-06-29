Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE50C1F516
	for <e@80x24.org>; Fri, 29 Jun 2018 21:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932119AbeF2VjE (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Jun 2018 17:39:04 -0400
Received: from mail-yw0-f172.google.com ([209.85.161.172]:46165 "EHLO
        mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752883AbeF2VjD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jun 2018 17:39:03 -0400
Received: by mail-yw0-f172.google.com with SMTP id g123-v6so4193850ywf.13
        for <git@vger.kernel.org>; Fri, 29 Jun 2018 14:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=buBlVEWCY7MIko0osM7DOaAP2t7eXSjxfwJ9QTvzPzs=;
        b=mx4AfptWVv0dfqiC4sJuZfVK14AUOcMW8gIGA17cIsY0mMK1IioC3UYgo0OdYiSA0B
         Vz3eNb1D7je8JNZ0190vlHdvaCezUbNoloGMqNMqToxAp+5eHll5uEwT4OaWDKXmk7jt
         YEitXEiLXlxv04HKvy5jdcFXaQTtbGKprqf1n7YP2ATEioLPDkBTW/Pp+wC4kAgdNnRc
         ba9f9pIB3oX6BFzDiC9SUp6TLEQjxsnuIaP7lF0jKtpnA+MzLc8qa+XQyKY9VdGpyUBm
         cZskwCQeTLB4lEXEFHA5RtxJLhqeyEryJGE2XdLNe/pxDMOlJYfboSKT5aHo3XbMXEva
         ZsQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=buBlVEWCY7MIko0osM7DOaAP2t7eXSjxfwJ9QTvzPzs=;
        b=Gs57avi0eV6XnjA6dTLP3TJ7V6EdY82joku6od2tfXh2Dw7ubSYNqjkdMqvk4Ktppo
         V4jxsEe9loDyy8gjBUYSFqUo9hqhLy/Vrp8nQ459TqNf1PouZxEJ78/Q0CJh80Zny0mD
         /rRWmfHShT4bbJQ/XvLOmb44OxGyivmTW38xVvVE3QSuA9ORsxrXHq43oal+dKXDg1QW
         f3ahYAu8FVuA2hxjV4EYJkUjpewzLpjqAwyhx4ZiSBT89JTsDmlbINHrGy0QNS+HiCqe
         nrJhh2wdN5EQFBeXxhiCU13oLw3w1mXyGqFGzpWhQbXU8d1FFIAj3bMdtLRUMG8eTV6v
         HRdQ==
X-Gm-Message-State: APt69E1+qZ6HyaokEQ+eBpky8nY6BB+PuyYUBtO3rHLRiX4Q0gQRCIjI
        u+i9UddLImvOQg61jJxpga1x+HVTMY7+CVGJH5+s/G7B
X-Google-Smtp-Source: ADUXVKItN0gvIbSBGHiB2KMJXDB4tHudRbLUPLHNCr/R1biHntQwOqrZDfrv3X4JT1bFMntE6q/ksu609REjY+sECE0=
X-Received: by 2002:a25:cc97:: with SMTP id l145-v6mr8455768ybf.334.1530308342000;
 Fri, 29 Jun 2018 14:39:02 -0700 (PDT)
MIME-Version: 1.0
References: <20180629161223.229661-1-dstolee@microsoft.com> <20180629161223.229661-4-dstolee@microsoft.com>
In-Reply-To: <20180629161223.229661-4-dstolee@microsoft.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 29 Jun 2018 14:38:50 -0700
Message-ID: <CAGZ79kbMks+U94-==SB48DoSpYQOpa-bn_yJBjW7zH3cCCotng@mail.gmail.com>
Subject: Re: [RFC PATCH 03/13] commit-reach: move commit_contains from ref-filter
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Derrick,

> +struct ref_filter_cbdata {
> +       struct ref_array *array;
> +       struct ref_filter *filter;
> +       struct contains_cache contains_cache;
> +       struct contains_cache no_contains_cache;

These members also seem to be moved whitespace-inconsistently.
Could you clarify in the commit message that you re-indent them or
what happened?

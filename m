Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3833BC433DF
	for <git@archiver.kernel.org>; Fri, 29 May 2020 00:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A31B2078C
	for <git@archiver.kernel.org>; Fri, 29 May 2020 00:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gnTr+nKg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437618AbgE2AUi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 20:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436651AbgE2AUh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 20:20:37 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D59C08C5C6
        for <git@vger.kernel.org>; Thu, 28 May 2020 17:20:37 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id r10so421754pgv.8
        for <git@vger.kernel.org>; Thu, 28 May 2020 17:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=U5g/vqwSMvX9qLYnmJPRtm3m2v81Vk1Pi1+wQU/HCms=;
        b=gnTr+nKgFiiDoOq6Pi1eTYzVjQ71AIgb6RCDFQfrX2J+YtCo3oNG5gCkYL340URsKS
         b4UdL58xaRLBm4G05X6SjFTYK9OQ4kEx8v5Xy9VhTbepASCePUuxqyVFUPBSTREpIFSj
         cQ9G8umKVui/DgFajvC0G9tB+11GDlIVwFPEfOJjvoTr89mBkFslY1Yj5yQQQFmviHZB
         ffY7sOBnq0bAztOy5QKgzMDHpFUnDH+s4C+RzJXfuoDC3OMxL3Z9YRQdaytuvwyqISPd
         r+3cZ3LJswOtTA6NngBDD6TI5ATCt8PWGiv+I70ic7+cKWKDsk3vzChSp2bEdayyTjZC
         ZwIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U5g/vqwSMvX9qLYnmJPRtm3m2v81Vk1Pi1+wQU/HCms=;
        b=tHorWuUrbKAExCKBvyAJDYtFoFH4Ya8BwEgQ/DE6F6AMEdO/UXR+DjO3waEWUDvDET
         LebUbmZ3cjAfW5qFRbquLkguEJxUKge+84ukTwPpG3hr3xgN17CjfZlz/H0wVJxhWdfa
         AliR45xZbmuV/ccAVu5OPUA+EcDfVXnWEdMiDRaH1j6S6UCtGgBcDGQWmw01qWtRKE9S
         3HOZb5oZLFKcItJuyMQXHlt6aibTRnpDW1IzVApLH01TIQCQCvYX6Q2BcUKQJ5Lq5rZ/
         f4aRSTdpFb0DHjx+VPI1AcpJbHH54dk3DHPn28xlgoeqY/FVmdAsUE+auRdoQRmEkAmN
         2qDw==
X-Gm-Message-State: AOAM530U8N4jKGCLhrlwGTIP86Uk/fqEqYT+6ydWI+wJdSdsyi2erv8k
        2uiMqlV1LAnZlczxRoKFvng=
X-Google-Smtp-Source: ABdhPJwnUaOoYnj1+UJZ5BYR6uGcFPEapFJEQTdpBeLpORDVQdcIyFisrMX7rwovX7cIubuwmLlfqg==
X-Received: by 2002:a65:68c9:: with SMTP id k9mr5513674pgt.77.1590711636771;
        Thu, 28 May 2020 17:20:36 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id a27sm5317986pgn.62.2020.05.28.17.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 17:20:36 -0700 (PDT)
Date:   Thu, 28 May 2020 17:20:34 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2] fast-import: add new --date-format=raw-permissive
 format
Message-ID: <20200529002034.GC114915@google.com>
References: <pull.795.git.git.1590693313099.gitgitgadget@gmail.com>
 <pull.795.v2.git.git.1590698437607.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.795.v2.git.git.1590698437607.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren wrote:

> From: Elijah Newren <newren@gmail.com>
>
> There are multiple repositories in the wild with random, invalid
> timezones.  Most notably is a commit from rails.git with a timezone of
> "+051800"[1].  A few searches will find other repos with that same
[...]
> Provide a --date-format=raw-permissive format that will not error out on
> these otherwise invalid timezones so that such existing repositories can
> be imported.
>
> [1] https://github.com/rails/rails/commit/4cf94979c9f4d6683c9338d694d5eb3106a4e734
> [2] https://lore.kernel.org/git/20200521195513.GA1542632@coredump.intra.peff.net/
> [3] https://github.com/newren/git-filter-repo/issues/88

This could potentially go in a Bug: footer.

> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  fast-import.c          | 15 ++++++++++++---
>  t/t9300-fast-import.sh | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 42 insertions(+), 3 deletions(-)

Makes sense.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.

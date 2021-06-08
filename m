Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-28.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88402C47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 17:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 662236136D
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 17:23:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232414AbhFHRZs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 13:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbhFHRZs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 13:25:48 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CFCAC061574
        for <git@vger.kernel.org>; Tue,  8 Jun 2021 10:23:55 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id x21-20020a17090aa395b029016e25313bfcso591154pjp.2
        for <git@vger.kernel.org>; Tue, 08 Jun 2021 10:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hw2U+KNj1AgPY//Mox/4AfITgUogGKXmFOQ8OrB+zbc=;
        b=oJARwQGOnxzgwSZIWs5Fs6CjcjRhnCy10dNuzz0ZGZwb/JMDPoCygfE16qtbTRoQay
         kIvj4Gg9cArJE4eUvIp5S09qkxfnYQJmuDXCEIBcS8XMfnaAL4JAzWjZW30OuteN3noy
         SAnqUGQZSwL3sL2Eevu2c9XkcaZSb7kd1G//v7NVykLOSd1+2Z1QNPmLntOkQ+aae4wc
         3TBU2BEyr75AJj7Jbe5Mp+W84VnwHXRN9gwzFJzB+WcZysa69IrHwR8Jy5DnRxYDa9AH
         FEC71ESrxtUocFhXp0fD3j7nXcoEH6gxwcHezgv2iMm3iZuAr3RH+khxj/sfYIqqWnpN
         mvPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hw2U+KNj1AgPY//Mox/4AfITgUogGKXmFOQ8OrB+zbc=;
        b=LvGMJYSpD9xygGK6AYRX9bmnN8fMRR3fHyFa5DO8GI1C6fRJ78ZJBB3stVi0FrzfRV
         DCHfGmfnZji+fW8MSkGFZdYIIjWOOm+Abqk8JCrFwwEuqO8BBZGlVPUjYR1tuGI5O6Tf
         cT5EieZTTvV15gQRjAwavbOXxBTASSv6b7Sz+08Os5Q9VgIuvONKJ/lXDEk5CI195CnU
         ewSWojxmYtWtfIDtB877TeCscQ2Us8cvGE6b/Q2ktwka9mXGXsOzXWVjCYPdYk/Uod0x
         t56CiiTpRLZ/mEb+CPCqDNutg2m7txuvd2SeCLbFGsVRFOMJnIQOE8I7NY51AhLuqoUB
         w/5A==
X-Gm-Message-State: AOAM531jawMNa7gYWGPPn5EpIW33B/6w8ZWG986T08HVCWeupVjNZWE9
        1PoKA+A8jSH/AXI7AIA/NgEEmA==
X-Google-Smtp-Source: ABdhPJxFbJoaNLlZu/aCZa3dmPXXjoSjDAyhhd1u7Wnqu7G+l+ODzB+NUzlGsuML9l1Qs8nU5A4CrQ==
X-Received: by 2002:a17:903:4106:b029:fd:9cea:7008 with SMTP id r6-20020a1709034106b02900fd9cea7008mr684917pld.47.1623173034669;
        Tue, 08 Jun 2021 10:23:54 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:f819:e238:f61a:a961])
        by smtp.gmail.com with ESMTPSA id c21sm11282443pfi.44.2021.06.08.10.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 10:23:53 -0700 (PDT)
Date:   Tue, 8 Jun 2021 10:23:47 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] MyFirstContribution: link #git-devel to Libera Chat
Message-ID: <YL+nowMI13hFzMyI@google.com>
References: <20210608135114.71104-1-raykar.ath@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608135114.71104-1-raykar.ath@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 08, 2021 at 07:21:14PM +0530, Atharva Raykar wrote:
> 
> It's pretty safe to say that most of the regulars on #git-devel are now
> on Libera Chat. This will help new contributors find the right place, if
> they choose to ask questions on `#git-devel`.

Ah, I forgot to say - it is probably better to link either to the
mailing list discussion or to the IRC chat logs than to say "It's safe
to say" in the commit message.

> 
> Since there seems to be no way to directly link Libera's web chat to
> `#git-devel` directly, I have put a generic link over the text 'Libera
> Chat'. Users will have to manually type `#git-devel` in the webchat
> interface, but that should be obvious enough to not be worth mentioning.
> 
> Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
> ---
> 
> My heuristic for determining "most of the regulars are on Libera Chat" is the
> fact that the last biweekly standup happened there.
> 
>  Documentation/MyFirstContribution.txt | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
> index af0a9da62e..cd9e2069d4 100644
> --- a/Documentation/MyFirstContribution.txt
> +++ b/Documentation/MyFirstContribution.txt
> @@ -47,7 +47,7 @@ Veteran contributors who are especially interested in helping mentor newcomers
>  are present on the list. In order to avoid search indexers, group membership is
>  required to view messages; anyone can join and no approval is required.
>  
> -==== https://webchat.freenode.net/#git-devel[#git-devel] on Freenode
> +==== #git-devel on https://web.libera.chat[Libera Chat]
>  
>  This IRC channel is for conversations between Git contributors. If someone is
>  currently online and knows the answer to your question, you can receive help
> @@ -826,9 +826,9 @@ NOTE: You can typically find someone who can `/allow` you on GitGitGadget by
>  either examining recent pull requests where someone has been granted `/allow`
>  (https://github.com/gitgitgadget/git/pulls?utf8=%E2%9C%93&q=is%3Apr+is%3Aopen+%22%2Fallow%22[Search:
>  is:pr is:open "/allow"]), in which case both the author and the person who
> -granted the `/allow` can now `/allow` you, or by inquiring on the
> -https://webchat.freenode.net/#git-devel[#git-devel] IRC channel on Freenode
> -linking your pull request and asking for someone to `/allow` you.
> +granted the `/allow` can now `/allow` you, or by inquiring on the #git-devel IRC
> +channel on https://web.libera.chat[Libera Chat] linking your pull request and
> +asking for someone to `/allow` you.
>  
>  If the CI fails, you can update your changes with `git rebase -i` and push your
>  branch again:
> -- 
> 2.31.1
> 

Return-Path: <SRS0=R7wA=DM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D55D1C4363A
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 23:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DC14206B5
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 23:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EdSL/Ji5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgJEXaT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Oct 2020 19:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbgJEXaT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Oct 2020 19:30:19 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C59C0613CE
        for <git@vger.kernel.org>; Mon,  5 Oct 2020 16:30:19 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id y20so289529pll.12
        for <git@vger.kernel.org>; Mon, 05 Oct 2020 16:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TOKiCHRw0gPzLt3XU5sylJ85jR6R2nFv5bUuXMe7xc0=;
        b=EdSL/Ji5n8LR5jz1uw7dxDA9t+VULzUHittP+JT5uUCmEoYrsn/gR3nCLbGLj7DnSc
         Wx/TguBxdP1PNlJklOyDG7za0gLZ/jXSbvOUl868TKLEr/DBUplB7tSCzuxopSObkRY/
         5qP8qTmQTKXi/oX9td+3uKRvrG99q25eXXWTFk4c47/rJwwVm87aq+RHea17nyp2U8mE
         Oyot0lKO7FNs7OfA8X13seKyBqsOgv0wY5Yp1FtSQUIgpjtyCesqYhJQsL1OES+adW0G
         S88jNLhbmtxFuFR32zBgkaDtw0ecboFq4ohFWFZvsb3PHeVXqroqqE84B2Srwxj5AJPO
         a+yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TOKiCHRw0gPzLt3XU5sylJ85jR6R2nFv5bUuXMe7xc0=;
        b=NFdUKkL1d6C3QlV/5q3bV/wj/rQVHZsp5egIOH1xK73+IBAvXVp6jdCptyyc+8uUDy
         B4kM05anJelFTUg0uhr6lMFoVJQIHaClc+Lyq+ihwEVtf7U1Fp1UNXf8Nc119Zq7hjrT
         Yn8CNFextgBuJMt+UZx2SpFH4Ywa2bSviOpDdgHahGOgzo2wr2yF6OipVysgVRuvxmCK
         FJ5+OU/I3YevDo33M1aq6a8q4oPO+TxLHBXu2BqJ1W9bfKfsuLfMXKOrYrg7YemxU+Jd
         lW8VIcfyFiN8IrLX2NvREGijqJdoCR3rtXoJ5amuRt4mVEGbh7V7tV5pmUgNz8TtUQNs
         Alyg==
X-Gm-Message-State: AOAM530KuZLQ5tlkvyy1qmf5tr9r/Nf0YqQ2TiOCjyP9GVWke6MeAtbb
        4jfDISb3dT5fN+3nU9FsuTPqBNPercY=
X-Google-Smtp-Source: ABdhPJw3lbxbh3rEK8Blj/Kz/sQ8PX/34mPJtJPmNHlRC9uR0Y2i/srGcByAUuMV3DBAhEKHTbBFmg==
X-Received: by 2002:a17:90b:3798:: with SMTP id mz24mr1697156pjb.46.1601940618978;
        Mon, 05 Oct 2020 16:30:18 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id x16sm1109324pff.14.2020.10.05.16.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 16:30:18 -0700 (PDT)
Date:   Mon, 5 Oct 2020 16:30:16 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 5/9] parse-options: parse into strvec
Message-ID: <20201005233016.GC1393696@google.com>
References: <20200909004939.1942347-1-emilyshaffer@google.com>
 <20200909004939.1942347-6-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909004939.1942347-6-emilyshaffer@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer wrote:

> This is useful if collecting generic arguments to pass through to
> another command, for example, 'git hook run --arg "--quiet" --arg
> "--format=pretty" some-hook'. The resulting strvec would contain
> { "--quiet", "--format=pretty" }.

An alternative is to use OPT_STRING_LIST and then convert in the
caller.  One advantage of that is that it would guarantee the behavior
with --no-arg etc is going to match exactly.

I prefer this OPT_STRVEC approach nonetheless.  Can the
parse_opt_strvec and parse_opt_string_list functions get comments
pointing to each other as an alternative way to encourage that kind of
consistency?

[...]
> --- a/Documentation/technical/api-parse-options.txt
> +++ b/Documentation/technical/api-parse-options.txt
> @@ -173,6 +173,11 @@ There are some macros to easily define options:
>  	The string argument is stored as an element in `string_list`.
>  	Use of `--no-option` will clear the list of preceding values.
>  
> +`OPT_ARGV_ARRAY(short, long, &struct argv_array, arg_str, description)`::

nit: this should be OPT_STRVEC

Thanks,
Jonathan

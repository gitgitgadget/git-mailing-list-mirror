Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A7AC4707A
	for <git@archiver.kernel.org>; Tue,  5 Apr 2022 21:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384057AbiDEVqo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Apr 2022 17:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457192AbiDEQCz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Apr 2022 12:02:55 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D02D1570A
        for <git@vger.kernel.org>; Tue,  5 Apr 2022 08:32:02 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id ch16-20020a17090af41000b001ca867ef52bso2369518pjb.0
        for <git@vger.kernel.org>; Tue, 05 Apr 2022 08:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ok0bwYKB1wbk/CVeW8Dx/D6at400/MSwDFcV9ewNvKM=;
        b=qO3zcs/SLRWrGd6I92OBUpTszfaQ6N+rihB/WN8Ah32cv5KHQOjk80bq238WzHHjML
         JIOJ7vjfgy4ee/MPVImIwSxXvEvk/w6phGXRUYepJHI4daq2SNJrtOCjsbJSPCeVa6a3
         s8Vd6oyht40/TvaH/GvwSbklQvC30fMAdvf0K/Zr88zoQ8dmfKx1QaeN7usZO6do6hLF
         LggzRewScgsigFWpvnKE4uFOGsdum393fPmxZX6+liL9m8Ohj7E7DVbO9Luk9kI1wJ83
         4FAIp5twdTHzMtY8auCq3nznxI4kiYDuCOHTLqSsRaSJBZMYYWIsWN90sOD8555uOEh8
         t2ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ok0bwYKB1wbk/CVeW8Dx/D6at400/MSwDFcV9ewNvKM=;
        b=68HiE4jmo7xgkgrCUB97fc8xGBNND/dkxpFh1Hwf4vtuMc32YVZTrVQ+97MgecD+O9
         YQywLMVkl1t8fOWWB4o7BAYYcIZW0Ij5uSLBp8XbvVe99zg+pKb73GUWAr+cuW1Uai2f
         aIloSR1hxcbNDoG/TDA5ozX9lWj12bhbF7GdbvSUlER9oA8D8jQw6I6ExjYqLdE2LjC7
         OAZlwfpx1+I7SFv5aj8BUtuii2AsKYoNwpssPpGDr/Hmz8FDDVgs1s57C2uu19NhmLfT
         5ppcTMvtXVDiLNq5ONAKe4KmQyyIqpx7hEvAJa7xo2B0Orsb9zjCAJSFRD92a/4VG9HI
         T20Q==
X-Gm-Message-State: AOAM533zwix/pmAhTsHv1VnM1rehYBN4QIgj9HC9hutLfS4dX3r6XPnR
        9RL87Q/us2kTON236ZLfoAg=
X-Google-Smtp-Source: ABdhPJxLUMdPJpFjF3o0UneuXZFBgfBpKpLk6OgrfwMjveK3//TLp9LXieY/ZVZ+snLUNZqzXNRfbQ==
X-Received: by 2002:a17:902:b488:b0:156:509c:5c42 with SMTP id y8-20020a170902b48800b00156509c5c42mr4067076plr.2.1649172721660;
        Tue, 05 Apr 2022 08:32:01 -0700 (PDT)
Received: from neerajsi-x1.localdomain (c-24-56-226-231.customer.broadstripe.net. [24.56.226.231])
        by smtp.gmail.com with ESMTPSA id 34-20020a17090a0fa500b001cabffcab2csm2744212pjz.55.2022.04.05.08.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 08:32:00 -0700 (PDT)
Date:   Tue, 5 Apr 2022 08:31:59 -0700
From:   Neeraj Singh <nksingh85@gmail.com>
To:     Adam Dinwoodie <adam@dinwoodie.org>
Cc:     git@vger.kernel.org, Neeraj Singh <neerajsi@microsoft.com>
Subject: Re: [PATCH] configure.ac: fix HAVE_SYNC_FILE_RANGE definition
Message-ID: <20220405153159.GA22458@neerajsi-x1.localdomain>
References: <20220405100020.48663-1-adam@dinwoodie.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405100020.48663-1-adam@dinwoodie.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 05, 2022 at 11:00:20AM +0100, Adam Dinwoodie wrote:
> If sync_file_range is not available when building the configure script,
> there is a cosmetic bug when running that script reporting
> "HAVE_SYNC_FILE_RANGE: command not found".  Remove that error message by
> defining HAVE_SYNC_FILE_RANGE to an empty string, rather than generating
> a script where that appears as a bare command.
> 
> Signed-off-by: Adam Dinwoodie <adam@dinwoodie.org>
> ---
>  configure.ac | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/configure.ac b/configure.ac
> index 6bd6bef1c4..316a31d231 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -1087,7 +1087,7 @@ GIT_CONF_SUBST([HAVE_CLOCK_MONOTONIC])
>  # Define HAVE_SYNC_FILE_RANGE=YesPlease if sync_file_range is available.
>  GIT_CHECK_FUNC(sync_file_range,
>  	[HAVE_SYNC_FILE_RANGE=YesPlease],
> -	[HAVE_SYNC_FILE_RANGE])
> +	[HAVE_SYNC_FILE_RANGE=])
>  GIT_CONF_SUBST([HAVE_SYNC_FILE_RANGE])
>  
>  #
> -- 
> 2.35.1
> 

Thanks for fixing this.  Looks good to me.

-Neeraj

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC302202DD
	for <e@80x24.org>; Thu, 13 Jul 2017 00:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750923AbdGMABX (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jul 2017 20:01:23 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35332 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750805AbdGMABW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2017 20:01:22 -0400
Received: by mail-pf0-f195.google.com with SMTP id q85so4959430pfq.2
        for <git@vger.kernel.org>; Wed, 12 Jul 2017 17:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jBLoO4LIO1riVxVKqxaDgc2ckJMKvR6Na/UQhiAA4Uc=;
        b=gIsaMcA6VR/Xx14R/vTB2N6ZxxFlCbEsjxdmXt27ZEjmnU4tpuFg2S8EPXNXUB+JzW
         14s2Kc+CsfAijDQOz2Gqbufm3PKMjYTVrH4/KQfP+0RfHgh3gx4pbkNyIpnQbO3jHHdF
         r9L+/E0WaPVRexZsZ15jHy/GnaN6rhDU5MbxI/BqiBMuIXWltWC8C1mc39miQmaXqUqN
         38rySsznvvPsQon+JOiJRo2nGsL/dumAPIBTtCYdO3n+nGpdLP8eopmtQ7qmbK9uaAhK
         te2DDKBuBf4L8d7qMzD5WNghHA2OtiHAqz4hOl94S4YtXqMyB2pqySxayd06hn0iIu4X
         jmQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jBLoO4LIO1riVxVKqxaDgc2ckJMKvR6Na/UQhiAA4Uc=;
        b=PKLqrXaUx3fNBe+rEzVSsFpzasVdJxQBAwi2X/1L6jhA2iBhKf2UuKF2pl40oQk/dq
         JgL0z8CfuNvmPOwe+crFvgQeyoORZBPD6P4c8KuHOwnDtY+r5cFK6NZUsQjWBu3oxbC7
         keU6oQKB8HhM68Jf0aC4JODOsunmrwjBHRjBOAc7jTVwyMvT9vxEapi1lqHLopMFQ9WC
         oR8PPLkKJsjaHnA3y0gVlrg3I8GG7KbFbMrsOlgcVbslxnlrntLAm7T1KSLLDbL92/Q2
         ziUousy6G5Okv9xLs9I0q42C1ocQUwAKK9dYzRofP0Wx72MfMvtJN+bH8qdCvHfDPRYG
         kWJQ==
X-Gm-Message-State: AIVw112OzvTAV61saU1u4Teu27CW+SjEiK7QJsJZMFdg5D1OGoeNOqlu
        VkrNHReJCRjPMGbK7RY=
X-Received: by 10.99.186.83 with SMTP id l19mr6185855pgu.44.1499904081410;
        Wed, 12 Jul 2017 17:01:21 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:25ad:9264:1cd0:bb62])
        by smtp.gmail.com with ESMTPSA id e124sm7704972pfc.76.2017.07.12.17.01.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 12 Jul 2017 17:01:20 -0700 (PDT)
Date:   Wed, 12 Jul 2017 17:01:17 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] submodule: use cheaper check for submodule pushes
Message-ID: <20170713000117.GJ93855@aiede.mtv.corp.google.com>
References: <20170712234504.15811-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170712234504.15811-1-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Stefan Beller wrote:

> In the function push_submodule[1] we use add_submodule_odb[2] to determine
> if a submodule has been populated. However the function does not work with
> the submodules objects that are added, instead a new child process is used
> to perform the actual push in the submodule.
>
> Use is_submodule_populated[3] that is cheaper to guard from unpopulated
> submodules.
>
> [1] 'push_submodule' was added in eb21c732d6 (push: teach
>     --recurse-submodules the on-demand option, 2012-03-29)
> [2] 'add_submodule_odb' was introduced in 752c0c2492 (Add the
>     --submodule option to the diff option family, 2009-10-19)
> [3] 'is_submodule_populated' was added in 5688c28d81 (submodules:
>     add helper to determine if a submodule is populated, 2016-12-16)

These footnotes don't answer the question that I really have: why did
this use add_submodule_odb in the first place?

E.g. did the ref iteration code require access to the object store
previously and stop requiring it later?

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  submodule.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/submodule.c b/submodule.c
> index da2b484879..55afad3e8c 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -976,7 +976,9 @@ static int push_submodule(const char *path,
>  			  const struct string_list *push_options,
>  			  int dry_run)
>  {
> -	if (add_submodule_odb(path))
> +	int code;
> +
> +	if (!is_submodule_populated_gently(path, &code))

Should this examine the code to distinguish between hard errors
(e.g. "Error reading .git") and a missing repository?

Thanks,
Jonathan

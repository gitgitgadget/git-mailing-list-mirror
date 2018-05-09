Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35DA21F424
	for <e@80x24.org>; Wed,  9 May 2018 17:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965742AbeEIRRS (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 13:17:18 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:38096 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965617AbeEIRRQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 13:17:16 -0400
Received: by mail-pf0-f193.google.com with SMTP id o76so25959992pfi.5
        for <git@vger.kernel.org>; Wed, 09 May 2018 10:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ozl8FhfEgDt6M6qk+72sk/4n0Q6KJ1WlsCT5FjWfkpY=;
        b=YqCNTiV/PeVaah/iLmEluRFQc4AKvw/VmEE4AkISYdsHktR+ODSETCFVPumLcDbCYk
         E4zu7cNaa6VGi3viSs1vXmXe8SE5KWeJKUeBk9qgpDIRoACXpIBjL/NuPafzH2jht2vE
         9pzrCKRb1Cyy/4g+xuF9sl1HOjzooX6ISRMQUbk6fdUhbX+HfmWnz83qkgCmfNXNbH35
         jKw1OgQpJ+1hFXeJyFvCVAKHgT+kACBI0Ayq5gK3mbdMX/RO6xAnxfeVetjZSLW7NvxI
         UrVcYmRwsfdiR2MISeGLurOt/bk6HDzn+Fv35BZQWPlpkQSXfA9dZGmC2m6bVvPd2oCZ
         RlHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ozl8FhfEgDt6M6qk+72sk/4n0Q6KJ1WlsCT5FjWfkpY=;
        b=mGv6ub0jkf/DZZwmv7TqFn/UQl2zplqNDKD9yiNmRoMtFWjPh25tfPSTMJorouPz0A
         0Uc/+CqlLBaIAhpZVBaCJPJJajvQMmvQFRPGA7oGHy4YKyU41DRrbSC3UebE0WSuUnD6
         Cy9EgBnDWxilo6VF+97orm5NjKfqP2XS5Mx0U3vMQdSwgLuZfwPHeUNwL/MUXFoB2l6u
         ymOTYF+IpshJNflyBMVXR6Wti7o2xcoVdqHJUS5NhrB0R2mDk3kxeCzBC28bFdskJjk2
         0JkubaEGOSAqUpC6i5a79j6mLVg+K3JfMcM5oPY5qkTqOukM/zjz9Gmg1IOGRbh1oh9Y
         h3aw==
X-Gm-Message-State: ALQs6tATakKWDzn3M80hCKG5YCIdsXapbtj4AWezVySBApjDLVyRwmah
        0nbZgi2YLHmrbcF3SRYo/NUe5SoLMdo=
X-Google-Smtp-Source: AB8JxZr204TJkMUVUfVMaKiX6BcOaffRNDBzo8ua+jWzRDOvXnCHJql9tWHg0wLnarjN+uH7KbXY1A==
X-Received: by 2002:a63:6fc9:: with SMTP id k192-v6mr36892902pgc.143.1525886236204;
        Wed, 09 May 2018 10:17:16 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id q75sm57604867pfj.94.2018.05.09.10.17.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 May 2018 10:17:15 -0700 (PDT)
Date:   Wed, 9 May 2018 10:17:14 -0700
From:   Brandon Williams <bmwill@google.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] repository: fix free problem with
 repo_clear(the_repository)
Message-ID: <20180509171714.GA63423@google.com>
References: <20180509170409.13666-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180509170409.13666-1-pclouds@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/09, Nguyễn Thái Ngọc Duy wrote:
> the_repository is special. One of the special things about it is that
> it does not allocate a new index_state object like submodules but
> points to the global the_index variable instead. As a global variable,
> the_index cannot be free()'d.
> 
> Add an exception for this in repo_clear(). In the future perhaps we
> would be able to allocate the_repository's index on heap too. Then we
> can remove revert this.
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  I was trying to test the new parsed_object_pool_clear() and found this.

This looks good and I do hope we can get to a state soon where we can
not have to special case the_repository.

> 
>  repository.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/repository.c b/repository.c
> index a4848c1bd0..f44733524a 100644
> --- a/repository.c
> +++ b/repository.c
> @@ -238,7 +238,9 @@ void repo_clear(struct repository *repo)
>  
>  	if (repo->index) {
>  		discard_index(repo->index);
> -		FREE_AND_NULL(repo->index);
> +		if (repo->index != &the_index)
> +			free(repo->index);
> +		repo->index = NULL;
>  	}
>  }
>  
> -- 
> 2.17.0.705.g3525833791
> 

-- 
Brandon Williams

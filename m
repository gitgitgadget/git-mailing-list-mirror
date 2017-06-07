Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6390B1FACB
	for <e@80x24.org>; Wed,  7 Jun 2017 17:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751820AbdFGRpc (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Jun 2017 13:45:32 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:36645 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751817AbdFGRpb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2017 13:45:31 -0400
Received: by mail-pf0-f173.google.com with SMTP id x63so8082189pff.3
        for <git@vger.kernel.org>; Wed, 07 Jun 2017 10:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EYkpkHhTJrLaUafHFF53eQbXD3vQZauKAeGfdYOicBs=;
        b=MOGdU5DvFgTFIPdU41mDHOyh4tHbXWQuDmn9F4EJKR+sLIFNIBNqGe8y7mgAEBNX1h
         IvktiXeYd5g0gYvBLFIk+w6o3echpNYqM3wnUEUCYJXWx8O2+x67M7BW2+4iOF98fRwm
         eoMYROoVYbB2ziEv5Jtm3qHwYhfG1QqH/QSub57hSwLARW9yOYxZLGb+v80UpqmLT2yq
         jNvunQag5JY7vymQN08A8oaNXSQmQxRBBNbtp4y1WxBXgyZpoaW8QKkqeNpmBHCPgm9m
         XrsY7ZRZFHIpTW3ndEY+1QyO0ztt9R+Thn2PlZLcGxP2vw/r/H7M/s1OzRzJcMW9sg2C
         cVDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EYkpkHhTJrLaUafHFF53eQbXD3vQZauKAeGfdYOicBs=;
        b=mYDdzuARzL3t864rADKVVMgwqCH8dmOID+L9Cjas6DrSKPX0yE8blGSgq7GHYizK1N
         ZA3VHyiZ/h6peD5LlpqQiF4pco341Vw2N6tCEIN9428kUoMmpXIqjplwdXUhEHlyhWZ6
         q4cN+8h539bsVS2dYWDgK6fGXJoc59AxD+LjOOYVixaRHxgzlWuLlIxH6O60T09CtOQC
         SBxx2tiPazB3+xL7j9k9w3quV+YSid5l3h1JyUkWYmITr/uK1lt8fQ78KFEEpAn9F6SN
         TH8aegyGdcbskEleZu6qmPIMTl5FLYH1owy2M3aeElSssKA2+fxXEX/mPSb3nAhet+hJ
         E+iw==
X-Gm-Message-State: AODbwcAWm5vqsHrC+uC8+czuFuRowdSw1+5+BJkeoO42FFUbvTmcDji0
        EiIqhpVuW0yQEvxQywRY6w==
X-Received: by 10.84.209.199 with SMTP id y65mr29416347plh.205.1496857531155;
        Wed, 07 Jun 2017 10:45:31 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:793b:8a31:813b:ceb2])
        by smtp.gmail.com with ESMTPSA id o20sm4412963pfa.96.2017.06.07.10.45.29
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 07 Jun 2017 10:45:30 -0700 (PDT)
Date:   Wed, 7 Jun 2017 10:45:29 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/9] discover_git_directory(): avoid setting invalid
 git_dir
Message-ID: <20170607174529.GB110638@google.com>
References: <cover.1496851544.git.johannes.schindelin@gmx.de>
 <300d32d72b67f8c12b6cc91c36a5735a77f5ed89.1496851544.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <300d32d72b67f8c12b6cc91c36a5735a77f5ed89.1496851544.git.johannes.schindelin@gmx.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/07, Johannes Schindelin wrote:
> When discovering a .git/ directory, we take pains to ensure that its
> repository format version matches Git's expectations, and we return NULL
> otherwise.
> 
> However, we still appended the invalid path to the strbuf passed as
> argument.
> 
> Let's just reset the strbuf to the state before we appended the .git/
> directory that was eventually rejected.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Seems sane.  This way the strbuf is in the same state it was in before
calling this function (upon a failure that is).

> ---
>  setup.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/setup.c b/setup.c
> index e3f7699a902..2435186e448 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -982,6 +982,7 @@ const char *discover_git_directory(struct strbuf *gitdir)
>  		warning("ignoring git dir '%s': %s",
>  			gitdir->buf + gitdir_offset, err.buf);
>  		strbuf_release(&err);
> +		strbuf_setlen(gitdir, gitdir_offset);
>  		return NULL;

There is another part of this function that returns NULL (which isn't
shown by this diff) after performing 'setup_git_dir_gently_1', do we
need to worry about anything that 'setup_git_dir_gently_1' has
potentially appended to 'gitdir' upon 'setup_git_dir_gently_1' failing?

>  	}
>  
> -- 
> 2.13.0.windows.1.460.g13f583bedb5
> 
> 

-- 
Brandon Williams

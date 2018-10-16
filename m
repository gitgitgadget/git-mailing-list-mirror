Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D13611F453
	for <e@80x24.org>; Tue, 16 Oct 2018 21:05:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbeJQE54 (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 00:57:56 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35740 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbeJQE54 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 00:57:56 -0400
Received: by mail-pg1-f195.google.com with SMTP id 32-v6so248501pgu.2
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 14:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1LQVJ+Z0T46n1LGwrHNnYRUs9EcmQck9nfeevi12x/s=;
        b=dRgg32BEMfgSdJikhcCwDXFUaBxTqXjsEIjvbnF3kVIBhavpECdKaHOA/8F01OjYEv
         Vw8nKLJ63JkHOxi0dKhuuVOJKbycRvwJ9WaxdyQ+w3GCJ1RVfdJA6h7hZjPI3GZya+B1
         Bjg8XO1gTEqjDq/M6m2/aucL1K0NPDkAdbOULbYDSyUSHIJMmG0ochZrjq75dYqBJSqa
         BFBos5noo00yQ3W0qTbs+00SfC1cIgS7b13DiEgKR8SOcc9gNcrik81yk87Q3qKuqV42
         mxZKu0RZtfmmV8X530Wu4pkJNOEJZFVrTlmy54lHMIN9PR4K4y45RrVPg+vTwhOfEVgZ
         7f8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1LQVJ+Z0T46n1LGwrHNnYRUs9EcmQck9nfeevi12x/s=;
        b=O19fkfXrwPGfCNQ5eesHyex/lxOFU8Fb6rEycFk6o2DfQ/x2KnvCygdOQq5fqdyN/p
         yaKuibCyNgD0gvpXgHiznWV/ddH++KV/17diTUVf4XIJUSTKk6QKIASVvc617BfCJWsF
         9+twg9k7jfZhu3gdZwNY79HCsKUdYVZpJpE+Mc884kklz06Tx+waLMeZ+DSB1U9ehHF+
         A/Vst8EsxMCfBK5Ihqetc7DRshi//8tbtjwEFl97hh/HxQwaVSyvyi3fmwDIJ8olb8R7
         wz5mjXZj9MuZbzjM82rTSWmk+wGGrTTVv60YLrO2QnKUSf7GUCQGkW3zIz3x4X+m9m8J
         je9g==
X-Gm-Message-State: ABuFfojm8Z07Acwbrm8kTHmPo4sxGrAAcmnahFHM8w9jKsexQx6iOAGC
        tDb8y9/DWtDhOH8IX3+d3VaID2be
X-Google-Smtp-Source: ACcGV61wqerXEBN2BEXJUku9K1Ln9wVJcxpq8rbH3LySjPoOA18ywrzjlcC3RJNaP9+WMBqDRCVXYw==
X-Received: by 2002:a63:2b58:: with SMTP id r85-v6mr21421686pgr.432.1539723941497;
        Tue, 16 Oct 2018 14:05:41 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id i5-v6sm14848232pgs.10.2018.10.16.14.05.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 14:05:40 -0700 (PDT)
Date:   Tue, 16 Oct 2018 14:05:38 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org, jungjw@google.com
Subject: Re: [PATCH] submodule helper: convert relative URL to absolute URL
 if needed
Message-ID: <20181016210538.GA96853@aiede.svl.corp.google.com>
References: <xmqq4ldm1nh6.fsf@gitster-ct.c.googlers.com>
 <20181016172703.134901-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016172703.134901-1-sbeller@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller wrote:

> Reported-by: Jaewoong Jung <jungjw@google.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  builtin/submodule--helper.c | 51 ++++++++++++++++++++++++-------------
>  t/t7400-submodule-basic.sh  | 24 +++++++++++++++++
>  2 files changed, 58 insertions(+), 17 deletions(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks for your patient work.

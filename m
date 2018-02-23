Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C6231F404
	for <e@80x24.org>; Fri, 23 Feb 2018 19:56:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932295AbeBWT4K (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 14:56:10 -0500
Received: from mail-pl0-f47.google.com ([209.85.160.47]:36174 "EHLO
        mail-pl0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754793AbeBWT4I (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 14:56:08 -0500
Received: by mail-pl0-f47.google.com with SMTP id v3so5488253plg.3
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 11:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4AEiR7q44gUbvbkqDMrNr4Umgs1evpsvHyYbcIZ/LEI=;
        b=hr1cqfuYBbrbQtTDrMEsG97s2LPnSBvzk6qpiszbSHsMzU4FABs7xXEHELNS1M84mO
         y4LvFEVH4U/F7CVBwDbWpQP1pFwPxELajdDezLMhsLUq4JHYQw0ek4yn1GyxA5tRiLkp
         3alvUwvbtKI9i79zaTZvJJX/AGhwetcOsRqbgzlqSCyF7kfmNZVhFDR1dqFJLUQJlo51
         lmDY0j1V/aF+oKlfd4EHiJjru40VZEyr0d0J5WnAAbquJZh768ZldhCesE1d4PeOBn3l
         VK2Qe8fBkCa1vyCRI4tu0XJDrYfnOuxPAk+Iby9S/drnp4KZmecZKNa2JsrQDJoRjWzD
         Ch5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4AEiR7q44gUbvbkqDMrNr4Umgs1evpsvHyYbcIZ/LEI=;
        b=h9pe87a0pe2ujzi0WelktcNO4iBmlGWhC9s8+24xpyibEuWPu0QON45Awb+nGxa7eA
         +LqOXbiySIzH1vTmj9H21Q0ziLQ7rPf4k8pD+xh5RAG6hERbuC9uKADzoqsE2YUE6JhL
         nd/T16wfB0UclrB4PpdswR/bPJYvtLc6gb/c8Qohqrx30DgWfE/IK8QBh6ygfyBBtVwj
         xbSS2MRh+Z92YwyRJB0grKej65jZF6RnQGrMmFTAhIfNl2Z79ocG8wlducs9/AsvGk6/
         AsKdFUD3G36UXLO1NlGnpnTS+Zwu6rVMewm7bMPY+wCN198gaccRtKi4JycOlcmb0r2w
         WHow==
X-Gm-Message-State: APf1xPCcp785rPCqmLiKhfW/ABjIOAaLYKScR/qDAfDDobZycmcK66WH
        6wvb/jf1NoUXzvsaR9Sen2bRpQ==
X-Google-Smtp-Source: AH8x22535Pp81u6kv1TxARNh++YfEcYSWfQPhwhAAWCORQYZmcaVo4MHQrOPnAB+s13zMqXWITC0JA==
X-Received: by 2002:a17:902:6083:: with SMTP id s3-v6mr2661760plj.6.1519415767379;
        Fri, 23 Feb 2018 11:56:07 -0800 (PST)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id k12sm1122518pgr.75.2018.02.23.11.56.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Feb 2018 11:56:06 -0800 (PST)
Date:   Fri, 23 Feb 2018 11:56:05 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        gitster@pobox.com, jrnieder@gmail.com, stolee@gmail.com,
        git@jeffhostetler.com, pclouds@gmail.com
Subject: Re: [PATCH v3 23/35] fetch-pack: support shallow requests
Message-ID: <20180223195605.GA234838@google.com>
References: <20180125235838.138135-1-bmwill@google.com>
 <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-24-bmwill@google.com>
 <20180223113722.ac4a8d3ef18bec31f20e79f7@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180223113722.ac4a8d3ef18bec31f20e79f7@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/23, Jonathan Tan wrote:
> On Tue,  6 Feb 2018 17:13:00 -0800
> Brandon Williams <bmwill@google.com> wrote:
> 
> > @@ -1090,6 +1110,10 @@ static int send_fetch_request(int fd_out, const struct fetch_pack_args *args,
> >  	if (prefer_ofs_delta)
> >  		packet_buf_write(&req_buf, "ofs-delta");
> >  
> > +	/* Add shallow-info and deepen request */
> > +	if (server_supports_feature("fetch", "shallow", 1))
> > +		add_shallow_requests(&req_buf, args);
> 
> One more thing I observed when trying to implement the server side in
> JGit - the last argument should be 0, not 1, right? I don't think that
> "shallow" should be required on the server unless we really need it.

Good catch, I'll fix that.

-- 
Brandon Williams

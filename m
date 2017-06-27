Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDCC8207D2
	for <e@80x24.org>; Tue, 27 Jun 2017 00:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751460AbdF0AGF (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Jun 2017 20:06:05 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34974 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751449AbdF0AGE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2017 20:06:04 -0400
Received: by mail-pf0-f195.google.com with SMTP id s66so2284850pfs.2
        for <git@vger.kernel.org>; Mon, 26 Jun 2017 17:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Xb46AUaiXWdpbA3/EyGOrCbeDtpvUC2iGspNm2RI1SU=;
        b=jjNiqxYumaS65A1u6aezcx9iNeZpHEaW5u6kLICOJorbiDcTK8/WUs+qzgxJAIRwG/
         ogj/fJrmVhxWug0rWNjICdmLxItVkaUjWJ12rZ91eCyWvzTZfTba/6+WV8UjaH60jWfS
         R8+aVHa6sCfXfyJ65vYqGJqNg2Cuwaf+M9iBNh/RdFaBiQd+ZuWqwBFjknGkVAEy2fhP
         fXDoURzQy8cH5M5iOpC1YnI1dkMW8z4zeeF2z9ZQyMUhMJlcpYel+Bkr+Oo12mQ0PWxO
         t4iJBtzWmCwLIT1pEQWGNLXtGIntwe2mbkBmNqxKcDFZzv/UOdIYPFOugnz97nQ10isI
         PJbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Xb46AUaiXWdpbA3/EyGOrCbeDtpvUC2iGspNm2RI1SU=;
        b=Coh+y6986M1AqpKI/DoV5C0qGVGSSpJ5X9W4N0qZ5/RBJ3QPW1VLRrPK/MFfjEF8yD
         Ft2fBhnXb+9r450866jA5qcQfCZOzN6hU84zWR3J6jj//C6cPuVGNdqV8jp9WsqBkcq1
         WghTHugbdRjw64ITV+nT/ZRoXSiZD+tf7Bhp5kRUX7dcMrOwTm2K+yVMU8soqgx2eGHB
         7Mh/pnahw5FqB3SkK53XG98GP9AhLiejjZ+yCp0ZjCkd2K6urO4ocHBGN40qpEh/U9a9
         k0ZegHdR6lbW+/uL0ciWMQtHAN/dHhLiBzmOqbpv6A37BFgwaBS8RqCSSgqm69FsF0mI
         QlzQ==
X-Gm-Message-State: AKS2vOyddYYNxq/s1rRZu/mJsygAEsovYirGMLFcWXf/NTJ7cOF1TDq3
        eVp1bPQw1h0MRw==
X-Received: by 10.84.192.3 with SMTP id b3mr2816518pld.76.1498521963594;
        Mon, 26 Jun 2017 17:06:03 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:5069:b7fd:dcb0:fd8c])
        by smtp.gmail.com with ESMTPSA id l85sm1971366pfj.130.2017.06.26.17.06.01
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 26 Jun 2017 17:06:02 -0700 (PDT)
Date:   Mon, 26 Jun 2017 17:06:00 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     James Clarke <jrtc27@jrtc27.com>
Cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH] pack-bitmap: Don't perform unaligned memory access
Message-ID: <20170627000600.GD161648@aiede.mtv.corp.google.com>
References: <20170626151612.64019-1-jrtc27@jrtc27.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170626151612.64019-1-jrtc27@jrtc27.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

James Clarke wrote:

> The preceding bitmap entries have a 1-byte XOR-offset and 1-byte flags,
> so their size is not a multiple of 4. Thus the name-hash cache is only
> guaranteed to be 2-byte aligned and so we must use get_be32 rather than
> indexing the array directly.
>
> Signed-off-by: James Clarke <jrtc27@jrtc27.com>
> ---
>  pack-bitmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Failing build log:
https://buildd.debian.org/status/fetch.php?pkg=git&arch=sparc64&ver=1%3A2.13.2-2&stamp=1498520310&raw=0

Thanks for tracking down and fixing it.

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C27720323
	for <e@80x24.org>; Wed, 22 Mar 2017 21:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751523AbdCVVQH (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 17:16:07 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34720 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751502AbdCVVQF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 17:16:05 -0400
Received: by mail-pf0-f193.google.com with SMTP id o126so28648158pfb.1
        for <git@vger.kernel.org>; Wed, 22 Mar 2017 14:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TEnuNKlqtyb395T8tPDJQV/yWpKE4tmJWfqczNI1RxE=;
        b=XIxHX4RZUZcYzKhiA+zUgKgw863qLst8pC6xiUhbXOtSTRG2hPddv8ot1bwSt5J5y+
         tImiRXSRXjKtVtoq5KQMF6LolqCcwtKPoxbukprihnvUv0CcZkVLF2TAViwDqaolN9DC
         ptGjzTAM1mRsIJWXtHoV4Yb4WNAUFSH8n6QljZ0lm5iULe7LcsVMdTllTSl4xqni7MHo
         6smZmSAzY7jOxXEB1EhChblJjQBHbQH9dwzLSitC5Irb+O5i8olWYC9x3ts57k74bd8C
         ZGXHhrXT6r2jhz2EOyo4XI3sUVsjDkwysvWkKHJoDp5lsm9/jn8yK51pdaiE72ksd8h0
         tSSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TEnuNKlqtyb395T8tPDJQV/yWpKE4tmJWfqczNI1RxE=;
        b=snBbwNzc1ImIV1OFPWKtTWjdjMcGwGDu3ocX40v5WCbVyQ0w6o+4J76ftd32nUriBs
         Z2WY71jaQ0Q9aRLv2Ajbp1iHtxn2bPMymFpe7zOzFsfbGdygAVmoSTcCyghNuAYHCkcL
         lKUiLIe4QVxOJjTD672Ztn1Twq+IiaEdn84ndFODBSUWJ24phvyipIXYBrE6v7Lzwm4P
         7Cx4JWyoXTMxEIrePsyyjlrHHLgag0radpEtZXkFOOna9Ud4WC1KG7nwfChUn2Y0TJ2e
         O7DhLdzV6GywjWdlOGsmAySbjqg2Phf2mlLRy2gIPC/LexUeNj6asIu9ai2FnMvMD7t+
         SfLQ==
X-Gm-Message-State: AFeK/H0pXt8/sUYZH4OW7ppqky0B8Zlffi6CTbGioxwPt1+NpvN9kBAXTgJFRjx9mu4CnQ==
X-Received: by 10.99.96.68 with SMTP id u65mr21911956pgb.159.1490217348595;
        Wed, 22 Mar 2017 14:15:48 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:55f5:992d:bc78:c749])
        by smtp.gmail.com with ESMTPSA id q194sm5688626pfq.43.2017.03.22.14.15.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 22 Mar 2017 14:15:47 -0700 (PDT)
Date:   Wed, 22 Mar 2017 14:15:46 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] send-pack: send push options correctly in
 stateless-rpc case
Message-ID: <20170322211546.GB26108@aiede.mtv.corp.google.com>
References: <20170322195102.165314-1-bmwill@google.com>
 <20170322195102.165314-2-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170322195102.165314-2-bmwill@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams wrote:

> "git send-pack --stateless-rpc" puts each request in a sequence of pkt-lines
> followed by a flush-pkt. The push option code forgot about this and sends push
> options and their terminating delimiter as ordinary pkt-lines that get their
> length header stripped off by remote-curl before being sent to the server.
>
> The result is multiple malformed requests, which the server rejects.
>
> Fortunately send-pack --stateless-rpc already is aware of this "pkt-line within
> pkt-line" framing for the update commands that precede push options. Handle
> push options the same way.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  send-pack.c | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)

This is only a hypothetical issue until the next patch though, right?

For what it's worth,

Tested-by: Jonathan Nieder <jrnieder@gmail.com>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.

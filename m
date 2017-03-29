Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F13420958
	for <e@80x24.org>; Wed, 29 Mar 2017 23:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753290AbdC2XJb (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 19:09:31 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:32923 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754078AbdC2XJa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2017 19:09:30 -0400
Received: by mail-pg0-f67.google.com with SMTP id 79so5391889pgf.0
        for <git@vger.kernel.org>; Wed, 29 Mar 2017 16:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yGraruVa3r3FVzpN59XwZdDH6Q2H9H8Y7V3NHqTM8nU=;
        b=TZBMnYrM/puZukR4XgC0X2GyxRPiSX0RXUn30lCIssZstDmUla6qOkHEql3FmA5c+a
         sBkhdsRO5FRW9/G89OOYjG5QVBT+rcibrFMNLchCP5pPP2rhzmK9ql/GxlWEKIY0yJxt
         7AnGyfEiBdU/msxkCb09W1lMCuYBvIr0TuK3meVHpdGPNqFEvQgHsOtvyFGnWC6jicxj
         kKpLao01QsftxbjrIgZBwDMx4kcOsYaFJNKMJd9p/8IjgyaoWiHRHv7IW7vUmMF7XHuf
         QtkAlbypYmTlz1AKcjUwS5UMz9gxIq0znRgnCK+zinKvCKS6JJQVHFcQAnWph383nX7U
         isSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yGraruVa3r3FVzpN59XwZdDH6Q2H9H8Y7V3NHqTM8nU=;
        b=nzka2JrpbJz8geOHh4icEfBeYtvUIb19sRTa6Bsd9WBwgMrE93EBvjwSyFixGrF4OH
         83j0P40+OBDeEcUFwPre9lHpR8rODdPXFoYlVW6u6iy94Xi7ogVMer8tjRr+k5pUzrK1
         DyhZJBq73L809yFJwZ2D2SvkmQvq/VM2hTMjpAEuJXjFT7Oa4ij+amve3EjOa6B8mGGd
         It7dwh1FeoAz1ZpTuvb0D8B3u7/NXAHgyXj9xScBgcISq8UBdnoL0rwSGPn6PnioLpFE
         WKh/R4SHT2aUxigu/ayCKTZ9FMH7SRPschHYJ039sOcPpksnf1i/w8nQh26UxZl4X7tB
         evrA==
X-Gm-Message-State: AFeK/H3vYZkoaNrSj7dzQfLqWHmhLWxHvQaS9+Lo1uJITLbuz4gDpHYCnlFPEg9i8k0gsg==
X-Received: by 10.98.38.198 with SMTP id m189mr3080391pfm.124.1490828968723;
        Wed, 29 Mar 2017 16:09:28 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:1cae:64a4:6d7e:ad6f])
        by smtp.gmail.com with ESMTPSA id s12sm298832pgs.12.2017.03.29.16.09.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 29 Mar 2017 16:09:27 -0700 (PDT)
Date:   Wed, 29 Mar 2017 16:09:25 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH 1/2] short status: improve reporting for submodule changes
Message-ID: <20170329230925.GY31294@aiede.mtv.corp.google.com>
References: <20170328230938.9887-1-sbeller@google.com>
 <20170329222616.11077-1-sbeller@google.com>
 <20170329222616.11077-2-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170329222616.11077-2-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller wrote:

> Signed-off-by: Stefan Beller <sbeller@google.com>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
>  Documentation/git-status.txt |  11 ++++
>  t/t3600-rm.sh                |  18 +++++--
>  t/t7506-status-submodule.sh  | 117 +++++++++++++++++++++++++++++++++++++++++++
>  wt-status.c                  |  17 ++++++-
>  4 files changed, 156 insertions(+), 7 deletions(-)

Yes, this looks good.

Thank you,
Jonathan

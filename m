Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC9B320966
	for <e@80x24.org>; Wed,  5 Apr 2017 21:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755941AbdDEVfy (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Apr 2017 17:35:54 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35230 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752690AbdDEVfw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2017 17:35:52 -0400
Received: by mail-pg0-f68.google.com with SMTP id g2so3812653pge.2
        for <git@vger.kernel.org>; Wed, 05 Apr 2017 14:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GEmpTGIUu3rPwV2GpSEXDyjS6mcNMGzdEt8Jf//FXBM=;
        b=PERDWnINuL0gD8HgvLuCsDNug1kdnVtiEdNZSzR+lLYrsXwtECGzikfO8Q67RaUE7b
         Vf6eL31CqQrOWGAdB0jchxUbFk1wLdq7Jop6d9X/iF81wi9xQHFz2u1nSnnvfAELNDRI
         CLoAH39EWnm24PKztP0NAyCxCcQNVpBge+7oN/nX/SEhMIaqBUf1L1qFQFp1Px9B0l7J
         yAWqbgqxMhn8/4kmlFZ6eTSN+QngeSaEzfMIb3GMJ22B1Wdq8nuEBu5hoahMCbpxYJwK
         Jd6WPDnSel8owb1ijaf5TQnjVjwdWu50InlLp3MdqSRXXhvir8KIH6y8x65uwKQZNDeZ
         tvBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GEmpTGIUu3rPwV2GpSEXDyjS6mcNMGzdEt8Jf//FXBM=;
        b=HYwZUMwR5nTKwtcgXKmdBxfpNT8dkS1+3YovKC8l/iMw9FdVZQKIGQI6dcHH5ssOxe
         9O244nYjj740numnvsGGV7nd3CZ04Xqsa8qwUF8YN6mlHBX9tiFA93v91/DtZLMc0L+y
         SjKcLipYBfxVvPu5EX6Je2/bbG4Z+yr6DOPOaudOZCiv4Vxb9bs21329nxYNCqST+ZhP
         4MjsFp8C6Y/+jwBvYimB0iQ9Yn//21AUy4edmGqLqQHIwIRYTV5zyd7VyViq7bRMgtAM
         /ZJ/04tVP95X/QKhir+v9m9R5ylMphBmaArGIC+BdyZgAN/avrCaQPTwxW0Ox0VfblPK
         6ucg==
X-Gm-Message-State: AFeK/H0Rs08C2KeV18/0NFIr2tI/e5nT4JASKVDSN2VuwgdV2GQDT4vezDmfQ66766LmzA==
X-Received: by 10.99.168.5 with SMTP id o5mr32506215pgf.19.1491428151460;
        Wed, 05 Apr 2017 14:35:51 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:55a8:b4cb:debd:758b])
        by smtp.gmail.com with ESMTPSA id v17sm39386011pgc.20.2017.04.05.14.35.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 05 Apr 2017 14:35:50 -0700 (PDT)
Date:   Wed, 5 Apr 2017 14:35:48 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@jeffhostetler.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 1/2] string-list: use ALLOC_GROW macro when reallocing
 string_list
Message-ID: <20170405213548.GI8741@aiede.mtv.corp.google.com>
References: <20170405210920.56549-1-git@jeffhostetler.com>
 <20170405210920.56549-2-git@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170405210920.56549-2-git@jeffhostetler.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git@jeffhostetler.com wrote:

> During status on a very large repo and there are many changes,
> a significant percentage of the total run time was spent

nit: s/was/is/ (see comments on v1)

> reallocing the wt_status.changes array.
[...]
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
>  string-list.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

With or without that wording tweak,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D84522036B
	for <e@80x24.org>; Tue,  3 Oct 2017 22:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751188AbdJCW7W (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 18:59:22 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:47245 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750841AbdJCW7W (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 18:59:22 -0400
Received: by mail-pg0-f52.google.com with SMTP id r25so3131304pgn.4
        for <git@vger.kernel.org>; Tue, 03 Oct 2017 15:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=wFa1IWwAlgonJJER1oO2IP1awaIPPyYu2g2CJZ20ybg=;
        b=RbeHEWYTe/YgpVADkdagt0y2larv+b+IYgtMbVHFH4hlT0RK3xOBlePfzwBAo9D2oF
         +UZ5VaYfbrNcZXtHJ7I+Fs+dnrno3UKoyi9VvbxwfRtIhoc4s3gG0Ew1TGYn+BBDSV5I
         WCps0pZWgxVEsQrXdx0Jy33aYMvEXcz7OVsAd03zrDqfZPGN5GSCP4hIXKgV7S7bKKAp
         AdHsIQRrxWcu+9dRzWjds62CZxYMB+sGDFmwW2Rbt9zOhLvaIw3Tl4m1Y2B5jH8uxaQc
         jOklabmskJy0wG34SYsCI333ZYUWUot4hL0kxGUnwJ/VpO94CDHyWApb73naoARtMCUi
         xQtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=wFa1IWwAlgonJJER1oO2IP1awaIPPyYu2g2CJZ20ybg=;
        b=XevXrSB5LvmzBvptCAlb72EIofOZ5Ykebmg/uJc4yWIldhhcz5De3kZr1MLtog/7Rz
         GLsv9QWk4tzjBgiO/iOOgD5k9pjsr7b+SMPnjrntQw9nf76KeDuhmawxCzEZm5JutLyc
         DAaOc8PlH3hydCbkz2Ac3sFHZojH0e3B8IIRPF6ZbuhpWQ36P+rNE3Mul7nWqG36/kzI
         j5/jb5kG1Dcpd7rP1m8hm3KO3TxD3KDHv/pAYWfh0V5V+HDgHCGjZqAXeUeH8COe5LjM
         oOrD3gYyx+j4ZtuRyPjbWa1TuG1Xr9VeBzjom7ZNFn1/f3zGWxMRVqXzIxMTDxuFmvJz
         nN9g==
X-Gm-Message-State: AHPjjUhWFNpDHMcs/2QS+59ouRGqyqRD+8284S4G44FhIwJKZP3XLKiv
        EI+5NA+RULZqc+dZI8A3Iz/gmj0K
X-Google-Smtp-Source: AOwi7QAx7J3lnifAcnycJkbpSxgtUDF6Z5unDmVCWJDb8WSgFGTyQiR4oArrAbMDQPwCfEwwjsgG4Q==
X-Received: by 10.99.110.12 with SMTP id j12mr16815536pgc.163.1507071561544;
        Tue, 03 Oct 2017 15:59:21 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:3463:ab6b:5863:927c])
        by smtp.gmail.com with ESMTPSA id e76sm23174134pfd.149.2017.10.03.15.59.20
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 03 Oct 2017 15:59:20 -0700 (PDT)
Date:   Tue, 3 Oct 2017 15:59:19 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] test-stringlist: avoid buffer underrun when sorting
 nothing
Message-ID: <20171003225919.GF19555@aiede.mtv.corp.google.com>
References: <16d3a84c-b695-a55d-0263-885d0d34ae95@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16d3a84c-b695-a55d-0263-885d0d34ae95@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe wrote:

> Check if the strbuf containing data to sort is empty before attempting
> to trim a trailing newline character.
>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
>  t/helper/test-string-list.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks for fixing it.
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

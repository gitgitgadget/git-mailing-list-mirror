Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C6A91F4C0
	for <e@80x24.org>; Sat, 12 Oct 2019 15:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729392AbfJLPYI (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 Oct 2019 11:24:08 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34234 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729069AbfJLPYI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Oct 2019 11:24:08 -0400
Received: by mail-lj1-f194.google.com with SMTP id j19so12617426lja.1
        for <git@vger.kernel.org>; Sat, 12 Oct 2019 08:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=J7pKy4H8wfxuVRICr7pN3o3rpBvG/Q/ywUAB9aerWSg=;
        b=F+YRrg7TTlB03JTXLOHnqWf7SgKEncSgu/yHY19gEj3Ada4N9tPoY01a7Ukk0eXmb2
         IPzsCd2m4IAMFuhxvhtbGwrDR5eGZI+G2iS7ShL1PvHgESAKzGw2BwdyF80RHyo0opUE
         Y6MroguusuFoHXO6tRpuX300cYdeXxkB9iXhSyLohkXneG1+oT96AqC6SvtK265XHMLB
         UTUmX5TLnpayg13H6Xrjtm6UMufg5y0QZk7jKyOc9ss1KFIjk+gRWG2PtVMtmAfz63tb
         sQQJiSx21B40p4mYRDzjJTzE6I5fmhLMMRaH7WQ+Fu+4y7eULdCuxxmjVj9QvaFeql89
         1DGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J7pKy4H8wfxuVRICr7pN3o3rpBvG/Q/ywUAB9aerWSg=;
        b=iblNl9wJ6svkoGnW5Jwcqeo3a8sWd9ZfMdOv7fUa9V0aAKjB1z42mI9kg9gBbAilc7
         qm6JHYB1BHfDSED78L+NsAzlA0YU3GPOQFJ1SHup/xPF4s4C4Ixp/U3txVadxpnMtf7G
         ZH1c/NZMLjrUIvw27wDJyyK6VFTgjqzkvXHKerq7KJtP/9W1rwKRx9QDlPfqBoyw810y
         xavZ9R5PDoJS0yURJyh9Ma+q8Fw/zp623Qfyct+hIsXtEgTWr2XHcvKQm1dYKm4vBzOv
         8nDOUztjR5OrnSrTkOZPcBsNzPZ+QCKyQFUBnjq4Yh0bP0PWDvib94d3K/WUNmRqdQgW
         vLfA==
X-Gm-Message-State: APjAAAWwCFfOIGW8NVOOJUkitqMiAG0Z+Mr8mRRW91DCSTyRRkodueOj
        7KohwZxTYnJqRZxGAPnuTzY=
X-Google-Smtp-Source: APXvYqw9EXA1iwbY9vcwqO0jcrRC2ZtAalTurwaXTfjD8k+mkOShfDQaNI/GRtMpv14fLnx+JS2euA==
X-Received: by 2002:a2e:5d5b:: with SMTP id r88mr12514918ljb.170.1570893846250;
        Sat, 12 Oct 2019 08:24:06 -0700 (PDT)
Received: from OJAN-PAAVO.localdomain ([213.80.106.30])
        by smtp.gmail.com with ESMTPSA id 21sm2668593ljq.15.2019.10.12.08.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2019 08:24:05 -0700 (PDT)
Date:   Sat, 12 Oct 2019 17:24:16 +0200
From:   Jakob Jarmar <jakob.j@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3] stash: avoid recursive hard reset on submodules
Message-ID: <20191012152416.GA743557@OJAN-PAAVO.localdomain>
References: <CA+xNDHtVc7pJr=SdihKDKiLE9TE_TcpEWWmPq+N9+fFcfM36wA@mail.gmail.com>
 <20191011001114.GB640501@OJAN-PAAVO.localdomain>
 <xmqqeezjhlad.fsf@gitster-ct.c.googlers.com>
 <20191011222448.GA650182@OJAN-PAAVO.localdomain>
 <xmqqsgnyenwj.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqsgnyenwj.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 12, 2019 at 10:46:36AM +0900, Junio C Hamano wrote:
> > +	git init sub &&
> > +	(
> > +		cd sub &&
> > +		test_commit sub_file
> > +	) &&
> > +	git init main &&
> > +	(
> > +		cd main &&
> > +		git submodule add ../sub &&
> > +		test_commit main_file
> > +	) &&
> > +	test_when_finished "rm -rf main sub"
> 
> Have test_when_finished that removes main and sub _before_ you start
> creating sub and main.  
> 
> When the &&-cascade breaks anywhere, the control may not even reach
> your test_when_finished that registers the clean-up procedure.
> Imagine "git init sub" succeeds but "git init main" somehow
> fails---you still want to clean up "sub".

Ah, of course, will fix this (and the other point as well).

> Other than that, looks reasonably well done.  

Thanks. This was fun to figure out and fix.

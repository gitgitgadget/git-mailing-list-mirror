Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BE591F463
	for <e@80x24.org>; Fri, 20 Sep 2019 18:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405210AbfITSOM (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Sep 2019 14:14:12 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39273 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404864AbfITSOM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Sep 2019 14:14:12 -0400
Received: by mail-wr1-f66.google.com with SMTP id r3so7720551wrj.6
        for <git@vger.kernel.org>; Fri, 20 Sep 2019 11:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=r1df0zfrjVcttzN+s57E4eZ4P/42jfN3+7cuMKCxVbk=;
        b=PidD/EL8rdYHPMZmJ92fobCw1Q+yqfTFLCQG67bCrubYAOZkDpf78hBSzVbfM6It3o
         2iVj7MbGeUSiuuLr9LjAb9p+g9wUR/pIOFQK9IaegaI97zi7C7KAG7BAVlicN4Bx0fF0
         O76+gLdUjShfn4ewGkhZR2ZKq7oGsPrERC+39ecSTZyMGf7bp4aTQ74ayy+pRsPmBOXp
         zVIlUKPYpusUDfglmx4bi5JvglLOh5rDLRHJ5izljEuwUYvqrAes60G4eClg4+wjaLTV
         s+9mU/awrZ77oQm8GRJr/y/vS6Gzjg44Nhjdouj8eoqqnwFmoswl+0nonrydmYJCYF13
         aIZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=r1df0zfrjVcttzN+s57E4eZ4P/42jfN3+7cuMKCxVbk=;
        b=AyYc6Oji5neGngA9IfX+l+xDFQaPHv3IK/TXENf8dXeJQEZliK1B1CLmQp2nSp+Zkp
         NPIAekdN68d1u0QQAYJyQhD2RelFY7l0MlndR3nB+z/gzKKoLSo69Jc1i/Lw9egb/LQT
         /madE90mHVEvi/vnOCjexRl9J01mbVeaDW/hg1Dcxay0WgJ5pMiPslT9NgJeBIiRNXYJ
         5DjmA79XHhPfl6y29MrbU63lOWSKoYUgZiqFVSz9T1Rr3FrH9BFCpEgh1j5FDGVeUtZo
         /OwGRF/VNkEGU6yVGL2Q0ooMvdX3iynHnyQmu+kkz/5l248gd9NLezZk4ePcuYSf9bJo
         mu5A==
X-Gm-Message-State: APjAAAW8u7EhMAIyrQISBqbAYE/lqAbYmmoC8sCHxkSEvLCM/LJCKSdi
        qiV57pchF8zFu1lnxF+yA1w=
X-Google-Smtp-Source: APXvYqxtwg1NMfwV066/JtlYoj3KyE5RP1g+zUY6p3BEhcgOFZdIF2gutVBUHa3U9gNPMQpc8llcGA==
X-Received: by 2002:adf:db0f:: with SMTP id s15mr12424549wri.120.1569003250197;
        Fri, 20 Sep 2019 11:14:10 -0700 (PDT)
Received: from szeder.dev (x4db40123.dyn.telefonica.de. [77.180.1.35])
        by smtp.gmail.com with ESMTPSA id h17sm5055086wme.6.2019.09.20.11.14.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Sep 2019 11:14:09 -0700 (PDT)
Date:   Fri, 20 Sep 2019 20:14:07 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 08/15] name-rev: pull out deref handling from the
 recursion
Message-ID: <20190920181407.GB26402@szeder.dev>
References: <20190919214712.7348-1-szeder.dev@gmail.com>
 <20190919214712.7348-9-szeder.dev@gmail.com>
 <5bf3b958-8c95-ae3d-1ae5-df3d57272d8c@web.de>
 <20190920181302.GA26402@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190920181302.GA26402@szeder.dev>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 20, 2019 at 08:13:02PM +0200, SZEDER Gábor wrote:
> > If the (re)introduced leak doesn't impact performance and memory
> > usage too much then duplicating tip_name again in name_rev() or
> > rather your new create_or_update_name() would likely make the
> > lifetimes of those string buffers easier to manage.
> 
> Yeah, the easiest would be when each 'struct rev_name' in the commit
> slab would have its own 'tip_name' string, but that would result in
> a lot of duplicated strings and increased memory usage.

I didn't measure how much more memory would be used, though.

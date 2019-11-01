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
	by dcvr.yhbt.net (Postfix) with ESMTP id 490711F454
	for <e@80x24.org>; Fri,  1 Nov 2019 00:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbfKAA32 (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Oct 2019 20:29:28 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52500 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbfKAA31 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Oct 2019 20:29:27 -0400
Received: by mail-wm1-f68.google.com with SMTP id c17so430036wmk.2
        for <git@vger.kernel.org>; Thu, 31 Oct 2019 17:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=V+3mf9cX8v9RtoiJqS4cqoMjaIDr/WR8dEzVKhKQKlo=;
        b=BUWyrJCDQkk63fyegwMpEOezT0CSweIioPb/lmjaBkgn2VGyOKTHTwJ+Cb5FpzVXdQ
         R1Y/hrUfh1u3uCrLKkGd/HHoxCrp07ocYsdcSei7q5G8LP7zMtl9D5x3OE+QxEuW/WuQ
         zN+JpvsntQz/wnbdervi6uWsTAanC8w40cAZeI+Xw5l9Vux22qPoK/aY5tlkNI9Hlnsw
         Sq3tEry3C4u0fy3/Qph46vWwG2UXtCty1XahbgvioC8R7vP1hRYlBSUlSFEUXRi0a+QG
         PbaoMAbxJyg4E/wuO+hThTOnDKxMQVgd22j2fezVhwpfmtAc6p+W6qJ4G9eg+Ll/0Akr
         iS7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=V+3mf9cX8v9RtoiJqS4cqoMjaIDr/WR8dEzVKhKQKlo=;
        b=mUQUWT03fC3e7VVpL9N/ofWiWnBU5esySF0JYKcqER3tOO16HCtJZS3VDHjbnaJBwO
         +VfSIuxV1ldMUzpoKEYHT8j3ruXa+Bg8HAZMiDF+mHBNury7pldLEIf66CuhxSbbJKmo
         LTSs60cLkInvk8WGvhGqM6rLK/gde0aods4uAOhZqM4DiCdSYdoEIGMHHoKtJw5Ryei4
         rYh3SjD0xuvqWX5JKEDKp6T0+3bnnK6/RBcpU7Z6Xzs7dnrmdvWkqnDYnL3svgthjSYg
         i6VMoo1JeC+mKn2FIGyfQrYj1kmupoulKVhExLe/fufqY44wVbaLIle2DYJmRzrMrlAb
         pSCA==
X-Gm-Message-State: APjAAAUeLdn9a8UR/sSxj66Wb+bFuizEIpHoamz9hA3ewvaPz9h3LRIN
        iIrnkfa/4Vi85GiRCP/X0J0=
X-Google-Smtp-Source: APXvYqwblJt+JhUwO83BOwB7pJRlzKibWwtqVvHL9TRlVNkGLzcZFsJPLY8L7OvFJJNShr0SkzZnRQ==
X-Received: by 2002:a1c:1d10:: with SMTP id d16mr8127102wmd.14.1572568166154;
        Thu, 31 Oct 2019 17:29:26 -0700 (PDT)
Received: from localhost (host96-200-dynamic.171-212-r.retail.telecomitalia.it. [212.171.200.96])
        by smtp.gmail.com with ESMTPSA id y3sm7579849wro.36.2019.10.31.17.29.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Oct 2019 17:29:25 -0700 (PDT)
Date:   Fri, 1 Nov 2019 01:29:24 +0100
From:   Davide Berardi <berardi.dav@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] Segmentation fault on non-commit objects.
Message-ID: <20191101002924.GC49846@carpenter.lan>
References: <20191029092735.GA84120@carpenter.lan>
 <20191029140621.GC2843@sigill.intra.peff.net>
 <xmqqbltz3qbc.fsf@gitster-ct.c.googlers.com>
 <20191031053733.GA10050@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191031053733.GA10050@sigill.intra.peff.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>Davide, do you have an interest in trying to make these code paths a bit
>more robust?
>
I've tried to implement your comments in a new patch, you can find it
at[1].  Sorry if this is not the standard procedure to submit a new
patch and let me know if you have new comments.

Thanks to all.
Ciao,
D.

[1] https://public-inbox.org/git/20191101002432.GA49846@carpenter.lan/T/#u

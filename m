Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC9151F859
	for <e@80x24.org>; Thu,  8 Sep 2016 01:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755260AbcIHBr1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 21:47:27 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35790 "EHLO
        mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754639AbcIHBrC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 21:47:02 -0400
Received: by mail-pa0-f46.google.com with SMTP id b2so11780648pat.2
        for <git@vger.kernel.org>; Wed, 07 Sep 2016 18:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=901E02R77Q/PO3IZ1QW22kPEE6SZI1OLWG6364Ip5MM=;
        b=f5O2iJ05PO/cpZzMjDLvKryO9FElCm12cdDS+kN6rKBAYVLrFTgYxF/2HCs7x3GIIJ
         sPU2RQua8wgSoy9ShkoD4kLD64FcyT/ZSYWxdUg26ZmgkInoEe6kkwvrunLacJxvb0CO
         sGImjSgayKiMtDF89eOR1fjM63jFw+FpiGhq3OJYFOzcwieectnZ4ARuh+z6Qpo/wOrQ
         eBJvMFAR2DEIzHG9ykWzPXc+TR6iFu/XCY7KJf///Vj45qGpVoSBkef9DijiaFcUgOEi
         PUK5qL9KPrSHmPTnVxq+lnDRVMqsGZ4MdYM/JAyifvxZMSbJRhGJzGpPd1VvYPc7H5Vm
         frsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=901E02R77Q/PO3IZ1QW22kPEE6SZI1OLWG6364Ip5MM=;
        b=CMKik4sibbCqbIg22zAFJtJZ3Z5fbDvoAT3vDc/0oy1h5tmeoedDyXKmg/IoFBe1/Z
         a+sbvC8mzL666dhCHvrmCbLFRP09WimYqn/ilRKPhNp2w2HojbSyPrxULAVIqbNK/vNi
         5NXRtbs6WZ67qTlgnEv0gDbYTbUeoTSLuDb9UyfeYJSwDhOQ8gCeBs61tSCdS+ngjJLY
         ud+DD9Rse4SjX/csC8CCzLl5MT3D8QczvRWTLXs9ls0UFL6nY6e8VedLLcl0uvVB0KBA
         BNIjEXazgsWfAiblORYgjianbqrk3FlIRpgRc0FmBlJXEsdyF5dh3eiYspJe6zg0aXri
         4vuQ==
X-Gm-Message-State: AE9vXwMm698aVd5lUn6kbzpNOWIDmrk6mEybfTeVlJYmkG8PecRotcMFdgW0u+rDqliv1w==
X-Received: by 10.66.161.225 with SMTP id xv1mr87045464pab.20.1473299221795;
        Wed, 07 Sep 2016 18:47:01 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:60fa:bcd3:3f9b:dd2])
        by smtp.gmail.com with ESMTPSA id g15sm15480696pfa.48.2016.09.07.18.47.00
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 07 Sep 2016 18:47:01 -0700 (PDT)
Date:   Wed, 7 Sep 2016 18:46:59 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, spearce@spearce.org, sbeller@google.com,
        peff@peff.net, gitster@pobox.com, Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH] connect: tighten check for unexpected early hang up (Re:
 [PATCH v3 2/2] connect: advertized capability is not a ref)
Message-ID: <20160908014659.GE25016@google.com>
References: <cover.1472836026.git.jonathantanmy@google.com>
 <cover.1473291819.git.jonathantanmy@google.com>
 <4b09bb7a5b7f4eb5fc31df3d98ce7ffc042eb367.1473291819.git.jonathantanmy@google.com>
 <20160908013431.GC25016@google.com>
 <20160908014555.GD25016@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160908014555.GD25016@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder wrote:

> Change-Id: I3cec2c160eb6c6f3efdce7dab38a4c78592f6c7f

Gah --- sorry about that.  Please remove this line if applying (or
I'll be happy to resend without it after review).

Jonathan

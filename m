Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BFACC433E0
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 15:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 370232070E
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 15:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5M8/YDB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732891AbgFWPWM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 11:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732781AbgFWPWM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 11:22:12 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C1BC061573
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 08:22:10 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id e2so9818259qvw.7
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 08:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4RX6jXMi//IxqIqXLHg1gMBD1cgMps9RYMQdDtgw1a4=;
        b=V5M8/YDBBNmv+Cx61IiKgeEHWOoppHSTItYYod3gRSbCYcplIkBxdi08gzujONGSt7
         SuucBDOmGSC8zRqs91a7WQ98X348E+5/cTNbMMtnUyP0SoDgn+SqkNrvh4xGOAuxb80y
         f+pIdcz2qDDvpti3Enw+0HIzHPSjiTKgTwGIqysCb7Lu2X6HfSFYX+CPW8Tl0h/KsIaq
         C76hHsbQyDQLecxjzTvl33p1eTu4/6ijtm+ukvgO20q0BbHKJEtoAlKYuU16oKBlsq3M
         B4H178rey9CqjeCDkuvPTiTkanxFDeFvgaexFEW2PQXLKtOQOuffuOuUwbd9IGHlLc/e
         HtRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4RX6jXMi//IxqIqXLHg1gMBD1cgMps9RYMQdDtgw1a4=;
        b=HCW04o/yrKC0a5GnVaDUNjyZ0EUsJQVgJyXREKYSujro1jY1FHS9ScYOxz3oCfHtM9
         rNS5qVvROk/IebCWZDJiav+o341TRtg0WXYcgAoO+iGg2jlWEhfD9iERuwqGjca2IW8V
         ibsvx+f6HOhvzSoc9Lc9RxA4zyUyrWYiTO0e/UM5qNGoIfk8sgkZ+hJDLpG+VH4spIzi
         cG0wIhzu9olE9aq9mBxpeYxIk6FqDM8/9VR5fDXMu44g1YqMOciBs8rnrnQ/1Ebre17U
         cQMviGz4WXjTTBSpMnfkwEyqWjoqc3DuGvO7eZoMP81NPZMBtoQ2R03OSQYEzVX5IE8+
         caFg==
X-Gm-Message-State: AOAM533FGI4VB+aTS6gWI92nCb059fk6x+nPUdRSnFDmSkt9Vq+1H0OJ
        hs1kbTwffFUYdhF0Xw9HI0Q=
X-Google-Smtp-Source: ABdhPJzx3euhszf02bkYApjy+nqP/9sGSbhgc1xJ5MVQOBa4oMvQFhP26P2ExTgr3y+j69xOD15+gA==
X-Received: by 2002:a0c:8482:: with SMTP id m2mr27297878qva.65.1592925729814;
        Tue, 23 Jun 2020 08:22:09 -0700 (PDT)
Received: from generichostname (CPEc05627352ede-CM185933998587.cpe.net.cable.rogers.com. [174.112.146.193])
        by smtp.gmail.com with ESMTPSA id k14sm846513qtm.38.2020.06.23.08.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 08:22:09 -0700 (PDT)
Date:   Tue, 23 Jun 2020 11:22:07 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Doc: reference 'seen' instead of 'pu' in meta docs
Message-ID: <20200623152207.GA2027104@generichostname>
References: <e250f1bb100aca94c914f1b2d38a3849c2566aea.1592909867.git.liu.denton@gmail.com>
 <nycvar.QRO.7.76.6.2006231708300.54@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2006231708300.54@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On Tue, Jun 23, 2020 at 05:09:12PM +0200, Johannes Schindelin wrote:
> Hi Denton,
> 
> On Tue, 23 Jun 2020, Denton Liu wrote:
> 
> > As of 2020-06-22, the name of git.git's integration branch has been
> > renamed from 'pu' to 'seen'.[0] Update git.git-specific documentation to
> > refer to the new branch name. In particular, update documents that refer
> > to the workflow and also "how to contribute"-type docs.
> >
> > There still remains other uses of 'pu' in the docs. In these cases, it
> > is generally used as an example and there isn't much value in updating
> > these examples since they aren't git.git specific.
> >
> > [0]: https://lore.kernel.org/git/xmqqimfid2l1.fsf@gitster.c.googlers.com/
> 
> Whoops, I only saw this now. In the meantime I submitted what I hope is a
> more complete version of this patch.

 No worries. I was on the fence about changing any non-meta
 documentation but, after reading your justification for the patches, it
 makes sense to me. Let's supersede my version with yours. 

 -Denton

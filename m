Return-Path: <SRS0=B2P3=AY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05241C433E1
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 20:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D48D320674
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 20:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594670454;
	bh=R2ida9PVUgURQuGPSBEI7msZem6wZNRg7Aviz1ZzTtU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Efs+JV4HfKce2xXKPnrX023gtLtiiNN69wd1130EU/l6pA+bmU4GZTmgm0Tkh5dCL
	 nMc3XIj2qbkuSyxkpUAxxk4Y8FwCjt2jFBDiD69xj9oytiw7TP6nb0h7jcAfsKjjYy
	 TSnKmcL65GbwbXwlSUHhV78rbb1KEs/wQLh0y9LM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgGMUAy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jul 2020 16:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgGMUAx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jul 2020 16:00:53 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB87C061755
        for <git@vger.kernel.org>; Mon, 13 Jul 2020 13:00:53 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id p7so6402053qvl.4
        for <git@vger.kernel.org>; Mon, 13 Jul 2020 13:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=cLzuDDnemoUgMLisMSdQttFRBX2EkRaT++EwrJpnxSk=;
        b=gdDnObawUBBmJpeUjFLXDwQDjfwNKI7KDQjl8ih6VoNDKQanjZ1FZGceXoOll3udvA
         JZLgS6pzKp+itDCXsGFyXLaUjOXmoXBhpnnDT0gLzyCw6yBtBvlo8FK29wBvCxflf4Vc
         IbBXOwmTHH7E9zOhu7Q3d5g8Vnw7vT7BsbqcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=cLzuDDnemoUgMLisMSdQttFRBX2EkRaT++EwrJpnxSk=;
        b=W5Is1kf9X0M2RVSWVpDPnzCyKo7fmWlsfCxXKkAxeWpiLWNtghYLBOa6113f4FdiBv
         8KipxRMFTayt8zrjjvNAoGxviIa4UJnHchjq1TIEfE08wf5/cBLbTcATeHfy/g8ay57s
         HQGVZVL5cmMdJOZnB0X7qNduZipwqMRtICLPN52RIpsgvzkhdKKNjKXVxSrGxu8Cnstd
         WminA5KqFiov929gMhXGRTIy8kqLRCF0dThdGnrXLSBolIPlY2JtMBuR+RUN/aWgIReS
         scmlzGrtSpa3cBqwi+EgpJj5jlULkEVNxOqSbY4NIqdbRoctGYb6EI5wpSokqA4g49Xv
         1j9Q==
X-Gm-Message-State: AOAM533m+gqgiL9pCwDPfHM9Tkrly8M3+zaI6suWwsi9R685aPKIzEl7
        tSBUo+bPNV7GOy1tSGeiLR+kipwCWnY=
X-Google-Smtp-Source: ABdhPJx9tQnddb8YCzx/+fkhwF3Ek60Sd96ePtMOiVqNwexs2AH9GWwJw12D1SXxOEVGQ94IhLJhtw==
X-Received: by 2002:ad4:5042:: with SMTP id m2mr1063031qvq.225.1594670452787;
        Mon, 13 Jul 2020 13:00:52 -0700 (PDT)
Received: from chatter.i7.local ([87.101.92.156])
        by smtp.gmail.com with ESMTPSA id e9sm19166045qtq.70.2020.07.13.13.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 13:00:52 -0700 (PDT)
Date:   Mon, 13 Jul 2020 16:00:49 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Subject: Re: FETCH_HEAD files and mirrored repos
Message-ID: <20200713200049.6a22nek4xckwtpt6@chatter.i7.local>
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
References: <20200711204849.khfbyundun7ujqzw@chatter.i7.local>
 <xmqqimetrcay.fsf@gitster.c.googlers.com>
 <20200711211915.h5bdgmbkisyc23m3@chatter.i7.local>
 <xmqqblkkr63u.fsf@gitster.c.googlers.com>
 <20200712202502.x4p2c7rf6ctflt5g@chatter.i7.local>
 <xmqqr1tgpibi.fsf@gitster.c.googlers.com>
 <79a56e7b-3c31-80c0-6a8b-807dcb4d5af3@kdbg.org>
 <xmqqk0z7nxs7.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk0z7nxs7.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 13, 2020 at 10:13:28AM -0700, Junio C Hamano wrote:
> > Nah, really??? It's one of the benefits of git-fetch that it writes
> > FETCH_HEAD and the primary reason in many cases where I use the command!
> > So, either I don't care that FETCH_HEAD is written, or I do use it. IMO,
> > not wanting to write FETCH_HEAD is the odd case and would need a
> > configuration tweak, not the other way round.
> 
> Yeah, that's even easier to arrange.  
> 
> Just the "--[no-]write-fetch-head" command line option and the
> fetch.writeFetchHEAD configuration variable are introduced and left
> off by default forever.

Does it make sense to add logic for whether this is done in a bare repo?  
I can't imagine common cases where a FETCH_HEAD would be useful outside 
of a checkout where a merge is likely to happen.

-K

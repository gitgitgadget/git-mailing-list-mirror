Return-Path: <SRS0=22YV=73=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 463ECC433DF
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 19:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 188C5206D7
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 19:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592162221;
	bh=F52cdG4uG03hmNLX7S3ed6TAlJvOqInyiBxyt8ooczY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=E17ELRFyLyosvq1Q8ZkZjS9UdBtn9cT1zuqZJtwy+5QfE0APDQ644aoJV9MNDaHMu
	 GfOKnYb2CUit1JN9ngiWqIF7yQPwmiBcmIyB1RskPtYf0f5GLf3EHaViYo+ANYabtw
	 QHSqc65t65hgfjkiDzAQ+vmsWX/xMyz9auzsi0TA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgFNTRA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Jun 2020 15:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbgFNTQ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jun 2020 15:16:59 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9377FC08C5C2
        for <git@vger.kernel.org>; Sun, 14 Jun 2020 12:16:58 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id j32so10984204qte.10
        for <git@vger.kernel.org>; Sun, 14 Jun 2020 12:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=h/gP1/ashVwOwufFHsq71NT6S09vv9/ynj0qjn4VUxM=;
        b=N1O9pi2Dh6izwk9EsInJHzSudqgXxq+LqhYRBb9V7EIkpPR5mTseScsjEHsHRKMMjv
         CTqo0MHLwBCLKN4G4+87tifPnvLdmfQyzVrBjvqdE4EULp+FZ+UhH4jsx09N/jxeWO1O
         VWCDaD+sTIKsIh1BZiO5M83XYdNd/QFOidV3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=h/gP1/ashVwOwufFHsq71NT6S09vv9/ynj0qjn4VUxM=;
        b=phcjZ9fb7vzSY2tnHZ3ysAVsWV1eeuCBhdUY+TZKBuj6qajyj7dFzn442kxD6u0muS
         HjkoSNrhFLbxoTNwmMm50hHzObhmUOXNBjGZ9uYe6KwM3bsYrk1oIzJ9zcWT28hL1hgE
         j48bhFpzAJlR48qYndWZ49JjCWmoDiW5ewnrHvqmXIdNaUlkCv/+BdcnccyqDy5+Dxs6
         nXbVhYkoCR2xT8aRs8v+pNOJGIMhnudtFM2g3sPex0pqwLV2qCgcgWQBGqmaHBzBC4NI
         4slNgwjkH84T1bX5nxsnXzKY5XQfEPXtyXt8G2AgqN+PDRt+Jv4rmvv0LUZ0P4mlXs93
         jujg==
X-Gm-Message-State: AOAM532BIjEwmCZ2o74tp8kJpsKdme1wz15lSophhhLh1XsQyfMFDxYO
        xFue60QwCRT17xRM6PiCjiIodVxRSaQ=
X-Google-Smtp-Source: ABdhPJw4Xx3ZmYwaKgRxC8ixIsPVE9o82s8J13WjMMQ/qYzaN+ByIKN94kpx+hSfJQztQc9i6UJBFw==
X-Received: by 2002:aed:3608:: with SMTP id e8mr12752335qtb.186.1592162217835;
        Sun, 14 Jun 2020 12:16:57 -0700 (PDT)
Received: from i7.mricon.com (107-179-243-71.cpe.teksavvy.com. [107.179.243.71])
        by smtp.gmail.com with ESMTPSA id z4sm9169462qkj.131.2020.06.14.12.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2020 12:16:56 -0700 (PDT)
Received: by i7.mricon.com (sSMTP sendmail emulation); Sun, 14 Jun 2020 15:16:55 -0400
Date:   Sun, 14 Jun 2020 15:16:55 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     =?utf-8?Q?S=C3=A9rgio?= Augusto Vianna <sergio.a.vianna@gmail.com>
Cc:     Johannes.Schindelin@gmx.de, don@goodman-wilson.com,
        git@vger.kernel.org, msuchanek@suse.de, newren@gmail.com,
        philipoakley@iee.email, sandals@crustytoothpaste.net,
        simon@bocoup.com, stolee@gmail.com
Subject: Re: Rename offensive terminology (master)
Message-ID: <20200614191655.qoug6lnxi332g5jk@chatter.i7.local>
Mail-Followup-To: =?utf-8?Q?S=C3=A9rgio?= Augusto Vianna <sergio.a.vianna@gmail.com>,
        Johannes.Schindelin@gmx.de, don@goodman-wilson.com,
        git@vger.kernel.org, msuchanek@suse.de, newren@gmail.com,
        philipoakley@iee.email, sandals@crustytoothpaste.net,
        simon@bocoup.com, stolee@gmail.com
References: <20200614190400.bk22inkkz2w6f2sg@chatter.i7.local>
 <18018f12-1376-9b17-e1b4-a2e5c59e711a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <18018f12-1376-9b17-e1b4-a2e5c59e711a@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 14, 2020 at 04:08:53PM -0300, Sérgio Augusto Vianna wrote:
> >Well, then nothing really changes then, does it?
> 
> Did you read what I said? I said it would be chaotic for everyone to deal
> with this change. It won't change anything for the people who WANT the
> change. They are just forcing everyone else to use what they want.

No, you "presented a contrived example," to use your own words. If you 
show me a "real word case" of how it would be "chaotic for everyone," 
then we can have a reasonable conversation.

> >False. Efforts to remove the usage of "master" traces back over half 
> >a
> decade
> 
> There will always be people that adopt fringe ideologies. In the 1960 there
> were feminists that accused every single straight woman of being a gender
> traitor, for example. Yes, I said "literally no one", and that was
> hyperbole. I'm sorry if that went over your head so easily.

Oh look, I'm all out of cringe now. I'm sorry, but I'm going to have to 
end it here.

-K

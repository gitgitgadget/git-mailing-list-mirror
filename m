Return-Path: <SRS0=1Nmv=77=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A743CC433DF
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 15:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 845BA20888
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 15:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592493792;
	bh=ZshX0G+QE8m0hUJRc4ZJX5XdaHcfYA0MFAjuiAFoBAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dq910ppeKNwTg+6Iny1l2qwJoLUsIihv1ossrUgdI9vTDV4CIe+00J2feI50dMX02
	 LB6fa6rQlRe0+zriRxz7JfSJCT0DTN8NpsAHq8ma8PmtQ8fJHmnOvW2LVkzEa0d+0w
	 w2/OTv2TVlSDAcSTVCDz7ydyHRa+Vh3Wi1mYwjYc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731423AbgFRPXL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Jun 2020 11:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729418AbgFRPXF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jun 2020 11:23:05 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E382FC06174E
        for <git@vger.kernel.org>; Thu, 18 Jun 2020 08:23:04 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id q14so4688104qtr.9
        for <git@vger.kernel.org>; Thu, 18 Jun 2020 08:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=iatYzrowbGgOUfCWIIPtOTK0UXOTekJVMpzbOWOp1WY=;
        b=cfoSGiaqm2zO6qreZCq4mRqS8vKBDPG76kKrb+TK0DL5EHfMV9XyRql5Yo8fidTm8A
         p/n+1ak5aX5FQUWIyeK0GNL5zhlTje/l2lK39JSH8VlWj/QHlzORHFBmhKSavjrApoOD
         WA9XIC1Bs2W69puCEIMRwb2tYhmrn/7005CWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=iatYzrowbGgOUfCWIIPtOTK0UXOTekJVMpzbOWOp1WY=;
        b=FezfNrsiYI1cKzUQzh7WP32EVyj/m0Vn5HvcrtTqoQfy0nguQeyWueW+Vco7eIcRcH
         cOwOrhnUHa6kNoDA1YbP53pR5pTuCGuo/wL2pJQDjjPUy81lRidk5Shv26BHxMZlUts1
         zlzTXQOmiPkQe4WeB9YpKpD4x12hLKOaoFvAL+ZuPX4AW6rbPj2zxcOOcnTmMwUUq297
         MMjPUUIFIgf2xkqcwhmbD/5GqCt7uWtDe/tkLmvHC6uRG5ZLVJy4dqmA+ljnm0WvP8zX
         9v5zDxLLlfSUndr7kkjrZSksbD0yYZRTpE9C6LMVeEZY5ZJNhHmE1gKDDZrFbU9rwkG+
         1DLw==
X-Gm-Message-State: AOAM532EhQyxyRdwb/CsU13YOz5R+Q40Lz3Auwdnc4n25ETCmPb39oz8
        VFc8dA0TnxWT1/yRl0EYSrgCIg==
X-Google-Smtp-Source: ABdhPJxvFdKbhQxII2q/Qc35edHyC270ZfhJ3CRmEkYa/8BS1o3NNB40FmwuXkhMOFJMo0pKyUM91w==
X-Received: by 2002:ac8:1742:: with SMTP id u2mr5067229qtk.341.1592493783948;
        Thu, 18 Jun 2020 08:23:03 -0700 (PDT)
Received: from i7.mricon.com (107-179-243-71.cpe.teksavvy.com. [107.179.243.71])
        by smtp.gmail.com with ESMTPSA id x30sm2324893qte.70.2020.06.18.08.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 08:23:02 -0700 (PDT)
Received: by i7.mricon.com (sSMTP sendmail emulation); Thu, 18 Jun 2020 11:23:00 -0400
Date:   Thu, 18 Jun 2020 11:23:00 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     demerphq <demerphq@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>,
        =?utf-8?Q?S=C3=A9rgio?= Augusto Vianna 
        <sergio.a.vianna@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Don Goodman-Wilson <don@goodman-wilson.com>,
        Git <git@vger.kernel.org>, newren@gmail.com,
        philipoakley@iee.email,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Simon Pieters <simon@bocoup.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: Rename offensive terminology (master)
Message-ID: <20200618152300.cw7teo2jmxyfsl2l@chatter.i7.local>
Mail-Followup-To: demerphq <demerphq@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>,
        =?utf-8?Q?S=C3=A9rgio?= Augusto Vianna <sergio.a.vianna@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Don Goodman-Wilson <don@goodman-wilson.com>,
        Git <git@vger.kernel.org>, newren@gmail.com, philipoakley@iee.email,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Simon Pieters <simon@bocoup.com>, Derrick Stolee <stolee@gmail.com>
References: <20200614181906.u42tuny3eipvhd46@chatter.i7.local>
 <b82bdf57-840d-f9c2-0e42-95a93d9336b7@gmail.com>
 <CANgJU+WoGNKuvZHAtLAfNAUfFdoLWHiDis_rSV-AfT9WspmHgA@mail.gmail.com>
 <20200616074316.GA21462@kitsune.suse.cz>
 <CANgJU+XzD9Nnnu4qWExpOUBy+u1=23SRCQy-=6aAVFJAowkjYg@mail.gmail.com>
 <xmqq5zbpv53g.fsf@gitster.c.googlers.com>
 <20200617201037.GA86579@google.com>
 <20200617201709.GB86579@google.com>
 <CANgJU+WbPgSTxQ=G3sFSvNFQ1cL3onYk5yKLBR=3AqWeEUCfZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANgJU+WbPgSTxQ=G3sFSvNFQ1cL3onYk5yKLBR=3AqWeEUCfZQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 18, 2020 at 09:57:42AM +0200, demerphq wrote:
> > Of course I missed the other point --- hostnames like master.<domain>
> > (e.g., a hypothetical master.kernel.org), refering to the source of
> > truth for something that then gets replicated.
> >
> > I don't think we're likely to see hostnames like main.kernel.org
> > because it's just *so generic* as a word.
> 
> Yep, you summarized my point well. I would say master.kernel.org is a
> correct use of the term "master copy", and the use in the branch name
> is simply not. My "master branch" for git.git is NOT *the* master.

This is actually an important philosophical point with software like 
git. There is no such thing as master.kernel.org for the very specific 
reason that we position kernel.org to be merely a convenient place where 
to get a *copy* of Linux. The "master copy" of the mainline tree exists 
only in once place -- on Linus's computer.

-K

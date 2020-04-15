Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16620C2BA19
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 13:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1DF32074F
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 13:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586959021;
	bh=3vVVwdbBccbzAmR+6/Ig3h9KSdOa6b8F5LbxQAi4nC8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ORZaxqpLbUW97HNLwGDRn11dQAj8N02Pp7yePMSd+rGEXDOiOk/Do1ffcpplTqa9T
	 VsjKZkzJ7DQyD6XJHOnZlsueJAedzaq2PZKjPM5VoD4mqka8bepi7W21dxa2/O6oh0
	 ntICm5UFhcLvohSOc++pcF3FMypqFfJrPjY46QWA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2636361AbgDON45 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 09:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2636339AbgDON4f (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 15 Apr 2020 09:56:35 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140E9C061A0C
        for <git@vger.kernel.org>; Wed, 15 Apr 2020 06:56:30 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id l78so1524378qke.7
        for <git@vger.kernel.org>; Wed, 15 Apr 2020 06:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=7zAXiXGs10hfSdq7ZAQolvYSWAgG83kOe51PrmOly5Q=;
        b=JBz3vovIW97xIVx+2sxgaufvY+BKjHxZB+tc7p6BQxFRUpeZnd4/k2EivG3o1GFOei
         a46YFPB1fO3Mxz7FOEJBnC4NI1lYWwOVKFG3MQ+niQi01DylUxTpXf2MpELFvv14cEr6
         XC+v7EHXhOt7uZYuxWkytEAudqMSLMVLsDN3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=7zAXiXGs10hfSdq7ZAQolvYSWAgG83kOe51PrmOly5Q=;
        b=S/vSxXRWaNKttxTuMOVgYJi7uFrkQQYumfZWYw9ioCuIQFnH+v5wQt2Isn61kMZD9A
         lnx5JGwkqyLPKfg4Dk+WxHFA6MX/JaKzxfY/2/aaFAEHvWPOPYN1l26KEDFe4E9tN+/U
         /R7mENvil/l6yJQDSljhGTlkSgW6SbebCeTsUdm96tiOld84rH3lrYibKQcVzX9HMXP9
         O7LzUJtaZgUoeimR87NmSlQEUE8jP78j2AJARlDsJNi2lL0McVUeLCy8Gsx+SIclFI3t
         Ic8dpJuuv1HPU/psyl9KG/8BiOFF4LnrB3TEOn2+9EXZYqtBabkS/c0s9aGdYLzcXufk
         CDeA==
X-Gm-Message-State: AGi0PuanetNotIvt0Kw/V5cZIPrvE94H3IfoZAxZbsZHjsnD8sUaTKhI
        aC+Epf9KsYLYueUtV9gHz7ETlIV98105WQ==
X-Google-Smtp-Source: APiQypK6FjFbL2yiapLpgo2LoFwNGHS3jLBSDvv0m1tFmpAykImwnYr5HNApO4F07gbKLYeiXNCZAQ==
X-Received: by 2002:a37:882:: with SMTP id 124mr21183530qki.139.1586958989200;
        Wed, 15 Apr 2020 06:56:29 -0700 (PDT)
Received: from chatter.i7.local (107-179-243-71.cpe.teksavvy.com. [107.179.243.71])
        by smtp.gmail.com with ESMTPSA id l22sm12890784qkj.120.2020.04.15.06.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 06:56:28 -0700 (PDT)
Date:   Wed, 15 Apr 2020 09:56:27 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     git@vger.kernel.org
Subject: Re: Fetching 24 Linux commits = 1.2 GiB
Message-ID: <20200415135627.vx75hsphbpmgrquv@chatter.i7.local>
Mail-Followup-To: Jiri Slaby <jslaby@suse.cz>, git@vger.kernel.org
References: <b7f5bfb9-61fb-2552-4399-b744428728e4@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b7f5bfb9-61fb-2552-4399-b744428728e4@suse.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 15, 2020 at 10:01:46AM +0200, Jiri Slaby wrote:
> Hi,
> 
> I was at 8f3d9f354286 of:
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> 
> I did git remote update today and it fetched:
> Receiving objects: 100% (7330823/7330823), 1.20 GiB
> It updated master: 8f3d9f354286..8632e9b5645b, that is 24 small commits.
> 
> One colleague of mine fetched 1324 commits:
> Receiving objects: 100% (6820/6820), 4.21 MiB | 6.70 MiB/s, done.
> Resolving deltas: 100% (5114/5114), completed with 1035 local objects.
> From git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux
>    7e63420847ae..8632e9b5645b  master     -> origin/master
> 
> Another colleague fetched the same what I and:
>   Receiving objects: 100% (7330823/7330823), 1.20 GiB
> too.
> 
> I did git gc --prune && git prune now and I am at 1.7G back from 3.5 G.
> 
> Is that a bug? What info should I provide?

I've helped sfr troubleshoot the same issue last week -- it's most 
likely due to 2.26 turning on protocol version=2 by default.  
Unfortunately, reproducing this has been tricky, so if you can reliably 
make this happen again, then providing a full copy of your local tree as 
well as the remote you're trying to fetch may greatly help narrow it 
down.

With sfr (for whom fetching 1.2G from .au is a bit of a big deal), we 
solved it by forcing protocol.version=1.

-K

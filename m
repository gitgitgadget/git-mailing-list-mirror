Return-Path: <SRS0=lPKc=7W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E3E6C433DF
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 16:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 159B520760
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 16:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591718817;
	bh=zhgxxaqpTVschk0GcuJpGZB7jdxvaXeHWDLu+QyIyMM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hyb1o0d5VGp6rKBpJ5vcPZmXVZStWi/BhYi8NajRUTehUcYLyHRSvl25FeRTFR/o7
	 7mQQoaCnsTnXBQzSmz8ClxLttLTvUe9P7yLvvYEH5VgWB4uysEU2jDyAK39aE4NNSi
	 0nozfA74KF7lf8sZWBSgLIJMdaOvRdu7BNMwj8Ww=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731061AbgFIQG4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Jun 2020 12:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728888AbgFIQGy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jun 2020 12:06:54 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B79C05BD1E
        for <git@vger.kernel.org>; Tue,  9 Jun 2020 09:06:54 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id n11so21304583qkn.8
        for <git@vger.kernel.org>; Tue, 09 Jun 2020 09:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=bBKNEq5zWjIYOJam2zjy7zStNUe+EDXJQ0vXKPCRE5w=;
        b=Jqze114lvZ3pk8GiAz6nsn8DYNp1jwLJkx8prj4RS3TCPXBXTqIxccAddqxMguoP3c
         B9LmX20K7c01FczV2qpSCwUtnYKipGeqecsTfMc0qWXJlEfTS3cynURrkuuN1p6tSLnC
         yX0KvWlnLaMIcB+ptyU3dTRmxHpKCtXDDyIj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=bBKNEq5zWjIYOJam2zjy7zStNUe+EDXJQ0vXKPCRE5w=;
        b=Kpfp4FH7F+9+Ou47iH796rPPqNgoyaDkiVBP9druZD3Ky/HHIMFg0l2pkXaQpKFoB2
         NyeIIbBkDhAEBe2X8IXOP2H0t4vtvysjtLQp6HSD5CeEGRJzbUbuE32feQdDYHhqsO6Z
         rRRm6DOGn0IK9KybFJgk4fBqeBbXK0VKaZk+n6mDDOOb9zcWggTarQJoy6AXuP5VNV4H
         U+zhhNOYAMzQIjWTXoKjeacWZs+16kYKSk5hVlma76O0QQzpP1v/EnELfHxZ59vc+yxq
         yyK9Z2An21pvNfLNHj0LENCw6sAiJ9vmZw0+ea2jSujD+m3wWH/2y1fDaabDYzzJesBP
         kMjA==
X-Gm-Message-State: AOAM532PTClpeFtKUDwDCv/lYA4aTuLHGG8Wq6XbwJ4bs5rNunG6ivie
        W4OxRTGZgfa67hxOZT73WtDrCe1Vy6A=
X-Google-Smtp-Source: ABdhPJxQgixUH/si33PxIvUxjoMCQ3vLh9pniQ3BLLbLKPIZdMOijfzTer0mUzVph7qFXT99rSHYnQ==
X-Received: by 2002:a05:620a:218b:: with SMTP id g11mr27830686qka.251.1591718813704;
        Tue, 09 Jun 2020 09:06:53 -0700 (PDT)
Received: from i7.mricon.com (107-179-243-71.cpe.teksavvy.com. [107.179.243.71])
        by smtp.gmail.com with ESMTPSA id 137sm10248725qkf.44.2020.06.09.09.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 09:06:53 -0700 (PDT)
Received: by i7.mricon.com (sSMTP sendmail emulation); Tue, 09 Jun 2020 12:06:50 -0400
Date:   Tue, 9 Jun 2020 12:06:50 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Simon Pieters <simon@bocoup.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, don@goodman-wilson.com
Subject: Re: Rename offensive terminology (master)
Message-ID: <20200609160650.7e74bcjksrto3rp6@chatter.i7.local>
Mail-Followup-To: Simon Pieters <simon@bocoup.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, don@goodman-wilson.com
References: <CAOAHyQwyXC1Z3v7BZAC+Bq6JBaM7FvBenA-1fcqeDV==apdWDg@mail.gmail.com>
 <20200505231641.GH6530@camp.crustytoothpaste.net>
 <CAOAHyQx=+fM1FpAv+g3M+j7j4MgLJA03=MGFmXLvZcfJKAEpGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOAHyQx=+fM1FpAv+g3M+j7j4MgLJA03=MGFmXLvZcfJKAEpGg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 09, 2020 at 05:16:57PM +0200, Simon Pieters wrote:
> Thank you for your encouraging response, Brian, and the research of
> what the change entails for git.
> 
> I've added Don to the cc, who started to work on implementing this change:
> 
> https://twitter.com/DEGoodmanWilson/status/1269931743320182784
> https://github.com/git-for-windows/git/issues/2674
> 
> Although I think it's reasonable to move away from 'master' regardless
> of its origin, today Tobie Langel pointed me to
> https://mail.gnome.org/archives/desktop-devel-list/2019-May/msg00066.html
> where, one year ago, Bastien Nocera made the case that git's 'master'
> is in fact a reference to master/slave.

Well, he pointed out that Bitkeeper used this terminology. Git doesn't 
have any internal concept of "slave" -- the only time you see this word 
used in the codebase is in the test suite, and we should absolutely 
change that.

I am torn on this issue -- I certainly want the project to be inclusive 
to all, but English has a lot of concepts that start with "master" and 
do not trace their origin to subjugation of fellow human beings:

- masterpiece
- masterful
- master's degree
- master copy

Making this change in git seems like attacking the problem at the wrong 
end.

Branch names are already fully arbitrary in Git -- you can have a repo 
without a master branch. Perhaps the best way to address it is to 
introduce a "default branch name" configuration variable, or just work 
without any default branches and let the next step after "git init" be 
"git branch".

-K

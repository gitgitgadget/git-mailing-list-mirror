Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E34FAC433E7
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 21:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9260F20FC3
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 21:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602538061;
	bh=KUK2/PhrpeKn6fvKiK1Tqpfx/PsK5hv5Sr/gsxcerAc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XdOtE4s/C/VJmAam71e4EBS2lfccF3lagSyihQqQqSPYLgRuC7qs67TvJDlyLdvmM
	 MJmtIhdluEmJ9ofxMtq0NQDRORQrtPNe+D37LvkOwpLI3CC+0bgCDZpIVKD7KYBW1A
	 EOC7ZQyZQ0/m4RaQe6PChOln02BCyqOejhdF+Ihk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729837AbgJLV1k (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 17:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbgJLV1k (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 17:27:40 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F9EC0613D0
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 14:27:40 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id i22so2700275qkn.9
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 14:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=5CteceSTHojT6w7enlH4cxOw7YNhdodrJZPaxZ2fyAQ=;
        b=LnwX0Z3DCJCEagyrt26o4QUwMBRC8JNeQPWaJ6XIIlmtH1+SDY+xq572VNXIP23Z27
         ziCA055GkMHAO7hfPYkrbKMjeDWKzSQLJA+JBfWor5Hma0fQ3eBBer1ri2/bZIvH39zd
         kgvR27pCmKANglI7X65poRrI5EbHqQwH0EpNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=5CteceSTHojT6w7enlH4cxOw7YNhdodrJZPaxZ2fyAQ=;
        b=F8SjrGg6Lz1Kz++CLg5UWMMELXwnlEY9JZqmp2VnfzTS9RN9WHrS4qFEMRpGOBnR3f
         vJIw7WXOGmVhmyCVkirlvfdioC6A7aefo02mwpxQ3CWX9dJcfN1yh9pKisYNia1JobfR
         jM27ZsB99IzTdNTAYR7wOZYSZywATpiVBzZiHvTJn0Zi5LF7feKjijdFKZIbXdlVuKZk
         0IJlh82DkxW5D+VxCt7h7iK8smu7VA8Lw6vnCFWjIc3VbSFRWrClnNIZcOKSQOebsq9i
         i+Ev7mZ4KSI2dUR1JXLIl2mHmI7kxYmKL0AzNklwtUkSkjax3E/jxk2efP+OMn0BLtjN
         4elg==
X-Gm-Message-State: AOAM533iksq/4SpawnpsDVXGbvwBUU3TKdjWwhEn9wbRwQSQFw3qdx3u
        NcZmo5wO768FZPfbsBK640hmVA==
X-Google-Smtp-Source: ABdhPJz3SzY6fqbrUXOdiu73yXMOv2Rf+wHZ03JY1dYF3Z8L4n5ZMch53F8DtzRI0dPonadNTpA5+A==
X-Received: by 2002:a05:620a:11a4:: with SMTP id c4mr3665718qkk.29.1602538058800;
        Mon, 12 Oct 2020 14:27:38 -0700 (PDT)
Received: from chatter.i7.local ([89.36.78.230])
        by smtp.gmail.com with ESMTPSA id d14sm13179473qtr.62.2020.10.12.14.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 14:27:38 -0700 (PDT)
Date:   Mon, 12 Oct 2020 17:27:36 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Subject: Re: Patchwork now does the right thing with GGG submissions
Message-ID: <20201012212736.vb7qq3hcdkdnqvnq@chatter.i7.local>
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
References: <20201012180034.tu4rmeoadhy5j4w7@chatter.i7.local>
 <20201012193850.GE3740546@google.com>
 <xmqq362jnpuw.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq362jnpuw.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 12, 2020 at 01:36:39PM -0700, Junio C Hamano wrote:
> >> Just FYI, I made the necessary tweaks to patchwork to make it 
> >> properly
> >> assign "From" for gitgitgadget submissions:
> >>
> >> https://patchwork.kernel.org/patch/11832689/
> >
> > \o/ Thanks much for this.
> >
> > For the curious, any links to the change behind the scenes that made
> > that happens?  Does it use Sender[1] or a different field?  Does the
> > change live in [2] or [3]?
> >
> > Sincerely,
> > Jonathan
> 
> It is curious that I sometimes see you respond to Konstantin on this
> list, but the message you are responding to is not found.  What is
> going on?

I initially didn't send it to git@vger, only to Jonathan. :) I don't 
mind, though -- I just wasn't sure if this was something others on the 
git list would care about.

> A question to Konstantin is what is so special about GGG?  Did you
> make patchwork to pay attention to the in-body "From:" and other
> in-body header lines (in which case it benefits not just GGG but
> everybody).  If you added a support to ignore everything before the
> scissors that would deserve an extra gold star ;-)

No, this is specifically for GGG mail, as it's a very specific 
well-understood case. The solution I have in place is to just pay 
attention to the in-body Form, but once we upgrade to patchwork 2.2.2 
tomorrow, we will also start paying attention to the X-Original-From 
header.

I'm not 100% sure if it's always correct to pay attention to the in-body 
From -- at least for the purposes of patchwork. Patchwork pays attention 
to "who submitted the series," not "who authored the commit," so making 
in-body From always be the "From" in patchwork would be wrong.

For the cases of GGG, we can ignore this difference, as we definitely 
don't want to pay attention to "who sent the patch" (it's always 
gitgitgadget@gmail.com). However, GGG can make the situation more 
correct if it starts adding an X-Original-From that would be the Github 
name and email of the person submitting the pull request. E.g.:

From: D. Eveloper via GitGitGadget <ggg@gmail.com>   <- DMARC From
X-Original-From: D. Eveloper <github@email.here.com> <- Patchwork From
Subject: [PATCH 1/10] ...

From: A. Nother-Person <foo@example.com>             <- Git From

> For example, how does
> 
> https://lore.kernel.org/git/xmqqy2kwiimi.fsf@gitster.c.googlers.com/
> 
> appear in patchwork?

It's a reply to another patch, so patchwork only processes it as a 
comment. Generally, patchwork doesn't see worrying about this thing as 
its job -- it just wants to let maintainers track incoming patches and 
series and download them in a format that is easy to apply using "git 
am". For that matter, that's how b4 approaches this as well.

-K

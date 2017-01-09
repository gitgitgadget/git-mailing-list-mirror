Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 520D41FEB3
	for <e@80x24.org>; Mon,  9 Jan 2017 18:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164115AbdAISYi (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 13:24:38 -0500
Received: from mail-pf0-f172.google.com ([209.85.192.172]:35753 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163274AbdAISYh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 13:24:37 -0500
Received: by mail-pf0-f172.google.com with SMTP id f144so22994367pfa.2
        for <git@vger.kernel.org>; Mon, 09 Jan 2017 10:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=de8kltFzLwB3Zc3uVKGyYctVHjTxdJ+dly3N7PsMSjo=;
        b=EdovHdrtIvZl+Zh4PTVvBG11goi06SKrladlKk5a8TVvqh95RV2bjCV237TbvMWemZ
         eDdhAF0RmidrhMZCI36HaxLlDmfeAStUbY6rGaDyVoK26HebTSO7x17eMvMvn6llPvuk
         U343IhWGadeTplK3s2mT25MYoAco27f5/vlSsLA66X1KQLr/6+d3IGoq0PJOSQ0agkWi
         KizINSLm10zYY0CwNxDpZYgfAxYMWNDkEWPCfh8/nwoavWCX7PWHKSN8S6j9edxOQlEB
         qlyzmI471YXgLk+rRBQakCrXmaXZBLQcBrbBEjFQ3Y6JxoLJom5Uhad9ukdWR+qsOwUB
         097A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=de8kltFzLwB3Zc3uVKGyYctVHjTxdJ+dly3N7PsMSjo=;
        b=kVJ/+ls7Kk9T/S1GPBGHPkxJFDn+qHBp4jg1oR+OXj4xWKUj0RmZ7kYd3wI6s0zZYk
         eGAeU0iT9BNtcaURMJeIRicx5nYTb4cfKiIspWi0SD8HqDQfj4rq/anzCeEJFSDRllZ6
         jH+j8vdkvKl8n/Rzj5GPrCQe3xASN1YFYLzVWgTv7CrL3Tvmpo22NKk2S9NocdZezrjm
         Er5wYiIn88fIBOTCBRqpY16iz/lilpVdkveES1D3mHeLkRLgxA3eEHDzf18nvorlOYcL
         BZPJSz6XljVX2fIID8bj4UhOqIAIHsAuUKd5omzCuZzIRf9NtXHuafDKs12XzY6U18Dw
         9JAw==
X-Gm-Message-State: AIkVDXKoWwMpk/T7tHadTPnQkWIUs3fSp54fSSHgLupGlE9zQh1e71rqf2X5I4+5pIO/QCQF
X-Received: by 10.98.93.77 with SMTP id r74mr70333148pfb.70.1483986276391;
        Mon, 09 Jan 2017 10:24:36 -0800 (PST)
Received: from google.com ([2620:0:1000:5b10:cb5:8f45:2d29:8a81])
        by smtp.gmail.com with ESMTPSA id a25sm18637682pgd.26.2017.01.09.10.24.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 09 Jan 2017 10:24:35 -0800 (PST)
Date:   Mon, 9 Jan 2017 10:24:33 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        jacob.keller@gmail.com, ramsay@ramsayjones.plus.com, tboegi@web.de,
        j6t@kdbg.org, pclouds@gmail.com, larsxschneider@gmail.com
Subject: Re: [PATCH v5 0/5] road to reentrant real_path
Message-ID: <20170109182433.GC62878@google.com>
References: <20170103190923.11882-1-bmwill@google.com>
 <20170104220124.145808-1-bmwill@google.com>
 <xmqqpojy1c49.fsf@gitster.mtv.corp.google.com>
 <20170109180418.GB62878@google.com>
 <xmqqzij0t7uh.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzij0t7uh.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/09, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> >> How does this relate to the 5-patch real_path: series that has been
> >> on 'next' since last year?
> >
> > The only difference should be in the first patch of the series which
> > handles the #define a bit differently due to the discussion that
> > happened last week.
> >
> > Here is the interdiff between v5 and 'origin/bw/realpath-wo-chdir':
> 
> Then can you make that an incremental patch (or two) with its own
> log message instead?  It (or they) would look and smell like a
> bugfix patch that follows up a change that has already landed.  As
> you know, we won't eject and replace patches that are already in
> 'next' during a development cycle.
> 
> Thanks.

Yes I'll get right on that.

-- 
Brandon Williams

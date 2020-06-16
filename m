Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8901C433DF
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 16:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF31F21475
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 16:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592323809;
	bh=HB+fVafQTyfeFYYvGyMUNZWTNrh6ZfwA57cgOi81RXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aa8HQjO1iUJlWsHSChQco5hEU4BhmNEWY/drTV2xxoyGzbljlx1jKvjb3RNfjHvaU
	 w7GLQGmPILfJhxOggZyHExyMl0XIYUtLn/Zzj3h2clApAd7H6i1FjFeY5xYqah0EFF
	 5HWuomv5oHm5wT132EPg5xiiMYwZnqW95jE0+6Xk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731892AbgFPQKH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 12:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731524AbgFPQKF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 12:10:05 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3D1C061573
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 09:10:05 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id l17so19635019qki.9
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 09:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=sK9gkWBfJgNSog+Ui7GlnRp8EHeoNDwx7ZEgf3RPEMw=;
        b=Rdufwc768TOIgHIC5Tqc84eZiBocnRpjpf4cvOZ2m6AYAeXakWALQ+UBbOOO8vFjWQ
         j5DM+AIlToTSjMkntHNQAuzzvKjlr/TPBciPD2sp/IHUsM7AxxolHtin/Ofg+XkUPJHJ
         fgnP4y/9AlbjkLLB42J9cc26xc3ZvC4m9eaUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=sK9gkWBfJgNSog+Ui7GlnRp8EHeoNDwx7ZEgf3RPEMw=;
        b=mCBVw/ooEeYbXqhKxIxtyeAYVuhD13qk067N8kCQYDvK7L2JE8IEbHGWANDQUf0Y13
         FGjcpNRnmxBOZWiEJ61GYGCfOV+p6TRTEy1d3rWKTy5T7V6ukzldGsgDGVS5cnol7JiW
         l5HvjL1a645iF0XbmxJW7RXVADcpcFMOdZ/PPuELanJ2Untf0QLfselrdkdBOnQqJ/lD
         vsN0K9gsY8oaxoH8Pz40+xWsKlmpgH7ZyqN0ysEmycQB0DUbTVk8w0XotkGh+4s+Z5n3
         XpzJq5PH864jdZEGpN5C7qSSmHUZrXfZPkqViXzOx8oYIuVPa5H4lVq8rld92Dponp/s
         MqDQ==
X-Gm-Message-State: AOAM530s/gnkdGbPuRG+4hnsuKSedEDTD2iIbdJ0iLhwMDWbivnf7d/V
        CUhWYqVXekyERKItiwfAOt7+sg==
X-Google-Smtp-Source: ABdhPJxFWWfVBakuilAHlgYAlleOCSiJM6s3Tcr/GvVIsz0WHXZXIwZ6k5DTMDXmO8fCdbuOktAmdw==
X-Received: by 2002:a37:64c2:: with SMTP id y185mr21807360qkb.186.1592323804363;
        Tue, 16 Jun 2020 09:10:04 -0700 (PDT)
Received: from i7.mricon.com (107-179-243-71.cpe.teksavvy.com. [107.179.243.71])
        by smtp.gmail.com with ESMTPSA id c6sm13628977qkg.93.2020.06.16.09.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 09:10:03 -0700 (PDT)
Received: by i7.mricon.com (sSMTP sendmail emulation); Tue, 16 Jun 2020 12:10:01 -0400
Date:   Tue, 16 Jun 2020 12:10:01 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        James Ramsay <james@jramsay.com.au>,
        Bryan Turner <bturner@atlassian.com>
Subject: Re: Consensus on a new default branch name
Message-ID: <20200616161001.fa5wa2br5ois2csr@chatter.i7.local>
Mail-Followup-To: Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        git@vger.kernel.org, James Ramsay <james@jramsay.com.au>,
        Bryan Turner <bturner@atlassian.com>
References: <20200615205722.GG71506@syl.local>
 <20200615212154.GA79696@syl.local>
 <20200616143107.GL666057@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200616143107.GL666057@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 16, 2020 at 10:31:07AM -0400, Jeff King wrote:
> 
> My biggest concern here was trying to understand what could break.
> Having read the patches from Johannes and thought about it a lot, I have
> a pretty good handle on where Git itself cares about the name. And I
> feel pretty confident that we can make the change in a way that won't
> cause problems there (and in fact, I think some of the code will be
> made more robust by relying on HEAD more appropriately).
> 
> There's a more open question of what _else_ will break in the ecosystem.

What if we work on making this configurable for now, but stick with the 
legacy name until we introduce breaking sha1 changes? Almost everything 
will need to retool for those anyway (and all documentation rewritten), 
so it is reasonable to bundle these changes to happen at the same time.

-K

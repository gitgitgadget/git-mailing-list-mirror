Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F7D1C433DF
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 17:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00BAD2067B
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 17:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592328752;
	bh=tpzoT1+24VSEkhkSgfFQbQlb7Q7T11qK8yn4Gm7sPkc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zdcQ22TH1Fdl9bfbbXIN4xBrsEPvyzlPcCMaI/tINx70Ao//uPbXrUAwWPu73OFJH
	 XUCj0GtJVa6RbZp7fY76uTbZOd770P1Y+KqQ1132UIMd8zwMu1Q90qTcg4t4WwlwaN
	 ARgqqM2MME7yE0QZ6k9BS9rXxa8gp/04DNrgQjkM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729236AbgFPRcb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 13:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728271AbgFPRca (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 13:32:30 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6143BC061573
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 10:32:30 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id k22so16108290qtm.6
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 10:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=uWNzIVoJCcLjRgqEJRaXauCyewNtYolRt53qDyjZQVA=;
        b=aiabG4IJCqeAnC6twJeaPCzQXhvSckrPJzsH/ZQ7lzdndvmeQsREUjnacrtiMP5ETz
         Lzl8qlViD/bxcyvonusSHMGsJk1q2zTWZQ7RbwK+OItpRKkUrjjOnMWrA4pw5KmZdINT
         pDv9Gsako9AuI+bpA68wfYCtFpkKW3yDigBZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=uWNzIVoJCcLjRgqEJRaXauCyewNtYolRt53qDyjZQVA=;
        b=DHKLvb3IyT46+2jklCGPjym6kv2LN+YXMAVtbcPTKHtAIDMjAWrVgEmD2zuDQQQql4
         4fVrqE1LollvZZXI7rYPG6P4SXZXDGlPOvWHkA/aG4uBlvXLMzfngLPBI5pV4FahWa3q
         aIVRsI0fhJxgOpYtxrt5T0nyJdksK7FFDml4qrUjc+MR7QLW/nbzbVPdRHFXYM1JAJKi
         M/f1D0KyOIX2LB4PwmoJh4anaVBPpl4KVEz0tWQgb+XgmbXwtfhlcrwiONx/odEyGOxQ
         4YkxYiFAiVwb8gIEuUCpv4dC+U/1ifK3BMWUuraM9fypeKyhnjuqA+3xCS2fWsCQiFBA
         4RLA==
X-Gm-Message-State: AOAM532b08TIbJfMDGEecYmtMIIBLFNLxuh16Tvdb8R5UJepbA/Vx+CB
        EtjgmuNEOEc8lOqyKXU6ppRxygeIq6k=
X-Google-Smtp-Source: ABdhPJwd8qSG4Pwv+ZRv6w80IzzxkVvMrpwGZ5KU5LcB3WXGQGJZc2EbqKaITkmxmziwk8FFm4gwdQ==
X-Received: by 2002:ac8:3066:: with SMTP id g35mr21854679qte.193.1592328749499;
        Tue, 16 Jun 2020 10:32:29 -0700 (PDT)
Received: from i7.mricon.com (107-179-243-71.cpe.teksavvy.com. [107.179.243.71])
        by smtp.gmail.com with ESMTPSA id v59sm15629636qte.96.2020.06.16.10.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 10:32:28 -0700 (PDT)
Received: by i7.mricon.com (sSMTP sendmail emulation); Tue, 16 Jun 2020 13:32:27 -0400
Date:   Tue, 16 Jun 2020 13:32:27 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Oleg <lego_12239@rambler.ru>
Cc:     git@vger.kernel.org
Subject: Re: Consensus on a new default branch name
Message-ID: <20200616173227.inexk4clqilojg36@chatter.i7.local>
Mail-Followup-To: Oleg <lego_12239@rambler.ru>, git@vger.kernel.org
References: <20200615205722.GG71506@syl.local>
 <20200615212154.GA79696@syl.local>
 <20200616143107.GL666057@coredump.intra.peff.net>
 <20200616145207.GA13998@legohost>
 <20200616160005.GB667151@coredump.intra.peff.net>
 <20200616171048.GA18874@legohost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200616171048.GA18874@legohost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 16, 2020 at 08:11:01PM +0300, Oleg wrote:
> > I think it's clear that this _is_ a politically-driven change. It is 
> > not
> > helping the software in any technical way to change the name. The
> 
> Yes. You are absolutely right.
> 
> > question is whether the more abstract benefits to people are worth the
> > potential costs.
> 
> Of course, not. This is obvious.

Oleg, that doesn't make it an invalid discussion point. If Git was 
written in German and the lead branch was called "refs/heads/fuhrer" 
(German word for "leader"), you'd be on the opposite side of the 
barricades arguing that this needs to be changed because it's offensive 
to many people whose immediate family members died in WW2.

And someone else would be reasonably pointing out that "fuhrer" doesn't 
mean "The Fuhrer" and nobody is even alive since then anymore, and omg, 
why is this even a discussion topic -- isn't there something more 
important everyone could work on?

Yes, it's a politically motivated change, but it's clearly important to 
quite a few people right now and their views should not be disregarded.

-K

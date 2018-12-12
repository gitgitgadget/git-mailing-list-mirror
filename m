Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90502211B3
	for <e@80x24.org>; Wed, 12 Dec 2018 14:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbeLLOzB (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Dec 2018 09:55:01 -0500
Received: from mail-yb1-f176.google.com ([209.85.219.176]:42846 "EHLO
        mail-yb1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbeLLOzB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Dec 2018 09:55:01 -0500
Received: by mail-yb1-f176.google.com with SMTP id m129so1605239ybf.9
        for <git@vger.kernel.org>; Wed, 12 Dec 2018 06:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=47qfUxD/8UgWtRQdtEIeaUlazkk3nR7BwqtZRtanc2Y=;
        b=eS+6sKtsD7Jryo3f1gywdHGuxjRyTQ7LNj57XECvoaoGvyKgdncaBeQY7rx0fgA+C6
         9hk4cmpm0xlnj3TUyuScEYO23zdWVxtuwNFdt1zNpcs1To5EHvNqhWiusMJY37JfGQMb
         OmTA9797NoGi55EB9BgytXlIBXt12TNMhliGmN7FTLT0gHw1oqbkeEBTyVBrzsuc1IAd
         n3LzfcMgHP6NrdiIlcD7tjv313leOtYoa/WQa+5YebwrPPp1xf0F+3RrKU4tieWFvtZV
         oPBJ+/Fl8W3+ZHRzS9uLO8pHo4uNOd5X3hf18vbeCElpZIh2T+zvnT0AeFK/0KEwmI0C
         WUYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=47qfUxD/8UgWtRQdtEIeaUlazkk3nR7BwqtZRtanc2Y=;
        b=ROv33avlKzd7XW0Cr905hiwWscUSZMCt1GweIUdIYEPpludAeKT79rOva5V4ZWHP1D
         ApUsuYhqAGSaKjLt/+dFOSR+rAg6IM8CxVNgSmSngjgR+lVB4Lnv4Vm0N0amc5dByqzS
         dqmFJLdoY8f9dXR8+JFUWJsNgX5iqjG0ovsPfd1hpfpNt+njAosA0OMzDGUVUyO4GDVx
         wNmE0y+TmaPeXtlA+cZ69hCcoXZaaCUQ4dLKW+PWjL3IWDzM5AxJI9kRwkoHeZODHROM
         h+/ct9JYVMhbYa1va4fSGVtMOr1PtcB3iPEOTXB/DtqUXpd6PnnmH6qcD9H+fw79vUW0
         u2jg==
X-Gm-Message-State: AA+aEWajCWfgCOJEYtIp53bn5NmLWL3QQamJcwqynNz5UOYx2nKsUvyq
        ipyyBof3nwr3Zs1lo2OHe5Q=
X-Google-Smtp-Source: AFSGD/WrQCR7/LcmhtUnaoNN9LqT5LhZl6ci4XBrszEyVpv/Q3Eq4OaYXbjBd7N0PpyN11ZJA9fACg==
X-Received: by 2002:a25:53c8:: with SMTP id h191-v6mr19909421ybb.169.1544626500069;
        Wed, 12 Dec 2018 06:55:00 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::4:9f4b])
        by smtp.gmail.com with ESMTPSA id t128sm5815468ywa.79.2018.12.12.06.54.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 06:54:59 -0800 (PST)
Date:   Wed, 12 Dec 2018 06:54:56 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Junio C Hamano <jch2355@gmail.com>,
        Jeff King <peff@peff.net>, kernel-team@fb.com,
        Stefan Xenos <sxenos@google.com>
Subject: Re: [PATCHSET] git-reverse-trailer-xrefs: Reverse map cherry-picks
 and other cross-references
Message-ID: <20181212145456.GQ2509588@devbig004.ftw2.facebook.com>
References: <20181211234909.2855638-1-tj@kernel.org>
 <xmqqo99rjjcu.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo99rjjcu.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello, Junio.

On Wed, Dec 12, 2018 at 04:26:57PM +0900, Junio C Hamano wrote:
> It also is not immediately obvious to me what your general strategy
> to maintain this reverse mapping is, when new ways and codepaths to
> cause new commits with "cherry-picked-from" trailer appear.  Do we
> keep piling on new hooks?  Or is the reverse mapping information

So, what I actually wanted was "this repo now has these new commits"
hook, but that didn't seem to be in line with other hooks as most were
bound to specific directly user-visible commands and actions.

> allowed to be a bit stale and be completed immediately before it
> gets used?  A totally different approach could be to record list of
> commits, all commits behind which have been scanned for reverse
> mapping, in the tip of the notes history, perhaps in the commit log
> message (which is machine generated anyway).  Then, before you need
> the up-to-date-to-the-last-second reverse mapping, you could run
> 
> 	git rev-list --all --not $these_tips_recorded

Wouldn't it be more useful to have repo-updated-with-these-commits
hook instead rather than putting more logic on note handling?

> and scan the commits, just like you scan what you fetched.  And when
> you update the reverse mapping notes tree, the commit to record that
> notes update can record the tip of the above traverseal.
> 
> I also wonder how this topic and the topic Stefan Xenos has been
> working on (cf. <20181201005240.113210-1-sxenos@google.com>) can
> benefit from each other by cross pollination.  Stefan's topic also
> needs to answer, given a commit, what other commits were created out
> of it by cherry-picking and then further amending the results, so
> that when the original commit itself gets amended, the cherry-picked
> ones that were created from the original can be easily identified
> and get updated in the same way as necessary.  

Ah, I see, forward-propagating amends to cherry-picks.

> The motivating workflow your topic's cover letter gives us is to
> maintain the release branch that goes only forward, so in that
> context, how a commit on the release branch that was created by
> cherry-picking an original gets updated when the original commit
> gets amended would be different (I am assuming that you cannot

At least we don't do this with our trees and most trees that I've
worked with don't either as that would make it really confusing for
people to work together.

> affored to rebase the release branch to update a deeply buried
> commit that was an earlier cherry-pick), but I would imagine that
> both topics share the need for a good data structure to keep track
> of (1) the relationship between the original and copy of the
> cherry-pick and (2) the fact that the original of such a cherry-pick
> is now stale and the copy might want to get updated.

As long as we can keep the reverse rference notes consistent, wouldn't
amend propagation just consume them?

Thanks.

-- 
tejun

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96AD01F404
	for <e@80x24.org>; Thu,  4 Jan 2018 19:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753195AbeADTtc (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jan 2018 14:49:32 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:42672 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752498AbeADTt1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jan 2018 14:49:27 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5D32660B1B; Thu,  4 Jan 2018 19:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1515095367;
        bh=L2N6IJe47g+S66jaquxqU15rTAvXo9mAiFWgLzM9km4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NOvRj6MR+ClhT59KojT6t0b+fG994iWeqZ0Xl8mi1+wI8WWD9nicSXXF2lzOqapGT
         q4k+IjIuaxkJL1eiUcZJWmwPHli9gkuj/pRBDLfcsmScQaFgdS77fzsSeFN0/rAyat
         yCSQJmu1MkYt3IaB19G6i68PBfjsFsHLY/eku6zk=
Received: from mfick-lnx.localnet (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mfick@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C48106029D;
        Thu,  4 Jan 2018 19:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1515095366;
        bh=L2N6IJe47g+S66jaquxqU15rTAvXo9mAiFWgLzM9km4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bxDOo2X7e/q12QQwHXy9z/RjCWzVpdYCSnK2kiHvnBySBWIWFhECv1EHDk8GRH+23
         FywB1weBMyaNz7QFc1E9wd8DEXK191sYrMQHLPcKFEvYa0ImsEYYaBiBaMNNaeXjxO
         lsA4yjSFGtyzQSnXYGBeZG5G1nO8jPABsQXNwCBg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C48106029D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mfick@codeaurora.org
From:   Martin Fick <mfick@codeaurora.org>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Carl Baldwin <carl@ecbaldwin.net>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Bring together merge and rebase
Date:   Thu, 04 Jan 2018 12:49:24 -0700
Message-ID: <2363617.2KWG4LOxlS@mfick-lnx>
User-Agent: KMail/4.13.3 (Linux/3.13.0-125-generic; KDE/4.13.3; x86_64; ; )
In-Reply-To: <alpine.DEB.2.21.1.1712232353390.406@MININT-6BKU6QN.europe.corp.microsoft.com>
References: <CALiLy7pBvyqA+NjTZHOK9t0AFGYbwqwRVD3sZjUg0ZLx5y1h3A@mail.gmail.com> <20171223210141.GA24715@hpz.ecbaldwin.net> <alpine.DEB.2.21.1.1712232353390.406@MININT-6BKU6QN.europe.corp.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sunday, December 24, 2017 12:01:38 AM Johannes Schindelin 
wrote:
> Hi Carl,
> 
> On Sat, 23 Dec 2017, Carl Baldwin wrote:
> > I imagine that a "git commit --amend" would also insert
> > a "replaces" reference to the original commit but I
> > failed to mention that in my original post.
> 
> And cherry-pick, too, of course.
> 
> Both of these examples hint at a rather huge urge of some
> users to turn this feature off because the referenced
> commits may very well be throw-away commits in their
> case, making the newly-recorded information completely
> undesired.
> 
> Example: I am working on a topic branch. In the middle, I
> see a typo. I commit a fix, continue to work on the topic
> branch. Later, I cherry-pick that commit to a separate
> topic branch because I really don't think that those two
> topics are related. Now I definitely do not want a
> reference of the cherry-picked commit to the original
> one: the latter will never be pushed to a public
> repository, and gc'ed in a few weeks.
> 
> Of course, that is only my wish, other users in similar
> situations may want that information. Demonstrating that
> you would be better served with an opt-in feature that
> uses notes rather than a baked-in commit header.

I think what you are highlighting is not when to track this, 
but rather when to share this tracking.  In my local repo, I 
would definitely want to know that I cherry-picked this from 
elsewhere, it helps me understand what I have done later 
when I look back at old commits and branches that need to 
potentially be thrown away.  But I agree you may not want to 
share these publicly.

I am not sure what the right formula is, for when to share 
these pointers publicly, but it seems like it might be that 
whenever you push something, it should push along any 
references to amended commits that were publicly available 
already.  I am not sure how to track that, but I suspect it 
is a subset of the union of commits you have fetched, and 
commits you have pushed (i.e. you got it from elsewhere, or 
you created it and already shared it with others)?  Maybe it 
should also include any commits reachable by advertisements 
to places you are pushing to (in case it got shared some 
other way)?

-Martin

-- 
The Qualcomm Innovation Center, Inc. is a member of Code 
Aurora Forum, hosted by The Linux Foundation


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07B3D20A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 03:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbeLMDku (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Dec 2018 22:40:50 -0500
Received: from mail-yb1-f171.google.com ([209.85.219.171]:40359 "EHLO
        mail-yb1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbeLMDku (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Dec 2018 22:40:50 -0500
Received: by mail-yb1-f171.google.com with SMTP id e12so256212ybq.7
        for <git@vger.kernel.org>; Wed, 12 Dec 2018 19:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=N5pHgtguYBl6p2O5nfUpD5w7fZGn6XZO3mbozA1Syw4=;
        b=eln3jJw3M6+RZV9Q/HQdBKCPbVEfeRE24HHn/TcivBzziN0MV+PJL67F5JFriAhDo/
         uz7P3Blf69C2T0ssPorgiPr/aMjN3o77sPMSGPC58dhMfc5NTc00QHuxPNtiZI0RQUP8
         HRBBkLlY+3yhy4y716iWFF7SHPCHgyW1NP5y5xsRaUk+7/x+cW8vPooujuhGAbGG10WN
         9Ix8Dmv3yiOOscLOjGIJmchT9CrMKzz8SQegMbNu0oDbKY6G9LlzAfZ07RzfLuZuIG7O
         ++mefq5kvjvtKZ6xkCaMrf68B/1HK/MvzWAVGt1i5PU8XKZ0/7oXr086g7D/V4cbsR8I
         dfnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=N5pHgtguYBl6p2O5nfUpD5w7fZGn6XZO3mbozA1Syw4=;
        b=NGnpb/aDu55vXUji3rnsEr/sMVDO1Xh45yUzJrzcFf5K5gg4Eytv45GnlKcx8a0vZc
         xr0Tvo0rvOG0lto903jIYtBcmCQIhu9si86p7LromXfg+sGdmXGR21Uddii+Lwnq5QO/
         VdiMaTTzgfO6bB20bAGvvxUe7vnfdiMICsa21i1IMAtrl3kO2K2xxN71fneIP7RmE1qu
         1qQ/LEpJYDdvBHMp4h7ZfPB7B+7rOtJTxr0b68HknAIL0cAp/yEDAn8AgqcuGNni+qVm
         XsBIQj7FvNlz1S01/OfoNAIQXbmW/BLTjAV3NZ27fR7YFpY5GavIpB8ToXfzkzgTAr8k
         35kw==
X-Gm-Message-State: AA+aEWZgW6SM1h9kNWaPlUVbbHx1PeA8OiVWvCntWQy9OgmJ8yg28M+R
        QJFF2sQc3kSo0jLBC8CXTF0=
X-Google-Smtp-Source: AFSGD/UvTDYoVb8YwhSrvMkcmH31RqriV7NTv7/5yh5Z0Eruy5mWtejeBPRewEZGRE4ZGKhx6Jy8SQ==
X-Received: by 2002:a25:ac5f:: with SMTP id r31mr15610804ybd.343.1544672448691;
        Wed, 12 Dec 2018 19:40:48 -0800 (PST)
Received: from localhost ([2620:10d:c091:180::1:15bc])
        by smtp.gmail.com with ESMTPSA id j6sm220259ywi.110.2018.12.12.19.40.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 19:40:47 -0800 (PST)
Date:   Wed, 12 Dec 2018 19:40:41 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>, kernel-team@fb.com,
        Stefan Xenos <sxenos@google.com>
Subject: Re: [PATCHSET] git-reverse-trailer-xrefs: Reverse map cherry-picks
 and other cross-references
Message-ID: <20181213034041.GR2509588@devbig004.ftw2.facebook.com>
References: <20181211234909.2855638-1-tj@kernel.org>
 <xmqqo99rjjcu.fsf@gitster-ct.c.googlers.com>
 <20181212145456.GQ2509588@devbig004.ftw2.facebook.com>
 <xmqqefamgmey.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqefamgmey.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello, Junio.

On Thu, Dec 13, 2018 at 12:01:25PM +0900, Junio C Hamano wrote:
> > Wouldn't it be more useful to have repo-updated-with-these-commits
> > hook instead rather than putting more logic on note handling?
> >
> >> and scan the commits, just like you scan what you fetched.  And when
> >> you update the reverse mapping notes tree, the commit to record that
> >> notes update can record the tip of the above traversal.
> 
> I do not consider what you do in notes/xref-* "more logic on note
> handling" in the sense that the logic is part of "notes" API.
> 
> The moment you decided to reserve one hierarchy in refs/notes/ and
> designed what the mapping recorded there means, you designed a new
> trailer-xrefs API.  It is a part of that API how blobs stored in
> your refs/notes/xref-cherry-picks are formatted and what they mean.
> It's the same thing---it is also part of your API how the log
> message for recording commits in that hierarchy is formatted and
> what it means.

Hmmm... I see.  I still have a bit of trouble seeing why doing it that
way is better tho.  Wouldn't new-object-hook be simpler?  They'll
achieve about the same thing but one would need to keep the states in
two places.

> > As long as we can keep the reverse rference notes consistent, wouldn't
> > amend propagation just consume them?
> 
> Yes.  Would that mean you do not need the notes/xref-* series we are
> seeing here, and instead (re)use what Stefan's series, which already
> needs to have access to and record the information anyway, records?

Oh yeah, for sure.  Didn't know Stefan was doing something similar.
Will continue on the other reply.

Thanks.

-- 
tejun

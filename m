Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B256820248
	for <e@80x24.org>; Fri, 19 Apr 2019 20:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725957AbfDSU1A (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Apr 2019 16:27:00 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36434 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbfDSU1A (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Apr 2019 16:27:00 -0400
Received: by mail-pl1-f194.google.com with SMTP id ck15so3058157plb.3
        for <git@vger.kernel.org>; Fri, 19 Apr 2019 13:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SfZRw4YSuebA5glKxy7/abJL4yGqbZPgrUIu45DIv8U=;
        b=ki1OmIXU50Lh8HQ6xhj53YQPTLyBlkj02ju84HeY9NXtpRHRACjf/RNQJNsr2r17id
         9F147RaoSJlz+iFEqhNQisob/Kesu8pptIf9iIFZ3sxEypZCmCf3wrHc95kQPEZ+R1Kb
         ytGgogEFAtnPla1af7tdyt1ylkE134/R+tfbdRkwNSmGDF1qA65igzyfoUV9EIiEB3xu
         BKtjIDUzVtL7g4choJH+qtFs3j9GJZueXo0VLFcXejIeV0R6fCknE3yfAYL9tjbIGs4E
         wVEcIuczibmHt/zKbrDnhp6+N1vWGn9iLOCbiPfnw1kwc/OnjhnkB+5ySvQQgCb2CFg3
         z9lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=SfZRw4YSuebA5glKxy7/abJL4yGqbZPgrUIu45DIv8U=;
        b=YUtMKfj/q+XPMyWUsO3+OlCHXfGZwFNEGGtqEb3T/Y6KVbW15XnaqVSYtblTOREYDt
         JJFYOwf0k1vwvQ+gE6FqlirK6qao8NAlju9SFHWn1CyxQQjEjXS1JNMhCwUITzkqcaXk
         liatuN/HCc4P7Jfhlh7ILPglvdMJL6U/pC5jYKeI4Lmp0bYkq+pT7hzNfYw8yL5AVj+k
         +638xu7apCRLcsCAbhaqYrTmlteeaBTBm3/IQjQPRP5nwIh+GoKmQP6aoh8aU0keScCw
         QNLd5u2y1uh4rRlhXcuH+PS6tklHizcfYIxmS/pN9JmYWGSbU/c8eZm1tL7r2Fyglq+z
         yqig==
X-Gm-Message-State: APjAAAV8vV+slgqH4RlQHpjQEvIWD1nrzcVmbOVOAiSDo1l8DeAbbRAP
        aC45MdE5RbyBYn8QBSvIOefpzb6jLttIQw==
X-Google-Smtp-Source: APXvYqy/MA1FpIdjYOHPMlGJWsN07+VHvy3Nq6nJG2Q/mmyipkbsZUQ2XzNzVJW9OA6UmXeONpG84w==
X-Received: by 2002:a17:902:9881:: with SMTP id s1mr5613309plp.99.1555705619109;
        Fri, 19 Apr 2019 13:26:59 -0700 (PDT)
Received: from google.com ([2620:0:100e:913:5bb:3076:546:99b0])
        by smtp.gmail.com with ESMTPSA id f2sm8761733pgc.30.2019.04.19.13.26.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Apr 2019 13:26:57 -0700 (PDT)
Date:   Fri, 19 Apr 2019 13:26:52 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, jonathantanmy@google.com, jrnieder@gmail.com
Subject: Re: [PATCH v3] rev-list: exclude promisor objects at walk time
Message-ID: <20190419202652.GU60888@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Jeff King <peff@peff.net>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, jonathantanmy@google.com, jrnieder@gmail.com
References: <6de682d5e48186970644569586fc6613763d5caa.1554312374.git.steadmon@google.com>
 <9856e7fc74f51b60ae162cbed3f5c0cf8c603222.1554757275.git.steadmon@google.com>
 <20190409180418.GH8796@szeder.dev>
 <20190409234255.GM60888@google.com>
 <20190411040642.GA8418@sigill.intra.peff.net>
 <20190412223847.GO60888@google.com>
 <20190413053434.GA31884@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190413053434.GA31884@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019.04.13 01:34, Jeff King wrote:
> On Fri, Apr 12, 2019 at 03:38:47PM -0700, Josh Steadmon wrote:
> 
> > > > Thank you for catching this. I haven't yet figured out the cause. I will
> > > > look into this more tomorrow and then send a V4 once I've fixed it.
> > > 
> > > I'm concerned that this is a sign that the approach I suggested does not
> > > actually work everywhere. I.e., could this be a case where we have some
> > > non-promisor object that points to a sub-object that is reachable from
> > > the promisor pack, but not a direct tip? Before your patch we'd consider
> > > that sub-object a promisor (because we enumerate all of the graph that
> > > we do have and mark each such object), but afterwards we would not.
> > > 
> > > And I wonder if that confuses pack-objects. Though I think it would
> > > confuse it in the _opposite_ direction. I.e., using
> > > --exclude-promisor-objects would count such an object as not-a-promisor
> > > and would be more inclined to include it in the new pack.
> > > 
> > > It is curious that this only turns up with GIT_TEST_COMMIT_GRAPH=1, too.
> > > It seems like any such problem ought to be independent of that.
> > > 
> > > Puzzling...
> > 
> > Do you think this justifies going back to the V1 approach (only checking
> > presence of objects pointed to by refs when doing a partial clone)?
> 
> Yes, I think it might. Especially coupled with your other report that
> the V1 approach is 500ms compared to several seconds for this one. Which
> I'd guess is probably because we actually parse the ref tip objects in
> rev-list, whereas your V1 just skipped that step entirely (which is
> perfectly fine for a clone, as we'd have just hashed the objects via
> index-pack anyway).
> 
> It might be interesting to know if the problem is indeed insurmountable
> with the V3 approach here, or if it's simply another bug. But diving
> into it is going to be rather tricky, and I am not volunteering to do
> it. :) So if you want to punt and go back to the more clearly correct V1
> approach, I can live with that. We can always revisit this approach
> later (it wouldn't be necessary for the clone case after your V1, but in
> theory it could be helping other cases, too).
> 
> -Peff

I have not made any progress in figuring out the repack + commit-graph
failure, so I will resend V1.

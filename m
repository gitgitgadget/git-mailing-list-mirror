Return-Path: <SRS0=LMRs=AT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE4A5C433E0
	for <git@archiver.kernel.org>; Wed,  8 Jul 2020 05:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95DE220786
	for <git@archiver.kernel.org>; Wed,  8 Jul 2020 05:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JFmq1QL9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729502AbgGHFr3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jul 2020 01:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgGHFr2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jul 2020 01:47:28 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488BEC061755
        for <git@vger.kernel.org>; Tue,  7 Jul 2020 22:47:28 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id f2so17715103plr.8
        for <git@vger.kernel.org>; Tue, 07 Jul 2020 22:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5kjMVC9qD7n0xYNeb7e7nLVW+o1hYJCGmWSam4Px22s=;
        b=JFmq1QL9NMlQ8LIt/H5xxXZy3gSlmIbQO370JjXMzk7Kqgx+fznHDL7DNKqADzQEqF
         O2+GpK6PmPkTrpnI+dK0k//aJSKuvxwV8NhhWSxJ9EoQyZP9NQErJxnW9/wG5hTFlw+a
         pv8e24r04vsIf6y0wlTBrenbsziOjr2uohTwk+vTb0kJ+dXMnxdTy3uNOgWN9eaS4oIs
         +QcdxYqDprl/Oz46zrhCTCTisoNuZ2iNH8Nbdynmjvd6DjpCy4v8sRvCycMr5hILiuPR
         9Avwb1tBec3aniunSrlZDjkCEwoCOhRmNbbERzQBco7XjacUgbhXyDK3faKgb+vksVBp
         aWPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5kjMVC9qD7n0xYNeb7e7nLVW+o1hYJCGmWSam4Px22s=;
        b=UFhk9Yexr+gdWjxehY/h0BCEdBjRVZkmxwAmxMvXaJUdaTa6f63TILJF9ogdqrr/Nq
         BKhwj23G3ycg6GuwlLbi2zYy4mCG9VAL7nL/lnKjZINHc7oa5Em6gZejwK4+neeOBQNj
         LlFzb/fJ9nXbxjNKO1EOO+kwApLlmz4A4q2ePJkitS4KCWn70OgKdMu/HR5jsaJm+wLp
         VpqPd0+AaEvQXdU6DUigLfnvtSa8KHdtcHd4d8FrgLsJR+4ZFWsHoQ150WeI7rQ8Qejj
         +JOyOl7N1g9yQayLINlnhhnvOUfybLZvIMFyML8vep7nq4x/9QZAOliAG7Z5CzH8Jv3N
         I5vw==
X-Gm-Message-State: AOAM5315q+ktfs/FaVvRrgTJL2YLWnYk9zWQkf31i3SKrsKYW3iswuIJ
        SI5cX3uLZtWI/gZ46cOXEa8=
X-Google-Smtp-Source: ABdhPJxujbzZrX7y2o3nUcJ8b8TZmsVedDg/ngAQZW/Fbyzn14srVpaX7ucamMMrAHlmYMoB9y23AQ==
X-Received: by 2002:a17:90a:70c3:: with SMTP id a3mr7916937pjm.107.1594187247775;
        Tue, 07 Jul 2020 22:47:27 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id o17sm3888107pjq.6.2020.07.07.22.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 22:47:27 -0700 (PDT)
Date:   Tue, 7 Jul 2020 22:47:25 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH] experimental: default to fetch.writeCommitGraph=false
Message-ID: <20200708054725.GB118756@google.com>
References: <20200707062039.GC784740@google.com>
 <xmqq8sfv745r.fsf@gitster.c.googlers.com>
 <20200707151735.GA27992@syl.lan>
 <xmqqeepn5kxz.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqeepn5kxz.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:

> We could obviously do both excluding it from the usual experimental
> set and applying your fix, so that those who are really curious can
> help us make sure your fix would be all that is needed.  Let's see
> what Jonathan says...

Yes, that would be my preference.

That is, both:

* applying the fix to provide a good experience to users interested in
  fetch.writeCommitGraph

* disabling fetch.writeCommitGraph in the experimental set, since it
  has not had much production exposure yet.  The experimental set is
  relatively young, so I want to ensure people's initial experiences
  with it are positive so that they stick with it if they're
  interested in experimental features (or in other words, I think
  there's still a place for features that are not yet proven enough
  to go in the experimental set).

Regardless of what is put in the experimental set, at $DAYJOB we will
run with the fix applied and with fetch.writeCommitGraph=true starting
next week.  I'd encourage anyone else with a similarly controlled
setup to try the same.

Thanks,
Jonathan

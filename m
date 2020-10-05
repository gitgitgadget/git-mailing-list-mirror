Return-Path: <SRS0=R7wA=DM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A34CC4363A
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 23:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3CF320789
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 23:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMnLRplf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgJEXsn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Oct 2020 19:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgJEXsn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Oct 2020 19:48:43 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66EEC0613CE
        for <git@vger.kernel.org>; Mon,  5 Oct 2020 16:48:42 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d6so307171plo.13
        for <git@vger.kernel.org>; Mon, 05 Oct 2020 16:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KLSDv1ioIZYpEwPkqxrHj6W3t0W+S6PULdiHvs/E9C8=;
        b=RMnLRplf5Cxf4/XDubA3Aijgq9WZ0he4EwnFijS5CkEb/4UpdlWQChdskpNO3stYlL
         kgJpTVYs1YVQGUzkyLQi/JrMC8OYjDLKlAIjjT4TE0DdJrDmcHn0cJ8qi78R5a5XlCP1
         XOfazDElPzES2Q57RvWwKJKuP0TiP8nZ5A4xtkJbswoCy/E2qXlktmdIIvmLntdABrfn
         YP9gGgZGsr5MT4VJyLKqK2v+uAEBFlLhasbDjg25bvapqptfotpGKZgWz/3eFiP4ua6I
         9aPaOxMceVWQnmzpLoWk4k+gERFja5kY2MOvhl0bu+RtqMEf6SUV6sNL68ci8croc0Wy
         TygQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KLSDv1ioIZYpEwPkqxrHj6W3t0W+S6PULdiHvs/E9C8=;
        b=R3bPwQrarxd09JQg2jggg3ig1hdi+vHBICoEyuq3hskQTcYvXqIA1O2SdAKvSeeGSf
         irdQbJuQYAELtWTu0cliKYvtRgUek20srJIAeNejmT2XB/1ts+3Bglv0SybCVZHzqsCk
         NIOAOX4xw//l/tkZkisKYQ9gPkbry6n90mqRRIITQkYt+C5V8igE/6Ee0KL2vcvRkxp+
         j6lmGi00yfORsid/a6VjyzxGct7pSvSxfNe5i1YTR2mfU6Fa0CDW7lHPC92PhqAYLb3o
         i3EDJSQO7UH6q4+ZNkWlze6oIstJ/R3eQ4FqK9UNR/oxgQy5DgBTosrDclckoA8ZuJx5
         peDg==
X-Gm-Message-State: AOAM5331umjMAnz08zEIGHOzfZ6jwXr0f9Z2BP/CdJm/tybL6oh2d8Ga
        Tib8WRaC7IhdBiIYMTZ6KXhnu3bFA2E=
X-Google-Smtp-Source: ABdhPJz9AR2B6cYt7gtAgkEGvWcOZ9RER9MNMmrbudcB1R/ZN1jULDGsxFpnH0LnRB9ftXArQNV5kQ==
X-Received: by 2002:a17:90a:4b4e:: with SMTP id o14mr1870701pjl.216.1601941722353;
        Mon, 05 Oct 2020 16:48:42 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id e11sm1093952pfl.58.2020.10.05.16.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 16:48:41 -0700 (PDT)
Date:   Mon, 5 Oct 2020 16:48:39 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v4 8/9] commit: use config-based hooks
Message-ID: <20201005234839.GF1393696@google.com>
References: <20200909004939.1942347-9-emilyshaffer@google.com>
 <20200923234734.1294057-1-jonathantanmy@google.com>
 <20201005212751.GH331156@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005212751.GH331156@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer wrote:
> On Wed, Sep 23, 2020 at 04:47:34PM -0700, Jonathan Tan wrote:

>>  - As for whether (1) it is OK for none of the hooks to be converted (and
>>    instead rely on the user to edit their hook scripts to call "git hook
>>    run ???"), or if (2) we should require some hooks to be
>>    converted, or if (3) we should require all hooks to be converted: I'd
>>    rather have (2) or (3) so that we don't have dead code. I prefer (3),
>>    especially since a reviewer wouldn't have to worry about leftover
>>    usages of old functions like find_hook() (as I mentioned at the start
>>    of this email), but I'm not fully opposed to (2) either.
>
> I personally prefer (3) - I think the user experience with (2) in a
> release (or even in 'next', which all Googlers use) is pretty bad. The
> downside, of course, is that a large topic gets merged all at once and
> makes some pretty nasty reviewer overhead.

One approach is to build up a series with "git hook run" and "git hook
list" demonstrating and testing the functionality and [PATCH n+1/n]
extra patches at the end converting existing hooks.  The user
experience from "git hook run" and even "git hook list" supporting a
preview of the future without built-in commands living in that future
yet would not be so bad, methinks.  And then a final series could
update the built-in commands' usage of hooks and would still be fairly
small.

In other words, I think I like (1), except *without* the
recommendation for users to edit their hook scripts to call "git hook
run" --- instead, the recommendation would be "try running this
command if you want to see what hooks will do in the future".

Thanks,
Jonathan

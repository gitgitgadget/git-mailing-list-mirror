Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F19DC433EF
	for <git@archiver.kernel.org>; Tue, 18 Jan 2022 21:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240373AbiARVYF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 16:24:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbiARVYE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 16:24:04 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7C2C061574
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 13:24:04 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id h12so502436pjq.3
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 13:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=8VhEEBxGCubN0Hbjh3WTdeqf9Jk/rBQXKvWlxZScQ/k=;
        b=b00kcNxvZIlrVTBwn6H2QunujnmicVYeAuZ33s5h/KxhyrKO5Eo4DvPKLG60we86nn
         S2E0kOIx5sWzm0bbjrY263LmmLfuHQ8azFBolz7PxPPg0cJRhmo+l6Z32Mfb/sSEiE2F
         B1JQhSn66BYC5NPaWcEULQ43EXhhFUzOidDNlGeBgcFhWcgHPghYFilrMhOO4dHO5bak
         E7Pj6Q7WqXunD7IgvvxBmJeGGS8EN0AOPdV/xQA2wjVzLiADXBZXZ+CDcUKY4VOjDQYS
         mnFqmfBLsOxlNdluItydxhACLx4ElvlZlL+skvEPOmOhrZJ3XdBnCl8QI0k7qY2pTY3L
         paGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=8VhEEBxGCubN0Hbjh3WTdeqf9Jk/rBQXKvWlxZScQ/k=;
        b=f9uFwZ2N0Fykae/TCsGzsKs3P5hO6v25fB7hLT6fbxAy7dmL45rZCE8gPkIuRbNj+q
         fy4k70c23qZdAIXrlbiQOYCXDua2dj2lIhB2wZTgM6/1665/ICnMnq6heeR4M+FyLnrx
         lHxvAZt9P7psbkU992yJW8d4grddH5sEibInQkdS92YsWwUwSGVfPdeY1dTtjLjOKQct
         6/lSDDsJOO4MtE8eoVxSXn0k1ltAPtqgx+jVxK8HPLAeWcU2mL/QCJ16GmduFmmTBEtg
         ER2+j0IQJi5YYLoBw5WaRUYubXCWLcKeyapMAqu9lXa09QFVmvrMTIYXaSa9Pws6S73f
         kytg==
X-Gm-Message-State: AOAM530S9wCdDGSkis1hzy25byWyj5zlk2qZbtoF+o6sbrWuCSiHuxN7
        xjJD4uwCQ8F3MOrdJogGMpjVTQ==
X-Google-Smtp-Source: ABdhPJwMsdMe1K3v2CwTZOIAIaCkg6XcNjgOsmnxvqh4kvGYtTroYE5sGqqWvqDyzFnSOMOGSCkQqw==
X-Received: by 2002:a17:902:6943:b0:14a:c6d3:d99b with SMTP id k3-20020a170902694300b0014ac6d3d99bmr8880035plt.89.1642541043549;
        Tue, 18 Jan 2022 13:24:03 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:bc30:e8ee:7a51:943c])
        by smtp.gmail.com with ESMTPSA id v10sm14588963pfg.19.2022.01.18.13.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 13:24:02 -0800 (PST)
Date:   Tue, 18 Jan 2022 13:23:56 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff Hostetler <jeffhost@microsoft.com>, git@vger.kernel.org
Subject: Re: [PATCH] test-lib: unset trace2 parent envvars
Message-ID: <Yecv7H5rrdMnRJBs@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>, git@vger.kernel.org
References: <82e51a52e20fbe13a5a898a0a2f6dbe1188e3fa3.1642116539.git.steadmon@google.com>
 <xmqq35lqetzw.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq35lqetzw.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022.01.13 22:01, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
> > This behavior breaks certain tests that examine trace2 output when the
> > tests run as a child of another git process, such as in `git rebase -x
> > "make test"`.
> 
> Well explained.  The paragraph makes it clear how easy to trigger
> and get bitten by this problem.
> 
> > While we could fix this by unsetting the relevant variables in the
> > affected tests (currently t0210, t0211, t0212, and t6421), this would
> > leave other tests vulnerable to similar breakage if new test cases are
> > added which inspect trace2 output. So fix this in general by unsetting
> > GIT_TRACE2_PARENT_NAME and GIT_TRACE2_PARENT_SID in test-lib.sh.
> 
> This probably makes sense, but I wonder how it interacts with a user
> who runs "cd t && GIT_TRACE2=blah ./t0987-test-this.sh" to trace the
> entire test script, though.

There shouldn't be any problems with this specific use case. I don't see
a valid reason for a test runner to fake GIT_TRACE2_PARENT_{NAME,SID}
though. None of the TRACE2 modes require using any of the PARENT
variables.


> > Reported-by: Emily Shaffer <emilyshaffer@google.com>
> > Helped-by: Jonathan Tan <jonathantanmy@google.com>
> > Signed-off-by: Josh Steadmon <steadmon@google.com>
> > ---
> >  t/test-lib.sh | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/t/test-lib.sh b/t/test-lib.sh
> > index 0f7a137c7d..e4716b0b86 100644
> > --- a/t/test-lib.sh
> > +++ b/t/test-lib.sh
> > @@ -449,6 +449,8 @@ unset VISUAL EMAIL LANGUAGE $("$PERL_PATH" -e '
> >  unset XDG_CACHE_HOME
> >  unset XDG_CONFIG_HOME
> >  unset GITPERLLIB
> > +unset GIT_TRACE2_PARENT_NAME
> > +unset GIT_TRACE2_PARENT_SID
> 
> Hmph.  Have you noticed the more generic "We want to unset almost
> everything that begins with GIT_, other than those selected few that
> are designed to be used to affect the tests" above the part you
> touched?
> 
> I am wondering if we should tweak the list there, instead of special
> casing these two and these two only. There is a pattern that allows
> anything that match "^GIT_(other|TRACE|things)", and I suspect that
> the pattern is way too loose (i.e. it allows any garbage to follow,
> and by allowing "TRACE", it also catches "TRACE2" because the former
> is a prefix of the latter), which is a problem.

Yes, due to the number of different TRACE2 modes, I figured it was
cleaner to allow them by default and then explicitly unset the ones that
cause trouble for trace parsing tests. But if you prefer to lock down
the list, I can send an alternate fix.


Thanks,
Josh

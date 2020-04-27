Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D84C4CECD
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 20:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C51522074F
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 20:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="olY+zprx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgD0Utx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 16:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726233AbgD0Utw (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 27 Apr 2020 16:49:52 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0733C0610D5
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 13:49:52 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id y6so138155pjc.4
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 13:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ni/sIPpEGEHlhMzgiq40ziCB6gck1sMUqu5v5b1we7g=;
        b=olY+zprxIr/J0VccvLFeGOpdVzMtepa/Zql4lxHcvnsMg7Fm5bLw2chDlPxPcQy7G6
         C9Q//XMHTOrknjZcu8r0+5tRTPv4d7JXld6Kgu6nqwLYRBdLTeN9M3MJp73pVvzQjTRI
         bngUZcbqQQX42lLd0gag6tkNGUjmU3qs2LCH1YxndO/b5Qi5mnwnY/mYfdpD27et8jJX
         NuLY4ZfG2kWaMD343ujruyokxk3EUZhQHGFrIdHIEEfwmTXt7dmp1y2S7llk8xt82a3G
         f7KquzVnQse32XZaCrJ0ZUsg4ywHniBiBmvx6u/HVpXDxS7L9qf3p7tOB1TYghIG8Le9
         HvFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ni/sIPpEGEHlhMzgiq40ziCB6gck1sMUqu5v5b1we7g=;
        b=d0afVSgpKzCHUq/GE1fa5v8paLtukk10vBfalf2yjz2l2BgKSwtdRAYRUxERAlDbgD
         rlULjg33wF0tF+ICbsLY/52ufLYO/MCHw1o+gjhRK/WJH55rX30SzEM00oQCj2DBLHfj
         c9fCZ5I1+K+vx0f+JytG4QlWNGJd2vH3Eclz4Da+tmp8ertCc0j5Q3kz+wCQQLe2HIGj
         nKYsDY6YPwDnK+6JaikXbwyFazAMmRToRaBjNYrJr3/hZzWa/Q9O9ThhfYj1xupuN2N/
         QobUvPLHULYevw5KFQwRyKr5CnP+u/eS3+f4GF7PQnpoQfvwYuHfLgl1Q4aoaaDZVnnW
         BUrw==
X-Gm-Message-State: AGi0PuZUB5PVF+rXY+aQ4UqHrxQRLhYpinVeLW25JSq/gU2pgoXf5CQy
        ZagMwT7+m8dP6BKhlTJwABbOVgS6gb4=
X-Google-Smtp-Source: APiQypJi/fEFXvOpDFGjGICoIJi0iGPwwHltNp0GEyssqtMo5wRL7w2QS2i4nE0eJvjom0/ZblzjkQ==
X-Received: by 2002:a17:902:32b:: with SMTP id 40mr8369665pld.73.1588020591609;
        Mon, 27 Apr 2020 13:49:51 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id l1sm176384pjr.17.2020.04.27.13.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 13:49:51 -0700 (PDT)
Date:   Mon, 27 Apr 2020 13:49:46 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] bugreport: collect list of populated hooks
Message-ID: <20200427204946.GB77802@google.com>
References: <20200424233800.200439-1-emilyshaffer@google.com>
 <xmqqsggs9ngo.fsf@gitster.c.googlers.com>
 <20200427190257.GA77802@google.com>
 <xmqqr1w87j2p.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqr1w87j2p.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 27, 2020 at 01:46:38PM -0700, Junio C Hamano wrote:
> 
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> >> > +	/*
> >> > +	 * NEEDSWORK: Doesn't look like there is a list of all possible hooks;
> >> > +	 * so below is a transcription of `git help hooks`. Later, this should
> >> > +	 * be replaced with some programmatically generated list (generated from
> >> > +	 * doc or else taken from some library which tells us about all the
> >> > +	 * hooks)
> >> > +	 */
> >> 
> >> Yes, I recall that we discussed adding some annotation to
> >> documentation and extracting this automatically.
> >
> > Right, we did. I think I was hesitant to move on it because I had
> > https://lore.kernel.org/git/20200420235310.94493-1-emilyshaffer@google.com
> > on my back burner and wasn't sure how the hook architecture would look
> > afterwards.
> 
> I thought we already agreed back then during that discussion I
> recalled that we'd leave that "single source of truth" unification
> out of the current topic.  Unless anything has changed recently to
> bring us closer to be ready to start designing, I think it still is
> fine to keep the needs-work comment above and punting.

Sure. Thanks.

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E7F6E6FE31
	for <git@archiver.kernel.org>; Mon, 25 Sep 2023 22:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbjIYWr2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Sep 2023 18:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbjIYWr1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2023 18:47:27 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DFBF12A
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 15:47:20 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-59c00b5c8b2so91499817b3.1
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 15:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1695682039; x=1696286839; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZOoClBMTBYeybFEVM+qxdXwb6ACyVy+2+1hgWtnIpnk=;
        b=PxISQSeA5zLkfLU6jukpKLWpyx5B138RjzZmKMvRg1URMIldJEJ7RH03XcvLiaXTWt
         U4RYGIdBSZAEdj9HXYEeK8zSanteX1t48l0LorbIHadh64vswBfuNMpGxvhc3cnbTSyE
         bfQrj4IS78ZxpYw1Y08M827ipZaOYYjkt+sovhcIT7hGtUZ9UgBIT+h6K8lfSOOMk651
         sghLSjI22OK1gL3F3Mcix+QgZ5PNAeFwBRu1MXvaD6K2cKF63ZmT3Fl17fl9NlwsUaCC
         KHlrOgT6bhJDU0pcb+XAWB5jaJSoBSC1ZjpeJEsAGt/XLtDUCSqfBkghSedxmiWbVIj8
         vMyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695682039; x=1696286839;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZOoClBMTBYeybFEVM+qxdXwb6ACyVy+2+1hgWtnIpnk=;
        b=X/39+SrU4GLIucL2xNYsulydoNoBzttOc8knDn4JG/qapRBfNE5WSEZIgtB3vn3AbC
         URHg6zBu95oflUD3DZxf132LBMYkrx1FseKgUjxzDJsCmKfVseE+7NX7Nfb71aoAurWh
         ET5Z4KCJrGekWsbppnrNzqr/jakvokFO0MPEsaCfqRS14FKRTj/crpSj/i+AkkzEsLM9
         U2omkZTkjqbLq1rtRz2bco1CXCXKmbBCR/p+Rq6YehBZpZCQm4VySbc5CJu3NhH7GoEG
         Agk8hDVHBYnnMIn/DR9+ZxwbpFZOTOSviXs7wiqZ1FR6JsKl6bsmAi6OlFNUinui8niZ
         GyvA==
X-Gm-Message-State: AOJu0Yz8FR8q7BGJmwNRp04X58pDs3m5WZ090TtJA3+y6vahfCBnOcJw
        6UzfXox/1w5mGanTHP6tkrlZzQ==
X-Google-Smtp-Source: AGHT+IEwKl9wpHWdjtWkFb0Bf/KLN7MgshrZhmExzjOtdIY7YRRJs0qoksh2ZNXweMqkl2mqRkc4gA==
X-Received: by 2002:a81:5b45:0:b0:59b:f8da:ffdb with SMTP id p66-20020a815b45000000b0059bf8daffdbmr8901001ywb.29.1695682039559;
        Mon, 25 Sep 2023 15:47:19 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id ci12-20020a05690c0a8c00b0059c0629d59csm459193ywb.115.2023.09.25.15.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 15:47:19 -0700 (PDT)
Date:   Mon, 25 Sep 2023 18:47:18 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] revision: make pseudo-opt flags read via stdin behave
 consistently
Message-ID: <ZRIN9gJsRgG4qj5r@nand.local>
References: <b93d4c8c23552abab64084b62f27944e7e192c0c.1695290733.git.ps@pks.im>
 <ZQyPOScCKhHeZNrr@nand.local>
 <ZRGBo1TsgSYrMt01@tanuki>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZRGBo1TsgSYrMt01@tanuki>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 25, 2023 at 02:48:35PM +0200, Patrick Steinhardt wrote:
> > > diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
> > > index a4a0cb93b2..9bf13bac53 100644
> > > --- a/Documentation/rev-list-options.txt
> > > +++ b/Documentation/rev-list-options.txt
> > > @@ -151,6 +151,8 @@ endif::git-log[]
> > >  --not::
> > >  	Reverses the meaning of the '{caret}' prefix (or lack thereof)
> > >  	for all following revision specifiers, up to the next `--not`.
> > > +	When used on the command line before --stdin, the revisions passed
> > > +	through stdin will not be affected by it.
> >
> > Hmmph. This seems to change the behavior introduced by 42cabc341c4. Am I
> > reading this correctly that tips on stdin with '--not --stdin' would not
> > be marked as UNINTERESTING?
> >
> > (Reading this back, there are a lot of double-negatives in what I just
> > wrote making it confusing for me at least. What I'm getting at here is
> > that I think `--not --stdin` should mark tips given via stdin as
> > UNINTERESTING).
>
> It does not change the behaviour, it only documents the current state
> such that it's at least spelled out somewhere.

Sorry, I must have been confused when writing this :-<. Looking at it
again, I agree that the current behavior is that "--not --stdin" treats
any tips given over stdin as INTERESTING, so this documentation is
consistent with that.

> > I wonder if we could instead do something like:
> >
> >   - inherit the current set of psuedo-opts when processing input over
> >     `--stdin`
> >   - allow pseudo-opts within the context of `--stdin` arbitrarily
> >   - prevent those psuedo-opts applied while processing `--stdin` from
> >     leaking over to subsequent command-line arguments.
> >
> > Here's one approach for doing that, where we make a copy of the current
> > set of flags when calling `read_revisions_from_stdin()` instead of
> > passing a pointer to the global state.
>
> That was indeed my first approach. But this change would break behaviour
> that was introduced with 42cabc341c4 (Teach rev-list an option to read
> revs from the standard input., 2006-09-05) almost 17 years ago. If we
> change it now then this is very likely to cause problems somewhere.

Per above, you're absolutely right. I think that the patch that you
proposed here LGTM.

Thanks,
Taylor

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA06C433F5
	for <git@archiver.kernel.org>; Sun,  9 Oct 2022 17:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiJIRXM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Oct 2022 13:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiJIRXL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Oct 2022 13:23:11 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D96A21813
        for <git@vger.kernel.org>; Sun,  9 Oct 2022 10:23:10 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id bu30so13980163wrb.8
        for <git@vger.kernel.org>; Sun, 09 Oct 2022 10:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ltr9rmm0NkfIPscTnFaN7xAm8DQSbehKc/dQCkFW7S0=;
        b=kHQVPC0jIeJ3YGkTzCmjGBWdnY2TiYC0hZKqzFD9v8xLrFC21ozWqzJSc2MZCfw4Iu
         gWpjm+n7VRaj+gaT/ulD8MUOHsJP2R0IRYFjhIH7sCzAki3Oa/J+ALzooreGoUV/g28+
         JjwW6rzCObX+GVufNaNuiL8NVAA/QiS0w9pCgbzSeKYdSHamZNYY4s7E3hqmaxvdhdbs
         rew54jFnsYqVNv5WTpTfbI39Rs+C7E5XtJhSh7gBouSkOG+lrndrjcckwLuLKn6HYQcG
         CkJH3swnuhgKt+Y1hegrB3QhVUuGDRfOYptA6ufoioCQb6UOIAy7HiPn0sJckm59Nr2S
         /TGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ltr9rmm0NkfIPscTnFaN7xAm8DQSbehKc/dQCkFW7S0=;
        b=wEqImvYavk+UeH6lLTY9zAnnIhbbE0lJD/UNe23aAhtbpxHH2+AZsBcYLEP9E0Pz05
         SKatlDr2VHQn6BLO+E6jQR4PcUv6Pac33USndbdhXZ0ToubLcmrpCJZ5HD5lKlkz5MOQ
         E0zWtPtCQ9uBxJmOgR5jAc9xAsNtwdy5kTPSM636FsR1lk4iUMmYD7E7fYGpI7HlRCz/
         GXlUnTiO27SvyGC2D5hbLZFFDBHNuezZK2QMvemtrq3iUYW4pnVM4No6sLVWbLFc1qHo
         GikfHk6RYPBJDPhWWPq55gtUaLi0rOevP6xS5hH/JnL+70DTWNKVXTsctOQfQ5/0IuvY
         99BQ==
X-Gm-Message-State: ACrzQf0sWZ3kIOB+lVRiLDXxkwr73uHnSyXz899OFAf2KtacKAIRTuNN
        WVypnOHSoN+Yow4X0IGjdko=
X-Google-Smtp-Source: AMsMyM4HxD8OsIWK7BEs7cloVlvNxSZ7z5bDyRxJYn7a3Udx1XBBuNnik/jhzBBsajlFVxVvL3lLZg==
X-Received: by 2002:adf:f410:0:b0:22e:3e12:237d with SMTP id g16-20020adff410000000b0022e3e12237dmr9288662wro.398.1665336188955;
        Sun, 09 Oct 2022 10:23:08 -0700 (PDT)
Received: from localhost (78-131-14-129.pool.digikabel.hu. [78.131.14.129])
        by smtp.gmail.com with ESMTPSA id l36-20020a05600c1d2400b003a62052053csm18087682wms.18.2022.10.09.10.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 10:23:08 -0700 (PDT)
Date:   Sun, 9 Oct 2022 19:23:06 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/6] sequencer: duplicate the result of
 resolve_ref_unsafe()
Message-ID: <20221009172306.GA2052@szeder.dev>
References: <20220930140948.80367-1-szeder.dev@gmail.com>
 <20220930140948.80367-6-szeder.dev@gmail.com>
 <1711157b-8f04-008b-1672-f1fbac3c3e81@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1711157b-8f04-008b-1672-f1fbac3c3e81@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 30, 2022 at 01:23:27PM -0400, Derrick Stolee wrote:
> > -	const char *head_ref = resolve_ref_unsafe("HEAD",
> > +	const char *head_ref = xstrdup_or_null(resolve_ref_unsafe("HEAD",
> >  						  RESOLVE_REF_READING,
> >  						  NULL,
> > -						  NULL);
> > +						  NULL));
> 
> Moving to a 'char *' matches our typical pattern of "I am responsible
> for freeing this or passing that responsibility to someone else."

Do we really have such a misleading pattern?

To me 'char*', as opposed to 'const char*', means that "I'll modify
the buffer where this pointer points to, and I must be on the lookout 
for when and how that happens".


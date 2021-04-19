Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7ED1C433B4
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 22:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9713760E0C
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 22:00:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbhDSWAu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 18:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbhDSWAr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 18:00:47 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28AFAC06174A
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 15:00:16 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id u8so27268451qtq.12
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 15:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=YcsYkm76s5WmBYZMiY//fz4h+cC0zRFCi0yvvoNkEWo=;
        b=XuMQSdx6LcMdcrajGiCfTrkM7J1bAtymu0O2nUSimllDS7obj/P9mruht5wW1DlHCv
         RqFF5VcvVWeN3no3Y4uApZFRGc8Odiq7e3rVUX5hdTxCtKWaRnc4Fusn5dWUxoEjd6hT
         doAvBspSdAEWelZan/daytIAqZH8otnShYrBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=YcsYkm76s5WmBYZMiY//fz4h+cC0zRFCi0yvvoNkEWo=;
        b=movx6amTAxpQP9iqlli4LxrHe31xanQE/YThA92LKM9YHlzrh4pFGmJzNfGxA/5eWK
         oZZKa9/ceKDWbg1HhX4ROkMMFo2tQTjcwY6vpsmPm5ox+IS1szLY6wnbECKS5CA+bvPc
         On9ElHR6aKlzPdIsQD9ghLBJ02BovLS+kB4lLa+vZjGY75TpPvIGZJBzwfeoH2QrceLA
         yHndZG39yVQ3a9vqFEdf8COWaMAdWlPiVKVkDmBgDKb3kQjjDoQXFZYD1RTruMHkpD/V
         EKCGFiyt1YXIGsOV/XY7Cnp5CW53Vbd8x/HoJ0gvUxXhJzt4O+7fbZFYiuvCl5SRoNIC
         FchQ==
X-Gm-Message-State: AOAM532LazeFvniFv7RhZoXlGJ5fM89sWkuoi4fbEIK86l023v/s/m2T
        GpcJSZHMVzosjyo7wryaUgi5Zw==
X-Google-Smtp-Source: ABdhPJzWvAFAsvp49t2SWDoSPhejo6Tx09L6h3rDUvMh5bi1B5vctfHHL9LuewERzv9vNe7Y+PH8cA==
X-Received: by 2002:ac8:7586:: with SMTP id s6mr13860203qtq.94.1618869615310;
        Mon, 19 Apr 2021 15:00:15 -0700 (PDT)
Received: from nitro.local ([89.36.78.230])
        by smtp.gmail.com with ESMTPSA id r1sm10661824qtt.3.2021.04.19.15.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 15:00:14 -0700 (PDT)
Date:   Mon, 19 Apr 2021 18:00:13 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Sebastian Schuberth <sschuberth@gmail.com>
Cc:     Eric Wong <e@80x24.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        patchwork@lists.ozlabs.org
Subject: Re: Pain points in Git's patch flow
Message-ID: <20210419220013.mguw4l5644r2c7gj@nitro.local>
Mail-Followup-To: Sebastian Schuberth <sschuberth@gmail.com>,
        Eric Wong <e@80x24.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>, patchwork@lists.ozlabs.org
References: <YHaIBvl6Mf7ztJB3@google.com>
 <22a0a383-0ae1-c7d1-75f7-7dfdfe5fb504@gmail.com>
 <87fszn48lh.fsf@evledraar.gmail.com>
 <CAHGBnuOVmzzhgW6GanHBXNb22UW3P1m3i6PJnOUEhYPO76hH4g@mail.gmail.com>
 <20210419193600.GA19186@dcvr>
 <CAHGBnuOv5PvCcKqed-sTOs2uxyuhRS7RDF4XvzPu9oHpyroasQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHGBnuOv5PvCcKqed-sTOs2uxyuhRS7RDF4XvzPu9oHpyroasQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 19, 2021 at 09:49:46PM +0200, Sebastian Schuberth wrote:
> > To watch a particular filename, the "dfn:" prefix may be used.
> > The prefixes supported for a particular instance are documented in
> > <https://public-inbox.org/git/_/text/help/>, and you
> > can watch multiple files by combining with "OR".
> 
> Thanks for pointing out these interesting features, I wasn't aware of them.

Eric is being modest. There are very cool things brewing in public-inbox, like
ability to create saved searches and follow threads you're interested in.
E.g. you should be able to define something like "whenever someone mentions my
favourite file, function name, or term, copy the entire thread into my inbox
and continuously update it with new messages."

I'm hoping that this will help turn the concept of mailing lists on their head
-- instead of subscribing to a list, folks will instead subscribe to closely
relevant saved searches across any number of remote and local sources.

> > Email is already well-established with a good amount of small
> > players, and plain-text is relatively inexpensive.  So it seems
> > best to build off the only halfway-decentralized thing we have
> > in wide use, rather than trying to start from scratch.
> 
> While I can understand that conservative approach for a community
> around a tool as important as Git, I still fear that only ever
> sticking to technology that is already in wide use will hinder to look
> over the rim of the tea cup.

I view email as merely one way of exchanging RFC2822-formatted messages. 
There are others and RFC2822 is robust enough to serve as a good standard
base that allows both free-form and structured content, including mixed.

-K

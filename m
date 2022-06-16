Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D306FC43334
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 21:58:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378609AbiFPV6O (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 17:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbiFPV6N (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 17:58:13 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03F933E2D
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 14:58:12 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 89so4111621qvc.0
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 14:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/unJzaFwRfpxxuPiVXnihgljENGy9wUbXfWMyNXmXZE=;
        b=SW6/yes5R6+8VThgTQkA/LZtrU+woLUqM3Rll2CkotEZR1ojWCtkBrxsf9V0TFRcK5
         QILOTEy1cqlZYR8qhJEKpcBB1BlnQ575fINgeNe2gw37arxPE+R9X0cwNu5CTGu6iUpZ
         pXREwu0PCp8i/e3mNe0R64udXDFVAknakMnSFrh9jYEEmFGfWRyhoCmMMAQfJ1LOe4gU
         PYVRpGpn8Iw1cq9injp8RSyHJ/kn9ZF0Rxtf7S/2uOxQidsmizi6DvEa206F2M5sS7EK
         JJU0wTY73ANBbNqSHxZDPhUQycNdVi61UF9Z6gP+48SyVzxpitVLBJRBGObP833uVBr1
         uszA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/unJzaFwRfpxxuPiVXnihgljENGy9wUbXfWMyNXmXZE=;
        b=T691TejoUY+pjmwYmOtLGDSwiWJU2KjTlrUvFHHSW6vQIKh+SMbTDCQskfxh1YDEhE
         ersWFA/OiMRiVKGWEjZ3/pdxfcYPSFCY3ALwyIE1YniL+O7WR9KVDpTV8bvw5+c9HryJ
         Uz33BDGjx7fUm+syqyk+bjn8bo+xvsq9BfM8Xf/PPAg+Ab6JdFmcEa52p1Dvlf6I43yA
         jxJR7nuPBk1jJ6QMOgLpic5UIp0hJXzvdrMWS8dYbVvNT0sZknYwwAlxTLcY+WfXHY/I
         w5MQHrAKWKHLV3eGrrzVmDBr8vxHTVwtmDnXgG2p9bzQ4+7SplIxdHHUTqUDIxoWLCwO
         IIQQ==
X-Gm-Message-State: AJIora8ivN/+jiWdEmc4+n9SXhERptaukL3/KahDmI3bj1x6MUMufFXC
        jhvx0ZMzq+1K5XpyrY6L39iQzRgbtmd347T6
X-Google-Smtp-Source: AGRyM1v1lBFvXeURVVVQtrKorX9cU1yGvdWS4ZLP9srMelTm8i/EJm2ZwDrj4uerXEKwu1LkRpROSA==
X-Received: by 2002:a05:622a:4ca:b0:304:f29e:7cc5 with SMTP id q10-20020a05622a04ca00b00304f29e7cc5mr5980165qtx.156.1655416691948;
        Thu, 16 Jun 2022 14:58:11 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d8-20020ac85d88000000b00304edcfa109sm2898950qtx.33.2022.06.16.14.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 14:58:11 -0700 (PDT)
Date:   Thu, 16 Jun 2022 17:58:10 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: gc/bare-repo-discovery (was Re: What's cooking in git.git (Jun
 2022, #04; Mon, 13))
Message-ID: <YquncgVEpWIG7lJ7@nand.local>
References: <xmqq35g82f0y.fsf@gitster.g>
 <kl6lzgid4u5p.fsf@chooglen-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <kl6lzgid4u5p.fsf@chooglen-macbookpro.roam.corp.google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 15, 2022 at 12:13:22PM -0700, Glen Choo wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
> > * gc/bare-repo-discovery (2022-06-07) 5 commits
> >  - setup.c: create `discovery.bare`
> >  - safe.directory: use git_protected_config()
> >  - config: read protected config with `git_protected_config()`
> >  - Documentation: define protected configuration
> >  - Documentation/git-config.txt: add SCOPES section
> >
> >  Introduce a discovery.barerepository configuration variable that
> >  allows users to forbid discovery of bare repositories.
> >
> >  Expecting a reroll.
> >  source: <29053d029f8ec61095a2ad557be38b1d485a158f.1654635432.git.gitgitgadget@gmail.com>
>
> v4 hasn't been reviewed yet. I think "Needs Review" is more accurate.

Yep, I agree that we can move this to "needs review". FWIW, I've been
meaning to look at the more recent iterations of this series, but
haven't quite gotten to it yet.

Thanks,
Taylor

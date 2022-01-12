Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D8E8C433EF
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 19:22:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345301AbiALTW0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 14:22:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350059AbiALTVg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 14:21:36 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C804C06173F
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 11:21:36 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id i82so5131610ioa.8
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 11:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=x8pTwG6txIZrjZHhimAV6JENT06h8ae4JzwhktH4mtA=;
        b=O0TzQjV9Db0atcms8ymrRa4giz1AtKv0vQHalge35+iXteP0qA0oY0+RJQKLz9VQFx
         ZE4VqUtK7LTxwLnE5NdzIeNAT6WAt4pMoIqxn+/HxUEMfyCdkU96gZmzsuVYWAMm81r3
         gTdneQqvFQHw7y4SA8qxXCtCQh3Wma9eBoIfN9T0WyJDkWcCICV7slgC6TXcrqxao6/9
         lj2p5hRmnYdRsk/VOqQ5gxYJrY8q1p1oXq9FlrBym84Kwa5UDtomkgJmQzJyOpO/kDf5
         QDZz4/K+QOmcy7Hts1Gazvbh+3VTm3vO0OxwVtves7GCn55mPKLAEaqtLTBhqg0AmygB
         mpXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x8pTwG6txIZrjZHhimAV6JENT06h8ae4JzwhktH4mtA=;
        b=yDsBWOFSd2fYh6PUIypO2dGkOq+FAif5PjkM9cYAl+LQeLh6osy1LVFfAtSWlzIP6F
         +ldjolTk3FLHFufmCH1KrFlQ34e/XDLMA8hO1oIcEEggo7aNZk6Enkrz8Iac16uySKpB
         QEhvIvUQPCwxcuOmHmZq3fxOWzfB25zw3AXTKgdiD7qQ485nvjKZ8qzE4htkI8itA81c
         woEuwuxa/OZnDvudinoaj1oIxfm3U26f/gvd4+trHKb5uEaw9pMzEOFP99GXrRj6y1Sh
         U3AK4zwqAGaI47zHzEnCFKM7SNsRD5x7qiJZlCcmNjwfoFnhmUMOZpMz9ac2GiIvdHET
         lNdA==
X-Gm-Message-State: AOAM531YZZjP7Gvf+cwq1BrLnrJGVTg4UN/SAxV0rl7FL07UbIU+8yoJ
        RKAZRNCllgvHj+iMwIbCuoSd59N5NgyU9A==
X-Google-Smtp-Source: ABdhPJwUdIvCjSn1RMoMn0tj5SfEIN0RZprXxnpNqgqiF71fkHZxvaR+KWYEj+bPkENo3c3oT+vQKg==
X-Received: by 2002:a5d:9d92:: with SMTP id ay18mr625229iob.130.1642015295995;
        Wed, 12 Jan 2022 11:21:35 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u14sm409975ilv.66.2022.01.12.11.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 11:21:35 -0800 (PST)
Date:   Wed, 12 Jan 2022 14:21:35 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     rsbecker@nexbridge.com, 'Taylor Blau' <me@ttaylorr.com>,
        git@vger.kernel.org
Subject: Re: [BUG] Re: Git 2.35.0-rc0
Message-ID: <Yd8qP75AO0ZJyQJZ@nand.local>
References: <00fd01d80691$c87e3ad0$597ab070$@nexbridge.com>
 <Ydzw+RqR6IfbT/oM@nand.local>
 <010b01d80697$0c848770$258d9650$@nexbridge.com>
 <Ydzyv8ZCEpDDRBXT@nand.local>
 <010d01d8069e$8d330480$a7990d80$@nexbridge.com>
 <xmqqzgo0u5j7.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzgo0u5j7.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 12, 2022 at 11:18:20AM -0800, Junio C Hamano wrote:
> <rsbecker@nexbridge.com> writes:
>
> > diff --git a/config.mak.uname b/config.mak.uname
> > index a3a779327f..9b3e9bff5f 100644
> > --- a/config.mak.uname
> > +++ b/config.mak.uname
> > @@ -576,6 +576,7 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
> >         NO_SETENV = YesPlease
> >         NO_UNSETENV = YesPlease
> >         NO_MKDTEMP = YesPlease
> > +       NO_UNCOMPRESS2 = YesPlease
> >         # Currently libiconv-1.9.1.
> >         OLD_ICONV = UnfortunatelyYes
> >         NO_REGEX = NeedsStartEnd
> >
> > Could we get that into rc1?
>
> Sure, with an appliable patch that is properly signed off.

I'm happy to attach my s-o-b to the below as well (and in general, that
it's safe to assume my sign-off is provided to everything I post to the
list, unless I explicitly say otherwise), since I originally suggested
the diff.

Thanks,
Taylor

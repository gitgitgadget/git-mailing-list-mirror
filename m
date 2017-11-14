Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81BEE201C8
	for <e@80x24.org>; Tue, 14 Nov 2017 08:44:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752769AbdKNIoq (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 03:44:46 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:47541 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751790AbdKNIoo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 03:44:44 -0500
Received: by mail-wr0-f193.google.com with SMTP id k61so16761954wrc.4
        for <git@vger.kernel.org>; Tue, 14 Nov 2017 00:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kvOz0xC+BaibmUj3WbF80n4yJRxPlXhs0YJ37QyItJc=;
        b=tjtcb0KVLUfnrCXQgrLB5yyJg8ZlI6ToAwuc2Gble0SLtXly0M8+iZY9lW8iXJ6pxC
         iSAslsTOYrImV9nti+rgX7ritOvzmyjBHCmEzPCz9UCBZ2kRtjLg0N5U+247iBs3/HW8
         UNvd2Q9BpCkbWobpGMirlkcwhgs/Mo8RbfCxR462gm7QOUM28GAT2M0IrnjOdArNKDaH
         SldChBrQwRLRieicvHy9V2rfwQxu4jnrL47EYvd540pBc80+6kd96R/Joqwfb2azyekk
         LaRNZKhGOFbcTAj2jEd3PpVv9A8siqja244XuPriRGjaarm/lPIz/htgDb6qIBAJx7zq
         ZMmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kvOz0xC+BaibmUj3WbF80n4yJRxPlXhs0YJ37QyItJc=;
        b=mBjUk6gDvs2mPxBlbNnCsGhBg61GWyIN20m7Ed1Ccs/+djKAQrWfoFTA4aKsAl3X2Z
         0FdKgnFmvrA6qlPzpXHN5K9pXiYD5XB/v/k4R7oGPWdLHT34uD05edwMWsIYAPSafaZ3
         hZp9hPNEqGIJj/10zYyBttS0wQeclZT/l4WgihDy8G9uHxK+hm98xIxal0Xn8oX88lCM
         u+SPL8iagSi856E9z+ajzFi8DFF8a//CxoVCZOgHhWXBFGGi1B8VzfkgBhwUfDRpEEMD
         SbPmViLes9+FIMY94KYZSjfk7LfAyURBkanDjVYp2rGCnObucW17fLl6NvZ9GReK2nwI
         lpFw==
X-Gm-Message-State: AJaThX5ERCQRvZh3eho4ZcoRunHlYg8jvf/GEWN5Hq44FzBXaPzswaSy
        gSbj3N3EBsIHYiEAWRnq5sc=
X-Google-Smtp-Source: AGs4zMaubj0JudJJejZLA8OLb5iV+BNsMgljHFUlcbWKh3bGHiqMMTyQs7ulPKfxRvMdqvzkr6WWUQ==
X-Received: by 10.223.135.132 with SMTP id b4mr9843946wrb.248.1510649083494;
        Tue, 14 Nov 2017 00:44:43 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id o70sm59339665wrb.62.2017.11.14.00.44.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Nov 2017 00:44:42 -0800 (PST)
Date:   Tue, 14 Nov 2017 08:46:07 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v1 1/2] checkout: factor out functions to new lib file
Message-ID: <20171114084607.GB12097@hank>
References: <20171112134305.3949-1-t.gummerer@gmail.com>
 <xmqq7euuc32z.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7euuc32z.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/13, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> > Factor the functions out, so they can be re-used from other places.  In
> > particular these functions will be re-used in builtin/worktree.c to make
> > git worktree add dwim more.
> >
> > While there add a description to the function.
> >
> > Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> > ---
> >
> > I'm not sure where these functions should go ideally, they don't seem
> > to fit in any existing library file, so I created a new one for now.
> > Any suggestions for a better home are welcome!
> >
> >  Makefile           |  1 +
> >  builtin/checkout.c | 41 +----------------------------------------
> >  checkout.c         | 43 +++++++++++++++++++++++++++++++++++++++++++
> >  checkout.h         | 14 ++++++++++++++
> >  4 files changed, 59 insertions(+), 40 deletions(-)
> >  create mode 100644 checkout.c
> >  create mode 100644 checkout.h
> 
> I am not sure either.  I've always considered that entry.c is the
> libified thing codepath that want to do a "checkout" should call,
> but the functions that you are moving is at a "higher layer" that
> does not concern the core-git data structures (i.e. the 'tracking'
> is a mere "user" of the ref API, unlike things in entry.c such as
> checkout_entry() that is a more "maintainer" of the index integrity),
> so perhaps it makes sense to have new file for it.

Makes sense, let me keep it as a new file then.

> > diff --git a/checkout.c b/checkout.c
> > new file mode 100644
> > index 0000000000..a9cf378453
> > --- /dev/null
> > +++ b/checkout.c
> > @@ -0,0 +1,43 @@
> > +#include "cache.h"
> > +
> 
> A useless blank line.
> 
> > +#include "remote.h"
> > +
> 
> This one is useful ;-)
> 
> > +struct tracking_name_data {
> > ...
> > diff --git a/checkout.h b/checkout.h
> > new file mode 100644
> > index 0000000000..9272fe1449
> > --- /dev/null
> > +++ b/checkout.h
> > @@ -0,0 +1,14 @@
> > +#ifndef CHECKOUT_H
> > +#define CHECKOUT_H
> > +
> > +#include "git-compat-util.h"
> > +#include "cache.h"
> 
> Try "git grep -e git-compat-util Documentation/CodingGuidelines" and
> just keep inclusion of "cache.h".

Ah I forgot about that.  Will fix, thanks!

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B551C1F404
	for <e@80x24.org>; Thu, 22 Feb 2018 19:51:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751359AbeBVTvh (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 14:51:37 -0500
Received: from mail-pl0-f51.google.com ([209.85.160.51]:37463 "EHLO
        mail-pl0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750967AbeBVTvg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 14:51:36 -0500
Received: by mail-pl0-f51.google.com with SMTP id ay8so3476779plb.4
        for <git@vger.kernel.org>; Thu, 22 Feb 2018 11:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CqOsGKv25EImcZcKFx8FQbFZEq9Fkm2Kl/cb2m70ECw=;
        b=uRlSLBkTDcVQ0xnn1BYrJg7woRCT3yecjtCij3cY/PKRjyvNAlv719Hdgv3UuDbAT4
         lj9sWjswWw6PXvyFXPXCJ1GDUw6bMuaiR+kw/p/MwWDByQ/2qmq30Efebke5MoGkz3mb
         BP61h67xxfCMgynhmXzUWfx7EqvzUPSm3SPE3iNUtfdzrKUcKgt715eBUHG1YJgBkDY9
         73RfAPmBHDI2U9W0vlP08RsPSBlahI8gaYBgMc+nWlZdKG9zHDpYYUcf3aZ4rUZ1KliK
         NQDhhMnD47ni60VVH+LDrxBKe2mYRYkvLJO4yTZZlDBneMA5Lu8YB/dhUDnKnkAUOyXR
         Fogg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CqOsGKv25EImcZcKFx8FQbFZEq9Fkm2Kl/cb2m70ECw=;
        b=YRcrrL1SbWZNyaqLZMbJerAJTGOKfsme0V1nWzkJznCswvk0sD4/WCC9kOoX9Crowf
         I/uQ/85ol09OWo8JL2FoUfFhupFuxrKvYwgUx2Hjifcivwu/vcP+Ah4Uhab3H/aLx2Jz
         g9HtzkMf0D0YCkiKGhLa2AhNXylTVCPf//nXyjNfZU09l6+IFGoeVMSGLJCfjgqc51Tw
         bU6e560ZzBjYb1devAVX64tHs9dC9YfuqYX/+Vv+FYYKoXX5H0MuVhafyJcE5xMC8nOf
         GTmvAnuFktw5m96TVh0UOser0zZswiN+bIxEw406ObqGtAEs5Lw54tEsIdf9pMn4uY6x
         bGMQ==
X-Gm-Message-State: APf1xPBGPJTNs/A+tauXYQHZCWwa2YwWGNWg9sxuXBBdoYS+beFABnAd
        7gtx1RyJS3CdScGgJqQyeZBh6cyC8T8=
X-Google-Smtp-Source: AH8x227rarLPWt0buOhqIWFIaTSBcRbuqlyPkmPxFW0I6obk2e7E3ppWMDFqw2hJFNH3YXuQ1ZGZkA==
X-Received: by 2002:a17:902:3381:: with SMTP id b1-v6mr7909153plc.20.1519329095814;
        Thu, 22 Feb 2018 11:51:35 -0800 (PST)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id k3sm1139162pff.41.2018.02.22.11.51.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Feb 2018 11:51:34 -0800 (PST)
Date:   Thu, 22 Feb 2018 11:51:33 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        gitster@pobox.com, jrnieder@gmail.com, stolee@gmail.com,
        git@jeffhostetler.com, pclouds@gmail.com
Subject: Re: [PATCH v3 16/35] transport: convert transport_get_remote_refs to
 take a list of ref patterns
Message-ID: <20180222195133.GO185096@google.com>
References: <20180125235838.138135-1-bmwill@google.com>
 <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-17-bmwill@google.com>
 <20180221145804.f483fb21559f71618812404d@google.com>
 <20180222182647.GF185096@google.com>
 <20180222113226.208f86fff80fb0d05c620433@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180222113226.208f86fff80fb0d05c620433@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/22, Jonathan Tan wrote:
> On Thu, 22 Feb 2018 10:26:47 -0800
> Brandon Williams <bmwill@google.com> wrote:
> 
> > On 02/21, Jonathan Tan wrote:
> > > On Tue,  6 Feb 2018 17:12:53 -0800
> > > Brandon Williams <bmwill@google.com> wrote:
> > > 
> > > > -const struct ref *transport_get_remote_refs(struct transport *transport)
> > > > +const struct ref *transport_get_remote_refs(struct transport *transport,
> > > > +					    const struct argv_array *ref_patterns)
> > > >  {
> > > >  	if (!transport->got_remote_refs) {
> > > > -		transport->remote_refs = transport->vtable->get_refs_list(transport, 0, NULL);
> > > > +		transport->remote_refs =
> > > > +			transport->vtable->get_refs_list(transport, 0,
> > > > +							 ref_patterns);
> > > >  		transport->got_remote_refs = 1;
> > > >  	}
> > > 
> > > Should we do our own client-side filtering if the server side cannot do
> > > it for us (because it doesn't support protocol v2)? Either way, this
> > > decision should be mentioned in the commit message.
> > 
> > If someone wants to add this in the future they can, but that is outside
> > the scope of this series.
> 
> In that case, also document that this function is allowed to return refs
> that do not match the ref patterns.
> 
> Unlike in patch 15 (which deals with the interface between the transport
> code and transport vtables, which can be changed as long as the
> transport code is aware of it, as I wrote in [1]), this may result in
> user-visible differences depending on which protocol is used. But after
> more thinking, I don't think we're in a situation yet where having extra
> refs shown/written are harmful, and if it comes to that, we can tighten
> this code later without backwards incompatibility. So, OK, this is fine.
> 
> [1] https://public-inbox.org/git/20180221145639.c6cf2409ce2120109bdd169f@google.com/

I'll add the documentation.

-- 
Brandon Williams

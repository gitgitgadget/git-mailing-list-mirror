Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35CD91F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 17:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406434AbeKWETz (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Nov 2018 23:19:55 -0500
Received: from cloud.peff.net ([104.130.231.41]:48758 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2406442AbeKWETz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Nov 2018 23:19:55 -0500
Received: (qmail 26795 invoked by uid 109); 22 Nov 2018 17:39:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 22 Nov 2018 17:39:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23759 invoked by uid 111); 22 Nov 2018 17:38:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 22 Nov 2018 12:38:57 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Nov 2018 12:39:31 -0500
Date:   Thu, 22 Nov 2018 12:39:31 -0500
From:   Jeff King <peff@peff.net>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Matthew DeVore <matvore@google.com>
Subject: Re: how does "clone --filter=sparse:path" work?
Message-ID: <20181122173931.GA22123@sigill.intra.peff.net>
References: <20181108050755.GA32158@sigill.intra.peff.net>
 <79b06312-75ca-5a50-c337-dc6715305edb@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <79b06312-75ca-5a50-c337-dc6715305edb@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 08, 2018 at 01:57:52PM -0500, Jeff Hostetler wrote:

> > Should we simply be disallowing sparse:path filters over upload-pack?
> 
> The option to allow an absolute path over the wire probably needs more
> thought as you suggest.
> 
> Having it in the traverse code was useful for local testing in the
> client.
> 
> But mainly I was thinking of a use case on the client of the form:
> 
>     git rev-list
>         --objects
>         --filter=spec:path=.git/sparse-checkout
>         --missing=print
>         <commit>
> 
> and get a list of the blobs that you don't have and would need before
> you could checkout <commit> using the current sparse-checkout definition.
> You could then have a pre-checkout hook that would bulk
> fetch them before starting the actual checkout.  Since that would be
> more efficient than demand-loading blobs individually during the
> checkout.  There's more work to do in this area, but that was the idea.
> 
> But back to your point, yes, I think we should restrict this over the
> wire.

Thanks for your thorough response, and sorry for the slow reply. I had
meant to reply with a patch adding in the restriction, but I haven't
quite gotten to it. :)

It's still on my todo list, but I'm going to be offline for a bit for
vacation, and I didn't want to leave this totally hanging without a
response.

-Peff

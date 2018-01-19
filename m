Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4DFF1F404
	for <e@80x24.org>; Fri, 19 Jan 2018 21:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756567AbeASVwX (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jan 2018 16:52:23 -0500
Received: from cloud.peff.net ([104.130.231.41]:50150 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1756461AbeASVwV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jan 2018 16:52:21 -0500
Received: (qmail 25938 invoked by uid 109); 19 Jan 2018 21:52:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 19 Jan 2018 21:52:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24990 invoked by uid 111); 19 Jan 2018 21:52:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 19 Jan 2018 16:52:57 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Jan 2018 16:52:19 -0500
Date:   Fri, 19 Jan 2018 16:52:19 -0500
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2] diff: add --compact-summary option to complement
 --stat
Message-ID: <20180119215219.GC12074@sigill.intra.peff.net>
References: <20180113132211.13350-1-pclouds@gmail.com>
 <20180118100546.32251-1-pclouds@gmail.com>
 <20180118224814.GA8473@sigill.intra.peff.net>
 <CACsJy8CPHk+aXHr-mkHZi27s=c3+ny8D9CSuzOSO8PweviBcqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8CPHk+aXHr-mkHZi27s=c3+ny8D9CSuzOSO8PweviBcqQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 19, 2018 at 07:26:28AM +0700, Duy Nguyen wrote:

> > (I know this is a bikeshed, so I'm perfectly willing to take "yuck, I
> > don't like that as well" as a response).
> 
> The position of A+x column is exactly where gerrit put it. Though web
> pages have more flexibility than our terminal console so its position
> does not have to be the same. I'm just throwing options out there
> 
> For many years I have this instead
> 
>  t/t5573-pull-verify-signatures.sh (new +x) | 81 ++++++++++++++++++++
> 
> Another option is just wrap the code in [] to make it look like check
> boxes. But that wastes two more columns
> 
>        builtin/merge.c                    |  2 +
>  [A+x] t/t5573-pull-verify-signatures.sh  | 81 ++++++++++++++++++++++++
>        t/t7612-merge-verify-signatures.sh | 45 +++++++++++++

Yeah, I almost suggested brackets, but wasn't sure if people would balk
at the extra 2 columns. But they do help it stand out more. Colors would
help, too, as you noted. Though they would not transfer over email, and
I wonder if people would want to use this for format-patch.

> Back to your suggestion, I kinda like the closeness between the +/-
> count and "|" though. The output on 10c78a162f is like this, which
> makes "A" looks a bit umm.. disconnected from the path name?
> 
>   Documentation/RelNotes/2.14.0.txt | A  97 +++++++++++++++++++++++++++
>   GIT-VERSION-GEN                   |     2 +-
>   RelNotes                          |     2 +-

Yeah, I was trying to get it away from the pathname, since it doesn't
stand out as much. I guess it depends how you think of the "A". To me it
is sensible as a modifier for the line-count change. I.e., My read on
the output above is "here is a path; it was added with 97 lines".

> > One thing I noticed is that --compact-summary by itself does nothing.
> > Should it imply --stat?
> 
> It might go with --numstat or --dirstat in future too. Didn't really
> think hard about this yet. But I probably will go with Eric suggestion
> and keep this in --stat=.... unless it really makes sense to have
> something like this in --numstat or --dirstat.

I'd think that most consumers of --numstat are not human, and would
just use "--numstat --raw" to get all the information. But I also have
not thought hard about it.

Anyway, thanks for listening. :)

-Peff

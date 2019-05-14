Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE4EC1F461
	for <e@80x24.org>; Tue, 14 May 2019 08:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbfENIpg (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 04:45:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:56526 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725916AbfENIpg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 04:45:36 -0400
Received: (qmail 2178 invoked by uid 109); 14 May 2019 08:45:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 14 May 2019 08:45:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10072 invoked by uid 111); 14 May 2019 08:46:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 14 May 2019 04:46:14 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 May 2019 04:45:34 -0400
Date:   Tue, 14 May 2019 04:45:34 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Todd Zullinger <tmz@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] test-lib: try harder to ensure a working jgit
Message-ID: <20190514084534.GA9567@sigill.intra.peff.net>
References: <20190514020520.GI3654@pobox.com>
 <20190514021419.GI7458@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190514021419.GI7458@genre.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 14, 2019 at 02:14:19AM +0000, brian m. carlson wrote:

> On Mon, May 13, 2019 at 10:05:20PM -0400, Todd Zullinger wrote:
> > diff --git a/t/test-lib.sh b/t/test-lib.sh
> > index 908ddb9c46..599fd70e14 100644
> > --- a/t/test-lib.sh
> > +++ b/t/test-lib.sh
> > @@ -1522,7 +1522,7 @@ test_lazy_prereq NOT_ROOT '
> >  '
> >  
> >  test_lazy_prereq JGIT '
> > -	type jgit
> > +	jgit --version
> >  '
> 
> I think this is an improvement, not only because of the reasons you
> mentioned, but because we remove the use of "type", which is not
> guaranteed to be present in a POSIX shell.

Isn't it? I have always treated it as the most-portable option for this
(compared to, say, `which`).  It is in POSIX as a utility (albeit marked
with XSI), which even says (in APPLICATION USAGE):

  Since type must be aware of the contents of the current shell
  execution environment (such as the lists of commands, functions, and
  built-ins processed by hash), it is always provided as a shell regular
  built-in.

All that said, I think Todd's patch makes perfect sense even without
wanting to avoid "type".

-Peff

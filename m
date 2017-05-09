Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 328981FF34
	for <e@80x24.org>; Tue,  9 May 2017 04:07:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752475AbdEIEH0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 May 2017 00:07:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:47908 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751272AbdEIEHZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2017 00:07:25 -0400
Received: (qmail 16199 invoked by uid 109); 9 May 2017 04:07:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 May 2017 04:07:25 +0000
Received: (qmail 20032 invoked by uid 111); 9 May 2017 04:07:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 May 2017 00:07:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 May 2017 00:07:22 -0400
Date:   Tue, 9 May 2017 00:07:22 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jordi Mas <jmas@softcatala.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Not translatable strings in Git
Message-ID: <20170509040722.dd2yt4254g3raeev@sigill.intra.peff.net>
References: <f3bfb85c-1722-e720-3d36-40c29a692867@softcatala.org>
 <CAGZ79kbtT6QCbd3-MpWiTm3r_cyBOLsa9kvd-KLNr8eEe+9v9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kbtT6QCbd3-MpWiTm3r_cyBOLsa9kvd-KLNr8eEe+9v9Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 08, 2017 at 09:49:34AM -0700, Stefan Beller wrote:

> On Sat, May 6, 2017 at 1:40 AM, Jordi Mas <jmas@softcatala.org> wrote:
> > Hello,
> >
> > When translating git (https://github.com/git/git/tree/master/po)
> >
> > The following strings cannot be translated:
> >
> >  remote: Counting objects: 331, done.
> >  remote: Compressing objects: 100% (213/213), done.
> >  remote: Total 244 (delta 184), reused 34 (delta 29)
> 
> This is what the remote server tells a client, but the client did not
> tell the server which locale it has.
> 
> Now consider we have hosting service that hosts projects accessible from
> a wide range of users, all of them having different locales. Which language
> should the remote speak? (Not knowing which language the client speaks).

In theory the client could pass the locale variables. We probably
already do by default over ssh. Likewise we could ask curl to send an
HTTP header based on the current locale, and the server could respect
that. That probably wouldn't even be that much code. I think it's just
something that nobody has bothered to implement so far.

> >  27 files changed, 3399 insertions(+), 3320 deletions(-)
> >  create mode 100644 build-aux/flatpak/org.gnome.Nautilus-stable.json
> >  delete mode 100755 build-aux/meson/check_libgd.sh
> 
> These sound like they are done locally and could be translated easily.
> However I wonder if we have issues with leaky plumbing in the user porcelain.

I don't think the diffstat summary is marked for translation at all,
plumbing or not.  There's some history there:

  http://public-inbox.org/git/1345922816-20616-1-git-send-email-pclouds@gmail.com/t/#u

There was an attempt to re-enable it for local-only commands:

  http://public-inbox.org/git/alpine.DEB.2.00.1210231323480.602@ds9.cixit.se/

but nobody seems to have responded (I don't have much of an opinion
myself).

-Peff

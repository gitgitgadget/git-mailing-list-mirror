Return-Path: <SRS0=caIn=3X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66730C33CAC
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 10:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39E7820721
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 10:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbgBCKBK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Feb 2020 05:01:10 -0500
Received: from cloud.peff.net ([104.130.231.41]:51116 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727494AbgBCKBK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Feb 2020 05:01:10 -0500
Received: (qmail 1759 invoked by uid 109); 3 Feb 2020 10:01:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 03 Feb 2020 10:01:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23344 invoked by uid 111); 3 Feb 2020 10:09:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 Feb 2020 05:09:14 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 3 Feb 2020 05:01:08 -0500
From:   Jeff King <peff@peff.net>
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: git-compat-util.h:798:13: =?utf-8?Q?er?=
 =?utf-8?B?cm9yOiBjb25mbGljdGluZyB0eXBlcyBmb3Ig4oCYaW5ldF9udG9w4oCZ?=
Message-ID: <20200203100108.GA1072975@coredump.intra.peff.net>
References: <CAH8yC8m3JFvEcfFF3z1rrRnEPK-adHGObmkOhNZiph7QJKUWqA@mail.gmail.com>
 <CAH8yC8mh0gysNz3Dbrph0f8KZ8DEWaH-6rWg6fSOD-_aGh3=3A@mail.gmail.com>
 <20200203085405.GC2164@coredump.intra.peff.net>
 <CAH8yC8=_9OtBJ2dMJPSGb3bYf-b+C6GYXx+NP4Dy_LDCoiks+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAH8yC8=_9OtBJ2dMJPSGb3bYf-b+C6GYXx+NP4Dy_LDCoiks+A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 03, 2020 at 03:59:19AM -0500, Jeffrey Walton wrote:

> > :) I second Junio's notion there that you may be better off skipping
> > ./configure entirely.Thanks Jeff.
> 
> I run 'make configure' and configure because that's what the INSTALL
> tells me to do.
> 
> Forgive my ignorance... If I don't run configure, then how do I
> configure things?

Above the "Alternatively you can use autoconf..." in INSTALL, there is:

  The beginning of the Makefile documents many variables that affect the
  way git is built.  You can override them either from the command line,
  or in a config.mak file.

You often don't need to set most of those flags, because
config.mak.uname picks some defaults based on the platform we find via
"uname".

So I'd first just try "make" without any config. If that doesn't work
out of the box, a patch to update config.mak.uname would be welcome.

If "./configure && make" also doesn't work, certainly patches are
welcome there, too. The reason I say you may be better off skipping it
is that historically it seems to not be kept as up-to-date. Usually it
would not make things _worse_ to run it, but in this inet_ntop case, I
think it does.

-Peff

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60624C61DA4
	for <git@archiver.kernel.org>; Fri, 17 Feb 2023 00:43:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjBQAns (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Feb 2023 19:43:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBQAnr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2023 19:43:47 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2F03580
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 16:43:46 -0800 (PST)
Received: (qmail 936 invoked by uid 109); 17 Feb 2023 00:43:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 17 Feb 2023 00:43:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14526 invoked by uid 111); 17 Feb 2023 00:43:45 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 16 Feb 2023 19:43:45 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 16 Feb 2023 19:43:45 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     tm-uzr3z@entrap.de, git@vger.kernel.org
Subject: Re: [PATCH] add basic http proxy tests
Message-ID: <Y+7NwQer53hP9ekm@coredump.intra.peff.net>
References: <c0862f86061c220af289ce812d57f9c7.squirrel@www.entrap.de>
 <Y+6WOF+OHX4u94Z2@coredump.intra.peff.net>
 <Y+6YgALh6L9m6rSX@coredump.intra.peff.net>
 <xmqqttzlm8uz.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqttzlm8uz.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 16, 2023 at 04:30:28PM -0800, Junio C Hamano wrote:

> >   - I've put the proxy tests into their own script, and it's the only
> >     one which loads the apache proxy config. If any platform can't
> >     handle this (e.g., doesn't have the right modules), the start_httpd
> >     step should fail and gracefully skip the rest of the script (but all
> >     the other http tests in existing scripts will continue to run).
> 
> Nice.  I have to move it from 5563 to 5564, though.

Ah, yeah. These number collisions are annoying.

Also, I note that our http client tests have spilled over into t556x
now, making the t556x_common script a bit of a misnomer (it handles
http-backend stuff). I'm not sure if we should be reordering more (which
is a lot of hassle) or perhaps just giving that helper a script a more
descriptive name. Or doing nothing. It is not that big a deal, just
something I noticed while searching for an unused number.

-Peff

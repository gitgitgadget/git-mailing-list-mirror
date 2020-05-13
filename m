Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CAD4C2D0F8
	for <git@archiver.kernel.org>; Wed, 13 May 2020 04:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 833C0206D6
	for <git@archiver.kernel.org>; Wed, 13 May 2020 04:52:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbgEMEwj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 00:52:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:45064 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725978AbgEMEwj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 May 2020 00:52:39 -0400
Received: (qmail 1170 invoked by uid 109); 13 May 2020 04:52:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 13 May 2020 04:52:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18365 invoked by uid 111); 13 May 2020 04:52:40 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 13 May 2020 00:52:40 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 13 May 2020 00:52:38 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     George Brown <321.george@gmail.com>, git@vger.kernel.org
Subject: Re: Re* [PATCH] contrib/git-jump: cat output when not a terminal
Message-ID: <20200513045238.GB65110@coredump.intra.peff.net>
References: <xmqqwo5ju47t.fsf@gitster.c.googlers.com>
 <CAFKec1Wy1iT8Z=gNDBn++XLxzGWr0UUiu3AKMU-qaR+jj2yoKQ@mail.gmail.com>
 <xmqqo8qvu0ao.fsf@gitster.c.googlers.com>
 <CAFKec1VGzpxVJV4zak46r_p2gGcw4UanFr7U4U4MSsG7t2A23w@mail.gmail.com>
 <20200511143157.GA1415@coredump.intra.peff.net>
 <xmqqr1vqscuy.fsf@gitster.c.googlers.com>
 <20200511154226.GC1415@coredump.intra.peff.net>
 <xmqqy2pyqv11.fsf_-_@gitster.c.googlers.com>
 <20200512192323.GC54565@coredump.intra.peff.net>
 <xmqqy2pwalj9.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy2pwalj9.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 12, 2020 at 02:30:34PM -0700, Junio C Hamano wrote:

> >> +edit=yes
> >> +
> >> +while	case "$#,$1" in
> >
> > Tab between "while" and "case"?
> 
> Yup.  Just to align case and its arms.

I guess that makes sense, though I'd probably have used spaces to do so.
Having a tab in the middle of the line is unusual.

> >> +	0,*) break ;;
> >> +	*,--no-editor) edit=no ;;
> >> +	*,--*) usage >&2; exit 1 ;;
> >> +	*) break ;;
> >> +	esac
> >> +do
> >> +	shift
> >> +done
> >
> > I found the use of "case" in the loop conditional a little unusual.
> 
> It's pretty-much personal preference, I think.  I could replace
> s/break/false/ if you find it easier to understand.

I think the part that most threw me off is looking at the arg-count in
each case arm. It's "*" in most, which really means "do not bother to
look at it" (which I think is why I found a loop condition on "$# -gt 0"
to be more natural).

I can live with it either way.

-Peff

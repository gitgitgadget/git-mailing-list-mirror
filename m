Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 582B32070F
	for <e@80x24.org>; Mon, 19 Sep 2016 20:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752098AbcISULy (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Sep 2016 16:11:54 -0400
Received: from smtprelay04.ispgateway.de ([80.67.31.27]:40308 "EHLO
        smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751414AbcISULx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2016 16:11:53 -0400
Received: from [84.168.70.3] (helo=book.hvoigt.net)
        by smtprelay04.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.84)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1bm4rk-0004rv-Gp; Mon, 19 Sep 2016 22:08:36 +0200
Date:   Mon, 19 Sep 2016 22:08:35 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Fredrik Gustafsson <iveqy@iveqy.com>,
        Leandro Lucarella <leandro.lucarella@sociomantic.com>
Subject: Re: [PATCH 3/2] batch check whether submodule needs pushing into one
 call
Message-ID: <20160919200835.GD62429@book.hvoigt.net>
References: <xmqqh9aaot49.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kYOBqQ0FF4J-+KbefSD8HRrUeMqpO27m_jprhm93aB+LA@mail.gmail.com>
 <20160824230115.jhmcr4r7wobj5ejb@sigill.intra.peff.net>
 <20160914173124.GA7613@sandbox>
 <xmqqwpiep10i.fsf@gitster.mtv.corp.google.com>
 <20160915121044.GA96648@book.hvoigt.net>
 <xmqq1t0kna51.fsf@gitster.mtv.corp.google.com>
 <20160916094019.GB1488@book.hvoigt.net>
 <20160916123155.GA40725@book.hvoigt.net>
 <xmqq1t0jlnm2.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1t0jlnm2.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 16, 2016 at 11:13:09AM -0700, Junio C Hamano wrote:
> Heiko Voigt <hvoigt@hvoigt.net> writes:
> > The most exact solution would be to use all actual remote refs available
> > (not sure if we have them at this point in the process?) another
> > solution would be to still append the --remotes=<remotename> option as a
> > fallback to reduce the revisions.
> 
> I'd say --remotes=<remotename> is the least problematic thing to do.

Ok then lets drop my last patch and keep it the way it was. Because if
the remote sha1 differs we probably do not have it locally anyway. The
only case this does not catch is when the user specifies a remote URL.
But that just means we will iterate over all revisions instead of a
reduced set, which makes the check slower but still correct. As one can
see from my measurements that should not be that bad anymore.

Cheers Heiko

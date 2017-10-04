Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BED8420281
	for <e@80x24.org>; Wed,  4 Oct 2017 09:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751314AbdJDJZt (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Oct 2017 05:25:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:60280 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751114AbdJDJZs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2017 05:25:48 -0400
Received: (qmail 19072 invoked by uid 109); 4 Oct 2017 09:25:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 04 Oct 2017 09:25:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16609 invoked by uid 111); 4 Oct 2017 09:25:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 04 Oct 2017 05:25:48 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Oct 2017 05:25:46 -0400
Date:   Wed, 4 Oct 2017 05:25:46 -0400
From:   Jeff King <peff@peff.net>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     git@vger.kernel.org
Subject: Re: Is git am supposed to decode MIME?
Message-ID: <20171004092546.vnjddxqwvia5cfn6@sigill.intra.peff.net>
References: <24940e12-3f72-1ef0-0983-58523d8dec51@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <24940e12-3f72-1ef0-0983-58523d8dec51@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 04, 2017 at 10:44:31AM +0200, Florian Weimer wrote:

> The git am documentation talks about “mailboxes”.  I suppose these contain
> messages in Internet Mail syntax.  Is git am supposed to decode MIME?
> 
> I'm asking because I have a message whose body is encoded as
> quoted-printable, but git am does not parse the patch contained in it.
> 
> If git am is supposed to deal with this, I'll dig deeper and try to figure
> out where things go wrong.

Yes, it should. I just double-checked with the toy patch patch below,
and it correctly extracted the quoted-printable from the commit message
and patch, as well as in the headers.

-- >8 --
From peff@peff.net Wed Oct  4 05:21:57 2017
Date: Wed, 4 Oct 2017 05:21:55 -0400
From: =?utf-8?Q?=C3=81ccented N=C3=A1me?= <peff@peff.net>
To: Jeff King <peff@peff.net>
Subject: [PATCH] add 8bit content
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This commit message also has s=C3=B3me 8-bit characters which
will need qp-encoding.

Signed-off-by: =C3=81ccented N=C3=A1me <peff@peff.net>
---
 file | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/file b/file
index d95f3ad..d39c7fc 100644
--- a/file
+++ b/file
@@ -1 +1 @@
-content
+8-bit c=C3=B3ntent
--=20
2.14.2.1117.g65a3442612


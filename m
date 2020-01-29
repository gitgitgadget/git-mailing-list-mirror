Return-Path: <SRS0=89pV=3S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400E1C33CB2
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 05:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 196AA20720
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 05:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbgA2Fx4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jan 2020 00:53:56 -0500
Received: from cloud.peff.net ([104.130.231.41]:47208 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725816AbgA2Fx4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jan 2020 00:53:56 -0500
Received: (qmail 14138 invoked by uid 109); 29 Jan 2020 05:53:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 29 Jan 2020 05:53:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14210 invoked by uid 111); 29 Jan 2020 06:01:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 29 Jan 2020 01:01:31 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 29 Jan 2020 00:53:55 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org
Subject: Re: [PATCH] doc: clarify "explicitly given" in push.default
Message-ID: <20200129055355.GB611490@coredump.intra.peff.net>
References: <1113893dd36a1e8cf72331dd01f36206b44f45ad.1580116685.git.bert.wesarg@googlemail.com>
 <xmqqr1zj6xl6.fsf@gitster-ct.c.googlers.com>
 <20200129024124.GC596379@coredump.intra.peff.net>
 <xmqq7e1a7s83.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7e1a7s83.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 28, 2020 at 09:21:32PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Though I'd still slightly worry that somebody might not consider
> > configured refspecs. Saying more clearly "any refspec no matter where it
> > comes from" might still be worthwhile. I.e., something like:
> >
> >   Defines the action `git push` should take if no refspec is given
> >   (whether from the command-line, config, or elsewhere).
> 
> That's 100x better than to say "explicit" "implicit" etc. and then
> have readers guess what the adjectives mean or explain what they
> mean in (parentheses).

OK, here it is in patch form, then, so we can (hopefully) wrap this up.

-- >8 --
Subject: [PATCH] doc: drop "explicitly given" from push.default description

The documentation for push.default mentions that it is used if no
refspec is "explicitly given". Let's drop the notion of "explicit" here,
since it's vague, and just mention that any refspec from anywhere is
sufficient to override this.

I've dropped the mention of "explicitly given" frmo the definition of
the "nothing" value right below, too. It's close enough to our
clarification that it should be obvious we mean the same type of "given"
here.

Signed-off-by: Jeff King <peff@peff.net>
---
Note that there's one other use of the word "explicit" in the context,
but it is used appropriately. :)

 Documentation/config/push.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/push.txt b/Documentation/config/push.txt
index 0a0e000569..54871f8213 100644
--- a/Documentation/config/push.txt
+++ b/Documentation/config/push.txt
@@ -1,14 +1,15 @@
 push.default::
 	Defines the action `git push` should take if no refspec is
-	explicitly given.  Different values are well-suited for
+	given (whether from the command-line, config, or elsewhere).
+	Different values are well-suited for
 	specific workflows; for instance, in a purely central workflow
 	(i.e. the fetch source is equal to the push destination),
 	`upstream` is probably what you want.  Possible values are:
 +
 --
 
 * `nothing` - do not push anything (error out) unless a refspec is
-  explicitly given. This is primarily meant for people who want to
+  given. This is primarily meant for people who want to
   avoid mistakes by always being explicit.
 
 * `current` - push the current branch to update a branch with the same
-- 
2.25.0.515.g69a699b7aa


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D724D1FCA9
	for <e@80x24.org>; Wed, 14 Sep 2016 23:52:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1763674AbcINXwh (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Sep 2016 19:52:37 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:49889 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762440AbcINXwg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Sep 2016 19:52:36 -0400
Received: from cloud (joshtriplett.org [IPv6:2604:3400:dc1:41:216:3eff:fe9f:2070])
        (Authenticated sender: josh@joshtriplett.org)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id E3DA7A80C6;
        Thu, 15 Sep 2016 01:52:32 +0200 (CEST)
Date:   Wed, 14 Sep 2016 16:52:31 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH] Move format-patch base commit and prerequisites before
 email signature
Message-ID: <20160914235231.GA12672@cloud>
References: <xmqqshtags0o.fsf@gitster.mtv.corp.google.com>
 <20160908185408.5qtfnztjbastlrtw@x>
 <20160908200819.pkg7jqcvxjpdqr3a@sigill.intra.peff.net>
 <xmqqd1kef5k5.fsf@gitster.mtv.corp.google.com>
 <xmqq7fakc12z.fsf@gitster.mtv.corp.google.com>
 <20160909200721.xfkbud377ja4wkrt@x>
 <xmqqpoocajbb.fsf@gitster.mtv.corp.google.com>
 <20160909210040.zlsczhcotrxnu4e4@x>
 <xmqq7fakai5k.fsf@gitster.mtv.corp.google.com>
 <xmqqmvjaozrz.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqmvjaozrz.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 14, 2016 at 03:57:36PM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > I do not mind doing it myself, but I am already in today's
> > integration cycle (which will merge a handful of topics to
> > 'master'), so I won't get around to it for some time.  If you are
> > inclined to, please be my guest ;-)
> 
> I queued this on top for now; I think it can be just squashed into
> your patch.  Please say "I agree" and I'll make it happen, or say
> "that's wrong" followed by a replacement patch ;-).

"I agree". :)

I'd suggest squashing in an *additional* patch to the testsuite to
ensure the presence of the blank line:

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 535857e..8d90a6e 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1515,8 +1515,9 @@ test_expect_success 'format-patch -o overrides format.outputDirectory' '
 
 test_expect_success 'format-patch --base' '
 	git checkout side &&
-	git format-patch --stdout --base=HEAD~3 -1 | tail -n 6 >actual &&
-	echo "base-commit: $(git rev-parse HEAD~3)" >expected &&
+	git format-patch --stdout --base=HEAD~3 -1 | tail -n 7 >actual &&
+	echo >expected &&
+	echo "base-commit: $(git rev-parse HEAD~3)" >>expected &&
 	echo "prerequisite-patch-id: $(git show --patch HEAD~2 | git patch-id --stable | awk "{print \$1}")" >>expected &&
 	echo "prerequisite-patch-id: $(git show --patch HEAD~1 | git patch-id --stable | awk "{print \$1}")" >>expected &&
 	signature >> expected &&

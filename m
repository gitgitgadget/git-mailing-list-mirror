Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FB191F462
	for <e@80x24.org>; Mon, 29 Jul 2019 14:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387788AbfG2OOD (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 10:14:03 -0400
Received: from lovelace.chead.ca ([162.223.226.168]:43598 "EHLO
        lovelace.chead.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387774AbfG2OOD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 10:14:03 -0400
X-Greylist: delayed 1574 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Jul 2019 10:14:02 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=chead.ca;
         s=lovelace20151122; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
        References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=TmS5FoDEmXSSayr2jbdtzSbBi2BUDoqna0aBoji/68A=; b=hXxAxi1OZs4uxN+Rrl2XGe7ahv
        kbzM2vfdfIZms8msk7sesN5rchLCCXTyWc8eoEEEBonxToaJVWJHZULoDMMt0BF8YJjguh7L+44cb
        bFdQATeET9LzHdJIfm/Dr4c0dICsZPXqzn2ZMB1Mj+WLs6M7JTBzdu8l3Bs2tb00JoQI=;
Received: from [192.252.232.184] (helo=amdahl.home.chead.ca)
        by lovelace.chead.ca with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <chead@chead.ca>)
        id 1hs607-0000Ee-PL; Mon, 29 Jul 2019 06:47:43 -0700
Date:   Mon, 29 Jul 2019 06:47:41 -0700
From:   Christopher Head <chead@chead.ca>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Christopher Head <bugs@chead.ca>,
        git@vger.kernel.org
Subject: Re: Push force-with-lease with multi-URL remote
Message-ID: <20190729064741.005bc16a@amdahl.home.chead.ca>
In-Reply-To: <xmqq7e81vuc3.fsf@gitster-ct.c.googlers.com>
References: <20190727095440.1aac3b3c@amdahl.home.chead.ca>
        <20190729102009.GC2755@sigill.intra.peff.net>
        <xmqq7e81vuc3.fsf@gitster-ct.c.googlers.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 29 Jul 2019 06:33:32 -0700
Junio C Hamano <gitster@pobox.com> wrote:

> I agree but only if the listed ones are separate ones.  If the URLs
> are separate paths to reach the same remote (e.g. https:// and ssh://
> going to the same place), the current definition would make more
> sense.

I realize I’m a bit biased towards my personal use case, but I wonder
if it would make sense to consider how frequently each case occurs?

Case 1: someone wants to keep multiple repos mirrored, by always
pushing to all of them (my use case).

Case 2: someone wants to push to one repo, but vagaries of Internet
connectivity mean that sometimes they can’t use SSH and other times
they can’t use HTTP (or they prefer one protocol but sometimes that
one doesn’t work), therefore they want both URLs so that when one fails
the other may work. I suppose the most common situation in this case is
that you want to use SSH so that you don’t have to type a password, but
sometimes you’re in a site which only allows HTTP connections and
typing a password as a fallback is preferable to failing altogether?

For me, case 1 happens quite frequently but case 2 pretty much never—I
don’t think I’ve ever been somewhere that blocks port 22 outbound, so I
always just use SSH. But I realize other people’s experience varies.
-- 
Christopher Head

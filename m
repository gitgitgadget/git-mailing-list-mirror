Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D04CAC43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 06:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD19C2071E
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 06:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfLIGSz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 01:18:55 -0500
Received: from cloud.peff.net ([104.130.231.41]:41660 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726270AbfLIGSy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 01:18:54 -0500
Received: (qmail 17834 invoked by uid 109); 9 Dec 2019 06:18:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 09 Dec 2019 06:18:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18127 invoked by uid 111); 9 Dec 2019 06:23:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Dec 2019 01:23:11 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 9 Dec 2019 01:18:53 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v3 0/9] Rewrite packfile reuse code
Message-ID: <20191209061853.GA38588@coredump.intra.peff.net>
References: <20191115141541.11149-1-chriscool@tuxfamily.org>
 <20191115180319.113991-1-jonathantanmy@google.com>
 <xmqqeexwxyc0.fsf@gitster-ct.c.googlers.com>
 <xmqqa78kxy1i.fsf@gitster-ct.c.googlers.com>
 <xmqq8snpw2pk.fsf@gitster-ct.c.googlers.com>
 <CAP8UFD20LMxuV7KWAvobybHYZruDiADX-yOFPLyMxsHS7HZN0g@mail.gmail.com>
 <nycvar.QRO.7.76.6.1912072145290.31080@tvgsbejvaqbjf.bet>
 <CAP8UFD1rmv7dvWBe5=dnrh8icfsE_PWEukmuUmqB9dWJ9NQTkg@mail.gmail.com>
 <nycvar.QRO.7.76.6.1912080942360.31080@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1912080942360.31080@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 08, 2019 at 09:54:01AM +0100, Johannes Schindelin wrote:

> > That's why I put Peff as the author of the patches.
> 
> No, that is not the reason. You might think that that is the reason, but
> the real reason why Peff is marked as the author of those patches is that
> he really authored those patches.
> 
> In light of what you said, I don't think that it is a good idea to go
> forward by leaning even further on Peff. From his activity on the Git
> mailing list, I deduce that he is not exactly in need of even more work.
> 
> Instead, I think that if you truly want to push these patches forward, you
> will have to dig deeper yourself, and answer Jonathan Tan's questions, and
> possibly adjust the patches accordingly and send a new iteration.
> 
> I perceive it as very unfair toward Peff that this has not yet happened.

To be clear, I am not bothered by this. And in fact I feel bad that I
promised Christian that I take a careful look at the patches again, but
haven't gotten around to it (for an embarrassingly long time now).

Now I would _love_ if somebody else dug into the topic enough to
understand all of the ins and outs, and whether what they're doing is
sane (or could be done better). But barring that, these patches have
been battle-tested for many years on GitHub's servers, so even if we
just take them as-is I hope it would be an improvement.

Fortunately I have some other work to do that I would like very much to
procrastinate on, so let me see if that can summon the willpower for me
to review these.

> Well, you have time enough to send lengthy replies on a Sunday morning
> (while Peff apparently did not even have time to say that he lacks the
> time to work on this).

One tricky thing here is that I leave messages or subthreads that I
intend to act on in my incoming Git mbox. And of course as time goes on,
those get pushed further back in the pile. But when new messages arrive,
mutt attaches them to the old threads, and I sometimes don't see them
(until I go back and sift through the pile).

I wish there was a good way to have mutt remain in threaded mode, but
sort the threads by recent activity. Setting sort_aux=last-date kind of
works, but last time I tried it, I got annoyed that it did funny things
with the order of patches within a thread (if somebody replies to patch
3/5, and then 2/5, it will pull 3/5 down as "more recent").

Dscho, you may feel free to roll your eyes and mutter under your breath
about email if you wish. ;)

-Peff

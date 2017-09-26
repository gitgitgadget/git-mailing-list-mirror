Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B2FA20281
	for <e@80x24.org>; Tue, 26 Sep 2017 17:21:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967955AbdIZRVV (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Sep 2017 13:21:21 -0400
Received: from outbound1.eu.mailhop.org ([52.28.251.132]:21933 "EHLO
        outbound1.eu.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965047AbdIZRVT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2017 13:21:19 -0400
X-Greylist: delayed 963 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Sep 2017 13:21:19 EDT
X-MHO-User: d78eb96c-a2dc-11e7-a893-25625093991c
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Originating-IP: 173.50.81.193
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from io (unknown [173.50.81.193])
        by outbound1.eu.mailhop.org (Halon) with ESMTPSA
        id d78eb96c-a2dc-11e7-a893-25625093991c;
        Tue, 26 Sep 2017 17:05:07 +0000 (UTC)
Received: from io.lakedaemon.net (localhost [127.0.0.1])
        by io (Postfix) with ESMTP id 29E0980060;
        Tue, 26 Sep 2017 17:05:03 +0000 (UTC)
X-DKIM: OpenDKIM Filter v2.6.8 io 29E0980060
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lakedaemon.net;
        s=mail; t=1506445503;
        bh=PBK5rHz+t4py/L8BfZXB6sKW1GVo9lWSb14xoRxTuEo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=xJmrO/rHdOQWuYG8UOxxv08kmjhx4QevupSkWcPhdQ27/DXhv0hFnQUNmiDE1KeZY
         LzcksrdnUObHDgFJFVH4QZa7mgOiGL6yml51X2CML2uW9+eR2NK+HfgxrVOF4LTMb2
         mng/eTvRua6wQpJVMJLGzXNug5CxE8eppLXWg392AndzTmcylCWTzpwHikNLZDqawP
         scPJEo1EzaA37RkpMnEpNM1dd1mHaej5+XS+HG9xZFGFo+f3F2qbHbbZQRUuLnh4DR
         qPqvRzw6JXF68ik36InvUhi2x55+5guiHOT4ShhPvgWKBljhRPWggqR2ole8l3lpCq
         0iVSZa1wn7C4A==
Date:   Tue, 26 Sep 2017 17:05:03 +0000
From:   Jason Cooper <jason@lakedaemon.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        demerphq <demerphq@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>, David Lang <david@lang.hm>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: RFC v3: Another proposed hash function transition plan
Message-ID: <20170926170502.GY31762@io.lakedaemon.net>
References: <20170304011251.GA26789@aiede.mtv.corp.google.com>
 <CA+55aFz+gkAsDZ24zmePQuEs1XPS9BP_s8O7Q4wQ7LV7X5-oDA@mail.gmail.com>
 <20170307001709.GC26789@aiede.mtv.corp.google.com>
 <xmqqa828733s.fsf@gitster.mtv.corp.google.com>
 <xmqq1snh29re.fsf@gitster.mtv.corp.google.com>
 <20170911185913.GA5869@google.com>
 <alpine.DEB.2.21.1.1709131340030.4132@virtualbox>
 <CANgJU+Wv1nx79DJTDmYE=O7LUNA3LuRTJhXJn+y0L0C3R+YDEA@mail.gmail.com>
 <CA+55aFwUn0KibpDQK2ZrxzXKOk8-aAub2nJZQqKCpq1ddhDcMQ@mail.gmail.com>
 <alpine.DEB.2.21.1.1709142037490.4132@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1.1709142037490.4132@virtualbox>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

Sorry for late commentary...

On Thu, Sep 14, 2017 at 08:45:35PM +0200, Johannes Schindelin wrote:
> On Wed, 13 Sep 2017, Linus Torvalds wrote:
> > On Wed, Sep 13, 2017 at 6:43 AM, demerphq <demerphq@gmail.com> wrote:
> > > SHA3 however uses a completely different design where it mixes a 1088
> > > bit block into a 1600 bit state, for a leverage of 2:3, and the excess
> > > is *preserved between each block*.
> > 
> > Yes. And considering that the SHA1 attack was actually predicated on
> > the fact that each block was independent (no extra state between), I
> > do think SHA3 is a better model.
> > 
> > So I'd rather see SHA3-256 than SHA256.

Well, for what it's worth, we need to be aware that SHA3 is *different*.
In crypto, "different" = "bugs haven't been found yet".  :-P

And SHA2 is *known*.  So we have a pretty good handle on how it'll
weaken over time.

> SHA-256 got much more cryptanalysis than SHA3-256, and apart from the
> length-extension problem that does not affect Git's usage, there are no
> known weaknesses so far.

While I think that statement is true on it's face (particularly when
including post-competition analysis), I don't think it's sufficient
justification to chose one over the other.

> It would seem that the experts I talked to were much more concerned about
> that amount of attention than the particulars of the algorithm. My
> impression was that the new features of SHA3 were less studied than the
> well-known features of SHA2, and that the new-ness of SHA3 is not
> necessarily a good thing.

The only thing I really object to here is the abstract "experts".  We're
talking about cryptography and integrity here.  It's no longer
sufficient to cite anonymous experts.  Either they can put their
thoughts, opinions and analysis on record here, or it shouldn't be
considered.  Sorry.

Other than their anonymity, though, I do agree with your experts
assessments.

However, whether we chose SHA2 or SHA3 doesn't matter.  Moving away from
SHA1 does.  Once the object_id code is in place to facilitate that
transition, the problem is solved from git's perspective.

If SHA3 is chosen as the successor, it's going to get a *lot* more
adoption, and thus, a lot more analysis.  If cracks start to show, the
hard work of making git flexible is already done.  We can migrate to
SHA4/5/whatever in an orderly fashion with far less effort than the
transition away from SHA1.

For my use cases, as a user of git, I have a plan to maintain provable
integrity of existing objects stored in git under sha1 while migrating
away from sha1.  The same plan works for migrating away from SHA2 or
SHA3 when the time comes.


thx,

Jason.

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EB5F20C11
	for <e@80x24.org>; Mon, 27 Nov 2017 20:57:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753008AbdK0U5f (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 15:57:35 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:36838 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752430AbdK0U5e (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 15:57:34 -0500
Received: by mail-it0-f67.google.com with SMTP id y71so11223414ita.1
        for <git@vger.kernel.org>; Mon, 27 Nov 2017 12:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q+WTu3fGn9XGcJPCLDcC3Z/2SDeq27HOl/SW8rYShW4=;
        b=Azm7enfmdMw5upPap6RVr62VCZHDGXTkRmzqr0k0kZgGL6HjZbmehatj9evPwNIQbm
         im4udWbAgGhoZqM7orWDVKu8YzT8p53Is4/9jM2muKSm//1TFg3ZziVHiQk8W8l/Auqz
         f3jhof4nTV7y/6QKUtVvXN7CMtJxIKATTA0E6jTnApDiHnlH5mBkjNykFlbj5urrwWuU
         Evt1l3tgfQn2tw88KXIug8KS64r0r/BFD+GBzS8Hz2KOS34tohXYrLwpqqjqgxB5Ud/e
         P08WYDXHuL1QyTFplF9iUa6jBc98J9wxS1CVPKGJN3tY58IhpdjvdLBaxMXeVe6h8f5R
         jozA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q+WTu3fGn9XGcJPCLDcC3Z/2SDeq27HOl/SW8rYShW4=;
        b=SdeKPju8tIGoO1V6CK3AUPMFvrOpqYD3Qh0/W4MQGQfmMvh096cCSDCTueROxN54wC
         yLN+ON8tYtm/ag1ltPltX6nhDlZq7bulpl69xBfD/0QUtUa/krS+NdYZbB6w/dMA3pRy
         UjjziuAz79xkeM3SBE2r1SsY5ablgYE8gPblTIgo1N/30KpUCLq/mDKNyXhXx9/zmG7R
         wJxKQk7hYuSVg4Gw5+LCMICbw+JTMJdK9FjZ6Vjq0zWv2gkNV8eiNd+Ivht5ZMQmfdm4
         3bx8ZvO/8qVnAuS5nQ3pAbirk+hRv6M0pgXwk9wRWyf8ktX18xuDzSIYb1GhuTpopwJ5
         3Zng==
X-Gm-Message-State: AJaThX4Mb2GC7wEbaDUJN3nBPbunEgbA8RYlyeF5qOrteOHTluuhYgJr
        WJhfEdctSxjBE399FemCJWg=
X-Google-Smtp-Source: AGs4zMYZS1oaOfTeA+lQBay2QD3DwL6gR0/sfS3DYWekrnvEczMyfdpb3A4PF1w5auRPFvv73grHbw==
X-Received: by 10.36.54.195 with SMTP id l186mr29442352itl.37.1511816253604;
        Mon, 27 Nov 2017 12:57:33 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id g100sm5699094iod.84.2017.11.27.12.57.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Nov 2017 12:57:32 -0800 (PST)
Date:   Mon, 27 Nov 2017 12:57:31 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nathan Neulinger <nneul@neulinger.org>,
        Santiago Torres <santiago@nyu.edu>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: git status always modifies index?
Message-ID: <20171127205731.GB27469@aiede.mtv.corp.google.com>
References: <5050d779-2981-6f06-49f7-0ecb4efb25b8@neulinger.org>
 <20171122161014.djkdygmclk227xmq@LykOS.localdomain>
 <dfbf4af3-e87c-bdcb-7544-685572925a50@neulinger.org>
 <20171122202720.GD11671@aiede.mtv.corp.google.com>
 <20171122211729.GA2854@sigill>
 <20171122215635.GE11671@aiede.mtv.corp.google.com>
 <20171122220627.GE2854@sigill>
 <xmqqwp2diuki.fsf@gitster.mtv.corp.google.com>
 <xmqq7eudidqb.fsf@gitster.mtv.corp.google.com>
 <20171127044314.GA6236@sigill>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171127044314.GA6236@sigill>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jeff King wrote:
> On Sun, Nov 26, 2017 at 06:35:56PM +0900, Junio C Hamano wrote:

>> Having a large picture option like "--read-only" instead of ending
>> up with dozens of "we implemented a knob to tweak only this little
>> piece, and here is an option to trigger it" would help users in the
>> long run, but we traditionally did not do so because we tend to
>> avoid shipping "incomplete" features, but being perfectionist with
>> such a large undertaking can stall topics with feature bloat.  In a
>> case like this, however, I suspect that an aspirational feature that
>> starts small, promises little and can be extended over time may be a
>> good way to move forward.
>
> I actually consider "--no-optional-locks" to be such an aspirational
> feature. I didn't go digging for other cases (though I'm fairly certain
> that "diff" has one), but hoped to leave it for further bug reports ("I
> used the option, ran command X, and saw lock contention").

I am worried that the project is not learning from what happened here.

My main issue with the --no-optional-locks name is that it does not
connect to the underlying user need.  Your main argument for it is
that it exactly describes the underlying user need.  One of us has to
be wrong.

So let me describe my naive reading:

As a user, I want to inspect the state of the repository without
disrupting it in any way.  That means not breaking concurrent
processes and not upsetting permissions.  --read-only seems to
describe this use case to me perfectly.

If I understood correctly, your objection is that --read-only is not
specific enough.  What I really want, you might say, is not to break
concurrent processes.  Any other aspects of being read-only are not
relevant.  E.g. if I can refresh the on-disk index using O_APPEND
without disrupting concurrent processes then I should be satisfied
with that.

Fair enough, though that feels like overengineering.  But I *still*
don't see what that has to do with the name "no-optional-locks".  When
is a lock *optional*?  And how am I supposed to discover this option?

This also came up during review, and I am worried that this review
feedback is being ignored.  In other words, I have no reason to
believe it won't happen again.

> I would be fine with having a further aspirational "read only" mode.

Excellent, we seem to agree on this much.  If I can find time for it
today then I'll write a patch.

Thanks,
Jonathan

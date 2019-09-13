Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 693FD1F463
	for <e@80x24.org>; Fri, 13 Sep 2019 17:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729769AbfIMRrt (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Sep 2019 13:47:49 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:37325 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729557AbfIMRrt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Sep 2019 13:47:49 -0400
X-Originating-IP: 1.186.12.20
Received: from localhost (unknown [1.186.12.20])
        (Authenticated sender: me@yadavpratyush.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 4D8C71C0005;
        Fri, 13 Sep 2019 17:47:46 +0000 (UTC)
Date:   Fri, 13 Sep 2019 23:17:43 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Birger Skogeng Pedersen <birger.sp@gmail.com>
Cc:     Philip Oakley <philipoakley@iee.email>,
        Marc Branchaud <marcnarc@xiplink.com>,
        Bert Wesarg <bert.wesarg@googlemail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] git-gui: add hotkey to toggle "Amend Last Commit"
 check button/menu
Message-ID: <20190913174743.x2kdfotq2fnuift7@yadavpratyush.com>
References: <ab1f68cc8552e405c9d04622be1e728ab81bda17.1567713659.git.bert.wesarg@googlemail.com>
 <b82a00441ff1a6a9cea3fd235c1c33729ec31b71.1567713659.git.bert.wesarg@googlemail.com>
 <20190911205539.vb6asqcc22nzgdqa@yadavpratyush.com>
 <CAGr--=Jz9xN6NMmiXjHeq9wZsYUx4eqfQrWjjVMkj3J1YCG_8g@mail.gmail.com>
 <20190912162924.phb5o2ppovnxa7nn@yadavpratyush.com>
 <db01db41-eff0-fb56-161a-ba26d1b18f55@xiplink.com>
 <56a6fbf8-4486-6bad-f847-793bb6b4e070@iee.email>
 <CAGr--=JDKrYT=Z8iwPVRy58OB9teH7bHXrYSZHqYHhJ=5wrJzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGr--=JDKrYT=Z8iwPVRy58OB9teH7bHXrYSZHqYHhJ=5wrJzQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13/09/19 09:50AM, Birger Skogeng Pedersen wrote:
> Hi Marc and Philip,
> 
> 
> On 12/09/2019 22:34, Marc Branchaud wrote:
> > I disagree!  Who expects anything to work properly when capslock is on?
> 
> Me :-)
> 
> 
> On Fri, Sep 13, 2019 at 12:23 AM Philip Oakley <philipoakley@iee.email> wrote:
> > I'd tend to agree. In other areas the use of shift is often used as the
> > complement of the unshifted action, so it does feel 'odd'. Thus it could
> > be used directly as the bool for amend or direct commit.
> >
> > This all assumes that Caps Lock is equivalent to having the shift on,
> > rather than being a special extra key.
> 
> It seems all the Ctrl+(lowercase character) hotkeys in git-gui have an
> equivalent Ctrl+(uppercase character).
> So for this feature, we should keep the Ctrl+E bind aswell as the
> Ctrl+e bind. If nothing else, to keep it consistent with the rest of
> the hotkey bindings.

I agree with this that we should keep it consistent with the rest of the 
bindings for now...

> But honestly, (as Marc pointed out) it is a quite weird that
> Ctrl+Shift+(character) has the excact same function as
> Ctrl+(character). Perhaps we should find another way to bind the
> hotkeys, where the state of Caps Lock doesn't matter? If possible.

...but I'd love to see this happen. To me shift is a modifier. No matter 
whether Caps Lock is pressed or not, it should not do the shift-modified 
behavior (that's just me, maybe other people think differently).

AFAIK, Tk does not provide any direct way to find out whether shift is 
pressed (correct me if I'm wrong). What you instead have to do is some 
bit arithmetic on the number passed to the "Key" event via the "%s" 
substitution. Source: [0]. We can probably have a bind_alpha procedure 
that takes two arguments: what to run when shift is pressed and what to 
run when it isn't.

This, of course, would be incompatible with the current behavior, but do 
people even keep the Caps Lock on? I personally use it so rarely I have 
my Caps Lock bound to Escape because I might as well use that key for 
something I use more often.

[0] https://blog.tcl.tk/4238

-- 
Regards,
Pratyush Yadav

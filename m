Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24CA71F453
	for <e@80x24.org>; Tue, 30 Apr 2019 23:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbfD3XkX (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Apr 2019 19:40:23 -0400
Received: from mout.gmx.net ([212.227.17.21]:46081 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbfD3XkX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Apr 2019 19:40:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1556667609;
        bh=z5t0Q5jVMFr0VqdrPB7x0fX2H/mgw99LqnfAFkJp6jw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=LnQ9nrdD229oz14Wc3xofqQcxfJp04PMqJq0JBemVxIKqUNigVpiQIZecjNcRNYpg
         tqkZpNnBDpi9Iqwa4qnDhKpwbz2r4GenRKa/uQP/LmmbO4BEwO003YzFRHN0DLqSPb
         HGFlZQioykiVZQJIFHD/A0y4ZIj/pam1t/5F6bbE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.96.188] ([12.174.135.204]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MgHHO-1h9yox18HW-00NenZ; Wed, 01
 May 2019 01:40:09 +0200
Date:   Tue, 30 Apr 2019 19:40:06 -0400 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/11] Start to implement a built-in version of `git add
 --interactive`
In-Reply-To: <20190418160633.GB8054@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1904301935400.45@tvgsbejvaqbjf.bet>
References: <pull.170.git.gitgitgadget@gmail.com> <12978dc248a2cd07c90559691b8a2add84f45394.1554917868.git.gitgitgadget@gmail.com> <3149b9ba-2f5a-46ce-ad89-4105ec217795@jeffhostetler.com> <20190418160633.GB8054@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Nh7CIztKHMjFI7GXC5J77ZS58WwLLy8Sg0x3d25a0RpX1mnCyYj
 9npeL0kIjLowMmlFn750Io7uiQqNwM66D4lBqrgavkprm1fQvaEQ7/l/9E5ESZd3X2tta5j
 4UCCBrX3zy1k4QYCs4vD7W7Du6qnRHMbURR7AJ/Yg8WBuAYrhTjSAYaeUooECIHSAQKkix3
 8a2per7S0Hk5MWVmWrD1g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DOHDYWplkIw=:SfPzeQ+xRFzUca6o82ba/7
 miUp4zuafxM/36ygpYqYh28rWfuVBs1DxLsZvBm4TumMzOM4WmDp6+ijnfDFgine57YZUEIcx
 KayAP9mvVsV8S+SMUQEEpdNlep9LuPCqtKM7k8TNt6ZkFlAeYhFXQ/JJwMSauqPpF9t2/H0kV
 1/Hn59YN4JZVlVX3OyKx6s/L2RYxOTaooB0PykAIw7EpGCySbPR4nt2zR+1lemEwE0wny2sDS
 w2aSBxaQlTD0WMxSO7V2iFqgI+zz/Wysiqp3+uD3sA5i3O3IwDTZQG2dVz3myBG9ferFY/ewg
 KErh81Y+SOELBECc+fjC4uXVNpf6qrmck0HWUkKEqikw3b68j8bJcnYi+4MbqgC1iOZtRX2fB
 r39DKoE0ZJ98eXsMiZ92ar/H5arTMhN9S+IpG05CWB+QaK560U9bKxp64FpxPsZeRHKy+7J2h
 nNVJeo+IFx0yfU3ldcdfX/nACjCEJfHKJP+FvGEepJmwg+CEYjMmoe50OshxoDAfK+DaFSXmC
 +kkUmP9F4mm1Vv44xcX37lYx2Yx5pfGKSrnOhi71ZkimRSWypJDwFQspGcReE+TrFCAJaHpjE
 hTJgfSnklGKLp5KCVDOroqe5Fex8UrWeTxlqHP5Aehl+fxt/bAJf3GM8qQ7mPXGEMXswsI4ue
 +InA9r85bntQ3IByrPDq5nWD9ZNnxDKTqarp98Unxpr50ELxexXUK1O2Zy91BC5+Mr0NROqXa
 qN+e9tweAtN/vvFKvx1PeFpMwOBMbfMOym0dUge1AIhhZm0y1drOWJpRH1Ru6xlesCiA7XGrL
 nZzgioynPv+BjwJBH4YYqbl5aQConzuudL8VUrXyPbkTNRr5or2F8GrrQ9KVikVKLCUURuSGv
 4cyW+MkUHyT5dqgm3o7c7j0fz1l1cX8ktG13ma0h0lRibrgpqeDiy1AKW92aBwjckXxJ9Hg9X
 O8UXLgnl4ng==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff & Jeff,

On Thu, 18 Apr 2019, Jeff King wrote:

> On Thu, Apr 18, 2019 at 10:31:30AM -0400, Jeff Hostetler wrote:
>
> > Currently, neither function looks at any other k/v pairs, so
> > this is a bit of a moot point, but I'm wondering if this should
> > look like this:
> >
> >     int add_config(...)
> >     {
> >         // give add-interactive.c a chance to look at k/v pair, but
> >         // do not short-cut because we don't know yet whether we
> >         // will be interactive or not yet.
> >         (void)add_i_config(...);
> >
> >         ...ignore_add_errors...
> >         ...use_builtin_add_i...
> >
> >         return git_default_config(...);
> >     }
>
> Yeah, I agree this split seems a bit more natural. It is worth
> propagating errors from add_i_config(), though, like:
>
>   if (add_i_config(var, value, data))
> 	return -1;
>
> so that any key-specific errors (e.g., config_error_nonbool) stop the
> parsing in the usual way.

The only problem there is that `add_i_config()` (like all the other
`git_config()` callbacks) does not report whether it consumed the
key/value pair or not. I tried to avoid deviating from the standard
practice to avoid calling `git_default_config()` when we already consumed
the config setting.

And I also tried pretty hard to *not* bleed any internal state of
`add-interactive` into `builtin/add`, as I wanted the new code to be as
libified as possible (in a nearby thread, somebody wished for a new `-p`
mode that would essentially be a combined `git stash -p` and `git add -p`,
and with properly libified code such a beast is a lot more feasible).

Any idea how to deal with that?

I guess I could invert the order, where `add_config()` would be called
as a fall-back from `add_i_config()`...

Or I invent a new convention where `add_i_config()` returns 1 when it
consumed the key/value pair. But that would set a precedent that is
inconsistent with the entire existing code base, something I am
uncomfortable to do for the sake of `add -i`...


Ciao,
Dscho

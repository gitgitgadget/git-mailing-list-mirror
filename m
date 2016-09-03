Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD5391F6BF
	for <e@80x24.org>; Sat,  3 Sep 2016 07:02:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753276AbcICHCh (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Sep 2016 03:02:37 -0400
Received: from mout.gmx.net ([212.227.17.20]:62890 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752463AbcICHCg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Sep 2016 03:02:36 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MGB7j-1bu33f3uh5-00FG56; Sat, 03 Sep 2016 09:02:01
 +0200
Date:   Sat, 3 Sep 2016 09:01:59 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Dennis Kaarsemaker <dennis@kaarsemaker.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/9] rebase -i: also expand/collapse the SHA-1s via the
 rebase--helper
In-Reply-To: <1472849798.4680.63.camel@kaarsemaker.net>
Message-ID: <alpine.DEB.2.20.1609030857480.129229@virtualbox>
References: <cover.1472833365.git.johannes.schindelin@gmx.de>  <fe53c109c757ede9cd1b0d2944d2b5e16575c49b.1472833365.git.johannes.schindelin@gmx.de> <1472849798.4680.63.camel@kaarsemaker.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:4VdriZmZm5hpJ1wkoxaqk/+hUUP0GQPVsrUzFDhrd6btsi6dAik
 WoOM3aHG9lYlANSxX8xkh8fFrOg3L9YhpvEJAIKhNB6y6DXYMu1urfnwDMyKaOvcLLc5l2B
 484g1Q0jQaZ9b6ulRQuRaHtekwHiS2FqRXme7j1T797WVPie/qrFnXvm9yWUa3lLCzv2Vva
 wFMSDk0pXC2SxaNL7ehqA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bK1sLEORZXw=:Sa8P7L0RXxYqsYaPH8mtiw
 Djos2aDWHip+j/AfHTzXb4f2lSjswaAsvEu1V22DS7NM3IVODQS10SxCpMPwFj8um+kpLt0Q0
 r066IXCXeYfIWaRKto5uqNGJZkGJIhEm9xUOUEnaJ5FO/Wi8P31Ec2vuLG9R4h0eGyKcHIqgt
 swzqZ/6ub0L1zh1EhhBPs84UHirmhptcB3mp002RR2DEsCONwQ0bP+33HHpmeol7seiwYYEpk
 fFOejneeHSj6/utsFfJIuzjGnVyb+5wONSHIfyHZzcj4kWrzowhd0+kfghJ4oxT8Q+qU4Amsq
 bPuxeHt9KevE+Odb7tIyQEt9SOQv+ZJxs5PRBi/VN1SIjqk9dzMWBol1wkD3OA3zGOpJFFe/L
 ieqleMCyqchpoNfzXc4ZbtEFH1DCkS1JiDkqWa249l5DxTpeONReaqSQ+mTuAKwfKA/wINgWp
 yc9mvNaFwe9kKmcLuLelADJ1mkKf4e0cM6uPiiPF2VNwGlETyAf3qUM9n3POf8WncZIV9nbab
 Zad39ZKVEfBJ4II5ZVRd13JExyIFhlislqgnhxGlelFUsAsGOuAgRJ+hmLH90UpiKWMMi3837
 pY0uAV6NFoB4Q1a3dlfwe0eZvzagqGwsNtW/KhwVcKgsPpEHgfUccnxz9nbf3nFTHJT0hExdt
 TGQVX515R1zgjPEUjHGbarY5cVtk/qXLlJ/PO82osEhogRjX/AKMR26Cmrho4Ifow+FLODmuW
 w14Kywfg8mcUlcKCzYmO6j64u6J6R3AMdLf+tcLdAl3LtMowc18ACF7o8F916pX6nOgc4SNMy
 +491rHV
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dennis,

On Fri, 2 Sep 2016, Dennis Kaarsemaker wrote:

> On vr, 2016-09-02 at 18:23 +0200, Johannes Schindelin wrote:
> > This is crucial to improve performance on Windows, as the speed is now
> > mostly dominated by the SHA-1 transformation (because it spawns a new
> > rev-parse process for *every* line, and spawning processes is pretty
> > slow from Git for Windows' MSYS2 Bash).
> 
> I see these functions only used as part of an shorten-edit-expand
> sequence. Why not do a git rebase-helper --edit-todo instead? Saves
> another few process spawnings.

It would make sense to consolidate the steps, yes. I just tried to be
careful in my incremental approach and am fairly certain about the current
revision faithfully replicating the previous behavior.

> Something for yet another later followup patch?

Sure. Probably more than one patch, though: I could imagine that a minor
refactoring would allow us to read in the todo script once, then apply the
individual processing steps in-memory, and then write out the new todo
script.

And then we can implement an --edit-todo with an optional --initial flag
that triggers the check for validity and the rearranging of the
fixup/squash commands (when the user calls `git rebase --edit-todo`,
neither of those steps should be run).

Maybe you will want to have a look into that while I am mostly offline?

Ciao,
Dscho

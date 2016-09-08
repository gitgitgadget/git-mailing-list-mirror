Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B8291F6BF
	for <e@80x24.org>; Thu,  8 Sep 2016 07:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758218AbcIHHyC (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 03:54:02 -0400
Received: from mout.gmx.net ([212.227.15.15]:65353 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753751AbcIHHyA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 03:54:00 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LhOO8-1bDGIz2dbk-00mbRr; Thu, 08 Sep 2016 09:53:53
 +0200
Date:   Thu, 8 Sep 2016 09:53:52 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] Demonstrate a problem: our pickaxe code assumes
 NUL-terminated buffers
In-Reply-To: <20160906184320.lzg5jizpw2kbzf72@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1609080953070.129229@virtualbox>
References: <cover.1473090278.git.johannes.schindelin@gmx.de> <ca678535c64570add58cfff95709c3c67384139d.1473090278.git.johannes.schindelin@gmx.de> <20160906184320.lzg5jizpw2kbzf72@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:dqVGjO9LIWKsrl8fX9i/kvlCBnY8Vdj+Lfk9G0h7j/hTFPWZFXX
 iPaiuQ/Q/iL75ru7GC7nmtpvt56dPHKCHOoyzT4uSUF2EXA5FBQbkXd+qvqaHIXYECpUYt+
 R9gseeeXUe0NtriAcR7F3MZlmCh7vko7LVLzp3c+jX8fj4WjWkWzulq5eCIdu06DlLTJpVA
 zArFwsS95+T6ys3cbMBKQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:63jMk2BzmA0=:ne4pNFncr5Vo9BWE6sHKO2
 Pz0mjADhYzHfIYHs44bf4VVzqaBURIQ4CfvOdjWNaBY2G3UX6d88rCi4TLeUX5r38/2xvumk1
 RJJMMKNpkInDFAtTXaNRJQr+H6uO4BOAkWFs8COsY+DUP3TsO33Uqp1dvISL7mmb3z6OU9PzJ
 m5vpc1j2kUUp1vkDkLKO3bfm0ST6j8H+EFkueCLYr5jZkE2xVBOa1hiyhEEe5kQMzka24wE9N
 sB0CO4OYMdWf7RaEIxAg6oFEPPs3SHwQk8ceQjaVgToyNENCXfX7/mh9fWfGl3OrYgbuX1cIv
 nzeoviCf8Nagdgy+Inq6NT2hwvmdm6s0XnE0JJgAyheQ32OVshGerDKRgG0DdC9RC0xA/7pMZ
 8mQbbvxHpPgjvLuOxT+Hw2Ha8+ibPGAXal8LC4LcNQkfMoXLqbyZz50bVJXQdvDWwQGrRx/3T
 cvAWvGELUD21bkFoDGRhkJpWGDCyERYFaH10JZWjG4YCEJeh/AmuRmWIa+xiRRsOtMVEdtuFu
 aqKFcr2T4/VUnPnH6W4qkvAlhKStF/10ABbMdVAZLlYYb32ye0X1e7sb9UdCmPQYavJPuzrJi
 3Y6XjfIHmUIVgIqaFXImw17nOfm1Ggchi9F/NlYIhben635nlxJq2aNx2ucR034uj8lDqoDdD
 X09+SAmN+L7L2p9nsREa+v5OWremOrZ248suyQJWvzNaOJ6TLKxSOYlsMulnby8xG/XfJRGBg
 PtrDq0AkCO4xoZTTSmJTjEfcxBHNvIV6VJNbNT1WDz0KbxNYIaIDCVTmvHOt/wtnTgsoO9GRI
 3a4Es0y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Tue, 6 Sep 2016, Jeff King wrote:

> On Mon, Sep 05, 2016 at 05:45:02PM +0200, Johannes Schindelin wrote:
> 
> > Typically, on Linux the test passes. On Windows, it fails virtually
> > every time due to an access violation (that's a segmentation fault for
> > you Unix-y people out there). And Windows would be correct: the
> > regexec() call wants to operate on a regular, NUL-terminated string,
> > there is no NUL in the mmap()ed memory range, and it is undefined
> > whether the next byte is even legal to access.
> > 
> > When run with --valgrind it demonstrates quite clearly the breakage, of
> > course.
> > 
> > So we simply mark it with `test_expect_success` for now.
> 
> I'd prefer if this were marked as expect_failure. It fails reliably for
> me on Linux, even without --valgrind. But even if that were not so,
> there is no reason to hurt bisectability of somebody running with
> "--valgrind" (not when it costs so little to mark it correctly).

Forgot to say in the cover letter: I did change this from
test_expect_success to test_expect_failure.

But of course, now I remember that I failed to change it back in 3/3. Bah.

Ciao,
Dscho

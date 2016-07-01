Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F96820FCF
	for <e@80x24.org>; Fri,  1 Jul 2016 08:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752517AbcGAIFd (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 04:05:33 -0400
Received: from mout.gmx.net ([212.227.17.21]:65128 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752182AbcGAIF0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 04:05:26 -0400
Received: from virtualbox ([37.24.143.238]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0Lqm3a-1bnIa52iGI-00eOGd; Fri, 01 Jul 2016 10:05:19
 +0200
Date:	Fri, 1 Jul 2016 10:05:19 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Jeff King <peff@peff.net>
cc:	"dmh@ucar.edu" <dmh@ucar.edu>, git@vger.kernel.org
Subject: Re: [PATCH 2/5] common-main: call git_extract_argv0_path()
In-Reply-To: <20160701060404.GB4593@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1607011000320.12947@virtualbox>
References: <20160701055532.GA4488@sigill.intra.peff.net> <20160701060404.GB4593@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:aeDlJDgHgZDZSmfWctyeCCR7jJzZJ8j2fdNwh52XwJbkDTKbX8r
 /9XKBjpPW072WCcjRS63PZXHR4ZVUGP0VmjgZqKxlThZaP8Q28zFOgP4Cu6QluKRoLV6pi9
 kLYqxfSEun1Yjtz3eJjnlvU56Gefhu614OTba3YsOjlZZy7SJJnwDJdN7b6wh9+YLlhsHd/
 aFkxr5i3AP0xcR9kCG5fQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:WdLEnN6W3jU=:Hev9SsAEpnwEM2fC8FKFpB
 SeZ6hXhlAx5WFtVCVgmszPnxDVg4u+hbzW1Qw7Nzn/BebT/5pP04stJKMZB9kMhdIEHmspPyZ
 jPHn1mAmgcAt5duOoxAr0DcZCn38Z/CejrkpHergIXDgwxhRmUflu4Q5QCXPaszhi2LvCE3Ah
 rnq9DwSurCLOVuXBopO1fWPI6B66BkO7xusbPqn8I/TXn5E/QyvgKPK74twt0eqYLi3e3R3LQ
 e5NwaNrg+vkRjcAL5NiqdXZhzvJAgC4T5Uwb/PMW/+peglUhPSllzfcwJ2UpQ7F/NCCycYpYr
 uG+9uzybuVHSE/FnsO/fP0jnuoEuQdEe3SsVb/5iicbM5Db7awhFTHvNd5G0aFLkc67L9301U
 u7rRRrrHTzObULZ4PY38LYnbLKKjEsXGIYrCbsjGP2515dbm5N5OxtKUTLhnpNxXxgcF/O/FF
 HV93D/xuz3Xce4ssF6iSwmG02bCOGuVvmc6tsMrk2wDeP1e8PmCEFCJgx73WiQUDRY4Y2xajJ
 fc3vfOvxMhFpW7EqQmPO4GhgBLNX5QfSXmQRSsVI14miuT6QdrPEQ4GtA7SPmFPtVqF/LSrKW
 a2MF1q3cwKzWmrExzbYIiIcqLoAw63iupRXrazeA2SlTVAUP1SDxg5N10GH3eSpvmcQ2RNjHW
 eRACPBAOUqkz7IegwvoAOAKb3pjNOvrgihkxvvPzBbeg4UqW0TJl6wVJxys6ugO2slgyAjcVF
 hZHEsLXn2jzyaFmjtqrEANfAmy3P70Gv8CR2mvdDzQ1w4BjV1P8Tn0WM2xtLkv9TWGSBEJSYh
 TwE4Gg/
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Peff,

On Fri, 1 Jul 2016, Jeff King wrote:

> This has been an accident-waiting-to-happen for a long time,
> but wasn't triggered until recently because it involves one
> of those programs actually calling system_path(). That
> happened with git-credential-store in v2.8.0 with ae5f677
> (lazily load core.sharedrepository, 2016-03-11). The
> program:
> 
>   - takes a lock file, which...
> 
>   - opens a tempfile, which...
> 
>   - calls adjust_shared_perm to fix permissions, which...
> 
>   - lazy-loads the config (as of ae5f677), which...
> 
>   - calls system_path() to find the location of
>     /etc/gitconfig
> 
> On systems with RUNTIME_PREFIX, this means credential-store
> reliably hits that assert() and cannot be used.

Thank you for that thorough write-up. I am now even more upset that we had
to go through the same steps (it took me an hour to figure out what was
going wrong, mostly due to abort() *not* spitting out a stack trace, so I
had to wield some gdb magic).

I am partly to blame here, of course, because I did not report what I did
to this mailing list. But then: 1) I considered this a Windows-only
problem, and 2) I was really already swamped, as it were.

The patch is good, of course, as are the rest of the patches (I did not
really look at them very thoroughly, but then, they are pretty obvious
improvements).

Ciao,
Dscho

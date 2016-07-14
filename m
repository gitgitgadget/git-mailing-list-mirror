Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F23920196
	for <e@80x24.org>; Thu, 14 Jul 2016 15:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbcGNPsH (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 11:48:07 -0400
Received: from mout.gmx.net ([212.227.15.15]:59366 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751231AbcGNPsE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 11:48:04 -0400
Received: from virtualbox ([37.24.141.198]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MZkNy-1bfwly1uta-00LXrd; Thu, 14 Jul 2016 17:47:44
 +0200
Date:	Thu, 14 Jul 2016 17:47:41 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Jeff King <peff@peff.net>
cc:	git@vger.kernel.org, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
	Johannes Sixt <j6t@kdbg.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 2/5] t5000: test tar files that overflow ustar
 headers
In-Reply-To: <20160630090857.GB17463@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1607141745420.6426@virtualbox>
References: <20160630090614.GA16725@sigill.intra.peff.net> <20160630090857.GB17463@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:UY+mu0jvX3tC0xDIrySs9GNtbm87GP/2D/dRA+pjRuj9AHCjNUQ
 5CmzXlh2NjUqDlMwOSCaeeMmWBUpPn3g4ERSHMnxSxOKVLafUN+7jLRZCnqsozssIikgQgQ
 mReudwGuLYGkjjRF5n2B1kGOekLoqjCvo5ZhETL8RAsTnrfcJwwb2+KGQg4+Etpm8E39n0G
 k9WJiDkYlfSe/gD/0aVdw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:2ePnTWcCtdg=:ShWNY3ItiZmBbDiJcsTLG/
 A7TaF5SqOUyxhId8+NXLQMgy7F+3vR4RIb/iP5P2duVNW3udufScOaCPM7k2OiGpmDH9PaOGi
 XYdd/eAxZa/+DLb+wGodFDScaKYgbWT9UsISyzMRKi17kP+vhkHxr15AWsbEFGJuVA8DJlneP
 +9xFbV99eyeAFuyvTSi83G1te+CeptEtBcWKYGviH/CBv6tiyrUUThqOuyUXAFG84Z6GH2gXz
 QAMdm8kCOJ8TTe9qk2Wlum6bWZ0ApDiwTyAYJqfPfP0jqmmGF8eirmk64PazAXZaGfjB93kLv
 SvvDrpoWs4JFzeYj6JUI2OKNriYsYEhSI+hrnZcCdR9xnf+PapxidmqvMwrOHfaL3IPfIu6pc
 /UQDyK4esGywpJ+Vm4yN2sLDsbGXkHY9j3zyvbFNVpgx9Iyy6mA8tTpahxl0MpqpTsmR7oxnc
 Lm6qguEks9tkmBQJUt8efaTHncN2Ya3AU4M95fJCCOJnBGTPjb1jl6BPg24yPjZqqo8oUAczS
 qfoYfPbPnS9Dgc+/uNKA77d+WpgG5Mau3nvo+d8gEYKQ1R2hOAR3q6PY87YnvY8wcKJ7+rjtd
 ciMotV7BpTD+6Oz/7sWxGe1z9gucP34rFBmXpqICef9/2mD8f+Z1u259TbDtguRNwaR8AbyPD
 TzS6/VFyiJ9D71q5y7g2k+3DA7X58Fvi/avjyR/1tW3cDDSoCCfWk5927uST6PIbrw6g/nR5T
 DiCpB7NtNPInMwfxK8LmptwjeroUBIaZHn0TICdQWXOR2uKHFg17VhvanvAHphAfAZrSCZpJ8
 CkSICjp
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Peff,

sorry for the very, very late reply.

On Thu, 30 Jun 2016, Jeff King wrote:

> The ustar format only has room for 11 (or 12, depending on
> some implementations) octal digits for the size and mtime of
> each file. For values larger than this, we have to add pax
> extended headers to specify the real data, and git does not
> yet know how to do so.
>
> [...]
>  t/t5000/19f9c8273ec45a8938e6999cb59b3ff66739902a | Bin 0 -> 2048 bytes

It appears that this blob cannot be read when sizeof(unsigned long) == 4.
This happens to break the t5000 test on Windows, where that comparison
holds true.

I am sure that I missed some other discussion about this issue... could
you point me to it?

Ciao,
Dscho

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83A2820899
	for <e@80x24.org>; Thu, 17 Aug 2017 20:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753165AbdHQU25 (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 16:28:57 -0400
Received: from mout.web.de ([212.227.17.11]:60653 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752632AbdHQU24 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 16:28:56 -0400
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Mg75d-1duAxc1fRl-00NUTG; Thu, 17
 Aug 2017 22:28:45 +0200
Date:   Thu, 17 Aug 2017 22:28:44 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Martin Koegler <martin.koegler@chello.at>
Cc:     git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de
Subject: Re: [Patch size_t V3 01/19] delta: fix enconding size larger than an
 "uint" can hold
Message-ID: <20170817202844.GA31284@tor.lan>
References: <1502914591-26215-1-git-send-email-martin@mail.zuhause>
 <1502914591-26215-2-git-send-email-martin@mail.zuhause>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1502914591-26215-2-git-send-email-martin@mail.zuhause>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K0:YNrF+ocuA44c5YbhG7QALQ67h13fwv0GlENbQq5bPCUUW35Y6b3
 clId5gwsrBkAIv0F8yXDWpiL6xyJBTEixT6t4LhhuUoDra97T0uiprDvqkqvpBNYEoajv19
 +R3QVMhH+BUN3OZZoXonU9Z6x/oF5Uaj95xqGd6tovBYGnGoVsIXRpzyNtliPd6kk3swzM6
 uET3q0v2SrpNnzbFkhAxw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:oKiBu3cmnr8=:mdyjKZe84L1Ix6tKQAfvgh
 FUAnx/PiYXOvA5fQaxXPy13VNjWCqQAtorTKO8FxdjB2T1ite9E5dGabN3PyZgFYOfK1L1YLq
 8MtyZhC3KQrMOD0e73W7jqQyieuylo6dt3CRqIMhDdef/Tcn8JG7/CloSAFn/1Yhy5HM4grRM
 N3sjS0ErcWfyU3BLzwO2m4LpEXseNGFjXYcxNv8l9km+nEacT10ed+iHn1AWilmo7iICt7fTi
 JJsvhPaLXM3vt181ReIg8cnYX9JwLanuenMfgOtr5yPvzjCJOaX3CRsmtN4oVDbw+it1V2q45
 2zozAcv16AU0ngJlNWxfb+0H52lypR6JBpOVDJuAOnvC9GHRZ4cW0aNAGro5cFq6vRp4H/Kwo
 2R5x1VLuSFoPnhENYIUXjMkrSkPlMNBKFFbU1Ir4GHhABZUzAEPIxhzW6H/r7A4is5YDQgwFf
 0ZO5i13G1EbevH78X9W0mfIN9GC8gyIrszPJ+huxyhNAq5CSplY0Ksk2uFHmAU10QiTZmE85D
 k8uZYI1p54J8nEKto44/PJVvqRLEGbVgo4AT+r+QqZLmz7Mljo/GsArXPVdh64gU7E38J1qFZ
 xVDl+9AaGIPg7md5/E8ndCTfkqJWK6NRC4DTMiPbvYbq+kqyLqUPPm2dLxpfmMxDEFUhzDQG4
 Qmx2BCFFkwMD4+tY0bQmscOyY/5sWLdwZJsXbU4v2JqDysI624mtCbvrnrDHlm+wfGT4F0Stq
 TmgXs51ue0urV48AD3EE2ePInBLTa+s4HmKU+PjF6wpEsZKkJb9h4ekOK4Am2/kinuvEY3gEN
 819Yg7KD6XoEDB5oDg/951boFLsgg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 16, 2017 at 10:16:13PM +0200, Martin Koegler wrote:
> From: Martin Koegler <martin.koegler@chello.at>
> 
> The current delta code produces incorrect pack objects for files > 4GB.

This may need a little bit more info (E.g. it does not fix anything on
a 32 bit Linux)

How about this:
The current delta code produces incorrect pack objects for files > 4GB
when "unsigned long" has 32 bits and size_t 64 bits.


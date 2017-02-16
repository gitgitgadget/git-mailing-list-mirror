Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E5B71FC44
	for <e@80x24.org>; Thu, 16 Feb 2017 16:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932909AbdBPQsL (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 11:48:11 -0500
Received: from zm23-mta-out-2.grenet.fr ([130.190.191.53]:48770 "EHLO
        zm23-mta-out-2.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932358AbdBPQsJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 11:48:09 -0500
Received: from zm23-mta-out.grenet.fr (zm23-mta-out.grenet.fr [130.190.191.35])
        by zm23-mta-out-2.grenet.fr (Postfix) with ESMTP id F3C54288E6;
        Thu, 16 Feb 2017 17:48:07 +0100 (CET)
Received: from smtps.univ-grenoble-alpes.fr (smtps2.u-ga.fr [195.83.24.202])
        by zm23-mta-out.grenet.fr (Postfix) with ESMTP id EEC7A100494;
        Thu, 16 Feb 2017 17:48:07 +0100 (CET)
Received: from anie (anie.imag.fr [129.88.42.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: moym@univ-grenoble-alpes.fr)
        by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id E5BB4607CF;
        Thu, 16 Feb 2017 17:05:03 +0100 (CET)
From:   Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To:     Siddharth Kannan <kannan.siddharth12@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, pranit.bauva@gmail.com,
        peff@peff.net, pclouds@gmail.com, sandals@crustytoothpaste.ath.cx
Subject: Re: [PATCH 1/4 v4] revision.c: do not update argv with unknown option
References: <1487258054-32292-1-git-send-email-kannan.siddharth12@gmail.com>
        <1487258054-32292-2-git-send-email-kannan.siddharth12@gmail.com>
Date:   Thu, 16 Feb 2017 17:48:07 +0100
In-Reply-To: <1487258054-32292-2-git-send-email-kannan.siddharth12@gmail.com>
        (Siddharth Kannan's message of "Thu, 16 Feb 2017 15:14:11 +0000")
Message-ID: <vpqwpcqm69k.fsf@anie.imag.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Greylist: Whitelist-UJF SMTP Authentifie (moym@univ-grenoble-alpes.fr) via smtps.univ-grenoble-alpes.fr ACL (97)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Siddharth Kannan <kannan.siddharth12@gmail.com> writes:

> handle_revision_opt() tries to recognize and handle the given argument. If an
> option was unknown to it, it used to add the option to unkv[(*unkc)++].  This
> increment of unkc causes the variable in the caller to change.
>
> Teach handle_revision_opt to not update unknown arguments inside unkc anymore.
> This is now the responsibility of the caller.
>
> There are two callers of this function:
>
> 1. setup_revision: Changes have been made so that setup_revision will now
> update the unknown option in argv

You're writting "Changes have been made", but I did not see any up to
this point in the series.

We write patch series so that they are bisectable, i.e. each commit
should be correct (compileable, pass tests, consistent
documentation, ...). Here, it seems you are introducing a breakage to
repair it later.

Other that bisectability, this makes review harder: at this point the
reader knows it's broken, guesses that it will be repaired later, but
does not know in which patch.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/

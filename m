Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 855AE2035F
	for <e@80x24.org>; Fri, 11 Nov 2016 17:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934472AbcKKRLH (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Nov 2016 12:11:07 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:58496 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933443AbcKKRLG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2016 12:11:06 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3tFmdz4gzsz5tlF;
        Fri, 11 Nov 2016 18:11:03 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id E3D17146;
        Fri, 11 Nov 2016 18:11:02 +0100 (CET)
Subject: Re: [PATCH] mingw: hot-fix t5615
To:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <f4336a7fa3df8c0b426c3d01ada8d7d8f38e588a.1478881741.git.johannes.schindelin@gmx.de>
 <xmqq37iy3q0s.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <fa11def5-a878-a5c8-6e7b-627ea8cda7e2@kdbg.org>
Date:   Fri, 11 Nov 2016 18:11:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <xmqq37iy3q0s.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 11.11.2016 um 18:06 schrieb Junio C Hamano:
> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>
>> That test made the incorrect assumption that the path separator character
>> is always a colon. On Windows, it is a semicolon instead.
>
> Documentation/git.txt says that GIT_ALTERNATE_OBJECT_DIRECTORIES is
> separated with ";" on Windows fairly clearly, and we should have
> caught that.
>
> For the upcoming release there is no need for any further tweak on
> your fix I am responding to, but in the longer term we would want to
> turn this to path_sep=";" (or ":") and define it in the global
> t/test-lib.sh, as it is plausible that we may want to prepend or
> append to $PATH in the tests and that also needs ";" on Windows, no?
>
> Are there other variables that is a list of paths that we care in
> our tests?  I notice GIT_CEILING_DIRECTORIES does not have the
> corresponding ": separated (on windows ; separated) list" in its
> description in Documentation/git.txt but the documentation may need
> to be fixed there as well?
>
> Thanks for a quick fix.  Will apply on jk/alt-odb-cleanup and merge
> down.

A simpler fix is to use $PWD instead of $(pwd). I'll submit a patch in a 
moment.

-- Hannes


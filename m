Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E02C20986
	for <e@80x24.org>; Thu, 29 Sep 2016 10:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932949AbcI2KEB (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 06:04:01 -0400
Received: from mx1.imag.fr ([129.88.30.5]:36777 "EHLO mx1.imag.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932221AbcI2KD7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 06:03:59 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
        by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u8TA3Xii011203
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Thu, 29 Sep 2016 12:03:33 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
        by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u8TA3YFw004172;
        Thu, 29 Sep 2016 12:03:34 +0200
From:   Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>,
        Junio C Hamano <gitster@pobox.com>,
        torvalds@linux-foundation.org, git@vger.kernel.org
Subject: Re: [PATCH 4/4] core.abbrev: raise the default abbreviation to 12 hexdigits
References: <20160928233047.14313-5-gitster@pobox.com>
        <20160929024400.22605-1-szeder@ira.uka.de>
        <20160929091509.2n4mdrevwxechqol@sigill.intra.peff.net>
Date:   Thu, 29 Sep 2016 12:03:34 +0200
In-Reply-To: <20160929091509.2n4mdrevwxechqol@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 29 Sep 2016 05:15:10 -0400")
Message-ID: <vpq7f9v9g5l.fsf@anie.imag.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Thu, 29 Sep 2016 12:03:33 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u8TA3Xii011203
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1475748214.3119@ZF4dnMKWUfK1FRAgHW8lrg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Sep 29, 2016 at 04:44:00AM +0200, SZEDER Gábor wrote:
>
>> >     So 12 seems reasonable, and the only downside for it (or for "13", for
>> >     that matter) is a few extra bytes. I dunno, maybe people will really
>> >     hate that, but I have a feeling these are mostly cut-and-pasted anyway.
>> 
>> I for one raise my hand in protest...
>> 
>> "few extra bytes" is not the only downside, and it's not at all about
>> how many characters are copy-and-pasted.  In my opinion it's much more
>> important that this change wastes 5 columns worth of valuable screen
>> real estate e.g. for 'git blame' or 'git log --oneline' in projects
>> that don't need it and certainly won't ever need it.
>
> True. The core of the issue is that we really only care about this
> minimum length when _storing_ an abbreviation, but we don't know when
> the user is just looking at it in the moment, and when they are going to
> stick it in a commit message, email, or bug tracker.

Perhaps a compromise would be to adapt the length to the size of the
project _and_ keep a huge margin. So, essentially, we'd have small
projects stick to the 7 characters, and very quickly bump to 12.

So, for a fast-growing project, there would be a short window at the
beginning of the project where people could cut-and-past short hashes.
OTOH, small projects could keep these few columns of screen real-estate.

That said, I can certainly live without these 5 columns, don't take my
message as an objection to setting to 12 right away.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/

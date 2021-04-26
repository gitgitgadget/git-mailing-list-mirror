Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E508C433B4
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 14:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B6516127A
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 14:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233828AbhDZOZ2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 10:25:28 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:33183 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231862AbhDZOZ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 10:25:27 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 13QEOJOY002714
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Apr 2021 10:24:19 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 0BDF315C3BC5; Mon, 26 Apr 2021 10:24:19 -0400 (EDT)
Date:   Mon, 26 Apr 2021 10:24:19 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Raxel Gutierrez <raxelgutierrez09@gmail.com>,
        mricon@kernel.org, patchwork@lists.ozlabs.org,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: Pain points in Git's patch flow
Message-ID: <YIbNE0Fw2VaZt9ry@mit.edu>
References: <YHaIBvl6Mf7ztJB3@google.com>
 <YIYfsMsz0Uz48GaI@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIYfsMsz0Uz48GaI@camp.crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 26, 2021 at 02:04:32AM +0000, brian m. carlson wrote:
> In general, I have trouble keeping track of the patch mails I've sent.
> I do definitely need to refer to them later, but I don't generally keep
> them around on my system since they tend to duplicate my repository, so
> I end up needing to find them in my mailbox, which as mentioned, is
> slow and error prone.

A quick and easy feature request to this (which I have had as well)
would be implementing a sendmail.fcc config, which if set, would
append any mail messages sent by git send-email to the Unix
mbox file specified by sendmail.fcc.

Once you have the message id of any patch mail that you've sent...

> I have trouble finding all the spots where people have given me review
> feedback.  I have patch mails and responses to those mails go to a
> particular folder, but I still often find that I'm not quite sure if
> I've gotten every piece of feedback in a review.  Sometimes,
> embarrassingly, I don't, and then I have to send another reroll.
> Regardless, this makes rerolling a series much slower as I have to comb
> my mail multiple times.

This becomes pretty easy to solve using existing tooling.  For people
who like web interfaces:

    https://lore.kernel.org/r/<message-id>

(This works today because git@vger.kernel.org is archived by the
lore.kernel.org public-inbox archive.)

Or for those who like CLI's and/or text-based mail readers such as
mutt or pine:

   b4 mbox -o /tmp <message-id>

This will dump the full mail thread (given any any message-id in that
mail thread) to /tmp/<messaige-id>.mbx in Unix mbox format, again
relying on lore.kernel.org.  I've found this to be especially handy if
I've been cc'ed part-way through a mail thread, or if I was only cc'ed
on a single patch and I want to see the full patch series for context.

Cheers,

						- Ted

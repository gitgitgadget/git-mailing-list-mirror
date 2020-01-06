Return-Path: <SRS0=yIgW=23=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8FE9C33C8C
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 19:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84D3D207FF
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 19:32:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgAFTcy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jan 2020 14:32:54 -0500
Received: from cloud.peff.net ([104.130.231.41]:58118 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726657AbgAFTcy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jan 2020 14:32:54 -0500
Received: (qmail 2360 invoked by uid 109); 6 Jan 2020 19:32:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 06 Jan 2020 19:32:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24630 invoked by uid 111); 6 Jan 2020 19:38:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 06 Jan 2020 14:38:25 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 6 Jan 2020 14:32:53 -0500
From:   Jeff King <peff@peff.net>
To:     Mike Rappazzo <rappazzo@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Rappazzo via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 0/1] sequencer: comment out the 'squash!' line
Message-ID: <20200106193253.GA971477@coredump.intra.peff.net>
References: <pull.511.git.1578326648.gitgitgadget@gmail.com>
 <xmqq7e24a3t0.fsf@gitster-ct.c.googlers.com>
 <CANoM8SV=pT3sFrfnEqWc2xBn_c2rES0qSMsdptF0DgcxgYL94w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANoM8SV=pT3sFrfnEqWc2xBn_c2rES0qSMsdptF0DgcxgYL94w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 06, 2020 at 02:20:09PM -0500, Mike Rappazzo wrote:

> > Can you tell us more about your expected use case?  I am imagining
> > that most people use the log messages from both/all commits being
> > squashed when manually editing to perfect the final log message (as
> > opposed to mechanically processing the concatenated message), so it
> > shouldn't matter if the squash! title is untouched or commented out
> > to them, and those (probably minority) who are mechanical processing
> > will be hurt with this change, so I do not quite see the point of
> > this patch.
> 
> This change isn't removing the subject line from the commit message
> during the edit phase, it is only commenting it out.  With the subject being
> commented out, it can minimize the effort to edit during the squash.
> 
> Furthermore, it can help to eliminate accidental inclusion in the final
> message.  Ultimately, the accidental inclusion is my motivation for
> submitting this.

But I thought that was the point of "squash" versus "fixup"? One
includes the commit message, and the other does not.

I do think "commit --squash" is mostly useless for that reason, and I
suspect we could do a better job in the documentation about pushing
people to "--fixup".

But --squash _can_ be useful with other options to populate the commit
message (e.g., "--edit", which just pre-populates the subject with the
right "squash!" line but lets you otherwise write a normal commit
message). If that's the workflow you're using, then I'm sympathetic to
auto-removing just a "squash!" line, as it's automated garbage that is
only meant as a signal for --autosquash.

-Peff

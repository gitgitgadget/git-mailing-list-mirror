Return-Path: <SRS0=27Fn=A3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19AFAC433DF
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 16:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8E1F2076D
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 16:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728505AbgGPQ4x (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jul 2020 12:56:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:59418 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbgGPQ4w (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jul 2020 12:56:52 -0400
Received: (qmail 25377 invoked by uid 109); 16 Jul 2020 16:56:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 16 Jul 2020 16:56:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27256 invoked by uid 111); 16 Jul 2020 16:56:51 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 16 Jul 2020 12:56:51 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 16 Jul 2020 12:56:51 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, delphij@google.com,
        Huan Huan Chen <huanhuanchen@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 2/2] repository: allow repository format upgrade with
 extensions
Message-ID: <20200716165651.GB1072075@coredump.intra.peff.net>
References: <0bede821-139a-d805-934a-142004abaa4c@gmail.com>
 <nycvar.QRO.7.76.6.2007141420300.52@tvgsbejvaqbjf.bet>
 <xmqqzh82ktgm.fsf@gitster.c.googlers.com>
 <xmqqpn8wkben.fsf@gitster.c.googlers.com>
 <20200716062054.GA3242764@google.com>
 <20200716062818.GC3242764@google.com>
 <xmqqh7u8hrka.fsf@gitster.c.googlers.com>
 <20200716110007.GD376357@coredump.intra.peff.net>
 <20200716122513.GA1050962@coredump.intra.peff.net>
 <xmqqv9inh0c5.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqv9inh0c5.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 16, 2020 at 09:49:14AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Subject: verify_repository_format(): complain about new extensions in v0 repo
> >
> > We made the mistake in the past of respecting extensions.* even when the
> > repository format version was set to 0. This is bad because forgetting
> > to bump the repository version means that older versions of Git (which
> > do not know about our extensions) won't complain. I.e., it's not a
> > problem in itself, but it means your repository is in a state which does
> > not give you the protection you think you're getting from older
> > versions.
> >
> > For compatibility reasons, we are stuck with that decision for existing
> > extensions. However, we'd prefer not to extend the damage further. We
> > can do that by catching any newly-added extensions and complaining about
> > the repository format.
> 
> Looking good overall, but I needed this to build from the source.

Oof, thanks. I did this as a one-off not even on a branch, and my
config.mak magic loosens -Werror in that case (because usually a
detached HEAD means I'm investigating some old commit, and quite a few
of them don't build without warnings these days).

Thankfully it seems I only managed a minor error without the compiler
there to help me. :)

-Peff

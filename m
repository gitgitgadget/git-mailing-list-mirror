Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9333C201B0
	for <e@80x24.org>; Tue, 28 Feb 2017 20:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751450AbdB1UJk (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 15:09:40 -0500
Received: from cloud.peff.net ([104.130.231.41]:35889 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750957AbdB1UJj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 15:09:39 -0500
Received: (qmail 19481 invoked by uid 109); 28 Feb 2017 20:08:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Feb 2017 20:08:24 +0000
Received: (qmail 29615 invoked by uid 111); 28 Feb 2017 20:08:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Feb 2017 15:08:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Feb 2017 15:08:22 -0500
Date:   Tue, 28 Feb 2017 15:08:22 -0500
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Dmitry Neverov <dmitry.neverov@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>
Subject: Re: 'git submodules update' ignores credential.helper config of the
 parent repository
Message-ID: <20170228200821.iojdzntjslwgrzcb@sigill.intra.peff.net>
References: <CAC+L6n0YeX_n_AysCLtBWkA+jPHwg7HmOWq2PLj75byxOZE=qQ@mail.gmail.com>
 <CAGZ79ka8saQMKeutE415WxOQ71MnEw1A4uV3b0Pa4gcehx8pdw@mail.gmail.com>
 <20170228143710.smbzo6b7wefjc62r@sigill.intra.peff.net>
 <CAGZ79kb8F9_9fd9uhfPpHVPQj-zm99qt5Tr=3TUhpe=K6JknEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kb8F9_9fd9uhfPpHVPQj-zm99qt5Tr=3TUhpe=K6JknEg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 28, 2017 at 10:05:24AM -0800, Stefan Beller wrote:

> > I have a feeling that something like this would create unwelcome corner
> > cases in the config-writer, which is otherwise does not have to care
> > about which existing section of a file it adds a key to.
> 
> Yeah the writer would become a lot more involved, if we're not going
> the stupid way (add these sections for nearly all keys. that would be
> a mess but easy to implement)
> 
> So I guess then we rather settle with multiple config files or a white/blacklist
> of config options to propagate from the superproject to its submodules.

I'm still open to the idea that we simply improve the documentation to
make it clear that per-repo config really is per-repo, and is not shared
between super-projects and submodules. And then something like Duy's
proposed conditional config lets you set global config that flexibly
covers a set of repos.

-Peff

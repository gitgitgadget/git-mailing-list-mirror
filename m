Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10D8F1F991
	for <e@80x24.org>; Tue,  8 Aug 2017 07:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751963AbdHHHiJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 03:38:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:60058 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751863AbdHHHiJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 03:38:09 -0400
Received: (qmail 5697 invoked by uid 109); 8 Aug 2017 07:38:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 08 Aug 2017 07:38:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13710 invoked by uid 111); 8 Aug 2017 07:38:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 08 Aug 2017 03:38:31 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Aug 2017 03:38:06 -0400
Date:   Tue, 8 Aug 2017 03:38:06 -0400
From:   Jeff King <peff@peff.net>
To:     Shawn Pearce <spearce@spearce.org>
Cc:     Ben Alex <ben.alex@acegi.com.au>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        David Borowitz <dborowitz@google.com>,
        Stefan Beller <sbeller@google.com>,
        David Turner <David.Turner@twosigma.com>,
        Kristoffer Sjogren <stoffe@gmail.com>
Subject: Re: reftable [v5]: new ref storage format
Message-ID: <20170808073806.ofrxcvgg3f6zaudu@sigill.intra.peff.net>
References: <CAJo=hJsOHF0KVmXvbSBiBgxq4zRdt7v7sj_GuKvcpbu8tkujFA@mail.gmail.com>
 <874ltkzlcf.fsf@gmail.com>
 <CAJo=hJuPwEWJEWOUpJ_T-=j0NxnzjOLy_=-qG51_zuYhKbBvrw@mail.gmail.com>
 <CAOhB0ruYhGAyNn84ZjS7TH7QdwxNi2bPN8KFxEEBd58B9qVrmg@mail.gmail.com>
 <CAJo=hJsEaKH40WnhxqvkASpiXnV8ipc+b1zrZ9VEjqRjpJ17Qg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJo=hJsEaKH40WnhxqvkASpiXnV8ipc+b1zrZ9VEjqRjpJ17Qg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 07, 2017 at 07:41:43AM -0700, Shawn Pearce wrote:

> > As such if JGit wanted to use a longer key size, it is possible to implement
> > similar automatic builds and packaging into JGit.
> 
> I don't know if we need a larger key size. $DAY_JOB limits ref names
> to ~200 bytes in a hook. I think GitHub does similar. But I'm worried
> about the general masses who might be using our software and expect
> ref names thus far to be as long as PATH_MAX on their system. Most
> systems run PATH_MAX around 1024.

GitHub limits to 255 (for the fully-qualified name, so including
"refs/heads/"). I don't recall ever seeing any complaints about that,
though I suppose it's not out of the realm of possibility for somebody
with a multi-byte encoding to hit with a real name (it's configurable,
so I'm not sure if Enterprise customers in Asia might ever bump it).  I
do think something like 1024 would be well into "you're insane if you
really want to name your branch this" territory.

-Peff

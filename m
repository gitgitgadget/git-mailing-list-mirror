Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70BEC207D6
	for <e@80x24.org>; Wed,  3 May 2017 09:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752529AbdECJgT (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 05:36:19 -0400
Received: from mout.gmx.net ([212.227.15.18]:52009 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752289AbdECJgS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 05:36:18 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LkgAG-1dg0Oh1BtE-00aUHk; Wed, 03
 May 2017 11:35:59 +0200
Date:   Wed, 3 May 2017 11:35:56 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 14/25] setup_discovered_git_dir(): plug memory leak
In-Reply-To: <20170502181511.wxr75p2uuwc4nni2@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1705031134250.3480@virtualbox>
References: <cover.1493387231.git.johannes.schindelin@gmx.de> <cover.1493740497.git.johannes.schindelin@gmx.de> <ab131705c4383dc408860b516b1e18b0753b0cbf.1493740497.git.johannes.schindelin@gmx.de> <CAGZ79kbsy1qh02WjX0nt6ci4r+5DVxJcPzwburBf0TP0qaEMTA@mail.gmail.com>
 <20170502181511.wxr75p2uuwc4nni2@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:izbpntlcqCIRAQYGdqgPCRIqlEb8xi52e4GsHW8nTXAG3FoPuQE
 Rhcr7lqEevhD8AL4H/52fa9Mi3bWfWhOzPA6B1PlzZ5+vmFkgYMwwPW4RYh9m5l1VfzNeHJ
 pQfcTWhw4B04cLcwh1rV7KTeG6/zLUnSy9fvz6QdlBk2DCq3mHkSnMc/bmLLpvrezVWz8un
 rHlA/RLjqvmvvoq+FaALw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Ep2b3T4Fpe0=:2OvA4cnDJnnLV5lNIGZo8L
 9zUj8zaZB1hOqfAqLXIA07IpNhFwXyshkBoZ4NxbMEku9fQtWvbDBXHgIiTOBSYKfwwT5X5bu
 TwOUaIzYC38a6SmPRTNOhR0UQYDiq3TQugNmkn7DRxw+62/6ZZgCuQs17+ggBdZjW9Edct4ZZ
 uKmQD4iVeyHeCAaqZ6l4DjQYahu+DR+C/d+O6jx6mLr0Tywyw/n/Q6RW8kBvq6zQMkdMCtsal
 SwqryruR1eXXbCpIKaPcf8xGouDoFR52hxdqtnP8WsrsHZqJlQId2CNwQInUExwph/lp6TgT7
 p+IQkdEN7H9YJTNI6RubdRsrFH4sqokvuu7wRvtwz62xksQ/SDszW9g5EEPzKQAf63PyFsJ1O
 S96lbYVEZPCe57zEqW1jMM/+C6IlbBKqZ2RaspDUWShHJBPcfa5QlIv5AaBMjx3Y8hE7ncy5Q
 gQSeqB47sfjXEvVCvZeSf97voF4DC6HgbXm9B1QmnHbMiw4HtHIAPioCewsmN3nnVgLiHUA/w
 A2+SpHYRyRKlrqo6BnZYnbdb/IMZoC6jDUDKTc8Al/3Q3iHq0+VRBZzI3Vz8/sVoKVr51NdK8
 VCFOjwdcvW5Np/+c3IiXd8Adi1wX91ghnq39X5mzWwvPCQOQ0QXjASPCwuCkvYbF/cFUfN0EN
 8Bmy3EPsgkqLvcOY88auAy4zNRh6xxVHi/egoVp0X4++LY+4W269y3hztMTEfYSeaF5pOmTQo
 pyNoxuNgBH7vJlpbo4QABuKlztXNNbBBn6HpBsXopLNsCRasi3Cx+7OqFxyMdZFjhD6pfZGr9
 5qlKFsq
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Tue, 2 May 2017, Jeff King wrote:

> On Tue, May 02, 2017 at 10:20:29AM -0700, Stefan Beller wrote:
> 
> > > -                       gitdir = real_pathdup(gitdir, 1);
> > > +                       gitdir = to_free = real_pathdup(gitdir, 1);
> > >                 if (chdir(cwd->buf))
> > >                         die_errno("Could not come back to cwd");
> > 
> > As the original motivation was to shut up Coverity, this may not
> > accomplish that goal, as in the path of taking the die_errno, we do not
> > free `to_free`. But that is ok as the actual goal is to hav no memleaks
> > in the good case. A memleak just before a die is no big deal.
> 
> I think Coverity understands our NORETURN attributes, so this should be
> fine (and if it doesn't, then we should fix that in the model file; but
> from the general results I've seen, it does).

That matches my impression.

Note that Coverity cannot figure out that all of our cmd_*() functions are
called in code paths that exit() with their return value. Otherwise we
would not see reports about those tons of intentional "let's abuse exit()
as our garbage collector" instances.

Ciao,
Dscho

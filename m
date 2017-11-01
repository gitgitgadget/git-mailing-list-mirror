Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC2612055E
	for <e@80x24.org>; Wed,  1 Nov 2017 22:35:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753435AbdKAWf1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 18:35:27 -0400
Received: from mout.gmx.net ([212.227.17.22]:61114 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751609AbdKAWf0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 18:35:26 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M8mCe-1e09gS3I8C-00CD5e; Wed, 01
 Nov 2017 23:35:15 +0100
Date:   Wed, 1 Nov 2017 23:33:51 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>, Kevin D <me@ikke.info>
Subject: Re: [PATCHv2 2/7] revision.h: introduce blob/tree walking in order
 of the commits
In-Reply-To: <20171101213911.aokzrnchr6s2r2uq@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.21.1.1711012333060.6482@virtualbox>
References: <20171031003351.22341-1-sbeller@google.com> <20171031211852.13001-1-sbeller@google.com> <20171031211852.13001-3-sbeller@google.com> <xmqqr2tiveqp.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.21.1.1711011316590.6482@virtualbox>
 <CAPc5daWpUMOCYyK=S8JiAV5DHF6BYDff8wH0N6QDeR=nvOXnLA@mail.gmail.com> <alpine.DEB.2.21.1.1711012235070.6482@virtualbox> <20171101213911.aokzrnchr6s2r2uq@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:7EJvA3swjGv3meP3H4oFDMS1/GAKRSgSbvS+eCLMNQMhDW+Vcfu
 qFugSitoqPzBE8ysLY30CRfEmqkJMn7iAdZY63/xLTO+t3xgQTFEmip8l7ZCGUcRHl3VsvD
 U/D7jafVUyRhWO8UnHjt/gp9mdnDj2sVtF8yAkP/Hv9J2E2IU/LlBCsxFoxZ9Jo1JHtkjzX
 QyJ6FDphXlhp5s3kKy50w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:SLxECaQ0hy8=:gBNDwJYdjHhKwnB+qtF0LJ
 lmd4tU83k8ASWnSns+1HSA4zkBQZYNjMEfFPKCtC+eFqaba1aWu72rQ6wn09ycJj6Y2+8tUxo
 YguwUGDnEJfz9fAkdgoUbc7BTSB+KZPlB5x8aM7PllzH5stkc1EMUMsqba4Xk7eKGSA5JFGDV
 cAcaYwU1B+cN6nYpOp0pHoQ8L+qPRvq36fOj6TC4Aw5iKs97NaAYLLqBWpRDhX3jkOx8lod+G
 BicFW/h4FrrYrIB8+gCi4w0RmlvnDqv3ErwysNTnzJfwO+vl2iC/7mLPn+Aaw/HSYm8YPGZDY
 0yNgyBJ6EcU9eZKfkSvKO7orZvvt0ZFaN8OcnGzevscbEWPNr7vSoRmp8KuacJ4bjyOb/H1Mg
 NZWXlpYGvokcDa45sCvNBhCTq4Z0sajbTDuoxGmyf1oWDOr6tdNlmJOi5A2LR6zbP0YLGGoJk
 tSWxAXUsWpJIzuTvjnGEGTny3UgZbARgzb10UN0pKAVVzCoPOTsxRwXmiSkFrHOp/spgBAeUz
 myN5UVJH4B6ikyOkZNGVULs+aAQByethPW0OUrGA/e4X9KEpz55D1ePq9lmLnA3KXImv+k5rR
 rVVaho0WBB/7bYdkPPd2Tj7KDE1ZZXi5QzFvvCwB9GhAE5xfsGctwYpGIGxukEa17GNbTcu9V
 ehFd//kFkJhqVKtWV5dyKOKWI+ShZCqSQsumaDvIFm7j064cGcioeBYZOXi1YRWyWQp478YAp
 0aTSkAMHfEOObGNes+UKrTKHNlsfvG1OxcfgCF97bFhukdCN+pkU46hYau9E7hZbfmh+YuJIa
 aC8XKQpIjrY3ViKgrxeQ9ocRKQwOVWyJHFQdVpn3GkC3qwr7pQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, 1 Nov 2017, Jeff King wrote:

> On Wed, Nov 01, 2017 at 10:36:02PM +0100, Johannes Schindelin wrote:
> 
> > On Wed, 1 Nov 2017, Junio C Hamano wrote:
> > 
> > > On Wed, Nov 1, 2017 at 9:26 PM, Johannes Schindelin
> > > <Johannes.Schindelin@gmx.de> wrote:
> > > >
> > > >         ...
> > > >         (
> > > >                 for x in four three
> > > >                 do
> > > >                         git rm $x &&
> > > >                         git commit -m "remote $x" ||
> > > >                         exit
> > > >                 done
> > > >         ) &&
> > > >         test 0 -eq $? &&
> > > >         ...
> > > >
> > > > Ugly? Yes. Correct? Also yes.
> > > 
> > > I think returning non-zero with "return" is how other tests avoid an
> > > extra level of subshell.
> > > Ugly? Yes. Correct? Questionable but it seems to work for those who
> > > wrote them ;-)
> > 
> > Given that the test_expect_* functions evaluate the code, it makes me
> > wonder whether those `return` statements really return appropriately, or
> > one call level too low.
> 
> The test_expect functions eval the actual snippets inside a dummy
> function. This is intentional exactly to allow them to call "return" at
> will.

Tricksy. And a bit unintuitive for script kings such as myself, but okay.

Ciao,
Dscho

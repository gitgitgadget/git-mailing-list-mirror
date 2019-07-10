Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 338B41F461
	for <e@80x24.org>; Wed, 10 Jul 2019 12:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbfGJMpC convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 10 Jul 2019 08:45:02 -0400
Received: from elephants.elehost.com ([216.66.27.132]:19581 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbfGJMpC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jul 2019 08:45:02 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x6ACirWS070528
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 10 Jul 2019 08:44:54 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Jeff King'" <peff@peff.net>
Cc:     <git@vger.kernel.org>
References: <009201d5369f$4da5d030$e8f17090$@nexbridge.com> <20190709215104.GA20936@sigill.intra.peff.net>
In-Reply-To: <20190709215104.GA20936@sigill.intra.peff.net>
Subject: RE: [Question] Diff text filters and git add
Date:   Wed, 10 Jul 2019 08:44:47 -0400
Message-ID: <00bb01d5371d$453a8520$cfaf8f60$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQHttJq7PJjjxbadXK1CWI2lF6jgrgDnky5VpouUXFA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On July 9, 2019 5:51 PM, Peff wrote:
> To: Randall S. Becker <rsbecker@nexbridge.com>
> Cc: git@vger.kernel.org
> Subject: Re: [Question] Diff text filters and git add
> 
> On Tue, Jul 09, 2019 at 05:43:05PM -0400, Randall S. Becker wrote:
> 
> > I am trying to do something a bit strange and wonder about the best
> > way to go. I have a text filter that presents content of very special
> > binary file formats using textconv. What I am wondering is whether
> > using the textconv mechanism is sufficient to have git calculate the
> > file signature or whether I need to use an external diff engine, so
> > that git add behaves in a stable manner (i.e., does git internally use
> > the textconv mechanism for evaluating whether a file changed or
> > whether the external diff engine is required, or whether this is even
> possible at all).
> 
> No, textconv only applies when generating a diff to output, and will never
> impact what's stored in Git.
> 
> It sounds like you might want a clean filter instead, to sanitize the file
> contents as they come into Git (and perhaps a matching smudge filter to
> convert back to the working-tree version if necessary).
> 
> You're talking about "the diff engine" here, but note that git-add would never
> do a diff at all. It cares only about full sha1s (and optimizes out re-computing
> the sha1 on each invocation by using stat data). So outside of clean/smudge,
> there's nothing else going on.

Thanks. I can script this instead. Will do an external diff then --assume-unchanged when I detect an equivalence.

Appreciate the advice and info,
Randall


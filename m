Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A0E11F731
	for <e@80x24.org>; Tue,  6 Aug 2019 17:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728836AbfHFR6z convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 6 Aug 2019 13:58:55 -0400
Received: from elephants.elehost.com ([216.66.27.132]:51687 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfHFR6z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Aug 2019 13:58:55 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x76HwnRC003937
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 6 Aug 2019 13:58:50 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Jeff King'" <peff@peff.net>
Cc:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
References: <20190806143829.GA515@sigill.intra.peff.net> <xmqqa7cml0s9.fsf@gitster-ct.c.googlers.com> <000f01d54c75$1a8fe460$4fafad20$@nexbridge.com> <20190806173817.GB4961@sigill.intra.peff.net>
In-Reply-To: <20190806173817.GB4961@sigill.intra.peff.net>
Subject: RE: [PATCH 0/3] --end-of-options marker
Date:   Tue, 6 Aug 2019 13:58:43 -0400
Message-ID: <001401d54c80$991cbd20$cb563760$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIxP74lDdV6XvID81wkSsuwoAdCfwH5VWUSAzOtFCQBn/zMt6YAGZkg
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On August 6, 2019 1:38 PM, Jeff King wrote:
> To: Randall S. Becker <rsbecker@nexbridge.com>
> Cc: 'Junio C Hamano' <gitster@pobox.com>; git@vger.kernel.org
> Subject: Re: [PATCH 0/3] --end-of-options marker
> 
> On Tue, Aug 06, 2019 at 12:36:26PM -0400, Randall S. Becker wrote:
> 
> > > > This series provides an alternative to "--" to stop option parsing
> > > > without indicating that further arguments are pathspecs.
> >
> > Would this offer the opportunity to, in the long term, supply options
> > to external diff engines, for example?
> >
> > Something like git diff --end-of-options --diff-opt1 --diff-opt2 -- a
> > b
> 
> I'd expect that to interpret "--diff-opt1" and "--diff-opt2" as non-option
> arguments, which in the context of git-diff means endpoints of the diff.
> 
> So no, I don't think you can use it like you're asking here.
> 
> > I'm just noodling here, wondering why otherwise
> >
> > git rev-list --max-parents=4  -- --count docs/
> >
> > does not work. I thought -- was pretty specific in terms of turning
> > off interpretation. So is it not a defect that --count is being interpreted?
> 
> The command-line above means that "--count" is interpreted
> (unambiguously) as a path. The problem is that if you want it to be
> interpreted as a starting point for traversal, then it must come _before_ the
> "--".
> 
> > I have a fear for all my sub-teams who script with the assumption that
> > -- has a specific meaning of stopping interpretation.
> 
> Nothing about "--" is changed by my series; it will still stop option
> interpretation in rev-list and in other commands. But as before, rev-list (and
> other Git commands that use the revision.c parser) use it to separate
> revisions and pathspecs.  That's unlike how most other programs use "--", but
> that ship sailed for Git in 2005.

Thanks for the explanation.

Randall


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72D912042F
	for <e@80x24.org>; Wed, 16 Nov 2016 14:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932724AbcKPO1B (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Nov 2016 09:27:01 -0500
Received: from smtprelay06.ispgateway.de ([80.67.31.102]:48965 "EHLO
        smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932184AbcKPO1A (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2016 09:27:00 -0500
Received: from [84.46.92.130] (helo=book.hvoigt.net)
        by smtprelay06.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.84)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1c71Ap-0003LJ-NH; Wed, 16 Nov 2016 15:26:51 +0100
Date:   Wed, 16 Nov 2016 15:26:49 +0100
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Jens Lehmann <Jens.Lehmann@web.de>,
        Fredrik Gustafsson <iveqy@iveqy.com>,
        Leandro Lucarella <leandro.lucarella@sociomantic.com>
Subject: Re: [PATCH v3 4/4] submodule_needs_pushing() NEEDSWORK when we can
 not answer this question
Message-ID: <20161116142649.GA32087@book.hvoigt.net>
References: <cover.1479221071.git.hvoigt@hvoigt.net>
 <1d87628994df89751afdcc7e180ebcdc29dde722.1479221071.git.hvoigt@hvoigt.net>
 <CAGZ79kYyyjP7W7gWq6WomVSkhRtMbZZMKYQPFszko4_f9oprgg@mail.gmail.com>
 <xmqqtwb8s2m8.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtwb8s2m8.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 15, 2016 at 04:13:51PM -0800, Junio C Hamano wrote:
> Stefan Beller <sbeller@google.com> writes:
> 
> >> "We do not know" ...
> >
> > ... because there is no way to check for us as we don't have the
> > submodule commits.
> >
> >     " We do consider it safe as no one in their sane mind would
> >     have changed the submodule pointers without having the
> >     submodule around. If a user did however change the submodules
> >     without having the submodule commits around, this indicates an
> >     expert who knows what they were doing."
> 
> I didn't think it through myself to arrive at such a conclusion, but
> to me the above sounds like a sensible reasoning [*1*].

I think you have a point here. If I rephrase it like this: "We do
consider it safe as no one in their sane mind *could* have changed the
submodule pointers without having the submodule around..."

Since its actually hard to create such a situation without the submodule
commit around I agree here.

> *1* My version was more like "we do not know if they would get into
>     a situation where they do not have enough submodule commits if
>     we pushed our superproject, but more importantly, we DO KNOW
>     that it would not help an iota if we pushed our submodule to
>     them, so there is no point stopping the push of superproject
>     saying 'no, no, no, you must push the submodule first'".

Yes saying that would be wrong. I was rather suggesting that we tell the
user that we could not find the submodule commits to and that if he
wants to proceed he should either pass --recurse-submodules=no or
initialize the submodule.

But I think the above reasoning obsoletes my suggestion. I would adjust
the comment accordingly but still keep the patch so we have
documentation that this behavior is on purpose.

Cheers Heiko

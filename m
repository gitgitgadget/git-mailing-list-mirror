Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 440B11F97E
	for <e@80x24.org>; Sun,  7 Oct 2018 05:21:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbeJGM1c (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Oct 2018 08:27:32 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:23136
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726310AbeJGM1c (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 7 Oct 2018 08:27:32 -0400
X-IronPort-AV: E=Sophos;i="5.54,351,1534802400"; 
   d="scan'208";a="281263525"
Received: from 89-157-201-244.rev.numericable.fr (HELO hadrien) ([89.157.201.244])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Oct 2018 07:21:26 +0200
Date:   Sun, 7 Oct 2018 07:21:26 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: git log -S or -G
In-Reply-To: <xmqqd0smvay0.fsf@gitster-ct.c.googlers.com>
Message-ID: <alpine.DEB.2.21.1810070719200.2347@hadrien>
References: <alpine.DEB.2.21.1810061712260.2402@hadrien> <CACBZZX6PmG=-8563eYE4z98yvHePenZf_Kz1xgpse0ngjB5QyA@mail.gmail.com> <xmqqd0smvay0.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-587054967-1538889686=:2347"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-587054967-1538889686=:2347
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Sun, 7 Oct 2018, Junio C Hamano wrote:

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>
> > On Sat, Oct 6, 2018 at 5:16 PM Julia Lawall <julia.lawall@lip6.fr> wrote:
> >> Git log -S or -G make it possible to find commits that have particular
> >> words in the changed lines.  Sometimes it would be helpful to search for
> >> words in the removed lines or in the added lines specifically.  From the
> >> implementation, I had the impression that this would be easy to implement.
> >> The main question would be how to allow the user to specify what is
> >> wanted.
> >
> > As far as I know this isn't possible. The --diff-filter option is
> > similar in spirit, but e.g. adding "foo" and then removing it from an
> > existing file will both be covered under --diff-filter=M, so that
> > isn't what you're looking for.
>
> I agree with Julia that UI to the feature is harder than the
> machinery to implement the feature to add "I am interested in seeing
> a patch that contains a hunk that adds 'foo' but am not interested
> in removal" (or vice versa) for -G.  You tweak
> diffcore-pickaxe.c::diffgrep_consume() and you'are done.
>
> Doing the same for -S is much harder at the machinery level, as it
> performs its thing without internally running "diff" twice, but just
> counts the number of occurrences of 'foo'---that is sufficient for
> its intended use, and more efficient.

There is still the question of whether the number of occurrences of foo
decreases or increases.

julia
--8323329-587054967-1538889686=:2347--

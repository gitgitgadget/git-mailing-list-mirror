Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 561D9203E1
	for <e@80x24.org>; Tue, 26 Jul 2016 11:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753306AbcGZLTT (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 07:19:19 -0400
Received: from mta01.prd.rdg.aluminati.org ([94.76.243.214]:51596 "EHLO
	mta01.prd.rdg.aluminati.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751261AbcGZLTR convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 07:19:17 -0400
Received: from mta01.prd.rdg.aluminati.org (localhost [127.0.0.1])
	by mta.aluminati.local (Postfix) with ESMTP id B2EDDC0433;
	Tue, 26 Jul 2016 12:19:15 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by mta01.prd.rdg.aluminati.org (Postfix) with ESMTP id AD03A20B89;
	Tue, 26 Jul 2016 12:19:15 +0100 (BST)
X-Quarantine-ID: <h4mGZzXUChVz>
X-Virus-Scanned: Debian amavisd-new at mta01.prd.rdg.aluminati.org
Received: from mta.aluminati.local ([127.0.0.1])
	by localhost (mta01.prd.rdg.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id h4mGZzXUChVz; Tue, 26 Jul 2016 12:19:14 +0100 (BST)
Received: from john.keeping.me.uk (unknown [10.2.0.10])
	by mta01.prd.rdg.aluminati.org (Postfix) with ESMTPSA id D0C756220B;
	Tue, 26 Jul 2016 12:19:11 +0100 (BST)
Date:	Tue, 26 Jul 2016 12:19:11 +0100
From:	John Keeping <john@keeping.me.uk>
To:	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Cc:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 2/3] push: add shorthand for --force-with-lease branch
 creation
Message-ID: <20160726111911.cehaitav4enas7dm@john.keeping.me.uk>
References: <cover.1469483499.git.john@keeping.me.uk>
 <4e07ff23715b53fcd29564be1c74a9f66dd74e1e.1469483499.git.john@keeping.me.uk>
 <57973BAD.2020607@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <57973BAD.2020607@gmail.com>
User-Agent: Mutt/1.6.2 (2016-06-11)
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jul 26, 2016 at 12:30:05PM +0200, Jakub Narębski wrote:
> W dniu 2016-07-25 o 23:59, John Keeping pisze:
> 
> > +test_expect_success 'new branch covered by force-with-lease (explicit)' '
> > +	setup_srcdst_basic &&
> > +	(
> > +		cd dst &&
> > +		git branch branch master &&
> > +		git push --force-with-lease=branch: origin branch
> > +	) &&
> > +	git ls-remote dst refs/heads/branch >expect &&
> > +	git ls-remote src refs/heads/branch >actual &&
> > +	test_cmp expect actual
> > +'
> 
> Do we need to test the negative, that is that if branch is not
> new it prevents push (e.g. when <branch> is HEAD), or is it
> covered by other tests?

It's covered by a test in patch 3 (at least for the implicit case added
there), but I could pull that forwards.  In fact, converting that test
to the explicit syntax will make it simpler since we won't need to set
up a non-fast-forward push.

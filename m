Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE5151F462
	for <e@80x24.org>; Tue, 11 Jun 2019 16:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390534AbfFKQtQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jun 2019 12:49:16 -0400
Received: from resqmta-po-05v.sys.comcast.net ([96.114.154.164]:49584 "EHLO
        resqmta-po-05v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387814AbfFKQtP (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 11 Jun 2019 12:49:15 -0400
Received: from resomta-po-01v.sys.comcast.net ([96.114.154.225])
        by resqmta-po-05v.sys.comcast.net with ESMTP
        id ahMDhJDyJOaJ5ajxTh5e47; Tue, 11 Jun 2019 16:49:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=20190202a; t=1560271755;
        bh=Bmw+7mq0t53eu9K5h0uyfGY8/3GUySQbxP9fg4yEtPA=;
        h=Received:Received:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=CZMOZjwSBceJ3hbudbLrWvaEUcURozRsmfB5KnMdKis5hT3anCFeQXC+SpN2vxGUs
         X7bDvBMULa23YC56orcL+60DVVEVbQsaVG+hcj0CB4kCaVyFaIm4CEVMj477D4sKLS
         M3ikmEMZRQ3d732gGJVUBkXZv3oeP/+eZFcEhQYiQoOrF/Pqm48CKBoT09UdvLfWMh
         NrB7x6yxPCmsTxFMvyTzL4PfrHv8xAkcoc6bKr40Xutu9+iBpzg025DYnGecrgGTmk
         7X5X1oomf43Ce6o6rTUPkncI5kTMqSV4fvf/WWAmRl3OPP9qyzU9Wd7psm22cCgaXc
         EWnjlfzhz9cmg==
Received: from comcast.net ([IPv6:2620:15c:2ce:200:8dc5:35e2:73b6:2c5e])
        by resomta-po-01v.sys.comcast.net with ESMTPSA
        id ajwohPwDhlRViajwxhztwM; Tue, 11 Jun 2019 16:49:12 +0000
X-Xfinity-VMeta: sc=-100;st=legit
Date:   Tue, 11 Jun 2019 09:48:34 -0700
From:   Matthew DeVore <matvore@comcast.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Matthew DeVore <matvore@google.com>, git@vger.kernel.org,
        avarab@gmail.com, git@matthieu-moy.fr, olyatelezhnaya@gmail.com,
        samuel.maftoul@gmail.com, gitster@pobox.com, karthik.188@gmail.com,
        pclouds@gmail.com, sunshine@sunshineco.com, emilyshaffer@google.com
Subject: Re: [RFC PATCH] ref-filter: sort detached HEAD lines firstly
Message-ID: <20190611164834.GA58112@comcast.net>
References: <faaa9a3d6ba66d77cc2a8eab438d1bfc8f762fa1.1559857032.git.matvore@google.com>
 <nycvar.QRO.7.76.6.1906090954510.789@QRFXGBC-DHN364S.ybpnyqbznva>
 <20190610234918.GA10396@comcast.net>
 <20190611004106.GB64137@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611004106.GB64137@google.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 10, 2019 at 05:41:06PM -0700, Jonathan Nieder wrote:
> Git seems to be inconsistent about this.  Documentation/CodingGuidelines
> says
> 
>         - When there are multiple arms to a conditional and some of them
>           require braces, enclose even a single line block in braces for
>           consistency. E.g.:
> 
> so you have some cover from there (and it matches what I'm used to,
> too). :)

Thanks for finding that.

> 
> [...]
> >>> +	LC_ALL=$zh_CN_locale LC_MESSAGES=$zh_CN_locale \
> >>> +		git -C r1 branch >actual &&
> >>> +	git -C r1 checkout - &&
> >>
> >> Why call `checkout` after `branch`? That's unnecessary, we do not verify
> >> anything after that call.
> >
> > It's to get the repo into a neutral state in case an additional testcase is
> > added in the future.
> 
> For this kind of thing, we tend to use test_when_finished so that the
> test ends up in a clean state even if it fails.

Done. That will be used in the next roll-up.

> > 	head -n 1 actual >first &&
> > 	# The first line should be enclosed by full-width parenthesis.
> > 	grep '$'\xef\xbc\x88.*\xef\xbc\x89'' first &&
> 
> nit: older shells do not know how to do $'\x01' interpolation.
> Probably best to use the raw UTF-8 directly here (it will be more
> readable anyway).

Good point. I suppose we don't have to worry about dev's editors screwing up
encoding since modern editors make this kind of thing easy to configure (and I
suspect that all sane editors use UTF-8 as the default or at least won't mangle
it...)

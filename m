Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 382A71F597
	for <e@80x24.org>; Wed, 18 Jul 2018 10:36:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731008AbeGRLNy (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 07:13:54 -0400
Received: from thoth.sbs.de ([192.35.17.2]:33189 "EHLO thoth.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728304AbeGRLNx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 07:13:53 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id w6IAaF47007137
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jul 2018 12:36:15 +0200
Received: from md1pvb1c.ad001.siemens.net (md1pvb1c.ad001.siemens.net [139.25.68.40])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id w6IAaFCH006376;
        Wed, 18 Jul 2018 12:36:15 +0200
Date:   Wed, 18 Jul 2018 12:36:14 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     <git@vger.kernel.org>, Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?UTF-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Ben Toews <mastahyeti@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v4 2/7] t/t7510: check the validation of the new config
 gpg.format
Message-ID: <20180718123614.1807a948@md1pvb1c.ad001.siemens.net>
In-Reply-To: <xmqq7eltmtv7.fsf@gitster-ct.c.googlers.com>
References: <cover.1531831244.git.henning.schild@siemens.com>
 <cover.1531831244.git.henning.schild@siemens.com>
 <2f806c4fa4454af59344f0f0e77d1ae8048aa841.1531831244.git.henning.schild@siemens.com>
 <xmqq7eltmtv7.fsf@gitster-ct.c.googlers.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am Tue, 17 Jul 2018 14:31:56 -0700
schrieb Junio C Hamano <gitster@pobox.com>:

> Henning Schild <henning.schild@siemens.com> writes:
> 
> > Test setting gpg.format to both invalid and valid values.
> >
> > Signed-off-by: Henning Schild <henning.schild@siemens.com>
> > ---
> >  t/t7510-signed-commit.sh | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
> > index 6e2015ed9..7bdad570c 100755
> > --- a/t/t7510-signed-commit.sh
> > +++ b/t/t7510-signed-commit.sh
> > @@ -227,4 +227,13 @@ test_expect_success GPG 'log.showsignature
> > behaves like --show-signature' ' grep "gpg: Good signature" actual
> >  '
> >  
> > +test_expect_success GPG 'check config gpg.format values' '
> > +	test_config gpg.format openpgp &&
> > +	git commit -S --amend -m "success" &&
> > +	test_config gpg.format OpEnPgP &&
> > +	test_must_fail git commit -S --amend -m "fail" &&  
> 
> This second one is a good demonstration that the value for this
> variable is case sensitive.
> 
> > +	test_config gpg.format malformed &&
> > +	test_must_fail git commit -S --amend -m "fail"  
> 
> And there is no longer a good reason to try another one.  Let's drop
> this last/third case.

Done.

Henning

> > +'
> > +
> >  test_done  


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEAF01F407
	for <e@80x24.org>; Wed, 13 Dec 2017 14:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753011AbdLMOYp (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Dec 2017 09:24:45 -0500
Received: from washoe.dartmouth.edu ([129.170.30.229]:35220 "EHLO
        smtp.onerussian.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753353AbdLMOXn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Dec 2017 09:23:43 -0500
Received: from [10.31.190.253] (helo=localhost)
        by smtp.onerussian.com with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <yoh@onerussian.com>)
        id 1eP7wi-0008Ev-EM; Wed, 13 Dec 2017 09:23:41 -0500
Date:   Wed, 13 Dec 2017 09:23:34 -0500
From:   Yaroslav Halchenko <yoh@onerussian.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Message-ID: <20171213142334.oy2uvkamho4whspj@hopa.kiewit.dartmouth.edu>
References: <1513077862-165-1-git-send-email-jacob.keller@gmail.com>
 <xmqqo9n320ep.fsf@gitster.mtv.corp.google.com>
 <CA+P7+xqR0C_Z5fJFdSBvzqCT=LU-mK0cdtaqJ=6TH5Ty60PQrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+P7+xqR0C_Z5fJFdSBvzqCT=LU-mK0cdtaqJ=6TH5Ty60PQrg@mail.gmail.com>
X-URL:  http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: C5B9 05F0 E8D9 FD96 68FF  366F A2DE 2350 62DA 33FA
User-Agent: NeoMutt/20170609 (1.8.3)
X-SA-Exim-Connect-IP: 10.31.190.253
X-SA-Exim-Rcpt-To: jacob.keller@gmail.com, gitster@pobox.com, git@vger.kernel.org
X-SA-Exim-Mail-From: yoh@onerussian.com
Subject: Re: [PATCH] doc: clarify usage of XDG_CONFIG_HOME config file
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:57:07 +0000)
X-SA-Exim-Scanned: Yes (on smtp.onerussian.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, 12 Dec 2017, Jacob Keller wrote:

> > And then "and the other files will not be read" can be dropped from
> > the first sentence of this paragraph?

> > Yaroslav on the original thread mentioned that reading codepath
> > without --file or --global does not limit to one of the three, and
> > this section is about "If not set explicitly with `--file`", so we'd
> > need to make sure if the above is what happens in reality (or update
> > the proposed clarification to match the reality).

> I'm pretty sure it does not read XDG_CONFIG_HOME unless ~/.gitconfig
> is missing. I tried a few things, but it was 2am for me, so I may be
> mis-remembering.

It always read it for non--global

$> ( HOME=/tmp/HOME; rm -rf $HOME; mkdir -p $HOME/.config/git; echo -e "[user]\n name=home" > $HOME/.gitconfig; echo -e "[user]\n name=xdg\n name2=xdg2" > $HOME/.config/git/config; git config user.name; git config user.name2; )     
home
xdg2

and it doesn't read it for --global

$> ( HOME=/tmp/HOME; rm -rf $HOME; mkdir -p $HOME/.config/git; echo -e "[user]\n name=home" > $HOME/.gitconfig; echo -e "[user]\n name=xdg\n name2=xdg2" > $HOME/.config/git/config; git config --global user.name; git config --global user.name2; )                                                                    
home

unless ~/.gitconfig is missing

$> ( HOME=/tmp/HOME; rm -rf $HOME; mkdir -p $HOME/.config/git; echo -e "[user]\n name=xdg\n name2=xdg2" > $HOME/.config/git/config; git config --global user.name; git config --global user.name2; )         
xdg                                                            
xdg2


-- 
Yaroslav O. Halchenko
Center for Open Neuroscience     http://centerforopenneuroscience.org
Dartmouth College, 419 Moore Hall, Hinman Box 6207, Hanover, NH 03755
Phone: +1 (603) 646-9834                       Fax: +1 (603) 646-1419
WWW:   http://www.linkedin.com/in/yarik        

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 431601F597
	for <e@80x24.org>; Tue, 17 Jul 2018 12:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731392AbeGQNXA (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 09:23:00 -0400
Received: from lizzard.sbs.de ([194.138.37.39]:55214 "EHLO lizzard.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731198AbeGQNW6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 09:22:58 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id w6HCo3ca028548
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jul 2018 14:50:03 +0200
Received: from md1pvb1c.ad001.siemens.net (md1pvb1c.ad001.siemens.net [139.25.68.40])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id w6HCo3s7008734;
        Tue, 17 Jul 2018 14:50:03 +0200
Date:   Tue, 17 Jul 2018 14:50:02 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     <git@vger.kernel.org>, Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?UTF-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Ben Toews <mastahyeti@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 5/7] gpg-interface: introduce new config to select
 per gpg format program
Message-ID: <20180717145002.2623286d@md1pvb1c.ad001.siemens.net>
In-Reply-To: <xmqqva9esydn.fsf@gitster-ct.c.googlers.com>
References: <cover.1531470729.git.henning.schild@siemens.com>
 <cover.1531470729.git.henning.schild@siemens.com>
 <8e6f4f547475e3ce26799901e255a78ea74dac8e.1531470729.git.henning.schild@siemens.com>
 <xmqqva9esydn.fsf@gitster-ct.c.googlers.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am Mon, 16 Jul 2018 13:45:40 -0700
schrieb Junio C Hamano <gitster@pobox.com>:

> Henning Schild <henning.schild@siemens.com> writes:
> 
> > +gpg.<format>.program::
> > +	Use this to customize the program used for the signing
> > format you
> > +	chose. (see gpg.program) gpg.openpgp.program is a synonym
> > for the
> > +	legacy gpg.program.  
> 
> I _think_ you meant "see gpg.format", but I am not 100% sure.

No i actually meant program, the next version just refers to both
config options for further reading.

> When X is a synonym for Y, Y is also a synonym for X, so technically
> speaking this does not matter, but when we talk about backward
> compatibility fallback, I think we say "OLDway is retained as a
> legacy synonym for NEWway", i.e. the other way around.
> 
> Also, `typeset in tt` what end-users would type literally, like
> configuration variable names, i.e.
> 
> 	Use this to customize the rpogram used for the signing
> 	format you chose (see `gpg.format`).  `gpg.program` can
> 	still be used as a legacy synonym for `gpg.openpgp.program`.

Used that second sentence.

Henning

> >  gui.commitMsgWidth::
> >  	Defines how wide the commit message window is in the
> >  	linkgit:git-gui[1]. "75" is the default.
> > diff --git a/gpg-interface.c b/gpg-interface.c
> > index 93bd0fb32..f3c22b551 100644
> > --- a/gpg-interface.c
> > +++ b/gpg-interface.c
> > @@ -182,7 +182,7 @@ int git_gpg_config(const char *var, const char
> > *value, void *cb) return 0;
> >  	}
> >  
> > -	if (!strcmp(var, "gpg.program"))
> > +	if (!strcmp(var, "gpg.program") || !strcmp(var,
> > "gpg.openpgp.program")) fmtname = "openpgp";
> >  
> >  	if (fmtname) {  


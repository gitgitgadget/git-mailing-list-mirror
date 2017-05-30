Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A2CD20D0A
	for <e@80x24.org>; Tue, 30 May 2017 04:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750951AbdE3E5g (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 00:57:36 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35633 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750911AbdE3E5f (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 00:57:35 -0400
Received: by mail-pf0-f194.google.com with SMTP id u26so15237780pfd.2
        for <git@vger.kernel.org>; Mon, 29 May 2017 21:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=8LnTx4r0SzXZJAx5oFgy2NJCcPvjHI1tRvmb/skn3VE=;
        b=B3hx1YsHRh0DKt/rRPDD0J68XqCyyrOt52xgXNGpZjOBhQpxTXW/Vl+60o5UPkXNxp
         760TPwiOe2oLeYnGUISaZk2l3jGeVtsLOVv3vKyTt1sGQMAO6/V54rMxjx4h8ILSINWD
         O/tL5yh9hQJ8ruonoBM/HL3a5NELjqkXCJgkG+0fk5bASuez8tueqEhznsd7iMp7inWS
         30U925agB/Yaxi1WOazVDuzlKJFcgrCbswZM4mbmeEAXBsr0oqRaCh4yNVeEMPOSAWQy
         aVqWz3xdphjU+hv5ppWryz8HDtN4Dju6bbhNtrU/3Xy/E5ZiwqPztMrxaRxbg2sJ0rs3
         SaLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=8LnTx4r0SzXZJAx5oFgy2NJCcPvjHI1tRvmb/skn3VE=;
        b=Q0fCIxgIExM4WgrKXHOoPLLicfpdQbplKmB/1UIcPeSs3u/dgwmXg7wZj5W2G3rZxO
         gdhIRqbcjaTD3VrwDbRv3leUEwZ2gnEXF+DGEyS+eXPc5S0ud001Pk3b/LA8nhVeNR8n
         BI3eI2xYE5wMPHpdxtOcSf5CPJZrcyMfzNIat3bS8iw0GDrOhd5Y+Obplh8/gjnz49+V
         WxNdvrerjRmCvEUeEzhlZGI9WBdDau7wxVyGVJsIstoHU/+z0ViZ+gU+R5MoYJGYM6Ma
         2569Xdb7O740azv+Ad9HfIf6/8BFONez1aVPFmLRKoVazHHtAEyofSbMB4EqdFOWHGAD
         kO7A==
X-Gm-Message-State: AODbwcC6mISo/46y7bmMStSXLZkPhjSa6fJz3e+L6gJhj3T0br7J9/px
        7YWN+NXQKxgdWQ==
X-Received: by 10.98.192.134 with SMTP id g6mr21330584pfk.26.1496120255183;
        Mon, 29 May 2017 21:57:35 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:f830:fc5f:a16b:f475])
        by smtp.gmail.com with ESMTPSA id f1sm13041765pgc.8.2017.05.29.21.57.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 29 May 2017 21:57:34 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v4 02/10] rebase -i: generate the script via rebase--helper
References: <cover.1493207864.git.johannes.schindelin@gmx.de>
        <cover.1493414945.git.johannes.schindelin@gmx.de>
        <e173445d9a6321f80053967e50375400c0a61764.1493414945.git.johannes.schindelin@gmx.de>
        <xmqq60gk8ad5.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1705291252080.3610@virtualbox>
Date:   Tue, 30 May 2017 13:57:33 +0900
In-Reply-To: <alpine.DEB.2.21.1.1705291252080.3610@virtualbox> (Johannes
        Schindelin's message of "Mon, 29 May 2017 12:54:01 +0200 (CEST)")
Message-ID: <xmqqfufnc56q.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Mon, 29 May 2017, Junio C Hamano wrote:
>
>> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>> 
>> > diff --git a/sequencer.c b/sequencer.c
>> > index 130cc868e51..88819a1a2a9 100644
>> > --- a/sequencer.c
>> > +++ b/sequencer.c
>> > @@ -2388,3 +2388,52 @@ void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag)
>> >  
>> >  	strbuf_release(&sob);
>> >  }
>> > +
>> > +int sequencer_make_script(int keep_empty, FILE *out,
>> > +		int argc, const char **argv)
>> > +{
>> > +	char *format = NULL;
>> > +	struct pretty_print_context pp = {0};
>> > +	struct strbuf buf = STRBUF_INIT;
>> > +	struct rev_info revs;
>> > +	struct commit *commit;
>> > +
>> > +	init_revisions(&revs, NULL);
>> > +	revs.verbose_header = 1;
>> > +	revs.max_parents = 1;
>> > +	revs.cherry_pick = 1;
>> > +	revs.limited = 1;
>> > +	revs.reverse = 1;
>> > +	revs.right_only = 1;
>> > +	revs.sort_order = REV_SORT_IN_GRAPH_ORDER;
>> > +	revs.topo_order = 1;
>> 
>> cf. <xmqq4lx5i83q.fsf@gitster.mtv.corp.google.com>
>> 
>> This is still futzing below the API implementation detail
>> unnecessarily.
>
> You still ask me to pass options in plain text that has to be parsed at
> run-time, rather than compile-time-verifiable flags.

Absolutely.  

We do not want these implementation details to code that does not
implement command line parsing.  This one is not parsing anybody's
set of options and should not be mucking with the low level
implementation details.

See 66b2ed09 ("Fix "log" family not to be too agressive about
showing notes", 2010-01-20) and poinder.  Back then, nobody outside
builtin/log.c and revision.c (these are the two primary things that
implement command line parsing; "log.c" needs access to the low
level details because it wants to establish custom default that is
applied before it reads options given by the end-user) mucked
directly with verbose_header, which allowed the addition of
"pretty_given" to be limited only to these places that actually do
the parsing.  If the above patch to sequencer.c existed before
66b2ed09, it would have required unnecessary change to tweak
"pretty_given" in there too when 66b2ed09 was done.  That is forcing
a totally unnecesary work.  And there is no reason to expect that
the kind of change 66b2ed09 made to the general command line parsing
will not happen in the future.  Adding more code like the above that
knows the implementation detail is unwarranted, when you can just
ask the existing command line parser to set them for you.


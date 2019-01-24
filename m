Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B989B1F453
	for <e@80x24.org>; Thu, 24 Jan 2019 01:12:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfAXBMs (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 20:12:48 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46017 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbfAXBMs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 20:12:48 -0500
Received: by mail-pg1-f195.google.com with SMTP id y4so1873026pgc.12
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 17:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GYx9MOqwSF9/iiuMbfhJCkdqRf4OIEhs8n3H25r3dMA=;
        b=dA88Ud5xVu1P6/zV3YlX4SaLzmyT/lG9rcmlXpz+ozimv8Lc/StSpGvFM8MZs94Igw
         KMYfoRAEV7QRicvtmZuDV5OIFzwj3uiOvME+CS5vbhdEjognqZ5tNgniJuj0goup6AJ8
         GloG7GbiVsmZzOH/PPXCLLUggwOHBLLG4H453tJsfO2R1McpXtZG9g2e2Vz7TpxgXoDQ
         4FIN1j9BPcpc8INyjsTrNKu0grWLC9A+QPLriTG8h0pGSCKKZiDSrYWXbqKptEQIUGQr
         G/yn4XkBC5TTZobgb6SfZQQ2xJ+Rvd5Nw3GQliY/k4YqzyfBbo90L4TPG57jm55XVrOo
         IdXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GYx9MOqwSF9/iiuMbfhJCkdqRf4OIEhs8n3H25r3dMA=;
        b=Zl6rz2gja7x+tBoYLOFZHzaztDnVjysTrZuryGPFItYQ9a0Q4josVru6ibxBKia+yt
         ULUPxAd7csMrSS1C95YpUCoAzPYa9AQijn0NebnlC8IbvPri6sH3hgQlRGD2fS96T5j3
         v1zcO0w3BCSWogJdTr4eA9tG0J3pojq4vY+p7xGR/r1zpsGw5B22NVAWICeJRnXaoCQo
         RXriPfU1f8Nig5Z8tvvmLj/8vRdg1SDHAN0vnNbwtaf4bYUd6LIe1TOU3MRbrXLwQG4J
         Xu9fB8EmcPobcPzghOX6K51WUnBFbv2ulsTEb4OMB4lXHWL73CTtE3M5RGnPBDWhpo4Y
         dIUg==
X-Gm-Message-State: AJcUukfxYNymRhN3XJ/C8Q/qdzKwCToqp+K+QF0mMObWckfs4aDzL1Vt
        ldKZFY4TpexN/4LV1RQTQzs=
X-Google-Smtp-Source: ALg8bN5KHB0LeeieJBnlW5Mywa3JSgXQn/V/9Usi+HhrBbulNPV4epajnjSn1mJ2dY+zky6Qu+snbQ==
X-Received: by 2002:a63:ee4c:: with SMTP id n12mr3986899pgk.21.1548292367118;
        Wed, 23 Jan 2019 17:12:47 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id r12sm20745390pgv.83.2019.01.23.17.12.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 17:12:46 -0800 (PST)
Date:   Wed, 23 Jan 2019 17:12:44 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 7/8] checkout: introduce --{,no-}overlay option
Message-ID: <20190124011244.GE34357@google.com>
References: <20181220134820.21810-1-t.gummerer@gmail.com>
 <20190108215225.3077-1-t.gummerer@gmail.com>
 <20190108215225.3077-8-t.gummerer@gmail.com>
 <20190122235313.GA199923@google.com>
 <20190123202156.GA11293@hank.intra.tgummerer.com>
 <xmqqzhrr9j52.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzhrr9j52.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
>> Jonathan Nieder wrote:

>>> Is this analogous to "git add --ignore-removal"?  If so, can we just
>>> call it --ignore-removal?
>>
>> Yes, it seems like they are very similar.
>
> Hmm, I am not sure if the word "removal" makes sense in the context
> of "checkout", as "removal" is an _action_ just like "checking out"
> itself is, and not a _state_.  You'd check out a state out of a tree
> to the index and the working tree, so "checking out absence of a
> path" may make sense, though, as "absence of a path" is a state
> recorded in that source tree object.

I find --ignore-removal fairly easy to understand, and I had no idea
what --overlay would mean.

I realize this is just one user's experience.  I'd be happy to do a
little informal survey (e.g. taking the description from the manpage
and asking people to name the option) if that's useful.

See also https://dl.acm.org/citation.cfm?id=32212 on this subject.

> The word "removal" makes little sense in "git add --ignore-removal",
> but it and "git add --no-all" outlived their usefulness already, so
> it may not be worth _fixing_ it.  But I am mildly opposed to spread
> the earlier mistake to a new option.

I think that's a good place to end up: once we flip the default for
checkout, then --ignore-removal would be an obscure option in that
command as well.  The consistency with "git add" is just a bonus.

Thanks,
Jonathan

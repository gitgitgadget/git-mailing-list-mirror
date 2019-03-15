Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8ABFF20248
	for <e@80x24.org>; Fri, 15 Mar 2019 22:33:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfCOWdY (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Mar 2019 18:33:24 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41652 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbfCOWdY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Mar 2019 18:33:24 -0400
Received: by mail-wr1-f68.google.com with SMTP id p1so11127838wrs.8
        for <git@vger.kernel.org>; Fri, 15 Mar 2019 15:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eA7KCJJvRseyljITo0qrKH90eTYVQOFKHcLj6kjsvwQ=;
        b=ANtAzfshNUViLPf3ZEBKGr7DM335X/uc5zUG1bqXkD3OS0xf3zMPRDqbUMe86eVdnW
         pZy5alDzCxEN9jljd87Y1wY3jt3sv9Pn17a5JeiTcV9Vmb9sJTFEohauMYTdG0/GvceA
         nWuDlmBJ+/dTZIQ83jkVyDwF9UwUpWikjb9bqWNZgsmK9t+K2SDUH22rehvbeKAH0aKs
         ho9fiFEFMoBtoK7v1PridCxVSfuavU4PNoCbeHJSPsDTVgH3hfaZhs4CZFN8inRhWJG4
         Ouyk0l4/Muj0/PvdkYkCaBJerv8fnhhGtioV39WWRNs0aHg0fRC1317BliKsjpRngnjI
         cjcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eA7KCJJvRseyljITo0qrKH90eTYVQOFKHcLj6kjsvwQ=;
        b=ssJIebT/vBhrlUFWKOElxFK3r27AoZCAqFmCJwuTiRahkkzs6XskBBF58wPETscxWo
         5sr0pKAX/VqDJwr667F9KQDaRRmF5v36LSRWuP6++DQFAQDt9P3ZidNXEII8o8Bz8H3Y
         mqPTCN6LQagG+F0b6sqH2SDl4KmW1sC+253we8AG04AVZRl5niGHIPxRwoOmXpv3Urum
         isugTyLQQZEhJTtAkSZez+acmnUBgCfXMfABWcZSxDDbV9ot8JIIbUBU5qW2FpoSaJCx
         xByPUKi/9IYAlV9wW6VXUwIAQwomuo1BZDYchcw1zAG8VRrW4S2hgtOFNF6OlrjjNtNb
         fxMg==
X-Gm-Message-State: APjAAAW19BEhbSd100VbpAgzSejqABfgdmHV7zAfXAdKV37QyRMRbtB/
        ECJePespq5LscFKgK7g/iEga7HIJ
X-Google-Smtp-Source: APXvYqxDLSsl1DSfEWKTB8MCKkRHzcDNXsZT09cbTriRrYX6dEX5OFprsQALwE8u336xeSKD7y9eDA==
X-Received: by 2002:adf:ed02:: with SMTP id a2mr4118319wro.24.1552689202344;
        Fri, 15 Mar 2019 15:33:22 -0700 (PDT)
Received: from localhost ([95.148.214.107])
        by smtp.gmail.com with ESMTPSA id c202sm3758500wme.38.2019.03.15.15.33.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Mar 2019 15:33:21 -0700 (PDT)
Date:   Fri, 15 Mar 2019 22:33:20 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Matthew Kraai <mkraai@its.jnj.com>
Subject: Re: [PATCH v2] stash: pass pathspec as pointer
Message-ID: <20190315223320.GH16414@hank.intra.tgummerer.com>
References: <20190307191836.GB29221@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1903081630040.41@tvgsbejvaqbjf.bet>
 <20190309182610.GD31533@hank.intra.tgummerer.com>
 <xmqqimwqmbba.fsf@gitster-ct.c.googlers.com>
 <xmqqd0mxkgvy.fsf@gitster-ct.c.googlers.com>
 <20190311214244.GB16414@hank.intra.tgummerer.com>
 <20190311221624.GC16414@hank.intra.tgummerer.com>
 <nycvar.QRO.7.76.6.1903122323460.41@tvgsbejvaqbjf.bet>
 <20190312234046.GF16414@hank.intra.tgummerer.com>
 <nycvar.QRO.7.76.6.1903132311200.41@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1903132311200.41@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/13, Johannes Schindelin wrote:
> Hi Thomas,
> 
> On Tue, 12 Mar 2019, Thomas Gummerer wrote:
> 
> > On 03/12, Johannes Schindelin wrote:
> > > However, we would not have needed to move the initialization of
> > > `rev.prune_data`, I don't think, because `init_revision()` zeros the
> > > entire struct, including `prune_data`, which would have made
> > > `clear_pathspec()` safe to call, too.
> > 
> > 'clear_pathspec()' doesn't actually check whether the parameter passed
> > to it is NULL or not before dereferencing it.
> 
> In this case, it does not need to check for NULL, as `&rev.prune_data`
> will always be non-NULL: `rev`'s `prune_data` field is of type `struct
> patchspec`, i.e. *not* a pointer (in which case the type would be `struct
> pathspec *`). See for yourself:
> 
> 	https://github.com/git/git/blob/v2.21.0/revision.h#L91

Doh, you're right of course, I totally missed that.  Thanks for the
pointer, and sorry for the noise!

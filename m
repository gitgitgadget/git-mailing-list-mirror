Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68129211B4
	for <e@80x24.org>; Mon, 14 Jan 2019 17:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfANRp4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Jan 2019 12:45:56 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46559 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbfANRp4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jan 2019 12:45:56 -0500
Received: by mail-wr1-f65.google.com with SMTP id l9so23877066wrt.13
        for <git@vger.kernel.org>; Mon, 14 Jan 2019 09:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=nM9uyzUMoGbSt1vhloyTndgEda+uVNQGyVmyFbGyXIE=;
        b=Oc/V77hkiQEsdrLqAjnjMf7Mz4Gh9d/QfQHibFhFJfA7Vc09ZEh9ueFMIOyXIwu1Qk
         ZxqJdLNc9yZVKRloFtaGOK270LvMOdlT2Q2SB+JDKttyvcej1ZQOqIhrTTQE/y7GdV4v
         nDrVH+yTMtbWBtJ0eHYCN1GTdWOVzDQRog8hS4e22jfCZxObYy4/Ft+blnIxmtk1DRf8
         57t2YshMSn2tI6IQRKKjocXsFitWTCPoK2+UAOF3GOEsCZmJBpHzzCEOEvwKAmPG9/qr
         8TzqgIG29TIwqIVZ8nLI945rHoGNvOi8lS17E6FVXfqtUiThK5HeT44z2qAIQFf56BOm
         P1TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=nM9uyzUMoGbSt1vhloyTndgEda+uVNQGyVmyFbGyXIE=;
        b=D4Ruldng7kZcg80Y2RhcRCop+cflWzYhJWbrYH4dNFbX9uFCxoq1iJxfqGI62WiGlM
         8Qq8fl4FpAO8kSbc5STQzB2yBBGXyuw+NhlbIIhZTudghaScs2dk+SbvEkh75rtj3Res
         z8FTLrdlTBfK69RgyI8w5lkbmbWfKWDjHbo4Y8gb6eqEfPWUqAvuWJUIWtl56APQEIo9
         EiF43KqeepfEPOPqsKKkcbTwdJQ5UYT5b+l/B4irpMT2rLSwbUjyl0tSJtYpmila7SBl
         QLZ8hmo+lD5BZpxdwL3mua+mMUxSsvdj+Ipze5Ly9nn/rk0CsXllhI2B/wJSy3azbyAG
         NGfA==
X-Gm-Message-State: AJcUukeRGkyOOkgnv4k+NbzVry0A9SC1OaZkvEr4ykc7VQ3qpQ7RRKBI
        VeFxiAZeP+bRG27Sc2GkWercXJna
X-Google-Smtp-Source: ALg8bN6UkR/S0AgERD6WR2tWUY+9mvp1uN0+z8gXTaf/z/piEdJWEtlrMDVhqLekuD86613TAjQxYA==
X-Received: by 2002:adf:ea81:: with SMTP id s1mr24551727wrm.309.1547487953934;
        Mon, 14 Jan 2019 09:45:53 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id g67sm54082961wmd.38.2019.01.14.09.45.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 09:45:52 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Barret Rhoden <brho@google.com>
Cc:     git@vger.kernel.org, Stefan Beller <stefanbeller@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH] blame: add the ability to ignore commits
References: <20190107213013.231514-1-brho@google.com>
        <xmqqbm4s6ozl.fsf@gitster-ct.c.googlers.com>
        <20190108112742.7878d4cb@gnomeregan.cam.corp.google.com>
        <xmqqimyz57l9.fsf@gitster-ct.c.googlers.com>
        <20190109154828.1b19dbb4@gnomeregan.cam.corp.google.com>
        <xmqq1s5k16zj.fsf@gitster-ct.c.googlers.com>
        <20190114101956.2b899d0e@brho.roam.corp.google.com>
Date:   Mon, 14 Jan 2019 09:45:52 -0800
In-Reply-To: <20190114101956.2b899d0e@brho.roam.corp.google.com> (Barret
        Rhoden's message of "Mon, 14 Jan 2019 10:19:56 -0500")
Message-ID: <xmqqfttvw2sv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Barret Rhoden <brho@google.com> writes:

> On 2019-01-10 at 14:29 Junio C Hamano <gitster@pobox.com> wrote:
>> > For instance, commit X does this:
>> >
>> > -foo(x,y);
>> > +foo(x,y,z);
>> >
>> > Then commit Y comes along to reformat it:
>> >
>> > -foo(x,y,z);
>> > +foo(x, y, z);
>> >
>> > And the history / rev-list for the file looks like:
>> >
>> > ---O---A---X---B---C---D---Y---E---F
>> >
>> > I want to ignore/skip Y and see X in the blame output.    
>> 
>> If you skip Y, the altered history would have "foo(x, y, z)" in E,
>> "foo(x,y,z)" in X, and "foo(x,y)" in A.  If you start blaming from
>> F, you'd get E as the commit that explains the latest state.  If you
>> do not skip Y, you'd get Y.  I am not sure how you'd get X in either
>> case.  
>
> The way to do it is ...

Sorry, I made a too-fuzzy statement.  What I meant was, that unless
you are ignoring E, I do not know why you "would want to" attribute
a line "foo(x, y, z)" that appears in F to X.  Starting from X up to
D (and to Y in real history, but you are ignoring Y), the line was
"foo(x,y,z)", after E, it is "foo(x, y, z)".  I didn't mean to ask
how you "would show" such a result---as I do not yet understand why
you would want such a result to begin with.


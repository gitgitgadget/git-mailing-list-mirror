Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B30E1C83000
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 07:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CE1920661
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 07:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OlhYC53u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgD1HSH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Apr 2020 03:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbgD1HSH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Apr 2020 03:18:07 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF55C03C1A9
        for <git@vger.kernel.org>; Tue, 28 Apr 2020 00:18:07 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id g2so8002947plo.3
        for <git@vger.kernel.org>; Tue, 28 Apr 2020 00:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xhJNBli/MbiEqJzeppBR/eZxuhCbPpkzYG6LLrT8AUI=;
        b=OlhYC53uqLmgu5ccxjo/MRgAkz36OkNdLHFnRL9xstw5IbJdP8bN6l5BUbnDZ0+AZy
         AO5d9NRMkgiJdiYdaTAieH6LCmh+4R+7KG+UOg+wz+2yNwlNDohK84ZRGuUjXRBxBANm
         +fMp8OWrHoVjsX1+a/cEvCowPeM47B/xqP32wO4QgBhmq7k9iB/hMwsH9FphvqhTq5zR
         rJ8J1NbdHUc8YiIijUGfcxDGlkM68vD0HrylgtYOde4w71Cpf6wngPCmjBHQj1sCC/ss
         WGgaE26eY+uzB9jI2ZnhYisI0M3WH9EEmdI3SzLO8Q6siYa+dgAz8ZemjLulKKgxOkO6
         wNvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xhJNBli/MbiEqJzeppBR/eZxuhCbPpkzYG6LLrT8AUI=;
        b=KGvgLb71nh2vIPqPFoqQAbbb873BxWcMmIjQE7ULyO/lohfDAV0Hx0R7E1G0nPYYfJ
         841g9pb2ejjYy+kXFivo1qVYglEraS5ymPLPF4gwg5tb+fh75sCZkVAkWWE8K45sV/Eh
         ge27ax32L95ETfz5rBPjGdI85/t8mhSJouvj3OVJJ8IqQAKn42YFNPLrLppUZjOd5QSd
         eLilqPt+YMUdFCgd3aP1iusemFZx73/YblZ77kksucFBx2Vhdmn07/s1E1gAqOA+7Acs
         PyDRWBnsHeqnEmcCdU8IlMfb2xM6fyT9e47Zz5wk9d2V/i2wxWWfyZ/EQqkpSmSlQKxZ
         P8pQ==
X-Gm-Message-State: AGi0PuYaFFivQINii4Aa3o8I+bN6CXKJUf5D/JQa4RkEYfsUfJzRDDck
        ClrkiucvXnEsluv/e1Eb/SI=
X-Google-Smtp-Source: APiQypKjxCrWKZcFXjMWHjp6tsOon3i+gEbLfWfMz9kluxx1HBVFpuXrP1jztINGAU8lPdRHf8467A==
X-Received: by 2002:a17:902:b592:: with SMTP id a18mr28051875pls.147.1588058284981;
        Tue, 28 Apr 2020 00:18:04 -0700 (PDT)
Received: from Carlos-MBP (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id 14sm14227444pfj.90.2020.04.28.00.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 00:18:04 -0700 (PDT)
Date:   Tue, 28 Apr 2020 00:18:02 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        dirk@ed4u.de, sunshine@sunshineco.com,
        Stefan Tauner <stefan.tauner@gmx.at>
Subject: Re: [PATCH v3] git-credential-store: skip empty lines and comments
 from store
Message-ID: <20200428071802.GF61348@Carlos-MBP>
References: <20200427084235.60798-1-carenas@gmail.com>
 <20200427125915.88667-1-carenas@gmail.com>
 <xmqqftco94wx.fsf@gitster.c.googlers.com>
 <20200427191858.GB1728884@coredump.intra.peff.net>
 <xmqqv9lk7j7p.fsf@gitster.c.googlers.com>
 <20200428052510.GA201501@google.com>
 <20200428054155.GB2376380@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428054155.GB2376380@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 28, 2020 at 01:41:55AM -0400, Jeff King wrote:
> On Mon, Apr 27, 2020 at 10:25:10PM -0700, Jonathan Nieder wrote:
> 
> > I wonder if in addition to the above documentation change we may want
> > something guaranteed to catch all cases where people would have
> > experienced a regression, like
> > 
> > diff --git i/credential-store.c w/credential-store.c
> > index c010497cb21..294e7716815 100644
> > --- i/credential-store.c
> > +++ w/credential-store.c
> > @@ -24,8 +24,8 @@ static int parse_credential_file(const char *fn,
> >  	}
> >  
> >  	while (strbuf_getline_lf(&line, fh) != EOF) {
> > -		credential_from_url(&entry, line.buf);
> > -		if (entry.username && entry.password &&
> > +		if (!credential_from_url_gently(&entry, line.buf, 1) &&
> > +		    entry.username && entry.password &&
> >  		    credential_match(c, &entry)) {
> >  			found_credential = 1;
> >  			if (match_cb) {
> > 
> > And then we can tighten the handling of unrecognized lines to first
> > warn and then error out, as a controlled change that doesn't lead
> > people to regret updating git.
> 
> I like that solution, as it mostly brings us back to the original
> behavior, as weird or unexpected as it was.

I like this version better as well, and we could even reuse my test
case.

it wouldn't cover cases where there were leading spaces/tabs around
the credential which I have to admit I liked just because it is
more robust to bad input, and there is no sane way now to tell the
user that there is invalid data anyway, but I am ok eitherway.

Carlo

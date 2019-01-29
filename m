Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11BF91F453
	for <e@80x24.org>; Tue, 29 Jan 2019 15:36:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbfA2Pg6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 10:36:58 -0500
Received: from mail-wm1-f48.google.com ([209.85.128.48]:52226 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfA2Pg5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 10:36:57 -0500
Received: by mail-wm1-f48.google.com with SMTP id m1so18341176wml.2
        for <git@vger.kernel.org>; Tue, 29 Jan 2019 07:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rhCbjarV7t4BCwrvrM+3sZEJS8KSB24V/JCe0LOz4T8=;
        b=XeIdEwPeJFKIVstVQklUBPaR7FF/yZmqiWMOmEuGARFtqC2naiKyIhiz2eEdEePhI+
         O4k2vcYwMA69x6ezW3SRZXaWEYzCFJG+AsKmbqU5/QyFtScVPWrhRQbapAVAeo0qPKfV
         Dc9Qd5MF0XOHOlvgqIa4jQ1J3ZIcIfaVtrhVY9bUIQD1dp7njfNoFoLflFksHNSlLGY3
         HnhyvYWFCDcTSXSWo5ePOYPpKSIdqQsHTgWNdEFhBo2Qth9S7ln3S8pnge9ZtPWm/8Vg
         vVMEjmzg+BfVm4abKzwd2c/4H52zdVrriceb4vTQjdUbcInCOogfTHt8pvjo3c1rfKA8
         PQDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rhCbjarV7t4BCwrvrM+3sZEJS8KSB24V/JCe0LOz4T8=;
        b=shFmOSyqVqDQnywaQ1QD6jm2g1/9a6WvIDjNTQWeAscm7YNezRXJIRTd8bRB2kv/b6
         0Q8huWAuMUvO1EXYzv9uQTTe4+pzWN526c3zldtgubWcbG8MJ1ygeQWIskCO3+zTbhIb
         lrmoMkB0gKP1+ImyC5zJNKyTeBG/QDyhkZYVMZWPjtSxNht1LmRmGLLb9iR+jwMDbH+b
         UI0IRHYtU5DIDDMOHpCmjKJye1qncfPYqDaKh68iFGb8YBLkwTGLE7IW6i93ROJH4o97
         2wmF6saXbab/sJ6w372mNf1m+qbOg2Qd23yTY60D4fH8jEJUSGu6bW1mblaKieZgISVX
         y0nA==
X-Gm-Message-State: AJcUukeE4f1OCwlxehBPqJhNFUHkdWXnm4hPED0DgtczUqnSyy7q9jHh
        1zc8Mf38prJ5IeYeUaBPUv0=
X-Google-Smtp-Source: ALg8bN75dgZdL8t9ydR7z0OhMd0KFq0eT4gpRQdpqd7H7oelt+OBCE630o/Jqu/Li+ixlypRx98PkQ==
X-Received: by 2002:a1c:6657:: with SMTP id a84mr20335484wmc.23.1548776214790;
        Tue, 29 Jan 2019 07:36:54 -0800 (PST)
Received: from szeder.dev (x4db3778b.dyn.telefonica.de. [77.179.119.139])
        by smtp.gmail.com with ESMTPSA id f2sm108743285wru.14.2019.01.29.07.36.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 07:36:53 -0800 (PST)
Date:   Tue, 29 Jan 2019 16:36:50 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH/RFC] completion: complete refs in multiple steps
Message-ID: <20190129153650.GB13764@szeder.dev>
References: <20190128094155.2424-1-pclouds@gmail.com>
 <20190128143828.GJ6702@szeder.dev>
 <20190128172707.GA3050@sigill.intra.peff.net>
 <CACsJy8BXfY+bZKV6Jxa7-3VQyyE6hGrFS7ZAnToFwpGq_o1bpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8BXfY+bZKV6Jxa7-3VQyyE6hGrFS7ZAnToFwpGq_o1bpw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 29, 2019 at 07:43:45AM +0700, Duy Nguyen wrote:
> On Tue, Jan 29, 2019 at 12:27 AM Jeff King <peff@peff.net> wrote:

> > > In general I think it would be much better to rely more on 'git
> > > for-each-ref' to do the heavy lifting, extending it with new format
> > > specifiers/options as necessary.
> >
> > FWIW, that was my first thought, too.
> 
> I was more concerned whether it's a good idea to begin with. But it
> sounds like you two both think it's good otherwise would have
> objected.

Well, I objected to this RFC implementation, but on purpose refrained
from expressing an opinion about whether this is good or bad idea,
because I didn't even want to try to guess what others might prefer :)

And as far as I can tell it doesn't affect my usage (in general I
don't have multi-level hierarchies under refs/heads/, so I mostly
complete a single ref path component, and when on occasion I do
complete a full ref, then I tend to know what I want, and even if I
don't, I only need the list of possibilities only at the last ref path
component).

> > > '%(refname:rstrip=-<N>)' already comes somewhat close to what we would
> > > need for full ref completion (i.e. 'refs/b<TAB>' to complete
> > > 'refs/bisec/bad'), we only have to figure out how many "ref path
> > > components" to show based on the number of path components in the
> > > current word to be completed.  Alas, it won't add the trailing '/' for
> > > "ref directories".
> >
> > I think it also makes it hard to do one thing which (I think) people
> > would want: if there is a single deep ref, complete the whole thing.
> > E.g., given:
> >
> >   $ git for-each-ref --refname='%(refname)'
> >   refs/heads/foo/bar
> >   refs/heads/foo/baz
> >   refs/heads/another/deep/one
> >
> > we'd ideally complete "fo" to "foo/" and "ano" to "another/deep/one",
> > rather than making the user tab through each level.
> 
> Ah ha, like github sometimes show nested submodule paths. Just one
> small modification, when doing "refs/heads/<tab>" I would just show
> 
> refs/heads/foo/
> refs/heads/another/
> 
> not refs/heads/another/deep/one to save space. But when you do
> "refs/heads/a<tab>" then you get "refs/heads/another/deep/one"
> immediately.

But this would be inconsistent with how "regular" path completion
works, e.g. if you have 'unique-dir/only-one-dir/only-one-file' and do
e.g. 'cat u<TAB>', then Bash will only offer 'unique-dir/', not the
whole path to the file in the subdir.  Ok, I know, those are real
paths not refs, they just look alike, because both happen to use '/'
as separator.

I can't asses whether people, in general, would prefer this behavior
or would rather be surprised or bothered by the inconsistency.


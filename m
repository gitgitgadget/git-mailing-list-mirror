Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE2BE1F404
	for <e@80x24.org>; Wed, 29 Aug 2018 09:32:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbeH2N2M (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 09:28:12 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36392 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727198AbeH2N2M (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 09:28:12 -0400
Received: by mail-ed1-f65.google.com with SMTP id f4-v6so3430107edq.3
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 02:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=w+M/77UW3YGyd5DpbBAlJ0gcAAl2yWh3Ar9etUMFM8A=;
        b=l1fV6mjK7pQVt0xiilJTqPBvZ+5S9Mz/EYibfOTzNcMJSWqLVsn7iQg/u/djtPnLt6
         xHimPrmuWW2NRSozkXnRai7L02qV5OfCJYNcIqPsDncRWkiesYxW5qq+eOvxiQBM9+6q
         BLbILz/1JrDj6EnQKpVNJs+2e3NUZ5ua88hjwhMZY7SpqUlr9HsDKegb3oMok+zTKOEH
         40fYIWcn01y0fRDB0eI09X/6/238b8GTOmGb79VaOCCbJP8yMlrb61iisagvIhnrlQR/
         8CrmITPWB5YNa0i4qVbX+owcXnrXGV9NoESGRq2cfo+XTsVaa+vOKlT0yRldd8i8UJBr
         iA3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=w+M/77UW3YGyd5DpbBAlJ0gcAAl2yWh3Ar9etUMFM8A=;
        b=L6e7UBLMKavO58+IQG7MUyMCPVNHHao92Oo1/YEZ8ZTgO2X34hAxFDIo/dSUtYR79N
         +V+aF5JLyPayCHpefbRWSe2B2ThKE26kUph2VNo2g7ARZ1n45HjIjPMZ3HRxJ9oXXb7H
         YCSfT+TfYltAYJCFIAnMP8L5XFdkyWOZlo1wEiao76ldOiy0PzZXA6HokI0JKLK26jmu
         rBmF8AQ6tib/NctHJ+aQZMvRkN1mVnyKQ7pm1PvOfu2xUy0x9yrBxtcf2BPuuP+DOjn5
         yI1Zw2XGK4Xg7mwlTAj4iWGnoHBeQmqGGLhjR3hRojpGLFOwbMp6VTaRK8gnM/2tId9b
         TyKQ==
X-Gm-Message-State: APzg51B6YpmzEiaAzXLQrbFHsotvfa1pmFXvx48ZbDchsvWsEROQdNLx
        NptsTMvtB6Nx33WZIJ5+Uz+pT1y+v88=
X-Google-Smtp-Source: ANB0VdaO6y60qYTgWCGqgF4WNIiJPVnAoAbyig6ig/IpEG/aFSEX0RTw6V81pGbELhIAly8RGXIiug==
X-Received: by 2002:a50:8141:: with SMTP id 59-v6mr6925474edc.61.1535535130427;
        Wed, 29 Aug 2018 02:32:10 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id f26-v6sm1600020edb.28.2018.08.29.02.32.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 02:32:09 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 09/12] Add a base implementation of SHA-256 support
References: <20180829005857.980820-1-sandals@crustytoothpaste.net> <20180829005857.980820-10-sandals@crustytoothpaste.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180829005857.980820-10-sandals@crustytoothpaste.net>
Date:   Wed, 29 Aug 2018 11:32:08 +0200
Message-ID: <875zztecx3.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Aug 29 2018, brian m. carlson wrote:

> SHA-1 is weak and we need to transition to a new hash function.  For
> some time, we have referred to this new function as NewHash.
>
> The selection criteria for NewHash specify that it should (a) be 256
> bits in length, (b) have high quality implementations available, (c)
> should match Git's needs in terms of security, and (d) ideally, be fast
> to compute.
>
> SHA-256 has a variety of high quality implementations across various
> libraries.  It is implemented by every cryptographic library we support
> and is available on every platform and in almost every programming
> language.  It is often highly optimized, since it is commonly used in
> TLS and elsewhere.  Additionally, there are various command line
> utilities that implement it, which is useful for educational and testing
> purposes.
>
> SHA-256 is presently considered secure and has received a reasonable
> amount of cryptanalysis in the literature.  It is, admittedly, not
> resistant to length extension attacks, but Git object storage is immune
> to those due to the length field at the beginning.
>
> SHA-256 is somewhat slower to compute than SHA-1 in software.  However,
> since our default SHA-1 implementation is collision-detecting, a
> reasonable cryptographic library implementation of SHA-256 will actually
> be faster than SHA-256.  In addition, modern ARM and AMD processors (and
> some Intel processors) contain instructions for implementing SHA-256 in
> hardware, making it the fastest possible option.
>
> There are other reasons to select SHA-256.  With signed commits and
> tags, it's possible to use SHA-256 for signatures and therefore have to
> rely on only one hash algorithm for security.

None of this is wrong, but I think this would be better off as a simple
"See Documentation/technical/hash-function-transition.txt for why we're
switching to SHA-256", and to the extent that something is said here
that isn't said there it could be a patch to amend that document.

> Add a basic implementation of SHA-256 based off libtomcrypt, which is in
> the public domain.  Optimize it and tidy it somewhat.

For future changes & maintenance of this, let's do that in two
steps. One where we add the upstream code as-is, and another where the
tidying / cleanup / git specific stuff is wired, which makes it easy to
audit upstream as-is v.s. our changes in isolation. Also in the first of
those commits, say in the commit message "add a [libtomcrypt] copy from
such-and-such a URL at such-and-such a version", so that it's easy to
reproduce the import & find out how to re-update it.

Is this something we see ourselves perma-forking? Or as with sha1dc are
we likely to pull in upstream changes from time-to-time?SHA256 obiously
isn't under active development, but there's been some churn in the
upstream code since it was added, and if you're doing some optimizing /
tidying that's presumably something upstream could benefit from as well,
as well as just us being nicer open source citizens feeding
e.g. portability fixes to upstream (since git tends to get ported a
lot).

So I wonder if we can't convince them to add a few macros to their code,
and then do something like what I did in a0103914c2 ("sha1dc: update
from upstream", 2017-05-20) for sha1dc allowing us to use their code
as-is with some defines in the Makefile, which both makes it easier to
update, and sets up a process where our default approach is to submit
changes upstream, instead of working on our perma-fork.

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 522E71F462
	for <e@80x24.org>; Tue, 30 Jul 2019 20:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728541AbfG3U43 (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jul 2019 16:56:29 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:39921 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbfG3U43 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jul 2019 16:56:29 -0400
Received: by mail-wm1-f42.google.com with SMTP id u25so47478651wmc.4
        for <git@vger.kernel.org>; Tue, 30 Jul 2019 13:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=7FlwFCpGSq58dyNhfMyjnYfvKSQ2oXtVHpTBjKG93zI=;
        b=PTFvsHl+9Zv3jZ3X/wyn7m7xm1uIDzk8IDyraqLj+Lhyt71nh+SJNVSAMTPABkVx8V
         bZApjqRPioe6OLuVPDkpAMJaSU/OfQKgkPXj86AtHPa3gpBxWi6++bjWcjXCR+MIs/v4
         e4yVCMjaFUHX4HtqRRyalppcR7W4pvUz26M/nT8OkDxmwaMQGc1pKf6JKrCzn/mwbjL2
         3VCTGHCWxc1fPCzeasAlS+1KQRFAumXoWmlR0Rrlk1qRkNr/p50rlth1+DLJoFkqhVZI
         lcv1V4tZzTUIfXj7Glmz+JZTe5Z1a34FKnpK8zPg9GggIHaaqYO5KkJpJoJEg4dOxfjJ
         e2tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=7FlwFCpGSq58dyNhfMyjnYfvKSQ2oXtVHpTBjKG93zI=;
        b=Iz5s4N3wG+URlcC0qJkmqS2CJJUjspiTCywHlS+TiQ78FJeBVtCoLDbbbFLuBfzR75
         XGlRswzWpjAvd0yXFQtlVDq/kWniUigk/g9oaph1eXEXRSfWJLlCB1UNffFIreiyLE7U
         +Lm9qA12GC12YdJDQJuEBZoZbmxsLG84V7yWxd7++JL5Q748UOUpeUHWvqQqmqsv5RAx
         DikMky5CNXiLwiH/TOKgG4JRpN+YiCXbvp7QAQhfWJGXn82tMHF+I6BpYw8OflVRXsg1
         Pj4Hl1DcORgcAgi+Xl+Xdx/GH+ue0lYNMLyDK9VaRnuPdbDxSjphxBis4suAS6ddMARy
         v71g==
X-Gm-Message-State: APjAAAXxy6d32P5BwtU3wdHkq5EjOJGK4o1TYgyGi17wPB3sKb7PLnET
        pbibbtLzKypOrMtmPhbsMRs=
X-Google-Smtp-Source: APXvYqx5MYX1+51jqbPXlaDNd1CNM+tORjofhUBiTdx7q3j16FNsrXIcu31sArZjNjZH7Zuw2pgCMg==
X-Received: by 2002:a7b:ce01:: with SMTP id m1mr26081594wmc.1.1564520187147;
        Tue, 30 Jul 2019 13:56:27 -0700 (PDT)
Received: from szeder.dev (x4dbe512f.dyn.telefonica.de. [77.190.81.47])
        by smtp.gmail.com with ESMTPSA id r12sm80040248wrt.95.2019.07.30.13.56.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 13:56:26 -0700 (PDT)
Date:   Tue, 30 Jul 2019 22:56:24 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Todd Zullinger <tmz@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        'Junio C Hamano' <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        git@vger.kernel.org, git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.23.0-rc0 - Initial test failures on NonStop
Message-ID: <20190730205624.GR20404@szeder.dev>
References: <049a01d546f9$70be7a30$523b6e90$@nexbridge.com>
 <20190730194938.GZ4545@pobox.com>
 <20190730200203.GA4882@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190730200203.GA4882@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 30, 2019 at 04:02:03PM -0400, Jeff King wrote:
> On Tue, Jul 30, 2019 at 03:49:38PM -0400, Todd Zullinger wrote:
> 
> > > Subtest 6 had an ordering issue. We do not know whether
> > > the problem is the code or the test result not keeping up
> > > with the code changes.
> > >
> > > --- expect      2019-07-30 16:56:36 +0000
> > > +++ actual      2019-07-30 16:56:36 +0000
> > > @@ -1,6 +1,6 @@
> > >  NULL
> > >  NULL
> > >  NULL
> > > +7c7cd714e262561f73f3079dfca4e8724682ac21 3
> > >  139b20d8e6c5b496de61f033f642d0e3dbff528d 2
> > >  d79ce1670bdcb76e6d1da2ae095e890ccb326ae9 1
> > > -7c7cd714e262561f73f3079dfca4e8724682ac21 3
> > 
> > I hit the same failure while building for Fedora on the
> > s390x architecture.  I have not dug into it much yet, but
> > perhaps this is an endianess issue?
> 
> Ah, of course. Our oid hashing is done by just picking off the first
> bytes of the sha1, and it doesn't care about endianness (because these
> are just internal-to-memory hashes).

Yeah.

> We _could_ reconcile that like this:

Do we really want that, though?  It's a hashmap, after all, and the
order of iteration over various hashmap implementations tends to be
arbitrary.  So an argument could be made that this test is overly
specific by expecting a particular order of elements (and perhaps by
checking the elements' oid as well), and it would be sufficient to
check that it iterates over all elements, no matter the order (IOW
sorting 'actual' before the comparison).

OTOH, this is not just any hashmap, but an oidmap, and I could imagine
that there might be use cases where it would be beneficial if the
iteration order were to match the oid order (but don't know whether we
actually have such a use case).


> I
> wonder if it's appreciably less efficient. I'll bet I could nerd-snipe
> René into doing a bunch of measurements and explorations of the
> disassembled code. ;)

Maybe it shows up in an oidmap-specific performance test, but with all
that's usually going on in Git hashmap performance tends to be
negligible (e.g. it's rarely visible in flame graphs).


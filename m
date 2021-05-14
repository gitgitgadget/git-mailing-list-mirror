Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBEB0C43460
	for <git@archiver.kernel.org>; Fri, 14 May 2021 19:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 950BC61574
	for <git@archiver.kernel.org>; Fri, 14 May 2021 19:57:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbhENT6w (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 15:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbhENT6o (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 May 2021 15:58:44 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B84C061756
        for <git@vger.kernel.org>; Fri, 14 May 2021 12:57:32 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id b25so613475oic.0
        for <git@vger.kernel.org>; Fri, 14 May 2021 12:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=5fBpkrPK+Umz6BWfLdUansYOFvUj0fwO+rhW4jBF5DM=;
        b=RBJxNyNURhQap7+Yi3HugopQyQXfeWKuiAcgdF0+A/CWCc3uN28eILvzLC9mf/+Kqy
         t5ky2dgnIpfIv5zbBfiCb4w4JgKraL4nbX2hCdfauuUua0yWHNFdJk0uW0bRNC6G+H4H
         Oefgdxs2up+wo/dmySDl6TZS7XbClTABruIoBW7dD97RwMh+5RtWpK4Jl2UioAVmiw3G
         bwX2bpHTG5rG5B67pwVZIHqB1rvEH/uNRV8q5QnNYO8MBgW6i9ZOP8lwyhn7T2LKln/3
         NrnnWsoZXrdAoaFOWtYVAfpXa1AwTDj1UEk7wEcN1yBIvnS6MA6LTLstD8kFgwFHsPPu
         hliQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=5fBpkrPK+Umz6BWfLdUansYOFvUj0fwO+rhW4jBF5DM=;
        b=avYWERALjPw/g9aXHPxL9bR4+jA3rfrNjyfF5xlix8b3rl6tCcDFJTNxC0hfMCztOU
         6StxePSrdyq/X0R5mCfA9RdVvI3v97CWOebvXDfILP02/tmodop/PTK2pfiGezprd15t
         UMUpBAt3fD/CZ46OzAEH55WV1k96ftBSkuIBEFopkBjO2MKWWTx1aFkU0po2qGltvPXU
         hk/lAjJIYb7coJzouBWvhxXg2EJwRiLq6UFqrW270kYSTyqYYEj7B3suPaMSV+pbVdcN
         uuOWUJvrMxaliIsb6NA/LldTuz2ItRbut13NzwjuCswsumtLXzkqZY19R7chtrkWyoi4
         aW2A==
X-Gm-Message-State: AOAM532wnN6upH5i8IrXWSyYZZe17k1azwRI2zah9DqK28MfkApwlEbw
        r2x3qfJh+EuuJA5P3KevBWs=
X-Google-Smtp-Source: ABdhPJwA6+x1a+IYnW+9i6aAqf0sp83agyJxYmflIgF8OGF4MBpmnexu4E9wvuodnA4q1vyDEsOGWA==
X-Received: by 2002:aca:42c6:: with SMTP id p189mr7907193oia.36.1621022251806;
        Fri, 14 May 2021 12:57:31 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id 77sm515277otc.54.2021.05.14.12.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 12:57:31 -0700 (PDT)
Date:   Fri, 14 May 2021 14:57:30 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, Jeff King <peff@peff.net>
Message-ID: <609ed62a3ad1d_4312720825@natae.notmuch>
In-Reply-To: <xmqqbl9e7yqz.fsf@gitster.g>
References: <609b2828309fc_678ff2082@natae.notmuch>
 <20210514003104.94644-1-sandals@crustytoothpaste.net>
 <20210514003104.94644-2-sandals@crustytoothpaste.net>
 <xmqqbl9e7yqz.fsf@gitster.g>
Subject: Re: [PATCH v2 1/2] doc: add an option to have Asciidoctor build man
 pages directly
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> > diff --git a/Documentation/Makefile b/Documentation/Makefile
> > index 2aae4c9cbb..891181c0f3 100644
> > --- a/Documentation/Makefile
> > +++ b/Documentation/Makefile
> > @@ -192,10 +192,16 @@ ASCIIDOC_HTML = xhtml5
> >  ASCIIDOC_DOCBOOK = docbook5
> >  ASCIIDOC_EXTRA += -acompat-mode -atabsize=8
> >  ASCIIDOC_EXTRA += -I. -rasciidoctor-extensions
> > -ASCIIDOC_EXTRA += -alitdd='&\#x2d;&\#x2d;'
> > +TXT_TO_HTML += -alitdd='&\#x2d;&\#x2d;'
> > +TXT_TO_XML  += -alitdd='&\#x2d;&\#x2d;'
> >  DBLATEX_COMMON =
> >  XMLTO_EXTRA += --skip-validation
> >  XMLTO_EXTRA += -x manpage.xsl
> > +ifdef USE_ASCIIDOCTOR_MANPAGE
> > +TXT_TO_MAN = $(ASCIIDOC_COMMON) -b manpage
> > +TXT_TO_MAN += -aplus='+'
> > +TXT_TO_MAN += -alitdd='\--'
> > +endif
> >  endif
> 
> This hunk is wholly inside USE_ASCIIDOCTOR and deals with {litdd}
> and {plus}, which are defined in asciidoc.conf that is not read by
> Asciidoctor, so we'd need to be careful to keep these three places
> (i.e. TXT_TO_HTML, TXT_TO_XML and TXT_TO_MAN) in sync with the
> asciidoct.conf file.
> 
> It is curious that {plus} for Asciidoctor is deffined only for
> manpages and HTML/XML side lacks the definition.  Intended?

Yes. It is a temporary workaround for a bug in asciidoctor. Eventually
we don't want to do this.

It's much more clearer in my patch, that contains the hack to a single
place inside asciidoctor-extensions.rb [1].

[1] https://lore.kernel.org/git/20210514121435.504423-8-felipe.contreras@gmail.com/T/#u

-- 
Felipe Contreras

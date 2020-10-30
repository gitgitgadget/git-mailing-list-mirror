Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AAD3C00A89
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 17:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FFAB20791
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 17:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="PciNx6t6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgJ3RB0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Oct 2020 13:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbgJ3RBY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Oct 2020 13:01:24 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D4BC0613D7
        for <git@vger.kernel.org>; Fri, 30 Oct 2020 10:01:24 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id 141so8769967lfn.5
        for <git@vger.kernel.org>; Fri, 30 Oct 2020 10:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ieJVAfY5IOdxVWZjejKkzYEH9SIRbqogwyEP2aL6XCE=;
        b=PciNx6t6ePKCyIpWZQWKluLMYGYYUTrObpLYtdE9qxYzeaEOgvi4FrIpPSYMwcuby8
         NpqzynUf+AsYtfBk8p+40+TeiCZ4Jy9HzhUM9AGJpINLfrgYcjVryyTDUDSSOQdkG7FQ
         AR/T+eIIsAhi2NLi2HJhcfgrE5TIhly3A7UbA0tnNtAI5zvXyQ0M68OeKDfQ/H5hkt/V
         87j0j2PNEzLvyoQAwMh4LZG6Jgs+hbnMt1S6w3DYueh/8TEenAt1/mi9jBuSTWjbqlD0
         qFZfi2J1MltnYNBpfdu9kBKJ9CHZ27kpMfQMkQry3pB5NMWt7yu/zElDjDKLAnwjbTfX
         DCdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ieJVAfY5IOdxVWZjejKkzYEH9SIRbqogwyEP2aL6XCE=;
        b=ZcX7F8y04+SRpquXH8GPpd9QATl8w53v6bFrvDN2BCKNaWiBZLK2S5tiWDDcWjrNQb
         ZRxz+liF7xdn+zeKVLyw48bfVGIEj2hMif8uJbqUvYtTWEVgkIceOI7Mu5xBU5BX5l1X
         yZhYDkwvbH7u4QSPUXisNmqsu9B6dYRSVVcnUduAALp/sECaVqIopWYpMfXhiVFPPitR
         pwJufoZGBk8gSQN0HV350/QrltU9wWWcQSuqCwd82QkCYuRaKxbN4VB9bXlfyTki5F7U
         df/niJWsuWxE+S8K3JnrXQc28nZRHHvkG9w8YqaLf+UbWv+yD1D/TfBZh83Vv3btuZMm
         JyvQ==
X-Gm-Message-State: AOAM533triqQBOzfE96nZU8YbvLFtq+n2aI4WapwwAAlJ67EgsDhZSa4
        kj3bX0Y34DyeFg/SROBICp6i2uI9CTW1fxdmow3YaTUUoZepGQ==
X-Google-Smtp-Source: ABdhPJzEY2WX4KXu33SgzcBP/vd8/t2qkZ9yDrzTcokr0w9fAHGcVptmTlZNiEfn1gMtE67ncfDsSt3DzmCMjnjCygQ=
X-Received: by 2002:a19:e88:: with SMTP id 130mr1257496lfo.599.1604077282832;
 Fri, 30 Oct 2020 10:01:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1603937110.git.matheus.bernardino@usp.br>
 <dfc3e0fd62bcf0223dc51485521116e1aca2ee07.1603937110.git.matheus.bernardino@usp.br>
 <xmqq361w4n4x.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq361w4n4x.fsf@gitster.c.googlers.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Fri, 30 Oct 2020 14:01:11 -0300
Message-ID: <CAHd-oW44tFRnpDWsQfF80gZn42mvgwZ0rT-ocQZ92zBTrQL-ZA@mail.gmail.com>
Subject: Re: [PATCH v3 01/19] convert: make convert_attrs() and convert
 structs public
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Jeff Hostetler <git@jeffhostetler.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 29, 2020 at 8:40 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Matheus Tavares <matheus.bernardino@usp.br> writes:
>
> > diff --git a/convert.h b/convert.h
> > index e29d1026a6..aeb4a1be9a 100644
> > --- a/convert.h
> > +++ b/convert.h
> > @@ -37,6 +37,27 @@ enum eol {
> >  #endif
> >  };
> >
> > +enum crlf_action {
> > +     CRLF_UNDEFINED,
> > +     CRLF_BINARY,
> > +     CRLF_TEXT,
> > +     CRLF_TEXT_INPUT,
> > +     CRLF_TEXT_CRLF,
> > +     CRLF_AUTO,
> > +     CRLF_AUTO_INPUT,
> > +     CRLF_AUTO_CRLF
> > +};
> > +
> > +struct convert_driver;
> > +
> > +struct conv_attrs {
> > +     struct convert_driver *drv;
> > +     enum crlf_action attr_action; /* What attr says */
> > +     enum crlf_action crlf_action; /* When no attr is set, use core.autocrlf */
> > +     int ident;
> > +     const char *working_tree_encoding; /* Supported encoding or default encoding if NULL */
> > +};
> > +
> >  enum ce_delay_state {
> >       CE_NO_DELAY = 0,
> >       CE_CAN_DELAY = 1,
> > @@ -102,6 +123,9 @@ void convert_to_git_filter_fd(const struct index_state *istate,
> >  int would_convert_to_git_filter_fd(const struct index_state *istate,
> >                                  const char *path);
> >
> > +void convert_attrs(const struct index_state *istate,
> > +                struct conv_attrs *ca, const char *path);
> > +
> >  /*
> >   * Initialize the checkout metadata with the given values.  Any argument may be
> >   * NULL if it is not applicable.  The treeish should be a commit if that is
>
> The new global symbols are reasonable, I would think, with a
> possible exception of "crlf_action", which may want to also have
> "conv" or "convert" somewhere in its name.

OK. Maybe `enum crlf_conv_action`? In this case, should I also change
the prefix of the enum values? I'm not sure if it's worth it, though,
since there are about 52 occurrences of them.

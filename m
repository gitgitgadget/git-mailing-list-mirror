Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 674CBC433ED
	for <git@archiver.kernel.org>; Fri, 14 May 2021 21:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48BEB61476
	for <git@archiver.kernel.org>; Fri, 14 May 2021 21:21:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbhENVWf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 17:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbhENVWf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 May 2021 17:22:35 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51116C06174A
        for <git@vger.kernel.org>; Fri, 14 May 2021 14:21:23 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id d25-20020a0568300459b02902f886f7dd43so445018otc.6
        for <git@vger.kernel.org>; Fri, 14 May 2021 14:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=7KbWnB7MU8symYmS2XRRO8RAbnXOl/maFUjggl+aOew=;
        b=l2QgOSNwTsYg1mvNCv7VF8YO8r7B7x1VuQQCCejH4cCkJSttXMQCwvs2YEzwxmCmTk
         tj/GlKKKugGoz8NgLj9egxg+4RoWWepGPrXpUEc09Rm0JfD2Re99wRiWkndXKboXrDzk
         gwskgfLUHS1WRM0Y0Ckn+LecbyR8dnKa9FA6qgIqs2SETjs3AnafxoLbAi4CGT2gzGLL
         6y9z9aOOuSBxsfLRTeuDZHM1dPWwngv1hFlHRdHl+7BRghyBdkfe0WXXdlZp7l3bwXRy
         R2r8K9Mrde/eB+2N542FP4kXMcdWB1WdEn+btjtZfqgGqxj2iANOHp0aHr4yBtxEu4l+
         ibhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=7KbWnB7MU8symYmS2XRRO8RAbnXOl/maFUjggl+aOew=;
        b=aYwRgEWoX4aN6rXyX8qMubbOseR+qtMQ5ER1nRfrUKB0EIFPnFskQshX5pnP2f8S/U
         f6+L4mWk1JV7hhCldpARTUZBVlp2qrD8svBholETg0T9XLwsQ7YF7x8qtdVSn6G6Xa/y
         ZJrnk2W4ySETAFXYBuljR1krrv+VCtMsUXouiL/m8Y8ShPfr3SNwVr2Jn7dCA+7k59dp
         3TA/S08M+kFUgv9TJIUSrKK+TvciYqITrfI8SZcVOFXnwXiBpTdpo7ic7aAAb3ttJAC3
         5ftrj4zkJLzh6bcM66mNa4nra4G4rmTI5fMu4M1kkBX0BIgasnYUywf/C4dXjpxqT8/2
         r14w==
X-Gm-Message-State: AOAM533f54CV/HTOtwNd2HfNU9fqH8Cu0JEJvcV1yaqP80PtH2loTAMU
        HJkCAHShTu56TnTObI+g7W0=
X-Google-Smtp-Source: ABdhPJwfpwr6naFEY7dPOhJpL0KCgvYbVvLXupqMShTLjxCTF58x+jqD3E1glvChPPWqSOH4WTFviA==
X-Received: by 2002:a9d:170b:: with SMTP id i11mr36127056ota.161.1621027282722;
        Fri, 14 May 2021 14:21:22 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id e7sm1582378oos.15.2021.05.14.14.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 14:21:22 -0700 (PDT)
Date:   Fri, 14 May 2021 16:21:21 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, Jeff King <peff@peff.net>
Message-ID: <609ee9d117baa_4312720826@natae.notmuch>
In-Reply-To: <YJ7W4YrboXQhMh/B@camp.crustytoothpaste.net>
References: <609b2828309fc_678ff2082@natae.notmuch>
 <20210514003104.94644-1-sandals@crustytoothpaste.net>
 <609eca5a42be2_43127208f2@natae.notmuch>
 <YJ7W4YrboXQhMh/B@camp.crustytoothpaste.net>
Subject: Re: [PATCH v2 0/2] Asciidoctor native manpage builds
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

brian m. carlson wrote:
> On 2021-05-14 at 19:07:06, Felipe Contreras wrote:
> > brian m. carlson wrote:
> > >     @@ Documentation/asciidoctor-extensions.rb: module Git
> > >               elsif parent.document.basebackend? 'html'
> > >                 %(<a href="#{prefix}#{target}.html">#{target}(#{attrs[1]})</a>)
> > >      +        elsif parent.document.basebackend? 'manpage'
> > >     -+          %(\\fB#{target}\\fP\\fR(#{attrs[1]})\\fP)
> > >     ++          %(\e\\fB#{target}\e\\fP\e\\fR(#{attrs[1]})\e\\fP)
> > >               elsif parent.document.basebackend? 'docbook'
> > >                 "<citerefentry>\n" \
> > >                   "<refentrytitle>#{target}</refentrytitle>" \
> > 
> > Huh? Didn't you say \e was not needed?
> 
> Yes, but I believe in that case my build was broken and I was incorrect.

I see. If it helps you I'm using this script [1] to run the specific
version of asciidoctor of a git repository (their wrapper is wrong).

> > You are doing basically the same thing thing my patches now, except in a
> > more convoluted way.
> 
> The way your patches do it, if someone adds a line like this:
> 
>   _abc linkgit:git-update-index[1] def_
> 
> the latter part (def) is not italicized.  In my version, it is, which is
> the correct behavior.

Right, but my version is precisely what asciidoc+docbook generates in
the simplest case.

I agree your version is superior (although I wouldn't do the second
\fR \fP). But that belongs in a separate patch IMO.

Cheers.

[1] https://dpaste.com/3AEDTFCSK

-- 
Felipe Contreras

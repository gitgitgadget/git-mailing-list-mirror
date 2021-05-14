Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A102CC433B4
	for <git@archiver.kernel.org>; Fri, 14 May 2021 12:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7281F61404
	for <git@archiver.kernel.org>; Fri, 14 May 2021 12:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhENM7V (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 08:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhENM7U (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 May 2021 08:59:20 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59AF4C061574
        for <git@vger.kernel.org>; Fri, 14 May 2021 05:58:08 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id f184so8147617oig.3
        for <git@vger.kernel.org>; Fri, 14 May 2021 05:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=eM0WuTJjgrj6KV1uA7zjEhDPevXP4xsOSXvri10RJ5E=;
        b=p4/DdFHzTpZJLX2IKHVg9hoUf11rmPOUDLv71Q/is7hRLxkcY44OCJtDXr7EeoUAD1
         7/ClRpOwPrSS+/hL9FUJw3htxUoJ+it6H+T79JStq+KBSlWdHF4kKu800qTlnGQScUYK
         eXtfps+C10pMsy0oJ0s1Kr5J+YVnVsPno1rU0ASGu/EqMzVQCqzXPVGXB3g1234liuMV
         obMiHQ6+MyBrTMgf3fiLJbiX9cFMpD6uHE+DAoTiJumWgZZhaKBQACoD5hQH1PMXxmK5
         50io6/hPweeaPZUPLR++kSMhbsESYSe7sMhr6iIv3c5iV6i1Upnv952QAwB7eD845QzD
         lpCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=eM0WuTJjgrj6KV1uA7zjEhDPevXP4xsOSXvri10RJ5E=;
        b=kCj/6GuR7XjTD4s5pFWROitKr1sYingESXZZ6SjTDPfzDOKOXZuI3s4DzuuEsF7RX7
         6qcpHnJ9flbR0RzHP3RDz9ZJwbuoQY/0YlphfEio9IHV8j0lGyiC6I0RV15jqRz5kju9
         abAZH+vuQOfjAF7wwn8lEd40Hg4sqciuywVCcU4Yz0wE5vu0Zx2YhE42WKExbM5myXIE
         bod45rbyNdIDLuU5F5MCNYSuSmAXBYyloBWCS4rWVGRL9MaPbB/PcCMeidg53Ut8/z7g
         60h78TGUlDdjybYpMPjX72uVHqfyE89ui001afrHAc8dXGSB3o4/B6flmOYGOnB5sMSr
         oOww==
X-Gm-Message-State: AOAM531IXR1FeGUVs6ePp6MZZQrKVMAxZSVVIZovu+qVVQshcAWME5ha
        RuzuJobQpQ+H9C+UjKbkRHI=
X-Google-Smtp-Source: ABdhPJzL5xA9HUX6KZ3TJsEaAsMu7bgLCHnCzKvcVBKYKWWR2BPTc3NtNZp3Zr917w/V3JAXfLMEHg==
X-Received: by 2002:a05:6808:a8a:: with SMTP id q10mr6775897oij.46.1620997087680;
        Fri, 14 May 2021 05:58:07 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id w25sm1353432otq.40.2021.05.14.05.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 05:58:07 -0700 (PDT)
Date:   Fri, 14 May 2021 07:58:04 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>
Message-ID: <609e73dcbe525_431272081e@natae.notmuch>
In-Reply-To: <YJ21Qfnk0tpPgPqu@camp.crustytoothpaste.net>
References: <609b2828309fc_678ff2082@natae.notmuch>
 <20210512021138.63598-1-sandals@crustytoothpaste.net>
 <6d56412a-cc67-22fc-717f-9fa218264b40@gmail.com>
 <YJ21Qfnk0tpPgPqu@camp.crustytoothpaste.net>
Subject: Re: [PATCH 1/2] doc: add an option to have Asciidoctor build man
 pages directly
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

brian m. carlson wrote:
> On 2021-05-12 at 02:48:59, Bagas Sanjaya wrote:
> > Maybe when distros upgraded shipped Asciidoctor version to 2.0, we can
> > bump the version requirement.
> 
> My general policy, which need not be Git's policy (but I think is
> reasonable), is that I will support the previous version of Debian and
> Ubuntu LTS for a year after the new one comes out.  Under that policy,
> we'd wait until a year after Debian 11 (bullseye) is released.

Under that policy the supported version would be Debian 10 (buster),
which ships with Ruby 2.5. It's more than capable of running
asciidoctor.

The CI of asciidoctor tests versionof Ruby as old as 2.3, so Debian 10
is safe.

In fact, I would bet you that asciidoctor works fine in Ruby 2.1 shipped
with Debian 8 (jessie) released in 2015. Maybe users of Debian 7 would
have trouble... *maybe*... It's hard to tell because Debian doesn't
even provide package information about that release.

> > > diff --git a/Makefile b/Makefile
> > > index 93664d6714..cb75dec314 100644
> > > --- a/Makefile
> > > +++ b/Makefile
> > > @@ -285,6 +285,9 @@ all::
> > >   # Define USE_ASCIIDOCTOR to use Asciidoctor instead of AsciiDoc to build the
> > >   # documentation.
> > >   #
> > > +# Define USE_ASCIIDOCTOR_MANPAGE to use Asciidoctor's manual page backend
> > > +# instead of building manual pages from DocBook.
> > > +#
> > The wording should be "...instead of building manual pages from DocBook with
> > xmlto".
> 
> I can make that change.  We're not using DocBook either way, with xmlto
> or other tooling (e.g., a plain xsltproc), so what we have here is
> accurate.

Hmm...

cat Documentation/manpage.xsl

  <xsl:import href="http://docbook.sourceforge.net/release/xsl-ns/current/manpages/docbook.xsl" />

That's a deliverable of the DocBook project, is it not?

-- 
Felipe Contreras

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9854C433B4
	for <git@archiver.kernel.org>; Thu, 13 May 2021 11:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90FD4601FE
	for <git@archiver.kernel.org>; Thu, 13 May 2021 11:04:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbhEMLF0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 07:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233019AbhEMLEi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 07:04:38 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C31C061574
        for <git@vger.kernel.org>; Thu, 13 May 2021 04:03:01 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id c13so7952702pfv.4
        for <git@vger.kernel.org>; Thu, 13 May 2021 04:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=StINxkKjCW8+xeY8nF3Tn/tQiQW9ATIGlskRN4toJhE=;
        b=DN1uTUGe/+UBQ50bfzoH8sx4Rn8iJ4EBUBqe4yJ2uFpVtmeoM+bn0HKBcSS9l8CQHF
         jDO6BU7nEoUhFb7zXV50+nK4G1rKFy40URkp0AUT7pzcP566qctNZaRtGq5bM31/G6f7
         wXUGDiKZXImdVyrP9unK95cOGofC1Fn/LN4bBqUZda9d282HwXz2pzDboBCgv3jjH/fJ
         uyxMLBViIrJAsNn60xICXGLrsXLJk6Ab9LjaQIOblNAGNDn1Utkqq6379+6huI6VVohQ
         ShRiHTiiyV3YkRp8COE4JK0GPRJ1+hYPa08b9j7zyiwIZPs+DtJdZ/IN25e5GIWwT8HH
         clYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=StINxkKjCW8+xeY8nF3Tn/tQiQW9ATIGlskRN4toJhE=;
        b=l1SJTeznz+b+8A3fWBr8TFPgTDkOAUMd5Q4et2Ol+BgJLElLd6g6pct4xoNuX8E7Zj
         66L9SPtFvQbvMveFvgCnLlVWPWyS4BBh3lPPkIK/ienybiwOkXIckK1VIO5wUPx6efN6
         72p+3YTi3hqxbgj1lfeKIWw61gbPLMqu76IbLohLBRCNH32hqJAfGJyIihbh2DhU61aT
         uz+xrhD8Yy8exGbtVVSwJGSIPx5t4zE3hp++k3o9KWBLLeKOD2rhFqjTLMO2GeWeAUmx
         qr4WWn/bXC8UWsWVNriTwf6YSa4DDuttmN9hLruEOwBlLdIwBCFg1+jSNdnk9omb7uVE
         JGAg==
X-Gm-Message-State: AOAM531suYCq748k08V//99Sdy71NKsZ1PDRof2udqMQhld0Tnvgq3ZO
        Qwk2AVp6WIQ5fBt3nw5FLfTztK0009dxhREJZWJ5Ielg2Vc=
X-Google-Smtp-Source: ABdhPJyCTwu7TTDwqD8EbzDFg0D/xaKiwxGVsbHYGKvt0eoR0r01jhjnFTZX2FpmtqvfVBCwsrPw2NmyBalhsSjTq6I=
X-Received: by 2002:a63:ad0f:: with SMTP id g15mr12733752pgf.415.1620903781473;
 Thu, 13 May 2021 04:03:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210512222803.508446-1-felipe.contreras@gmail.com> <20210512222803.508446-9-felipe.contreras@gmail.com>
In-Reply-To: <20210512222803.508446-9-felipe.contreras@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 13 May 2021 13:02:47 +0200
Message-ID: <CAN0heSrWu462h9Ch5K-aMHUgjB-BGqRp9YpWa=vPi_V+MiUwBg@mail.gmail.com>
Subject: Re: [PATCH 8/8] doc: join xml and man rules
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 13 May 2021 at 00:28, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> Will be useful later with asciidoctor that can do both at the same time.

> -%.1 %.5 %.7 : %.xml manpage-base-url.xsl $(wildcard manpage*.xsl)
> -       $(QUIET_XMLTO)$(XMLTO) -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
> -
> -%.xml : %.txt $(ASCIIDOC_DEPS)
> -       $(QUIET_ASCIIDOC)$(TXT_TO_XML) -d manpage -o $@ $<
> +%.1 %.5 %.7 : %.txt $(ASCIIDOC_DEPS) manpage-base-url.xsl $(wildcard manpage*.xsl)
> +       $(QUIET_ASCIIDOC)$(TXT_TO_XML) -d manpage -o $*.xml $< && \
> +       $(XMLTO) -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $*.xml

It does mean that if manpage-base-url.xsl changes, we'll regenerate all
the xml files. Before this change, we would just rerun the xmlto step.

Also, this will break `make info`. It will either find xml files that
"happen" to be there, e.g., because you just built the manpages (or
maybe you did so several weeks ago), or it won't find them and error
out.

(If you're wondering if anyone is actually using `make info`, there's
some discussion at [1]. I don't think anyone would be too sad to see it
go. Once `make info` is the only reason we need to generate the xml
files, I think it's a given we should try to drop that stuff.)

I think we should keep the separate xml targets as long as "asciidoctor
without xmlto" isn't the only way we support building the manpages. If
the only benefit here is "later", I think we should do this patch later.
I could also imagine that the xml target will just go away once all the
"old" ways of building the manpages are gone and `make info` is gone,
i.e., when we simply don't need any of these generated xml files.

[1] https://lore.kernel.org/git/20200402004533.GA6369@camp.crustytoothpaste.net/

Martin

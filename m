Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A94DAC00144
	for <git@archiver.kernel.org>; Sat, 30 Jul 2022 00:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239198AbiG3ATz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 20:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiG3ATy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 20:19:54 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D7C67C80
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 17:19:53 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id b9so5898677pfp.10
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 17:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=IVE6ESUaVt14TG8qFw/UpRetyKQEedhfJDzODPoM7ao=;
        b=DioaCobxBoWuEn/iPh5beqXanmNkW75MMXPQtuII/GuecEbVF8z/ADKkzgA4kiUvH7
         9isi7gk5L5s8AGwDlZqk+f4YsUBlhr7FzY/Si4Mno+D0U31L4QqqlmqoG8PUAS9i3BRD
         tpvPd1SjaVgJgboPAF9vKs9epaIiJDeJpab7wloKx+B3QKl7JwSJshKbBnx51gUuSSx2
         8xjjOzKV5pzqslZhVyDpw4DpYprQNyaSCVptjuiWY/H/gOTkC2BxuV5YLrZ+BF/OsJaX
         +04f4VXzegtgoR3IAS3NSwR24P0TSfXWGVAAmGvMipRQT2oTOAUISK01S1uhIbQgrXpA
         grog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=IVE6ESUaVt14TG8qFw/UpRetyKQEedhfJDzODPoM7ao=;
        b=S/nASeFQZhgf17N46eECBRyFhpPMth7pB2Er23oREpdB4e5eU7BZnlJZt7H8ZZPzHj
         IuhoKMAvLc0o0RQN61eFVGHoS3TcZy3iGP0gdN+gHFO6LrOalwGMtTMbn4KWg49d69n4
         zNwe1H6Z4bDeBKIrfZaX+nd4PZckTqm+GXHetbrd7/R/BsQQQ/yBOiMdZvs9nqyV9u1F
         c833u/SywhCYMc2zL+dtNH0Y7PO+N5BsczAHXoyF/DGce4APT8YeL6qoLH+Y39S1FDHu
         GnlzmjPwN/6rE+jVBMJ4uX5ymr+4yEXiGwk/UCpau1K0xASvscCtGbThN1SwBPlLHbHj
         JRXw==
X-Gm-Message-State: AJIora/lzVFeqzXGPV5F4gIQrWj81XTDCxrEqFkZ+AS/skX/wYgogAMu
        Zjm/ijKuEvpTjQMPtJ3aHbo=
X-Google-Smtp-Source: AGRyM1tN91FL2lCWOgfuy5e3KEb4xWTXgfgJUfiLVLqKAiWpDR3FMm4SLSchpJMoXqsUWtu7JlrE+w==
X-Received: by 2002:a63:8449:0:b0:41b:4a5b:c5ca with SMTP id k70-20020a638449000000b0041b4a5bc5camr4814677pgd.6.1659140392823;
        Fri, 29 Jul 2022 17:19:52 -0700 (PDT)
Received: from localhost ([113.173.163.90])
        by smtp.gmail.com with ESMTPSA id z12-20020a170903018c00b0016dd0242e04sm435758plg.276.2022.07.29.17.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 17:19:52 -0700 (PDT)
Date:   Sat, 30 Jul 2022 07:19:49 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] merge-file: fix build warning with gcc 4.8.5
Message-ID: <YuR5Jado2LrtZUjP@danh.dev>
References: <365e01e93dce582e9d926e83bdc6891310d22699.1659084832.git.congdanhqx@gmail.com>
 <xmqqbkt7api9.fsf@gitster.g>
 <YuQ60ZUPBHAVETD7@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuQ60ZUPBHAVETD7@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022-07-29 15:53:53-0400, Jeff King <peff@peff.net> wrote:
> On Fri, Jul 29, 2022 at 08:48:46AM -0700, Junio C Hamano wrote:
> 
> > I think the concensus was that we should squelch the false warning
> > on older compilers with -Wno-missing-braces, but then the discussion
> > has stalled by a suggestion to introduce a way to detect older
> > compilers that is different from how we do so at the same time, and
> > went nowhere.
> > 
> > Hopefully we can add a simple -Wno-* without waiting for whole
> > config.mak thing getting revamped this time?
> 
> Perhaps this?
> 
> -- >8 --
> Subject: [PATCH] config.mak.dev: squelch -Wno-missing-braces for older gcc
> 
> Versions of gcc prior to 4.9 complain about an initialization like:
> 
>   struct inner { int x; };
>   struct outer { struct inner; };
>   struct outer foo = { 0 };
> 
> and insist on:
> 
>   struct outer foo = { { 0 } };
> 
> Newer compilers handle this just fine. And ignoring the window even on
> older compilers is fine; the resulting code is correct, but we just get
> caught by -Werror.
> 
> Let's relax this for older compilers to make developer lives easier (we
> don't care much about non-developers on old compilers; they may see a
> warning, but it won't stop compilation).
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Tested on a debian jessie chroot using gcc-4.8 and 4.9. Though note that
> you also need to manually specify -std=gnu99 to get it to work at all
> with those compilers these days! So I kind of wonder if it's even worth
> catering to their warnings automatically.

Well, config.mak.uname automatically adds -std=c99 for RHEL 7 and
CentOS7. Can we add the same things for Debian? Or should we just
remove both?


-- 
Danh

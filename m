Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F75BC64E7B
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 08:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16FC420C56
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 08:08:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729929AbgLCIIg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 03:08:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728929AbgLCIIg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 03:08:36 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF3F0C061A4E
        for <git@vger.kernel.org>; Thu,  3 Dec 2020 00:07:55 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id d20so1387603lfe.11
        for <git@vger.kernel.org>; Thu, 03 Dec 2020 00:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bzzt-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/OpH/2VAagcmC9J6m+noqoSDKSX7Wn9Pv41QkMQhf7I=;
        b=J6PryFi04oUFdaT+tjTyq0Xkuv1t4FtSraWwJ1+8gy0/AjpVmMI1WyRMHWPQeQ9fDJ
         Iw6FcRSuW2ygIS6RFrUZXJNRXc3QQ1gNq90RC1/yCBNXBVeSaLuVPwjKd/p5+wP4Rb3V
         j6Ksye1nBnVmAm2NNPVTuSZAJAhaXztS3/E6ip9M9agthAcFkEBWndN3YTTafE4kFTiX
         GDpRgn38vyh5ToJiY5+CL4hdsjVWdUuVVFUpPEtHrU5d20oApFYzYHUqF/NlMVIif/dP
         Y3FDGn/PWuYCdE+u26ev0QxiUeL0zaPE1pddsBfBhzcxRdbrIyojKHPXsHFjLdBAdsAs
         eU4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/OpH/2VAagcmC9J6m+noqoSDKSX7Wn9Pv41QkMQhf7I=;
        b=kdL/FjBeO3aJ+3D/gi7ZE0VQq9QS0EpnBNon5OV98LmpInzxgezWdu59eP9y/BUSM/
         51mgPsw2KjpATZIMZQRZFe0C0byyIiOFSPTCL+E9i++rZO+H9Kqtl2Hr32b5sFErUFMy
         t4SRUcJ+FAqv/gh/NHt+ydaEBOjBpmz+IsS8pIAhZ2Gz8c7K8DRng2ycwTpybzcC8MNA
         6pouoYf36MbhhoR0m21PVvHn3tfnwF+Py4onzTZjjmgwzSkbfI7YeaFkEPTsY5XjZBO2
         vTuU5S9kXwf8Vn2YW3vazgWVUq8f+52bK28Km5ZU6FFSRwKSet4XjErEy5AhMk92QqUK
         03MA==
X-Gm-Message-State: AOAM5329fgKSzslVTcBSK2mALyd95p/wf2URByO95l/NZqtkWdCzYzLX
        QwchBxh+g59Oiy01x0sOLxouV9sg++ZxJzlxGnYSEg==
X-Google-Smtp-Source: ABdhPJz0Dw68/xtcl71mGAhCkKfonITB0UWW/2o5LC1TwcPCZWT6IApt9wUIPpxgFd6SrWhVSaX29CShT5LGA1wewBI=
X-Received: by 2002:a19:6759:: with SMTP id e25mr844108lfj.25.1606982874464;
 Thu, 03 Dec 2020 00:07:54 -0800 (PST)
MIME-Version: 1.0
References: <20201201095037.20715-1-arnout@bzzt.net> <20201201154115.GP748@pobox.com>
 <X8bhdyu/OlscI1ME@camp.crustytoothpaste.net> <20201202160755.GX748@pobox.com>
 <X8gnItjchqX4wwmt@camp.crustytoothpaste.net> <20201203020059.GY748@pobox.com> <xmqqim9jipre.fsf_-_@gitster.c.googlers.com>
In-Reply-To: <xmqqim9jipre.fsf_-_@gitster.c.googlers.com>
From:   Arnout Engelen <arnout@bzzt.net>
Date:   Thu, 3 Dec 2020 09:07:43 +0100
Message-ID: <CACDuYhu83q8L6DfDVJJgn9sOfrpnDtXT4JPQ5ea-BEKBhDaPiQ@mail.gmail.com>
Subject: Re: Re* [PATCH] doc: make HTML manual reproducible
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Todd Zullinger <tmz@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

First of all, I'm super impressed by the quality of the review here,
thanks for that everyone!

On Thu, Dec 3, 2020 at 3:31 AM Junio C Hamano <gitster@pobox.com> wrote:
> Here is what I'd queue tentatively to potentially reduce one
> round-trip (if Arnout is happy with this version, we can just hear
> "yes, that's good" without a formal v2).

This looks good to me, thank you!


Kind regards,

Arnout

> --- >8 ------ >8 ------ >8 ------ >8 ------ >8 ------ >8 ---
> From: Arnout Engelen <arnout@bzzt.net>
> Date: Tue, 1 Dec 2020 09:50:37 +0000
> Subject: [PATCH v2] doc: make HTML manual reproducible
>
> Versions of docbook-xsl newer than 1.79.1 allows xsltproc to assign
> IDs to nodes in the generated HTML consistently, to make the output
> resulting from the same source stable and reproducible.
>
> Pass the generate.consistent.ids parameter from the command line to
> ask for this feature.  Older versions of the tool simply ignores the
> parameter and produces their output the same way as before this
> change, so there is no need to check for toolchain version.
>
> Signed-off-by: Arnout Engelen <arnout@bzzt.net>
> Helped-by: brian m. carlson <sandals@crustytoothpaste.net>
> Helped-by: Todd Zullinger <tmz@pobox.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
> Notes (amlog):
>     Message-Id: <20201201095037.20715-1-arnout@bzzt.net>
>
>  Documentation/Makefile | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 80d1908a44..69dbe4bb0b 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -380,7 +380,10 @@ SubmittingPatches.txt: SubmittingPatches
>         $(QUIET_GEN) cp $< $@
>
>  XSLT = docbook.xsl
> -XSLTOPTS = --xinclude --stringparam html.stylesheet docbook-xsl.css
> +XSLTOPTS =
> +XSLTOPTS += --xinclude
> +XSLTOPTS += --stringparam html.stylesheet docbook-xsl.css
> +XSLTOPTS += --param generate.consistent.ids 1
>
>  user-manual.html: user-manual.xml $(XSLT)
>         $(QUIET_XSLTPROC)$(RM) $@+ $@ && \
> --
> 2.29.2-589-gfe47622759
>
>

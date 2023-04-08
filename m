Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136A3C7619A
	for <git@archiver.kernel.org>; Sat,  8 Apr 2023 22:45:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjDHWpx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Apr 2023 18:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDHWpv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Apr 2023 18:45:51 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC0E903E
        for <git@vger.kernel.org>; Sat,  8 Apr 2023 15:45:50 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id w11so1631572pjh.5
        for <git@vger.kernel.org>; Sat, 08 Apr 2023 15:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680993950; x=1683585950;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ATe1w12IxSAkAIbh/GpuJeZ/N6Wy8MKBAOBedZMgiJU=;
        b=qmXdk2yz4k8JyN9CLd8KNAt3GTaPbEabVRwQGOO2qO+i/hk9/NHMUEIrqwoDpPMic3
         aZddJWhKPaxA0AC4rfD7NBVfS8Mz+jKJ7T7B2UOVtFzhnZrcUqz71CCNKFodoXx60qDB
         Z73Q/npzMUVV4UWO8110/yaWK14BiKHGng9YjYdWpxrMzbznnFQA98d3mT9nz+RMW28O
         knCPzrbUT+cVPgMZoK+3Aat1Wr032pfSoPWM5jbcH73BCGNPhLLDO2tzTxETMoGWSyJ/
         Y8Uk6DO5FoEPg/1pF7iMD8cV2gdD2Z7O2TDwW9AO6kxx305ZApajruiuSBigHy8Ftu9w
         LQDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680993950; x=1683585950;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ATe1w12IxSAkAIbh/GpuJeZ/N6Wy8MKBAOBedZMgiJU=;
        b=vxCOEyPuVcuqwH9SqRgTTGyzaGTD9Fvhsq8AmzEG9cY33EREzwmV1PDcbh9gGzDUJO
         Qithel8zNJpzD3rKP4EBlmfe4wCTM0LIhdg4f1FztGu7psUp8qsotVn/lrk4pIlt+Mzs
         aFcNU0RGf0EFStI+TO9mViNRYUYtebWk4ixYdJVGWfr7roePQA082CFAd6rP5xH+Cbts
         xYRKhQI+Lj424119Hq1szSrNiMyYUg+LmoezvJr5DQqCH4eThO3swzKZf9gCyznpBEjd
         4CEbYGnTAjiv4tr/gFpcTqnBwlr9Hz4EgVl2Lj81llypa0f4AwDOSzr/qnmrvYbA27q2
         idEw==
X-Gm-Message-State: AAQBX9eFiplJ8eiTiVPDMt61lyDX1Sc2C/CYcGm+6PabPfa5la3/PDYC
        GMhpMHWfYLWPQkm/wvUjv0gHpqaYpaE=
X-Google-Smtp-Source: AKy350bYhnNID2DUBZDKReZswmLvliOOmfRfA0EGJ/gm9xNM89rBBwx0byaIViJcxgaZXXX/NFJ4Cg==
X-Received: by 2002:a17:902:ce81:b0:19d:778:ff5 with SMTP id f1-20020a170902ce8100b0019d07780ff5mr8598471plg.15.1680993950156;
        Sat, 08 Apr 2023 15:45:50 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id x19-20020a1709027c1300b0019f387f2dc3sm4988467pll.24.2023.04.08.15.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Apr 2023 15:45:49 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH] doc: simplify man version
References: <20230408001829.11031-1-felipe.contreras@gmail.com>
Date:   Sat, 08 Apr 2023 15:45:48 -0700
Message-ID: <xmqqr0suf0wz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index a6ba5bd460..4721b000c1 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -150,8 +150,7 @@ ASCIIDOC_HTML = xhtml11
>  ASCIIDOC_DOCBOOK = docbook
>  ASCIIDOC_CONF = -f asciidoc.conf
>  ASCIIDOC_COMMON = $(ASCIIDOC) $(ASCIIDOC_EXTRA) $(ASCIIDOC_CONF) \
> -		-amanversion=$(GIT_VERSION) \
> -		-amanmanual='Git Manual' -amansource='Git'
> +		-amanmanual='Git Manual' -amansource='Git $(GIT_VERSION)'
>  ASCIIDOC_DEPS = asciidoc.conf GIT-ASCIIDOCFLAGS
>  TXT_TO_HTML = $(ASCIIDOC_COMMON) -b $(ASCIIDOC_HTML)
>  TXT_TO_XML = $(ASCIIDOC_COMMON) -b $(ASCIIDOC_DOCBOOK)

Is this a complete patch, or will this leave us in an incomplete
in-between place?

We have some references to manversion in "git grep manversion
Documentation/" in asciidoc.conf and asciidoctor-extensions.rb
remaining after this ptach is applied, which presumably are no
longer used.  I would imagine that these leftover references end up
substituting them with something benign, like an empty string, in
the output, but it somehow makes me feel dirty [*].

Other than that, I like the simplification of requiring only two
pieces of information to convey the same information that we are
attempting to (and to some backends, failing to) give with three
pieces of information.


[Footnote]

* If I am not guessing correctly how the result of applying this
  patch works in the above "I would imagine ..." that led to my
  possible misunderstanding of feeling "dirty", it would be a sign
  that the proposed log message is not explaining sufficiently and
  deserves an update.  Even just saying "... and when they join the
  `source` and `version`, if `version` is left empty or unspecified,
  the resulting document would not show any extra whitespace.  So it
  is safe to do the joining ourselves and stuff the result in the
  `source` field" or something would be sufficient, I would imagine,
  in order to help the future readers of "git log" that there is no
  need to "feel dirty" the same way I did.

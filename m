Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07912C433DB
	for <git@archiver.kernel.org>; Tue, 29 Dec 2020 03:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D18C3207B6
	for <git@archiver.kernel.org>; Tue, 29 Dec 2020 03:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbgL2DSC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Dec 2020 22:18:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbgL2DSB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Dec 2020 22:18:01 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F31C061793
        for <git@vger.kernel.org>; Mon, 28 Dec 2020 19:17:21 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id f9so7292670pfc.11
        for <git@vger.kernel.org>; Mon, 28 Dec 2020 19:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=KBNvGNAtYdSTUWd9i4KNVole4vueysTeAgeIPZbvJUk=;
        b=gS6VOpupXjjRQxanVYFpdeKHCYGoH962+Z5NsyLLMbkTmEsk6p2IYdLe0GRe/lbDlp
         fOWC3E73x+AbSF5P5+GgIx4CkkZl0f0ijVGhdS25Eq6KghqJWlsukqgdYV1Jcibzeic2
         TPwMuyjQJWYwgDajp+NZcQdA6ldHPJxheUN2iA2lhz9RoloxVu9nfBIIW+lyejJORgAs
         VoXHVYLjV3AaSrJmwZNShq+LXx/ZtOFvMy/P6xXSXyZNosAmdEnZSfDHbsILTLHXVfVh
         LVrun2Fkn2lh8q8YaREBcFSWF1wGemBhyeQk2K7qXgJtN51hOVsV2xgTD5iprZ1uy2xw
         cWPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=KBNvGNAtYdSTUWd9i4KNVole4vueysTeAgeIPZbvJUk=;
        b=cCiwzxlp9B8GLQl+B/M/f4wI124K/JepzNaWm3Dx6p43lMM+jKi4DBy25w6hHV9sKh
         PEM6VyprqKi3LlYdOBhBRI8M0Bakp6eSBujj6iCxDruExnAESAbeLYBwkYGJZsdYQWXA
         Y3AD03H58/b/qtjcn8rtpQaeKh30GfPd3onv92UzpzV8y4bIg2oZx4p8OH7GcsW8tuNP
         TMl3eE7c/aKcmamiVUwsBVCczKukDpr/ACKLdxD19E3Te2ojO0X3ud9MdQhMPPIhBtFG
         XYB6QIgGB7ARK24uGLMSV2xTPYoAnIU4QTJvKLTBo7H8iSjCwjFPFE1GWOWr4RLlZhvV
         EqXw==
X-Gm-Message-State: AOAM533pWb1QJ1pishwXbsvw3ZkiScJSzqqahgYOkxn4KL/HYtLf8o1B
        Ek9tjkXlVMVo4CU6Rtx3SoC6ESHkrxQ=
X-Google-Smtp-Source: ABdhPJwiH12bdDtaxSfisRruIhWiRs5YkihLhVH3Nd5a5+eKTe4bwYW2SOXr/ZKkqc4mmuNAGvKbcQ==
X-Received: by 2002:aa7:8209:0:b029:19f:3002:513 with SMTP id k9-20020aa782090000b029019f30020513mr23016113pfi.49.1609211841322;
        Mon, 28 Dec 2020 19:17:21 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id 5sm37322208pff.125.2020.12.28.19.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 19:17:20 -0800 (PST)
Date:   Mon, 28 Dec 2020 19:17:18 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] CoC: update to version 2.0 + local changes
Message-ID: <X+qfvtcA9SiRjsvB@google.com>
References: <xmqq5z4mjdbq.fsf@gitster.c.googlers.com>
 <20201228171734.30038-3-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201228171734.30038-3-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason wrote:

> Update the CoC added in 5cdf2301 (add a Code of Conduct document,
> 2019-09-24 from version 1.4 to version 2.0. This is the version found
> at [1] with the following minor changes:
>
>  - We preserve the change to the CoC in 3f9ef874a73 (CODE_OF_CONDUCT:
>    mention individual project-leader emails, 2019-09-26)
>
>  - We preserve the custom into added in 5cdf2301d4a (add a Code of

nit: s/into/intro/

>    Conduct document, 2019-09-24)
>
> This change intentionally preserves a warning emitted on "git diff
> --check". It's better to make it easily diff-able with upstream than
> to fix whitespace changes in our version while we're at it.
>
> 1. https://www.contributor-covenant.org/version/2/0/code_of_conduct/code_of_conduct.md

Missing sign-off.

> ---
>  CODE_OF_CONDUCT.md | 153 ++++++++++++++++++++++++++++++---------------
>  1 file changed, 104 insertions(+), 49 deletions(-)

In https://code.googlesource.com/git/summit/2020/+/main/index.md, we
found this version of the contributor covenant helpful because it
provides a vocabulary for describing different ways to respond to
issues.  I think it's helpful for readers to have an understanding of
the range of ways the project leadership team might respond.

Acked-by: Jonathan Nieder <jrnieder@gmail.com>

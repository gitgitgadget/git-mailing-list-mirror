Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF98C433DB
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 13:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80713619A2
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 13:53:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhCVNxD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Mar 2021 09:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbhCVNwx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Mar 2021 09:52:53 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920A4C061574
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 06:52:52 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 16so21100668ljc.11
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 06:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ive2Y/G/WuLRRgQiuQ8M8GHrytxkNx5CEAns7Mdob/o=;
        b=fUIfo2XjVjjMYSPpTwTKCps/Ou1Sc7y4RxxEMNJAgbF2ksTFNUxjfRp7qfjM35TuHt
         aZq8roCup8HOKU4LaX61QiJdAKStgE9ENKRDSx3wW1ODrqNEEtVo7mYaCi1VLuK1UlXj
         AkiwkCvuRWBzRG7P1pzerd9c/sB7hO59MdI5pE57c2Q7cCY31KjDgcK4yfkmEaRliBsH
         HAbMqdHF5/nmt4+DNWO5QkYgXg/fc/RxZ/gBPGI/OUn0AHyAkeWiA6EhuzcBuQxUzOUE
         zn/MZZI5KNJtm6ymOlOL/cwtzugtUyY2MSQ0/0mGS7u5mcg1dSltC4dIP3NJcrarJGm9
         gBEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ive2Y/G/WuLRRgQiuQ8M8GHrytxkNx5CEAns7Mdob/o=;
        b=AOG/+uOlXKLeUtwF2rSbCGFVDRnMTv2bKzuXUd0sKIZUd48VsdCK8Xzk5Ayk779otf
         H2Qd/rbUCsB13qYEkGqhGMiVqCNWJK84VoUduI14KNHOfUKmhALwKhU+28vvA8aq4tgC
         Tkuq2kSSqbBVuAsKae6rEcEK7vPdfNWNDgj/9tnHcujYh8JBQq/hCFQi/fpxQrTRAFfN
         3YP4Ftiids3qNJlrY+Q2U5KjmFLOiMplTN24XmkFAcQSPDGqQ9x2bYwKCc2FVYmWXtt4
         RdnxNiodJIfDpgUofxKMv4XrL6iMf2VKDAHTAZPk5AegzaAwTgbaq1cSWQBTmOZnkrvI
         g/Rw==
X-Gm-Message-State: AOAM532W4oW/yjZJP+Dqy306RTZfC2TdhEUGA0yRE0ccOtlf8vN8+wei
        tyKWQn0B0ZYjj//mdpWN5q81D+xqJAJH3RfBLrAQHaP/eUJU9A==
X-Google-Smtp-Source: ABdhPJyamFYMh9QybOY8l+EKQYBOmd3n5u0L5x/iUEiJWDrOAafMp+caayLWcqebqtwy1TdFL1SNian9vt7Sl45pDXc=
X-Received: by 2002:a2e:88ca:: with SMTP id a10mr9569794ljk.55.1616421171050;
 Mon, 22 Mar 2021 06:52:51 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqzgyxijy6.fsf@gitster.g>
In-Reply-To: <xmqqzgyxijy6.fsf@gitster.g>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Mon, 22 Mar 2021 10:52:39 -0300
Message-ID: <CAHd-oW7zuRR2=2tU3J9NGeNCprE2p52aVK_RC0QSjsdzHLnZ=w@mail.gmail.com>
Subject: Re: What's cooking in git.git (Mar 2021, #06; Sat, 20)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Junio

On Sat, Mar 20, 2021 at 6:40 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> * mt/parallel-checkout-part-1 (2021-03-18) 9 commits
>   (merged to 'next' on 2021-03-19 at a1bc83ad8e)
>  + entry: add checkout_entry_ca() taking preloaded conv_attrs
>  + entry: move conv_attrs lookup up to checkout_entry()
>  + entry: extract update_ce_after_write() from write_entry()
>  + entry: make fstat_output() and read_blob_entry() public
>  + entry: extract a header file for entry.c functions
>  + convert: add classification for conv_attrs struct
>  + convert: add get_stream_filter_ca() variant
>  + convert: add [async_]convert_to_working_tree_ca() variants
>  + convert: make convert_attrs() and convert structs public
>  (this branch is used by mt/parallel-checkout-part-2.)
>
>  Preparatory API changes for parallel checkout.
>
>  Will merge to 'master'.

Sorry for my confusion, but are you going to squash the `#include
"entry.h"` fix [1] or do you want me to re-roll this series with it?

[1]: https://lore.kernel.org/git/19fee535ee0ec5211f22b2b69a4a9804816c2322.1616122653.git.matheus.bernardino@usp.br/

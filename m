Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36331C432BE
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 00:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22ADF60ED3
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 00:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236872AbhHTAEE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 20:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236976AbhHTAED (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 20:04:03 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2C6C061575
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 17:03:26 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id fa24-20020a17090af0d8b0290178bfa69d97so6103000pjb.0
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 17:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=7BEOjHSPoEYb0hyC5Yzr2rKr5xQ6ET9i9TQEFzaOoSk=;
        b=D1A/WGb/jTb+ZuRX7xLUUDt5SPntJ97cvBq18e7vW7jZA5Z7JMkqQ4fxHWLce3dktB
         9c2pigyqAOfRN3mcZoMpeMq0aOICSqLkou42qCm8QlGxVovjtK6As4o6EQ21Y5iJyFhG
         bpb8h/TJlTySNwVMSJoK2ADqKvmgYRab+nXhlVUjCox7fYE/X6B8a4k8ah6w4KKKQxsJ
         jBFCW6Oi+2zqFmEd5qx0aAxfeqD8LDXdTzKhXdGmOzpMjgdS44G3SOR3Qxmt+ztrd2Fr
         prmw3RQ5ptopOnToSd68A58CtJl31eMoj8sDMEo22UkdT9Ayxqse0RYlfhMo7+8oIpm9
         4S+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7BEOjHSPoEYb0hyC5Yzr2rKr5xQ6ET9i9TQEFzaOoSk=;
        b=fh2GcKRvnELCBfsjwzp3JQPJL0eQMsDfFrc2O/nG+Qu+XT+X90MjkZUqXsEOk/iKeg
         wWLekklyBks0PqikzgtokhwyPAeFrae+0QwNe+wJR+NdIVTXrhVa63XnGz07hVVSQ1Te
         PXFtQVhf7HTX8/crP1cPUCUiq4op9dlc22yYTP7VdsVHNvdVLBU60p7z7YozQi1ERRvC
         ziuv4qhH6OwcKsEddm2R3kluvM0idCOo1QEv28RDhNuDo16ZP+RwHtxZ3qoh0y8p/Ooj
         C7bmmJ2tudPC9Vo8Ss60x0ECMNgs0PvGL1fWDtGM45GWzdEILiqoZWJL8B0EPggDIuzW
         rxKA==
X-Gm-Message-State: AOAM531+LzPYJaQdrGMzjJS9qDpzvMZnXuSzvogT2dSzjIyTHSawjGTY
        p8eaxXYKPxpNwhlXMTT1aWlzRPk6AEUsMxncwUZzLg==
X-Google-Smtp-Source: ABdhPJwVH5RNanXMsjfOL2jvlQjDpQwbL6e1D7lM3NCHxb2h6CygeiM0vco0j6Qgb+nppJdkx/Q5VA==
X-Received: by 2002:a17:902:7b8b:b029:12b:8d3e:70e7 with SMTP id w11-20020a1709027b8bb029012b8d3e70e7mr14074317pll.76.1629417805777;
        Thu, 19 Aug 2021 17:03:25 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:5c:aa12:af53:acbb])
        by smtp.gmail.com with ESMTPSA id u21sm4685279pfh.163.2021.08.19.17.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 17:03:24 -0700 (PDT)
Date:   Thu, 19 Aug 2021 17:03:17 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v4 02/36] Makefile: stop hardcoding
 {command,config}-list.h
Message-ID: <YR7xRYWSDAHPH2NS@google.com>
References: <cover-00.27-0000000000-20210617T101216Z-avarab@gmail.com>
 <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com>
 <patch-v4-02.36-0f749530777-20210803T191505Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v4-02.36-0f749530777-20210803T191505Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 03, 2021 at 09:38:28PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> Change various places that hardcode the names of these two files to
> refer to either $(GENERATED_H), or to a new generated-hdrs
> target. That target is consistent with the *-objs targets I recently
> added in 029bac01a8 (Makefile: add {program,xdiff,test,git,fuzz}-objs
> & objects targets, 2021-02-23).
> 
> A subsequent commit will add a new generated hook-list.h. By doing
> this refactoring we'll only need to add the new file to the
> GENERATED_H variable, not EXCEPT_HDRS, the vcbuild/README etc.
> 
> I have not tested the Windows-specific change in config.mak.uname
> being made here, but we use other variables from the Makefile in the
> same block, and the GENERATED_H is fully defined before we include
> config.mak.uname.

Is it not something you can get coverage for via, for example, the
GitHub Actions CI suite? I wonder if that means we want some test to
check that these generated lists came together correctly?

Otherwise the diff looks straightforward.
> 
> Hardcoding command-list.h there seems to have been a case of
> copy/paste programming in 976aaedca0 (msvc: add a Makefile target to
> pre-generate the Visual Studio solution, 2019-07-29). The
> config-list.h was added later in 709df95b78 (help: move
> list_config_help to builtin/help, 2020-04-16).
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Reviewed-by: Emily Shaffer <emilyshaffer@google.com>

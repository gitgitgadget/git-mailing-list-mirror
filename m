Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A4F5C433F5
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 07:57:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbiJDH5g (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 03:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiJDH5d (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 03:57:33 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D65C2CC86
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 00:57:33 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 3so12077443pga.1
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 00:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=39x2lEUHCvkKAj0iTicxVbuc/O9TS7kGC5yWHkEUgQM=;
        b=kSJNuBrKjZ5opQUmWZK/YrLMXoBvKidBt5npuqE4zGu7joGfPD02nr8nT21x/UxpGE
         CscJOk4/dyxQXwiq36kkHkyPqud3Z5JxXbSm8Dswd7P2LtqS4Kko4hm4EKdS+nCaCqec
         WQhdLNdJpLm1u8gjlYzi1N13m3IyjqJhGZq7Ax6+gBeDtB+FsSTZf0aNkA+VaPnto+BQ
         yrBt9GseEMMl+HwGJZ+xSz6DluGZ5H0QZwdkWWZsI0nrykCwQXvNvu72xFIKebgNglTJ
         VShjm/iGjxTQRm1d5GcEBRLe470tLDxvRjJkN+dxb00WFmqjg58VzM1tBJAvLnB5aWsp
         RPEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=39x2lEUHCvkKAj0iTicxVbuc/O9TS7kGC5yWHkEUgQM=;
        b=5z3Rd3C21U/+gjzNReE14ZnCw5gonw81CJDlv9/d4CWbFPqQDjVaKklkkak0uFjOeo
         7/AHnhYur7DslpNolF+SkDVOvKVNCCLjyhDidwTU+6Ec0Rio+BC/PHQ43JlTyhH1u6tQ
         bGGLM31PIpNayb3lPVv762tewFkA8Nc6aYf+GQv040FZpSIIAzDjwUMJ8SKQwkyYpoie
         LcN17VYQ6rQcFwp/tunLZf0wJ0IPlBnxKnY4i+v3k2qPBJHp/uyBRNw0vqOOPPJkNV8s
         1n0sgLEPIRDGWUL5pMYSLuZbbe2/uzEXu2mwuOgdQdpyy39q/scCZQPYExn/enC2VSD/
         eLYQ==
X-Gm-Message-State: ACrzQf1UVX4IRynBGfXIDLdMePH40ut27Dd0/QzIesafjKDcWVpIrBC6
        CScl205sSP4B8fsaxNG34YJAZG1uPQ0=
X-Google-Smtp-Source: AMsMyM7/GRP1uIsQWJVUiC6Bir1J//H0skV2Y6gbCpT02N7Kvh3rTKhfHwu4paZi1ETwcbNzGnw24g==
X-Received: by 2002:a63:cc43:0:b0:43a:2f12:d326 with SMTP id q3-20020a63cc43000000b0043a2f12d326mr22177151pgi.320.1664870252849;
        Tue, 04 Oct 2022 00:57:32 -0700 (PDT)
Received: from localhost ([2001:ee0:500b:6370:da47:cda5:dbd5:6e77])
        by smtp.gmail.com with ESMTPSA id h70-20020a628349000000b0052d98fbf8f3sm5977521pfe.56.2022.10.04.00.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 00:57:32 -0700 (PDT)
Date:   Tue, 4 Oct 2022 14:57:29 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     darkdragon <darkdragon-001@web.de>
Cc:     git@vger.kernel.org
Subject: Re: Install-prefix when building should not be hardcoded
Message-ID: <YzvnadnAYce0dIpi@danh.dev>
References: <CAAOCJVAML0axQXbYZncT945SuG3-GfmDtDQ4_8cnkQmF_SZtHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAOCJVAML0axQXbYZncT945SuG3-GfmDtDQ4_8cnkQmF_SZtHw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022-10-04 09:38:24+0200, darkdragon <darkdragon-001@web.de> wrote:
> Even though in Makefile, it is stated that git will figure out
> gitexecdir at runtime based on the path to the executable, there are
> many output files where $(prefix) will be hardcoded. Even git
> --exec-path will print out $(compile_prefix)/libexec/git-core instead
> of using run_prefix.

I'm not sure about this part.

> Example: We are building git in Docker at a separate stage to /deploy
> (since /usr/local is populated with our compiler toolchain). The final
> image is assembled by copying the contents of /deploy to /usr/local.
> Commands like "git submodule" will fail because of the wrong git exec
> path. Searching via "grep -r /deploy" in /deploy after make install
> yields many results.

But you may be interested in $(DESTDIR)

	make prefix=/usr/local all
	make prefix=/usr/local DESTDIR=/deploy install

Does that work for you?

-- 
Danh

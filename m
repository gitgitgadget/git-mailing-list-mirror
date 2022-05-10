Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C7CC433EF
	for <git@archiver.kernel.org>; Tue, 10 May 2022 18:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349064AbiEJStP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 May 2022 14:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349170AbiEJSsU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 May 2022 14:48:20 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9779B6669E
        for <git@vger.kernel.org>; Tue, 10 May 2022 11:48:18 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id kq17so34754810ejb.4
        for <git@vger.kernel.org>; Tue, 10 May 2022 11:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=QRDI3pMpz+AH/VjumWhljc4Ic+9+QfydQUthNmiEKCk=;
        b=DMIQyoVJxRICaRERsSUQu2EChsYyhDX+I2ogqmu4Jt6XuscREzascmZ4J2wljBP52w
         RR25s5745gsDUZrbS9BCz2XAhnC80gfAUwbjtvCnnnIPg5PSxeepKPYotYFktKXiPK+z
         HIuXKEXc5i8auTOytrQUoKD2p/OP4D1FWCB929Ro4EwR7OLsiRdC+j7VrBBS86iwugTE
         vVFeePCTJ3jpM2WxPnXQMD2jhYSLITKNpRYYe9hs9qEbVIZsQD5TjTf76+NEa4oh36gT
         0kyNolwjGxbm++LlmNrARUrt32Uyh/wU15jT5M+GZC92V2BpRdMleDcvOU3x4HGOM+nP
         LnNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=QRDI3pMpz+AH/VjumWhljc4Ic+9+QfydQUthNmiEKCk=;
        b=LRgszOeeGMImLqxhl+T38zfpcndWY2suQoFXxVnEFcljleNucOaTbWfUSHbbVebdCK
         e8LYMx++RB/fx7FsHf5XLJ3AWq7QmxRNEi1DUOeqtIv+REQapMV4DfIpCEh0Ltlm1ZHj
         mP6cqPY5xYZFBLvOnYnG/KQlpM3v6LdPJ8qwpx+OliAtz/XDQDkhXYHJsW87OJGa4yyT
         OIkA/JpnarrxYaQTLgRBbwlNZvoqPkGdnOoA20oaMTf+ikjAhSJijzQyfgJN5zd9q1Ab
         ekaKwAsh0y4yrPZzbVqHO1+xpBDZCeMu8yMR06TCE9J70/KuyM+jdXUqMPIlIzlcFHj5
         UOag==
X-Gm-Message-State: AOAM531Ka7UXRyK2jLtRHXQpOIXmo7M8/iVFMvKnt11LrcsF5GTXLiPL
        oWeLmDuKMKa80xUcBXaiS98=
X-Google-Smtp-Source: ABdhPJyTnLr6UlU8P8A1x0PIis9ZUco9CFsX4I3HIInkLMLWDl1yUG5Ja+pnVNTEKE2+Z9TiH4btkA==
X-Received: by 2002:a17:907:7212:b0:6f4:fdc7:b7f3 with SMTP id dr18-20020a170907721200b006f4fdc7b7f3mr21354251ejc.16.1652208497204;
        Tue, 10 May 2022 11:48:17 -0700 (PDT)
Received: from localhost (92-249-246-75.pool.digikabel.hu. [92.249.246.75])
        by smtp.gmail.com with ESMTPSA id d5-20020a1709061f4500b006f3ef214e47sm34056ejk.173.2022.05.10.11.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 11:48:16 -0700 (PDT)
Date:   Tue, 10 May 2022 20:48:15 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 3/3] safe.directory: document and check that it's ignored
 in the environment
Message-ID: <20220510184815.GB4408@szeder.dev>
References: <pull.1215.git.1649863951.gitgitgadget@gmail.com>
 <20220427170649.4949-1-szeder.dev@gmail.com>
 <20220427170649.4949-4-szeder.dev@gmail.com>
 <xmqqlevql0lj.fsf@gitster.g>
 <xmqqee1il09v.fsf@gitster.g>
 <20220509213915.GA2043@szeder.dev>
 <xmqqlevabcsu.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqlevabcsu.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 09, 2022 at 02:45:21PM -0700, Junio C Hamano wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
> > repositoy could trivially safe-list itself.  However, it's unclear (to
> > me) why 'git -c safe.directory=...' is ignored: 8959555cee
> > (setup_git_directory(): add an owner check for the top-level
> > directory, 2022-03-02) only states that it's ignored, but doesn't
> > justify why.  Now, let's suppose that there was a compelling reason to
> 
> Correct.  I do not think it is a restriction with any sensible
> justification, just that it happened to be implemented that way.
> 
> IOW, I am saying that GIT_SAFE_DIRECTORIES may be a lot nicer user
> interface than fixing the "we ignore 'git -c safe.directory'?"  bug.

In light of this, I'm not sure we want to test said buggy behavior.
IOW, do we want 2/3 and 3/3 of this patch series at all?  Or perhaps
add those test as 'test_expect_failure' instead?


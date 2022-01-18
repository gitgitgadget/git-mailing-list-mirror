Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D57D7C433EF
	for <git@archiver.kernel.org>; Tue, 18 Jan 2022 21:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349467AbiARVCN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 16:02:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244694AbiARVCN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 16:02:13 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE01EC061574
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 13:02:12 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id o7-20020a05600c510700b00347e10f66d1so3143440wms.0
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 13:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=I9O8IZAy73m1EceqsEYa5LjjEq3aGY46F/2fWciXjCU=;
        b=B7LYe9VmLeBV7shBUmpq4lQTBHu1WxOwCFWrK2jNmzn278jNeZU97Hoh8BduWPRRej
         NYPIJ8zDdX6f8H4bDmmLrhX+zpmnQCwMbE5GwUTNuHacTUDWQk/Zk4xTJkkak6vfLGxr
         5y8Lgb2oqiKG3QiXiXJELkwv6R5aPT62lfDb14MHi3PFNHTbDSDOKoy3YZRx7OozzwDw
         TFSs/vpw75V6mYS0EuJyhPQSLpT3Ny1+GlZifhDmbHUiAAWNA8eKmVVCg7ncD9C8oD0D
         oN3pN217IT07rrciqw+0V0c8hwEPURRsJ5rxbM8kutiG1bJ6jIVzZ7nI99b1BiVlMNhm
         /3KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I9O8IZAy73m1EceqsEYa5LjjEq3aGY46F/2fWciXjCU=;
        b=N21iLpdn9m22c0UgQPAfpYB9N3YIVHx/CSPwci/v2wdExanKlITh+ivcpe1CshMR7r
         GQATTYTX2lmrq4SkresjMr0xCDq3FhfQ4NlyKOqEjdZ8x02Dwhc0hFGT+Z9N9v6DXryV
         TzpWzHhkXF6/0UbnlaTJAyX2aO6tk5kgiV9Jfr4bXnT2DhPluEJZtNIVAwa9Ww26Jo4E
         BgqNYL2V9v6x4Re1XXGO29LhGng7WzPxpzli5X0LRez8yZozf5fGREDj15gYVUg0tHMN
         /VywXyN5AxH4LVcubZS9nNSQ02M968CWGaoPRXyJDggUDGDdovEMMOUAgPmQ/IreNYEA
         FEbw==
X-Gm-Message-State: AOAM530M5VFX3XVGIR+WyTpmp1q0li60kXYmA3mcR1MkIY11C5uiWk4n
        uxp7GlfWgK2oOZOwJWrwpkY=
X-Google-Smtp-Source: ABdhPJzi4fZUEnebTGrFCtHfktgULNIBbSeCuhAF2GgS9+L9VY2R2xvtncpvhjUO6BxAq/jrxwPtWA==
X-Received: by 2002:a5d:6c68:: with SMTP id r8mr26898588wrz.37.1642539731346;
        Tue, 18 Jan 2022 13:02:11 -0800 (PST)
Received: from szeder.dev (94-21-146-14.pool.digikabel.hu. [94.21.146.14])
        by smtp.gmail.com with ESMTPSA id r206sm2984191wma.26.2022.01.18.13.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 13:02:10 -0800 (PST)
Date:   Tue, 18 Jan 2022 22:02:05 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        johannes.schindelin@gmail.com,
        Lessley Dennington <lessleydennington@gmail.com>
Subject: Re: [PATCH v3 2/3] sparse-checkout: custom tab completion
Message-ID: <20220118210205.GA2632@szeder.dev>
References: <pull.1108.v2.git.1640892413.gitgitgadget@gmail.com>
 <pull.1108.v3.git.1641841193.gitgitgadget@gmail.com>
 <256e5f034c6072b6e3621adfa96c5c6319752fae.1641841193.git.gitgitgadget@gmail.com>
 <20220115095725.GA1738@szeder.dev>
 <CABPp-BGR+UrW5ej-8+XXHPkjMfFgURycd9rWC+2awUvYcr_PXA@mail.gmail.com>
 <xmqqv8yjz5us.fsf@gitster.g>
 <CABPp-BErg-RtyycXaRXYfQHEQXA4q-FU9Q6nYkSHJsqL-04oXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BErg-RtyycXaRXYfQHEQXA4q-FU9Q6nYkSHJsqL-04oXw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 17, 2022 at 10:14:58AM -0800, Elijah Newren wrote:
> the
> documentation never explicitly states files are acceptable to
> sparse-checkout {set,add}.  It always mentions "directories" and
> "patterns".

The "Full Pattern Set" section of the manpage does in fact explicitly
states that files are supported.


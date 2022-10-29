Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43156C38A02
	for <git@archiver.kernel.org>; Sat, 29 Oct 2022 20:15:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiJ2UPV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Oct 2022 16:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiJ2UPS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Oct 2022 16:15:18 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6DC12AE3
        for <git@vger.kernel.org>; Sat, 29 Oct 2022 13:15:07 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id p184so7114257iof.11
        for <git@vger.kernel.org>; Sat, 29 Oct 2022 13:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=o6cMI6qugdD1yphWKn8L3fhyQ6L5fHiweKv8jHHzt7I=;
        b=7sCMCbHGS6oXUc2+yEI1mwkrathyBiDuFsxGPiQC7H1dgv5ghNsygwSW1oIgo69A2b
         Mks6KPQdyrs6+RU8VXmGDdZOyytiLdWvT1MFdVyhDEKxyHp1HGT17301Uux3kbOmcxYe
         AkPljgSbD+kXMJYG2vE5PCG60PQ/ycQ7vLn0BNaCvikmuURhIgc8hWTDkz07MDnp7qsY
         Kge6vTuy/29PrOEN2JjtHqW/E9Q/mUxI8OTanVKbGY/LXf7YRlsC/r38PVA7fV4cNBdK
         Ag76otNeGEhXX7gEyHutuIPS/awDxLh+7hio416q2CjeIyAYQNEqxMrHUqLWOZM4dt4c
         szTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o6cMI6qugdD1yphWKn8L3fhyQ6L5fHiweKv8jHHzt7I=;
        b=21zVLllkA69bA28E2EkWdbtrMEe9GxC2D4DocsTe9kZ2Nv9ho1wHQ9TFBouY7Fk/PJ
         4VyxZ84egyrW4GvQL8q1YwZBukn1HIZ0O1vDxicZJtsWVYg9hnUuylB8P5/XGZh9xeMi
         s7/WBEab/nihP2EF53q5ThEUcLsIYqcEGDhjmeb7c9RaJfUBIGHGZ3DRdvnMlGaMHTU7
         3l8Ei9/RGoECh9TF2uTb6QIc4pV5KP3bTA+6H7tEiUufIRov5WdpMZ+wqrFRhBLHN5oH
         7qRqvLtVMPUe7BJ4mGWzkJIe/td5QDQU1U+10dbQnoHJkyG7hJHmAHSREgPu4k0JhqGa
         LPkg==
X-Gm-Message-State: ACrzQf3JlVL7iAnw79SVpxliMUubLmqCtx6i+SvkrtIEhikrY/YlTab+
        zMJ+TfxQTXtprdK9Cm5GdKw1rQ==
X-Google-Smtp-Source: AMsMyM5fJ+586tfYUmpAzGSOdiR39Ht19ifiO/+9HgjhqEeRVUqtCFtoKc8ZjHKrb12xE0jkTbxGug==
X-Received: by 2002:a05:6602:334c:b0:6c1:819f:fe55 with SMTP id c12-20020a056602334c00b006c1819ffe55mr2665895ioz.43.1667074506957;
        Sat, 29 Oct 2022 13:15:06 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m3-20020a924b03000000b002dd0bfd2467sm903217ilg.11.2022.10.29.13.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 13:15:05 -0700 (PDT)
Date:   Sat, 29 Oct 2022 16:15:04 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Calvin Wan <calvinwan@google.com>
Subject: Re: [PATCH 3/3] run-command tests: test stdout of
 run_command_parallel()
Message-ID: <Y12JyOQZT8xKHC7k@nand.local>
References: <cover-0.3-00000000000-20221029T025520Z-avarab@gmail.com>
 <patch-3.3-6d6c2241bf2-20221029T025520Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-3.3-6d6c2241bf2-20221029T025520Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 29, 2022 at 04:59:47AM +0200, Ævar Arnfjörð Bjarmason wrote:
> Extend the tests added in c553c72eed6 (run-command: add an
> asynchronous parallel child processor, 2015-12-15) to test stdout in
> addition to stderr.
>
> When the "ungroup" feature was added in fd3aaf53f71 (run-command: add
> an "ungroup" option to run_process_parallel(), 2022-06-07) its tests
> were made to test both the stdout and stderr, but these existing tests
> were left alone. Let's also exhaustively test our expected output
> here.

Makes sense, this patch looks good. Thanks.

Thanks,
Taylor

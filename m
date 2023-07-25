Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2366EB64DD
	for <git@archiver.kernel.org>; Tue, 25 Jul 2023 22:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbjGYWqP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jul 2023 18:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbjGYWqD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2023 18:46:03 -0400
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA6B6E90
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 15:41:35 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-577497ec6c6so72027187b3.2
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 15:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1690324766; x=1690929566;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fb6pglrRirxp+CHTFvC9tKeYn2r5t+eAKTchETIMdx8=;
        b=gO2vUCRnpmrzOpQ/m7X0B3HKhM4GIUbJ/J1VMcxMgT0cEthiu1bkX3fA4xyp3hY2KW
         35JieSwUESp/EvrSNhSbmPR4Vrpj3YMGuDQyelfQtHDyMm63ZDU3eONGxLd4EjNFSOGT
         Ck6/uoIIUbm6M8E7Vmk2aQBUkDPDI2BtrQOGZ3f2yXi5KiCZBsdeR6ohSynmihX8eNN8
         MRKUmsjGIkWxvOmPv0YSm3ErSMFwgZ3x7gHPiaqS3eGp+by2YkqW3l9BsZDtVgLS3LZ2
         MvsZAUxBng7U7b4tZk5Ye2+ZNB8Lk6VhBXGG3zE9HxsPQpNqUqZciUsD1WAKUT3F7quN
         RHng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690324766; x=1690929566;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fb6pglrRirxp+CHTFvC9tKeYn2r5t+eAKTchETIMdx8=;
        b=AbWAZwfplEzsbKDRQBYTRD36mKP8cbmiIz/g2ZAFjvBCMENhNflBggoINHiZ49gXus
         zvzBt4az2BrRG05okZYHF2pbz+v70+IGQSilzmVOnPBttb64DpS73vSK1qUV2MhDug4/
         tx/dgbUjDSXlGeMyrefKOBX1Lc9rEPBuKKJtyMHR04hZDYeUV02rJTGT3ZTmPOEFYjGM
         bTECrPBQOhvTPFNaPon4kIaPwRQ4DAXakUaG+vYzcykyGnKRfo7wX+KtmQeUDlUH7Aey
         +M1l4jTOEUu+z2SVktP4Ea+uwwiVQ6/Q39bgjQerftP51vgqbRDJW9o0whqXKElRmbkU
         oiXA==
X-Gm-Message-State: ABy/qLYJ+FRc5WmHigDTN/Sf0Y8LWjPTfBamuYDbLWHAJE0k9dw63/QK
        drZiuRwUP5r2flgWewtRbk/kmw==
X-Google-Smtp-Source: APBJJlGHU3MLxp6oPM30fip1+aQcZoNP06BgHwlN+2seO4tgDrkXqlUYVTouv/7Owx3pvcCUNT+dow==
X-Received: by 2002:a0d:c143:0:b0:583:fa2b:26d2 with SMTP id c64-20020a0dc143000000b00583fa2b26d2mr599438ywd.7.1690324766562;
        Tue, 25 Jul 2023 15:39:26 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id j22-20020a819216000000b00583f9bcd531sm1632749ywg.97.2023.07.25.15.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 15:39:26 -0700 (PDT)
Date:   Tue, 25 Jul 2023 18:39:25 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2023, #05; Tue, 25)
Message-ID: <ZMBPHTIacaWjy99D@nand.local>
References: <xmqqedkvk8u4.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqedkvk8u4.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 25, 2023 at 01:57:39PM -0700, Junio C Hamano wrote:
> * cc/repack-sift-filtered-objects-to-separate-pack (2023-07-24) 8 commits
>  - gc: add `gc.repackFilterTo` config option
>  - repack: implement `--filter-to` for storing filtered out objects
>  - gc: add `gc.repackFilter` config option
>  - repack: add `--filter=<filter-spec>` option
>  - repack: refactor finding pack prefix
>  - repack: refactor finishing pack-objects command
>  - t/helper: add 'find-pack' test-tool
>  - pack-objects: allow `--filter` without `--stdout`
>
>  "git repack" machinery learns to pay attention to the "--filter="
>  option.
>
>  Will merge to 'next'.
>  source: <20230724085909.3831831-1-christian.couder@gmail.com>

This may be a little soon to merge into 'next'. I looked at version 1
and had some concerns, but haven't had a chance to look at version 2.

Now that we have a third round, I'll take a look at it now. Sorry for
the hold up.

Thanks,
Taylor

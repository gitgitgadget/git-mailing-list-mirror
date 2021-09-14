Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245F3C433EF
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 05:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5892610D1
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 05:43:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239634AbhINFo0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 01:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239462AbhINFoY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 01:44:24 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27FBC061574
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 22:43:07 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id b7so15408711iob.4
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 22:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=DCuSnxTPpvX13xAxhurnUrKZbchQ9kqQsaqqBuDtcTE=;
        b=eHOI9sO4KLwzylC25lpdQrfSF1o4hD0eGTSyVIeKPfGKxcmmEgBpV46pACM9MOnOxM
         D36lgwIAHkLFs5vKXd2vDxCRBUWtJJ/1MonSccOClBVQK0lCy+Sas++MkxenmAFm8dJO
         PIWWvb874ffnkhH/ApxVnY0o616892LeTZtxIu/a2R568aaA9Zr0ofl3d40oavCQEqD8
         s6or2UbWf0ekvP9S/LTHe1FgtemZ+6Ts7lbhBuTEeDsM6q4MSL+zCOKTdxpDAePCXQOx
         CFQ1uEyUl69h7lfS4cIOBuRSXz0a/jhiuoUIWUTDSZEb+vNhIZNal7gfyMxwjRabeAg4
         /hVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=DCuSnxTPpvX13xAxhurnUrKZbchQ9kqQsaqqBuDtcTE=;
        b=qe/MpNhlYS37Vck1GOUqaaV31kIN6seu1zdGBA5UWxa3ov3LCyqBG6b70m8VScZ1BU
         UzOagiaPLfh+v+MAu2JwJAkT/h05FL4a1Mri4HjYsl5BEeKT1eLmgw3A+yb+gpCQvaLV
         D6vdBTzh1bDMwIpzjmGuX9goeftOxNyWkKcVcNmayGp+ffQl2GrL9zUPnV7SD8d3L9ep
         hDwprrFsk9JpmWvYAZMrM/XIGoKFJhAoIJLT3TWv7LbkfCUVgHQ1zrdF4pfC3ZRX7daa
         WEDBLh2ENK7fhOomV5MC4/yBgOis2ysUIlwzeMiJltuwDGXfaHVLn+Z2Y8Y70o1bkQq1
         csKA==
X-Gm-Message-State: AOAM533Gl32mZE02dWqzTcUiz/vPwNUXy9t3eopMz7FQ27gyzTRAJg1y
        Lx9q/gPBWWUruJByW7oshHb06bP64YhQzTpW
X-Google-Smtp-Source: ABdhPJw4mQSREuEfvEFLPYtRfn/2o9Fqe+IsfKhLXztRyuBT3nnFXp1LyUIvcdKrIfb7+Be5J0Ks+A==
X-Received: by 2002:a5d:9253:: with SMTP id e19mr12220097iol.35.1631598187197;
        Mon, 13 Sep 2021 22:43:07 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y11sm247750ilh.73.2021.09.13.22.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 22:43:06 -0700 (PDT)
Date:   Tue, 14 Sep 2021 01:43:06 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2021, #04; Mon, 13)
Message-ID: <YUA2ajsm8q2EtH9h@nand.local>
References: <xmqqtuinc3tx.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqtuinc3tx.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 13, 2021 at 07:02:02PM -0700, Junio C Hamano wrote:
> * tb/repack-write-midx (2021-09-10) 8 commits
>  - builtin/repack.c: pass `--refs-snapshot` when writing bitmaps
>  - builtin/repack.c: make largest pack preferred
>  - builtin/repack.c: support writing a MIDX while repacking
>  - builtin/repack.c: extract showing progress to a variable
>  - builtin/repack.c: keep track of existing packs unconditionally
>  - midx: preliminary support for `--refs-snapshot`
>  - builtin/multi-pack-index.c: support --stdin-packs mode
>  - midx: expose 'write_midx_file_only()' publicly
>  (this branch uses tb/multi-pack-bitmaps.)
>
>  "git repack" has been taught to generate multi-pack reachability
>  bitmaps.

I think that this is in a good state, although I would like to get
another review (particularly it would be good to have somebody weigh in
on the --refs-snapshot format question that Ævar raised [1]).

[1]: https://lore.kernel.org/git/87sfyb8ihg.fsf@evledraar.gmail.com/

> * tb/midx-write-propagate-namehash (2021-09-12) 4 commits
>  - t5326: test propagating hashcache values
>  - midx.c: respect 'pack.writeBitmapHashcache' when writing bitmaps
>  - pack-bitmap.c: propagate namehash values from existing bitmaps
>  - t/helper/test-bitmap.c: add 'dump-hashes' mode
>  (this branch uses tb/multi-pack-bitmaps.)
>
>  "git multi-pack-bitmap write" learns to propagate the hashcache
>  from original bitmap to resulting bitmap.

Another reroll coming, but the series is mostly unchanged (the reroll
fixes a couple of test and perf-test related bugs and adds some
performance numbers).

One small nit, s/multi-pack-bitmap write/multi-pack-index write
--bitmap/.

Thanks,
Taylor

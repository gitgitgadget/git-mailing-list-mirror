Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11922C11F67
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 22:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF1CA61CAB
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 22:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235469AbhF2Wqf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 18:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233056AbhF2Wqe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 18:46:34 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84BC3C061760
        for <git@vger.kernel.org>; Tue, 29 Jun 2021 15:44:06 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id h2so685187iob.11
        for <git@vger.kernel.org>; Tue, 29 Jun 2021 15:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=9uOxC4gbC8az3O1QhukX9bHZUSzEnRFkjZMcK2blOy8=;
        b=106r+K8xY/krk+h5jZ7LgE7b7EFAhMKs7xX4PiAAJbaWFCkuKtN66WmU+gFZviYfEN
         vX9gEXJho9PUneGFybvYAcMZMdAV+XLDQuTL/WagIGMCWk7XLhfTv2JV9nZN52K6u342
         6I7japB0PdYTyjppGrATy+73oMxJQ62Mo52WsSvsJtHlCGzJ57hpXqwG/cNfsL9yI31q
         20ZZ1XJ+9/mc0BYxrZIcxWm4ETlKrG1/uSztEQOxIxAyHnoWXFMH1h024Qp5J1QzPklf
         qwLV7+2x+VeRiTmpxOqKCnWWOdG409EIfM1D2ZH7+gXmal71w0ChIlQ4FwvES9pM9GHm
         4CIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=9uOxC4gbC8az3O1QhukX9bHZUSzEnRFkjZMcK2blOy8=;
        b=XV4U//DpGXvAm7k0kwOvQ6Cwr4LFkDISlpteJah2cGjiZo/R5rT+1tPM61j6xs42WR
         a+I2XAyPv9E3NbUZNDMcImt7I7ozXvQM726g/OX5l5GR+Mz1pK3jq1gvWMQFkVw5dcFY
         nRWGRCZqpVRxLW+XBj4kYpW8zZXQCFodRxycgUbZ3D3xfXTDCh/c6nO/TQCYMG+WWxg9
         bITpN/FA96vfbnDKu3GSBvcUiWegV+HcUVqZvlfZU3+ag0Nf4jB7rD1i/xfsVgHCJLxG
         0vElTdKgu4H05k6uRAvy36p+zBJEbGBJK8epyMGhG0PXqXC1jB8Lh+ic9z0hQYoCfWCy
         saQA==
X-Gm-Message-State: AOAM532zDxq8d7tZmohFpNUlAcgWQPSMAN0bn7TuQyIsWIXIjK4rC1+K
        s3Ko0RPWV39hF2TWp6WoGNTZ2A==
X-Google-Smtp-Source: ABdhPJyR4M0FW2TKHb2OhjDab4hZNKItFuhKS+fYhccBr1Dd1C+AY32QAVSC/ladQMGDs0oJ65vFAg==
X-Received: by 2002:a02:cb82:: with SMTP id u2mr6550858jap.8.1625006645899;
        Tue, 29 Jun 2021 15:44:05 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id l26sm10542523iok.26.2021.06.29.15.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 15:44:05 -0700 (PDT)
Date:   Tue, 29 Jun 2021 18:44:03 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] connected: implement connectivity check using
 bitmaps
Message-ID: <YNuiM8TR5evSeNsN@nand.local>
References: <cover.1624858240.git.ps@pks.im>
 <7687dedd4722c39b5ecef2c2165147c25d16b8d9.1624858240.git.ps@pks.im>
 <YNovuzAsaEb2uIaa@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YNovuzAsaEb2uIaa@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 28, 2021 at 04:23:23PM -0400, Taylor Blau wrote:
> I'll try this out myself and see if it's worth it. (As an aside, I'll be
> offline next week, so it may take me a little while to post something to
> the list).

I gave implementing this a shot and it seems to have produced some good
improvements, although there are definitely some areas where it does
better than others.

Here are some results running on linux.git with a cold cache, counting
objects for commit 2ab38c17aa, which I picked deliberately since I know
it has a bitmap:

    $ hyperfine \
      'GIT_READ_COMMIT_TABLE=0 git.compile rev-list --count --objects --use-bitmap-index 2ab38c17aac10bf55ab3efde4c4db3893d8691d2' \
      'GIT_READ_COMMIT_TABLE=1 git.compile rev-list --count --objects --use-bitmap-index 2ab38c17aac10bf55ab3efde4c4db3893d8691d2' \
      --prepare='sync; echo 3 | sudo tee /proc/sys/vm/drop_caches'

		Benchmark #1: GIT_READ_COMMIT_TABLE=0 git.compile rev-list --count --objects --use-bitmap-index 2ab38c17aac10bf55ab3efde4c4db3893d8691d2
			Time (mean ± σ):     141.1 ms ±   2.5 ms    [User: 13.0 ms, System: 64.3 ms]
			Range (min … max):   136.2 ms … 143.4 ms    10 runs

		Benchmark #2: GIT_READ_COMMIT_TABLE=1 git.compile rev-list --count --objects --use-bitmap-index 2ab38c17aac10bf55ab3efde4c4db3893d8691d2
			Time (mean ± σ):      28.7 ms ±   3.2 ms    [User: 6.5 ms, System: 10.0 ms]
			Range (min … max):    22.0 ms …  31.0 ms    21 runs

		Summary
			'GIT_READ_COMMIT_TABLE=1 git.compile rev-list --count --objects --use-bitmap-index 2ab38c17aac10bf55ab3efde4c4db3893d8691d2' ran
				4.91 ± 0.55 times faster than 'GIT_READ_COMMIT_TABLE=0 git.compile rev-list --count --objects --use-bitmap-index 2ab38c17aac10bf55ab3efde4c4db3893d8691d2'

That's sort of a best-case scenario, because we're not doing any
traversal between the bitmapped commits and the traversal tips. But even
if we do have some traversal, the results are still pretty good.
Swapping out 2ab38c17aa for `--branches` yields a 5.02x improvement from
141.0ms down to 28.1ms.

Adding in `--tags` basically negates any improvement (having the commit
table extension eeks out a 1.03x improvement from 645.7ms down to
626.0ms. `perf record` shows that 30% of time is spent outside of the
bitmap code.

If you want to give this a try yourself, I highly recommend generating
your bitmap while packing with `-c pack.writeReverseIndex`. Building a
reverse index on-the-fly also seems to negate any performance
improvements here, so having an on-disk reverse index is more or less a
prerequisite to testing this out.

Extremely gross and inscrutable code can be found on the
'tb/bitmap-commit-table' branch of my fork [1].

Thanks,
Taylor

[1]: https://github.com/git/git/compare/master...ttaylorr:tb/bitmap-commit-table


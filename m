Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E0BC4361B
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 17:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62F0723B46
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 17:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730859AbgLHR5O (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 12:57:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730203AbgLHR5N (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 12:57:13 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A40C061749
        for <git@vger.kernel.org>; Tue,  8 Dec 2020 09:56:33 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id x16so20330082oic.3
        for <git@vger.kernel.org>; Tue, 08 Dec 2020 09:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gUag/giY4paL3LIAqiqd9H+3t3z9wyZDcWfb6bAMD5k=;
        b=Ob9Gv+0smfMBSLSaOqAdQjOeTM/Gx6R7MtqC9ob4/+2igoYjXFJnrBBFQfdwu11afg
         MffFP0722YT3EkHD5NZ6c8QZqA6sxR1JaiXbv47MJIaE1lHmY/eNICypTlgL2BX1F9cI
         N3X7MslZIT+n9wxBiopaXvPD3IjGqQRXt92Tg26mCsfTF+ZJOj3leA0md4QEvjJqptI9
         QhQHJRxAL8+Q1Y5GGss1lzqdSiob+XylPBf4LypulERok7B2rEcmGQOI+bw249arMS72
         CUEgQ9Wzx2KTkzyMnuIj7msCAzxQmh6OG97cnzT0Zi2+hCSWZC3mA1gDBBq4wMu6USZ5
         98Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gUag/giY4paL3LIAqiqd9H+3t3z9wyZDcWfb6bAMD5k=;
        b=NYNzYxwT7J+M/HHpxIL5LMXESAoRU3cilIFnhLEpMwP9OIF914W5acNSxS3Oj2ry4l
         a9vhVfSK5qhZRqYoNzfmyl3AqsYxwEFrdukvM74Y1e6kANXYcc2pQiW2ZEemulXSkG9z
         v1UZwG+/etnZ9VTrHEVk9udLzf5Lpb9COI0HAuEVGf7vEPNJlfNJpaLrZEYP7TkO75nh
         hSqFULpFFn0+L3SbEXvTjSvjFJ2N5fz9Pu+M0+e0GFjqG3LEj9uRv01pMi2T0N9LW+xv
         /3b5i9XraGqsWUsucOHESj0ZWbmrDsSmBXJgYcaPVIvYpM+3oh+v5HyifgNx1S2Klhkx
         K9vA==
X-Gm-Message-State: AOAM530bq/H7Gk54OLmM55vUrDWlVQPlylxU/BGwioRyD4YEYDYWDSFd
        8OzlWBcGlsNTcCl6k1An7BsPQQ==
X-Google-Smtp-Source: ABdhPJx4fEiWq28GIxW6zJf7mmpDq3RjiJAIsp3fUH7OZskLO3dyJbjCf7mwn8fqJcO+fsaFZbA1aQ==
X-Received: by 2002:aca:c388:: with SMTP id t130mr723008oif.36.1607450192998;
        Tue, 08 Dec 2020 09:56:32 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id t19sm1657744otp.36.2020.12.08.09.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 09:56:32 -0800 (PST)
Date:   Tue, 8 Dec 2020 12:56:28 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, szeder.dev@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 02/15] chunk-format: add API for writing table of contents
Message-ID: <X8++THm5K3O9AUrT@nand.local>
References: <pull.804.git.1607012215.gitgitgadget@gmail.com>
 <da7933cc59928c7995821dcc72ceae0c690ebaca.1607012215.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <da7933cc59928c7995821dcc72ceae0c690ebaca.1607012215.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 03, 2020 at 04:16:41PM +0000, Derrick Stolee via GitGitGadget wrote:
> @@ -0,0 +1,26 @@
> +#include "git-compat-util.h"
> +#include "chunk-format.h"
> +#include "csum-file.h"
> +#define CHUNK_LOOKUP_WIDTH 12
> +
> +void write_table_of_contents(struct hashfile *f,
> +			     uint64_t cur_offset,

Hmmph. Could we not use hashfile_total() here instead? I wonder how much
the callers would be able to be cleaned up without having to keep track
of the offset themselves.

Is this to indicate that we might call hashfd() on a file that already
has data in it at an offset that doesn't cause us to overwrite that
data? I doubt it (since both callers currently write all of their data
into a hashfile), but if so that should be documented, too.

(In either case, off_t is a more appropriate type than uint64_t here.)

> @@ -0,0 +1,36 @@
> +#ifndef CHUNK_FORMAT_H
> +#define CHUNK_FORMAT_H
> +
> +#include "git-compat-util.h"
> +
> +struct hashfile;
> +
> +typedef int (*chunk_write_fn)(struct hashfile *f,
> +			      void *data);
> +
> +/*
> + * When writing a chunk-based file format, collect the chunks in
> + * an array of chunk_info structs. The size stores the _expected_

I'm not clear on what "_expected_" means here. Does that mean that the
actual data written may be over- or under-sized? If not, does violating
the expectation cause an error?

I realize that I'm being pedantic, but documenting this would be useful
to callers.

> + * amount of data that will be written by write_fn.
> + */
> +struct chunk_info {
> +	uint32_t id;
> +	uint64_t size;
> +	chunk_write_fn write_fn;
> +};
> +
> +/*
> + * Write the chunk data into the supplied hashfile.
> + *
> + * * 'cur_offset' indicates the number of bytes written to the hashfile
> + *   before the table of contents starts.
> + *
> + * * 'nr' is the number of chunks with non-zero IDs, so 'nr + 1'
> + *   chunks are written in total.
> + */
> +void write_table_of_contents(struct hashfile *f,
> +			     uint64_t cur_offset,

Same goes here about cur_offset.

Thanks,
Taylor

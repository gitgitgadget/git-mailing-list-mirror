Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B57D62047F
	for <e@80x24.org>; Tue, 26 Sep 2017 09:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967783AbdIZJ1a (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Sep 2017 05:27:30 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:55164 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967750AbdIZJ12 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2017 05:27:28 -0400
Received: by mail-pg0-f41.google.com with SMTP id c137so5604861pga.11
        for <git@vger.kernel.org>; Tue, 26 Sep 2017 02:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=jfjFfQQaAhZL0t1nsLD7QFDAhi3769fbPePsftw5c2k=;
        b=jI7QdD0HFD2AWShwJ7QLZlatnqNpnLv2uxUqmvZiswTUEo38GPB9RGgBiB+PAyNGw2
         vYpmmRCZyCBE2uqFZpJ2Rp7qcdfyZt+K/W2G3CSHY6aRWqBpT2JS4vG+3hS/D+XHUqrb
         LduF63edN+4lyJelnXFSiQ5VTGyHief/hgwIpMF4i2uVM7J1pbJuUI+Tv4l9gX++bpAa
         zityc0/e0I7SBSHeaWFcn6XCjQvijPaBgekoKh5u+iy2Q1Bl7IWZMVqcK1ZJJkwrQUI5
         p2RCmE7E7Hj36DQRJeeq5f2IlhjR03X+prvrePs52pBtjAhwgWXWqPte/amlb2sNrS3D
         ZyAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=jfjFfQQaAhZL0t1nsLD7QFDAhi3769fbPePsftw5c2k=;
        b=nkTCxErBt8SZuzVX9h81fcn11s146rebyTy+s3B32Z3nUGX4gYjzbH8cMQjSBymcxo
         H1FhjnozsuTIPS7AGO6h8x93xSH66UB6s82vgFk2ZgWvsMliobN4nUNwr3IQIzDKOjQ3
         ozDvUPedXUsiiKiPiBtBoBwYdkIZtV6RzCStG1zbN+vGlCs/90Pn0yNX4sGZJEarAPfe
         U8pl0RbKNi6oKDOcXVWNMLbtvyMlYvZQmqXl4fWqf/ha4w/SYKsauKNgmf94XM0amO1P
         fKrxd/ZK/rRyPrdnZqDfHpQR39nw7vJ8VBfm2sXMJcjB6yHquobAtMsxf1c8wHzoMUY/
         XNdg==
X-Gm-Message-State: AHPjjUikYBR0om7LNkp27xkO7FYT2/eTKAPsGuDi73+uA8wLfWBZWBFS
        UFtdUsC+LtMQTetRl9Z3IHc=
X-Google-Smtp-Source: AOwi7QBR0WPfvzr5fKZqDlQOQvr3vJhDMcqxsgKU9uVt1ah2u+knAlknxnHG8qNgR1HtmGdskk+s1Q==
X-Received: by 10.101.65.205 with SMTP id b13mr10429233pgq.319.1506418047883;
        Tue, 26 Sep 2017 02:27:27 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:8cad:f525:a0b8:9738])
        by smtp.gmail.com with ESMTPSA id f3sm16362811pfd.82.2017.09.26.02.27.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 26 Sep 2017 02:27:27 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, git@jeffhostetler.com
Subject: Re: [PATCH v2 2/5] p0008-abbrev.sh: Test find_unique_abbrev() perf
References: <20170925095452.66833-1-dstolee@microsoft.com>
        <20170925095452.66833-3-dstolee@microsoft.com>
Date:   Tue, 26 Sep 2017 18:27:26 +0900
In-Reply-To: <20170925095452.66833-3-dstolee@microsoft.com> (Derrick Stolee's
        message of "Mon, 25 Sep 2017 05:54:49 -0400")
Message-ID: <xmqq8th1ajy9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <dstolee@microsoft.com> writes:

> diff --git a/t/helper/test-abbrev.c b/t/helper/test-abbrev.c
> new file mode 100644
> index 000000000..6866896eb
> --- /dev/null
> +++ b/t/helper/test-abbrev.c
> @@ -0,0 +1,19 @@
> +#include "cache.h"
> +#include <stdio.h>

Same comment on <stdio.h> as [1/5] applies.

> +
> +int cmd_main(int ac, const char **av)
> +{
> +	struct object_id oid;
> +	char hex[GIT_MAX_HEXSZ + 2];

Why +2 (as opposed to +1)?

> +	const char *end;
> +
> +	setup_git_directory();
> +
> +	while (fgets(hex, GIT_MAX_HEXSZ + 2, stdin)) {
> +		hex[GIT_MAX_HEXSZ] = 0;
> +		if (!parse_oid_hex(hex, &oid, &end))
> +			find_unique_abbrev(oid.hash, MINIMUM_ABBREV);
> +	}
> +
> +	exit(0);
> +}
> diff --git a/t/perf/p0008-abbrev.sh b/t/perf/p0008-abbrev.sh
> new file mode 100755
> index 000000000..ba25e7824
> --- /dev/null
> +++ b/t/perf/p0008-abbrev.sh
> @@ -0,0 +1,22 @@
> +#!/bin/bash
> +
> +test_description='Test object disambiguation through abbreviations'
> +. ./perf-lib.sh
> +
> +test_perf_large_repo
> +
> +test-list-objects 100000 | sort -R > objs.txt

I thought "sort randomly" was a GNUism.  Does it work across
platforms?  I think not.

> +
> +test_perf 'find_unique_abbrev() for existing objects' '
> +	test-abbrev < objs.txt
> +'
> +
> +test-list-objects 100000 --missing | sort -R > objs.txt
> +
> +test_perf 'find_unique_abbrev() for missing objects' '
> +	test-abbrev < objs.txt
> +'
> +
> +rm objs.txt
> +
> +test_done

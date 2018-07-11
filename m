Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C39B91F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 10:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbeGKKKz (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 06:10:55 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:38376 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbeGKKKz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 06:10:55 -0400
Received: by mail-ed1-f49.google.com with SMTP id t2-v6so4183288edr.5
        for <git@vger.kernel.org>; Wed, 11 Jul 2018 03:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NF+zqNlSJ6OPwQJooQ2oekYJXxDA9ajp7Sb7yvQDimU=;
        b=e2Pl6wt9DWRcieK7pxYNqHhQ9vYpibT8XQKp5zSMMI7g00fRzTf+hQzPRQgCX+p/tQ
         T84nmQhQ0JpTTZjkMGOuwEXqaxxMhhAsE6X6yXjFsm91xLqV1z7vkgaJdECpJkn+Cdyb
         G7zUnjuhzDQAeZ7pncBlB82G/XMSqCHI1xJxIy7cNdvgsyqg0D9TZDf/Y5ztCCRxCHFj
         e6ddzQ13MO2PTUj2X/OYVuLxm2PpqWX+idEzd9eYJk3EaOHATteOsyi8KkL01du3mNT6
         d6mKO9mNuLwRIYdbWxZCafLQZEvNR9No6EftkwPUFJ11jeQKdtPRXVMrV63+x1bVQrhI
         O1Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NF+zqNlSJ6OPwQJooQ2oekYJXxDA9ajp7Sb7yvQDimU=;
        b=Q9w1pXrexdqcVZxY1vlzB2f1Kjvhkf7du7axfW7v4G1br1JTIxXG+JYJNenLuwD/vQ
         cXncyBjBymD55crpQNhootk2M3Y0e6G78RBLhvRzzSfqUP0J7q0vOpI37k1AbgMPgSwr
         L7amH3PycYc2xVLO6yY+J/GSBsWFv6g8Rw/4slQuUEkfTIO481WDnDjYgcsP2ijj7C3v
         2WMPtyFmPHg63n7Pg9R2YJychF5pJIQ4q2kZn3gRyTyAeDc0mQB/oC292eLBpx6uhjGC
         bC0V8Uciqg/MnuEI587nbK+r57nlVyPyUhBeH/ZRNFeCXID0zGbo3Gd1KNH6P6w2Qzxj
         geCQ==
X-Gm-Message-State: APt69E0WZZpQIwzcVPSxYIM772dkIo7F711fvUVIukoqlRpVc790VZHZ
        7afciSkhmZDJPO2vdjMhm1I=
X-Google-Smtp-Source: AAOMgpeMo3gU80NOsfFf47+5tvwqJjexFzA9Wt0BNKBkv1EZSILiENZYhLX5Ns03a+jFEoH864+mOQ==
X-Received: by 2002:a50:b4b0:: with SMTP id w45-v6mr30764240edd.254.1531303640587;
        Wed, 11 Jul 2018 03:07:20 -0700 (PDT)
Received: from localhost.localdomain (x4db1cc71.dyn.telefonica.de. [77.177.204.113])
        by smtp.gmail.com with ESMTPSA id e2-v6sm6368775edn.11.2018.07.11.03.07.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Jul 2018 03:07:19 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 01/20] linear-assignment: a function to solve least-cost assignment problems
Date:   Wed, 11 Jul 2018 12:07:17 +0200
Message-Id: <20180711100717.3747-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.18.0.273.g57f1ecce9c
In-Reply-To: <39272eefcfe66de3ca1aa2ee43d6626ce558caae.1530617166.git.gitgitgadget@gmail.com>
References: <cover.1525448066.git.johannes.schindelin@gmx.de> <pull.1.v3.git.gitgitgadget@gmail.com> <39272eefcfe66de3ca1aa2ee43d6626ce558caae.1530617166.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> diff --git a/linear-assignment.c b/linear-assignment.c
> new file mode 100644
> index 000000000..0b0344b5f
> --- /dev/null
> +++ b/linear-assignment.c
> @@ -0,0 +1,203 @@
> +/*
> + * Based on: Jonker, R., & Volgenant, A. (1987). <i>A shortest augmenting path
> + * algorithm for dense and sparse linear assignment problems</i>. Computing,
> + * 38(4), 325-340.
> + */
> +#include "cache.h"
> +#include "linear-assignment.h"
> +
> +#define COST(column, row) cost[(column) + column_count * (row)]
> +
> +/*
> + * The parameter `cost` is the cost matrix: the cost to assign column j to row
> + * i is `cost[j + column_count * i].
> + */
> +void compute_assignment(int column_count, int row_count, int *cost,
> +			int *column2row, int *row2column)
> +{

[...]

> +update:
> +		/* updating of the column pieces */
> +		for (k = 0; k < last; k++) {
> +			int j1 = col[k];
> +			v[j1] += d[j1] - min;
> +		}
> +
> +		/* augmentation */
> +		do {
> +			if (j < 0)
> +				BUG("negative j: %d", j);
> +			i = pred[j];
> +			column2row[j] = i;
> +			k = j;
> +			j = row2column[i];
> +			row2column[i] = k;

Coccinelle suggests using SWAP(j, row2column[i]) instead of the last
three lines above.
It's more idiomatic, and it avoids (ab)using the 'k' variable
(elsewhere used as loop variable) as a temporary variable.

> +		} while (i1 != i);
> +	}
> +
> +	free(col);
> +	free(pred);
> +	free(d);
> +	free(v);
> +	free(free_row);
> +}

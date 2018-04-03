Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4ACD1F404
	for <e@80x24.org>; Tue,  3 Apr 2018 18:31:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752813AbeDCSb5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 14:31:57 -0400
Received: from mail-pl0-f53.google.com ([209.85.160.53]:34431 "EHLO
        mail-pl0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752525AbeDCSb5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 14:31:57 -0400
Received: by mail-pl0-f53.google.com with SMTP id u11-v6so10054174plq.1
        for <git@vger.kernel.org>; Tue, 03 Apr 2018 11:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5fLi9XzI6BJ4Z6A/jeXc8C8xj0fAkYZCV16uSDVm9ss=;
        b=vhiioC2c7T1DB20SAcQUFJq46fxhuvocrqLCyCruXX57F9hW5lleHeyipy7QfgjuMa
         /Tahcv2TS5xDs1l/zBiiDESy9xENyfxaFvHZmSaEADWN3Ij5aoTR9/ValX5bmezfKLBF
         IV4ohbe9oAf06fJrMm/j6GDqqNG5P7gzT8C2UTAF5x9ZyzxPwmisdfJn167QVSBJZYY0
         PTmM2H1zo6RBX30xTfTpSrNsw1ZsPxkkDMt+fs2C7bj1c95Wq806Bmu0WkuR3k0s1Bt3
         jNZuKFdu8VthX4RB9Or3tGBVC88e4rpZpltu+IWpw7kxck8BEXGBB2pyZV4IOAR+pdqD
         vFLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5fLi9XzI6BJ4Z6A/jeXc8C8xj0fAkYZCV16uSDVm9ss=;
        b=t9LscfJcEKpyXgZsfOeP19srhsk1b88xwaTX24vro2OdOIAqyqYkodo/Vkqo9xvgpO
         jMGkuKvQCSst8KN6WzfxnZNQ84WTtXO9PxvZXTVGGiZva/VjDeMTUPw/l3nQ1y4tv4EI
         5SjHAtTgW+Mh9+pTvnbnMvt8Uywc02ixMF7oW53psO2NRU4n2xQUZTqTOS7HbWrA1fnY
         0Cw8b3mnOdQIdnmfz2L/abupq+bdchhr7E2Q+fpyeUnNS3uYPCiDJ0MfthxPlGRRl5R9
         vRaL43M7AlMc3ujRcmLgVGCs+00U3U0SlH0ndK2LXe3eC5yXc4sV4ZHTDuYYE89V1XE3
         8oig==
X-Gm-Message-State: AElRT7EC/lYmmUKDdEuJsbIkd0znAaaWU2y1yWChYosopu//RZiK4OUb
        lXorPNDiqAGIUVTJfnqf3Dw6Jw==
X-Google-Smtp-Source: AIpwx4/eWcWQ6zVv1LBZkmc9f913nQDrgynozS7AQ3YeqO1Z+4IT4J/9XyfIXy+Mk59t7ovbwH3kaA==
X-Received: by 2002:a17:902:a9c9:: with SMTP id b9-v6mr8495690plr.8.1522780316440;
        Tue, 03 Apr 2018 11:31:56 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id z78sm6419464pfd.23.2018.04.03.11.31.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Apr 2018 11:31:55 -0700 (PDT)
Date:   Tue, 3 Apr 2018 11:31:54 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, sbeller@google.com,
        larsxschneider@gmail.com, peff@peff.net
Subject: Re: [PATCH 4/6] commit: use generations in paint_down_to_common()
Message-Id: <20180403113154.4d81719baba74aae53c9a58c@google.com>
In-Reply-To: <20180403165143.80661-5-dstolee@microsoft.com>
References: <20180403165143.80661-1-dstolee@microsoft.com>
        <20180403165143.80661-5-dstolee@microsoft.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue,  3 Apr 2018 12:51:41 -0400
Derrick Stolee <dstolee@microsoft.com> wrote:

> +int compare_commits_by_gen_then_commit_date(const void *a_, const void *b_, void *unused)
> +{
> +	const struct commit *a = a_, *b = b_;
> +
> +	if (a->generation < b->generation)
> +		return 1;
> +	else if (a->generation > b->generation)
> +		return -1;
> +
> +	/* newer commits with larger date first */
> +	if (a->date < b->date)
> +		return 1;
> +	else if (a->date > b->date)
> +		return -1;
> +	return 0;
> +}

I think it would be clearer if you commented above the first block
"newer commits first", then on the second block, "use date as a
heuristic to determine newer commit".

Other than that, this looks good.

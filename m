Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A489C433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 01:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5399A61132
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 01:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346614AbhIHBje (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 21:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346223AbhIHBjd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 21:39:33 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D50C061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 18:38:26 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id bt14so815690ejb.3
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 18:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=ASGMnVpuXmnXlC86sjUmqBsAWi2iTArdOKfzhLVmtv4=;
        b=gJ3emz7bcYdHFYALo11NzUjq7bsCRPppkqE3YFBlyuh0Kd7SbPi8LMQQtuUc/qioqV
         zWgDUp8Yh+uTSDxPE1hyK70TqtSzWZUMD97JbTzTev9E1JTopiYfuSUn1DRlVdCEX3rg
         +c25nOk/Pn6Dns+rRLj0yP6HBUjhjZfukuIjJrXbN/g2EBDLh25HXEJd0TtKtMRg/7n+
         IxunzNf4rklc0CpKPAdcNvr6h1MFyYYuLjXjsBiKyqLU4totiyGPjEMSV666+T6czJcw
         rvuGdDvmh/Cgz3DlbucsjEGwH8hhPUJc3d0Pd4IERnxbo5nBdI1r40fLcuuJqPtBY8Mb
         nIjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=ASGMnVpuXmnXlC86sjUmqBsAWi2iTArdOKfzhLVmtv4=;
        b=IXaPeVKDJKk01LCyZC0YQ1TfuxFW/b3qm+Tp8kHYHnIKiwm4+eDIr5HT+PUSRS5tP7
         MLj/Nr2cD9y8ERddhgjOqXcbEL2G+BvGHBHUrAHr2WPlBscbl9URQqeVMPBZpeO7Fauk
         MMJrraD2JTlrHxYJhv1fjhBTRjczizHZmdV9MGpw9Zgon/He4KPPITDhkwb2cf5wsYMk
         OrxWji5uUGs5PkihhJxMKvryS7/cWT6OLVMNYA7aL4FIcqW5UEJiEzWFJTm44GQ6u1x5
         pzCEbP8U4V+fXJmFkeNq77xPQcYZNmL8vogEFlnRmpQE2yL++2uHm/2LSaggo+rJMi0c
         HLug==
X-Gm-Message-State: AOAM533aL86JXLROLjtxz4aaAgPHlu5qYlgleSqjQzo2ApJlQvp481QS
        F0BozsSEAa2LjqsoWZg5Qt+ndUuP2W3X1g==
X-Google-Smtp-Source: ABdhPJw8/e0PBrjO/L0+JDEw1H6k1jqXaCEAcDXyU413xUghkhw4lrauOyIh69ucQIO4tn7zYMhwJQ==
X-Received: by 2002:a17:906:7d83:: with SMTP id v3mr1408721ejo.216.1631065104807;
        Tue, 07 Sep 2021 18:38:24 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id b13sm279975ede.97.2021.09.07.18.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 18:38:24 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 1/4] t/helper/test-bitmap.c: add 'dump-hashes' mode
Date:   Wed, 08 Sep 2021 03:37:05 +0200
References: <cover.1631049462.git.me@ttaylorr.com>
 <918f9b275a1a03b6383e32f28cf1db26a6d67633.1631049462.git.me@ttaylorr.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <918f9b275a1a03b6383e32f28cf1db26a6d67633.1631049462.git.me@ttaylorr.com>
Message-ID: <878s07kfsg.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Sep 07 2021, Taylor Blau wrote:

> +int test_bitmap_hashes(struct repository *r)
> +{
> +	struct bitmap_index *bitmap_git = prepare_bitmap_git(r);
> +	struct object_id oid;
> +	uint32_t i;
> +
> +	if (!bitmap_git->hashes)
> +		goto cleanup;
> +
> +	for (i = 0; i < bitmap_num_objects(bitmap_git); i++) {
> +		nth_bitmap_object_oid(bitmap_git, &oid, i);
> +
> +		printf("%s %"PRIu32"\n",
> +		       oid_to_hex(&oid), get_be32(bitmap_git->hashes + i));
> +	}
> +
> +cleanup:
> +	free_bitmap_index(bitmap_git);
> +
> +	return 0;
> +}

Seems like it should return void, it doesn't ever return non-0, nor in
the rest of this series....

> +static int bitmap_dump_hashes(void)
> +{
> +	return test_bitmap_hashes(the_repository);
> +}
> [...]
>  		return bitmap_list_commits();
> +	if (!strcmp(argv[1], "dump-hashes"))
> +		return bitmap_dump_hashes();

Perhaps the return code only for the brevity of this test-only code?
Seems like having bitmap_dump_hashes() do the "return 0" would be better
in that case.

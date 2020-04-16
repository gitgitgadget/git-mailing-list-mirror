Return-Path: <SRS0=FNL0=6A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4404C2BB55
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 14:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC4E6206D6
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 14:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7WlumsW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391148AbgDPOIw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2393116AbgDPOIr (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 16 Apr 2020 10:08:47 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF471C061A0C
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 07:08:46 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 8so6418938oiy.6
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 07:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=04axOD0rJjXu5+bW5Fj3U+eQsAKLxXKhIT8tY2bTyKc=;
        b=Z7WlumsWUgVEprDacJBCgChJD/bwKcAlriMN8YTKu2liTRmSPwZugP+Jpozez2WELF
         Bqm7J22QX3PnwHKArWK1i2bAhqYGSLeBBcOv7WDwXMWyOa9hT3ysKf8Hxldq6WhFxXih
         9DQjYrVvwLomJbZNF7KGBAoTIe3FxnNc64TYaALK2TdqfhqkOvWN/m+/rk6BU2QI8YTF
         Vpu7OoyLEhncuSsV8KHAb5sP8Vn4/y0Svj2o8Xz8O/iJc4HaWXJTfl3iewF5Dwxc+Jic
         NUi7zg9g+X02yNd2ZO8t10IF7gd5M3YLwTb/+u5XdjdV26C9bYfFH7dj30GqRsd9W5Ji
         MOVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=04axOD0rJjXu5+bW5Fj3U+eQsAKLxXKhIT8tY2bTyKc=;
        b=efSLy4hRGV2Nhzw+JTtfDMkxsJbLX1vLrlGUFKw0ft1jqC0RPA3fyHVfg9BsLJVHYO
         00j+6Nf5JU5E08dOq2izAnIZ94Np01QBiW+wnufFoAu8jRo+TqXT0uQba01rMGhkRv7F
         CTl9yzDBfYyt1Wxyf769aBryvM+4pTVb/2sKf3JQCyqy0WzJZBJ3tgXhYQMHYH9ca7Mm
         bJXZM6MguBS1XGXWr5p6IPDoS4/tQMsNn+RpvXeDKR5sab1stpQRPmaBltncOFHAl6TJ
         Wfy0LQRuLM/YvMSF45+/yDMg7elBzT3zC/5S5Ur9MvYjXPsyXPn+nWR6u8qG4fUzOfhX
         /+og==
X-Gm-Message-State: AGi0PuaVHokmi8yl5e9YQGgCyos0TDBEhXUyJND22aAn8Hq0IF+xxBVE
        W2GrZMeKMftiFHAS69Mb1Z6NsU4qT0g=
X-Google-Smtp-Source: APiQypKubFUyAOg2hmqfwuFBzrJBEQz9WnHfyFnl2vWFDv9MF4ykXvIxhc9fNFblQxAamZynMGtdvA==
X-Received: by 2002:aca:c145:: with SMTP id r66mr2908505oif.90.1587046125885;
        Thu, 16 Apr 2020 07:08:45 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id r24sm7209771otq.9.2020.04.16.07.08.45
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2020 07:08:45 -0700 (PDT)
Subject: Re: Git Test Coverage Report (April 16, 2020)
From:   Derrick Stolee <stolee@gmail.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
References: <c797df50-ec21-98a3-58c4-ade0c04284c9@gmail.com>
Message-ID: <d4bf43d8-0d56-bbb9-e68f-a4933dacd3d3@gmail.com>
Date:   Thu, 16 Apr 2020 10:08:43 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:76.0) Gecko/20100101
 Thunderbird/76.0
MIME-Version: 1.0
In-Reply-To: <c797df50-ec21-98a3-58c4-ade0c04284c9@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/16/2020 9:57 AM, Derrick Stolee wrote:
> Derrick Stolee	efb0e3a0 blame: use changed-path Bloom filters
> blame.c
> efb0e3a0 1276) if (origin->commit->generation == GENERATION_NUMBER_INFINITY)
> efb0e3a0 1277) return 1;
> efb0e3a0 1279) filter = get_bloom_filter(r, origin->commit, 0);
> efb0e3a0 1281) if (!filter)
> efb0e3a0 1282) return 1;
> efb0e3a0 1284) bloom_count_queries++;
> efb0e3a0 1285) for (i = 0; i < bd->nr; i++) {
> efb0e3a0 1286) if (bloom_filter_contains(filter,
> efb0e3a0 1287)   bd->keys[i],
> efb0e3a0 1288)   bd->settings))
> efb0e3a0 1289) return 1;
> efb0e3a0 1292) bloom_count_no++;
> efb0e3a0 1293) return 0;
> efb0e3a0 1302) if (bd->nr >= bd->alloc) {
> efb0e3a0 1303) bd->alloc *= 2;
> efb0e3a0 1304) REALLOC_ARRAY(bd->keys, bd->alloc);
> efb0e3a0 1307) bd->keys[bd->nr] = xmalloc(sizeof(struct bloom_key));
> efb0e3a0 1308) fill_bloom_key(path, strlen(path), bd->keys[bd->nr], bd->settings);
> efb0e3a0 1309) bd->nr++;
> efb0e3a0 2903) bd = xmalloc(sizeof(struct blame_bloom_data));
> efb0e3a0 2905) bd->settings = sb->repo->objects->commit_graph->bloom_filter_settings;
> efb0e3a0 2907) bd->alloc = 4;
> efb0e3a0 2908) bd->nr = 0;
> efb0e3a0 2909) ALLOC_ARRAY(bd->keys, bd->alloc);
> efb0e3a0 2911) add_bloom_key(bd, path);
> efb0e3a0 2913) sb->bloom_data = bd;
> efb0e3a0 2920) for (i = 0; i < sb->bloom_data->nr; i++) {
> efb0e3a0 2921) free(sb->bloom_data->keys[i]->hashes);
> efb0e3a0 2922) free(sb->bloom_data->keys[i]);
> efb0e3a0 2924) free(sb->bloom_data->keys);
> efb0e3a0 2925) FREE_AND_NULL(sb->bloom_data);
> efb0e3a0 2927) trace2_data_intmax("blame", sb->repo,
> efb0e3a0 2929) trace2_data_intmax("blame", sb->repo,

For this to be covered, I need to modify my build to use
GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=1. I'll have that ready for the next
run.

> Derrick Stolee	72ca4f9b commit: write commit-graph with Bloom filters
> commit-graph.c
> 72ca4f9b 1979) ctx->changed_paths = 1;

Same here, although I will change this line in the next version.
 
Thanks,
-Stolee


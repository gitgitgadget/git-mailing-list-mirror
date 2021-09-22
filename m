Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB6C4C433EF
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 23:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3E5861131
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 23:14:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238404AbhIVXQA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 19:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238293AbhIVXP5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 19:15:57 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB28C061574
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 16:14:26 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id i3-20020aa79083000000b003efb4fd360dso2646227pfa.8
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 16:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4Z7XYPYAD2ZhfrR7NTWN3HTb8YGQl9p6Hpe5GtfkYII=;
        b=ErTSPgwmcgR+nHUvQNzTeEMqqxtQFOWmqMjT8xlEPY4DN4iD6d8q1cO68XC/4E332V
         yrdAz2pznow+DTN2sv4OCVfSB9EuvqFx5jpbwxmV2BXQT+Qibay3btDZKs/mztW41i7T
         h7P7fjGxcT07lFsOfzLSgjCB0D0m+8hzfQf66DIfbUL8Nl5dAJh3Ddgiis2JRBLESgcF
         TLdMw25h+vpAok2Wwjsw1FUUbv19J6N4g4rxe9X4nDADZkdhghVI9F2WvPjS+BHz4yZs
         z1iirty5mxyuZt4kHQN7pdSiAT2G2bEaRML8tSgUcoqmDHzLunBQsZfnfdN2W84oDAMW
         vgGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4Z7XYPYAD2ZhfrR7NTWN3HTb8YGQl9p6Hpe5GtfkYII=;
        b=DFXrPopZngKSmYpw4ag3zS1kHKfWFVFITAwyYGvu7TDJfdRCehkPJkfT+oJd1L7Df8
         eJevaL/Ew7ycLzvufQfZrdb5ahUw9sOA3m5WO7BnijmuMhw9EJN2X4oQTbUMblbxB1ZP
         o0G0gBDmXtiRGYQrTREb15Wpe7oI0ZFCYVXLuj+7Z0dOnNiL4/WUvYkXf8zGsT7zq2eP
         /8jsLPFIS5v60W/sy+jXwwgZzuAKMjLVa7bceqdgnkME2ctJ5BMlDUqUk3PCwq8jJDsH
         xZxL53SqWSarx2RJvIXaTwtAy4UfrK52iXvjiABUf5alONLPRhN7QGi2Qd6Rhu+pKiz3
         TIKQ==
X-Gm-Message-State: AOAM53247b4ueBBPLJEYdebZQ4exv/o7Jb5Jw8akH9aBb6LGYr+zEs16
        zveQ4gV238hNMKRusEp/a9R/E3rR7kFNc2zVksSM
X-Google-Smtp-Source: ABdhPJw28CqcaHC+IPpu548p55upi9SbFyv7FxgT6SbZoDGRQ8G5yvQ6oL8ufExFi8WJm9amuqk1LwrMabEkQp3c08E1
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a62:7b4a:0:b0:439:2b2c:89f1 with
 SMTP id w71-20020a627b4a000000b004392b2c89f1mr1196032pfc.18.1632352465844;
 Wed, 22 Sep 2021 16:14:25 -0700 (PDT)
Date:   Wed, 22 Sep 2021 16:14:23 -0700
In-Reply-To: <03c1b2c4d3d9d10a6768684e9c4d1c1cc8019844.1631730270.git.me@ttaylorr.com>
Message-Id: <20210922231423.2610917-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <03c1b2c4d3d9d10a6768684e9c4d1c1cc8019844.1631730270.git.me@ttaylorr.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: Re: [PATCH v2 1/8] midx: expose `write_midx_file_only()` publicly
From:   Jonathan Tan <jonathantanmy@google.com>
To:     me@ttaylorr.com
Cc:     git@vger.kernel.org, peff@peff.net, gitster@pobox.com,
        avarab@gmail.com, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> @@ -1237,7 +1253,7 @@ static int write_midx_internal(const char *object_dir,
>  
>  	QSORT(ctx.info, ctx.nr, pack_info_compare);
>  
> -	if (packs_to_drop && packs_to_drop->nr) {
> +	if (ctx.m && packs_to_drop && packs_to_drop->nr) {
>  		int drop_index = 0;
>  		int missing_drops = 0;
>  

I couldn't figure out why this requires ctx.m now.

> @@ -62,6 +63,10 @@ int midx_contains_pack(struct multi_pack_index *m, const char *idx_or_pack_name)
>  int prepare_multi_pack_index_one(struct repository *r, const char *object_dir, int local);
>  
>  int write_midx_file(const char *object_dir, const char *preferred_pack_name, unsigned flags);
> +int write_midx_file_only(const char *object_dir,
> +			 struct string_list *packs_to_include,
> +			 const char *preferred_pack_name,
> +			 unsigned flags);

It took me a while to figure out that this function doesn't only write a
MIDX file, but writes an MIDX file only for certain packs. Maybe worth
adding a comment here (e.g. "Write an MIDX file only for the given
packs").

Other than that, this patch looks good.

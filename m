Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF052C433B4
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 22:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93FF4613CD
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 22:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236518AbhDUWFF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 18:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343521AbhDUWE4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 18:04:56 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C409C06174A
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 15:03:04 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id s23-20020a056a001c57b029026369efe398so4851652pfw.2
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 15:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=oHfx5xlXlPbU8HipIV6TbrC+jwIVncNp7q4tqDZjotI=;
        b=L74l8m1crI8CtvUb6EXqgvOGe+tfydt74gshacTqKcocmHkxT7Q11e50Yh4L8jDRYD
         wUHEoTULxnMH1JfLwniVJsxSlcieFLHHFPyqWPOqZuBytIs8E+0SLt1/6+t1h/u27HqO
         Qm376fNltxicep7slYDUxsToWe+z1o4XKS8c+1l1tBqZ386HD7wRcYoZApramDmRA8v+
         Q7yUMx+QyceRQLZW+x5uxekyd5gDxNgF4XUMIw0Of39anscjHEUZKavObkAe9i2hIxHl
         PDXHy0CZoE70lIQ4rAZcID83zBp7vOsOp96hXwN2w7YnoL+WBbHVC6W883SvvuJ2WcE3
         tXlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oHfx5xlXlPbU8HipIV6TbrC+jwIVncNp7q4tqDZjotI=;
        b=LsdmCGUdx//zWVfQ7ollddJsjWFxILhl/27oBp4ymHMXmLwzU7d0k0Q6r1G0Tyzk3B
         8Cm1hNDmJZm8uHkY7vlXFS9SY+E6F2T5/2TKpOUvxVthjWu/g0Ru/6BpBZL5WRwmonBj
         zFZD3XBASd/MFkE3Baz4OxGWEA7qCVfcT7EutL3vNx409yw9LyuUKeTEeRqzJCAuT+XK
         vdL4dI19unQzatOi5W6h0LCthkxFFJNFsqhv1j3n2aBNfjKBFxcqGSqZPPRHACZXDGFz
         PNFk5IXJMqj3ys5Hfaw4nDwegAUMEPqA/ihADBqVYiPoVacXnIsJWm+72dV8qODPEbvC
         HfrQ==
X-Gm-Message-State: AOAM532vqKp7ADv36s8IkMB/cDogp1u8kMkvnwrrxTVQAWXYcFX3cHnG
        cninvi/4S21LvDtORyASC+4vx4sMNZckuAJNYfEX
X-Google-Smtp-Source: ABdhPJxYVkbN+R4Stts7ljBFSnvIaKn7nHce/WE8/M3wihaQAwIEf/Lm7Xtzfgi6ZsJLQnlaKxUI7TzzZ3NOn5EBIcrV
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:59ce:b029:eb:2262:d5c6 with
 SMTP id d14-20020a17090259ceb02900eb2262d5c6mr182262plj.77.1619042583786;
 Wed, 21 Apr 2021 15:03:03 -0700 (PDT)
Date:   Wed, 21 Apr 2021 15:02:59 -0700
In-Reply-To: <patch-2.8-1b472fcd85-20210420T133218Z-avarab@gmail.com>
Message-Id: <20210421220300.1022458-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <patch-2.8-1b472fcd85-20210420T133218Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: Re: [PATCH v2 2/8] object.c: add a utility function for "expected
 type X, got Y"
From:   Jonathan Tan <jonathantanmy@google.com>
To:     avarab@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de,
        peff@peff.net, me@ttaylorr.com, newren@gmail.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> diff --git a/merge-recursive.c b/merge-recursive.c
> index 7618303f7b..b952106203 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -2999,6 +2999,7 @@ static int read_oid_strbuf(struct merge_options *opt,
>  	if (!buf)
>  		return err(opt, _("cannot read object %s"), oid_to_hex(oid));
>  	if (type != OBJ_BLOB) {
> +		const char* msg = oid_is_type_or_die_msg(oid, OBJ_BLOB, &type);
>  		free(buf);
>  		return err(opt, _("object %s is not a blob"), oid_to_hex(oid));
>  	}

Stray extra line.

> +void oid_is_type_or_die(const struct object_id *oid,
> +			enum object_type want,
> +			enum object_type *type)
> +{

Thanks - this looks like a good simplification.

Why is type a pointer? Maybe it's to better distinguish the values at
the call site (one pointer, one not), but this solution is confusing
too.

> +int oid_is_type_or_error(const struct object_id *oid,
> +			 enum object_type want,
> +			 enum object_type *type)
> +{

Same comment.

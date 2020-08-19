Return-Path: <SRS0=/SyM=B5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A61EC433DF
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 00:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB985207FB
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 00:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="iJYdQ/mo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgHSAE3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Aug 2020 20:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbgHSAE2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Aug 2020 20:04:28 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC2CC061389
        for <git@vger.kernel.org>; Tue, 18 Aug 2020 17:04:28 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id z189so13862190pfz.11
        for <git@vger.kernel.org>; Tue, 18 Aug 2020 17:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=bhhgDL5/oqcP6LTXPk4XDpo6037p6SAyA8RFEV4I2zs=;
        b=iJYdQ/mo0KKP89g0ff3cyHNlBLKTgZEfcnpokDBhrYwZ15IRHg730mTgcuE1QA2U+/
         iu/PNila3aN7wP2AGnAuT+PGIfD436th91MtDRQNhyMudezzR7np7/1SnK425Q7Wr6Wd
         Aoo9yOPwe6G9yEpzXSBlk48YQN7YUCiiq5KKBdifunetdNkfXPxS0c0mWlaiNfRMEUnc
         kLceby8mO2BzgqNaon3fllqIiuo1vmnF9J+u9Qd+CtROt4fEOSqESW4f5+KWNwlp4fUw
         RWjjrmtmxLbdaqi77oO1Bu9bJ6yw8Soyc+JgPVU9tOMRCcxte8AzaR0MblMRhiV86JKb
         M+yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bhhgDL5/oqcP6LTXPk4XDpo6037p6SAyA8RFEV4I2zs=;
        b=l/67/cwrlBYr80SDj28bl5zbnMZagHy/S3AWOTTcMjnjP0x3eSHlnrYiV/Wkpl4+y2
         YxHvQ2CQSi9dJvhnLDtNfgMJMdYOOojBToPFPnotuAI39/ZgpWxi0+jraBhaVm7JBmVE
         4i3AWzC2IKVncD5xesoITk6vWB56JONTFnkPESBurj2haOHZcP4R9coq3oXq/Nq6Lhn0
         h9CcNzO2Seg+gM3tLGzY8hVu/cs7ZkWSJBAJBAJK8jIP1i/mATUXHqUGkfp+nXTJa0/b
         tR1AmulHrC3gn97FFU4D2oYVQxSF13htmrXsEYIGFBD3NBRcZwMgDkh9fYPf7+HiBN9u
         7KNQ==
X-Gm-Message-State: AOAM531Rfj3tMyLr+Omc3k/pvfWOudQER+G5CxIyyUldvLnXZxdm0lVc
        SIwA3zAz0RBtu2yEM9feBYIvYo73AieHC1Nm3uMz
X-Google-Smtp-Source: ABdhPJxcmFXU6/wXxZPoLDGLTRUKMhxPXB+iq6mwpKDnGdA66dVxiJSflqiE0Ty8EhCAr6ihJPHsHjaTvOG6sCZiH1Rp
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:18d])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:f014:: with SMTP id
 bt20mr424932pjb.0.1597795467445; Tue, 18 Aug 2020 17:04:27 -0700 (PDT)
Date:   Tue, 18 Aug 2020 17:04:25 -0700
In-Reply-To: <6f86cfaa94cfeaf7a2af417991ca07e41b6b0c3d.1597760589.git.gitgitgadget@gmail.com>
Message-Id: <20200819000425.2840491-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <6f86cfaa94cfeaf7a2af417991ca07e41b6b0c3d.1597760589.git.gitgitgadget@gmail.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: Re: [PATCH v2 07/11] maintenance: take a lock on the objects directory
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        steadmon@google.com, jrnieder@gmail.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        emilyshaffer@google.com, sluongng@gmail.com,
        jonathantanmy@google.com, derrickstolee@github.com,
        dstolee@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> If the lock file already exists, then fail silently. This will become

Maybe "skip all maintenance steps silently"?

> +	if (hold_lock_file_for_update(&lk, lock_path, LOCK_NO_DEREF) < 0) {
> +		/*
> +		 * Another maintenance command is running.
> +		 *
> +		 * If --auto was provided, then it is likely due to a
> +		 * recursive process stack. Do not report an error in
> +		 * that case.
> +		 */
> +		if (!opts->auto_flag && !opts->quiet)
> +			error(_("lock file '%s' exists, skipping maintenance"),
> +			      lock_path);
> +		free(lock_path);
> +		return 0;
> +	}

As it is, this doesn't seem very silent. :-) If we do want a message to
be printed maybe make it warning instead of error.

Other than that, the idea of having a lock file and the implementation
in this patch look good to me.

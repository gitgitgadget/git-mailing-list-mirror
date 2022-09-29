Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BC8C433FE
	for <git@archiver.kernel.org>; Thu, 29 Sep 2022 21:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiI2VtT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Sep 2022 17:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiI2VtN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2022 17:49:13 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE11A130715
        for <git@vger.kernel.org>; Thu, 29 Sep 2022 14:49:11 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id q8-20020a632a08000000b0043cab9c7de9so1663127pgq.3
        for <git@vger.kernel.org>; Thu, 29 Sep 2022 14:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lX15tIFF9ySTTtNXwQkaAHhTZjpq+klhNY3ybUHdpsQ=;
        b=pP1xtJ7pcTfY4XedqA3XVuTD0Rb8OM4XVYNerQvaaaopGmyFA/U9T6rOwDU/Wclpc4
         oeGIbNbDGbREuXp2pHwdQnLrPB9lQAjC9VB4/Aw7ynwBg6AAwfTDRFOX5Uk+yVBqUd0Q
         3B3qBZDYZ1ADpUZgiAHCSYQWSZtASRZdxwHHQw5+POKCrpMJS/Tsg2O4DXNFQq5yvHWu
         NJhL4H7Fiuz9jYQS6l0YQh5fpkEQnlq+D/qqJfPKqX2h/ukxYXTrEmC9wUPtCAKSgSc+
         EgoTkwpu+MpKElN3/S/bYQLU/TO9yiOxHNRT6djjn6ujDkhF82Zy46BWe5RELfXgCTmH
         fuwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lX15tIFF9ySTTtNXwQkaAHhTZjpq+klhNY3ybUHdpsQ=;
        b=uQebHE65To6GjmXQyWlS0GVYDViBR71iVqg3a/hgiREy9kW7PIHd7gOV1Skmx6IYFL
         coWtUofH6VcXoNlpqfmvP9SEUcC889+uU2Wxp3qkCy0/YaKIWAhgMKXe+MVBi250OgSt
         04j/T2XiW5bEf6Tt5ZhiY54wyolboPHZ620SenDcBo+0W11hk+hGkBDkk8umNBzUwKyt
         XfuafC24dtenkUF1UXoooEmYnHzEwu5IC8YpydAAktUTlrSRXMq2ztj2VcP7rSIuzhaX
         P+VDqRK/tA9IGtVmpk+w1zOCd4J6KJjEQVOHddNeO0w21PURwlrAC972QZw/+8NhV3g9
         bIaw==
X-Gm-Message-State: ACrzQf2q40ZlVlYII0kLQaCuPIiatgAJmDvwsRc5bxvBJ7e6TR5jSGim
        TB2jNPKW9u873JiEQiTCufJuu8MUNf1mfiprEipm
X-Google-Smtp-Source: AMsMyM5owq6twlbj7G9FjvR6EXhXzpdXqCETf/XvVSZ+ey8E88i5hIMjAm2S9bO4TBe0W+xfy/ue/Uy7dbz7D2RlUOeD
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a63:df10:0:b0:43b:e82f:e01c with
 SMTP id u16-20020a63df10000000b0043be82fe01cmr4720246pgg.19.1664488151341;
 Thu, 29 Sep 2022 14:49:11 -0700 (PDT)
Date:   Thu, 29 Sep 2022 14:49:06 -0700
In-Reply-To: <70daef66833744fb8b870f431af8201222c7a2ba.1662734015.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20220929214906.1437133-1-jonathantanmy@google.com>
Subject: Re: [PATCH v2 4/9] bundle-uri: create base key-value pair parsing
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        Glen Choo <chooglen@google.com>,
        Teng Long <dyroneteng@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> @@ -65,6 +66,81 @@ int for_all_bundles_in_list(struct bundle_list *list,
>  	return 0;
>  }
>  
> +/**
> + * Given a key-value pair, update the state of the given bundle list.
> + * Returns 0 if the key-value pair is understood. Returns 1 if the key
> + * is not understood or the value is malformed.
> + */
> +MAYBE_UNUSED
> +static int bundle_list_update(const char *key, const char *value,
> +			      struct bundle_list *list)
> +{
[snip]
> +	if (parse_config_key(key, "bundle", &subsection, &subsection_len, &subkey))
> +		return -1;

The comment at the top should say -1 instead of 1.

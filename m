Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E6D6C77B75
	for <git@archiver.kernel.org>; Mon,  8 May 2023 22:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234003AbjEHW3Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 18:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233464AbjEHW3Y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 18:29:24 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA2865B6
        for <git@vger.kernel.org>; Mon,  8 May 2023 15:29:23 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-53033a0b473so643661a12.0
        for <git@vger.kernel.org>; Mon, 08 May 2023 15:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683584963; x=1686176963;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RfgJyfbDxXf9aTu1mXaJ0H6E2Ktdg9kTMjcmFi8et54=;
        b=HSXFssA/fNSXs2g/b86h3Ad4EixS9PBs+SPJ9mQyN3mq5AW6QM3F6PcseOlafcs8GA
         zxniYpkNta0SFJ7EjX4TWenho/dbBQAYD8siXwLJ8MEqVKYkVudaiEJBv2V7Mcu9Eif2
         zYCGpVCVte94RC9IigXMp/oCRFC61p6vNWYprdWkyxkRiCbpdRi0qgxh3S1ewx+YH6hZ
         H4ZxXHfRTL0iW1AyIaZhaRUcsd+WXYHY8EFNlpshCNfIeg/f27qN0BnlRAPwY2mCtM3Z
         2DNibo+aCGtNRRJ6Um6Mlg9z6qd5hbBElEabzUtWBGGPcGH6wdW/QbD+hnGUaTL9v5q5
         jXmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683584963; x=1686176963;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RfgJyfbDxXf9aTu1mXaJ0H6E2Ktdg9kTMjcmFi8et54=;
        b=NCm7b3g5bcZUxoUnMBNne0VIK9CvKFCOuGwdSnSuelyjaBcFjXTWpuSr+appUD85Qz
         UysJp1gp/cg5aJ8XCcy6q48Og9VFdhJh+dL9N/91lJBwTSnVbCLwO+feF4zz9FpTiw2e
         nmO/NmxelmU1CB+BjrJm0MQAVxv9IoDVAOdbHJgVX9zUYU6fqiK+A+U0aivvTu2Rq/YR
         RBP2FCB48QViMPWHoag5eZliROZItpF+6RscznLPs/Q09C9gdQ28fkdaGdxH2VPMBQ6T
         6VK+hep4XQStef3xakTcdqwMwvAibtV4ct7OQb0lqT65fOj4uyCcA0Yu221ZB+UaKzXB
         5khg==
X-Gm-Message-State: AC+VfDxIgf40M4aDzz3U315x36NLjcDtjl4GXebCMPzsFuVLDfgrD7Iu
        VP9I1OpKH+6veHqo2H3c1Dc=
X-Google-Smtp-Source: ACHHUZ64OVrgBOlDK3m2WYNjroMDE5Ges5Sw6yqEV0IrQ/PCcQc3m4hx3RFnG14Hf2Sxqd70ZdBF1Q==
X-Received: by 2002:a17:902:e74e:b0:1ab:19fe:d85b with SMTP id p14-20020a170902e74e00b001ab19fed85bmr14662228plf.38.1683584962810;
        Mon, 08 May 2023 15:29:22 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id v11-20020a1709029a0b00b001a96562642dsm7734373plp.277.2023.05.08.15.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 15:29:22 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 04/15] ref-filter: add ref_filter_clear()
References: <cover.1683581621.git.me@ttaylorr.com>
        <c804ba3620476713bd0535a315876378149ad7dd.1683581621.git.me@ttaylorr.com>
Date:   Mon, 08 May 2023 15:29:22 -0700
In-Reply-To: <c804ba3620476713bd0535a315876378149ad7dd.1683581621.git.me@ttaylorr.com>
        (Taylor Blau's message of "Mon, 8 May 2023 17:59:52 -0400")
Message-ID: <xmqqr0rq4ful.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> From: Jeff King <peff@peff.net>
>
> We did not bother to clean up at all in branch/tag, and for-each-ref
> only hit a few elements. So this is probably cleaning up leaks, but I
> didn't check yet.
>
> Note that the reachable_from and unreachable_from lists should be
> cleaned as they are used. So this is just covering any case where we
> might bail before running the reachability check.
> ---

Not signed-off?

> +void ref_filter_clear(struct ref_filter *filter)
> +{
> +	oid_array_clear(&filter->points_at);
> +	free_commit_list(filter->with_commit);
> +	free_commit_list(filter->no_commit);
> +	free_commit_list(filter->reachable_from);
> +	free_commit_list(filter->unreachable_from);
> +	ref_filter_init(filter);
> +}

And the previous step matters here---otherwise we will end up
walking two commit lists whose elements have all been popped
in reach_filter().

Makes sense.

> +void ref_filter_init(struct ref_filter *filter)
> +{
> +	struct ref_filter blank = REF_FILTER_INIT;
> +	memcpy(filter, &blank, sizeof(blank));
> +}


I wonder if structure assignment "*filter = blank" is easier to see
but I think we've seen this "_INIT; memcpy()" dance before.



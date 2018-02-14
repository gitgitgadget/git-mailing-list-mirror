Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BB141F404
	for <e@80x24.org>; Wed, 14 Feb 2018 00:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966191AbeBNAMa (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 19:12:30 -0500
Received: from mail-pg0-f54.google.com ([74.125.83.54]:42535 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966159AbeBNAM3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 19:12:29 -0500
Received: by mail-pg0-f54.google.com with SMTP id y8so1116372pgr.9
        for <git@vger.kernel.org>; Tue, 13 Feb 2018 16:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+J9ql/PHddttLPG4YPMqIyzE+ueEnDCZ0nwWxTV+khI=;
        b=Hc5d5yR8ReDUQ7WxOvMSt0SAyi38E/KM/k0CAma6X7AHhzBjNlBIeR0eK6KgW0eZIG
         OoCILj2dp13Vr2PtnHfGuy5fjmSJdKTC9STTbX9PjLyif/11Aqb+krzfT7lGgoUwFBYG
         0JNvXxYE8ayUg7kKCBclHEjxktnpqkToGtDv0Jia0t0rB/vFIX8JB9eQw+z/s5cVqV0p
         i9Cls3Kzt86bhSmXjQsMKrFKfPebv76zjBFMSHltAd4mbYiwftMgh0q4Ej7c0byWjwkf
         e2FJnuwt3QRy1BtO3CO8zDhOgVkNmAX06LRsuEEJ0zgJqHiHdgo9YBKlvI6q+MEyeGXh
         wIKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+J9ql/PHddttLPG4YPMqIyzE+ueEnDCZ0nwWxTV+khI=;
        b=VlJu64Jt41KWgTZJt/NmVWINJK9D2LAXrhvP5TQ/BWzh7ndjs7jalO1U4SInC+8pP/
         Ug+vPOS1wnfvcXEuyWharUK1TwvdeY6/s0FrpR2OpQKX1xsu4xAjSdVI8Wfpa6HDzAlh
         Oeqp8dzdpamQIih4j20mhuGgZ/V0JNWv/7QV7lkKdB2hmx/XEs25fXRocUEV924OK/+p
         BCZ03x95hoINiBnZnPxUG6v4zoJcWxLTMUM2ngSjP07rb6h7Hc53Df2ohrYCtWxeTkzL
         hUpQTDUXVzN9MKkQjB+8z/BxbqwN+8Ccm/w0VudeGpnKMhsDcqTzfuPU5yIvdT1f05nm
         ET1Q==
X-Gm-Message-State: APf1xPBMKrUrFMnRjYBYLy6pxA+xOliDriZqXXQDw0p2bkcax1wTmdnB
        m/YHN4Q3LdDJHSIclH9WWV1dsw==
X-Google-Smtp-Source: AH8x225SHjSvozmZoraiUqYg6xlumotClODnbp/kd1yWae1U0IRq2W46u+rdAEzS+xMDIjog3qf/9g==
X-Received: by 10.101.74.132 with SMTP id b4mr2376202pgu.355.1518567148621;
        Tue, 13 Feb 2018 16:12:28 -0800 (PST)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id l64sm38138431pfg.62.2018.02.13.16.12.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Feb 2018 16:12:26 -0800 (PST)
Date:   Tue, 13 Feb 2018 16:12:25 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, git@jeffhostetler.com,
        gitster@pobox.com, peff@peff.net, sbeller@google.com,
        szeder.dev@gmail.com
Subject: Re: [PATCH v3 11/14] commit: integrate commit graph with commit
 parsing
Message-Id: <20180213161225.6e21291d25015be632b03fee@google.com>
In-Reply-To: <1518122258-157281-12-git-send-email-dstolee@microsoft.com>
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
        <1518122258-157281-1-git-send-email-dstolee@microsoft.com>
        <1518122258-157281-12-git-send-email-dstolee@microsoft.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu,  8 Feb 2018 15:37:35 -0500
Derrick Stolee <stolee@gmail.com> wrote:

> | Command                          | Before | After  | Rel % |
> |----------------------------------|--------|--------|-------|
> | log --oneline --topo-order -1000 |  5.9s  |  0.7s  | -88%  |
> | branch -vv                       |  0.42s |  0.27s | -35%  |
> | rev-list --all                   |  6.4s  |  1.0s  | -84%  |
> | rev-list --all --objects         | 32.6s  | 27.6s  | -15%  |

Could we have a performance test (in t/perf) demonstrating this?

> +static int check_commit_parents(struct commit *item, struct commit_graph *g,
> +				uint32_t pos, const unsigned char *commit_data)

Document what this function does? Also, this function probably needs a
better name.

> +/*
> + * Given a commit struct, try to fill the commit struct info, including:
> + *  1. tree object
> + *  2. date
> + *  3. parents.
> + *
> + * Returns 1 if and only if the commit was found in the commit graph.
> + *
> + * See parse_commit_buffer() for the fallback after this call.
> + */
> +int parse_commit_in_graph(struct commit *item)
> +{

The documentation above duplicates what's in the header file, so we can
probably omit it.

> +extern struct object_id *get_nth_commit_oid(struct commit_graph *g,
> +					    uint32_t n,
> +					    struct object_id *oid);

This doesn't seem to be used elsewhere - do you plan for a future patch
to use it?

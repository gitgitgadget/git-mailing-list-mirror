Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A47E1FCA0
	for <e@80x24.org>; Mon, 27 Mar 2017 23:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752955AbdC0Xc0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Mar 2017 19:32:26 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35098 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752701AbdC0XcZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2017 19:32:25 -0400
Received: by mail-pg0-f65.google.com with SMTP id g2so16568506pge.2
        for <git@vger.kernel.org>; Mon, 27 Mar 2017 16:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=afxrEwONYeSnBVd7eecENktolZJVx8hh0DRiN1HP77c=;
        b=HBbClrYkspyJ/1IKfEdggiMq0rDYjzyoZDtznEgueTBwaIEDVnTWtH9Kyicv0pY2qI
         2j5/ZgzBqP7fw1IlCBZBvxK4dTfQE/dTzFPZgdXM78jeFjlrsO1wFPqY5KAF4a1ESuwj
         RO3USpdxBnR5TOoOweuHz4ZQnl2rLkyN8HPB1NlGbiU9Nj/6NjSK4Ag4d4idW3+CocZ/
         xoqgGwsBzY63GXiFZpJNIXMAe7nmqX4v3eAS0pQNooqhX6+/lefa+VD2+2IjYZ2+OJzU
         bT8HboMDLJ+Lkqgf3PNk5blPHJCP65fONfC7nWRifZ4+V8koYl6GlrvigyrQj+ZvGNHT
         BlxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=afxrEwONYeSnBVd7eecENktolZJVx8hh0DRiN1HP77c=;
        b=SfYiUD5clTel24ldZ8EaJ84XeeLL2rENhyu9X99cSr2dBaj9EKmfedf4R14JKTGbQt
         iquXQo9tKN7c+xMRi7xl0DEooKE38sECaWoE5nh/L+Meq0HxS/nrcc+7veMVeITk39lf
         K//scyj7clAS7z+DdBjrx7XHZjPsTzA02BXxik2MX3focP8/fdW9mrxeLraGNqUlxx1l
         uCF85Wl26LRtT21DaSE9eugf9DZY+mb/eUulKk/hcjT+PY7t/GLATHNhoSoo9iPd2DTN
         1K7a2sIwuZOnkYil5JIYA8edTOgJbeIOeScu5XxWuFjdLmQ6TfJEXtws3BK61HIZaOuF
         +4Pw==
X-Gm-Message-State: AFeK/H20GS5L/KzEUw65ahDjc2xwn/Xyo+YnbUnfdFEe96h9mhrmCWPuMNnZpBHMX6qVkA==
X-Received: by 10.99.94.198 with SMTP id s189mr26976763pgb.211.1490657533430;
        Mon, 27 Mar 2017 16:32:13 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:c051:ab1a:5a93:a0ac])
        by smtp.gmail.com with ESMTPSA id z62sm3152137pff.88.2017.03.27.16.32.12
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 27 Mar 2017 16:32:12 -0700 (PDT)
Date:   Mon, 27 Mar 2017 16:32:10 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@jeffhostetler.com, git@vger.kernel.org, gitster@pobox.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 1/2] read-cache: skip index SHA verification
Message-ID: <20170327233210.GO31294@aiede.mtv.corp.google.com>
References: <1490648979-49580-1-git-send-email-git@jeffhostetler.com>
 <1490648979-49580-2-git-send-email-git@jeffhostetler.com>
 <20170327224408.2bzh5vfa6deni6fm@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170327224408.2bzh5vfa6deni6fm@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:

> Hrm, there shouldn't be any dependency of the config on the index (and
> there are a handful of options which impact the index already). Did you
> try it and run into problems?
>
> In general, I'd much rather see us either:
>
>   1. Rip the code out entirely if it is not meant to be configurable,
>      and cannot be triggered by the actual git binary.
>
> or
>
>   2. Make it configurable, even if most people wouldn't use it. And then
>      have a test to exercise it using a git command (unlike the one-off
>      test helper, which isn't run at all).

Agreed with this, leaning toward (1).

If "git fsck" verifies the .git/index file then I don't see any need
for other commands to.

Thanks and hope that helps,
Jonathan

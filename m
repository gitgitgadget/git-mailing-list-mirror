Return-Path: <SRS0=Rj9+=DP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB73FC43457
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 16:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EF5E21D7D
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 16:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6dLuA04"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729506AbgJHQ0b (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Oct 2020 12:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728620AbgJHQ0b (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Oct 2020 12:26:31 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9F8C061755
        for <git@vger.kernel.org>; Thu,  8 Oct 2020 09:26:31 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id t20so3358773qvv.8
        for <git@vger.kernel.org>; Thu, 08 Oct 2020 09:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HdZ+i6yWMTIJumHK/3JSH4roJpLhWPjCwnWUVY3av9A=;
        b=L6dLuA0416F6L0y8a0kdmaf/Ve3SUwXcX23aT4Gk5J0pqA4sBSuivErkrKGcfUM1ZT
         EM8rlRftHTiJGc88yG4iKZ/UxfMEY1sOjKKzkWwH3mpf4LAyWzt434QTOTbGUNDLw5tz
         GbaLniHcqS/vjqT+Yxcro5QDZNZbipYmt1l93DhPAkJWfU1W5RoSSgo5UlEl9lyXUUUf
         +iVJDn1lKErGlG42ynbSY7lNSjH+9U+M2cNtqifs8DOQgwiL99WiNTlzs5GJYQgTEHG8
         bOiCOeBSZ6a5iDcEtClQSr9Yt/Lo/NjFIOTtkPkD/IfNfbItEqBnG+ERihqVVOm0dEvG
         WKiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HdZ+i6yWMTIJumHK/3JSH4roJpLhWPjCwnWUVY3av9A=;
        b=GHACk3441S/YxUSn30lRLPZZeXWva0M3o+td1l7f7bzQIaZUc7HbLodhU6rCWcWk7S
         ntFgqKuylyE+hpKZXXaNtW7cLoLhQ6LySpvR5/EkBltebM41Qq9znlu0YXJVoc3C8YOz
         ohETMsKfIVdfoLMxNPhMncNhVgxtwZvOZtlj+p5wd4cEOLU4o7SY8MZxE4urHXGuzQRY
         t7e+JFJ9FapL/3RJ+XXjqpw+d9lM3UODKdW/EPSM3vny9QWjNrUhMsg5e6edYjZpygit
         41mWTj73IZP0FPxTayC+R/pNRuODpMmbvUYvQb/lDAcUT4zsQXvZLwpknLZRyuWdYcKN
         qDHg==
X-Gm-Message-State: AOAM531tAwrPZR3009yZnMvKheKy8kVS9ss00vjC0DeIegJYHsFmqhIF
        JOXRUKGOu2ext/izC+O5/gVDQJYEcVHEYg==
X-Google-Smtp-Source: ABdhPJwl0BM5lrHiOwwNvxn0s7xgqTju3a7I9B3ESxzX53z/6WiVnGAs4AOdJcUmDxwcI5B/GVZp6g==
X-Received: by 2002:a0c:b9a0:: with SMTP id v32mr8944069qvf.58.1602174390089;
        Thu, 08 Oct 2020 09:26:30 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:54e2:eee4:6579:8f40? ([2600:1700:e72:80a0:54e2:eee4:6579:8f40])
        by smtp.gmail.com with UTF8SMTPSA id 198sm4326878qki.117.2020.10.08.09.26.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2020 09:26:29 -0700 (PDT)
Subject: Re: [PATCH v3] commit-graph: ignore duplicates when merging layers
To:     Jeff King <peff@peff.net>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.747.v2.git.1602169145625.gitgitgadget@gmail.com>
 <pull.747.v3.git.1602169479482.gitgitgadget@gmail.com>
 <20201008155304.GA2823778@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <e1d4c427-b9a7-261a-6297-4a4768e8dbc0@gmail.com>
Date:   Thu, 8 Oct 2020 12:26:29 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:82.0) Gecko/20100101
 Thunderbird/82.0
MIME-Version: 1.0
In-Reply-To: <20201008155304.GA2823778@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/8/2020 11:53 AM, Jeff King wrote:
> On Thu, Oct 08, 2020 at 03:04:39PM +0000, Derrick Stolee via GitGitGadget wrote:
>> @@ -2023,17 +2023,27 @@ static void sort_and_scan_merged_commits(struct write_commit_graph_context *ctx)
>>  
>>  		if (i && oideq(&ctx->commits.list[i - 1]->object.oid,
>>  			  &ctx->commits.list[i]->object.oid)) {
>> -			die(_("unexpected duplicate commit id %s"),
>> -			    oid_to_hex(&ctx->commits.list[i]->object.oid));
>> +			/*
>> +			 * Silently ignore duplicates. These were likely
>> +			 * created due to a commit appearing in multiple
>> +			 * layers of the chain, which is unexpected but
>> +			 * not invalid. We should make sure there is a
>> +			 * unique copy in the new layer.
>> +			 */
> 
> You mentioned earlier checking tha the metadata for the duplicates was
> identical. How hard would that be to do here?

I do think it is a bit tricky, since we would need to identify
from these duplicates which commit-graph layers they live in,
then compare the binary data in each row (for tree, date, generation)
and also logical data (convert parent int-ids into oids). One way
to do this would be to create distinct 'struct commit' objects (do
not use lookup_commit()) but finding the two positions within the
layers is the hard part.

At this point, any disagreement between rows would be corrupt data
in one or the other, and it should be caught by the 'verify'
subcommand. It definitely would be caught by 'verify' in the merged
layer after the 'write' completes.

At this point, we don't have any evidence that whatever causes the
duplicate rows could possibly write the wrong data to the duplicate
rows. I'll keep it in mind as we look for that root cause.

Thanks,
-Stolee

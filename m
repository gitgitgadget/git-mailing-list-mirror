Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE3BC6FA99
	for <git@archiver.kernel.org>; Wed,  8 Mar 2023 00:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjCHAJe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Mar 2023 19:09:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjCHAJb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2023 19:09:31 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D2AA6164
        for <git@vger.kernel.org>; Tue,  7 Mar 2023 16:09:30 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5395c8fc4a1so151195007b3.5
        for <git@vger.kernel.org>; Tue, 07 Mar 2023 16:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678234169;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QtrrEEx1MocBKOpZxotpwEV57n3Z1zGYaD/mNxPXcrM=;
        b=oTjeFMR924naAv40++wIyKeT6gbrNIiJUvu/DulF1jY6Xv17eVTFoeE+3Frp+3aFaw
         PVXtiQ43jTfy4MTdV98UAInkGu/LbeITfocGqGUw2PVNSWG/g7/I7SMAdgOZRph77eqh
         o6ZDo8ZK7AFxRvGGPvkQwJqNAmJVonLX9tlokzt/IRuuTxLiJaGgEPn6GQdBSHhfQj4r
         zYxoBhWtjJTXsu/ciMMM1ak0wZKmToZXlr+/hh4HTW+5bCT7I49+ePDSIl0VQAyLkITy
         0kvEjeSk/kmT/y0y148NJko2DpnYtTrrUYDghVvGj66KQXGgBqcEUK/HS00VMmh+iSVr
         D1Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678234169;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QtrrEEx1MocBKOpZxotpwEV57n3Z1zGYaD/mNxPXcrM=;
        b=vWekB4g5PaD0nzWxgBAk5oWOnLAU0YMjZ2tga/d6WP5932+poyDhXuiMhx9GW94bas
         KFfF+mHb5ILGctHpuOHBpXKsedR6XZ6bfdg7zEF+IcJg/YcbHIyisdMX9S8HhXAPu9Au
         C6+Ftzsfwh5dIuiPEn6eF1X/EnQkbm/gpyL9/WSbYwbzKJqOzMSzWI5w94LzbKPDftUY
         EC8b4pHq8Io69DeN2JyLFPt+oK+Cpi7ZNDg2IV9W7NpaCDRvJRVRw+VjFEB9D3RoLPne
         p0zz2RAwetdYo4UBQbEPHVJY84xVhKD2mTzQUUSpVP2H44ICp9mL2RraczglhG4lI+9k
         I8tw==
X-Gm-Message-State: AO0yUKVG4nCyDUBuIBiuxOUavHypz22Q/WVfIM+RkZls3FZnJuEQjpqj
        K8iW5m5R7tR+cQRhgndy9J0EJSZb4CY+lg==
X-Google-Smtp-Source: AK7set/PqNixSZqxbYeam/XY200+S4Wj4nGPD3YdE7AWJLBegks6shXLUWvYiUL2dBG9t8uiIMx60S2CqgJoeg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a05:6902:4d4:b0:a03:da3f:3e68 with SMTP
 id v20-20020a05690204d400b00a03da3f3e68mr9875580ybs.12.1678234169771; Tue, 07
 Mar 2023 16:09:29 -0800 (PST)
Date:   Tue, 07 Mar 2023 16:09:28 -0800
In-Reply-To: <7cf19017-518b-245e-aea2-5dee55f88276@dunelm.org.uk>
Mime-Version: 1.0
References: <20230225180325.796624-1-alexhenrie24@gmail.com>
 <20230305050709.68736-1-alexhenrie24@gmail.com> <20230305050709.68736-4-alexhenrie24@gmail.com>
 <7cf19017-518b-245e-aea2-5dee55f88276@dunelm.org.uk>
Message-ID: <kl6l4jqwhznr.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v6 3/3] rebase: add a config option for --rebase-merges
From:   Glen Choo <chooglen@google.com>
To:     phillip.wood@dunelm.org.uk, Alex Henrie <alexhenrie24@gmail.com>,
        git@vger.kernel.org, tao@klerks.biz, gitster@pobox.com,
        newren@gmail.com, phillip.wood123@gmail.com,
        Johannes.Schindelin@gmx.de, sorganov@gmail.com,
        calvinwan@google.com, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>> @@ -800,6 +813,15 @@ static int rebase_config(const char *var, const char *value, void *data)
>>   		return 0;
>>   	}
>>   
>> +	if (!strcmp(var, "rebase.rebasemerges")) {
>> +		opts->config_rebase_merges = git_parse_maybe_bool(value);
>> +		if (opts->config_rebase_merges < 0) {
>> +			opts->config_rebase_merges = 1;
>> +			parse_rebase_merges_value(opts, value);
>> +		}
>
> I think we need
>
> 	} else {
> 		opts->rebase_cousins = 0;
> 	}
>
> here. Otherwise if rebase.rebaseMerges is set twice we wont follow the 
> usual "last config wins" convention. For example
>
> 	[rebase]
> 		rebaseMerges=rebase-cousins
> 		rebaseMerges=true
>
> will result in us unexpectedly rebasing cousins

Ah, good catch.

An alternative might be to use the "lookup" functions (e.g.
repo_config_get_maybe_bool()), which already implement "last one wins"
semantics. It's a bigger change, but it may be easier for future readers
to understand. I don't have a strong opinion on which is the 'better'
approach.

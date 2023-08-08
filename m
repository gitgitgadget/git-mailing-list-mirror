Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A7AC41513
	for <git@archiver.kernel.org>; Tue,  8 Aug 2023 16:23:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbjHHQXI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Aug 2023 12:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232516AbjHHQVd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2023 12:21:33 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA099EC4
        for <git@vger.kernel.org>; Tue,  8 Aug 2023 08:49:11 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2ba0f27a4c2so87024201fa.2
        for <git@vger.kernel.org>; Tue, 08 Aug 2023 08:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691509750; x=1692114550;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Fqcf4bH5L14XhsigffFAT/vOVUmIRRqi8eO30ANGV9A=;
        b=q0RWB1bGan9QnNHpox6tYqg0LaBbx/sm30+h4szmVWG5Hvxm4teOOcWQ8RBgcT9R8H
         nUZWd3qkMncWZ/cFRbGOS314j6a2xunM4I5dEP/+i5q4D4KBs3FjvAdw4sHOxJDraLiB
         CzjYPX3IGGdWJOgF6FppHVvqoi0aiZ0zVu1hYsfeWD1TsfjBcJlh4bjqkzHRz0xyaJrf
         LSMEpdzrmXuSCEbkymlL8uSHJrDlO1QVy4yUyt/E4KT/06xL4BjTlRNyTU5asR2Vi3wM
         LkEP6nymD/XvsjActAig2ll4lHEM/Q+CrLLpzcOE0KGbnwZjmfTVsH/no7Ei23u1utmP
         gU2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691509750; x=1692114550;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fqcf4bH5L14XhsigffFAT/vOVUmIRRqi8eO30ANGV9A=;
        b=g6Dh6I95lTx76vRB58OlSS8k4+OrTdeXGKD3WxLsjg9BMUef1W8Q5Q8eociEO7rK5u
         OwrZ2TIaMf0Pq63yObOcgyf2H0ODQWwAMYYUImj7m80CNxVhDeooFplVQ231z650AoBF
         B1MAItFSWd0VzcfgB1IiDIryg3E0RRcd0GoyChS28gDUEiy2UVjccHqMP22sxqrCMLKv
         kSsgortXSnIxHtSobA/P+haXPCAWS/LQRJ9U6PWolFonungTvpJSOJmB15XHOQCju4rL
         TsV/jX1c4hkFQadYoPpVgC0PvcLJ/kCBQe4mhPs4TnkC4Ng70w+6hSx7QYRVKuD7795c
         eyNQ==
X-Gm-Message-State: AOJu0YxoCwCjEZd3WCSIXvbTu+ESx1uLMYTjYdC6nweWmaIUyeAE9OdM
        9u8Y6EW4SlZ7q7gTL7rc+9F1TRKozbo=
X-Google-Smtp-Source: AGHT+IHmhTlGXz7O1A0CN6BDMagfl2JAflkDYMeEbpn3XonhtJkDd0yp+ZPwHrRcl4oyoRkIyCTs1w==
X-Received: by 2002:a2e:80da:0:b0:2b9:cf90:ab9c with SMTP id r26-20020a2e80da000000b002b9cf90ab9cmr8901318ljg.8.1691488437048;
        Tue, 08 Aug 2023 02:53:57 -0700 (PDT)
Received: from [192.168.1.212] ([90.242.223.1])
        by smtp.gmail.com with ESMTPSA id k18-20020a7bc412000000b003fbbe41fd78sm13313517wmi.10.2023.08.08.02.53.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 02:53:56 -0700 (PDT)
Message-ID: <adc0cf80-c2e3-7af2-6d7f-036b95d27f80@gmail.com>
Date:   Tue, 8 Aug 2023 10:53:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 6/6] maintenance: use random minute in systemd scheduler
Content-Language: en-US
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, sandals@crustytoothpaste.net, lenaic@lhuard.fr,
        Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>
References: <pull.1567.git.1691434300.gitgitgadget@gmail.com>
 <14e340b75faaa66980479f42fec14c457aea5c74.1691434300.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <14e340b75faaa66980479f42fec14c457aea5c74.1691434300.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee

On 07/08/2023 19:51, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <derrickstolee@github.com>
> +	switch (schedule) {
> +	case SCHEDULE_HOURLY:
> +		schedule_pattern = xstrfmt("*-*-* *:%02d:00", minute);
> +		break;
> +
> +	case SCHEDULE_DAILY:
> +		schedule_pattern = xstrfmt("*-*-* 0:%02d:00", minute);
> +		break;
> +
> +	case SCHEDULE_WEEKLY:
> +		schedule_pattern = xstrfmt("Mon 0:%02d:00", minute);
> +		break;

This is not a new issue with this patch but we run the hourly job even 
when we want to run the daily job or the weekly job and we run the daily 
job when we want to run the weekly job.  maintenance_run_tasks() contains

	if (hold_lock_file_for_update(&lk, lock_path, LOCK_NO_DEREF) < 0) {
		/*
		 * Another maintenance command is running.
		 *
		 * If --auto was provided, then it is likely due to a
		 * recursive process stack. Do not report an error in
		 * that case.
		 */
		if (!opts->auto_flag && !opts->quiet)
			warning(_("lock file '%s' exists, skipping maintenance"),
				lock_path);
		free(lock_path);
		return 0;
	}

So only one of these jobs will succeed. The cron entries are careful to 
only run one job at a time, I think it would be worth doing the same 
thing here. I think the using the following format strings would fix this.

Hourly: "Tue..Sun *-*-* 1..23:00:%02d"
Daily:  "Tue..Sun *-*-* 00:00:%02d"
Weekly: "Mon      *-*-* 00:00:%02d"

It looks like the launchctl schedule has the same issue.

One thing I've been wondering about which is related to maintenance but 
totally off-topic for this patch is that I think when auto maintenance 
is enabled we stop automatically running "gc" so how do the reflogs get 
expired?

Best Wishes

Phillip

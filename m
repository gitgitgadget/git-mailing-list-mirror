Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 403B6C433F5
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 16:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiBXQI1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 11:08:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbiBXQIN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 11:08:13 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD65517AED5
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 08:07:40 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id d84so2145447qke.8
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 08:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=q4+hkr2pmxfGIW7eoR+N/OJ5qpcSF84Xo4POXWfPods=;
        b=KPl4x9qVIaskHmYOkizTjrpq2bYkiaQ8GoUBhufpiA1cu8PzyD6LjGODqzTdNUcsnB
         f7vtxzPlceSu2/R8mjKoMWqKBW/3cA0tHPlgg/ILRsyy1T2HZ7f3UwuoVRHjkeQmVnL8
         /1/JAxaTvhIGe2QZGp//NAY90M3hHl9aq8ugDToiZ9DFzujGg4Lv6p3ate4M5bQETYS3
         bhK2jL2OUfqYvoiYWvZlkyXJSMUf4Z0tG0FSfL2LZnlVTAFor5fxupYt6irefXwymRX2
         FV7cwvwIyigiOz2EP9Qv5dOsnzXyptWCpADUlvMJ8eQZYqPC/DFZr2au8GUs9sVoLN0k
         fO/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=q4+hkr2pmxfGIW7eoR+N/OJ5qpcSF84Xo4POXWfPods=;
        b=x/5TpCuuQK26++139fIdm3oPcPjKQQniqlZ7CVNXvhcArDvM5XAqZriLXHUPWFQf1c
         YEonjEKl9GV8ZCCq9OzpW5oNr5pZZydjiL54q3l57119+VyTkAwvToWg5QrFtAnlb54Q
         6LzmZAZYlTLtyDFj0WCAA8YekOe2vXxC4OTz7JYSU7crYDy4DA+6+ME7TpnfKyZWfYav
         e7BIKIev7ljMb1BOWX9G4MvqgLSC1arA1Vv4YyJf/0FN0ZWZIT6+S0FSZS+/P3qhMcVa
         0bYP2wm4312AihudcllcWw+8yFU7l+DbYB1pDQi3CtEXtlnZNbU1fUrJhjPbqpDuVwTu
         Waog==
X-Gm-Message-State: AOAM531EuZWNLtn2Oci1H9JoXEbbhAdGgdR8tlfTxqqVITKmW40Yi6RZ
        eDeS7T3CiMbtIp0Bx9Th9NWv
X-Google-Smtp-Source: ABdhPJxItIlDj2PWcuQSYNMSUYxosDjj04lMsd8qg4c53kQN1KLeCfos2eTGGc1qfcN0oxnYL3tmwA==
X-Received: by 2002:a37:3c5:0:b0:46c:e3c1:722b with SMTP id 188-20020a3703c5000000b0046ce3c1722bmr2091410qkd.742.1645718649533;
        Thu, 24 Feb 2022 08:04:09 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id y2sm1509334qke.109.2022.02.24.08.04.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 08:04:09 -0800 (PST)
Message-ID: <4c784936-7b70-3910-6413-0438e86b23c4@github.com>
Date:   Thu, 24 Feb 2022 11:04:07 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 17/23] fsmonitor--daemon: stub in health thread
Content-Language: en-US
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
 <4a77f5b1fdef3af20fbfefccccc5fee194eb3422.1644940774.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <4a77f5b1fdef3af20fbfefccccc5fee194eb3422.1644940774.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/15/2022 10:59 AM, Jeff Hostetler via GitGitGadget wrote:
> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> Create another thread to watch over the daemon process and
> automatically shut it down if necessary.
> 
> This commit creates the basic framework for a "health" thread
> to monitor the daemon and/or the file system.  Later commits
> will add platform-specific code to do the actual work.

...

> diff --git a/compat/fsmonitor/fsm-health-darwin.c b/compat/fsmonitor/fsm-health-darwin.c
> new file mode 100644
> index 00000000000..b9f709e8548
> --- /dev/null
> +++ b/compat/fsmonitor/fsm-health-darwin.c
> @@ -0,0 +1,24 @@
> +#include "cache.h"
> +#include "config.h"
> +#include "fsmonitor.h"
> +#include "fsm-health.h"
> +#include "fsmonitor--daemon.h"
> +
> +int fsm_health__ctor(struct fsmonitor_daemon_state *state)
> +{
> +	return 0;
> +}
> +
> +void fsm_health__dtor(struct fsmonitor_daemon_state *state)
> +{
> +	return;
> +}
> +
> +void fsm_health__loop(struct fsmonitor_daemon_state *state)
> +{
> +	return;
> +}
> +
> +void fsm_health__stop_async(struct fsmonitor_daemon_state *state)
> +{
> +}

The macOS implementation is stubbed, as advertised.

> diff --git a/compat/fsmonitor/fsm-health-win32.c b/compat/fsmonitor/fsm-health-win32.c
> new file mode 100644
> index 00000000000..94b1d020f25
> --- /dev/null
> +++ b/compat/fsmonitor/fsm-health-win32.c
> @@ -0,0 +1,72 @@
> +#include "cache.h"
> +#include "config.h"
> +#include "fsmonitor.h"
> +#include "fsm-health.h"
> +#include "fsmonitor--daemon.h"
> +
> +struct fsm_health_data
> +{
> +	HANDLE hEventShutdown;
> +
> +	HANDLE hHandles[1]; /* the array does not own these handles */
> +#define HEALTH_SHUTDOWN 0
> +	int nr_handles; /* number of active event handles */
> +};
> +
> +int fsm_health__ctor(struct fsmonitor_daemon_state *state)
> +{
> +	struct fsm_health_data *data;
> +
> +	CALLOC_ARRAY(data, 1);
> +
> +	data->hEventShutdown = CreateEvent(NULL, TRUE, FALSE, NULL);
> +
> +	data->hHandles[HEALTH_SHUTDOWN] = data->hEventShutdown;
> +	data->nr_handles++;
> +
> +	state->health_data = data;
> +	return 0;
> +}
> +
> +void fsm_health__dtor(struct fsmonitor_daemon_state *state)
> +{
> +	struct fsm_health_data *data;
> +
> +	if (!state || !state->health_data)
> +		return;
> +
> +	data = state->health_data;
> +
> +	CloseHandle(data->hEventShutdown);
> +
> +	FREE_AND_NULL(state->health_data);
> +}
> +
> +void fsm_health__loop(struct fsmonitor_daemon_state *state)
> +{
> +	struct fsm_health_data *data = state->health_data;
> +
> +	for (;;) {
> +		DWORD dwWait = WaitForMultipleObjects(data->nr_handles,
> +						      data->hHandles,
> +						      FALSE, INFINITE);
> +
> +		if (dwWait == WAIT_OBJECT_0 + HEALTH_SHUTDOWN)
> +			goto clean_shutdown;
> +
> +		error(_("health thread wait failed [GLE %ld]"),
> +		      GetLastError());
> +		goto force_error_stop;
> +	}
> +
> +force_error_stop:
> +	state->health_error_code = -1;
> +	ipc_server_stop_async(state->ipc_server_data);
> +clean_shutdown:
> +	return;
> +}
> +
> +void fsm_health__stop_async(struct fsmonitor_daemon_state *state)
> +{
> +	SetEvent(state->health_data->hHandles[HEALTH_SHUTDOWN]);
> +}

But it apppears the Windows code is actually implemented. Did you
mean to do that as separate step, or should the commit message
mention that the Windows implementation is included?

Thanks,
-Stolee


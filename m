Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0915C433EF
	for <git@archiver.kernel.org>; Fri, 15 Jul 2022 03:17:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241248AbiGODRw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 23:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiGODRw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 23:17:52 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908A376975
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 20:17:51 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id u6so3003321iop.5
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 20:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=QDyd/dIWX2HYJRAhWuTlpdKUoucmaP0GwlHd0tJuCk0=;
        b=NDVNeUc0T7rtd9wccXe8M0GI1bub7pIgt2TNi0OzE3/J6yH5nqQAl8K+lF0z6zaZv8
         2k20+3VU+f3UQsbEGEnimqXYAQMGdnJh4VK/Sg1vrgZFGGsNac8Ys7SmznemU9blR8fL
         2kPVoeZxnXSKcsfKTPAc+/VTOeZFM/XfUoEzkHUZwgCtDY3Le1MlRqlQRIgiLyeBKdSW
         rt+mlxh62LobSnnfGWo43anr+dzHybtV1EEcKV+FjFOf65ctXNHdsqWwT3WbcdoTez2q
         8tFl19ufwwTOPHzcWCxjWdaq1BnkkMTHwpkDSoK1y0to0QK1i5g562SNh/yFJZsFvI2w
         kMcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QDyd/dIWX2HYJRAhWuTlpdKUoucmaP0GwlHd0tJuCk0=;
        b=OGWTarFyy8OoZBnEym+arfI5F/ZvyrAsHWKOZBPPxVo3LiNuyfjT/bJrcZn8ApEYAb
         z7o020BBOTkQEnxprydAHRsbCDOb6VrcOvNr/bHJtM2iOsm9Pd8JPCXWCB/bqDCA+tdE
         Pe3gn1pATwlMv/OtRagpTPSmMmF0hbTwlnOCWZJKNgsd2EH1bUJzpuU36HZQgaTqZ6w5
         jSxzs87o/6b9kTDZBF/2s79aPdFymBUm33vkbAY4JV1uz0H3As2w0/onZg2aGoNZ4e9q
         VkoWTTn9QZnydhky5w1HU0g9TI1LmqfUEPDaxcT1E4TNHYJD/moTOvOSG4118+jBPajl
         aoUA==
X-Gm-Message-State: AJIora+5nSpkODng/MGCXHZ2NyZ+OVmieINNgJvRTTLVT8nJcI1LAvj5
        oCuqsEQU73hwygqUI7dET5xGW7c3xGGr
X-Google-Smtp-Source: AGRyM1vu8vy/wB1JOsn0RvdMn71yVIfVmfw+cqc6AAx2lFkbVdVd3c7C7JFlTi2lB4MZCK1s/wEGuQ==
X-Received: by 2002:a05:6638:63a:b0:33f:2630:8755 with SMTP id h26-20020a056638063a00b0033f26308755mr6640675jar.182.1657855069576;
        Thu, 14 Jul 2022 20:17:49 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:a446:d79d:69be:6b29? ([2600:1700:e72:80a0:a446:d79d:69be:6b29])
        by smtp.gmail.com with ESMTPSA id b13-20020a05660214cd00b0067b7a057ee8sm1512730iow.25.2022.07.14.20.17.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 20:17:49 -0700 (PDT)
Message-ID: <3036d949-63b2-9d6c-b3f6-0075fe9e1ca5@github.com>
Date:   Thu, 14 Jul 2022 23:17:48 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/3] commit-graph: introduce
 `repo_find_commit_pos_in_graph()`
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, ps@pks.im, wfc@wfchandler.org
References: <cover.1657667404.git.me@ttaylorr.com>
 <e988c974119edbabc06dae6d24810fc0bafbdc94.1657667404.git.me@ttaylorr.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <e988c974119edbabc06dae6d24810fc0bafbdc94.1657667404.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/12/2022 7:10 PM, Taylor Blau wrote:

> +int repo_find_commit_pos_in_graph(struct repository *r, struct commit *c,
> +				  uint32_t *pos)
> +{
> +	if (!prepare_commit_graph(r))
> +		return 0;
> +	return find_commit_pos_in_graph(c, r->objects->commit_graph, pos);
> +}
> +

This is absolutely correct for the given prototype.

>  void load_commit_graph_info(struct repository *r, struct commit *item)
>  {
>  	uint32_t pos;
> -	if (!prepare_commit_graph(r))
> -		return;
> -	if (find_commit_pos_in_graph(item, r->objects->commit_graph, &pos))
> +	if (repo_find_commit_pos_in_graph(r, item, &pos))
>  		fill_commit_graph_info(item, r->objects->commit_graph, pos);

Normally I would complain about referring directly to r->objects->commit_graph
without an explicit prepare_commit_graph() in the method. My initial thought
was that we would need to know that the new method prepares the graph, but
obviously the commit-graph needs to exist and be prepared if we are loading a
position from it.

All good here.

Thanks,
-Stolee

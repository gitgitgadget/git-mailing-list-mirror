Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CBE7C77B73
	for <git@archiver.kernel.org>; Thu, 20 Apr 2023 13:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbjDTNKz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Apr 2023 09:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbjDTNKy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2023 09:10:54 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0856E4215
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 06:10:51 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id a11so2168680ybm.3
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 06:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1681996250; x=1684588250;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tBT00L5fJkocqZuKjDnTVG/7moFNL3Uk4NWc9sN4G9o=;
        b=V1fudlPMLHKmqCS1QhRKXINWSTMhfIGa58xhOtusNKh4VUSz5R5KViodRFSuYeGz7k
         /LIdT2UDzIAPXsY/wiSvcE3zbkURP4yd3frcvQmeaWjUH3jZ7Twq04KpeSZIxNwRK+JG
         vHThdWQKDy8rZYcSUre8Hg8VOADsYQWsOoMCG3Fl1OblqGBRUSqTORKFoscM7oEE1akw
         bjFjbsp/ClhUogqvUxKxTCMg9Ce4ogiHHtbQwCEMjj4gXE8R3eUz/sKtR/3MXpC1GOhn
         vkuKHCNqTRZCIPeTlCurciXqBNOk1mFDADh98XOlFbGOcnMipWTiBa07j8Bjjohfx62u
         fJXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681996250; x=1684588250;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tBT00L5fJkocqZuKjDnTVG/7moFNL3Uk4NWc9sN4G9o=;
        b=lpRIG1jeyE/sHgry0XnFUNbl1SlRTogxvGYLW+silWHRfM0aiWUUWbVUht3NMgLSeL
         Kk0KU0Ihjcj97PMN0tCIl21OHuN7GyF6bjHasG2hxvngkT68qE4zQStpEEsnlP+qj238
         VKOXLh/ly3Am1mehIyy3OaCBH8No43xiQx6YeyG6tg0JuKAs/BT7ZYaYUhMW03RXXVSZ
         9SlE5BtkMxQWKaZZHnh5LjZGj73gWItaWQT9OBuVpvuSh+97oNXoz57vw+E3vHfZZNo7
         E3hn2v3Yl6f9E9XiasPoqSL2BzMatHkUBv6MdLtu+0+MEhvHXaaJqW4vxOT6+QpYbDyj
         zJRQ==
X-Gm-Message-State: AAQBX9fC/6DGogEazvNTi5spGCZXEKXYoPT3SjwlM1IZCWaeSxT6F8wS
        kF3dIXPLl4v2+FE9txVK4DoL
X-Google-Smtp-Source: AKy350Yf8grqIC/4ZNDy3BqGLcIE4bhl7rlQDIF17mabpRQqNUhIfv4H1Edy2nZhBEkT2jTj+wxRiw==
X-Received: by 2002:a25:d795:0:b0:b8e:e30f:11ee with SMTP id o143-20020a25d795000000b00b8ee30f11eemr1622046ybg.0.1681996250224;
        Thu, 20 Apr 2023 06:10:50 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:c9cd:9424:a6a5:5425? ([2600:1700:e72:80a0:c9cd:9424:a6a5:5425])
        by smtp.gmail.com with ESMTPSA id e131-20020a253789000000b00b7767ca7473sm299820yba.16.2023.04.20.06.10.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 06:10:49 -0700 (PDT)
Message-ID: <d5c93b5b-32b9-ec50-1661-06f73fa37f5f@github.com>
Date:   Thu, 20 Apr 2023 09:10:47 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] merge-ort: fix calling merge_finalize() with no
 intermediate merge
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
References: <pull.1518.git.1681974847078.gitgitgadget@gmail.com>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <pull.1518.git.1681974847078.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/20/2023 3:14 AM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>

> While at it, ensure the FREE_AND_NULL() in the function does something
> useful with the nulling aspect, namely sets result->priv to NULL rather
> than a mere temporary.

Good call. It also makes the code look better.
 
>  void merge_finalize(struct merge_options *opt,
>  		    struct merge_result *result)
>  {
> -	struct merge_options_internal *opti = result->priv;
> -
>  	if (opt->renormalize)
>  		git_attr_set_direction(GIT_ATTR_CHECKIN);
>  	assert(opt->priv == NULL);
>  
> -	clear_or_reinit_internal_opts(opti, 0);
> -	FREE_AND_NULL(opti);
> +	if (!result->priv)
> +		return;
> +	clear_or_reinit_internal_opts(result->priv, 0);
> +	FREE_AND_NULL(result->priv);

Perhaps this would be better as

	if (result->priv) {
		clear_or_reinit_internal_opts(result->priv, 0);
		FREE_AND_NULL(result->priv);
	}

to avoid an accidental addition of code to the end of this
method that doesn't depend on result->priv?

Thanks,
-Stolee

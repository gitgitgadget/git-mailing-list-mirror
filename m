Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62263C43334
	for <git@archiver.kernel.org>; Thu,  2 Jun 2022 13:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235118AbiFBNSU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jun 2022 09:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbiFBNST (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jun 2022 09:18:19 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 114BA1E2241
        for <git@vger.kernel.org>; Thu,  2 Jun 2022 06:18:18 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id y12so4756447ior.7
        for <git@vger.kernel.org>; Thu, 02 Jun 2022 06:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=PJJoHMTe9GlFPMrKhBsZftllvkQlvS8+STd0SlbLpFk=;
        b=LbK3k7mIp33ETBGJ++4Sy0ISC1FTUhUOQ6l7MQnau3zlYdL8rdB6wXPsgNi8wZg0oe
         P9mirM9q9Pe8PfwsfEO+qIPSM2btDwDeBoIodmRdmGmc+GXXrJHl0BqNdl4zKnIfjUE2
         UC81TbEryHumFB7J6r5f1BdwsGwF70d6UVUvmIWBsifMiQAHUVkkzMIQ5ipLLRV6HhZK
         mldJdDoc5V0D23cJBx29KfNtZ6T4M5LIKktPgOPP4PCLnrhuiesICSJ5qon/G358eGiu
         m3+AIhjftwSv/5s0zAGJ+b8VsStE9NTZTchOQWvkXdWeREQ3jhF0ps8wqFWI26f0NIwM
         IQ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PJJoHMTe9GlFPMrKhBsZftllvkQlvS8+STd0SlbLpFk=;
        b=OLkPMXIcP8tKsz7orwc1GVlj4u/SZhmv5BXPBoHkZs6ctioP8xba+t9c1AH7ciCDXj
         dpHHldMeq3d49BA5oM5OpOQfrCUnzQGP5Llm3cLuiUcDHEC0l2XzfJxAwopi9sEULKH9
         LsdlXMoO8jOjI0vYHmMohEokmxreJLQ0VyUvq0lttWO0FFCV8jEvE4/ZaM0HqkO8zXz5
         VQED68YzmBsOYCOhsZCjNlTNvqSs/1YVGNF7Am46BrH1xTOOfQiKV6zlfpUsQhgLIHvr
         BSVPNNTlzMHB6iyjEF1kUZC+FmZCK922QcRwUYXCx2V7ecWRJnP2HxsVNhVtvfhtLZI5
         P4/w==
X-Gm-Message-State: AOAM5326AppTsI644GIA4qt2s3nWIVtTMy/tfEvfCA3wPS9DnrIyqflr
        W1EjXUHwFBELuZpfjdWOS5QW+yS6oPNW
X-Google-Smtp-Source: ABdhPJwTnZyDszz9BUfCpfvaH17ZMzrRH4WL61GNelneeQMVi4wsPW6hNRa3CiPZ6IOH1d9QLX/O0A==
X-Received: by 2002:a05:6638:338f:b0:330:f1e9:c1cd with SMTP id h15-20020a056638338f00b00330f1e9c1cdmr2934003jav.260.1654175897487;
        Thu, 02 Jun 2022 06:18:17 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:9cc9:fda3:3ddf:6700? ([2600:1700:e72:80a0:9cc9:fda3:3ddf:6700])
        by smtp.gmail.com with ESMTPSA id s8-20020a92ae08000000b002d149ec2606sm1353526ilh.65.2022.06.02.06.18.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 06:18:17 -0700 (PDT)
Message-ID: <3873f70e-0dd6-e469-5d0e-0f6847136f0a@github.com>
Date:   Thu, 2 Jun 2022 09:18:16 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 5/5] upload-pack: make uploadpack.packObjectsHook
 protected
Content-Language: en-US
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>
References: <pull.1261.v2.git.git.1652485058.gitgitgadget@gmail.com>
 <pull.1261.v3.git.git.1653685761.gitgitgadget@gmail.com>
 <e25d5907cd1e3894f19ffbfb3310175fd660563b.1653685761.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <e25d5907cd1e3894f19ffbfb3310175fd660563b.1653685761.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/27/2022 5:09 PM, Glen Choo via GitGitGadget wrote:
> From: Glen Choo <chooglen@google.com>
> 
> Now that protected config includes "-c", "uploadpack.packObjectsHook"
> behaves identically to a 'Protected config only' variable. Refactor it
> to use git_protected_config() and mark it 'Protected config only'.

I'm really glad to see this simplification at the end of your series.

> @@ -1321,18 +1321,21 @@ static int upload_pack_config(const char *var, const char *value, void *cb_data)
>  		data->advertise_sid = git_config_bool(var, value);
>  	}
>  
> -	if (current_config_scope() != CONFIG_SCOPE_LOCAL &&
> -	    current_config_scope() != CONFIG_SCOPE_WORKTREE) {
> -		if (!strcmp("uploadpack.packobjectshook", var))
> -			return git_config_string(&data->pack_objects_hook, var, value);
> -	}
> -

...

> +static int upload_pack_protected_config(const char *var, const char *value, void *cb_data)
> +{
> +	struct upload_pack_data *data = cb_data;
> +
> +	if (!strcmp("uploadpack.packobjectshook", var))
> +		return git_config_string(&data->pack_objects_hook, var, value);
> +	return 0;
> +}
> +

This is much cleaner.

> @@ -1342,6 +1345,7 @@ void upload_pack(const int advertise_refs, const int stateless_rpc,
>  	upload_pack_data_init(&data);
>  
>  	git_config(upload_pack_config, &data);
> +	git_protected_config(upload_pack_protected_config, &data);
>  
>  	data.stateless_rpc = stateless_rpc;
>  	data.timeout = timeout;
> @@ -1697,6 +1701,7 @@ int upload_pack_v2(struct repository *r, struct packet_reader *request)
>  	data.use_sideband = LARGE_PACKET_MAX;
>  
>  	git_config(upload_pack_config, &data);
> +	git_protected_config(upload_pack_protected_config, &data);

It's unfortunate that there are two places that need this change.
Is it worth adding a static helper that executes these?

static void get_upload_pack_config(void *data)
{
	git_config(upload_pack_config, data);
	git_protected_config(upload_pack_protected_config, data);
}

Thanks,
-Stolee

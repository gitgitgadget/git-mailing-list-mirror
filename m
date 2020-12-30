Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED49C433DB
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 14:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A7DF221F8
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 14:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgL3OG6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Dec 2020 09:06:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbgL3OG6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Dec 2020 09:06:58 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9880C061799
        for <git@vger.kernel.org>; Wed, 30 Dec 2020 06:06:17 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id d14so13880222qkc.13
        for <git@vger.kernel.org>; Wed, 30 Dec 2020 06:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wErS+qAW9rHxpEYfHvek5ZP9QOOyAfdZgXz4LmBF0eI=;
        b=dnnra3SJJG5RAnNN8V+Wd7YJP4RuJUdl+CoJFBlaEPyicHSvWpZ6UGjT9DmZTJrq0O
         bf0UX34ARANmzMI6rb5KtP5/VWI2EZf8v88edtZpiBd79VFbQvLdbh5vg2YfewSWmrDK
         YCSWNQ25x+ufZSvpMywLpIceB5EGqvG2TgU+pdYfK4QZ6V4aiH3l56xwf3U26K9NxGLZ
         9dgeMpBE+VyZl4pzxfFsvIohPA+I3yX9R4a9bEH7e+O5cqFTpQWluRXJ8DIorzPV6lNh
         wcgmnOmF6ZOcxbiqEVcKb9ipRTCCouVOGKsaHdjUXSTQOBTAl8cIFuJbIvnowU2aYrAB
         EKPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wErS+qAW9rHxpEYfHvek5ZP9QOOyAfdZgXz4LmBF0eI=;
        b=jNfO2fTgsX6rMstxR6T5sKw7XB/VpBKu5AimxqN3QngD7eqGBPuadMIiCcpquSFmcX
         8UJNJfag/UQ1k7ID3qRG6nBO/V8IQQfFR8KLqi8WHW73E5pPwiycof/RhsXxIFWn0IrS
         tzPiXfs2lGt+ITlAexHnKEkxAGCYZvNHfqyqVp+uUW3EM7DuxVrWtoBQOQxGDxUvPK/E
         jd/ACYJ7x418vk3BYNnIOFkw711ZJX3qnpDzykTzsRlLdN+oUoIas4s6wNlyUhA6SS8a
         OreNKz5F7HGPqzhmyofWUwSMouZpXpUufYj4acvdxaH/xorLi3lJc4J2ZM+3436nCWa8
         bqIA==
X-Gm-Message-State: AOAM530LAeyrPlAxl+Ni7zunSoZji7NpwF0CiFrXLB/mRRCe/uBVTiAl
        KrljDRk0xJgaoaJdkQp301E=
X-Google-Smtp-Source: ABdhPJzpAn+qNBxDIYoIzMUM+ByPVYoXLzsH6xnhTQspvS3lvxkHPIVbiB1IXQ2RuhG4iyHsKtbG2A==
X-Received: by 2002:a05:620a:13c2:: with SMTP id g2mr52134317qkl.174.1609337176772;
        Wed, 30 Dec 2020 06:06:16 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id r1sm26642792qta.32.2020.12.30.06.06.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Dec 2020 06:06:15 -0800 (PST)
Subject: Re: [PATCH 01/10] merge-ort: handle D/F conflict where directory
 disappears due to merge
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
References: <pull.815.git.1608270687.gitgitgadget@gmail.com>
 <382a009c18efc8a46a9c0210754f2266c3116ee4.1608270687.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <cb08fd8a-b4e1-77d6-7d8d-9f0431db2404@gmail.com>
Date:   Wed, 30 Dec 2020 09:06:15 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <382a009c18efc8a46a9c0210754f2266c3116ee4.1608270687.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/18/2020 12:51 AM, Elijah Newren via GitGitGadget wrote:
> +	} else if (ci->df_conflict && ci->merged.result.mode != 0) {
>  		die("Not yet implemented.");
>  	}
>  
>  	/*
>  	 * NOTE: Below there is a long switch-like if-elseif-elseif... block
>  	 *       which the code goes through even for the df_conflict cases
> -	 *       above.  Well, it will once we don't die-not-implemented above.
> +	 *       above.
>  	 */

This comment change might be a bit premature.

Thanks,
-Stolee


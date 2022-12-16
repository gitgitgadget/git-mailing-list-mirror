Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5781C4332F
	for <git@archiver.kernel.org>; Fri, 16 Dec 2022 13:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbiLPNlL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Dec 2022 08:41:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiLPNlJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2022 08:41:09 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A08C773
        for <git@vger.kernel.org>; Fri, 16 Dec 2022 05:41:05 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id i20so2640079qtw.9
        for <git@vger.kernel.org>; Fri, 16 Dec 2022 05:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sw/u+B9a9Vurbzav0hKGEZwi5t8VQsIhfobGz1sv3r0=;
        b=C1ax5fZLPidpJxR+1llCCN6g9eYkvhVlRmVIwcUjDGd+Y2lPGMrwLjsNFMjByHzLBY
         dZrD1icSuNHeaVBVPZH3u/HOrM4leLP1giUMWBacTbP8RGCsQfwgdv5MSty9A94sF+Id
         eyKzI3CeP5BMvhHwXaUskf2JoNheMTRhhM/HuC80clqH3cDBwXvTOT1bwJvZWjpKXefR
         8HiTkSINmjmX1GHuVIcbf1e7beY65QERTuHhp+WJphD1GxLaZsGg9Kskc/+7iZPQIg6Q
         iIO5UoyLX2UjViJEMATSluMQYwQZd3sRp/dm9C+YWN29gXSk4v3CB04SnJGdfwG485dZ
         Uzug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sw/u+B9a9Vurbzav0hKGEZwi5t8VQsIhfobGz1sv3r0=;
        b=PiRZPEz7893xQM8tamlXK3rGkPPI3Z3YRCxMmkcpx9+V4+WZU2HvIeZqGZ7WmgXmok
         ncNFx1yq+aXJ4JFUicEgfvyRXWzTqltReVpA7jGEuEx6XrspOSQjON9N/gPhM58cz9bJ
         InjtWJHDWluOSdoZIVKDeTHxbXnKlkoRz5Ka+p3u/5W7HgJg/ri39dhqA3K6dQ+G0iCK
         V3+/cy/RHT8e6JoEB0h5PxbCYBlB4/1iSjWIuCU2HKkL6JdKzraAqZ6+w7kF9qY9a3/j
         ldFgX9nt23b3IDzD5O12lZOcDYgHJ0gGJ9siE5O0TDJF5qC0Z1rG5WpMQPIq4srRBcVO
         4JSw==
X-Gm-Message-State: AFqh2kqCIpWTf6VdOR6+3O0EAlRCyE7DZJn44BZj0DXotGxLo1hynkND
        nnxf1aMyGXbp400FcpaS40HZ
X-Google-Smtp-Source: AMrXdXtJKG2XHfa1I2tdKm2dL2VXitn0K81hJwmXMYo8Ep8qegLT7KGLdqwcuTuu3sMhcqgWiCPztw==
X-Received: by 2002:a05:622a:20b:b0:39c:da20:602 with SMTP id b11-20020a05622a020b00b0039cda200602mr4876476qtx.12.1671198064943;
        Fri, 16 Dec 2022 05:41:04 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:19d1:77f6:ebd4:cf69? ([2600:1700:e72:80a0:19d1:77f6:ebd4:cf69])
        by smtp.gmail.com with ESMTPSA id f8-20020a05620a280800b006fc7c5d456asm1413323qkp.136.2022.12.16.05.41.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 05:41:04 -0800 (PST)
Message-ID: <9e754af8-ecd3-6aed-60e8-2fc09a6a8759@github.com>
Date:   Fri, 16 Dec 2022 08:41:03 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH v3 0/4] Optionally skip hashing index on write
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, vdye@github.com,
        newren@gmail.com, Jacob Keller <jacob.keller@gmail.com>
References: <pull.1439.v2.git.1670862677.gitgitgadget@gmail.com>
 <pull.1439.v3.git.1671116820.gitgitgadget@gmail.com>
 <221215.865yec3b1j.gmgdl@evledraar.gmail.com>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <221215.865yec3b1j.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/15/22 10:56 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Thu, Dec 15 2022, Derrick Stolee via GitGitGadget wrote:
> 
>> Updates since v2
>> ================
>>
>>  * Patch 2 now has additional details about why to use the config option in
>>    its message. The discussion about why the index is special is included in
>>    the commit message.


> So even if we can't produce a behavior difference, just doing e.g.:
> 
> 	struct repository *r = istate->repo ? istate->repo : the_repository;
> 
> And then using:
> 
> 	prepare_repo_settings(r);
>         f->skip_hash = r->->settings.index_skip_hash;

This, and other comments are sensible and will be reflected in v4.
 
> Seems sensible. I just don't get why 4/4 has that seeming fix-up of 2/4
> after-the-fact. Isn't it better to carve that bit out of 4/4, just do
> the config setup in repo-settings.c to begin with, and have 4/4 do what
> its $subject says, i.e. to have "feature.manyFiles" imply this new
> config?

The point is to make patch 4 completely independent, and be able to
pull it out if necessary. There's no reason to load the config inside
repo-settings.c unless it's part of something like feature.manyFiles.

Thanks,
-Stolee

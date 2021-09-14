Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17ECDC433EF
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 03:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5EBF610A2
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 03:55:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239225AbhIND4i (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 23:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238979AbhIND4g (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 23:56:36 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5081EC061574
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 20:55:20 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id u13-20020a17090abb0db0290177e1d9b3f7so1098474pjr.1
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 20:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9weRbFXdwMRt+2P2IvMh1EE0wskY0fyhGCXwnjh/KBk=;
        b=aw8QKXCVNG6YYb13W6uU9Zu2gAYE/v+i6f9Tl9bIkL89Hco3jshI6sNOz8dQ2mX8JT
         nM9rv+hAURPRgf8zMt/wx3GrIadI9lreGyv3X68Cf2CRMw5b3hd2Dp/x0HPRK4BIH8HE
         GEiB2KAe8lNoDrv0VjxizxgOI9aeoGChiyHdUYUM2jt3fegmDqa2+/HDCruThFIYut+7
         p+EvOY8lPDMkUe+4Iu+NWSK5RwZzOtbbHsolo8G5i6Y18yzLuDo53lUVtzgJIm3m40lR
         DdjPuxrG9vyb35DUwzgKiltaC0EjUYVVkW2nM/jZT1GD3Zcp168hrM93scSJFGHtHyLc
         DZtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9weRbFXdwMRt+2P2IvMh1EE0wskY0fyhGCXwnjh/KBk=;
        b=pyeRmpqGYPqGBumDYz7nHC888jZLbicP1LM0pEvuXBtquK/I/OOHAnjF8EB3ABu6Px
         2GeC9KA1H3k8wAhNMmx2pJZsoejliEsjcvYZ4CRIB7W4HqB/af4vZ6qflf3bALwxaS3L
         efuJbyA1TwZipwz/09pqTPdq6F8DxKQ/hbbCWRNYQHr9+N/J//bfYEb/lmVQCNGvqE+R
         TFXh/fvZ9Klvg4etZHeqcWBWmArbliV51d0lfn5Dpu0W2nNQ8GSK30gn6z6Bh2WfUzm1
         KT+Fm8OC9FWjCKhG3qnc3XeKtzBAF8hLVlY0NH/xF55ah7v2xkrw1tV9w9TaQdnj21m6
         XM3w==
X-Gm-Message-State: AOAM530+cAFLa0qXH51qe60woJQ+gunCsey6lXzmaGLsUJdzyUW2bbjy
        AzJxXqbA6fEYSe8roHr0RabPPkjzMMoG/w==
X-Google-Smtp-Source: ABdhPJxJqyJwfe4iv5c7Omb7weLHocqqO1mDwJ7rzinr1fiXlkCy8Fdh4DZ9LvmsmGVD+16zMOvTzA==
X-Received: by 2002:a17:90b:f97:: with SMTP id ft23mr3115868pjb.135.1631591719747;
        Mon, 13 Sep 2021 20:55:19 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-43.three.co.id. [116.206.12.43])
        by smtp.gmail.com with ESMTPSA id u8sm8046774pfk.212.2021.09.13.20.55.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Sep 2021 20:55:19 -0700 (PDT)
Subject: Re: [PATCH] MyFirstContribution: Document --range-diff option when
 writing v2
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Glen Choo <chooglen@google.com>, Git List <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>
References: <20210913194816.51182-1-chooglen@google.com>
 <02e15e8d-6923-9f21-8eeb-592eb0c9588b@gmail.com>
 <CAPig+cSHSSuE6ovPN+XVRDhNU8WD+XzuH0gLzupNZiN1QLGz9A@mail.gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <9551fbe4-255b-774b-d00d-40f5330f70c9@gmail.com>
Date:   Tue, 14 Sep 2021 10:55:16 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cSHSSuE6ovPN+XVRDhNU8WD+XzuH0gLzupNZiN1QLGz9A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14/09/21 10.46, Eric Sunshine wrote:
> Not so. Anyone who does any serious amount of review on this project
> finds it tremendously helpful to have both a prose description of the
> changes ("Changes since v1..." plus a link to the previous submission)
> and a mechanical range-diff or interdiff. A range-diff (or interdiff)
> is especially important to provide reviewers with context which they
> might have forgotten since the previous version of a patch series was
> posted, which can matter since it's so easy to forget specifics even
> about one's own review if enough time has passed or if reviewing a
> large number of unrelated submissions. A range-diff or interdiff also
> helps a reviewer determine at-a-glance whether or not earlier review
> comments have been addressed without having to laboriously re-read
> each and every patch.
> 

So will range-diff be mandatory or optional?

-- 
An old man doll... just what I always wanted! - Clara

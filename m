Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51513C61DA4
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 13:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234496AbjBWNwz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 08:52:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234474AbjBWNwx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 08:52:53 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E4C270F
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 05:52:49 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id b6so4568792qtb.1
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 05:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9+pDYIG+tpxzjL3hn571/RmQvLs7yGeN0CT/8V9UBNs=;
        b=cnqBl417Lj1pLukix+tIrQ0ItLTU6jPLNo5n4MVso+TKjp29eVdtu/FTWr1z0jR9oJ
         AeWEWTqvJBeVvUVTp4XdwfrjCmtlGZxvem8JIwREY26Fh0tMZbXkBNRrECD9o/JFJymO
         J3NPWLBHLjwguiobl9BLlbrQUJpqQUfMJeeaai7gy4cRLirNZMkb9pOHSsQwHYUz2ArM
         Il+0YVnt15ydeP7lj7ClBo+aQfoCLowFjFE9MzNkhyWZea6/BljZbIG9fWIDGH1Fvciu
         X+h0QWfCvaTmSer8R5OGz++D75OTN4p8Yx9hWLr92uDhLRVGmxmhBjFLDTuLen/k7byh
         02cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9+pDYIG+tpxzjL3hn571/RmQvLs7yGeN0CT/8V9UBNs=;
        b=NAbfFhEZvqM7Jj1NwczZ0Ja54zx7JisbMLox+KgkzaEp25WzrXrZxSEtWbTPQ+CSXm
         DbJGVP9/k87DucNQ1sbhSwBo0usVLZHsTskWO+0baaNYJ5DrASH1sV4iGeKLq4NWhDaO
         FysSFaSATFEYUcf7nW1mJARI1a/uede9xPwlX+QkKSoJNArZ3JFwJipnn96n66va6r/m
         FZHf8CSBVV++Kf8tkQQmczGkWoGS0zcjq2MDLR17grV9numRJF744XKIRhsR4frtgfGG
         nG2MM25/gLIdy+IlUk3NuG10D5q03zujDDWdLE2LZjjznRQuAL516Tq22W+lI+/t8G/z
         6xjg==
X-Gm-Message-State: AO0yUKXzXZjThUTNzsR4EzONxGopEa7+7mi6uM1bR5KX6R4e7bBKt+l8
        kID1MOO3tzJ0MU5Gaf4m1t1y
X-Google-Smtp-Source: AK7set/zjc188OIl2L0njf3+ySTc4JO1QFeeBQJXf/KowLVLx6CyjyMxQO1lBoW6wh2VxNzl8jP8xg==
X-Received: by 2002:ac8:7d03:0:b0:3b8:6cb3:e54a with SMTP id g3-20020ac87d03000000b003b86cb3e54amr10518708qtb.5.1677160368183;
        Thu, 23 Feb 2023 05:52:48 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:e099:82d3:1307:6825? ([2600:1700:e72:80a0:e099:82d3:1307:6825])
        by smtp.gmail.com with ESMTPSA id 1-20020a370b01000000b006fcb77f3bd6sm4169799qkl.98.2023.02.23.05.52.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 05:52:47 -0800 (PST)
Message-ID: <14c2e90d-e68b-d0ad-f8d4-1842663b33c9@github.com>
Date:   Thu, 23 Feb 2023 08:52:46 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 02/16] treewide: remove unnecessary git-compat-util.h
 includes in headers
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Emily Shaffer <nasamuffin@google.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.1485.git.1677139521.gitgitgadget@gmail.com>
 <adafa655432dd13d1c727522377ac9a4b515b76a.1677139521.git.gitgitgadget@gmail.com>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <adafa655432dd13d1c727522377ac9a4b515b76a.1677139521.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/23/2023 3:05 AM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> Since git-compat-util.h needs to be included first in C files, having it
> appear in header files is unnecessary.  More importantly, having it
> included in header files seems to lead to folks leaving it out of C
> files, which makes it harder to verify that the rule is being followed.
> Remove it from header files, other than the ones that have been approved
> as alternate first includes.
...
>  compat/fsmonitor/fsm-ipc-win32.c       | 1 +
>  compat/fsmonitor/fsm-settings-darwin.c | 1 +

It looks like you have a couple .c files here that belong in the
previous patch.

Thanks,
-Stolee

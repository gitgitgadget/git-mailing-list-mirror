Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CACC4332F
	for <git@archiver.kernel.org>; Thu, 15 Dec 2022 15:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbiLOPOq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 10:14:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbiLOPOV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 10:14:21 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFA72ED51
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 07:14:01 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-3b10392c064so46107257b3.0
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 07:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kZ2o8r2UwTUWO6G30wqQYfGwPT6eV4bbKfvB380jhyM=;
        b=J+n62+QhNyR60XgdReQrCAbMUmoDjXm7XFzgfKC4SEUwJsK0E2gTv3xVYil0iNPjPo
         /nQasejq3Hy3ePyvKmue4Gp136M1Wp3+IoCPUeFROaJ8YoOHmQAaXXayiqbBtRGa4Eg+
         nlMXKRmLqWHjtHYJxiYzs4YJ0x6WqWhuAYQJ1WUQvG7cZSfBjIXNAKLkSqirNI/pfrUr
         ED87LR8MpmCoZsIHaKegGIvMKTvYQ4jhrBJ9x5a962zbDlCNCO6TEjfoCFmkJakMSw7z
         K6oPyHaD+MTyhrHUalF0mdihRizquKsVeO2+9PRPmsIpi9y/tlLIps9KKGLgYN43NlPf
         M7hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kZ2o8r2UwTUWO6G30wqQYfGwPT6eV4bbKfvB380jhyM=;
        b=d6ab2L86t4w0I8qEoeh6HQ+cD6zSVk1oWP4oCAYrZkHzFF2uugfTK5cwRGUH0fzQ6n
         13rH9ETc5JltjBq0nGuTJu73/xm1N9YpzlybwQlDMQm6z094YhaVbv1uqdmx9gLK0XIF
         LYQdg3VRHajDVHFmR9eh0nmHnV7L0hIGiQ+AifcTqsCxekvyXSYdrgwltfkCrYeuH8PV
         P2iRDW5GfJapL/wJ+VEw9h8HUBaTXbuJ9J8IG4n1tu/xNGwIHn3AtbdhsZtTobi6hyk+
         /LsF7/olHOyPQUGBSUi6wI7KMekLIfKTNw/QYHrQoa2uWgjTkHt53Hbju/zP2yxKDYqZ
         LD/w==
X-Gm-Message-State: ANoB5pkKLReKFV6Udt2rFCmvSeE9xHPh18XjujwSYG0gSp0Rb2XiRl7t
        H4hmeXJQFb5kaen+qjQuWr33
X-Google-Smtp-Source: AA0mqf4qPvCNYNiIhyc4C3rgigJcyMXUXQGBIF6FiZil/BgvSS3YBU6ftPgYHNyMVmLx6PJetCVSZw==
X-Received: by 2002:a05:7500:79f:b0:eb:900:b86b with SMTP id cx31-20020a057500079f00b000eb0900b86bmr3552927gab.56.1671117240930;
        Thu, 15 Dec 2022 07:14:00 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:7005:c0ef:d043:4397? ([2600:1700:e72:80a0:7005:c0ef:d043:4397])
        by smtp.gmail.com with ESMTPSA id s5-20020a05620a254500b006ec62032d3dsm12330977qko.30.2022.12.15.07.14.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 07:14:00 -0800 (PST)
Message-ID: <112d189c-f2f9-8e12-fe13-82e41316c41b@github.com>
Date:   Thu, 15 Dec 2022 10:13:59 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH] commit: skip already cleared parents in
 clear_commit_marks_1()
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <7cf2ea1f-8dbf-5639-3874-86de391ae20a@web.de>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <7cf2ea1f-8dbf-5639-3874-86de391ae20a@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/13/22 1:27 AM, René Scharfe wrote:
> Don't put clean parents on the pending list, as they and their ancestors
> don't need any treatment and would be skipped later anyway.  This saves
> the allocation and release of a commit list item in ca. 20% of the cases
> during a run of the test suite.

> -		while ((parents = parents->next))
> -			commit_list_insert(parents->item, plist);
> +		while ((parents = parents->next)) {
> +			if (parents->item->object.flags & mark)
> +				commit_list_insert(parents->item, plist);
> +		}

From this context, it looks like this is a change of behavior (the
walk only continues to parents that have the flag, so if the flag
is not closed under reachability, such as the UNINTERESTING flag,
then we won't clear all flags) but above this we already skip a
commit that doesn't have the flag enabled.

One thing that is odd about this method is that it sets the
'commit' value to the first parent, and adds the later parents
to the list. It's a minor point, but that check for the flag
on the 'commit' is what prevents us from walking too far along
the first-parent history.

All this to say, this is a safe change with a nice upside.

Thanks,
-Stolee

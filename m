Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B70BC433E0
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 13:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B1112220B
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 13:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgL3NgY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Dec 2020 08:36:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbgL3NgY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Dec 2020 08:36:24 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45FD2C06179B
        for <git@vger.kernel.org>; Wed, 30 Dec 2020 05:35:12 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id c14so10929776qtn.0
        for <git@vger.kernel.org>; Wed, 30 Dec 2020 05:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fCYsFngI7GIGOAeTmBxr0ya5dVk+ZxGRz7jJBo+Jx30=;
        b=b7XR2kIBXdw5jFoZ0xzug70i7DCJ3012n7wfRcYmTTkdA6aTehWKGIzWi6YE7FJek4
         U8hQNSgPU4OFVO4DSp9ZQU1OTOKPEl3VpmTRpcn/4hEk/BlubpYFrghxlDoZRceOtG4B
         jYzj9WNhNFHENHWHJbQGAuHiFunxXUj0wy+NbanQC7oeJ5aihWN46/JGcAUQUpaU0vaM
         ox2eTnf550HXSPNtuYO0xqsFLr2osfkctmyAVjxsgJRzkuR5GH+nvwT6uZ2fOoM3sFna
         t+TamGhciZbYvRItCbQVmu+uJeE6QiC5nA0ZeMHbdLj7ZhOKCwunZuh/UDWFi+9GWS7N
         PooA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fCYsFngI7GIGOAeTmBxr0ya5dVk+ZxGRz7jJBo+Jx30=;
        b=TJG/JMs5RQf8ZBMwK9I4SDf4HLfAKRCX5kia8yB/WejSleLgpHPPQ/lVRlPo5rcvez
         GgsN9rrnnIxJ96y13ZvT6I43AMeb8r/Talo3WAP5Cx9W/9mXQik400b162nOa53DKwRt
         2GWk54U3rF6CGa6GjYTi52LX1jYRToS3AvTrwfrWHmWm1lQt4k3ZRRR1x6vD7i1AL5fd
         RXYaCnEsoB4ZbQpz18zbV+HCcPIuFiGW/3eCrU77lLK7Fj/fYa/Ykc7IOy7GJRg+4JXy
         ndDKYHdbAKMQDkbPtyaeTu44qxOMTEqLq4KALa58ZgaccdOdhR84nTXCUgtBTF5wXOeF
         M9OQ==
X-Gm-Message-State: AOAM531qbBF41e7xbj05jv0VkSfkBqnTHSIsfTwzPVLew6oRlEHgqhwc
        O+J+5b655Vo4NUz4xG2tp6cGd1uiWqt/DA==
X-Google-Smtp-Source: ABdhPJyt79f5lFaBJKVVUtM+5Ca31qXUbaDd3GlLJCvyT2ssXODCO33c6R/9tfx6w0WpvrOhqZsl6w==
X-Received: by 2002:ac8:7b9d:: with SMTP id p29mr51961330qtu.75.1609335311417;
        Wed, 30 Dec 2020 05:35:11 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id d25sm27674309qkl.97.2020.12.30.05.35.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Dec 2020 05:35:10 -0800 (PST)
Subject: Re: [PATCH 0/4] rename "sha1-foo" files
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
References: <cover.1609282997.git.martin.agren@gmail.com>
 <4d1f5c59-db2c-3c88-f3ca-1edcdfb2f99e@gmail.com>
 <CAN0heSq2ttahii+tUJo92L0ERcbYuS-Z51OhMsQsd-a51SWPKQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <cb9ef187-5b61-431d-f540-4adc1bc8ad9b@gmail.com>
Date:   Wed, 30 Dec 2020 08:35:10 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <CAN0heSq2ttahii+tUJo92L0ERcbYuS-Z51OhMsQsd-a51SWPKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/30/2020 3:01 AM, Martin Ågren wrote:
> On Wed, 30 Dec 2020 at 02:29, Derrick Stolee <stolee@gmail.com> wrote:
>> Oh, and I remembered the one semi-legitimate case to try for exact
>> renames whenever possible: "git log --follow" will download fewer
>> blobs in a blobless partial clone (--filter=blob:none). Of course,
>> this only works if the rule is always followed and is not really a
>> justification for doubling the number of your patches.
> 
> Ok, I see. Well, if you and/or others feel we should aim for a 100%
> rename, I don't mind splitting the patches. My gut reaction is along
> your "only works if the rule is always followed", plus I wonder if there
> are actually Git developers using a blobless partial clone of git.git
> [other than for testing blobless partial clones].

The upside is so small, it is not worth re-rolling your series. I was
just thinking out loud to justify my first gut reaction. Even in
blobless clones, this is not a huge cost (as long as we didn't also
add or remove enormous blobs). This behavior of "filling in the gaps"
is expected we use the repository.

Thanks,
-Stolee

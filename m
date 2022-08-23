Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB88C32774
	for <git@archiver.kernel.org>; Tue, 23 Aug 2022 17:07:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343906AbiHWRHf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Aug 2022 13:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345056AbiHWRGU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2022 13:06:20 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04684A6C70
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 07:05:16 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id y19so4442909ilq.9
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 07:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=rrCs0ZPCF8/d3NdzgIK34bO0uJS+4zC5l6v78AF/gA0=;
        b=g5ffrVOesiz3Xv98Bbcwpau3yDSooF3LjG1ylD/rSGRupx1D0eW+QuF4R6ENQ5ybPg
         3gIC9U9FKoX6feIBVLuFuI5MOnUbb3bfkPLBZOhfjCA6mspFt8LlIsKtg5qOReohvGY4
         tjGHj37/ewRfMptVBTqTsGAf0nQpzyNq1ayVGoRGv2ZDWhQO+A4WvyVwTn38TczwlMx6
         lIUbRbHJweeZ+uLZ3QrwrE3rZRYv1tlHTzeqwzTB2sKjkJPZX0ModqT4+78G2mK9Ot4p
         EPDK4IzzDFPJywsihhL90p+D0vbIhsdi3sE1yKowEEPlFYvBQRuWqbnapMrlAUnKvc70
         MWQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=rrCs0ZPCF8/d3NdzgIK34bO0uJS+4zC5l6v78AF/gA0=;
        b=3aeABrRsfhTjBrjfKIdO3HAJvVr+KmD+jZYrADEGw9NDbQzI38GZis+L7H8cs7TJrz
         wrZeCNMwLmJseaotYwR7BhsVn60hcYzbBzegB6ZTF7WVhoHJHz+Opu2P5cqjbCmVoSRJ
         SP/quEDEv6nZsbrN8MQJASkvcQzh/Sb/5H89Fm89pkXsh64s8X4tqYAPhKkIWv+yyf91
         PK12bVl3ivmns+evgoCtSVxco6p2ZMmciTc3zeJhUEgkBts7wpzO+51g5NZUDCJge9h0
         TSj65TqKzXorgE/46N0F2tW6jaPe2Pk32l8TnGn2e2ExLgr369J8pfUXYd8JnFxWwIMy
         LBaQ==
X-Gm-Message-State: ACgBeo0ir+8LZ5NrL7b+CpRzsXkqRM3jWRHDkjzKWuEGNWGjyvi+YOz/
        blKKjX+7IFzY+5Ml0G55kvGy
X-Google-Smtp-Source: AA6agR6y1wEltFcP2i/bkmH3DyUkYpePygvJf5BP1m57WZBTmX0fxuetZOByLkptAuSqmTLdP7p7xQ==
X-Received: by 2002:a05:6e02:158a:b0:2d3:f1c0:6b68 with SMTP id m10-20020a056e02158a00b002d3f1c06b68mr12852231ilu.38.1661263516222;
        Tue, 23 Aug 2022 07:05:16 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:1d99:34da:b008:42fd? ([2600:1700:e72:80a0:1d99:34da:b008:42fd])
        by smtp.gmail.com with ESMTPSA id g2-20020a05660203c200b006788259b526sm7128393iov.41.2022.08.23.07.05.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 07:05:15 -0700 (PDT)
Message-ID: <5229519b-3af2-a023-8996-43343b130722@github.com>
Date:   Tue, 23 Aug 2022 10:05:13 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 3/5] clone: add --bundle-uri option
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, dyroneteng@gmail.com, Johannes.Schindelin@gmx.de,
        szeder.dev@gmail.com, mjcheetham@outlook.com, steadmon@google.com
References: <pull.1300.v2.git.1659443384.gitgitgadget@gmail.com>
 <pull.1300.v3.git.1660050703.gitgitgadget@gmail.com>
 <00debaf6e77852efe1dcad4bfda5ebd5bf590ac4.1660050704.git.gitgitgadget@gmail.com>
 <xmqq8rngas5q.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqq8rngas5q.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/22/2022 5:24 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> +	/*
>> +	 * Before fetching from the remote, download and install bundle
>> +	 * data from the --bundle-uri option.
>> +	 */
>> +	if (bundle_uri) {
>> +		/* At this point, we need the_repository to match the cloned repo. */
>> +		repo_init(the_repository, git_dir, work_tree);
>> +		if (fetch_bundle_uri(the_repository, bundle_uri))
>> +			warning(_("failed to fetch objects from bundle URI '%s'"),
>> +				bundle_uri);
>> +	}
> 
> I do not offhand know why I suddenly started seeing the issue for
> this relatively old commit I have had in my tree for at least 10
> days, but I am getting this
> 
> builtin/clone.c: In function 'cmd_clone':
> builtin/clone.c:1248:17: error: ignoring return value of 'repo_init' declared with attribute 'warn_unused_result' [-Werror=unused-result]
>  1248 |                 repo_init(the_repository, git_dir, work_tree);
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> 
> with the commit merged in 'seen'.

Thank you for pointing this out. Here is a patch that fixes
the issue from this patch:

--- >8 ---

From 6df8bc6d7ffdc1b115d85ef9550bab5dcf1811f8 Mon Sep 17 00:00:00 2001
From: Derrick Stolee <derrickstolee@github.com>
Date: Tue, 23 Aug 2022 09:53:47 -0400
Subject: [PATCH] clone: warn on failure to repo_init()

The --bundle-uri option was added in 55568919616 (clone: add
--bundle-uri option, 2022-08-09), but this also introduced a call to
repo_init() whose return value was ignored. Fix that ignored value by
warning that the bundle URI process could not continue if it failed.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/clone.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 4463789680b..e21d42dfee5 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1245,8 +1245,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	 */
 	if (bundle_uri) {
 		/* At this point, we need the_repository to match the cloned repo. */
-		repo_init(the_repository, git_dir, work_tree);
-		if (fetch_bundle_uri(the_repository, bundle_uri))
+		if (repo_init(the_repository, git_dir, work_tree))
+			warning(_("failed to initialize the repo, skipping bundle URI"));
+		else if (fetch_bundle_uri(the_repository, bundle_uri))
 			warning(_("failed to fetch objects from bundle URI '%s'"),
 				bundle_uri);
 	}
-- 
2.37.1.vfs.0.0.rebase



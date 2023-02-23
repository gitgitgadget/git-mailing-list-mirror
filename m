Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90094C64ED6
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 14:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234841AbjBWOR6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 09:17:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233947AbjBWORj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 09:17:39 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BBDA58B67
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 06:17:14 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id r23-20020a05683001d700b00690eb18529fso2457820ota.1
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 06:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b96ETI54n+cW9lVvTPH3ErmxJqUP+fQjjnHWtKZfzKA=;
        b=jOwCX7tSvj07SzD2Mk4WtOiP+hYLsnuN7DdGEeRi7PkJb6TRvoq8/Vg+l2V/U6tIM2
         M0nFurM/1Hw4cKK3uDOpYaVykbfayBRti/+9XrA77tQIPwzMlrMGpANctHT2qd+PlJdZ
         N4IfP+lTmDYv21hiamG/FCIC3q1VsbVcrBqECfn6jD2fX8Ja1aeOwR9F3rlkRObBlGJc
         5nf3ViDLtevCyisP3cSXd85gWA0sp9p92ACGuR8+DQOT79mlnX5WucVOFaduA7qjUKPY
         wodybkLt3t7rds4sjYVz5a0cByLN5YdhYg8JjdoHfOYwbbBcSqUBLvEHVAv1kDiqKkvM
         51KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b96ETI54n+cW9lVvTPH3ErmxJqUP+fQjjnHWtKZfzKA=;
        b=muxlTOXN8hyYLtgl1xH2qLc7voQnRMPojhUmj9KheqNzr0e4JbzpfLh5dIIs+Q/S7t
         Zuu0+F2y5WjVQonoRNRcrl3RotaxTQOf1YcCMekL7S2M2SIiWBBUSE6vCZ3W8qlsda/R
         jozu52+LyAO5iRC/pedE3Nx6XtiY+826Bka3MNivgXRE6UIj/9FPvPWRDVHE7ler2B65
         IhuYxB+ZEkNgKZ9j47dZOAKpZj45p/Zz1GprkG5BiCzkTQ55IMEPsqXY5o+TtTCUeepY
         9uQ9Gb52P3sy+qt0Nar2o42rmu1n01NFiAuQZ0ztsjP3qPOUNYjVw1y9Kl7FFDgcz9nE
         B2ig==
X-Gm-Message-State: AO0yUKUTjsolqTF1Ic2gJ5R4iy3/sVf92xfiYJummqPDgPob1BbJwVOD
        +JzhahX+ibIWYeEGhhIi0SsZ
X-Google-Smtp-Source: AK7set883pFC82jpEyOa+oLvl/UtFD6xh2z33/ogPnq+x7Ex+Uzf3YAktvQnW0pnhik8BPOU3sG04g==
X-Received: by 2002:a9d:378a:0:b0:68b:dc52:10f9 with SMTP id x10-20020a9d378a000000b0068bdc5210f9mr1862317otb.5.1677161833074;
        Thu, 23 Feb 2023 06:17:13 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:e099:82d3:1307:6825? ([2600:1700:e72:80a0:e099:82d3:1307:6825])
        by smtp.gmail.com with ESMTPSA id o21-20020a9d7195000000b0068657984c22sm2362340otj.32.2023.02.23.06.17.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 06:17:12 -0800 (PST)
Message-ID: <e2948915-8505-2657-7283-e845804dde0d@github.com>
Date:   Thu, 23 Feb 2023 09:17:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 10/16] object.h: stop depending on cache.h; make cache.h
 depend on object.h
Content-Language: en-US
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Emily Shaffer <nasamuffin@google.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.1485.git.1677139521.gitgitgadget@gmail.com>
 <1357f18db5601cf4fc68a56a2e846d2aed6ad6b6.1677139522.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <1357f18db5601cf4fc68a56a2e846d2aed6ad6b6.1677139522.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/23/2023 3:05 AM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> Things should be able to depend on object.h without pulling in all of
> cache.h.  Move an enum to allow this.
> 
> Note that a couple files previously depended on things brought in
> through cache.h indirectly (revision.h -> commit.h -> object.h ->
> cache.h).  As such, this change requires making existing dependencies
> more explicit in two files.

> diff --git a/diff.h b/diff.h
> index 41eb2c3d428..b90036f5294 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -8,6 +8,7 @@
>  #include "pathspec.h"
>  #include "object.h"
>  #include "oidset.h"
> +#include "strbuf.h"
>  
>  /**
>   * The diff API is for programs that compare two sets of files (e.g. two trees,
> @@ -71,7 +72,6 @@ struct oid_array;
>  struct option;
>  struct repository;
>  struct rev_info;
> -struct strbuf;
>  struct userdiff_driver;

This inclusion of strbuf.h in diff.h seems like a step in the
opposite direction. What caused you to need to do this?

Looking ahead at the patch titles, I see you will revisit diff.h
in the final patch, so I'll try to see if there are effects there.

> diff --git a/list-objects-filter-options.h b/list-objects-filter-options.h
> index 1fe393f4473..ef03b45132e 100644
> --- a/list-objects-filter-options.h
> +++ b/list-objects-filter-options.h
> @@ -1,9 +1,10 @@
>  #ifndef LIST_OBJECTS_FILTER_OPTIONS_H
>  #define LIST_OBJECTS_FILTER_OPTIONS_H
>  
> -#include "cache.h"
> +#include "object.h"
>  #include "parse-options.h"
>  #include "string-list.h"
> +#include "strbuf.h"

Here's another case of including strbuf.h instead of declaring
'struct strbuf'. However, it makes a bit more sense because you
are deleting the cache.h include in this change. It would still
be nice if we didn't need to do it.
 
Thanks,
-Stolee

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B027AC433EF
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 14:43:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237741AbiF0On3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 10:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236271AbiF0On1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 10:43:27 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7C4634E
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 07:43:26 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id b23-20020a9d7557000000b00616c7999865so3065036otl.12
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 07:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ao+t42Qs6OlPm5aVGc/LCIMuAB735iQBK8nQEdNya70=;
        b=ShzlED911Cpt2EjoOjPJZE7/rinigjIthgPICKj9ZHGAgUQljiNTs4Mi/xdJCpKh30
         ZwHwGI8/9w7iBlANWKnxF/wDvBDrEKksZNnVPxDH9RY1pFknI+l5iEMjI+olBAcBCDOf
         fOL0/3yoCwvDj0eGVvJvk1hgDAVWz+lt9qhmOrahjUKBtljAMCgDFFCAcsMvQkcf5IDm
         t0s8PPl5cRvSmXCTBUaxY8KZi6QVcj40nOWk9onF8KrqF8iMM+rkEhB/ZNqrc8O6Z3LT
         DvfnYG7E1wo2Lz+2RV6mQ3zWvV5fety++TWPh5VAHf5UHUyvNSz3uvtcu+yqyZab8IQQ
         ooMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ao+t42Qs6OlPm5aVGc/LCIMuAB735iQBK8nQEdNya70=;
        b=2FzaKEO/s8a5jMG1Fa46b0SwStQPcPUHu8nzND6GdAeRgsa+lxAPZtcv2+vh0/w/oi
         ddpfIYZZ9RWrjqH6qBmekvxblEmTlbERV3/duK+lfMhHLwReYw/NZs3cM9MOUim2i+nV
         JOItpCWYBkFvexe1Psh9s73WHUGK5RM3Il4DjcU11V5Wd7v2MuEYHgjlcp7XV++7uTJQ
         yqa2kyiWLB5v6Bc+rrAatAlZgTho1BwfWWRHpQQn15Pess5u8wHPLGS0OQ7ko4Wos4lZ
         iD/UWJNRsO5gz0Qy0XiNbsytAoNX/nFlF2jZ9C26Kuu+aN5D8JLemDvnYdM45MiaBBe1
         N6Yg==
X-Gm-Message-State: AJIora+h2zGapuhVtME46gw61agNoJtRjIy5iTBwOdUTe5e8lcRki5Pf
        bOeHcM6xZMO7tFoq3hFatiFoBwTdy2BA
X-Google-Smtp-Source: AGRyM1un1hsvHgyYBiCo/rMhqX+FQtyYxiAbEhF50MYMuhLIQnq+ZvHSw3er0AXTlTNjHdiH5m+hxQ==
X-Received: by 2002:a05:6830:6215:b0:616:9ec3:b71 with SMTP id cd21-20020a056830621500b006169ec30b71mr5918639otb.296.1656341005725;
        Mon, 27 Jun 2022 07:43:25 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:714a:b337:6fac:e704? ([2600:1700:e72:80a0:714a:b337:6fac:e704])
        by smtp.gmail.com with ESMTPSA id e23-20020a9d0197000000b0060c05f45c38sm6468886ote.48.2022.06.27.07.43.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 07:43:25 -0700 (PDT)
Message-ID: <05edd01a-8b6f-b25d-0cd1-b1a46ca7c219@github.com>
Date:   Mon, 27 Jun 2022 10:43:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 3/6] pack-bitmap-write: learn
 pack.writeBitmapLookupTable and add tests
Content-Language: en-US
To:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
References: <pull.1266.git.1655728395.gitgitgadget@gmail.com>
 <pull.1266.v2.git.1656249017.gitgitgadget@gmail.com>
 <7786dc879f006c8316c33dd70e98888ceb50a014.1656249017.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <7786dc879f006c8316c33dd70e98888ceb50a014.1656249017.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/26/2022 9:10 AM, Abhradeep Chakraborty via GitGitGadget wrote:
> From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
> 
> Teach git to provide a way for users to enable/disable bitmap lookup
> table extension by providing a config option named 'writeBitmapLookupTable'.
> Default is true.

I wonder if it makes sense to have it default to 'false' for now, but to
change that default after the feature has been shipped and running in
production for a while.

> Also add test to verify writting of lookup table.

s/writting/writing/

> +pack.writeBitmapLookupTable::
> +	When true, git will include a "lookup table" section in the

I think you should either use "Git" when talking about the software
generally, OR use "`git repack --write-bitmap-index` will include..."

> +	bitmap index (if one is written). This table is used to defer
> +	loading individual bitmaps as late as possible. This can be
> +	beneficial in repositories which have relatively large bitmap

s/which/that/

(I'm pretty sure that "that" is better. We're trying to restrict the set
of repositories we are talking about, not implying that all repositories
have this property.)

> +	indexes. Defaults to true.
> +

> --- a/pack-bitmap-write.c
> +++ b/pack-bitmap-write.c
> @@ -713,6 +713,7 @@ static void write_lookup_table(struct hashfile *f,
>  	for (i = 0; i < writer.selected_nr; i++)
>  		table_inv[table[i]] = i;
>  
> +	trace2_region_enter("pack-bitmap-write", "writing_lookup_table", the_repository);
>  	for (i = 0; i < writer.selected_nr; i++) {
>  		struct bitmapped_commit *selected = &writer.selected[table[i]];
>  		uint32_t xor_offset = selected->xor_offset;
> @@ -725,6 +726,7 @@ static void write_lookup_table(struct hashfile *f,
>  
>  	free(table);
>  	free(table_inv);
> +	trace2_region_leave("pack-bitmap-write", "writing_lookup_table", the_repository);
>  }

These lines seem misplaced. Maybe they were meant for the previous
patch?

Thanks,
-Stolee

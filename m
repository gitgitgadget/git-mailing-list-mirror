Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E7F51F4C0
	for <e@80x24.org>; Tue, 15 Oct 2019 19:40:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732411AbfJOTk0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Oct 2019 15:40:26 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40317 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727856AbfJOTk0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Oct 2019 15:40:26 -0400
Received: by mail-pf1-f196.google.com with SMTP id x127so13114762pfb.7
        for <git@vger.kernel.org>; Tue, 15 Oct 2019 12:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i08RXMeO9BQqNh382Gy/mCujyg9G5yvKiwal5Bq/u7I=;
        b=RKpi/yEdG+q+Z0Ip+7r8YevdtEmNIXlUzvNO+L1J3ETfbuFz+64KBm0pa9wdZ76C32
         wfP1d4a1VBYPwLDoWxisnyRvLn3idJr+ZESA9yJPY70XpwBQPDIyZqKgnY5IvDEbA89H
         k3kXs7SZi8BauOebdPhnZT5PnRQ+EB8pEa2UcnYCCQpUgrcs+Q8aCtbyhKBMTf/wEJ5f
         66IoWJx2tkA12gHVA/+dS6szJQ3PQvNK1Wq5MAagO7bzqNNs6SRjINitA3KAAdUhvh73
         fJnbw1dbrd9MX0PrnHEEpOuASsCjjbgoj2KzZAik85F8atJfExG9n/MlkA80YvFOaiub
         OmyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=i08RXMeO9BQqNh382Gy/mCujyg9G5yvKiwal5Bq/u7I=;
        b=XoU71iHk9Rae3PTPpLBskubOe6kH8dZuzGPBpH94jjC97w7P8SjgaGKo8AoWb3kfV1
         hQkC7rv5nPSaoZdMMfM7PCgFGSPi9pCXUfPXnO4k0qPReG4tTiywxvWk/AFaYI/sErIM
         YOnvTXYsrRQJyrxO+SyJOtcd/Wxt6EqUbQe9/Vhvav0nYKJ97mvl3nliBy/vCO7SZwbm
         Z+TA6y6iiaVJXbny/bf1DC0kU9mdAWoKsearyABIyxk1456maq3QMzu6mOH8V+VzdLpR
         P9c4SiSYuibbGFWQf8cZpO+jZU6meypx8fK8LXfOG1tnq//D9Wwjq+qqQrTBc1qETmuD
         PTjQ==
X-Gm-Message-State: APjAAAW4zg/RIBViI31zyoIn35VKqZ/OP/N+Y9IAI1Qh1pXzrG+RCpzG
        S7KM8BD+D+0akwgfxMZDEXYI/A==
X-Google-Smtp-Source: APXvYqwSwjS5y7JVZ1Aidzp2VtCcpzh630UkeSTOSgJUXf2OA5EpfahjMiOlCVQh4wVjUddFKJ16VQ==
X-Received: by 2002:a62:3441:: with SMTP id b62mr41508842pfa.233.1571168425206;
        Tue, 15 Oct 2019 12:40:25 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:ece8:7fe:c1f1:a20f])
        by smtp.gmail.com with ESMTPSA id 206sm21130577pge.80.2019.10.15.12.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 12:40:24 -0700 (PDT)
Date:   Tue, 15 Oct 2019 12:40:19 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] fetch-pack: write fetched refs to .promisor
Message-ID: <20191015194019.GC233821@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
References: <20190826214737.164132-1-jonathantanmy@google.com>
 <20191015001231.97272-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015001231.97272-1-jonathantanmy@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019.10.14 17:12, Jonathan Tan wrote:
> The specification of promisor packfiles (in partial-clone.txt) states
> that the .promisor files that accompany packfiles do not matter (just
> like .keep files), so whenever a packfile is fetched from the promisor
> remote, Git has been writing empty .promisor files. But these files
> could contain more useful information.
> 
> So instead of writing empty files, write the refs fetched to these
> files. This makes it easier to debug issues with partial clones, as we
> can identify what refs (and their associated hashes) were fetched at the
> time the packfile was downloaded, and if necessary, compare those hashes
> against what the promisor remote reports now.
> 
> This is implemented by teaching fetch-pack to write its own non-empty
> .promisor file whenever it knows the name of the pack's lockfile. This
> covers the case wherein the user runs "git fetch" with an internal
> protocol or HTTP protocol v2 (fetch_refs_via_pack() in transport.c sets
> lock_pack) and with HTTP protocol v0/v1 (fetch_git() in remote-curl.c
> passes "--lock-pack" to "fetch-pack").
> 
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
> Changes from v1:
>  - commit message explains scope of change ("it knows the name of the
>    pack's lockfile)
>  - explained what .promisor contains in comment in builtin/repack.c
>  - moved .promisor writing until after we know that index-pack succeeded
> ---

Thanks, this looks good to me.

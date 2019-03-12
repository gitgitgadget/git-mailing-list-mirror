Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B687202BB
	for <e@80x24.org>; Tue, 12 Mar 2019 13:59:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbfCLN7s (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 09:59:48 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:33045 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbfCLN7s (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 09:59:48 -0400
Received: by mail-yw1-f65.google.com with SMTP id a199so2183354ywa.0
        for <git@vger.kernel.org>; Tue, 12 Mar 2019 06:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IYJ4+9kC29AAMf6IYl7B4ArCygW+E/oyCGaNiKop9VY=;
        b=JJKIfKksGKQ/zDEWwx46voV/o41ZKwWdUeb+yjX/OkE0jAjTZDuZZzSnAHzi+JGsXS
         mJNMftpmokOKKQddblHvmky6d4DizbSzx1SQGJVTrj4J6wCEmhi8Krm8hgu1rTAoysEp
         gvCjk7DvQXOJiVKQh5ZGUdP495oHfa2wVp4Ws1+z5ZkmC7pTTKBHwvVcTlXWyvwFdUyJ
         8b+sONacS30BYQNlOcnXPD931/XD9uqzhVQ1tInIblYkK2S5zkS5HsLjOl2SBoiFS3MA
         X1MVCrs23DvpMtq7jtQ0uLwPNGOF9QFRbrmACaI2oPAiCL79kAhJFjeX8bEAesqyn9d3
         oAYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IYJ4+9kC29AAMf6IYl7B4ArCygW+E/oyCGaNiKop9VY=;
        b=T7jjdCdYTJ3WEb9DEwAiq8lkCwLWqylq72YG73i0z7IVFg+mmmVmbNB/Wuhm987S7n
         AImxT4fjUO6KhNISQKnu/sNbO/dvZmqdt8pjZX89CUXZhbBlxBQ8toSHZ+9mlRihR/Oa
         OvQT6goySPyrPF3+G2FhitGpIZTvOfSY9cTzXd/HXOX8eZRcligeTXR0JgpQ2SEbJwJV
         3zB7yT/PqgSudfMBPh6C/G0iekOBVY5u2laNCtf0UrtNyXbiJrxupqutzQZ+kV/mYLIY
         N/dDYQqv0ANOB0jOSJP/6yPlViRxD3eO/3SQg5B/6cQzGL4oBF6E7PJqQmOrDR96w8Yw
         niqA==
X-Gm-Message-State: APjAAAWWNXxT0tT+WbbyYZ60Lgra+D+BpHcKgIYKapsdPynzLyVGYOTL
        ruVxpcqEplkG5ev10OYrc9o=
X-Google-Smtp-Source: APXvYqwD9Okt9tLAyx7CvUr+w37xSe5UeNcUZWM8D42hpRBAb+QuKGL4utYgxlhM0f08GRVTQKlC3w==
X-Received: by 2002:a25:50d2:: with SMTP id e201mr32201921ybb.81.1552399187790;
        Tue, 12 Mar 2019 06:59:47 -0700 (PDT)
Received: from [192.168.1.13] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id b132sm3533024ywh.79.2019.03.12.06.59.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 06:59:47 -0700 (PDT)
Subject: Re: [PATCH 2/4] revision walk: optionally use sparse reachability
To:     Nathaniel Filardo <nwf20@cl.cam.ac.uk>, git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>
References: <20190312131858.26115-1-nwf20@cl.cam.ac.uk>
 <20190312131858.26115-3-nwf20@cl.cam.ac.uk>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b414cb29-05a2-333e-f734-540eb0d1eaa4@gmail.com>
Date:   Tue, 12 Mar 2019 09:59:46 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:66.0) Gecko/20100101
 Thunderbird/66.0
MIME-Version: 1.0
In-Reply-To: <20190312131858.26115-3-nwf20@cl.cam.ac.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/12/2019 9:18 AM, Nathaniel Filardo wrote:
> The only caller that passes a non-zero value to prepare_revision_walk
> after this patch is builtin/pack-objects.  Without this, sparsity seems
> to do little good therein, as prepare_revision_walk will densely
> propagate UNINTERESTING flags from trees to tree contents, before
> mark_edges_uninteresting has a chance to be faster by being sparse.
> 
> Signed-off-by: Nathaniel Filardo <nwf20@cl.cam.ac.uk>
> ---
>  bisect.c                         |  2 +-
>  blame.c                          |  2 +-
>  builtin/checkout.c               |  2 +-
>  builtin/commit.c                 |  2 +-
>  builtin/describe.c               |  2 +-
>  builtin/fast-export.c            |  2 +-
>  builtin/fmt-merge-msg.c          |  2 +-
>  builtin/log.c                    | 10 +++++-----
>  builtin/merge.c                  |  2 +-
>  builtin/pack-objects.c           |  4 ++--
>  builtin/rev-list.c               |  2 +-
>  builtin/shortlog.c               |  2 +-
>  bundle.c                         |  2 +-
>  http-push.c                      |  2 +-
>  merge-recursive.c                |  2 +-
>  pack-bitmap-write.c              |  2 +-
>  pack-bitmap.c                    |  4 ++--
>  reachable.c                      |  4 ++--
>  ref-filter.c                     |  2 +-
>  remote.c                         |  2 +-
>  revision.c                       | 10 ++++++----
>  revision.h                       |  2 +-
>  sequencer.c                      |  6 +++---
>  shallow.c                        |  2 +-
>  submodule.c                      |  4 ++--
>  t/helper/test-revision-walking.c |  2 +-
>  26 files changed, 41 insertions(+), 39 deletions(-)

This patch is very noisy. Perhaps the pattern established in 4f6d26b1:
"list-objects: consume sparse tree walk" should be reversed and instead
include a 'sparse_tree_walk' setting into 'struct rev_info'.

Changing so many method prototypes is rather invasive and unlikely to
benefit many of these callers.

If the setting is added to 'struct rev_info', then you'll want to remove
the parameter from mark_edges_uninteresting().

Thanks,
-Stolee

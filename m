Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 798EFC433B4
	for <git@archiver.kernel.org>; Fri,  7 May 2021 04:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56AB261040
	for <git@archiver.kernel.org>; Fri,  7 May 2021 04:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbhEGEBI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 May 2021 00:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhEGEBF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 May 2021 00:01:05 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6E4C061574
        for <git@vger.kernel.org>; Thu,  6 May 2021 21:00:05 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id s20so4464718plr.13
        for <git@vger.kernel.org>; Thu, 06 May 2021 21:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+Q4A28Xi4JCQ4WRAgmT3tDSYo8RDS3VXGv2dRkJzmEo=;
        b=JzRQ8IjfivzB4FgnsBDB3Y+6xhUSnqVGP4AVDCjdDxTG6rb2eY+I7hzWyCUw72u3r7
         PBhD+TOAgWqLKyvKr3XxZAdcWw9flJkE5HfHISbSMBNNf25QnG9htczuT7AdHJvpaIf8
         ckVvGSmbeWzvxR+T8bamuxh+DWNUR1QUT+9VNeQiXqNJnE2Ck9w3jMbDEyPaHNvVhTcq
         vMN/x8SDyx06AZqyiLOed8nWlui2y9LOLDNe0ng6/bqN+C6V6/nm0hBs/IwYnSsIM2sN
         ioyUJI01iOoPVGj85VyhnJMNgmOSWUlMmsWnifdrtbEp3X7uUZlWteEoWpPjNxxoJRiF
         qClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+Q4A28Xi4JCQ4WRAgmT3tDSYo8RDS3VXGv2dRkJzmEo=;
        b=jCd1EEWZlVIyrM99dIW1MQImDb0dI3ERNBPOuQAj3ILHl3IG9ywAsC3Fa55VnRcCYq
         rUt7zetp7FdxRkvpzBlfQmLFyBBjeGMqx+M9kNt3PPmVQaeSwRb07Krx96qyT8ypRrJT
         OQ0JF7fxFaKrSKt131VoV+N5p9a2UD4ZFyRGkyr7Hou8A7Sskmo4tXw9AwbGJe9M08vi
         9sNbUVeHkpoiRvxgIDpA++3uP/JAqw1ZDC7ZkKUxpVsftNmFEQjqN2kBeECUY/VGvlPc
         8HxZAVufpSapxb2Kth8a4H2t9vMB3mouwxsdwZXvi77Zla3zq67tV4mlIdAZG0gL2aHb
         LQHg==
X-Gm-Message-State: AOAM532Se3Eyl/r+daTSCh1JxzUcnYdDhoJsJUHXuJQye3wD8h+5wtXg
        nDmrW+YGJRl/SVC2A+eL+4b/BZHqIeMzqBmt
X-Google-Smtp-Source: ABdhPJzfOP7GkNySZeP/2u33ZRyCBj7V5AFlk36/JvRLBD1wgBuI4dTU6/Z2y1vlyDTjc/hx+C2zaA==
X-Received: by 2002:a17:902:7446:b029:ed:d815:8b8c with SMTP id e6-20020a1709027446b02900edd8158b8cmr8162336plt.26.1620360005159;
        Thu, 06 May 2021 21:00:05 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-82.three.co.id. [180.214.233.82])
        by smtp.gmail.com with ESMTPSA id j7sm11363542pjw.4.2021.05.06.21.00.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 May 2021 21:00:04 -0700 (PDT)
Subject: Re: [PATCH 1/1] clone: document partial clone section
To:     Teng Long <dyroneteng@gmail.com>, gitgitgadget@gmail.com
Cc:     git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>
References: <pull.745.v5.git.git.1614695133486.gitgitgadget@gmail.com>
 <20210506063046.23353-1-dyroneteng@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <dd4b4247-0981-4ad7-ce6f-448cedeeb4b0@gmail.com>
Date:   Fri, 7 May 2021 11:00:00 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210506063046.23353-1-dyroneteng@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/05/21 13.30, Teng Long wrote:
> Partial clones are created using 'git clone', but there is no related
> help information in the git-clone documentation during a period. Add
> a relevant section to help users understand what partial clones are
> and how they differ from normal clones.
> 
> The section briefly introduces the applicable scenarios and some
> precautions of partial clone. If users want to know more about its
> technical design and other details, users can view the link of
> git-partial-clone(7) according to the guidelines in the section.
> 
> Signed-off-by: Teng Long <dyroneteng@gmail.com>
> ---
>   Documentation/git-clone.txt | 69 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 69 insertions(+)
> 
> diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
> index c898310099..15495675a8 100644
> --- a/Documentation/git-clone.txt
> +++ b/Documentation/git-clone.txt
> @@ -308,6 +308,75 @@ or `--mirror` is given)
>   	for `host.xz:foo/.git`).  Cloning into an existing directory
>   	is only allowed if the directory is empty.
>   
> +Partial Clone
> +-------------
> +
> +By default, `git clone` will download every reachable object, including
> +every version of every file in the history of the repository. The **partial clone**
> +feature allows Git to transfer fewer objects and request them from the
> +remote only when they are needed, so some reachable objects can be
> +omitted from the initial `git clone` and subsequent `git fetch`
> +operations. In this way, a partial clone can reduce the network traffic
> +costs and disk space usage when git is working under a large repository.
> +
> +To use the partial clone feature, you can run `git clone` with the
> +`--filter=<filter-spec>` option. If the repository has a deep history
> +and you don't want to download any blobs, the form `filter=blob:none`
> +will omit all the blobs. If the repository has some large blobs and you
> +want to prevent some large blobs being downloaded by an appropriate
> +threshold, the form `--filter=blob:limit=<n>[kmg]` omits blobs larger
> +than n bytes or units (see linkgit:git-rev-list[1]).
> +
Why not the following?:

```
If the repository has some large blobs and you want to omit blobs larger
than desired size limit, use `--filter=blob:limit=<n>[kmg]`.
```

> +When using a partial clone, Git will request missing objects from the
> +remote(s) when necessary. Several commands that do not involve a request
> +over a network may now trigger these requests.
> +
> +For example, The <repository> contains two branches which names 'master'
> +and 'topic. Then, we clone the repository by
> +
> +    $ git clone --filter=blob:none --no-checkout <repository>
> +
> +With the `--filter=blob:none` option Git will omit all the blobs and
> +the `--no-checkout` option Git will not perform a checkout of HEAD
> +after the clone is complete. Then, we check out the remote tracking
> +'topic' branch by
> +
> +    $ git checkout -b topic origin/topic
> +
> +The output looks like
> +
> +------------
> +    remote: Enumerating objects: 1, done.
> +    remote: Counting objects: 100% (1/1), done.
> +    remote: Total 1 (delta 0), reused 0 (delta 0), pack-reused 0
> +    Receiving objects: 100% (1/1), 43 bytes | 43.00 KiB/s, done.
> +    Branch 'topic' set up to track remote branch 'topic' from 'origin'.
> +    Switched to a new branch 'topic'
> +------------
> +
> +The output is a bit surprising but it shows how partial clone works.
> +When we check out the branch 'topic' Git will request the missing blobs
> +because they are needed. Then, We can switch back to branch 'master' by
> +
> +    $ git checkout master
> +
> +This time the output looks like
> +
> +------------
> +    Switched to branch 'master'
> +    Your branch is up to date with 'origin/master'.
> +------------
> +
> +It shows that when we switch back to the previous location, the checkout
> +is done without a download because the repository has all the blobs that
> +were downloaded previously.
> +
> +`git log` may also make a surprise with partial clones. `git log
> +--<path>` will not cause downloads with the blob filters, because it's
> +only reading commits. `git log -p -- <path>` will download blobs to
> +generate the patch output and git log --raw will download all blobs
> +that changed at recent commits in order to compute renames.
> +
>   :git-clone: 1
>   include::urls.txt[]
>   
> 

This describes client-side usage. However, you missed the point that not
all server supports partial clone. If you have your own Git server, and
you want to enable partial clone, you need to invoke as user running the
server daemon (typically `git`):

`git config --global uploadpack.allowfilter true`

And you also missed the case when someone wants to remove partial clone
filters (in order to turn into full clone), for example when needed to
push to another repository as backup. See Gitlab docs for the instructions
[1].

However, brian m. carlson [CC'ed] suggested that "fetch missing objects"
step is instead be done using xargs to avoid "Argument list too long" error,
see [2].

[1]: https://docs.gitlab.com/ee/topics/git/partial_clone.html#remove-partial-clone-filtering
[2]: https://lore.kernel.org/git/YD7bczBsIR5rkqfc@camp.crustytoothpaste.net/
-- 
An old man doll... just what I always wanted! - Clara

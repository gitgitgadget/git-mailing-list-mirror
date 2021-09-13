Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A78FC433EF
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 19:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A76F60F26
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 19:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240452AbhIMTUZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 15:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhIMTUV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 15:20:21 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F8FC061574
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 12:19:05 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id a1so11276259ilj.6
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 12:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tHqJKxCd7/dC8S0d0oBn1wKbTEmTq3aCi0t5fmtsPEo=;
        b=q75O7gknd4fI86kpU318bcKvqEfDSZPcaMhSL1Z00soZJslVV614BiyQtcCrYoE+oD
         y3dDup2URPMzUkyW+v6QqxO+dqigyVwSqUKGfnZRPSC+ElEfxiugNUv1GSIPwrANbcLo
         BRAf/yiUY/sOLbnYGpUjv2RqTgCNIoyUjyk6VJX740dQ+enGaqkhPjU9JmeOgFYMoFjf
         9bUeZcUSjwdnemxVSjE3+fapXoQUGK9LI8LxQTz2auok3KLsIu660N8A8JRSE8SNH5UA
         bA72+4r9XAyluvwWbRP8hhwb5DSkuwkXiU6GhWw7O0ao3kXm9FZe83boYQKsTJ0OCqbu
         3Usw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tHqJKxCd7/dC8S0d0oBn1wKbTEmTq3aCi0t5fmtsPEo=;
        b=1yO/Bz4slfrU8LCq8BWDRW41gnx1CgQcl4cNmHwNPoK6uvp5zO2tMn9UJeaxEfok8f
         UG9ZOIskuYLHdbN41x918UioF4MTCeEespoX76o0cdOAytvqMemOyxvejYoqupe3T5KU
         2Sx1fuGkz5THUBq5Y5Hhc3WZZRcNy7IR6pCHrAGLCubuAQ4OUsQigK9JHiDUMMlg8MuW
         6RfFLQm8lSnGmwZlrw0isoK8zLdok/7X3zA6op9bcGUhQ0HIH/GFGF+JhrR2hYi68I8J
         2kHN5Ijxoh4QQ3R87uQRcoJOmPuU8LElzHVzN1yb8Nd+ppCuSGcD3z6wfZROCPAwr8VZ
         1MGg==
X-Gm-Message-State: AOAM5333dDfkuWy+p6EAmTbGkzT8pOpjbwUBmRHf1GKjxM/heDvpBff3
        Rml62YtJy+3kRmTFjsUNroKXmYlwGFIj2E3k
X-Google-Smtp-Source: ABdhPJwWRlKKFp0pAs214moX8DUGKUkRex5vhiSdTpwjqLmEnIn3RnO5ECZXWDG7deZLLhDt9uuJ9g==
X-Received: by 2002:a05:6e02:168d:: with SMTP id f13mr9062067ila.12.1631560745029;
        Mon, 13 Sep 2021 12:19:05 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id b3sm5334511ilm.20.2021.09.13.12.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 12:19:04 -0700 (PDT)
Date:   Mon, 13 Sep 2021 15:19:03 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com
Subject: Re: [PATCH 0/3] Use default values from settings instead of config
Message-ID: <YT+kJ5jhzn6rghc9@nand.local>
References: <20210913181221.42635-1-chooglen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210913181221.42635-1-chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 13, 2021 at 11:12:18AM -0700, Glen Choo wrote:
> I'm fairly new to the codebase (this is my first patch!), so I have some
> questions/concerns that I wasn't able to figure out:

Welcome to the Git community! :-).

> - prepare_repo_settings() may have undesirable side effects or may
>   not always be callable

Calling prepare_repo_settings() is definitely the right thing to do,
because (as you note) it centralizes the default values for settings
that it keeps track of.

You can call prepare_repo_settings() so long as you have a repository to
call it on. Since fsck and gc must run inside of a repository, the
callers you added are safe. And note that prepare_repo_settings() is
idempotent, i.e., that it is a noop when called more than once.

Thanks,
Taylor

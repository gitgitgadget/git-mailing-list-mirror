Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A40C433F5
	for <git@archiver.kernel.org>; Sun, 10 Oct 2021 11:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB23A60F23
	for <git@archiver.kernel.org>; Sun, 10 Oct 2021 11:19:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbhJJLV4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Oct 2021 07:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbhJJLVz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Oct 2021 07:21:55 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AFDAC061570
        for <git@vger.kernel.org>; Sun, 10 Oct 2021 04:19:57 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id x4so9301482pln.5
        for <git@vger.kernel.org>; Sun, 10 Oct 2021 04:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:from
         :subject:content-transfer-encoding;
        bh=YiCWMLUTP+51XFOaGg4b2dLOl+SE7gmj4+QlnLnmiIE=;
        b=MA4KLIZAvuVJz30V6iacPj3HCMUEu2LPQcjkb9wm/I4JGjhzaY874tIYyxWNtxlP/9
         k/BXd+BLPxMUI3rvzSKed6UYmKzKH3j30O07GdIgmhImIrowqGOAix7tOyameH459AZ9
         UQeh9gmVaEtOrxXoLlk8StOyKm4+DC/H8ztM4K8ZgpHRCOlL7+FDTiZax5r6EpbV56bO
         OcAu5kbemirRhYTuy0ZzhoX1RNLSw/Z3Gt41+pojEK8923TjOpb4jv4XA7nSe6plLhOa
         Emmta1Y+5iNU2rvZgGAm43a7Lb/ist25hXsMOXdebu2IOdxcbJrADau1swAMMVp3M+ow
         j1RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:from:subject:content-transfer-encoding;
        bh=YiCWMLUTP+51XFOaGg4b2dLOl+SE7gmj4+QlnLnmiIE=;
        b=u55K+DDHatbVKd8k21Ew3SAXUaSD3QfBZAEBQ2F3FTapvo0ebYBfn6dReiHjIh0wTq
         HNGJZ5EIO3POHO3UTnjoPFC5fYFRClwrDy3+sFNptbFiYmwadkW4N7li+GGkxVsMg3Q0
         HGQtkA9OeKOwEMrr44dY2jkAyJKyPXJs1HjtcVCJEmW54Tzf/Hha+//aA/mbKQxykBiQ
         iTFFVGZTvX1pzox/ckgzxK3pl5EzRSW738iaEbVvvnphxbvlIfiELukV3FRUMhgBRD0W
         WGE7OQkIf7B/N7SiTTlCq0FB8SgZdf7FjI6hf6XajPMeq1vzsnJdOJK0HXuIIznZ6LBW
         1MYg==
X-Gm-Message-State: AOAM531HI03lFlzTQ89XbIzOuEaN09O8PQyBZVz4RWCT+BzbRAuTPB8u
        rhP7NL8LeYWYIfaP4ai7/ANBcuWYYyE=
X-Google-Smtp-Source: ABdhPJxSFg7SXf5Z/r7+58P7h+JB4rxACnWf6oJSPewboU0GL33QL2My/rm1uFIX89fUWY5FN1djuA==
X-Received: by 2002:a17:90a:1f4a:: with SMTP id y10mr22857471pjy.225.1633864796528;
        Sun, 10 Oct 2021 04:19:56 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-42.three.co.id. [116.206.12.42])
        by smtp.gmail.com with ESMTPSA id z4sm4411380pfb.107.2021.10.10.04.19.55
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Oct 2021 04:19:56 -0700 (PDT)
Message-ID: <e50a85f1-7be2-dab9-a453-fb93bdb71f3c@gmail.com>
Date:   Sun, 10 Oct 2021 18:19:53 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     Git Users <git@vger.kernel.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: git archive -o something.tar.zst but file info just says "POSIX tar
 archive"
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I noticed the following (possible bug?) when I tried to create zstd tar 
archive (.tar.zst) with `git archive`.

First, I created the plain tar archive with `git archive`, then extract 
and rearchive to zstd tar achive:

```
(on the repo)

$ git archive -o /tmp/something.tar --prefix=something/ HEAD

(outside the repo, on /tmp)

$ tar xvf something.tar
$ tar --zstd -c -v -f something.tar.zst something/
```

I checked that the archive was indeed zstd tar archive:

```
$ file something.tar.zst
something.tar.zst: Zstandard compressed data (v0.8+), Dictionary ID: None
```

Now I created the same archive with `git archive` directly:

```
(on the repo)

$ git archive -o /tmp/something1.tar.zst --prefix=something/ HEAD
```

But that archive info (with `file`) was something different:

```
(outside the repo, on /tmp)
$ file something1.tar.zst
something1.tar.zst: POSIX tar archive
```

I expected that `something1.tar.zst` was proper zstd tar archive, and 
not plain archive like above.

-- 
An old man doll... just what I always wanted! - Clara

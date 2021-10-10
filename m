Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 539D8C433F5
	for <git@archiver.kernel.org>; Sun, 10 Oct 2021 11:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1ED276109E
	for <git@archiver.kernel.org>; Sun, 10 Oct 2021 11:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbhJJLmd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Oct 2021 07:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbhJJLmb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Oct 2021 07:42:31 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CE5C061570
        for <git@vger.kernel.org>; Sun, 10 Oct 2021 04:40:32 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id b8so55515253edk.2
        for <git@vger.kernel.org>; Sun, 10 Oct 2021 04:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=c6LkAjJmaztaxvT3K6+QQPZO4bSVksEaX4tSo2Da/iQ=;
        b=ZpTXXZ7W3xeXHyC4MgiZp0hkbpcBO8O9Hm1C8W9JMQUHUDd0hxM0HEpNxl1Mw3eWnU
         XidM+FsZGLnzHISQ1DTuKr4UMK2sWfAo6lrHz33/LSFjMBxGr03L4FwOV8neuXuruZHc
         XcOv9/SUZf8q6M3sp3HsE3HY7YQKe9b+pvLgnPuf2tMowZlSoaa6Ea8vwcnuMwRetxR4
         BfuUrgnnp20U4L3cs7QQDv8WCfCY6DFPXHjMRXAwrtkXyFvRIx75Aazc739UIgcG2P/a
         BUJKuxXMMHSUSU3kZVJ2nWfP/D9A6oG3CRYxVnozrMVO682+IlJccT6T1vWOEArnPePt
         eyNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c6LkAjJmaztaxvT3K6+QQPZO4bSVksEaX4tSo2Da/iQ=;
        b=VtTGlDqSNWLb2ReR97HQK/T6OeAAo8f1kVE47cjOE/sBp2iKn+cnbAxP+LZySYZd0k
         a6vxxfYXNo6uSbOKlBKIlEv8iG/HURmyGBlknNPQhZUDO5GrGQnb3YrdTdc/2KdkdaJ4
         A8Q80Okk0+zwUQ/q9CuxEBmfYAWW1eNx9pjKRm5fFsE9oo8pEUH4MPrcLPlKGFyVoDFH
         //AhCGOta3mQ9Iduq8p95uCwyG+HYvHA+GDqpouu45kxvHUEbLC6+VQlJNDZKPoVfdXH
         UKxu6kqY3zdM2pxbXMd74HqtDodRDu4AnsW+TefCKQwR9l7/o4DziRtaqS8fl+31nrKD
         g/Mw==
X-Gm-Message-State: AOAM532fK/xMyYROXVA73Z7DCzvyqCl4MZyyHbbf3FFPcK8LAB6v2l3J
        Vz0SGrh2gA3t5lvMetabFjw4VudZEgE=
X-Google-Smtp-Source: ABdhPJyg98kL7OQibO9P3vrrf1c9apf3StfxUHelmsTwMn3lVIhnrurc2pCuqWgSTCEu5aFcVLSOwQ==
X-Received: by 2002:a50:e106:: with SMTP id h6mr32399615edl.295.1633866031036;
        Sun, 10 Oct 2021 04:40:31 -0700 (PDT)
Received: from szeder.dev (94-21-58-27.pool.digikabel.hu. [94.21.58.27])
        by smtp.gmail.com with ESMTPSA id u2sm2428555eda.32.2021.10.10.04.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Oct 2021 04:40:30 -0700 (PDT)
Date:   Sun, 10 Oct 2021 13:40:25 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Git Users <git@vger.kernel.org>
Subject: Re: git archive -o something.tar.zst but file info just says "POSIX
 tar archive"
Message-ID: <20211010114025.GA571180@szeder.dev>
References: <e50a85f1-7be2-dab9-a453-fb93bdb71f3c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e50a85f1-7be2-dab9-a453-fb93bdb71f3c@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 10, 2021 at 06:19:53PM +0700, Bagas Sanjaya wrote:
> I noticed the following (possible bug?) when I tried to create zstd tar
> archive (.tar.zst) with `git archive`.

> $ git archive -o /tmp/something1.tar.zst --prefix=something/ HEAD
> ```
> 
> But that archive info (with `file`) was something different:
> 
> ```
> (outside the repo, on /tmp)
> $ file something1.tar.zst
> something1.tar.zst: POSIX tar archive
> ```
> 
> I expected that `something1.tar.zst` was proper zstd tar archive, and not
> plain archive like above.

  $ git archive -h |grep -e ' -l'
      -l, --list            list supported archive formats
  $ git archive -l
  tar
  tgz
  tar.gz
  zip

Does it list zstd among the supported formats on your machine?


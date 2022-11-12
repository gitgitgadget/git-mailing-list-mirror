Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 522B4C4332F
	for <git@archiver.kernel.org>; Sat, 12 Nov 2022 04:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233445AbiKLEYO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Nov 2022 23:24:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbiKLEYM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2022 23:24:12 -0500
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C5F4875B
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 20:24:10 -0800 (PST)
Received: by mail-vk1-xa29.google.com with SMTP id s204so2639431vkb.3
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 20:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6Ny5yPjU7xJ4U9S+kA/IwZXBLmSprkbTAL1ngfr+MDw=;
        b=eNvg0oj/kB20Pi+D/yMRkDQOn7PE+qiWIq7wtwqTOfdxB08oD74TNy6EY9wpZpC9vz
         udmn8n+QAbv4GuTRu2Kpq4PLN6E5srxaUx3KdTOmXd40fyJ0eB/8LhDkr4aJjGZjTmmG
         34IkDZYDNdsfK3oHFtd1izx6teNtxGf2agDUa5IUkJZ2sX0bSDxA+eRkBWc/P2cjHIKc
         ELVR+f4KTr8wo+IwlmFdjWgpFImmmZKhIvSIG7FgBmvGZOg1qzfKQrfO+amyOnZ+C6Hn
         CeV5/+QBoe2hzx+fxWWjWXCRYB1rFO5N22nw49ikcAyzVCzA9rbpA75ecz6vCXYgj+FE
         NnFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6Ny5yPjU7xJ4U9S+kA/IwZXBLmSprkbTAL1ngfr+MDw=;
        b=LAlBNPSjBMdcp9WaO/tUBbyh7OiR6xuR3dcdDtcCV6Kh/hUHfhjI0y/ZastNZWwwSd
         FzP2GBInixJ8kCZ3H3cz5//S0Ow+5sYmWDShWD5soRWkXN43+bYwnoqoT0yAQA6AjZ90
         1Wh9Ckyf3MfEec8A++VTH7F2rg1cj4W9D4Z5UfUOt5Ld/gC934UL5+YifAWCqZNTZYcD
         sxJMfiUtOfnkcyrodacovQaJBdnSAE7YlxPwmRPZVAH/RbDR32WUNwY6ujEBnwXMBdAY
         XMousGo02hKjbZvuGDfOTdch/CNjuq4cQ65vzQ92/4o/I9NtyoUoD2DSfGcHwxkK2nTr
         1gRg==
X-Gm-Message-State: ANoB5pmWOUf533snKRm80mmYtcLCEVAsGx8U2MJI62e8msTdhIkUVyzu
        sPOiELANx/Su0JRtXpEFQqmcYCJKslL+MyYXkMeH73wRVOlbqR5B
X-Google-Smtp-Source: AA0mqf6e8cV+qxJVcXeVjeSOF81OGfvNWJhmiZCTBQfpX1nF+cK4oIwctPQrF7eiiSnB9JjZcqwXlSu33RUr3dVTQsg=
X-Received: by 2002:a05:6122:1883:b0:376:5afd:d30c with SMTP id
 bi3-20020a056122188300b003765afdd30cmr2555585vkb.13.1668227049335; Fri, 11
 Nov 2022 20:24:09 -0800 (PST)
MIME-Version: 1.0
From:   Adam Lee <adam8157@gmail.com>
Date:   Sat, 12 Nov 2022 12:23:58 +0800
Message-ID: <CABAGCCq-bFYX+9kU-GGWBstjMjOcO1nSQdi6Udugtkd2McO3Tg@mail.gmail.com>
Subject: [Bug report] git log shows a wrong history
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

What did you do before the bug happened? (Steps to reproduce your issue)

```
git clone https://github.com/greenplum-db/gpdb-postgres-merge.git
git_log_reproducer

cd git_log_reproducer/

git co -b iteration_REL_12_12 origin/iteration_REL_12_12

git log
```

What did you expect to happen? (Expected behavior)

A part of the history is:
```
...
commit 9ac9a7fd4138988d744e0b5767883c06c20ffa6f
commit fe0a9ddbdd7eee572f7321f9680280044fd5f258
...
```

What happened instead? (Actual behavior)

That part of the history is:
```
...
commit 9ac9a7fd4138988d744e0b5767883c06c20ffa6f
commit f9c655d647427b45ae0d7bd9baf3551a013b8ea1
commit fe0a9ddbdd7eee572f7321f9680280044fd5f258
...
```

What's different between what you expected and what actually happened?

commit f9c655d647427b45ae0d7bd9baf3551a013b8ea1 is at the wrong place.

`git log --graph` is fine.

Anything else you want to add:

[System Info]
git version:
git version 2.34.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.15.0-52-generic #58-Ubuntu SMP Thu Oct 13 08:03:55 UTC
2022 x86_64
compiler info: gnuc: 11.2
libc info: glibc: 2.35
$SHELL (typically, interactive shell): /bin/bash

[Enabled Hooks]

-- 
Adam

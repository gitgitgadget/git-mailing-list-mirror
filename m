Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16107C77B7C
	for <git@archiver.kernel.org>; Sat, 13 May 2023 08:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbjEMIi6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 May 2023 04:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjEMIi5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2023 04:38:57 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB874C07
        for <git@vger.kernel.org>; Sat, 13 May 2023 01:38:55 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-b9a6eec8611so50297147276.0
        for <git@vger.kernel.org>; Sat, 13 May 2023 01:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683967134; x=1686559134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Mi0zmA8fKy4KQ01vYjzn5CXzhZ/T2HSKW2lHJApHoY=;
        b=WdIzvG024en/4d8qaj/RBWp4Xup5PYDheHc9pa91VtpDDjkOTTqeHH5ZtouSlUQ/TL
         Oqz++jpYoHEcMQWuUWVB/wzbElGr1F40sUSdySeCY7+kKz3OUdGG6sEtjIGHOCAjP1kk
         edo6CnHtLWRM0LVzezLf96G8mBduMzF5oNiIyrfaUpYr7GAex3AMM0ntGUBU+WLLkVXb
         b40WWRvvWFtFhKC2e3uxCkaAJfnF39GH3nmjNK3dSKg6eU4cGugc5Pk5Bx52byLwwXb4
         jlrAhHuDx2EgQVj+k7BEn6VJvLj5/Yfdh3wbZUTU5DxuF/OyiQVUYvIHjXIJ0aq8S28q
         4q4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683967134; x=1686559134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Mi0zmA8fKy4KQ01vYjzn5CXzhZ/T2HSKW2lHJApHoY=;
        b=XEukiJE48QwKVysn2p5QkLWc1AHU8+CAwUJNGbHvK+sTUweWY5hseijcPXPwsP8fwF
         GHj40W4jGYJUXlZyzEdqThbVhv3e/bwS9/Zv//b/xiOqnsQQlS9l4Joa3h+tZlYouM+k
         vSXKLd5JuXwk8pMwYjaiXH3ywYu6R56z1nJPIbU9cX46YUYDlus/5rSUi13w2esCckQr
         UV0IQmRBcWH03NM65WghTCKyXzHJW/+dDuGERF4Wpjz8WanRjsv0ASE3lUWp3KD4Q7Nn
         hiBsWWhhwhtDm6NrmhzID8KPGPS/Fw0TmEXUGLtsCdS4qYbVpwceNeCahBgatrJzG3ai
         q85A==
X-Gm-Message-State: AC+VfDxy0YkeN4I0sgTPfmRbkzRTXpLGgi8Bu4XOxEDfoCETYdq4MMPk
        k1CfWxNZKu3Vm1q1fBhD0dxx/nv/JNGzIRbLA5SnbUG2Wad0Fidt
X-Google-Smtp-Source: ACHHUZ6oqzSDV9+hC4xIzTqi44XhhP1bBpSdJwImVK9QX9lWyN9+NllzVOJyR7PgkIjNoOCByZTdJb5qRn+cNGx8Jfw=
X-Received: by 2002:a05:6902:100a:b0:ba7:4c49:95e with SMTP id
 w10-20020a056902100a00b00ba74c49095emr1966531ybt.7.1683967134531; Sat, 13 May
 2023 01:38:54 -0700 (PDT)
MIME-Version: 1.0
References: <21183ea9-84e2-fd89-eb9b-419556680c07@gnieh.org>
In-Reply-To: <21183ea9-84e2-fd89-eb9b-419556680c07@gnieh.org>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sat, 13 May 2023 16:39:51 +0800
Message-ID: <CAOLTT8SvqmsjDRFQeMUjbri7mhp14KRxQqeKUq2jvS93u3Ryeg@mail.gmail.com>
Subject: Re: bug report git ls-files format
To:     Martin Monperrus <martin.monperrus@gnieh.org>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin Monperrus <martin.monperrus@gnieh.org> =E4=BA=8E2023=E5=B9=B45=E6=9C=
=8813=E6=97=A5=E5=91=A8=E5=85=AD 14:19=E5=86=99=E9=81=93=EF=BC=9A
>
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>
> What did you do before the bug happened? (Steps to reproduce your issue)
>
> Run `git ls-files . --format=3D"%(objectmode) %(objecttype) %(objectname)=
%x09%(path)"`
>
> What did you expect to happen? (Expected behavior)
>
> Have the full output per the format specifier
>
> What happened instead? (Actual behavior)
>
> fatal: bad ls-files format: %(objecttype)
>
> What's different between what you expected and what actually happened?
>
> %(objecttype) is not supported. It is supported in git ls-tree. For sake =
of consistency it would be
> good to have it here.
>

It's not a bug, but completion of the functionality would be better.
In addition to %(objecttype), there may also be %(objectsize), and I will s=
ubmit
a patch to complete it later.

> Anything else you want to add:
>
> Please review the rest of the bug report below.
> You can delete any lines you don't wish to share.
>
>
> [System Info]
> git version:
> git version 2.40.1
> cpu: x86_64
> no commit associated with this build
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> uname: Linux 5.15.0-69-generic #76-Ubuntu SMP Fri Mar 17 17:19:29 UTC 202=
3 x86_64
> compiler info: gnuc: 12.2
> libc info: glibc: 2.35
> $SHELL (typically, interactive shell): /bin/bash
>
>
> [Enabled Hooks]
> pre-commit
>

Thanks,
ZheNing Hu

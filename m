Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 368C9C6FD1C
	for <git@archiver.kernel.org>; Fri, 24 Mar 2023 14:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbjCXOAi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Mar 2023 10:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232066AbjCXOAN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2023 10:00:13 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B980E1C7C3
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 06:59:47 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-541a05e4124so34655297b3.1
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 06:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679666385;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tHBB+TZdlFun/rzmK25Ae4KcsdXy316FK1nq3r1BVP0=;
        b=knaRLuCfaW3h5jC9qLs6+iS5U+ZLUKvR3vH+pqFFBGEGhXFmFN3ggns4lfJZdHjJ++
         jbNEPfUNk+7ZWtI83mJcxhp4L8QvFZaXQmmom84qgGXbacwur/8/trZISqLLFjEEZgOK
         QNv6GjWlt3C9+meMbTxnt/0GA1mTfwXOX5OsrNlzDFXBeUcc781NRZNbBZwps416PUsd
         oKnpsP5dJ59SOxKCNq8CIuLwTqCCpVz+85HlVPzfVaU7qvULYYTuCAvGGYz4Hoyd6bVn
         o5LCVUDxnT9EVW8lQ5OWsfwuCGXqXdO8RS0UbUHsrNaFtLIz0865YyI4cTTg+yliru/T
         /vVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679666385;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tHBB+TZdlFun/rzmK25Ae4KcsdXy316FK1nq3r1BVP0=;
        b=phw1YSNUcAwoL17/14lPR/Y23fe6IQ96VA9P4XGac7y1Kcuw94714hMjswDifZTyAN
         guOBCwTu2FyBMdDPRZnz+Hv/sG27vHf9ywCBIa+oDrxZkNNgMlSCwKvmmUv1nbjS0QrB
         UedYJ6xJgdlJNrcPhzZB6xYi6hUc1uDZGt71avTcFsOmBRiIWZgI3ON2K6DlJekSxsXc
         CgKfZs50Ty5bUkmm6IAJxUolc7UvXzioP/lSz3izRcHjgYqyV/Yyu2ZWABGQ9CtECV7n
         vVPv5EYQGhuyxc5Cg/vdRtyasYecZK6U4lWoQAodXuThH8Pn7FVXdQLCF0nNxq7vwKbh
         p5Jg==
X-Gm-Message-State: AAQBX9fstXm9LG7eoCSmUZtUJQ3obLH5GkIFgrw5qU6olpr35PR1MRLg
        6L39yqL/nCErKrgzZLKWBk/0Hx+nw5bmz0aWxkJZ11SOEBKPAA==
X-Google-Smtp-Source: AKy350ZFWdx4Pfnwpu1XmWB0ez7nhAWV+RCzoJyMn5eeFKfJayqbN18LTMIVBFV077mBY5HWGpJkZtGuyqUkhLt4zs4=
X-Received: by 2002:a81:4428:0:b0:52f:184a:da09 with SMTP id
 r40-20020a814428000000b0052f184ada09mr1311452ywa.2.1679666385178; Fri, 24 Mar
 2023 06:59:45 -0700 (PDT)
MIME-Version: 1.0
From:   Utku <ugultopu@gmail.com>
Date:   Fri, 24 Mar 2023 16:59:19 +0300
Message-ID: <CAEeqB6=D_=qo1iHS2oJzFBJsgitBAeEJgWVFXX0jk1VpL0mb5A@mail.gmail.com>
Subject: Is it possible to set the similarity threshold in configuration file?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For example, for the [status
command](https://git-scm.com/docs/git-status), I would like to set a
value for the `find-renames` option in `~/.gitconfig`. To so so, I
tried the following with no avail:

[status]
        findRenames = 5%

[status]
        findrenames = 5%

[status]
        find--renames = 5%

Is it possible to set a value for the `find-renames` option of the
`status` command in `~/.gitconfig`?

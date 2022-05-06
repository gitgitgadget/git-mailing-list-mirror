Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E46C433EF
	for <git@archiver.kernel.org>; Fri,  6 May 2022 20:00:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392265AbiEFUEM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 May 2022 16:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238593AbiEFUEL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 May 2022 16:04:11 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5885113D0A
        for <git@vger.kernel.org>; Fri,  6 May 2022 13:00:26 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id i19so16352446eja.11
        for <git@vger.kernel.org>; Fri, 06 May 2022 13:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=whxnc/+68ri5OFcCc0SEc06xPmzTi2wpXNDEc2LCuSo=;
        b=Pal+PbJtYubEo56rRt1nf9m36w9JDsBmjCmWQkVJ6Q8f/0knxHtjjBcdZSuzw85FtC
         Ii6/QPdJM+MW4xD5wF3cg1MJ64IKN4FxDV7fXTMC0TPG5eKxO43oH8HMZXk1Z4O1Mtlc
         xpSi79nvSvXB5MVDGkI7YBjVmBmQwuGGnkmHy3iexSxsc82/BdPmJVgjpwdkVSwFah2C
         7F/3C5+oxn7+RhT55/LN5gds/KX4eNbB6nn6U1aNE/AmkKW/WGuuEZmCGsGxs11FCY0x
         BoH+KPuVOJsRTW4xxIa9fV0BeZDSEpldHB9irL9ajUA6aTHJfbgHcBP5vH39WG8gOO2e
         F3YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=whxnc/+68ri5OFcCc0SEc06xPmzTi2wpXNDEc2LCuSo=;
        b=xBHqJm+pUjN44GTkmSif4AY3Okq1/41ZcEhT2UBmQWAkh90mcoVr64Dir6fmp8xOSV
         bf42YBkyiJ3vNOK1UAbyyP/0MZdq0dQOii2ulNasmyL4lZp2/r0+F2VZYtXZsPAuB7cp
         SJqnhBphMVq7GhOQ6Ue0rSHFoOXwPf4c/M5A31LUlpT98RTFOdCRL7POXeKItq7JdRC3
         R2TWGv7bgeVIZ7UJDANnQ4jd4yayPwSjUHASWJ/zjd9E9XybJZYAHUrEVUtuUSWJeXdc
         i1O08WYrFgk+XppvHsIB6RasAh68qFGZREb2Sj4oykg6AlD9VZNo+H2q2sfmrP0GSet4
         2K2g==
X-Gm-Message-State: AOAM533IosWyjHcx4Gph04Jc/i5J+OCBxxF5b9GQi7/7/Q2aZ9xresRR
        1KhqEH19mDhkp/xrmFjcL08t34zk4m7mIRcq8F4=
X-Google-Smtp-Source: ABdhPJzJtCY41izPn5/FX5L2o+mCRvyDWafWi2SiMuxZJMaCfzJkxblU0hqVADvuDo9zKkdYNGptSRDGyYtsxdGLcDA=
X-Received: by 2002:a17:906:4fc8:b0:6d8:5059:f998 with SMTP id
 i8-20020a1709064fc800b006d85059f998mr4592676ejw.487.1651867224924; Fri, 06
 May 2022 13:00:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220505203234.21586-1-ggossdev@gmail.com> <xmqqilqimw6v.fsf@gitster.g>
In-Reply-To: <xmqqilqimw6v.fsf@gitster.g>
From:   oss dev <gg.oss.dev@gmail.com>
Date:   Fri, 6 May 2022 16:00:13 -0400
Message-ID: <CAAA5oLk-HhJQ2571cHd7qAZM+VFiDA=W12zyh47XzkFJik+XAw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] dir: consider worktree config in path recursion
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, christian w <usebees@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 6, 2022 at 1:02 PM Junio C Hamano <gitster@pobox.com> wrote:

> And this is supposed to add a new entry to the index at
> "git-test-123456/test-file"?

Correct, I expected an index entry at "git-test-123456/test-file".  If
I run the following:

```
test_repo="$(mktemp -d /tmp/git-test-XXXXXXX)"
cd "$test_repo"
>test-file
>/tmp/test-file
git init
git config core.worktree /tmp
git add test-file
git add /tmp/test-file
```

.. then with current git I get an index entry for "/tmp/test-file" but
not "/tmp/git-test-123456/test-file".  That is, I can add files
outside the standard worktree location but not inside it.

A playground example of the prior behavior (git 2.25.1) is here:
https://www.onlinegdb.com/OXt2cvL8S

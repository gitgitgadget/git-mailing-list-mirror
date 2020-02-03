Return-Path: <SRS0=caIn=3X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19016C35247
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 20:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC1AA20658
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 20:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgBCUPE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Feb 2020 15:15:04 -0500
Received: from mail-lj1-f171.google.com ([209.85.208.171]:35140 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbgBCUPD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Feb 2020 15:15:03 -0500
Received: by mail-lj1-f171.google.com with SMTP id q8so16061614ljb.2
        for <git@vger.kernel.org>; Mon, 03 Feb 2020 12:15:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=OiIVGJe00E76ajoLNEcHDxLnPYwOJscxnNOaSxsCq6I=;
        b=kR5wN94QlwJRtUoezDUWcH0ipaups5LkSBjAbXeqDXGjvrztSOppCKuN1uJ5UPFVme
         YE3k9vWu+G/nqotkQFBeBnj9Rt7yRYcNLj1a9wHP6VZeXy2+oFho1HgxWhKciwgKeD7k
         NB8Rjf5PaoY+cWxNddzFv6lCy9/gTHrrCq402gUddI0YLsRjF491VMxTyDaQIl/kB3oF
         y6nrkq8hLJpfglMWq/YasIP2MxZmTbHKzFxwD5c7UpognqjYCPnITDpAS9565XMnjuU6
         S/jFDFWXkFzsSkchDG6BEx62lxf4odBq6joVEEEtXiOk3u4but3rk/6xnqVD77WD44ja
         E0hg==
X-Gm-Message-State: APjAAAUhntSqY7cPb7TIXrE2XS/V7ucYyMSm5eJfyeG7QQZ12Ng+54e/
        XI8pbMaJo4z+uQlRMdNnZLUxPfaqVcinHlIqApOi8Lni
X-Google-Smtp-Source: APXvYqw/zGkqM0B4xENEjXN2sumQgXde+WtL+0LizWe12RCBJ2Xb0/+XA98QDP6bgSnA0C2oRIKL5widyt2xuSZEuqU=
X-Received: by 2002:a05:651c:1049:: with SMTP id x9mr15114082ljm.233.1580760901695;
 Mon, 03 Feb 2020 12:15:01 -0800 (PST)
MIME-Version: 1.0
From:   masukomi <masukomi@masukomi.org>
Date:   Mon, 3 Feb 2020 15:14:50 -0500
Message-ID: <CAG4-5WdTkFyCa_MqiRchR9GZgC_NEWdgobPfRfxYhTVqzVCCQw@mail.gmail.com>
Subject: [bug] git-rev-parse sometimes appends subdirectories to result
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Expected behavior

No matter what subdirectory of my repo I am in git rev-parse
--show-toplevel will always return the same result

Actual behavior

Depending on what subdirectories you are in it will sometimes (not
always) start appending those subdirectories to the path.

Reproduction

My git repo root is at

/Users/masukomi/workspace/private_comments

If i run git rev-parse --show-toplevel within that directory it
returns the correct (identical) path.
If i run it within /Users/masukomi/workspace/private_comments/src it
returns the correct path (without the /src)
If I run it within
/Users/masukomi/workspace/private_comments/src/tests it suddenly
starts returning

/Users/masukomi/workspace/private_comments/src/tests

Notes

Git 2.25.0
macOS 10.15.3
installed via homebrew.
no submodules present.



- Kay Rhodes
https://masukomi.org

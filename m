Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 661071F6A9
	for <e@80x24.org>; Thu,  3 Jan 2019 20:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbfACUrC (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Jan 2019 15:47:02 -0500
Received: from mail-wm1-f46.google.com ([209.85.128.46]:38075 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbfACUrC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jan 2019 15:47:02 -0500
Received: by mail-wm1-f46.google.com with SMTP id m22so31594115wml.3
        for <git@vger.kernel.org>; Thu, 03 Jan 2019 12:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:from:date:message-id:subject:to;
        bh=ckiRVNIDcX8/Kej4+WKnd54T7ItkZiIjD/Rx1qjkc5E=;
        b=h3LiKJ44MpKtSKJQIL3F2e04smNwkCR5CLbep9cdleGRFndYnXr5Lp3TMthr8P8ODc
         daxRLftRAIbXfb4u2XiQQ5iJYfl2MzmK9DhcrICuhWC4FYxQKWifoz6VKXUn0mY9UDeE
         e/YW1+UNY1Bne7Hw/lypBpPqEbW4mfqx5kc7Hb/+1+rIvpI0Q8nlUab9ZQgn8bbYYD3B
         nyr+28iXYepa41xfw72xph6m8k6Bd0HdQE6ncIIkrQkBLGL+QTjIWyzCuRFDt7rFhz/q
         ke4mGi7uzL+CFys2thP+BAHx6spX845v6uqo3DZICywmaWQvhQ4iblp/+36DRlWspLEG
         rl3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ckiRVNIDcX8/Kej4+WKnd54T7ItkZiIjD/Rx1qjkc5E=;
        b=FafbpNcEKFcqINCL3qv3av3AeJW7GNsivrSjwbVjVFfXkH2wIDcX8PGYo6ieaa12yE
         QX0JbgpOzANWNNdOVYVyWKHlTGuF+9UaB1Lq3Bjp9t+8gn63A4/DnMlYgrywlfAHvlFp
         tGaix4zfB3asXfIwJ1uTAlxjK2S7DAlLteiBrp6/f/+WMBEGnKlAjUplxP4PIAkzcYrC
         jRL1jPDjoSTzuVOrvyTGQoJZUHoCx65t1qM4T89o6V2gzfolB9u0XJu/ZTu3K0UYW0EK
         UB+xn5eMU5zVXr3RGICIrLMyzKJw+GWJj6G41i3AgapFNGnarr7IykZITYFgFTPl4Pab
         BgwQ==
X-Gm-Message-State: AA+aEWYCUMBoSUjMJs2roAFUeJ3VLblH8tlkXgVk6KFlH7X4iAXOYe26
        XSDKhZEk5s/ANYmHpUFyJR419n0Ti7GHdslXLDkcUAKOJRQ=
X-Google-Smtp-Source: AFSGD/VAHMLjr06VbOM4EZIEc1z0w9xoSni1QlffkAWUuyRkFDkkNk5RRqvw37JydJhWGk1Kz0pAGe161ahNwAENU2M=
X-Received: by 2002:a1c:c87:: with SMTP id 129mr37380848wmm.116.1546548419924;
 Thu, 03 Jan 2019 12:46:59 -0800 (PST)
MIME-Version: 1.0
From:   Anthony Sottile <asottile@umich.edu>
Date:   Thu, 3 Jan 2019 12:46:49 -0800
Message-ID: <CA+dzEBmh4LdN-XFS9y9YKrDMzV_7+QpDzBA2uv9Xi80PgR5NTQ@mail.gmail.com>
Subject: git add --intent-to-add + git stash "Cannot save the current worktree state"
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Minimal reproduction

```
git init t
git -C t commit --allow-empty -m 'initial commit'
touch t/a
git -C t add --intent-to-add a
git -C t stash
```

```
+ git init t
Initialized empty Git repository in /private/tmp/t/t/.git/
+ git -C t commit --allow-empty -m 'initial commit'
[master (root-commit) 858132e] initial commit
+ touch t/a
+ git -C t add --intent-to-add a
+ git -C t stash
error: Entry 'a' not uptodate. Cannot merge.
Cannot save the current worktree state
```

Anthony

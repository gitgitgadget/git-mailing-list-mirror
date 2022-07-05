Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4888CC433EF
	for <git@archiver.kernel.org>; Tue,  5 Jul 2022 20:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiGEUf5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jul 2022 16:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiGEUfz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jul 2022 16:35:55 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0C814087
        for <git@vger.kernel.org>; Tue,  5 Jul 2022 13:35:55 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id m24-20020a0568301e7800b00616b5c114d4so10437144otr.11
        for <git@vger.kernel.org>; Tue, 05 Jul 2022 13:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=+ZZFtQ9AGxyITDbjCVfiOSv5pnQba9cfIAMQqPjiL0Y=;
        b=qiW8+dVe+JE7uwtnM6UL8YPX8u5SGh8YSgLUoGSSPX+ijv22RSfvZ5y0jxGZt0+ks+
         TxpLANSWW1Xq1x/6/urTesWF13hODvS01tDPsKvx9flCrH6cCQwO+gDBd3oD5oDtqlB1
         sJDo8dYBLBi867/NtjGk5LxrFcOhNpT2o0akLAmTqkb9nPQiQRTHeldYIcLa56r0bpEe
         Evr07LisBOImVts1YgpvAhELE2wiU/rquF9a98M8Zvz/CFAArJQsPxLwWwvSE7oMO59w
         4xDTPuUNdhp29W7FsAh6rwtuzqINuRThMSn6flbcCBINE6RhT+rpnYCH/00LVL3KgPb8
         UJ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=+ZZFtQ9AGxyITDbjCVfiOSv5pnQba9cfIAMQqPjiL0Y=;
        b=CidhFLQca2N7pZJKyHSGoAONKBuWEPIW5TLSHhHRI3zSMsc4IafmKeWQNPpnmjQud2
         IjuxsohBVYq/bwPq1/Qu2lti4s3uNXnmQn/GeB6Q4y+ThstBrp5EhXzfnmL05s90RcdI
         4C1y6wI7jxj/vZTyj1fFeR2qstnrGcfdsmYCVBbuPbR8nN942yfddvO9ZNMyYmP3CJGj
         hGA18oQsyguSHOSbHBt2Z4BBzOfjN2WFKMxAEIFZVFUA4sMFQHHn67nVFxkzsOiCxT9s
         WgTQ/Eoqru7KpM9kYzP0J4JZk2QIVBCPkGMaHLjJ6iK6W7AX235tjuc5vwwzs6PN/0oN
         L7/A==
X-Gm-Message-State: AJIora+lCvp9+p3p9VTuHxWlXfKHnrV87FuqHr6sndFrDtViVyueaiTx
        h+pYiWxQvFpYjmZjA9NQdNg+ZbB1ZYVYZ+p517I7BIx3XtBG/w==
X-Google-Smtp-Source: AGRyM1uRQ5oX8cKfMy0K3TuFSNCkUqZJPljUy5W9jBkTQLO8SKTxjRxrmgE6nCKjsLtCnSWZUuC9QZ5GBd2lQLWvbbw=
X-Received: by 2002:a05:6830:408c:b0:616:9fdd:5314 with SMTP id
 x12-20020a056830408c00b006169fdd5314mr15869351ott.145.1657053354420; Tue, 05
 Jul 2022 13:35:54 -0700 (PDT)
MIME-Version: 1.0
From:   Sim Tov <smntov@gmail.com>
Date:   Tue, 5 Jul 2022 23:35:42 +0300
Message-ID: <CA+X_a+z-=K5BfDpMiWAnnVma6ihh6kUXb84CCrHL5gte5WykMw@mail.gmail.com>
Subject: "mixed" or "merged" submodules
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

here  https://stackoverflow.com/q/72770397/1876484

I asked this question:

I'm aware of git submodules which dwell each in its own separate directory.

1. But is there such thing as "mixed" submodules whose content is
"merged" together?

For instance:

- Submodule1 (path ./), consist of files `a.txt`, `b.txt` and
directory `C` with the file `1.txt`
- Submodule2 (path ./), consist of files `x.txt`, `y.txt` and
directory `C` with the file `2.txt`
- Resulting "mixed" repo of both submodules: files `a.txt`, `b.txt`,
`x.txt`, `y.txt` and directory `C` with the files `1.txt`, `2.txt`

2. If it is not implemented in git - is there a workaround to achieve this?

Here my use case:

Both submodules - independent libraries (collection of books as plain
text files), which have same structure (directories = book
categories). I want to present the combined parent git repository as
full collection of books, while both projects evolve independently and
do not overlap (in terms of file names = books).

I got a very detailed and informative answer. My question now - do you
see any other practical use cases for such a feature? Would such a
more general case of submodules be a good feature in git or not?

Thank you!

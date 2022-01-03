Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1123C433F5
	for <git@archiver.kernel.org>; Mon,  3 Jan 2022 10:14:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbiACKOk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jan 2022 05:14:40 -0500
Received: from mail-io1-f45.google.com ([209.85.166.45]:40831 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232617AbiACKOj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jan 2022 05:14:39 -0500
Received: by mail-io1-f45.google.com with SMTP id q5so39748944ioj.7
        for <git@vger.kernel.org>; Mon, 03 Jan 2022 02:14:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XSqvOhmU2j/13C8EQDaSEjIEvOCFEHMa/c4wo4guUGE=;
        b=EsWTfKwv8R+OUPrYi+3u7V2benlC1TlSoGgFeC1sJcw5qxsF98OVk73TOb9Xq16SBg
         PRzsFdbaAQ9+eOZprJUVBdOFw4IaIlYC9Awlx2eohvtcPdZHCZSYQYp0DWq9+kNDwGYA
         JyW7+WaFuWmEwRKQiu712lF6wK1RvY/cBCcmFaWsWFAfTgE08XNHaq9FtzfftFWnfqWm
         Kczt7hd+WJDwTY+yhwXdK3YrKEuMV/s0XfimPtQ/iKEmH1ZlDvFsajV3eI2c9MwLlU/A
         AV4UZEx5YvUmeIzIA8gPcSVzh6G6O1kRTYpCN7uA1puBCd54mz9SFScwb+8CKg2sEYus
         A7QQ==
X-Gm-Message-State: AOAM530IVnSQ8nIuxLSRumrW1VPO8JSo4tcARCkPcLKC+i5u3ER29plx
        mbrLYD7OV1wQJKTL6t5Uvqsex5kdsgk1UvLowDJ8TlgIUUk=
X-Google-Smtp-Source: ABdhPJw//SfGQ/YqU/UOFqOIlex9vM+tB02Sm9rqezNFc6r/mixkYsdL8AjHbbb0J5c7Ck30wrBr8FIjOkhCFawTRAg=
X-Received: by 2002:a05:6602:2dd0:: with SMTP id l16mr20868216iow.198.1641204879156;
 Mon, 03 Jan 2022 02:14:39 -0800 (PST)
MIME-Version: 1.0
References: <52591f5d-d4b5-90ea-e84e-32b99803a3e6@gmail.com>
 <00dd01d7fd78$7e69e150$7b3da3f0$@nexbridge.com> <CA+JQ7M_tQG4yzSeHjZxPWuWEOM=iSLrWxojQGcpL9E7FcoXLRg@mail.gmail.com>
 <83d398ce-caba-34f7-3727-3e7f5d396127@gmail.com>
In-Reply-To: <83d398ce-caba-34f7-3727-3e7f5d396127@gmail.com>
From:   Erik Cervin Edin <erik@cervined.in>
Date:   Mon, 3 Jan 2022 11:14:02 +0100
Message-ID: <CA+JQ7M-3sswuYzuXy+bs=e26o3btDoK9z3A0j4WVvELoHG5A-Q@mail.gmail.com>
Subject: Re: Git Diff feature request
To:     nickgearls@gmail.com
Cc:     rsbecker@nexbridge.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 3, 2022 at 8:43 AM Nick Gearls <nickgearls@gmail.com> wrote:
>
> When you want to compare 2 versions of a repo you don't own, you don't have the option to apply a formatting standard ...

You may try
https://git-scm.com/docs/diff-options#Documentation/diff-options.txt---word-diff-regexltregexgt

  printf 'if (xyz) biz()\n' > bar
  git commit -m 1 bar
  printf 'if (xyz)\n  biz()\n' > bar
  git commit -m 2 bar
  git diff --word-diff-regex='[^[:space:]]' HEAD~

yields a diff with differences hidden

diff --git a/bar b/bar
index 49d380e..05c8e60 100644
--- a/bar
+++ b/bar
@@ -1 +1,2 @@
if (xyz)
  biz()

But from gits perspective, the files are different and the lines are different.
This is the reason having an adhering to a formatting standard is advised,
and something IMHO every serious project should adhere to.

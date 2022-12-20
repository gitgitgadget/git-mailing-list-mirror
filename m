Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C8A3C4332F
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 19:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233542AbiLTT5G (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Dec 2022 14:57:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234201AbiLTT4i (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2022 14:56:38 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D5C1E719
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 11:56:09 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id i12so8941096qvs.2
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 11:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=webstech-net.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F4WNx3ohEaXtx3T9r1zPYq5ocx4ePIg050WHMBdxnzQ=;
        b=rvegKbDfaNKfl+xg4NVdO+4cCemwGGBWXP+H1w6mJm3JVgDNpx2tQacZn8HblDXelZ
         Tqv9q2qqWfTI+OhZ2vE4befQXV51I5HTRKuAAePRM66o+km1JnEIUQ+Br5urzcq///QE
         N0XpajSjWyK2S6QLHS6WrE67H6HD02ypC0M3hE3YTKlvGTNK2JUlKvQdenqo7vDfZBcO
         VtuUSK+eZoUMb1H/Y5+AW1sRZSkQIf56//CThyuW4TaLaUUbFu4QOVKVa+6MmtAaEZwm
         SZjAnWdYPeyffPkB6kXcmVNdcNRuzRlg0cmITmlomvY/aIKy1ltcSaqkYpeTcoSoeRnr
         pkGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F4WNx3ohEaXtx3T9r1zPYq5ocx4ePIg050WHMBdxnzQ=;
        b=BJ4fCeakyCPcRjxp39Xrq3LxJAZISKU3GPeMclaAGcSISxCIq2PQpKBHsjMbhZ1G0y
         pRxHf6Xr6mt9WZVMua0qaLUkjFPkFahyiI1v2sJkWfVdEkL6OUrPXWvGdWxplccTgVRG
         Y4TmnaqMqv/+LvFF53Z3y4X/ULbq8V5o9Si6PFxX3LHzcMdqGKUXQfIEOOb2eFO1Y4h2
         wUmcwsn6KmzQBPPZX2+M2dCkdSWZuHGuGWq4HRmm5qkkRV7ejnJqZ1D2j2SngDFHdjCj
         ChflV8diV3ANmBH7EDmzafpq3ce8/Ve5dGKVacir+v+IUcqakQjEfmqKf6Q6PAHpB6oq
         HAKQ==
X-Gm-Message-State: ANoB5pkiWuqg4ks/px/jK//XvJn1eIVoeNBGHIRVtSp8El5DGZTjfm4W
        sdVlc2gFvCEQ4HhfBGn5fLNSH10QbkSBnkSHZ8Dwr4x0S4dUvK2Y
X-Google-Smtp-Source: AA0mqf47zhbfZKYjGS5q/ziH5sGLuLHLVLrFbcjyIgNS8IvR1p35bHpYDJQu4t5MQYo+6KHxWJUhgb63jrIy97GEwyk=
X-Received: by 2002:ad4:50ac:0:b0:4bb:ce03:5714 with SMTP id
 d12-20020ad450ac000000b004bbce035714mr78382264qvq.30.1671566168696; Tue, 20
 Dec 2022 11:56:08 -0800 (PST)
MIME-Version: 1.0
References: <pull.1444.git.1671179520.gitgitgadget@gmail.com>
 <pull.1444.v2.git.1671496548.gitgitgadget@gmail.com> <a2b5f3e87d6ef62d8005cff5568ad3afc4af3771.1671496548.git.gitgitgadget@gmail.com>
 <Y6Fle8gzVU5si3T/@danh.dev>
In-Reply-To: <Y6Fle8gzVU5si3T/@danh.dev>
From:   Chris Webster <chris@webstech.net>
Date:   Tue, 20 Dec 2022 11:55:57 -0800
Message-ID: <CAGT1KpV0igMKk4FvapuZCdJ7kFS+_cNe2ouczQsomheOGhgLZg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] ci (check-whitespace): suggest fixes for errors
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I think this change is getting too long to be embeded in a yaml file.
> I think it's better to move the shell code into its own script, so we
> can have better code highlight in editor and a proper shebang (/bin/bash).

That would need to be a separate patch?

> > +          echo "Run \`git rebase --whitespace=fix ${lastcommit}\` and \`git push --force\` to correct the problem." >>$GITHUB_STEP_SUMMARY
>
> When move this block into its own script, we can use single quote
> string here, too.

I am not sure what you mean.

Thanks for the review,
...chris.

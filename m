Return-Path: <SRS0=5D3W=ZY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A60C432C3
	for <git@archiver.kernel.org>; Mon,  2 Dec 2019 08:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCB16215F1
	for <git@archiver.kernel.org>; Mon,  2 Dec 2019 08:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z88B1rlt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfLBInP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Dec 2019 03:43:15 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45]:46718 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfLBInP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Dec 2019 03:43:15 -0500
Received: by mail-wr1-f45.google.com with SMTP id z7so39602975wrl.13
        for <git@vger.kernel.org>; Mon, 02 Dec 2019 00:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=TpjvMBEdLM7mA+hKwLdB5rU9btB+QxDLpsCwb+VzEBo=;
        b=Z88B1rltD7G+uhJ/t8Ed2uHW5Eggxwt60NcSzq9npVgl4bLPU2HZjBMJX3yz/VlrA5
         WGsczXqcZw1zrfR0GSDWINSgHVCrqBlCzL6Tf2iJWKWiclfXULSQABjgJWKMDSyqERz1
         +r0dvTXhom2jXHUicXHtRcZheuZzd1BIGnMhuE9NKJF6Cmh0v0XHC9OEom54ecgSjlBh
         OT9vnwr12dseOnd/PufFdh7sE3x5/iZp7v+n5r8NwZbl1olaQ9+cInMQ96XvA238bxIr
         VMpqEnd/5Cw+AzYNc3u2tPGt5WWKKMzHqgBIaT0vfqW/QNQVtnz0JSUfGy3DCePS+TqL
         hNwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TpjvMBEdLM7mA+hKwLdB5rU9btB+QxDLpsCwb+VzEBo=;
        b=cS0Ix88UCOcz5EDoZn9UDZKwwyo0ib8YuojtdHxzukSPb3dsD29QBgHCgvcOSHR4Xq
         Dgeis+LSEfQmHTCdqD5NwiXfAPJlmTnUKcZ+Imn5shW7hzw4n2/BhMctGSkaXrgsheuC
         QsQ0Yf84HvDgWuKIxCSibANEr8sSSkaU8lmmmCVa+UOiG/GF/QnGlrki8i6fBvhlGCU0
         v2xYiomE5TGpTzTdSXscXCluvjaYjlJn6atr15mKXGol6JPA0xyEx6F6kc4cvcjJXlQH
         fdwPf74yX378p+EfGQL0gfGNyMq4ARSjdl8wuXysaTw+7CW95wKFphC9gyS991D0QDnQ
         vrUA==
X-Gm-Message-State: APjAAAWfGubj2ERa+PAu9e1jzPcm9wiNYyMrW1WAAGFhFPQ7/AACiNPj
        2zqBThTUYqFJV6vU402f2jXfYIbq
X-Google-Smtp-Source: APXvYqza4P7sTrU2bJsABnpyZELUl8f76taIOfVJIw5t9buHEfD+hi+DeuDdWbjwW0BAvUcm/38m6g==
X-Received: by 2002:adf:f581:: with SMTP id f1mr5604804wro.264.1575276192824;
        Mon, 02 Dec 2019 00:43:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d8sm17386306wre.13.2019.12.02.00.43.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Dec 2019 00:43:12 -0800 (PST)
Message-Id: <pull.481.git.1575276191.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 02 Dec 2019 08:43:10 +0000
Subject: [PATCH 0/1] pkt-line: fix a typo
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I stumbled over this during some investigation recently, together with the
"initilize" and the "occured" typos. Fixes for the latter have been
contributed, so I won't do that again, but this one was still unaddressed.

Johannes Schindelin (1):
  pkt-line: fix a typo

 pkt-line.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


base-commit: d9f6f3b6195a0ca35642561e530798ad1469bd41
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-481%2Fdscho%2Fassigined-tyop-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-481/dscho/assigined-tyop-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/481
-- 
gitgitgadget

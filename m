Return-Path: <SRS0=d/2q=6J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 053F6C2BA1A
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 00:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C690B20857
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 00:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZJaF9c02"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbgDYA4J (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 20:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbgDYA4J (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 20:56:09 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13486C09B049
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 17:56:08 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id o6so9553220pjl.1
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 17:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=3flK3B+U7aabN+tU51uYf+CWHDbXpThsM+xMSKa8mHA=;
        b=ZJaF9c02Me3GzO7GpmWFFVLS05/Qpiuz3FUalrZQ19pdq44ccrELaMIVhdboyXGh2U
         K9kSf+9DLpSXb1XFoknqmqrxD632kQxzC9w3S3+mW9o6XJnsU5TdUMzGIXx/dnjZ/u/C
         sWks+1IqZ4q8E+N5mLfvEowoYm6rQiGdTKaEA+Rpt+fbd+eWxY30cSZGQfkIB+hIttSH
         OhKZBaqsxne4AgjA4NQ85GkHwscnoYyUiwT0yjI7JHcc5PpNqoEeY5BY//LeeZTTAGkQ
         rJkguONNYpBG4wHoqJtFXyXM7sc4A1MOSRfdpHMVtYtc1uv+vpG/W9VVXVMEGXIXJ8Zj
         lYXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=3flK3B+U7aabN+tU51uYf+CWHDbXpThsM+xMSKa8mHA=;
        b=IUhB8BU3/esHQEm9epTzSyr8ZOROgQcsYgO/GYG/R1UCeYuhXDNcINvmY6/q6y1E1c
         fG/C9PzkEjVnoiVg8wJi3Trziu7i4Z2g53j0xvfgNJiGNfn4b6JA6DyhhQNjFxZTB6Hy
         xkviDvLSRtpWAjWyvlchCEtaqu5zBbF56Ssjgrc+RauOwBMqOrVNxFmQTO97UyaBTrg8
         GFFRiFsHVN3CB6XDoHR3igonLe4bihR/e3LdXZ+RU7vgMEmN6UALYopLuoBSw7bNgmtb
         tJGZBrzc32kiK//cA62mKWC0fsUhHMNvWUUYRu9KKAOmC1iMfXsjHBti41MSju7UwlEZ
         PAcg==
X-Gm-Message-State: AGi0PuZhfaDK95TCamfgob0P5FP/jlugXz7puWo7u4t9ruDLmvWG14Lh
        7N+hP47sKnPzNak1ZjDqFXa8CbYyShywwNenM3Y2w7dtb0hw4pRzmBJZ3EwlpNYjv3f4HhYDUqZ
        kI7bcrSH/solP4w+Fyeb6KRtRXuhYrDxNx7I/t+P3nngRM9iw75cdVa1wVIgTUpn70WVw6CkEx3
        +z
X-Google-Smtp-Source: APiQypKES6LfIWoISbtou0pE5ylEYFyGR0QuJrhPcpE5ep1sxGqZUkQkfUvEz6xNCAlly0FrTEYO4wiyV621A44Fkq+z
X-Received: by 2002:a17:90a:9b82:: with SMTP id g2mr9742401pjp.72.1587776166755;
 Fri, 24 Apr 2020 17:56:06 -0700 (PDT)
Date:   Fri, 24 Apr 2020 17:56:00 -0700
Message-Id: <cover.1587775989.git.jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH 0/2] Protocol v2 in_vain fixes
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        jrnieder@gmail.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patch 1 is a fix for what I described in [1].

The fix in patch 1 exposes a bug, which patch 2 fixes. Jonathan Nieder
found the bug [2], and I have written a test covering this case. I've
credited him as "Helped-by".

[1] https://lore.kernel.org/git/20200423213735.242662-1-jonathantanmy@google.com/
[2] https://lore.kernel.org/git/20200422165358.GB140314@google.com/

Jonathan Tan (2):
  fetch-pack: in protocol v2, in_vain only after ACK
  fetch-pack: in protocol v2, reset in_vain upon ACK

 fetch-pack.c          | 14 +++++++++----
 t/t5500-fetch-pack.sh | 49 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+), 4 deletions(-)

-- 
2.26.2.303.gf8c07b1a785-goog


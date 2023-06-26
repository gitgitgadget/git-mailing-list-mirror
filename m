Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4753FEB64DA
	for <git@archiver.kernel.org>; Mon, 26 Jun 2023 16:25:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbjFZQZq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jun 2023 12:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbjFZQZH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2023 12:25:07 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D6C12A
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 09:25:03 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-313e34ab99fso2726020f8f.1
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 09:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687796701; x=1690388701;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L+/f/RVZomTkapsMngxop6R26fwIFTVcMJ/LWQ406iE=;
        b=fQWI5asKNKzByyNfyVDpOYT8exWnnqvtNF1crju1EBJd0dY4NdUirp8R3ZAcexbRsM
         K20MMcrz9POcGZFw1PgMh//hmOgrt5dBEpauy2EXy+SCt2FCH7FgzG/TBKYFyzf0Ckdl
         XOTHBV6FUYoL5eFjkBS8eUZBWjm+HkINB/z6Yo58811Z6BOve2dvvMBwryPQx9vk9pMn
         ntnFVfHkj4SEKmLSXHXqGn2dg7giqTLLiC+I7ASqEpnV0J7zkQp2ijyenxB3BAEDLEGf
         b/0o9wK5t8jJMMInl1Y4ZrXKUFxt4I4b4kLkQlf2KvP04GqSxRFZ1kB8NHU9GLVIi+Nm
         WPHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687796701; x=1690388701;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L+/f/RVZomTkapsMngxop6R26fwIFTVcMJ/LWQ406iE=;
        b=P1qFsZD9FNVz1NXsf54VrMIREiVJf31nC44aaiIeZcKAUAKKCZoLZS9YuZvTghuXzg
         Gi6kYeIQ+fK0NYzxOop32oTLkGTzb2gJvcSKjU1mxPFaSWZw8WMb4U7q/ThtUdL8qn0V
         NecYN4imcLmLAq/4coglSz7GNI6Qjw/ZR25vlamdawf/64j6E9EitZBpppOys4NY1V2+
         IOcXe8LV9IsyzU+9PlmEdl1ep23tXmmB4ehm4A3MkyjBY+BC9puh9JYJkDPE45AnM6UG
         BTlDYHLnpRRFe/V73aAplD+q30kQe2+w6g9AX6QyStgs7fwijdsFS2A7NVudwl8C7Mb8
         W1lQ==
X-Gm-Message-State: AC+VfDw2gUnvtnzps+XNf+Nvc0U7IG8q2H9MTuDDGn0S2H9p7i+L+U1x
        dYpQ8awPqBm9ibgmcLNCu2jElcRt6ho=
X-Google-Smtp-Source: ACHHUZ76VkIjbrPA9zRg0AXWFDo6pNRgHwVHSQVh5SlBxYa827Kq/MX+cRkLt6nv0ZtSHYwgtRRfag==
X-Received: by 2002:a5d:6884:0:b0:30f:b1e8:8896 with SMTP id h4-20020a5d6884000000b0030fb1e88896mr22244199wru.67.1687796701525;
        Mon, 26 Jun 2023 09:25:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i6-20020adff306000000b00311339f5b06sm7775093wro.57.2023.06.26.09.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 09:25:01 -0700 (PDT)
Message-Id: <560ad1cd0179f8615dadd8b252b5c3f8cef6822e.1687796689.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1543.v3.git.1687796688.gitgitgadget@gmail.com>
References: <pull.1543.v2.git.1686574374.gitgitgadget@gmail.com>
        <pull.1543.v3.git.1687796688.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 26 Jun 2023 16:24:38 +0000
Subject: [PATCH v3 14/24] completion: complete --line-prefix
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 7246ced14ad..13d6730f33d 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1757,7 +1757,7 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
 			--textconv --no-textconv --break-rewrites
 			--patch --no-patch --cc --combined-all-paths
 			--anchored= --compact-summary --ignore-matching-lines=
-			--irreversible-delete
+			--irreversible-delete --line-prefix
 "
 
 # Options for diff/difftool
-- 
gitgitgadget

